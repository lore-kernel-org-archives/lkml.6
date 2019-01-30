Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31067C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09F8B20869
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oTw/lUF+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733215AbfA3ShD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 13:37:03 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39340 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733103AbfA3ShC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 13:37:02 -0500
Received: by mail-lj1-f193.google.com with SMTP id t9-v6so464249ljh.6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 10:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MFK9fDVCrEcW9cs9+Bfj5Lsq8+kacWpOw55FKDAtOqA=;
        b=oTw/lUF+PWcmdEgfJkpPInfa7/Ud8w+AfErgLPp4kH5d8qa3YNJlp0M15NucGPRgie
         GTw35zC/YffKZksIyOKzBUG6tvPXikLfco6y5vLiYNg3d3lJf3MPp7iehgsnNVpj/U5K
         BCiBSfatvjS8fIY6WXlgcozotQw0fUOQFzmaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MFK9fDVCrEcW9cs9+Bfj5Lsq8+kacWpOw55FKDAtOqA=;
        b=WHs5XOJojmhd/7xeXSZ2jPUHGmDmB6Z7Xnt7ad5O7ax9vRgqTiXe5kZdsTbe/OR7vN
         XbOAtDzZW5rr/mzGjUIEJuUXm6ygm0mTQ9tWCjdQubPOMbKuUmPn/z19KNpxD/1aAa8P
         iI2fsUR5h40p/hUKD8GJRtnBxTwrhg3teWwF1+c0GqMittD+9xt9owtS5kNQPMMEmc8x
         d52j8EIumZqew4Qj9S8eJ0H3pmEYgCXqMNmybU0DKB+aQlddrEAproPsam93ZZzdmfG+
         u1qXSXnl9BC6vN4Kto0NQKDfiCYFSPX1BPuCkdEXmHuRrAPcjxCniC67gWZx8geRu3If
         xhKw==
X-Gm-Message-State: AJcUukffe2CA0TXQzCGMpORL/4fOxrLbZJ1IAUJ7UaOARH/J1rKNrAjf
        uGy0oSyh1/v11300H7DVanDflR0mqBM=
X-Google-Smtp-Source: ALg8bN6JMwbDybzj6cH13w3Tbhy9WYCsBlLyrOI0SXQnv9np/hlwOSE9SPnSGHZo9lZ93c8aNuvO5Q==
X-Received: by 2002:a2e:880a:: with SMTP id x10-v6mr26914544ljh.174.1548873420385;
        Wed, 30 Jan 2019 10:37:00 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id m63-v6sm442063lje.81.2019.01.30.10.36.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 10:36:59 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id v15-v6so407474ljh.13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 10:36:59 -0800 (PST)
X-Received: by 2002:a2e:9715:: with SMTP id r21-v6mr25990512lji.30.1548873076878;
 Wed, 30 Jan 2019 10:31:16 -0800 (PST)
MIME-Version: 1.0
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com> <1546314952-15990-12-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1546314952-15990-12-git-send-email-yong.wu@mediatek.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 30 Jan 2019 10:30:39 -0800
X-Gmail-Original-Message-ID: <CAE=gft4=4h_1MAnrC8CosSe3gOWx+DwFJSLvGNtOFNMZN8oZ3w@mail.gmail.com>
Message-ID: <CAE=gft4=4h_1MAnrC8CosSe3gOWx+DwFJSLvGNtOFNMZN8oZ3w@mail.gmail.com>
Subject: Re: [PATCH v5 11/20] iommu/mediatek: Move vld_pa_rng into plat_data
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
> Both mt8173 and mt8183 don't have this vld_pa_rng(valid physical address
> range) register while mt2712 have. Move it into the plat_data.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/iommu/mtk_iommu.c | 3 ++-
>  drivers/iommu/mtk_iommu.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 8d8ab21..2913ddb 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -548,7 +548,7 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
>                          upper_32_bits(data->protect_base);
>         writel_relaxed(regval, data->base + REG_MMU_IVRP_PADDR);
>
> -       if (data->enable_4GB && data->plat_data->m4u_plat != M4U_MT8173) {
> +       if (data->enable_4GB && data->plat_data->vld_pa_rng) {
>                 /*
>                  * If 4GB mode is enabled, the validate PA range is from
>                  * 0x1_0000_0000 to 0x1_ffff_ffff. here record bit[32:30].
> @@ -741,6 +741,7 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
>         .m4u_plat     = M4U_MT2712,
>         .has_4gb_mode = true,
>         .has_bclk     = true,
> +       .vld_pa_rng   = true,
>         .larbid_remap = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9},
>  };
>
> diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
> index b46aeaa..a8c5d1e 100644
> --- a/drivers/iommu/mtk_iommu.h
> +++ b/drivers/iommu/mtk_iommu.h
> @@ -48,6 +48,7 @@ struct mtk_iommu_plat_data {
>         /* HW will use the EMI clock if there isn't the "bclk". */
>         bool                has_bclk;
>         bool                reset_axi;
> +       bool                vld_pa_rng;

I agree with Nicolas that valid_pa_range would be much clearer...
although, even now that I know what it's supposed to mean, I don't get
what it represents. What is this saying?

-Evan
