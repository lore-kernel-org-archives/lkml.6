Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C6EC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 06:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3646E2171F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 06:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Kwid8MSj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbfABGXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 01:23:45 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46683 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727306AbfABGXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 01:23:45 -0500
Received: by mail-qk1-f194.google.com with SMTP id q1so17348340qkf.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jan 2019 22:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/G0LKOy+gkijPGJwFf7FcWEzIEjlTwQ0utpYDkzMgkU=;
        b=Kwid8MSjv1q+pcKqnHbHuudSdYWf4yp7F92p0vSfTXgIIsMkBGtF9WWOxT7b9vg9I4
         gEduaSUM9HQmIVmMqzBEQaOCwjKXL3SHQhZag7TL9YxVM8XRM5p2rn4AZf9IlUc3KZ/Y
         rMKQDCkhNK5beNQm2Nd2YTIwrOhtVdQrWqEY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/G0LKOy+gkijPGJwFf7FcWEzIEjlTwQ0utpYDkzMgkU=;
        b=ag9XbKCsBcuQp4ew0Yr6YT8AP47H2ZHCtYA5EInj2zeHCcsREyjbBkOolxbI4MXN8m
         /koDqT8IMI2gV0YdhMUALGnR1DcCXs6QS1IdWD+NKbRHkWtCA7YiS49UNshUZfPXmpXI
         SdOBA1SJplGoUXU3iyrGAhJln1TGlhT7rX0AW1kSi9j5rFcyc0SvMTTI4zPuUm7+JU11
         +RaQwuEHHzHDqotJM59kqLwsSyUXnMIrkP49yyDPSRiA8C78DYazY3ahNVh+mzvEVNon
         WYAxXypeRgFw+zY+xzcVG7S/J4jaP5pomhpcceZ2au77P4bwLS32UNfwtt2xbVMbUM5t
         6e9g==
X-Gm-Message-State: AJcUukd4c4bYEwV2EnU5r+E6AvReo8cQKT72rf8kpuTm37gmL2W3OHTS
        z9R1GWQ6RBkXrJhrQDEIGl0yAGOOEA9Kqwrff5Az2g==
X-Google-Smtp-Source: ALg8bN6iOLQBmZY1/ue0dPBwGkyTxirasUyalr0+9XkwPAuHZ7/7u3vwmtgKnybzaRzo5zxJBUILhyiC5cmAdwCBnpc=
X-Received: by 2002:a37:7885:: with SMTP id t127mr40448749qkc.323.1546410223419;
 Tue, 01 Jan 2019 22:23:43 -0800 (PST)
MIME-Version: 1.0
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com> <1546314952-15990-10-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1546314952-15990-10-git-send-email-yong.wu@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Wed, 2 Jan 2019 14:23:32 +0800
Message-ID: <CANMq1KC0zciUAtvcYoxfBOOMbGFu_Un031QemtuDopjWvwk3cw@mail.gmail.com>
Subject: Re: [PATCH v5 09/20] iommu/mediatek: Refine protect memory definition
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
> The protect memory setting is a little different in the different SoCs.
> In the register REG_MMU_CTRL_REG(0x110), the TF_PROT(translation fault
> protect) shift bit is normally 4 while it shift 5 bits only in the
> mt8173. This patch delete the complex MACRO and use a common if-else
> instead.
>
> Also, use "F_MMU_TF_PROT_TO_PROGRAM_ADDR" instead of the hard code(2)
> which means the M4U will output the dirty data to the programmed
> address that we allocated dynamically when translation fault occurs.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
> @Nicalos, I don't put it in the plat_data since only the previous mt8173
> shift 5. As I know, the latest SoC always use the new setting like mt2712
> and mt8183. Thus, I think it is unnecessary to put it in plat_data and
> let all the latest SoC set it. Hence, I still keep "== mt8173" for this
> like the reg REG_MMU_CTRL_REG.

Should be ok this way. But maybe one way to avoid hard-coding 4/5
below is to have 2 macros:

#define F_MMU_TF_PROT_TO_PROGRAM_ADDR (2 << 4)
#define F_MMU_TF_PROT_TO_PROGRAM_ADDR_MT8173 (2 << 5)

And still use the if below?

> ---
>  drivers/iommu/mtk_iommu.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index eca1536..35a1263 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -53,11 +53,7 @@
>
>  #define REG_MMU_CTRL_REG                       0x110
>  #define F_MMU_PREFETCH_RT_REPLACE_MOD          BIT(4)
> -#define F_MMU_TF_PROTECT_SEL_SHIFT(data) \
> -       ((data)->plat_data->m4u_plat == M4U_MT2712 ? 4 : 5)
> -/* It's named by F_MMU_TF_PROT_SEL in mt2712. */
> -#define F_MMU_TF_PROTECT_SEL(prot, data) \
> -       (((prot) & 0x3) << F_MMU_TF_PROTECT_SEL_SHIFT(data))
> +#define F_MMU_TF_PROT_TO_PROGRAM_ADDR          2
>
>  #define REG_MMU_IVRP_PADDR                     0x114
>
> @@ -521,9 +517,11 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
>                 return ret;
>         }
>
> -       regval = F_MMU_TF_PROTECT_SEL(2, data);
>         if (data->plat_data->m4u_plat == M4U_MT8173)
> -               regval |= F_MMU_PREFETCH_RT_REPLACE_MOD;
> +               regval = F_MMU_PREFETCH_RT_REPLACE_MOD |
> +                         (F_MMU_TF_PROT_TO_PROGRAM_ADDR << 5);
> +       else
> +               regval = F_MMU_TF_PROT_TO_PROGRAM_ADDR << 4;
>         writel_relaxed(regval, data->base + REG_MMU_CTRL_REG);
>
>         regval = F_L2_MULIT_HIT_EN |
> --
> 1.9.1
>
