Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F29C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D08020869
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Sg/1LAlp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733232AbfA3ShJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 13:37:09 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41794 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733221AbfA3ShI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 13:37:08 -0500
Received: by mail-lj1-f193.google.com with SMTP id k15-v6so447530ljc.8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 10:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xVAhcBnT4pyU9hfS17+pqFPt/MfKXdwkrExkLukGrKw=;
        b=Sg/1LAlpcV3YwX9KeMC1DS+dGRdVswUBWA9ft43mbvFV883HZ0jV2tbBDjIVhr2w6B
         HiL+XjWY/ccQKqZn0qFj4HiYPL3o+xAf9vWTalhnNYLUfhGzHMhcnSAS1C7UJOSNa8zF
         1hLD/3B45QNEHe9LC+Zj6hjcc9J5k5J779xKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xVAhcBnT4pyU9hfS17+pqFPt/MfKXdwkrExkLukGrKw=;
        b=OvMbnTwCM2nssE4+kRt8k4jidJmjovj1l1NSU0PNg+G1K4Avyaq35Q+GK8CdxFqCnI
         b7bzOUythKX5BtvOAK/NNXBxag8OjDZ0BLcKeKWdRvEZ+OIk/w/JqGdDdpf1or1yKJS5
         2EQj69fMlUoe/BBB3k5HufeD6yNxrLTEi6FOovyPGUl4orA4/sXfo8PGIBlPSBnb4Pav
         lj1gfNhf7o2uAaq/U7HpwS1EYtTA13DAma8cv2m9ps2q5M+usL1OgHjP7on6mEUtNFkd
         eUwx2fbtmiDVOVGsCLEj0AwReGdonC0ZxdGjz/T/yySPhuniHq7JaBZm/JyK31Ir+xzU
         IUuA==
X-Gm-Message-State: AJcUukeU5pyV88VQL9PBCloLvdUZbBz39GDqS25AbtfzqQLBJ5MadXDW
        RID3fb3MKn9Ws9z+YyqfTFWHQ/7ZBDs=
X-Google-Smtp-Source: ALg8bN7tvLIF67ow0bkaPJ+N586cIzXi/Hgxf4/hOsoEIuzrQc3xywgaXJzHr0JFQzfBzxEvjuWgow==
X-Received: by 2002:a2e:8808:: with SMTP id x8-v6mr24693958ljh.190.1548873426221;
        Wed, 30 Jan 2019 10:37:06 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id m10-v6sm398220ljj.34.2019.01.30.10.37.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 10:37:06 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id v15-v6so407732ljh.13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 10:37:06 -0800 (PST)
X-Received: by 2002:a2e:6109:: with SMTP id v9-v6mr24506538ljb.126.1548873054750;
 Wed, 30 Jan 2019 10:30:54 -0800 (PST)
MIME-Version: 1.0
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com> <1546314952-15990-11-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1546314952-15990-11-git-send-email-yong.wu@mediatek.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 30 Jan 2019 10:30:18 -0800
X-Gmail-Original-Message-ID: <CAE=gft72KfZ9RdDTJeEpQJ7h3_cOXzm1YRQG-U47s64QVOhabA@mail.gmail.com>
Message-ID: <CAE=gft72KfZ9RdDTJeEpQJ7h3_cOXzm1YRQG-U47s64QVOhabA@mail.gmail.com>
Subject: Re: [PATCH v5 10/20] iommu/mediatek: Move reset_axi into plat_data
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
> In mt8173 and mt8183, 0x48 is REG_MMU_STANDARD_AXI_MODE while
> it is extended to REG_MMU_CTRL which contains _STANDARD_AXI_MODE in
> the other SoCs. I move this property to plat_data since both mt8173
> and mt8183 use this property.
>
> It is a preparing patch for mt8183.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
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

The commit description makes it sound like the overall format of the
register is the same, but the "other SoCs" have some extra bits they'd
like to leave alone. Would it be easier to do a read-modify-write to
always clear some bits in the register, instead of doing something
based on the SoC? Or do the bits mean completely different things in
the different versions (in which case what you've got makes sense to
me)?
-Evan
