Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB1BECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 06:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EFF820873
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 06:02:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EFF820873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbeGPG15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 02:27:57 -0400
Received: from mga06.intel.com ([134.134.136.31]:8746 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727163AbeGPG15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 02:27:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jul 2018 23:02:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,360,1526367600"; 
   d="scan'208";a="216294168"
Received: from blu2-desk2.ccr.corp.intel.com (HELO [10.0.2.15]) ([10.239.13.1])
  by orsmga004.jf.intel.com with ESMTP; 15 Jul 2018 23:02:11 -0700
Subject: Re: [PATCH 1/1] Revert "iommu/vt-d: Clean up pasid quirk for
 pre-production devices"
To:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
References: <1531031001-5783-1-git-send-email-baolu.lu@linux.intel.com>
Cc:     ashok.raj@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        Zhenyu Wang <zhenyuw@linux.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <5B4C34E4.30004@linux.intel.com>
Date:   Mon, 16 Jul 2018 14:02:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <1531031001-5783-1-git-send-email-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

The graphic guys are looking forward to having this in 4.18.
Is it possible to take it in the following rcs?

Best regards,
Lu Baolu

On 07/08/2018 02:23 PM, Lu Baolu wrote:
> This reverts commit ab96746aaa344fb720a198245a837e266fad3b62.
>
> The commit ab96746aaa34 ("iommu/vt-d: Clean up pasid quirk for
> pre-production devices") triggers ECS mode on some platforms
> which have broken ECS support. As the result, graphic device
> will be inoperable on boot.
>
> Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=107017
>
> Cc: Ashok Raj <ashok.raj@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel-iommu.c | 32 ++++++++++++++++++++++++++++++--
>  include/linux/intel-iommu.h |  1 +
>  2 files changed, 31 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index b344a88..115ff26 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -484,14 +484,37 @@ static int dmar_forcedac;
>  static int intel_iommu_strict;
>  static int intel_iommu_superpage = 1;
>  static int intel_iommu_ecs = 1;
> +static int intel_iommu_pasid28;
>  static int iommu_identity_mapping;
>  
>  #define IDENTMAP_ALL		1
>  #define IDENTMAP_GFX		2
>  #define IDENTMAP_AZALIA		4
>  
> -#define ecs_enabled(iommu)	(intel_iommu_ecs && ecap_ecs(iommu->ecap))
> -#define pasid_enabled(iommu)	(ecs_enabled(iommu) && ecap_pasid(iommu->ecap))
> +/* Broadwell and Skylake have broken ECS support — normal so-called "second
> + * level" translation of DMA requests-without-PASID doesn't actually happen
> + * unless you also set the NESTE bit in an extended context-entry. Which of
> + * course means that SVM doesn't work because it's trying to do nested
> + * translation of the physical addresses it finds in the process page tables,
> + * through the IOVA->phys mapping found in the "second level" page tables.
> + *
> + * The VT-d specification was retroactively changed to change the definition
> + * of the capability bits and pretend that Broadwell/Skylake never happened...
> + * but unfortunately the wrong bit was changed. It's ECS which is broken, but
> + * for some reason it was the PASID capability bit which was redefined (from
> + * bit 28 on BDW/SKL to bit 40 in future).
> + *
> + * So our test for ECS needs to eschew those implementations which set the old
> + * PASID capabiity bit 28, since those are the ones on which ECS is broken.
> + * Unless we are working around the 'pasid28' limitations, that is, by putting
> + * the device into passthrough mode for normal DMA and thus masking the bug.
> + */
> +#define ecs_enabled(iommu) (intel_iommu_ecs && ecap_ecs(iommu->ecap) && \
> +			    (intel_iommu_pasid28 || !ecap_broken_pasid(iommu->ecap)))
> +/* PASID support is thus enabled if ECS is enabled and *either* of the old
> + * or new capability bits are set. */
> +#define pasid_enabled(iommu) (ecs_enabled(iommu) &&			\
> +			      (ecap_pasid(iommu->ecap) || ecap_broken_pasid(iommu->ecap)))
>  
>  int intel_iommu_gfx_mapped;
>  EXPORT_SYMBOL_GPL(intel_iommu_gfx_mapped);
> @@ -554,6 +577,11 @@ static int __init intel_iommu_setup(char *str)
>  			printk(KERN_INFO
>  				"Intel-IOMMU: disable extended context table support\n");
>  			intel_iommu_ecs = 0;
> +		} else if (!strncmp(str, "pasid28", 7)) {
> +			printk(KERN_INFO
> +				"Intel-IOMMU: enable pre-production PASID support\n");
> +			intel_iommu_pasid28 = 1;
> +			iommu_identity_mapping |= IDENTMAP_GFX;
>  		} else if (!strncmp(str, "tboot_noforce", 13)) {
>  			printk(KERN_INFO
>  				"Intel-IOMMU: not forcing on after tboot. This could expose security risk for tboot\n");
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 1df9401..ef169d6 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -121,6 +121,7 @@
>  #define ecap_srs(e)		((e >> 31) & 0x1)
>  #define ecap_ers(e)		((e >> 30) & 0x1)
>  #define ecap_prs(e)		((e >> 29) & 0x1)
> +#define ecap_broken_pasid(e)	((e >> 28) & 0x1)
>  #define ecap_dis(e)		((e >> 27) & 0x1)
>  #define ecap_nest(e)		((e >> 26) & 0x1)
>  #define ecap_mts(e)		((e >> 25) & 0x1)

