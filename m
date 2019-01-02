Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0186C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 06:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82E652089F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 06:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SvQy1Urm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbfABGns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 01:43:48 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45710 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbfABGns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 01:43:48 -0500
Received: by mail-qt1-f195.google.com with SMTP id e5so32526395qtr.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jan 2019 22:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hxsCIc2Rx1Ms2RCfEbVuhSTlGaapJ79FpT93F2PUHUc=;
        b=SvQy1UrmCX3e3pFfyZYNF4KHchd+78j1fnOyCirYwhiJ3L+feAsy2Bq1uCZWMTf5bI
         XgvUuchUGViu/X8xZ2qHCr+jEnKlCGGptMp7Kgwo+7X06/j6v1f8ntL7x4qCplwop8W2
         gi9PyZuKWf+0evskFQp31yDQgfsLAnA6PbPdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hxsCIc2Rx1Ms2RCfEbVuhSTlGaapJ79FpT93F2PUHUc=;
        b=bzb0svaigsc7q8yjfpYHKSuMIY5Z0MJfvSIc55iGAEjG6D7FI1MQ6/ESJa0LmF/Jyw
         TB2sTATXN5muCuaCEIGv3CEcSI1RD6j+p/WvyYXgJ7gOU1VLIt8M3H6wTSyMTwqRcqXT
         XtHSR2QNd1lubeZcsmI0tfTkddKva6DiwQwRVa4+HVcZUCW8o8vxrxcdQpQASRmZgbnn
         lf3Vcbo6cDvd2P12tMlerzFdtVeszC/tNuh+kAgqXG1BxhXEOg+RA5uivEA+0G5qHfAy
         LT2FriIRBq6tm0g1+qqrEfRX+1oz69VwuRemqtvfQeIQMWoxcc4cpplKzgU8o8YdATWE
         VBRg==
X-Gm-Message-State: AA+aEWbbjHguxtb2LYMaT1ZkJXi2J+LIx3+lWxcu78A8hokoECsA2qBN
        GV/INNKGIPQ2gRQVAuiGg4hCBgg2fzfLxcZ+LHdRrbval5rVUw==
X-Google-Smtp-Source: AFSGD/VAb2rds6gqac1p/cAm8YQZRcfR1Ll9MQSfNTLI8cmoQcEyhiYNaNgGS2jIKbd3Rv+8BIJZ4emvgGQwZtc7N3I=
X-Received: by 2002:ac8:6b50:: with SMTP id x16mr42237246qts.368.1546411426948;
 Tue, 01 Jan 2019 22:43:46 -0800 (PST)
MIME-Version: 1.0
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com> <1546314952-15990-11-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1546314952-15990-11-git-send-email-yong.wu@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Wed, 2 Jan 2019 14:43:36 +0800
Message-ID: <CANMq1KDK9r2-QWPfzaz_6pD70_XTE0Od3wTsDDZ0kOYJPJFEUQ@mail.gmail.com>
Subject: Re: [PATCH v5 10/20] iommu/mediatek: Move reset_axi into plat_data
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

On Tue, Jan 1, 2019 at 11:58 AM Yong Wu <yong.wu@mediatek.com> wrote:
>
> In mt8173 and mt8183, 0x48 is REG_MMU_STANDARD_AXI_MODE while
> it is extended to REG_MMU_CTRL which contains _STANDARD_AXI_MODE in
> the other SoCs. I move this property to plat_data since both mt8173
> and mt8183 use this property.
>
> It is a preparing patch for mt8183.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>

> ---
>  drivers/iommu/mtk_iommu.c | 4 ++--
>  drivers/iommu/mtk_iommu.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 35a1263..8d8ab21 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -558,8 +558,7 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
>         }
>         writel_relaxed(0, data->base + REG_MMU_DCM_DIS);
>
> -       /* It's MISC control register whose default value is ok except mt8173.*/
> -       if (data->plat_data->m4u_plat == M4U_MT8173)
> +       if (data->plat_data->reset_axi)
>                 writel_relaxed(0, data->base + REG_MMU_STANDARD_AXI_MODE);
>
>         if (devm_request_irq(data->dev, data->irq, mtk_iommu_isr, 0,
> @@ -749,6 +748,7 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
>         .m4u_plat     = M4U_MT8173,
>         .has_4gb_mode = true,
>         .has_bclk     = true,
> +       .reset_axi    = true,
>         .larbid_remap = {0, 1, 2, 3, 4, 5}, /* Linear mapping. */
>  };
>
> diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
> index eec19a6..b46aeaa 100644
> --- a/drivers/iommu/mtk_iommu.h
> +++ b/drivers/iommu/mtk_iommu.h
> @@ -47,7 +47,7 @@ struct mtk_iommu_plat_data {
>
>         /* HW will use the EMI clock if there isn't the "bclk". */
>         bool                has_bclk;
> -
> +       bool                reset_axi;
>         unsigned char       larbid_remap[MTK_LARB_NR_MAX];
>  };
>
> --
> 1.9.1
>
