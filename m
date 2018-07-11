Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384F3C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E670420BEC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:45:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E670420BEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732436AbeGKCrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 22:47:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45784 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732292AbeGKCrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 22:47:17 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2AFB5401DED0;
        Wed, 11 Jul 2018 02:45:15 +0000 (UTC)
Received: from xz-mi (ovpn-12-41.pek2.redhat.com [10.72.12.41])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A4D1D2026D6B;
        Wed, 11 Jul 2018 02:45:09 +0000 (UTC)
Date:   Wed, 11 Jul 2018 10:45:06 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com,
        sanjay.k.kumar@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, yi.y.sun@intel.com,
        jacob.jun.pan@intel.com
Subject: Re: [PATCH v4 9/9] iommu/vt-d: Remove the obsolete per iommu pasid
 tables
Message-ID: <20180711024506.GB2359@xz-mi>
References: <1531113778-28238-1-git-send-email-baolu.lu@linux.intel.com>
 <1531113778-28238-10-git-send-email-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1531113778-28238-10-git-send-email-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 11 Jul 2018 02:45:15 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 11 Jul 2018 02:45:15 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'peterx@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 01:22:58PM +0800, Lu Baolu wrote:
> The obsolete per iommu pasid tables are no longer used. Hence,
> clean up them.
> 
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Liu Yi L <yi.l.liu@intel.com>
> ---
>  drivers/iommu/intel-iommu.c |  6 +++---
>  drivers/iommu/intel-svm.c   | 17 ++---------------
>  include/linux/intel-iommu.h |  5 ++---
>  3 files changed, 7 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index f8609b5..9a88081 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -1755,7 +1755,7 @@ static void free_dmar_iommu(struct intel_iommu *iommu)
>  	if (pasid_enabled(iommu)) {
>  		if (ecap_prs(iommu->ecap))
>  			intel_svm_finish_prq(iommu);
> -		intel_svm_free_pasid_tables(iommu);
> +		intel_svm_exit(iommu);
>  	}
>  #endif
>  }
> @@ -3336,7 +3336,7 @@ static int __init init_dmars(void)
>  			hw_pass_through = 0;
>  #ifdef CONFIG_INTEL_IOMMU_SVM
>  		if (pasid_enabled(iommu))
> -			intel_svm_alloc_pasid_tables(iommu);
> +			intel_svm_init(iommu);
>  #endif
>  	}
>  
> @@ -4330,7 +4330,7 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
>  
>  #ifdef CONFIG_INTEL_IOMMU_SVM
>  	if (pasid_enabled(iommu))
> -		intel_svm_alloc_pasid_tables(iommu);
> +		intel_svm_init(iommu);
>  #endif
>  
>  	if (dmaru->ignored) {
> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> index a253cde..eb30836 100644
> --- a/drivers/iommu/intel-svm.c
> +++ b/drivers/iommu/intel-svm.c
> @@ -38,7 +38,7 @@ struct pasid_state_entry {
>  	u64 val;
>  };
>  
> -int intel_svm_alloc_pasid_tables(struct intel_iommu *iommu)
> +int intel_svm_init(struct intel_iommu *iommu)
>  {
>  	struct page *pages;
>  	int order;
> @@ -63,15 +63,6 @@ int intel_svm_alloc_pasid_tables(struct intel_iommu *iommu)
>  		iommu->pasid_max = 0x20000;
>  
>  	order = get_order(sizeof(struct pasid_entry) * iommu->pasid_max);
> -	pages = alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
> -	if (!pages) {
> -		pr_warn("IOMMU: %s: Failed to allocate PASID table\n",
> -			iommu->name);
> -		return -ENOMEM;
> -	}
> -	iommu->pasid_table = page_address(pages);
> -	pr_info("%s: Allocated order %d PASID table.\n", iommu->name, order);
> -
>  	if (ecap_dis(iommu->ecap)) {
>  		/* Just making it explicit... */
>  		BUILD_BUG_ON(sizeof(struct pasid_entry) != sizeof(struct pasid_state_entry));

Then do we still need the so-called pasid state table?  I tried to
find out what it did before but I failed since I see that the bit 27
of the extended cap is marked as reserved now in the latest vt-d spec
(then ecap_dis could be meaningless too).

Asked since if we don't need both the per-iommu pasid table and the
pasid state table, then maybe we don't need intel_svm_init() at all?

> @@ -86,14 +77,10 @@ int intel_svm_alloc_pasid_tables(struct intel_iommu *iommu)
>  	return 0;
>  }
>  
> -int intel_svm_free_pasid_tables(struct intel_iommu *iommu)
> +int intel_svm_exit(struct intel_iommu *iommu)

Same thing applies to this exit() function - after we removed the
per-iommu idr, per-iommu pasid table, and (possibly obsolete)
per-iommu pasid state table, do we need that at all?

Thanks,

>  {
>  	int order = get_order(sizeof(struct pasid_entry) * iommu->pasid_max);
>  
> -	if (iommu->pasid_table) {
> -		free_pages((unsigned long)iommu->pasid_table, order);
> -		iommu->pasid_table = NULL;
> -	}
>  	if (iommu->pasid_state_table) {
>  		free_pages((unsigned long)iommu->pasid_state_table, order);
>  		iommu->pasid_state_table = NULL;
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index e7901d4..3c43882 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -453,7 +453,6 @@ struct intel_iommu {
>  	 * devices away to userspace processes (e.g. for DPDK) and don't
>  	 * want to trust that userspace will use *only* the PASID it was
>  	 * told to. But while it's all driver-arbitrated, we're fine. */
> -	struct pasid_entry *pasid_table;
>  	struct pasid_state_entry *pasid_state_table;
>  	struct page_req_dsc *prq;
>  	unsigned char prq_name[16];    /* Name for PRQ interrupt */
> @@ -526,8 +525,8 @@ int for_each_device_domain(int (*fn)(struct device_domain_info *info,
>  				     void *data), void *data);
>  
>  #ifdef CONFIG_INTEL_IOMMU_SVM
> -extern int intel_svm_alloc_pasid_tables(struct intel_iommu *iommu);
> -extern int intel_svm_free_pasid_tables(struct intel_iommu *iommu);
> +int intel_svm_init(struct intel_iommu *iommu);
> +int intel_svm_exit(struct intel_iommu *iommu);
>  extern int intel_svm_enable_prq(struct intel_iommu *iommu);
>  extern int intel_svm_finish_prq(struct intel_iommu *iommu);
>  
> -- 
> 2.7.4
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu

-- 
Peter Xu
