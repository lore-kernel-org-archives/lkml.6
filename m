Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750939AbeEBEn2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 00:43:28 -0400
Received: from mga06.intel.com ([134.134.136.31]:49808 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750822AbeEBEn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 00:43:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,353,1520924400";
   d="scan'208";a="46079506"
Subject: Re: [PATCH 9/9] iommu/vt-d: Clean up PASID talbe management for SVM
To: "Liu, Yi L" <yi.l.liu@intel.com>,
        David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>
References: <1523934202-21669-1-git-send-email-baolu.lu@linux.intel.com>
 <1523934202-21669-10-git-send-email-baolu.lu@linux.intel.com>
 <A2975661238FB949B60364EF0F2C257439BE7567@SHSMSX104.ccr.corp.intel.com>
Cc: "Raj, Ashok" <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <5AE941E5.2060102@linux.intel.com>
Date: Wed, 2 May 2018 12:43:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <A2975661238FB949B60364EF0F2C257439BE7567@SHSMSX104.ccr.corp.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 05/01/2018 05:24 PM, Liu, Yi L wrote:
>> From: Lu Baolu [mailto:baolu.lu@linux.intel.com]
>> Sent: Tuesday, April 17, 2018 11:03 AM
>>
>> The previous per iommu pasid table alloc/free interfaces
>> are no longer used. Clean up the driver by removing it.
> I think this patch major cleans intel_svm_alloc_pasid_tables
> and intel_svm_free_pasid_tables.

Yes.

>  Actually, only PASID State
> table allocation is remained in these two functions.

Together with GB pages and 5-level page table support checks.

>
> Since PASID Table is modified to be per-iommu domain. How
> about the PASID State Table? Should it also be per-iommu domain?

Yes. This is in plan. I will do this in another patch series.

>
> Thanks,
> Yi Liu

Best regards,
Lu Baolu

>> Cc: Ashok Raj <ashok.raj@intel.com>
>> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Cc: Kevin Tian <kevin.tian@intel.com>
>> Cc: Liu Yi L <yi.l.liu@intel.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>  drivers/iommu/intel-iommu.c |  6 +++---
>>  drivers/iommu/intel-svm.c   | 17 ++---------------
>>  include/linux/intel-iommu.h |  5 ++---
>>  3 files changed, 7 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
>> index 5fe7f91..5acb90d 100644
>> --- a/drivers/iommu/intel-iommu.c
>> +++ b/drivers/iommu/intel-iommu.c
>> @@ -1736,7 +1736,7 @@ static void free_dmar_iommu(struct intel_iommu *iommu)
>>  	if (pasid_enabled(iommu)) {
>>  		if (ecap_prs(iommu->ecap))
>>  			intel_svm_finish_prq(iommu);
>> -		intel_svm_free_pasid_tables(iommu);
>> +		intel_svm_exit(iommu);
>>  	}
>>  #endif
>>  }
>> @@ -3291,7 +3291,7 @@ static int __init init_dmars(void)
>>  			hw_pass_through = 0;
>>  #ifdef CONFIG_INTEL_IOMMU_SVM
>>  		if (pasid_enabled(iommu))
>> -			intel_svm_alloc_pasid_tables(iommu);
>> +			intel_svm_init(iommu);
>>  #endif
>>  	}
>>
>> @@ -4268,7 +4268,7 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
>>
>>  #ifdef CONFIG_INTEL_IOMMU_SVM
>>  	if (pasid_enabled(iommu))
>> -		intel_svm_alloc_pasid_tables(iommu);
>> +		intel_svm_init(iommu);
>>  #endif
>>
>>  	if (dmaru->ignored) {
>> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
>> index 3b14819..38cae65 100644
>> --- a/drivers/iommu/intel-svm.c
>> +++ b/drivers/iommu/intel-svm.c
>> @@ -34,7 +34,7 @@
>>
>>  static irqreturn_t prq_event_thread(int irq, void *d);
>>
>> -int intel_svm_alloc_pasid_tables(struct intel_iommu *iommu)
>> +int intel_svm_init(struct intel_iommu *iommu)
>>  {
>>  	struct page *pages;
>>  	int order;
>> @@ -59,15 +59,6 @@ int intel_svm_alloc_pasid_tables(struct intel_iommu *iommu)
>>  		iommu->pasid_max = 0x20000;
>>
>>  	order = get_order(sizeof(struct pasid_entry) * iommu->pasid_max);
>> -	pages = alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
>> -	if (!pages) {
>> -		pr_warn("IOMMU: %s: Failed to allocate PASID table\n",
>> -			iommu->name);
>> -		return -ENOMEM;
>> -	}
>> -	iommu->pasid_table = page_address(pages);
>> -	pr_info("%s: Allocated order %d PASID table.\n", iommu->name, order);
>> -
>>  	if (ecap_dis(iommu->ecap)) {
>>  		/* Just making it explicit... */
>>  		BUILD_BUG_ON(sizeof(struct pasid_entry) != sizeof(struct
>> pasid_state_entry));
>> @@ -82,14 +73,10 @@ int intel_svm_alloc_pasid_tables(struct intel_iommu
>> *iommu)
>>  	return 0;
>>  }
>>
>> -int intel_svm_free_pasid_tables(struct intel_iommu *iommu)
>> +int intel_svm_exit(struct intel_iommu *iommu)
>>  {
>>  	int order = get_order(sizeof(struct pasid_entry) * iommu->pasid_max);
>>
>> -	if (iommu->pasid_table) {
>> -		free_pages((unsigned long)iommu->pasid_table, order);
>> -		iommu->pasid_table = NULL;
>> -	}
>>  	if (iommu->pasid_state_table) {
>>  		free_pages((unsigned long)iommu->pasid_state_table, order);
>>  		iommu->pasid_state_table = NULL;
>> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
>> index 08e5811..44c7613 100644
>> --- a/include/linux/intel-iommu.h
>> +++ b/include/linux/intel-iommu.h
>> @@ -470,7 +470,6 @@ struct intel_iommu {
>>  	 * devices away to userspace processes (e.g. for DPDK) and don't
>>  	 * want to trust that userspace will use *only* the PASID it was
>>  	 * told to. But while it's all driver-arbitrated, we're fine. */
>> -	struct pasid_entry *pasid_table;
>>  	struct pasid_state_entry *pasid_state_table;
>>  	struct page_req_dsc *prq;
>>  	unsigned char prq_name[16];    /* Name for PRQ interrupt */
>> @@ -539,8 +538,8 @@ void free_pgtable_page(void *vaddr);
>>  struct intel_iommu *domain_get_iommu(struct dmar_domain *domain);
>>
>>  #ifdef CONFIG_INTEL_IOMMU_SVM
>> -extern int intel_svm_alloc_pasid_tables(struct intel_iommu *iommu);
>> -extern int intel_svm_free_pasid_tables(struct intel_iommu *iommu);
>> +int intel_svm_init(struct intel_iommu *iommu);
>> +int intel_svm_exit(struct intel_iommu *iommu);
>>  extern int intel_svm_enable_prq(struct intel_iommu *iommu);
>>  extern int intel_svm_finish_prq(struct intel_iommu *iommu);
>>
>> --
>> 2.7.4
>
