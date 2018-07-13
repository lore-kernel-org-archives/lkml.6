Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FCBECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 01:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75693214C2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 01:34:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75693214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387998AbeGMBqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 21:46:47 -0400
Received: from mga12.intel.com ([192.55.52.136]:54605 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387916AbeGMBqq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 21:46:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jul 2018 18:34:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,346,1526367600"; 
   d="scan'208";a="215622312"
Received: from blu2-desk2.ccr.corp.intel.com (HELO [10.0.2.15]) ([10.239.13.1])
  by orsmga004.jf.intel.com with ESMTP; 12 Jul 2018 18:34:30 -0700
Subject: Re: [PATCH v4 9/9] iommu/vt-d: Remove the obsolete per iommu pasid
 tables
To:     Peter Xu <peterx@redhat.com>
References: <1531113778-28238-1-git-send-email-baolu.lu@linux.intel.com>
 <1531113778-28238-10-git-send-email-baolu.lu@linux.intel.com>
 <20180711024506.GB2359@xz-mi>
Cc:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com,
        sanjay.k.kumar@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, yi.y.sun@intel.com,
        jacob.jun.pan@intel.com
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <5B4801A6.1090200@linux.intel.com>
Date:   Fri, 13 Jul 2018 09:34:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20180711024506.GB2359@xz-mi>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Do you have further comments for this series? I will work out a
new version if there are no ones.

Thank you for reviewing my patches. Do you allow me to add your
reviewed-by to the patches which you've reviewed?

Best regards,
Lu Baolu

On 07/11/2018 10:45 AM, Peter Xu wrote:
> On Mon, Jul 09, 2018 at 01:22:58PM +0800, Lu Baolu wrote:
>> The obsolete per iommu pasid tables are no longer used. Hence,
>> clean up them.
>>
>> Cc: Ashok Raj <ashok.raj@intel.com>
>> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Cc: Kevin Tian <kevin.tian@intel.com>
>> Cc: Liu Yi L <yi.l.liu@intel.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Reviewed-by: Liu Yi L <yi.l.liu@intel.com>
>> ---
>>  drivers/iommu/intel-iommu.c |  6 +++---
>>  drivers/iommu/intel-svm.c   | 17 ++---------------
>>  include/linux/intel-iommu.h |  5 ++---
>>  3 files changed, 7 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
>> index f8609b5..9a88081 100644
>> --- a/drivers/iommu/intel-iommu.c
>> +++ b/drivers/iommu/intel-iommu.c
>> @@ -1755,7 +1755,7 @@ static void free_dmar_iommu(struct intel_iommu *iommu)
>>  	if (pasid_enabled(iommu)) {
>>  		if (ecap_prs(iommu->ecap))
>>  			intel_svm_finish_prq(iommu);
>> -		intel_svm_free_pasid_tables(iommu);
>> +		intel_svm_exit(iommu);
>>  	}
>>  #endif
>>  }
>> @@ -3336,7 +3336,7 @@ static int __init init_dmars(void)
>>  			hw_pass_through = 0;
>>  #ifdef CONFIG_INTEL_IOMMU_SVM
>>  		if (pasid_enabled(iommu))
>> -			intel_svm_alloc_pasid_tables(iommu);
>> +			intel_svm_init(iommu);
>>  #endif
>>  	}
>>  
>> @@ -4330,7 +4330,7 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
>>  
>>  #ifdef CONFIG_INTEL_IOMMU_SVM
>>  	if (pasid_enabled(iommu))
>> -		intel_svm_alloc_pasid_tables(iommu);
>> +		intel_svm_init(iommu);
>>  #endif
>>  
>>  	if (dmaru->ignored) {
>> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
>> index a253cde..eb30836 100644
>> --- a/drivers/iommu/intel-svm.c
>> +++ b/drivers/iommu/intel-svm.c
>> @@ -38,7 +38,7 @@ struct pasid_state_entry {
>>  	u64 val;
>>  };
>>  
>> -int intel_svm_alloc_pasid_tables(struct intel_iommu *iommu)
>> +int intel_svm_init(struct intel_iommu *iommu)
>>  {
>>  	struct page *pages;
>>  	int order;
>> @@ -63,15 +63,6 @@ int intel_svm_alloc_pasid_tables(struct intel_iommu *iommu)
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
>>  		BUILD_BUG_ON(sizeof(struct pasid_entry) != sizeof(struct pasid_state_entry));
> Then do we still need the so-called pasid state table?  I tried to
> find out what it did before but I failed since I see that the bit 27
> of the extended cap is marked as reserved now in the latest vt-d spec
> (then ecap_dis could be meaningless too).
>
> Asked since if we don't need both the per-iommu pasid table and the
> pasid state table, then maybe we don't need intel_svm_init() at all?
>
>> @@ -86,14 +77,10 @@ int intel_svm_alloc_pasid_tables(struct intel_iommu *iommu)
>>  	return 0;
>>  }
>>  
>> -int intel_svm_free_pasid_tables(struct intel_iommu *iommu)
>> +int intel_svm_exit(struct intel_iommu *iommu)
> Same thing applies to this exit() function - after we removed the
> per-iommu idr, per-iommu pasid table, and (possibly obsolete)
> per-iommu pasid state table, do we need that at all?
>
> Thanks,
>
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
>> index e7901d4..3c43882 100644
>> --- a/include/linux/intel-iommu.h
>> +++ b/include/linux/intel-iommu.h
>> @@ -453,7 +453,6 @@ struct intel_iommu {
>>  	 * devices away to userspace processes (e.g. for DPDK) and don't
>>  	 * want to trust that userspace will use *only* the PASID it was
>>  	 * told to. But while it's all driver-arbitrated, we're fine. */
>> -	struct pasid_entry *pasid_table;
>>  	struct pasid_state_entry *pasid_state_table;
>>  	struct page_req_dsc *prq;
>>  	unsigned char prq_name[16];    /* Name for PRQ interrupt */
>> @@ -526,8 +525,8 @@ int for_each_device_domain(int (*fn)(struct device_domain_info *info,
>>  				     void *data), void *data);
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
>>
>> _______________________________________________
>> iommu mailing list
>> iommu@lists.linux-foundation.org
>> https://lists.linuxfoundation.org/mailman/listinfo/iommu

