Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751593AbeEBDIj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 23:08:39 -0400
Received: from mga03.intel.com ([134.134.136.65]:60907 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750823AbeEBDIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 23:08:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,353,1520924400";
   d="scan'208";a="42289947"
Subject: Re: [PATCH 5/9] iommu/vt-d: Per domain pasid table interfaces
To: "Liu, Yi L" <yi.l.liu@intel.com>,
        David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>
References: <1523934202-21669-1-git-send-email-baolu.lu@linux.intel.com>
 <1523934202-21669-6-git-send-email-baolu.lu@linux.intel.com>
 <A2975661238FB949B60364EF0F2C257439BE7516@SHSMSX104.ccr.corp.intel.com>
Cc: "Raj, Ashok" <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <5AE92BAB.3010705@linux.intel.com>
Date: Wed, 2 May 2018 11:08:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <A2975661238FB949B60364EF0F2C257439BE7516@SHSMSX104.ccr.corp.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yi,

Thank you very much for reviewing my patches.

On 05/01/2018 05:22 PM, Liu, Yi L wrote:
>> From: Lu Baolu [mailto:baolu.lu@linux.intel.com]
>> Sent: Tuesday, April 17, 2018 11:03 AM
>>
>> This patch adds the interfaces for per domain pasid table
>> management. Currently we allocate one pasid table for all
>> devices under the scope of an IOMMU. It's insecure in the
>> cases where multiple devices under one single IOMMU unit
>> support PASID feature. With per domain pasid table, we can
>> achieve finer protection and isolation granularity.
>>
>> Cc: Ashok Raj <ashok.raj@intel.com>
>> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Cc: Kevin Tian <kevin.tian@intel.com>
>> Cc: Liu Yi L <yi.l.liu@intel.com>
>> Suggested-by: Ashok Raj <ashok.raj@intel.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>  drivers/iommu/intel-pasid.c | 75
>> +++++++++++++++++++++++++++++++++++++++++++++
>>  drivers/iommu/intel-pasid.h |  4 +++
>>  include/linux/intel-iommu.h |  5 +++
>>  3 files changed, 84 insertions(+)
>>
>> diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
>> index 0690f39..b8691a6 100644
>> --- a/drivers/iommu/intel-pasid.c
>> +++ b/drivers/iommu/intel-pasid.c
>> @@ -13,6 +13,7 @@
>>  #include <linux/intel-iommu.h>
>>  #include <linux/iommu.h>
>>  #include <linux/memory.h>
>> +#include <linux/pci.h>
>>  #include <linux/spinlock.h>
>>
>>  #include "intel-pasid.h"
>> @@ -58,3 +59,77 @@ void *intel_pasid_lookup_id(int pasid)
>>
>>  	return p;
>>  }
>> +
>> +/*
>> + * Interfaces for per domain pasid table management:
>> + */
>> +int intel_pasid_alloc_table(struct device *dev, size_t entry_size,
>> +			    size_t entry_count)
>> +{
>> +	struct device_domain_info *info;
>> +	struct dmar_domain *domain;
>> +	struct page *pages;
>> +	int order;
>> +
>> +	info = dev->archdata.iommu;
>> +	if (WARN_ON(!info || !dev_is_pci(dev) ||
>> +		    !info->pasid_supported ||
>> +		    !info->domain))
>> +		return -EINVAL;
>> +
>> +	domain = info->domain;
>> +
>> +	if (entry_count > intel_pasid_max_id)
>> +		entry_count = intel_pasid_max_id;
>> +
>> +	order = get_order(entry_size * entry_count);
>> +	pages = alloc_pages_node(domain->nid, GFP_KERNEL | __GFP_ZERO, order);
>> +	if (!pages)
>> +		return -ENOMEM;
>> +
>> +	spin_lock(&pasid_lock);
>> +	if (domain->pasid_table) {
> Can the check be moved prior to the page allocation?

I chose allocation and then assignment with lock to avoid
race and possible page allocation failure.

>
>> +		__free_pages(pages, order);
>> +	} else {
>> +		domain->pasid_table	= page_address(pages);
>> +		domain->order		= order;
>> +		domain->max_pasid	= entry_count;
>> +	}
>> +	domain->pasid_users++;
>> +	spin_unlock(&pasid_lock);
>> +
>> +	return 0;
>> +}
>> +
>> +void intel_pasid_free_table(struct device *dev)
>> +{
>> +	struct dmar_domain *domain;
>> +
>> +	domain = get_valid_domain_for_dev(dev);
>> +	if (!domain || !dev_is_pci(dev))
>> +		return;
>> +
>> +	spin_lock(&pasid_lock);
>> +	if (domain->pasid_table) {
>> +		domain->pasid_users--;
>> +		if (!domain->pasid_users) {
>> +			free_pages((unsigned long)domain->pasid_table,
>> +				   domain->order);
>> +			domain->pasid_table	= NULL;
>> +			domain->order		= 0;
>> +			domain->max_pasid	= 0;
>> +		}
>> +	}
>> +	spin_unlock(&pasid_lock);
>> +}
>> +
>> +void *intel_pasid_get_table(struct device *dev)
> Will intel_iommu_get_pasid_table() more accurate?

This function defines in intel-pasid.c. The name pattern for global
functions defined in this function is intel_pasid_xxx_xxxx().

>
> Regards,
> Yi Liu
>

Best regards,
Lu Baolu
