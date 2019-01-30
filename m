Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2087C282D9
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73E572087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mQC2KzBy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733191AbfA3Sgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 13:36:45 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40967 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733094AbfA3Sgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 13:36:44 -0500
Received: by mail-lf1-f65.google.com with SMTP id c16so391670lfj.8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 10:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1e0nHX9Wr1oeqbeRBnTvuV8S/9zyEhNvko7O1JoesYs=;
        b=mQC2KzBypqrIbtKDzJzKS9MEhzEcGJxb4W/HQQYlgVp3aOAmgTL0xGekyrw+Tz3V7p
         JrDLEBOzpnX+G8RWr8e0xlBBCPzwHg56c/wYJ5/t2JQS1JyECzyWgZ/s/HRc1XAMvgAs
         EPahZKWuoBX3Me59vXJy6MeJnSlAuEu/IrGto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1e0nHX9Wr1oeqbeRBnTvuV8S/9zyEhNvko7O1JoesYs=;
        b=JGaG9Axyi/WKSfYtAr8bMgUl2Vyf0G71KhsbcpEMzo8IqxcqQU40cLk4Bsy/SpAiOH
         I5nrT/UEDmFAWGyCP2T9vNTokmdmBMlq9LLlVK3ueJofGcpO1gvni8JOcFykwzg1NKnI
         xkTXoaWDLi1ax3Mz9GhxWAw2O1Z1EqRmAlhSmlo/lphSFphw9NcOvEFElqTwDZG2zeIj
         utmyvF5uOcAviRL7kJ+xfu+3v+kh1+z9dUepBnhJn9i0V3QxMjRol/SEbJMEvcp5qEjV
         1AL6QFK43q7MAM+8gvFNJSYco4QhY8V9QJsEAwsNlKKYcjPYsNOaB9qoTeV0lrJAd0LK
         4fMA==
X-Gm-Message-State: AJcUukdVXzrFgPEVFkM2XuUt1xubBvjgsSjj45Uy3265Cmz4tMH1zciA
        3TfYU1y/uPQ4mYIVAnDmbEP5MvEzCRo=
X-Google-Smtp-Source: ALg8bN7QCS5knVLkHXocim/ZQRZ/O3zHikyMKX1aOPW1ut/jLVapr+XHtqPwLkRULQ7a/VL/Z7zcUg==
X-Received: by 2002:a19:6514:: with SMTP id z20mr16542288lfb.31.1548873401715;
        Wed, 30 Jan 2019 10:36:41 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id f29sm417979lfa.46.2019.01.30.10.36.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 10:36:41 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id c16so391633lfj.8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 10:36:41 -0800 (PST)
X-Received: by 2002:a19:7352:: with SMTP id o79mr25476428lfc.104.1548873009496;
 Wed, 30 Jan 2019 10:30:09 -0800 (PST)
MIME-Version: 1.0
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com> <1546314952-15990-9-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1546314952-15990-9-git-send-email-yong.wu@mediatek.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 30 Jan 2019 10:29:33 -0800
X-Gmail-Original-Message-ID: <CAE=gft7FOfqJir8n6wGvOcs0pdxtuvmd9jonHwD4Q_1Q8wM5oQ@mail.gmail.com>
Message-ID: <CAE=gft7FOfqJir8n6wGvOcs0pdxtuvmd9jonHwD4Q_1Q8wM5oQ@mail.gmail.com>
Subject: Re: [PATCH v5 08/20] iommu/mediatek: Add larb-id remapped support
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
> The larb-id may be remapped in the smi-common, this means the
> larb-id reported in the mtk_iommu_isr isn't the real larb-id,
>
> Take mt8183 as a example:
>                        M4U
>                         |
> ---------------------------------------------
> |               SMI common                  |
> -0-----7-----5-----6-----1-----2------3-----4- <- Id remapped
>  |     |     |     |     |     |      |     |
> larb0 larb1 IPU0  IPU1 larb4 larb5  larb6  CCU
> disp  vdec  img   cam   venc  img    cam
> As above, larb0 connects with the id 0 in smi-common.
>           larb1 connects with the id 7 in smi-common.
>           ...
> If the larb-id reported in the isr is 7, actually it's larb1(vdec).
> In order to output the right larb-id in the isr, we add a larb-id
> remapping relationship in this patch.
>
> If there is no this larb-id remapping in some SoCs, use the linear
> mapping array instead.
>
> This also is a preparing patch for mt8183.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/iommu/mtk_iommu.c | 4 ++++
>  drivers/iommu/mtk_iommu.h | 2 ++
>  2 files changed, 6 insertions(+)
>
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 847082c..eca1536 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -220,6 +220,8 @@ static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
>         fault_larb = F_MMU0_INT_ID_LARB_ID(regval);
>         fault_port = F_MMU0_INT_ID_PORT_ID(regval);
>
> +       fault_larb = data->plat_data->larbid_remap[fault_larb];
> +
>         if (report_iommu_fault(&dom->domain, data->dev, fault_iova,
>                                write ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ)) {
>                 dev_err_ratelimited(
> @@ -742,12 +744,14 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
>         .m4u_plat     = M4U_MT2712,
>         .has_4gb_mode = true,
>         .has_bclk     = true,
> +       .larbid_remap = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9},
>  };
>
>  static const struct mtk_iommu_plat_data mt8173_data = {
>         .m4u_plat     = M4U_MT8173,
>         .has_4gb_mode = true,
>         .has_bclk     = true,
> +       .larbid_remap = {0, 1, 2, 3, 4, 5}, /* Linear mapping. */

I briefly considered bikeshedding about how to define these arrays in
a way that might save memory for linear-map devices, but then decided
this is fine.

Reviewed-by: Evan Green <evgreen@chromium.org>
