Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0DFC67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 04:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2127207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 04:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aNlsAR7a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2127207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbeJWMgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 08:36:54 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:45510 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727075AbeJWMgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 08:36:54 -0400
Received: by mail-yb1-f194.google.com with SMTP id 131-v6so2348440ybe.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 21:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fjzq+067ROV9KpHVl4dVALJn6HDkMi4wVcwtqgOooRk=;
        b=aNlsAR7a6RBfTagM3oBT5gayy0QWRbnHafapyjPsO37VqC22u4xreLjUIcIqJ5Z0C1
         ivGScUyleLcwpEQKPxQeeTdgNodpUpsHhLeDtn5Xj0XkdxWgLmneiE4ZV7Oqzse5IcVw
         m2IglCvMouSyH+G72CLFDzrts2n9v9Y62vk4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fjzq+067ROV9KpHVl4dVALJn6HDkMi4wVcwtqgOooRk=;
        b=cjej/+Q4tegDOYORCz8wKlqHCyTLE3JaWyADU34EkB7h73QY4X3YSVoth9Zx9OPBcx
         muvoLjc/RhSMncKJ+INWb1hEKbgPnRJ16e63OPGzrzWs8wksEFiC9WR0NaEn6ZC0VfZp
         LG6O4tWoSdUnTNJw772juEV6KyIWyCPxSW0A8tEglJXZ9zQ8qBvX+AbTlwnSeIdaRmGi
         8G9uWpZc2J2YhYTn8fcYbIfns7UGbiiXJkxrtLbe5uSOzGl8MSVdVl2mALwiQlEg3WxO
         FcNIhNPhehFX7S2kG3F9J10mbsB8BAIfrmNh+OxUFyXHO5dThPJtrhZSiiiULjjuA/jE
         xU4Q==
X-Gm-Message-State: AGRZ1gIxsLTExG4e1NgyCHOqYd/JWFWV7y450QRecKFJYgEtIlWDa2EY
        FJqWFtdczqWOueIHCvPbpDxZcroIWXu+SA==
X-Google-Smtp-Source: AJdET5dlCZoYO+Q/eWi1ZUt2Ug3yvBuAUk21BDYIMV3yr3Isakpch33WUJ7cTRqBJuZ9/gzoUER38g==
X-Received: by 2002:a25:56d7:: with SMTP id k206-v6mr10419784ybb.120.1540268119587;
        Mon, 22 Oct 2018 21:15:19 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id 207-v6sm16409ywi.0.2018.10.22.21.15.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 21:15:18 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id d18-v6so5071yba.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 21:15:18 -0700 (PDT)
X-Received: by 2002:a25:cb53:: with SMTP id b80-v6mr635991ybg.303.1540268117720;
 Mon, 22 Oct 2018 21:15:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180615105329.26800-1-vivek.gautam@codeaurora.org>
In-Reply-To: <20180615105329.26800-1-vivek.gautam@codeaurora.org>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Tue, 23 Oct 2018 13:15:06 +0900
X-Gmail-Original-Message-ID: <CAAFQd5AMirap5vjVC+73cv_KzE=-+EUD6TWd_NHRDw_m-sXDrw@mail.gmail.com>
Message-ID: <CAAFQd5AMirap5vjVC+73cv_KzE=-+EUD6TWd_NHRDw_m-sXDrw@mail.gmail.com>
Subject: Re: [PATCH 1/1] iommu/arm-smmu: Add support to use Last level cache
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <joro@8bytes.org>, pdaly@codeaurora.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vivek,

On Fri, Jun 15, 2018 at 7:53 PM Vivek Gautam
<vivek.gautam@codeaurora.org> wrote:
>
> Qualcomm SoCs have an additional level of cache called as
> System cache or Last level cache[1]. This cache sits right
> before the DDR, and is tightly coupled with the memory
> controller.
> The cache is available to all the clients present in the
> SoC system. The clients request their slices from this system
> cache, make it active, and can then start using it. For these
> clients with smmu, to start using the system cache for
> dma buffers and related page tables [2], few of the memory
> attributes need to be set accordingly.
> This change makes the related memory Outer-Shareable, and
> updates the MAIR with necessary protection.
>
> The MAIR attribute requirements are:
>     Inner Cacheablity = 0
>     Outer Cacheablity = 1, Write-Back Write Allocate
>     Outer Shareablity = 1
>
> This change is a realisation of following changes
> from downstream msm-4.9:
> iommu: io-pgtable-arm: Support DOMAIN_ATTRIBUTE_USE_UPSTREAM_HINT
> iommu: io-pgtable-arm: Implement IOMMU_USE_UPSTREAM_HINT

Would you be able to provide links to those 2 downstream changes?

