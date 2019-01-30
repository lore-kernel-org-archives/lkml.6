Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56F1C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89DF120989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UKdQOyNv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387397AbfA3Sz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 13:55:56 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46123 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728446AbfA3Szz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 13:55:55 -0500
Received: by mail-lj1-f195.google.com with SMTP id v15-v6so455434ljh.13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 10:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RDw5sWCs3kR4DAIs/UO/8X+8choKwOZ5wTyIJOu2aRs=;
        b=UKdQOyNvx/BWDWSTNPC6tCnq5oeqeUJiU+8c1WMG5VPWiNVOZC3xob/9/lTjsb931f
         +ByBZtzXD6pRNIJ/Q8XS90VMonipSiLwqgvq1+UJ3AeHowdf/7G0U+7uZZut/QLelldH
         nn2AIwgWxdIPm1lA1Uj/aMmybZkOLbE2hYYIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RDw5sWCs3kR4DAIs/UO/8X+8choKwOZ5wTyIJOu2aRs=;
        b=IIlohve8bm8KKwRx4gMCcRuYHg2MPxVemYTD7yrP8LIEwgl4TWu2FsGqoD5B9cRbs6
         5dIIb6fmVyPjRik+6yd7UWNbc2XeXCQtO4YFFtbOM5ej6LciPy0kTs+SegLAI3qKARgi
         xtOqxFiBEEW6hIPGAGdQTme5hTZGXth1zQiFYRyx//OcZ54FGKsck0w76cNvbzHeikqi
         C6sb7q2IJkkhWuvlN9Mpxm7LIJIqTC/tgJNpohTHsu6so/Sxs+BTHOcrfeHSHr2hzwoQ
         GPe5u4UI7VuGcr7B8Y7c4ly+HaswGXZ/hf4xcj1/Wf5t/sqYboP3L+aGYrm19p4udsDf
         ychQ==
X-Gm-Message-State: AHQUAubOpkT6K1Z1zdRPRTpmajUaOOnR6fy3E99s8NZFaYEOIrkl3fUZ
        DSL6rVmu2ooVm+IY0/3T6ZcFcQ7BriQ=
X-Google-Smtp-Source: AHgI3IbYAr1VbPP8YXQwXTqnJCR4b4GYXHPkY7U1+bcgRAGlhHeEDx+4WdpiABzteaGCaXfvkUbNRA==
X-Received: by 2002:a2e:3308:: with SMTP id d8-v6mr9611280ljc.38.1548874553001;
        Wed, 30 Jan 2019 10:55:53 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id y131sm415979lfc.43.2019.01.30.10.55.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 10:55:52 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id t18-v6so529526ljd.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 10:55:52 -0800 (PST)
X-Received: by 2002:a2e:7011:: with SMTP id l17-v6mr24947251ljc.147.1548873036569;
 Wed, 30 Jan 2019 10:30:36 -0800 (PST)
MIME-Version: 1.0
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com> <1546314952-15990-10-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1546314952-15990-10-git-send-email-yong.wu@mediatek.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 30 Jan 2019 10:30:00 -0800
X-Gmail-Original-Message-ID: <CAE=gft7TnvSDskOmeXp4Z-D45uwOfwyiJo0CYY=Q93NR0PvRnA@mail.gmail.com>
Message-ID: <CAE=gft7TnvSDskOmeXp4Z-D45uwOfwyiJo0CYY=Q93NR0PvRnA@mail.gmail.com>
Subject: Re: [PATCH v5 09/20] iommu/mediatek: Refine protect memory definition
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

On Mon, Dec 31, 2018 at 7:58 PM Yong Wu <yong.wu@mediatek.com> wrote:
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

I agree with Nicolas with regard to not having the random 4 and 5
sprinkled in the function.
-Evan
