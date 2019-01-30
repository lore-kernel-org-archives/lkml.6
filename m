Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD07C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A618020989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LAMal645"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387503AbfA3TH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 14:07:56 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35067 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387403AbfA3THz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 14:07:55 -0500
Received: by mail-lj1-f195.google.com with SMTP id x85-v6so571991ljb.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 11:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u2kvNL8hyI8LvEhJp8PwSq49BVsqDIa5rehdFSpt/WA=;
        b=LAMal645UtppVgxvUM0liVNBkXQhEeuOZbWAMkeKgNRLnJo9l1bO+ClwBIOB7IOvD5
         KdRp2Los/M2vb5x2Ks1C8WtQuxKnYKu8FOYwSO0y4YGta86aMqHFMjkQkZDJ/buQ9zZS
         rnSNQrlDmEkMtcQ5MgWcxQhIHtN6GN+LpdmuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u2kvNL8hyI8LvEhJp8PwSq49BVsqDIa5rehdFSpt/WA=;
        b=unVHY6FKw3LyE4+gwlGc/Fn+IRAoSZQW1t0Rfz7dhN04e2SjWMeG+FaMysfKT8/sTM
         Q+rBK9ZHgUo69mRvIvQpmqiIA/gycRSd7iSnA0Z3XxTawlvuLdSGgsgIJlz9nLnAVUje
         h2qT9jdonmlY9gPt74nsiR67XfE35UNYW8aaduPt//VeETb+g+R5tvwfh5cpMG7QTcxC
         PK09RLkLt1NKYD2NfluaHEP+8FxsLNXxd9teyocb/KqPxC37WBAYV4H1Fq1oUkIlbMTk
         Eg0Hdzm6toa85vUKiPYHiWuNZn35r+tivGY7Ap5VnjeZYarOjN/15iiYYfOASYmu3dky
         T9iQ==
X-Gm-Message-State: AHQUAuZNn7WWsH95DVc1tnFISWjaFRbBPLGtIzEwuTnvBYA9tEUiv4Gs
        LO08PvVkIPkge5frTalnswA96CeXgcA=
X-Google-Smtp-Source: AHgI3IallvZ1xVnT2+rbLC2Tw0RWowXWIuZV1CV2+tIXkDeajmmCQEQcUGretQ5q3E7dUbOGC8Fqqw==
X-Received: by 2002:a2e:a289:: with SMTP id k9-v6mr714488lja.24.1548875272330;
        Wed, 30 Jan 2019 11:07:52 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id a20-v6sm417799ljf.28.2019.01.30.11.07.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 11:07:51 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id u89-v6so577557lje.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 11:07:50 -0800 (PST)
X-Received: by 2002:a2e:9715:: with SMTP id r21-v6mr26090126lji.30.1548875269976;
 Wed, 30 Jan 2019 11:07:49 -0800 (PST)
MIME-Version: 1.0
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com> <1546314952-15990-17-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1546314952-15990-17-git-send-email-yong.wu@mediatek.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 30 Jan 2019 11:07:13 -0800
X-Gmail-Original-Message-ID: <CAE=gft4q3oj+oQ=Vo-kGD7OYTO0_WMf8t4SLa_H7SCH8G2VFOw@mail.gmail.com>
Message-ID: <CAE=gft4q3oj+oQ=Vo-kGD7OYTO0_WMf8t4SLa_H7SCH8G2VFOw@mail.gmail.com>
Subject: Re: [PATCH v5 16/20] memory: mtk-smi: Add bus_sel for mt8183
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

On Mon, Dec 31, 2018 at 7:59 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> There are 2 mmu cells in a M4U HW. we could adjust some larbs entering
> mmu0 or mmu1 to balance the bandwidth via the smi-common register
> SMI_BUS_SEL(0x220)(Each larb occupy 2 bits).
>
> In mt8183, For better performance, we switch larb1/2/5/7 to enter
> mmu1 while the others still keep enter mmu0.
>
> In mt8173 and mt2712, we don't get the performance issue,
> Keep its default value(0x0), that means all the larbs enter mmu0.
>
> Note: smi gen1(mt2701/mt7623) don't have this bus_sel.
>
> CC: Matthias Brugger <matthias.bgg@gmail.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/memory/mtk-smi.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> index 9790801..08cf40d 100644
> --- a/drivers/memory/mtk-smi.c
> +++ b/drivers/memory/mtk-smi.c
> @@ -49,6 +49,12 @@
>  #define SMI_LARB_NONSEC_CON(id)        (0x380 + ((id) * 4))
>  #define F_MMU_EN               BIT(0)
>
> +/* SMI COMMON */
> +#define SMI_BUS_SEL                    0x220
> +#define SMI_BUS_LARB_SHIFT(larbid)     ((larbid) << 1)
> +/* All are MMU0 defaultly. Only specialize mmu1 here. */
> +#define F_MMU1_LARB(larbid)            (0x1 << SMI_BUS_LARB_SHIFT(larbid))
> +
>  enum mtk_smi_gen {
>         MTK_SMI_GEN1,
>         MTK_SMI_GEN2
> @@ -57,6 +63,7 @@ enum mtk_smi_gen {
>  struct mtk_smi_common_plat {
>         enum mtk_smi_gen gen;
>         bool             has_gals;
> +       u32              bus_sel; /* Balance some larbs to enter mmu0 or mmu1 */
>  };
>
>  struct mtk_smi_larb_gen {
> @@ -72,8 +79,8 @@ struct mtk_smi {
>         struct clk                      *clk_apb, *clk_smi;
>         struct clk                      *clk_gals0, *clk_gals1;
>         struct clk                      *clk_async; /*only needed by mt2701*/
> -       void __iomem                    *smi_ao_base;
> -
> +       void __iomem                    *smi_ao_base; /* only for gen1 */
> +       void __iomem                    *base;        /* only for gen2 */
>         const struct mtk_smi_common_plat *plat;
>  };
>
> @@ -410,6 +417,8 @@ static int __maybe_unused mtk_smi_larb_suspend(struct device *dev)
>  static const struct mtk_smi_common_plat mtk_smi_common_mt8183 = {
>         .gen      = MTK_SMI_GEN2,
>         .has_gals = true,
> +       .bus_sel  = F_MMU1_LARB(1) | F_MMU1_LARB(2) | F_MMU1_LARB(5) |
> +                   F_MMU1_LARB(7),
>  };
>
>  static const struct of_device_id mtk_smi_common_of_ids[] = {
> @@ -482,6 +491,11 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
>                 ret = clk_prepare_enable(common->clk_async);
>                 if (ret)
>                         return ret;
> +       } else {
> +               res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +               common->base = devm_ioremap_resource(dev, res);
> +               if (IS_ERR(common->base))
> +                       return PTR_ERR(common->base);

So you split base and smi_ao_base because they're completely different
register regions, or because ->base is no longer "always on"? It's
tempting to recombine them because they appear to be mutually
exclusive, but if they're truly different register regions then I
understand.
