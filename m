Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 176EBC4321E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 23:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5593206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 23:13:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5593206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728498AbeIGDvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 23:51:01 -0400
Received: from mga18.intel.com ([134.134.136.126]:6332 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbeIGDvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 23:51:01 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2018 16:13:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,339,1531810800"; 
   d="scan'208";a="70984649"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.32])
  by orsmga007.jf.intel.com with ESMTP; 06 Sep 2018 16:13:13 -0700
Date:   Thu, 6 Sep 2018 16:13:13 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH 1/1] iommu/vt-d: Handle memory shortage on pasid table
 allocation
Message-ID: <20180906231313.GB90494@otc-nc-03>
References: <20180901062416.6107-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180901062416.6107-1-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 01, 2018 at 02:24:16PM +0800, Lu Baolu wrote:
> Pasid table memory allocation could return failure due to memory
> shortage. Limit the pasid table size to 1MiB because current 8MiB
> contiguous physical memory allocation can be hard to come by. W/o
> a PASID table, the device could continue to work with only shared
> virtual memory impacted. So, let's go ahead with context mapping
> even the memory allocation for pasid table failed.
> 
> Fixes: cc580e41260d ("iommu/vt-d: Per PCI device pasid table interfaces")

Although this reduces the changes of failure, ideally we should remove
any trace of ecs support. We officially have no products that support it
officially, and our latest spec does deprecate ECS feature.

> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reported-and-tested-by: Pelton Kyle D <kyle.d.pelton@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel-iommu.c | 6 +++---
>  drivers/iommu/intel-pasid.h | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 5f3f10cf9d9d..bedc801b06a0 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -2540,9 +2540,9 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
>  	if (dev && dev_is_pci(dev) && info->pasid_supported) {
>  		ret = intel_pasid_alloc_table(dev);
>  		if (ret) {
> -			__dmar_remove_one_dev_info(info);
> -			spin_unlock_irqrestore(&device_domain_lock, flags);
> -			return NULL;
> +			pr_warn("No pasid table for %s, pasid disabled\n",
> +				dev_name(dev));
> +			info->pasid_supported = 0;
>  		}
>  	}
>  	spin_unlock_irqrestore(&device_domain_lock, flags);
> diff --git a/drivers/iommu/intel-pasid.h b/drivers/iommu/intel-pasid.h
> index 1c05ed6fc5a5..1fb5e12b029a 100644
> --- a/drivers/iommu/intel-pasid.h
> +++ b/drivers/iommu/intel-pasid.h
> @@ -11,7 +11,7 @@
>  #define __INTEL_PASID_H
>  
>  #define PASID_MIN			0x1
> -#define PASID_MAX			0x100000
> +#define PASID_MAX			0x20000
>  
>  struct pasid_entry {
>  	u64 val;
> -- 
> 2.17.1
> 
