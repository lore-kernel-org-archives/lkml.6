Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08FBDC282D9
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE28F2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SGUZF20T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733099AbfA3Sea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 13:34:30 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38707 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733063AbfA3Se3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 13:34:29 -0500
Received: by mail-lf1-f65.google.com with SMTP id a8so400326lfk.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 10:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E6oIusMF+iFLQKqeXCK/18P8bJ9F9HsbW/9Ihvp1RMY=;
        b=SGUZF20Tb1xKiJC2QZUA+j8QUBKvC5yQg65xBn31Dy2xE2in2dCL6hqUZQOxdpLG0P
         cPJ1VJxs2EIh9jacIMGYv+gI0RC+TM4jx/MqphWM0IfV/+efzWVawzweyj3ELA5XmfoK
         Bj4PR68aPpg6FEajxTcsHsq7W7OCLDRfbQOrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E6oIusMF+iFLQKqeXCK/18P8bJ9F9HsbW/9Ihvp1RMY=;
        b=IIBHWnP6IhtpooumJh6mdCF9kZWJkkEjh+FTJ+8J2F4sYuf48YthgW7EMulRvYUerV
         YAnN4KdPzDH1Dbar/PUOn6hc7cdJYxSlgNqodONO8XQZ9ZS2qHyN5edif9M8DGVLqe4q
         J5zHywoVUtoMn17pmDQMEPJ1BOFsZU6C6CQjpjNPF7NYYsGAk2SUssE+7cCsD51I8Vdk
         g8+/4LzGu5YrBS/xLkV/8HxCRPKNsKem64wRkFvFFosuTJg+Z2Pax1mAzaYSxJRwTaUj
         j6PqWtWHEMtSuG/AibZOTCejS6GsawpCwcM2llQaYaAPXfgzPLBQYN05/oeuiBBJ6Ijm
         B6gw==
X-Gm-Message-State: AJcUukc7GstnuE5meVW0IuxVI9DcdTsg4PlfEP9H9yI8ZtNoKW/OxirL
        5+hdQhpo08FLmzPmRk0Y9bEisTYiPr8=