>
> [1] https://patchwork.kernel.org/patch/10422531/
> [2] https://patchwork.kernel.org/patch/10302791/
>
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> ---
>  drivers/iommu/arm-smmu.c       | 14 ++++++++++++++
>  drivers/iommu/io-pgtable-arm.c | 24 +++++++++++++++++++-----
>  drivers/iommu/io-pgtable.h     |  4 ++++
>  include/linux/iommu.h          |  4 ++++
>  4 files changed, 41 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index f7a96bcf94a6..8058e7205034 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -249,6 +249,7 @@ struct arm_smmu_domain {
>         struct mutex                    init_mutex; /* Protects smmu pointer */
>         spinlock_t                      cb_lock; /* Serialises ATS1* ops and TLB syncs */
>         struct iommu_domain             domain;
> +       bool                            has_sys_cache;
>  };
>
>  struct arm_smmu_option_prop {
> @@ -862,6 +863,8 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>
>         if (smmu->features & ARM_SMMU_FEAT_COHERENT_WALK)
>                 pgtbl_cfg.quirks = IO_PGTABLE_QUIRK_NO_DMA;
> +       if (smmu_domain->has_sys_cache)
> +               pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_SYS_CACHE;
>
>         smmu_domain->smmu = smmu;
>         pgtbl_ops = alloc_io_pgtable_ops(fmt, &pgtbl_cfg, smmu_domain);
> @@ -1477,6 +1480,9 @@ static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
>         case DOMAIN_ATTR_NESTING:
>                 *(int *)data = (smmu_domain->stage == ARM_SMMU_DOMAIN_NESTED);
>                 return 0;
> +       case DOMAIN_ATTR_USE_SYS_CACHE:
> +               *((int *)data) = smmu_domain->has_sys_cache;
> +               return 0;
>         default:
>                 return -ENODEV;
>         }
> @@ -1506,6 +1512,14 @@ static int arm_smmu_domain_set_attr(struct iommu_domain *domain,
>                         smmu_domain->stage = ARM_SMMU_DOMAIN_S1;
>
>                 break;
> +       case DOMAIN_ATTR_USE_SYS_CACHE:
> +               if (smmu_domain->smmu) {
> +                       ret = -EPERM;
> +                       goto out_unlock;
> +               }
> +               if (*((int *)data))
> +                       smmu_domain->has_sys_cache = true;
> +               break;
>         default:
>                 ret = -ENODEV;
>         }
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index 010a254305dd..b2aee1828524 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -169,9 +169,11 @@
>  #define ARM_LPAE_MAIR_ATTR_DEVICE      0x04
>  #define ARM_LPAE_MAIR_ATTR_NC          0x44
>  #define ARM_LPAE_MAIR_ATTR_WBRWA       0xff
> +#define ARM_LPAE_MAIR_ATTR_SYS_CACHE   0xf4
>  #define ARM_LPAE_MAIR_ATTR_IDX_NC      0
>  #define ARM_LPAE_MAIR_ATTR_IDX_CACHE   1
>  #define ARM_LPAE_MAIR_ATTR_IDX_DEV     2
> +#define ARM_LPAE_MAIR_ATTR_IDX_SYS_CACHE       3
>
>  /* IOPTE accessors */
>  #define iopte_deref(pte,d) __va(iopte_to_paddr(pte, d))
> @@ -442,6 +444,10 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
>                 else if (prot & IOMMU_CACHE)
>                         pte |= (ARM_LPAE_MAIR_ATTR_IDX_CACHE
>                                 << ARM_LPAE_PTE_ATTRINDX_SHIFT);
> +               else if (prot & IOMMU_SYS_CACHE)
> +                       pte |= (ARM_LPAE_MAIR_ATTR_IDX_SYS_CACHE
> +                               << ARM_LPAE_PTE_ATTRINDX_SHIFT);
> +

Okay, so we favor the full caching (IC WBRWA, OC WBRWA, OS) first if
requested or otherwise try to use system cache (IC NC, OC WBWA?, OS)?
Sounds fine.

nit: Unnecessary blank line.

>         } else {
>                 pte = ARM_LPAE_PTE_HAP_FAULT;
>                 if (prot & IOMMU_READ)
> @@ -771,7 +777,8 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
>         u64 reg;
>         struct arm_lpae_io_pgtable *data;
>
> -       if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_NS | IO_PGTABLE_QUIRK_NO_DMA))
> +       if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_NS | IO_PGTABLE_QUIRK_NO_DMA |
> +                           IO_PGTABLE_QUIRK_SYS_CACHE))
>                 return NULL;
>
>         data = arm_lpae_alloc_pgtable(cfg);
> @@ -779,9 +786,14 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
>                 return NULL;
>
>         /* TCR */
> -       reg = (ARM_LPAE_TCR_SH_IS << ARM_LPAE_TCR_SH0_SHIFT) |
> -             (ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_IRGN0_SHIFT) |
> -             (ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_ORGN0_SHIFT);
> +       if (cfg->quirks & IO_PGTABLE_QUIRK_SYS_CACHE) {
> +               reg = (ARM_LPAE_TCR_SH_OS << ARM_LPAE_TCR_SH0_SHIFT) |
> +                     (ARM_LPAE_TCR_RGN_NC << ARM_LPAE_TCR_IRGN0_SHIFT);

Contrary to the earlier code which favored IC/IS if possible, here we
seem to disable IC/IS if the SYS_CACHE quirk is requested, regardless
of whether it could still be desirable to use IC/IS. Perhaps rather
than
IO_PGTABLE_QUIRK_SYS_CACHE, we need something like
IO_PGTABLE_QUIRK_NO_INNER_CACHE?

> +       } else {
> +               reg = (ARM_LPAE_TCR_SH_IS << ARM_LPAE_TCR_SH0_SHIFT) |
> +                     (ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_IRGN0_SHIFT);
> +       }
> +       reg |= (ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_ORGN0_SHIFT);
>

[keeping the context]

Best regards,
Tomasz
