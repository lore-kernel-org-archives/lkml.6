Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16915C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 03:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D435E21903
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 03:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OYmVann3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390906AbeLUDgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 22:36:04 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44399 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388947AbeLUDgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 22:36:04 -0500
Received: by mail-qt1-f194.google.com with SMTP id n32so4261277qte.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 19:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1YKu3l2W2tnjwEusBHKXK1YRzv6cTe2O21eT23+mEyU=;
        b=OYmVann3ocxoEst0RrE5++bYdAiYd1ZyviOS/oRcs3l1x+M0+pga7amLk2552x5uXa
         pSvHdvGPYIJpj4XDkyUz9qmyY0tHI7Q11yC66OLNwyPfP17ZGIj/S0zJa4MFKkc1DIXY
         uA0B2vJx4V4oYWqBcKds2EI3AfZss7ktv1Cz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1YKu3l2W2tnjwEusBHKXK1YRzv6cTe2O21eT23+mEyU=;
        b=FIM3Pwhr7gAlmh7XviVeWGUXJh29tes9eCtqQZI0lBIgp/Ce3WaUL1i4qARaEZAUCM
         o2jK0gFPhYydP5pKflrbHmOOoo2cX6twKeyQEI03f+nsP+9W93xjvEn7v1RZXpTydfJc
         Z7fKj/paM1OrCX/EO83IOBm1zZn/vyHlBbuRXSWj2oEWGJI50XUqucL4rHJ3phCn9n0c
         eL0E28rbX6ICtXvLSOunOzClB4uCvnYSg5BW8fRjeVFHorkLqS1UkeLsVTvFQ7n17h4u
         EQ+anTGbfKimT1/LMGCeWzOpNbAOZ2x0Tl+Frbj6czKOETXuxh364FwweYbKs5bHvqMp
         bmTQ==
X-Gm-Message-State: AJcUukc4c+ImV86svQRp0887IG6iSYigR7C9Yb0i4xuJT03vdrKr19aa
        Dm8EFDzUcwcaAOEZpOLgFtTR7cfmRiT6FHvuhSTCJQ==
X-Google-Smtp-Source: ALg8bN4amSwWukkVzC9WFmuyGIAa98Ef1i3/sWMAuO/47Fu+m8QmPDRsZqxyYGHjQN3rCLzAvfDN15LGoRsxIe/ztQo=
X-Received: by 2002:a0c:db04:: with SMTP id d4mr824527qvk.114.1545363362797;
 Thu, 20 Dec 2018 19:36:02 -0800 (PST)
MIME-Version: 1.0
References: <1544258371-4600-1-git-send-email-yong.wu@mediatek.com> <1544258371-4600-9-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1544258371-4600-9-git-send-email-yong.wu@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Fri, 21 Dec 2018 11:35:51 +0800
Message-ID: <CANMq1KDHTPbYHXVsf+_=ER3HYjfFPjv6LTTZMvmM7WChiFDyZQ@mail.gmail.com>
Subject: Re: [PATCH v4 08/18] iommu/mediatek: Add larb-id remapped support
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
        iommu@lists.linux-foundation.org, arnd@arndb.de,
        yingjoe.chen@mediatek.com, youlin.pei@mediatek.com,
        Arvind Yadav <arvind.yadav.cs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 8, 2018 at 4:42 PM Yong Wu <yong.wu@mediatek.com> wrote:
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
> This also is a preparing patch for mt8183.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/iommu/mtk_iommu.c | 3 +++
>  drivers/iommu/mtk_iommu.h | 4 ++++
>  2 files changed, 7 insertions(+)
>
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index eda062a..8ab3b69 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -220,6 +220,9 @@ static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
>         fault_larb = F_MMU0_INT_ID_LARB_ID(regval);
>         fault_port = F_MMU0_INT_ID_PORT_ID(regval);
>
> +       if (data->plat_data->larbid_remap_enable)
> +               fault_larb = data->plat_data->larbid_remapped[fault_larb];
> +
>         if (report_iommu_fault(&dom->domain, data->dev, fault_iova,
>                                write ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ)) {
>                 dev_err_ratelimited(
> diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
> index b8749ac..3877050 100644
> --- a/drivers/iommu/mtk_iommu.h
> +++ b/drivers/iommu/mtk_iommu.h
> @@ -47,6 +47,10 @@ struct mtk_iommu_plat_data {
>
>         /* HW will use the EMI clock if there isn't the "bclk". */
>         bool                has_bclk;
> +
> +       /* The larb-id may be remapped in the smi-common. */
> +       bool                larbid_remap_enable;
> +       unsigned int        larbid_remapped[MTK_LARB_NR_MAX];

Wouldn't it be a little simpler if you just had
larbid_remap[MTK_LARB_NR_MAX] (no larbid_remap_enable), and just set
it to {0, 1, 2, 3, 4, 5, 6, 7} in platforms that don't need
complicated remapping?

Also, unsigned char/u8 array would be enough.

>  };
>
>  struct mtk_iommu_domain;
> --
> 1.9.1
>
