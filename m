Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0673C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 06:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C80421871
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 06:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gzL4g9nD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbfABGyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 01:54:22 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39008 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727834AbfABGyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 01:54:22 -0500
Received: by mail-qt1-f193.google.com with SMTP id u47so27968919qtj.6
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jan 2019 22:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ip8/SWgSo5UCVMc09lG/mRV3/rvBHR6BxLBivxzsv4g=;
        b=gzL4g9nDiolo7xKtSXGwOBsS3KFom7nTZaj3UQf3Pwct3mH3w4gw0Am7qKs7/qLOB/
         qwcyFonUxVDqlkYIoKwzPtAbEcFLdlcxcvFGWbh8+dMLIw1WT9nlY+JmlyvQb6ObyAUK
         wfquMC/ndnLxZMHBtKybHr2Y+MkPFJxxvxyUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ip8/SWgSo5UCVMc09lG/mRV3/rvBHR6BxLBivxzsv4g=;
        b=T0UxPYAokS6G2IkkrK+/keDAPlBQDDtFiuwUvaSYtM/IFc9V9jKlFnqD4yXA5TXoj8
         L4DP0vRa+E3v6zXicokfbYuqNISFUGrShyEVt+tMkNcV3U7nnLbbvyGKVySuabeXledx
         d1eV3io3j+7kHgK5TJaxTsVb7CM8/RCahtEw5EWy7/h24bONE7AX9PdP0pJhhPG5A5Ge
         kV6PU6Y2myCsKoRwR0fR5tvXNXFPC6CTve9HAll8ZqcGo0YwYaCrpr3TlfmnpqYIQyHV
         NeQCaQL5vboeLhyCoBWvdANvkWjeOmvcjeoWjLSTXN2foIJ/elVO4tzZ5msFjTv1/UI7
         +Kcg==
X-Gm-Message-State: AJcUukfwWnxEchouaBYIar2I+xg4E/1iGf+Mvj9bRs4For/hJtuO1w+Z
        18mdHUZpoaD3j/RAS2aQaXU9uZgzMKwUW6dtWHv1Zw==
X-Google-Smtp-Source: ALg8bN75WFVA+pR4as9+dTvFsiDbi5FhbIGMXi89qH/cRfg4a0UjzmWL6uLucnOGLiEmcW33zYpvopfv95oL5M7+rl4=
X-Received: by 2002:a0c:8425:: with SMTP id l34mr42318055qva.101.1546412059811;
 Tue, 01 Jan 2019 22:54:19 -0800 (PST)
MIME-Version: 1.0
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com> <1546314952-15990-19-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1546314952-15990-19-git-send-email-yong.wu@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Wed, 2 Jan 2019 14:54:09 +0800
Message-ID: <CANMq1KDnduh+X30GzNgTb7Q3Dace8O4uNAzeULTgBRUdEsp_XA@mail.gmail.com>
Subject: Re: [PATCH v5 18/20] iommu/mediatek: Fix VLD_PA_RANGE register backup
 when suspend
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tomasz Figa <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        iommu@lists.linux-foundation.org, Arnd Bergmann <arnd@arndb.de>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        youlin.pei@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 1, 2019 at 11:59 AM Yong Wu <yong.wu@mediatek.com> wrote:
>
> The register VLD_PA_RNG(0x118) was forgot to backup while adding 4GB
> mode support for mt2712. this patch add it.
>
> Fixes: 30e2fccf9512 ("iommu/mediatek: Enlarge the validate PA range
> for 4GB mode")
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/iommu/mtk_iommu.c | 2 ++
>  drivers/iommu/mtk_iommu.h | 1 +
>  2 files changed, 3 insertions(+)
>
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 7fcef19..ddf1969 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -716,6 +716,7 @@ static int __maybe_unused mtk_iommu_suspend(struct device *dev)
>         reg->int_control0 = readl_relaxed(base + REG_MMU_INT_CONTROL0);
>         reg->int_main_control = readl_relaxed(base + REG_MMU_INT_MAIN_CONTROL);
>         reg->ivrp_paddr = readl_relaxed(base + REG_MMU_IVRP_PADDR);
> +       reg->vld_pa_range = readl_relaxed(base + REG_MMU_VLD_PA_RNG);

Don't we want to add:
if (data->plat_data->vld_pa_rng)
before this save/restore operation? Or it doesn't matter?

>         clk_disable_unprepare(data->bclk);
>         return 0;
>  }
> @@ -740,6 +741,7 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
>         writel_relaxed(reg->int_control0, base + REG_MMU_INT_CONTROL0);
>         writel_relaxed(reg->int_main_control, base + REG_MMU_INT_MAIN_CONTROL);
>         writel_relaxed(reg->ivrp_paddr, base + REG_MMU_IVRP_PADDR);
> +       writel_relaxed(reg->vld_pa_range, base + REG_MMU_VLD_PA_RNG);
>         if (m4u_dom)
>                 writel(m4u_dom->cfg.arm_v7s_cfg.ttbr[0] & MMU_PT_ADDR_MASK,
>                        base + REG_MMU_PT_BASE_ADDR);
> diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
> index 0a7c463..c500bfd 100644
> --- a/drivers/iommu/mtk_iommu.h
> +++ b/drivers/iommu/mtk_iommu.h
> @@ -33,6 +33,7 @@ struct mtk_iommu_suspend_reg {
>         u32                             int_control0;
>         u32                             int_main_control;
>         u32                             ivrp_paddr;
> +       u32                             vld_pa_range;

Well, please be consistent ,-) Either vld_pa_rng, or valid_pa_range ,-)

>  };
>
>  enum mtk_iommu_plat {
> --
> 1.9.1
>