X-Google-Smtp-Source: ALg8bN6TNEzYytUnP/6HDzSrdVNkGv7a/RIW4r+GlPHpgmDUMwJkp5OIw0YuLyrGkPA1FlXuU3z27g==
X-Received: by 2002:a19:4948:: with SMTP id l8mr14684534lfj.156.1548873267103;
        Wed, 30 Jan 2019 10:34:27 -0800 (PST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id z7-v6sm391349lji.42.2019.01.30.10.34.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 10:34:26 -0800 (PST)
Received: by mail-lj1-f182.google.com with SMTP id v15-v6so401184ljh.13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 10:34:26 -0800 (PST)
X-Received: by 2002:a2e:9715:: with SMTP id r21-v6mr25985526lji.30.1548872964434;
 Wed, 30 Jan 2019 10:29:24 -0800 (PST)
MIME-Version: 1.0
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com> <1546314952-15990-7-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1546314952-15990-7-git-send-email-yong.wu@mediatek.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 30 Jan 2019 10:28:47 -0800
X-Gmail-Original-Message-ID: <CAE=gft5bga+pM_7syKMnnma78xYN0HT4LaPPEftJ9DNqFf=zWw@mail.gmail.com>
Message-ID: <CAE=gft5bga+pM_7syKMnnma78xYN0HT4LaPPEftJ9DNqFf=zWw@mail.gmail.com>
Subject: Re: [PATCH v6 06/20] iommu/io-pgtable-arm-v7s: Extend MediaTek 4GB Mode
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tomasz Figa <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, Arnd Bergmann <arnd@arndb.de>,
        yingjoe.chen@mediatek.com, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 31, 2018 at 7:57 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> MediaTek extend the arm v7s descriptor to support the dram over 4GB.
>
> In the mt2712 and mt8173, it's called "4GB mode", the physical address
> is from 0x4000_0000 to 0x1_3fff_ffff, but from EMI point of view, it
> is remapped to high address from 0x1_0000_0000 to 0x1_ffff_ffff, the
> bit32 is always enabled. thus, in the M4U, we always enable the bit9
> for all PTEs which means to enable bit32 of physical address.

I got a little lost here. I get that you're trying to explain why you
always used to set bit32 of the physical address. But I don't totally
get the part about physical addresses being from 0x4000_0000 -
0x1_3fff_ffff, but also from 0x1_0000_0000-0x1_ffff_ffff. Are you
saying that the physical addresses from the iommu's perspective were
always >0x1_0000_0000? But then from whose perspective is it
0x4000_0000? ... oh, or you're saying there was some sort of remapping
facility that moved the physical addresses around?

>
> but in mt8183, M4U support the dram from 0x4000_0000 to 0x3_ffff_ffff
> which isn't remaped. We extend the PTEs: the bit9 represent bit32 of
> PA and the bit4 represent bit33 of PA. Meanwhile the iova still is
> 32bits.
>
> In order to unify code, in the "4GB mode", we add the bit32 for the
> physical address manually in our driver.
>
> Correspondingly, Adding bit32 and bit33 for the PA in the iova_to_phys
> has to been moved into v7s.
>
> Regarding whether the pagetable address could be over 4GB, the mt8183
> support it while the previous mt8173 don't. thus keep it as is.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/io-pgtable-arm-v7s.c | 31 ++++++++++++++++++++++++-------
>  drivers/iommu/io-pgtable.h         |  7 +++----
>  drivers/iommu/mtk_iommu.c          | 14 ++++++++------
>  drivers/iommu/mtk_iommu.h          |  1 +
>  4 files changed, 36 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
> index 11d8505..8803a35 100644
> --- a/drivers/iommu/io-pgtable-arm-v7s.c
> +++ b/drivers/iommu/io-pgtable-arm-v7s.c
> @@ -124,7 +124,9 @@
>  #define ARM_V7S_TEX_MASK               0x7
>  #define ARM_V7S_ATTR_TEX(val)          (((val) & ARM_V7S_TEX_MASK) << ARM_V7S_TEX_SHIFT)
>
> -#define ARM_V7S_ATTR_MTK_4GB           BIT(9) /* MTK extend it for 4GB mode */
> +/* MediaTek extend the two bits below for over 4GB mode */
> +#define ARM_V7S_ATTR_MTK_PA_BIT32      BIT(9)
> +#define ARM_V7S_ATTR_MTK_PA_BIT33      BIT(4)

If other vendors start doing stuff like this we'll need a more generic
way to handle this... but I guess until we see a pattern this is okay.

>
>  /* *well, except for TEX on level 2 large pages, of course :( */
>  #define ARM_V7S_CONT_PAGE_TEX_SHIFT    6
> @@ -183,13 +185,22 @@ static dma_addr_t __arm_v7s_dma_addr(void *pages)
>  static arm_v7s_iopte paddr_to_iopte(phys_addr_t paddr, int lvl,
>                                     struct io_pgtable_cfg *cfg)
>  {
> -       return paddr & ARM_V7S_LVL_MASK(lvl);
> +       arm_v7s_iopte pte = paddr & ARM_V7S_LVL_MASK(lvl);
> +
> +       if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_4GB) {
> +               if (paddr & BIT_ULL(32))
> +                       pte |= ARM_V7S_ATTR_MTK_PA_BIT32;
> +               if (paddr & BIT_ULL(33))
> +                       pte |= ARM_V7S_ATTR_MTK_PA_BIT33;
> +       }
> +       return pte;
>  }
>
>  static phys_addr_t iopte_to_paddr(arm_v7s_iopte pte, int lvl,
>                                   struct io_pgtable_cfg *cfg)
>  {
>         arm_v7s_iopte mask;
> +       phys_addr_t paddr;
>
>         if (ARM_V7S_PTE_IS_TABLE(pte, lvl))
>                 mask = ARM_V7S_TABLE_MASK;
> @@ -198,7 +209,14 @@ static phys_addr_t iopte_to_paddr(arm_v7s_iopte pte, int lvl,
>         else
>                 mask = ARM_V7S_LVL_MASK(lvl);
>
> -       return pte & mask;
> +       paddr = pte & mask;
> +       if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_4GB) {
> +               if (pte & ARM_V7S_ATTR_MTK_PA_BIT32)
> +                       paddr |= BIT_ULL(32);
> +               if (pte & ARM_V7S_ATTR_MTK_PA_BIT33)
> +                       paddr |= BIT_ULL(33);
> +       }
> +       return paddr;
>  }
>
>  static arm_v7s_iopte *iopte_deref(arm_v7s_iopte pte, int lvl,
> @@ -315,9 +333,6 @@ static arm_v7s_iopte arm_v7s_prot_to_pte(int prot, int lvl,
>         if (lvl == 1 && (cfg->quirks & IO_PGTABLE_QUIRK_ARM_NS))
>                 pte |= ARM_V7S_ATTR_NS_SECTION;
>
> -       if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_4GB)
> -               pte |= ARM_V7S_ATTR_MTK_4GB;
> -

So despite getting lost in the details, I guess the reason it's okay
that this goes from unconditional to conditional on bit32 is that
before, with the older chips, all physical addresses were above 4GB,
so we'll always see PA's above 4GB?

>         return pte;
>  }
>
> @@ -504,7 +519,9 @@ static int arm_v7s_map(struct io_pgtable_ops *ops, unsigned long iova,
>         if (!(prot & (IOMMU_READ | IOMMU_WRITE)))
>                 return 0;
>
> -       if (WARN_ON(upper_32_bits(iova) || upper_32_bits(paddr)))
> +       if (WARN_ON(upper_32_bits(iova)) ||
> +           WARN_ON(upper_32_bits(paddr) &&
> +                   !(iop->cfg.quirks & IO_PGTABLE_QUIRK_ARM_MTK_4GB)))
>                 return -ERANGE;
>
>         ret = __arm_v7s_map(data, iova, paddr, size, prot, 1, data->pgd);
> diff --git a/drivers/iommu/io-pgtable.h b/drivers/iommu/io-pgtable.h
> index 47d5ae5..69db115 100644
> --- a/drivers/iommu/io-pgtable.h
> +++ b/drivers/iommu/io-pgtable.h
> @@ -62,10 +62,9 @@ struct io_pgtable_cfg {
>          *      (unmapped) entries but the hardware might do so anyway, perform
>          *      TLB maintenance when mapping as well as when unmapping.
>          *
> -        * IO_PGTABLE_QUIRK_ARM_MTK_4GB: (ARM v7s format) Set bit 9 in all
> -        *      PTEs, for Mediatek IOMMUs which treat it as a 33rd address bit
> -        *      when the SoC is in "4GB mode" and they can only access the high
> -        *      remap of DRAM (0x1_00000000 to 0x1_ffffffff).
> +        * IO_PGTABLE_QUIRK_ARM_MTK_4GB: (ARM v7s format) MediaTek IOMMUs extend
> +        *      to support up to 34 bits PA where the bit32 and bit33 are
> +        *      encoded in the bit9 and bit4 of the PTE respectively.
>          *
>          * IO_PGTABLE_QUIRK_NO_DMA: Guarantees that the tables will only ever
>          *      be accessed by a fully cache-coherent IOMMU or CPU (e.g. for a
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 189d1b5..ae1aa5a 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -367,12 +367,16 @@ static int mtk_iommu_map(struct iommu_domain *domain, unsigned long iova,
>                          phys_addr_t paddr, size_t size, int prot)
>  {
>         struct mtk_iommu_domain *dom = to_mtk_domain(domain);
> +       struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
>         unsigned long flags;
>         int ret;
>
> +       /* The "4GB mode" M4U physically can not use the lower remap of Dram. */
> +       if (data->plat_data->has_4gb_mode && data->enable_4GB)
> +               paddr |= BIT_ULL(32);
> +

Ok here's where I get lost. How is this okay? Is the same physical RAM
accessible at multiple locations in the physical address space? Won't
this map an iova to a different pa than the one requested?

Also, you could have rolled the has_4gb_mode check into whether or not
you set enable_4GB. Then you're doing the check for has_4gb_mode once,
rather than on every map call.
-Evan
