Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245EAC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 06:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD36A2089B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 06:44:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD36A2089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbeGKGqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 02:46:42 -0400
Received: from mga06.intel.com ([134.134.136.31]:12713 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726361AbeGKGqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 02:46:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2018 23:43:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,337,1526367600"; 
   d="scan'208";a="244746683"
Received: from blu2-desk2.ccr.corp.intel.com (HELO [10.0.2.15]) ([10.239.13.1])
  by fmsmga006.fm.intel.com with ESMTP; 10 Jul 2018 23:43:56 -0700
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
Message-ID: <5B45A727.3080801@linux.intel.com>
Date:   Wed, 11 Jul 2018 14:43:51 +0800
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

Good eyes!

Yes, we will cleanup this with a following patch series which enables
features defined in the vt-d v3.0.

Best regards,
Lu Baolu
