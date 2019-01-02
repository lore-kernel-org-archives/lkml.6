Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EF6C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 06:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C0F12171F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 06:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UkdAFm5o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbfABGP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 01:15:29 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38930 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbfABGP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 01:15:28 -0500
Received: by mail-qt1-f195.google.com with SMTP id u47so27915488qtj.6
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jan 2019 22:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=glopvezWLKYRpCDLx2kOuGjngzEcYlz2hV+GLH3M5dE=;
        b=UkdAFm5oX8RMBIReEW8Vewr+IDS1r4ySAFVRZK9VbgW+fMsxXZjZ05VMJ8fNHN05c9
         gfM4znaPdSkn0dgwzzdD0bFZtCch2mOC+WTkOlLVA5gcfXNi8RzZCD6TC+APiKuxi5Qd
         XaSQZ+79L5uG9PmDTN1/30OKTZsCGit7UaPRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=glopvezWLKYRpCDLx2kOuGjngzEcYlz2hV+GLH3M5dE=;
        b=qec8/LIw2gjpFe6VzoBgZFnO1wD1TtDGyn3MSRC2jldGDuOXGBk8huVWEvB5MfNFuc
         PHHamsWtpuycPl0m2c1iXIuHsF6NrWfu7NdkGoIjl2ZZGO4XQ8pTxndLdaN4asNiUI8X
         rg6QmqFv8pZMZewHz9yvhHFbX7WrEs+OCHxxhtklCP9kJNObK6R4CvIcYDksOOOQuSoN
         vFzjMuoSUd2tFccRcaqWQZ4YLiNGZZaRlIOV1gwSFVyxLW5m17BEOJ5HXDmSEu9Iqbnc
         6Ky9PGYFzQkxu7/qWtVoSCT6cgg+y7K3aa73l+HYuXWg4SE7sD2/v+A/ImZl/wV0qn8V
         OrYg==
X-Gm-Message-State: AJcUukeIkhEYoNizQcPRPVHOORNUvNbgo2V0f2x/DeJDIQ8e+S5xmM8W
        ltPWmf04cg/XWFBIo4hmgI08UrdH9XjG/4Z1dtqbFA==
X-Google-Smtp-Source: ALg8bN6DF22l97+TmYykR+dmQ5cCuzjN9NK2/vtlat13VeS9OrPVu+YEUXwmFz3YllcOiQpiTnQveogasQ6M2Gh8bXc=
X-Received: by 2002:a0c:8425:: with SMTP id l34mr42246686qva.101.1546409726928;
 Tue, 01 Jan 2019 22:15:26 -0800 (PST)
MIME-Version: 1.0
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com> <1546314952-15990-9-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1546314952-15990-9-git-send-email-yong.wu@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Wed, 2 Jan 2019 14:15:15 +0800
Message-ID: <CANMq1KCz9mkrou2+C_FTKWsaa3+riofn5VXHdE==Ux3vLJf=zA@mail.gmail.com>
Subject: Re: [PATCH v5 08/20] iommu/mediatek: Add larb-id remapped support
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

I think it's a little cleaner this way, thanks.

Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>

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
>  };
>
>  static const struct of_device_id mtk_iommu_of_ids[] = {
> diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
> index b8749ac..eec19a6 100644
> --- a/drivers/iommu/mtk_iommu.h
> +++ b/drivers/iommu/mtk_iommu.h
> @@ -47,6 +47,8 @@ struct mtk_iommu_plat_data {
>
>         /* HW will use the EMI clock if there isn't the "bclk". */
>         bool                has_bclk;
> +
> +       unsigned char       larbid_remap[MTK_LARB_NR_MAX];
>  };
>
>  struct mtk_iommu_domain;
> --
> 1.9.1
>
