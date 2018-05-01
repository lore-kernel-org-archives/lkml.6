Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754749AbeEAJWQ convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 05:22:16 -0400
Received: from mga14.intel.com ([192.55.52.115]:52297 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754603AbeEAJWO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 05:22:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,350,1520924400";
   d="scan'208";a="50511951"
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>
CC: "Raj, Ashok" <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: RE: [PATCH 5/9] iommu/vt-d: Per domain pasid table interfaces
Thread-Topic: [PATCH 5/9] iommu/vt-d: Per domain pasid table interfaces
Thread-Index: AQHT1fns4zThlFAGBkyYHNqXlvzvjqQapC5w
Date: Tue, 1 May 2018 09:22:11 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439BE7516@SHSMSX104.ccr.corp.intel.com>
References: <1523934202-21669-1-git-send-email-baolu.lu@linux.intel.com>
 <1523934202-21669-6-git-send-email-baolu.lu@linux.intel.com>
In-Reply-To: <1523934202-21669-6-git-send-email-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOTk2ZTFiYTEtMmVkZC00ZWMzLTg5NDYtMTc4ODNmNGRiMGRmIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiI2SUd6UXd0cDZEMHdHRXNwejhzUXBNckt0S1BxUVBjYW1VTklpbTV1NDV3bWZjZHQycU9ZMVVNSVFYUjZDS1wvQiJ9
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu [mailto:baolu.lu@linux.intel.com]
> Sent: Tuesday, April 17, 2018 11:03 AM
> 
> This patch adds the interfaces for per domain pasid table
> management. Currently we allocate one pasid table for all
> devices under the scope of an IOMMU. It's insecure in the
> cases where multiple devices under one single IOMMU unit
> support PASID feature. With per domain pasid table, we can
> achieve finer protection and isolation granularity.
> 
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Liu Yi L <yi.l.liu@intel.com>
> Suggested-by: Ashok Raj <ashok.raj@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel-pasid.c | 75
> +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/iommu/intel-pasid.h |  4 +++
>  include/linux/intel-iommu.h |  5 +++
>  3 files changed, 84 insertions(+)
> 
> diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
> index 0690f39..b8691a6 100644
> --- a/drivers/iommu/intel-pasid.c
> +++ b/drivers/iommu/intel-pasid.c
> @@ -13,6 +13,7 @@
>  #include <linux/intel-iommu.h>
>  #include <linux/iommu.h>
>  #include <linux/memory.h>
> +#include <linux/pci.h>
>  #include <linux/spinlock.h>
> 
>  #include "intel-pasid.h"
> @@ -58,3 +59,77 @@ void *intel_pasid_lookup_id(int pasid)
> 
>  	return p;
>  }
> +
> +/*
> + * Interfaces for per domain pasid table management:
> + */
> +int intel_pasid_alloc_table(struct device *dev, size_t entry_size,
> +			    size_t entry_count)
> +{
> +	struct device_domain_info *info;
> +	struct dmar_domain *domain;
> +	struct page *pages;
> +	int order;
> +
> +	info = dev->archdata.iommu;
> +	if (WARN_ON(!info || !dev_is_pci(dev) ||
> +		    !info->pasid_supported ||
> +		    !info->domain))
> +		return -EINVAL;
> +
> +	domain = info->domain;
> +
> +	if (entry_count > intel_pasid_max_id)
> +		entry_count = intel_pasid_max_id;
> +
> +	order = get_order(entry_size * entry_count);
> +	pages = alloc_pages_node(domain->nid, GFP_KERNEL | __GFP_ZERO, order);
> +	if (!pages)
> +		return -ENOMEM;
> +
> +	spin_lock(&pasid_lock);
> +	if (domain->pasid_table) {

Can the check be moved prior to the page allocation?

> +		__free_pages(pages, order);
> +	} else {
> +		domain->pasid_table	= page_address(pages);
> +		domain->order		= order;
> +		domain->max_pasid	= entry_count;
> +	}
> +	domain->pasid_users++;
> +	spin_unlock(&pasid_lock);
> +
> +	return 0;
> +}
> +
> +void intel_pasid_free_table(struct device *dev)
> +{
> +	struct dmar_domain *domain;
> +
> +	domain = get_valid_domain_for_dev(dev);
> +	if (!domain || !dev_is_pci(dev))
> +		return;
> +
> +	spin_lock(&pasid_lock);
> +	if (domain->pasid_table) {
> +		domain->pasid_users--;
> +		if (!domain->pasid_users) {
> +			free_pages((unsigned long)domain->pasid_table,
> +				   domain->order);
> +			domain->pasid_table	= NULL;
> +			domain->order		= 0;
> +			domain->max_pasid	= 0;
> +		}
> +	}
> +	spin_unlock(&pasid_lock);
> +}
> +
> +void *intel_pasid_get_table(struct device *dev)

Will intel_iommu_get_pasid_table() more accurate?

Regards,
Yi Liu

> +{
> +	struct dmar_domain *domain;
> +
> +	domain = get_valid_domain_for_dev(dev);
> +	if (!domain)
> +		return NULL;
> +
> +	return domain->pasid_table;
> +}
> diff --git a/drivers/iommu/intel-pasid.h b/drivers/iommu/intel-pasid.h
> index 0c36af0..a90c60b 100644
> --- a/drivers/iommu/intel-pasid.h
> +++ b/drivers/iommu/intel-pasid.h
> @@ -26,5 +26,9 @@ extern u32 intel_pasid_max_id;
>  int intel_pasid_alloc_id(void *ptr, int start, int end, gfp_t gfp);
>  void intel_pasid_free_id(int pasid);
>  void *intel_pasid_lookup_id(int pasid);
> +int intel_pasid_alloc_table(struct device *dev, size_t entry_size,
> +			    size_t entry_count);
> +void intel_pasid_free_table(struct device *dev);
> +void *intel_pasid_get_table(struct device *dev);
> 
>  #endif /* __INTEL_PASID_H */
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index a4463f0..bee7a3f 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -424,6 +424,11 @@ struct dmar_domain {
>  					 */
>  	u64		max_addr;	/* maximum mapped address */
> 
> +	void		*pasid_table;	/* pointer of pasid table */
> +	unsigned int	pasid_users;	/* User number of pasid table */
> +	int		order;		/* the page order of tables */
> +	int		max_pasid;	/* max pasid */
> +
>  	struct iommu_domain domain;	/*
>  					 * generic domain data structure for
>  					 * iommu core
> --
> 2.7.4
