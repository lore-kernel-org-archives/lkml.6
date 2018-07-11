Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C26C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A9D520849
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:26:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A9D520849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbeGKH31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 03:29:27 -0400
Received: from mga07.intel.com ([134.134.136.100]:10664 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726444AbeGKH31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 03:29:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jul 2018 00:26:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,337,1526367600"; 
   d="scan'208";a="66038387"
Received: from blu2-desk2.ccr.corp.intel.com (HELO [10.0.2.15]) ([10.239.13.1])
  by orsmga003.jf.intel.com with ESMTP; 11 Jul 2018 00:26:27 -0700
Subject: Re: [PATCH v4 6/9] iommu/vt-d: Per PCI device pasid table interfaces
To:     Peter Xu <peterx@redhat.com>
References: <1531113778-28238-1-git-send-email-baolu.lu@linux.intel.com>
 <1531113778-28238-7-git-send-email-baolu.lu@linux.intel.com>
 <20180711021826.GA2359@xz-mi>
Cc:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com,
        sanjay.k.kumar@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, yi.y.sun@intel.com,
        jacob.jun.pan@intel.com
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <5B45B11D.1080405@linux.intel.com>
Date:   Wed, 11 Jul 2018 15:26:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20180711021826.GA2359@xz-mi>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07/11/2018 10:18 AM, Peter Xu wrote:
> On Mon, Jul 09, 2018 at 01:22:55PM +0800, Lu Baolu wrote:
>> This patch adds the interfaces for per PCI device pasid
>> table management. Currently we allocate one pasid table
>> for all PCI devices under the scope of an IOMMU. It's
>> insecure in some cases where multiple devices under one
>> single IOMMU unit support PASID features. With per PCI
>> device pasid table, we can achieve finer protection and
>> isolation granularity.
>>
>> Cc: Ashok Raj <ashok.raj@intel.com>
>> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Cc: Kevin Tian <kevin.tian@intel.com>
>> Cc: Liu Yi L <yi.l.liu@intel.com>
>> Suggested-by: Ashok Raj <ashok.raj@intel.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Reviewed-by: Liu Yi L <yi.l.liu@intel.com>
>> ---
>>  drivers/iommu/intel-iommu.c |   1 +
>>  drivers/iommu/intel-pasid.c | 178 ++++++++++++++++++++++++++++++++++++++++++++
>>  drivers/iommu/intel-pasid.h |  18 +++++
>>  drivers/iommu/intel-svm.c   |   4 -
>>  include/linux/intel-iommu.h |   2 +
>>  5 files changed, 199 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
>> index 3d802c5..a930918 100644
>> --- a/drivers/iommu/intel-iommu.c
>> +++ b/drivers/iommu/intel-iommu.c
>> @@ -2450,6 +2450,7 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
>>  	info->dev = dev;
>>  	info->domain = domain;
>>  	info->iommu = iommu;
>> +	info->pasid_table = NULL;
>>  
>>  	if (dev && dev_is_pci(dev)) {
>>  		struct pci_dev *pdev = to_pci_dev(info->dev);
>> diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
>> index e918fe0..1b61942 100644
>> --- a/drivers/iommu/intel-pasid.c
>> +++ b/drivers/iommu/intel-pasid.c
>> @@ -13,6 +13,8 @@
>>  #include <linux/intel-iommu.h>
>>  #include <linux/iommu.h>
>>  #include <linux/memory.h>
>> +#include <linux/pci.h>
>> +#include <linux/pci-ats.h>
>>  #include <linux/spinlock.h>
>>  
>>  #include "intel-pasid.h"
>> @@ -58,3 +60,179 @@ void *intel_pasid_lookup_id(int pasid)
>>  
>>  	return p;
>>  }
>> +
>> +/*
>> + * Per device pasid table management:
>> + */
>> +static inline void
>> +device_attach_pasid_table(struct device_domain_info *info,
>> +			  struct pasid_table *pasid_table)
>> +{
>> +	info->pasid_table = pasid_table;
>> +	list_add(&info->table, &pasid_table->dev);
>> +}
>> +
>> +static inline void
>> +device_detach_pasid_table(struct device_domain_info *info,
>> +			  struct pasid_table *pasid_table)
>> +{
>> +	info->pasid_table = NULL;
>> +	list_del(&info->table);
>> +}
>> +
>> +struct pasid_table_opaque {
>> +	struct pasid_table	**pasid_table;
>> +	int			segment;
>> +	int			bus;
>> +	int			devfn;
>> +};
>> +
>> +static int search_pasid_table(struct device_domain_info *info, void *opaque)
>> +{
>> +	struct pasid_table_opaque *data = opaque;
>> +
>> +	if (info->iommu->segment == data->segment &&
>> +	    info->bus == data->bus &&
>> +	    info->devfn == data->devfn &&
>> +	    info->pasid_table) {
>> +		*data->pasid_table = info->pasid_table;
>> +		return 1;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int get_alias_pasid_table(struct pci_dev *pdev, u16 alias, void *opaque)
>> +{
>> +	struct pasid_table_opaque *data = opaque;
>> +
>> +	data->segment = pci_domain_nr(pdev->bus);
>> +	data->bus = PCI_BUS_NUM(alias);
>> +	data->devfn = alias & 0xff;
>> +
>> +	return for_each_device_domain(&search_pasid_table, data);
>> +}
>> +
>> +int intel_pasid_alloc_table(struct device *dev)
>> +{
>> +	struct device_domain_info *info;
>> +	struct pasid_table *pasid_table;
>> +	struct pasid_table_opaque data;
>> +	struct page *pages;
>> +	size_t size, count;
>> +	int ret, order;
>> +
>> +	info = dev->archdata.iommu;
>> +	if (WARN_ON(!info || !dev_is_pci(dev) ||
>> +		    !info->pasid_supported || info->pasid_table))
>> +		return -EINVAL;
>> +
>> +	/* DMA alias device already has a pasid table, use it: */
>> +	data.pasid_table = &pasid_table;
>> +	ret = pci_for_each_dma_alias(to_pci_dev(dev),
>> +				     &get_alias_pasid_table, &data);
>> +	if (ret)
>> +		goto attach_out;
>> +
>> +	pasid_table = kzalloc(sizeof(*pasid_table), GFP_ATOMIC);
> Do we need to take some lock here (e.g., the pasid lock)?  Otherwise
> what if two devices (that are sharing the same DMA alias) call the
> function intel_pasid_alloc_table() concurrently, then could it
> possible that we create one table for each of the device while AFAIU
> we should let them share a single pasid table?

The only place where this function is called is in a single-thread context
(protected by a spinlock of device_domain_lock with local interrupt disabled).

So we don't need an extra lock here. But anyway, I should put a comment
here.

>
>> +	if (!pasid_table)
>> +		return -ENOMEM;
>> +	INIT_LIST_HEAD(&pasid_table->dev);
>> +
>> +	size = sizeof(struct pasid_entry);
>> +	count = min_t(int, pci_max_pasids(to_pci_dev(dev)), intel_pasid_max_id);
>> +	order = get_order(size * count);
>> +	pages = alloc_pages_node(info->iommu->node,
>> +				 GFP_ATOMIC | __GFP_ZERO,
>> +				 order);
>> +	if (!pages)
>> +		return -ENOMEM;
>> +
>> +	pasid_table->table = page_address(pages);
>> +	pasid_table->order = order;
>> +	pasid_table->max_pasid = count;
>> +
>> +attach_out:
>> +	device_attach_pasid_table(info, pasid_table);
>> +
>> +	return 0;
>> +}
>> +
>> +void intel_pasid_free_table(struct device *dev)
>> +{
>> +	struct device_domain_info *info;
>> +	struct pasid_table *pasid_table;
>> +
>> +	info = dev->archdata.iommu;
>> +	if (!info || !dev_is_pci(dev) ||
>> +	    !info->pasid_supported || !info->pasid_table)
>> +		return;
>> +
>> +	pasid_table = info->pasid_table;
>> +	device_detach_pasid_table(info, pasid_table);
>> +
>> +	if (!list_empty(&pasid_table->dev))
>> +		return;
> Same question to here: do we need a lock?

Same reason as above.

>
>> +
>> +	free_pages((unsigned long)pasid_table->table, pasid_table->order);
>> +	kfree(pasid_table);
>> +}
>> +
>> +struct pasid_table *intel_pasid_get_table(struct device *dev)
>> +{
>> +	struct device_domain_info *info;
>> +
>> +	info = dev->archdata.iommu;
>> +	if (!info)
>> +		return NULL;
>> +
>> +	return info->pasid_table;
>> +}
>> +
>> +int intel_pasid_get_dev_max_id(struct device *dev)
>> +{
>> +	struct device_domain_info *info;
>> +
>> +	info = dev->archdata.iommu;
>> +	if (!info || !info->pasid_table)
>> +		return 0;
>> +
>> +	return info->pasid_table->max_pasid;
>> +}
>> +
>> +struct pasid_entry *intel_pasid_get_entry(struct device *dev, int pasid)
>> +{
>> +	struct pasid_table *pasid_table;
>> +	struct pasid_entry *entries;
>> +
>> +	pasid_table = intel_pasid_get_table(dev);
>> +	if (WARN_ON(!pasid_table || pasid < 0 ||
>> +		    pasid >= intel_pasid_get_dev_max_id(dev)))
>> +		return NULL;
>> +
>> +	entries = pasid_table->table;
>> +
>> +	return &entries[pasid];
>> +}
>> +
>> +/*
>> + * Interfaces for PASID table entry manipulation:
>> + */
>> +static void sm_pasid_clear_entry(struct pasid_entry *pe)
>> +{
>> +	memset(pe, 0, sizeof(struct pasid_entry));
> [1]
>
>> +}
>> +
>> +void intel_pasid_clear_entry(struct device *dev, int pasid)
>> +{
>> +	struct pasid_entry *pe;
>> +
>> +	pe = intel_pasid_get_entry(dev, pasid);
>> +	if (WARN_ON(!pe))
>> +		return;
>> +
>> +	sm_pasid_clear_entry(pe);
>> +
>> +	/* Make sure the entry update is visible before translation. */
>> +	wmb();
> Pure question: AFAIU wmb only orders write operation, then do we
> really need it here?  Instead from the comment I feel like what we
> really need is a WRITE_ONCE() at [1].  Am I wrong somewhere?

I reconsidered this. Yes, you are right. I *need* a WRITE_ONCE() at [1].

Good catch! Thank you!

Best regards,
Lu Baolu
