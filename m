Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48899C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1183621479
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mHIkL2Fl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729927AbfBSXlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 18:41:52 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37512 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727375AbfBSXlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 18:41:52 -0500
Received: by mail-lj1-f194.google.com with SMTP id a17so2837180ljd.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 15:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5hFiQkH7MQb4ozKg9YqmIfOGeIDqr9uI8jWHvthlU/Y=;
        b=mHIkL2Fl+PCYoE9pu/GNaMDbvrszSlgA63D2KX8jJ5CdwdADGYB8Fa6IPa7LVoeACm
         RT4Hgkltbv2dAxzfWCk8Zq1vzjMDjYbXyLjMjLM3zG2HsVfEVrg37RfjaBOr/uQB9jgz
         LvD9vVvlNE9VqRX5VpeEMczMCtledhJCn9bnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5hFiQkH7MQb4ozKg9YqmIfOGeIDqr9uI8jWHvthlU/Y=;
        b=GWy2mtykyJjRDse1+dROenZoOJTHbr0ruTsQi0y/dqFCEohIAhyY+m+JzXxwn75fNx
         pCmz7Qi8xmPB37HtGk3YQHar7lPYKIlbcYQq1UH6bA7JNHq9s97KRie6q2gYzfEFbhSu
         jNA+DArfGCj20KWfLDEUJ0OJ3EA2ciJWSZMGuTwVyAUPHa+hCq97cFFLsgW6Yo75MM1O
         bN8WOH2G5b+vaIbhJixyu5USDV9+OulqCth9Lm98hF20tnXj8dKLnvCYc7PLvTTpCNDy
         iG0wMAESsX9Q4rN+xkpEq97VYWHyF5GnxKrgQVxDe5EG1M1DGApAoxWA3ktvGlcu5Uwh
         YF5Q==
X-Gm-Message-State: AHQUAuaASL1qxi57z8wUByOjfjzYSFZunDgiQsnXHZ1vwI/+/wfKldnv
        qM8k+oeRds0NGfx8q0IuBOBntjossZ8=
X-Google-Smtp-Source: AHgI3IYO59GFsm7qOiEZ2Lyn1CZyNA7jRMm95x/xGmZlM2NckGPNxRpuxAO4nd02Zm7Is8ZNveFwjw==
X-Received: by 2002:a2e:e02:: with SMTP id 2-v6mr15258724ljo.10.1550619709813;
        Tue, 19 Feb 2019 15:41:49 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id j14sm4964468lfc.28.2019.02.19.15.41.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 15:41:49 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id v7so16176575lfd.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 15:41:49 -0800 (PST)
X-Received: by 2002:ac2:4191:: with SMTP id z17mr18126203lfh.117.1550619229104;
 Tue, 19 Feb 2019 15:33:49 -0800 (PST)
MIME-Version: 1.0
References: <1550394300-17420-1-git-send-email-yong.wu@mediatek.com> <1550394300-17420-22-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1550394300-17420-22-git-send-email-yong.wu@mediatek.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 19 Feb 2019 15:33:12 -0800
X-Gmail-Original-Message-ID: <CAE=gft783rOUubODiFHxa9NKeUJxGk4FCeguDsyoqrUxsGDEsQ@mail.gmail.com>
Message-ID: <CAE=gft783rOUubODiFHxa9NKeUJxGk4FCeguDsyoqrUxsGDEsQ@mail.gmail.com>
Subject: Re: [PATCH v6 21/22] iommu/mediatek: Fix iova_to_phys PA start for
 4GB mode
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
        iommu@lists.linux-foundation.org, yingjoe.chen@mediatek.com,
        youlin.pei@mediatek.com, Nicolas Boichat <drinkcat@chromium.org>,
        anan.sun@mediatek.com, Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 17, 2019 at 1:09 AM Yong Wu <yong.wu@mediatek.com> wrote:
>
> In the 4GB mode, the physical address is remapped,
>
> Here is the detailed remap relationship.
> CPU PA         ->    HW PA
> 0x4000_0000          0x1_4000_0000 (Add bit32)
> 0x8000_0000          0x1_8000_0000 ...
> 0xc000_0000          0x1_c000_0000 ...
> 0x1_0000_0000        0x1_0000_0000 (No change)
>
> Thus, we always add bit32 for PA when entering mtk_iommu_map.
> But in the iova_to_phys, the CPU don't need this bit32 if the
> PA is from 0x1_4000_0000 to 0x1_ffff_ffff.
> This patch discards the bit32 in this iova_to_phys in the 4GB mode.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/iommu/mtk_iommu.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 0277396..076d333 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -119,6 +119,19 @@ struct mtk_iommu_domain {
>
>  static const struct iommu_ops mtk_iommu_ops;
>
> +/*
> + * In M4U 4GB mode, the physical address is remapped as below:
> + *  CPU PA         ->   M4U HW PA
> + *  0x4000_0000         0x1_4000_0000 (Add bit32)
> + *  0x8000_0000         0x1_8000_0000 ...
> + *  0xc000_0000         0x1_c000_0000 ...
> + *  0x1_0000_0000       0x1_0000_0000 (No change)
> + *
> + * Thus, We always add BIT32 in the iommu_map and disable BIT32 if PA is >=
> + * 0x1_4000_0000 in the iova_to_phys.
> + */
> +#define MTK_IOMMU_4GB_MODE_PA_140000000     0x140000000UL
> +
>  static LIST_HEAD(m4ulist);     /* List all the M4U HWs */
>
>  #define for_each_m4u(data)     list_for_each_entry(data, &m4ulist, list)
> @@ -415,6 +428,7 @@ static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
>                                           dma_addr_t iova)
>  {
>         struct mtk_iommu_domain *dom = to_mtk_domain(domain);
> +       struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
>         unsigned long flags;
>         phys_addr_t pa;
>
> @@ -422,6 +436,10 @@ static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
>         pa = dom->iop->iova_to_phys(dom->iop, iova);
>         spin_unlock_irqrestore(&dom->pgtlock, flags);
>
> +       if (data->plat_data->has_4gb_mode && data->dram_is_4gb &&
> +           pa >= MTK_IOMMU_4GB_MODE_PA_140000000)
> +               pa &= ~BIT_ULL(32);
> +

The define doesn't really make it much better, but I guess it doesn't
make it worse either. As I was reviewing this I was thinking that this
should be rolled into patch 6 "iommu/io-pgtable-arm-v7s: Extend
MediaTek 4GB Mode". But I guess this was returning bad PAs since
before this series, right? So does this need a Fixes tag?
-Evan
