Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCC9C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A34EE20863
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dKWvkS0E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388545AbfAaQg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 11:36:57 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39892 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388493AbfAaQg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 11:36:56 -0500
Received: by mail-lf1-f65.google.com with SMTP id n18so2807718lfh.6
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 08:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lW5D3gcqaZFTIynuG5+XGzwm6TlVkJOR5eGnIKEV1dk=;
        b=dKWvkS0ESAm34gQePnmEYissq/yFcRDG/SLR0NEjoyNvgQxBUQ2EK/+nHACP304kBF
         EafDswZfZmUePOCrZNGOB1ij5vteqjOZ5eFubRGIPohNx01vSRsJO3zlvtf9ST0hz3sg
         3AmNgpe6KQYAuXnKzd5/onMzKrQbS9wE4jxPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lW5D3gcqaZFTIynuG5+XGzwm6TlVkJOR5eGnIKEV1dk=;
        b=M11sFqzZVDtQfUFp1SFB7lCBOmJNKeS0LQAi65fnBuIMhY5Lf+lXm07xhx/+nZNlEh
         K8FTog7aPZAX4eaXP5Mbi3nW5A9pTPqBuoqVkct/QgbnoX8LxjzRtrmaKn11nFVC2osd
         u0G3c/v7lgBTpMb93yJJUZHENAirOMxtsFb140UKLbS3YOeY+CG+t0P2oHoZZrv9Kbpe
         u5pEWtjOYY/UjKdq8ZpY4nFxPHvPptRNfeiNVNMhgu1WP2cCMRJHwfJzXyz7HegUCDUK
         YExrA0dMkB/81ZzHQHkC262Wne2CPXBoemlCrxkSDY+7bB9/0glICg+o7yE7n8gRyXPn
         AXjQ==
X-Gm-Message-State: AJcUuke61oIFXOsU8LNvpjY80gqg56KQtDXbx7j+JZjhfUp1p54TcR8m
        co3u96s9nOqCVEFEcMs1P4U9AIFoWVU=
X-Google-Smtp-Source: ALg8bN6zjDVssj2EpQBKn1mO58Xh5gjn8t2huhJLV1mOebU2C/tCECQMRc9QmfO9ikShm/S13lj7mg==
X-Received: by 2002:a19:e601:: with SMTP id d1mr29602817lfh.71.1548952612977;
        Thu, 31 Jan 2019 08:36:52 -0800 (PST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id t22sm978568lfb.0.2019.01.31.08.36.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 08:36:51 -0800 (PST)
Received: by mail-lj1-f182.google.com with SMTP id s5-v6so3181555ljd.12
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 08:36:50 -0800 (PST)
X-Received: by 2002:a2e:9181:: with SMTP id f1-v6mr21562086ljg.64.1548952609813;
 Thu, 31 Jan 2019 08:36:49 -0800 (PST)
MIME-Version: 1.0
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com>
 <1546314952-15990-12-git-send-email-yong.wu@mediatek.com> <CAE=gft4=4h_1MAnrC8CosSe3gOWx+DwFJSLvGNtOFNMZN8oZ3w@mail.gmail.com>
 <1548904841.19710.36.camel@mhfsdcap03>
In-Reply-To: <1548904841.19710.36.camel@mhfsdcap03>
From:   Evan Green <evgreen@chromium.org>
Date:   Thu, 31 Jan 2019 08:36:12 -0800
X-Gmail-Original-Message-ID: <CAE=gft7DNKu93c8e47nrC7Q7h4VL3vGwkj8ycQM8yVdCdjb+hw@mail.gmail.com>
Message-ID: <CAE=gft7DNKu93c8e47nrC7Q7h4VL3vGwkj8ycQM8yVdCdjb+hw@mail.gmail.com>
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

On Wed, Jan 30, 2019 at 7:20 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> On Wed, 2019-01-30 at 10:30 -0800, Evan Green wrote:
> > On Mon, Dec 31, 2018 at 7:58 PM Yong Wu <yong.wu@mediatek.com> wrote:
> > >
> > > Both mt8173 and mt8183 don't have this vld_pa_rng(valid physical address
> > > range) register while mt2712 have. Move it into the plat_data.
> > >
> > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > ---
> > >  drivers/iommu/mtk_iommu.c | 3 ++-
> > >  drivers/iommu/mtk_iommu.h | 1 +
> > >  2 files changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > > index 8d8ab21..2913ddb 100644
> > > --- a/drivers/iommu/mtk_iommu.c
> > > +++ b/drivers/iommu/mtk_iommu.c
> > > @@ -548,7 +548,7 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
> > >                          upper_32_bits(data->protect_base);
> > >         writel_relaxed(regval, data->base + REG_MMU_IVRP_PADDR);
> > >
> > > -       if (data->enable_4GB && data->plat_data->m4u_plat != M4U_MT8173) {
> > > +       if (data->enable_4GB && data->plat_data->vld_pa_rng) {
> > >                 /*
> > >                  * If 4GB mode is enabled, the validate PA range is from
> > >                  * 0x1_0000_0000 to 0x1_ffff_ffff. here record bit[32:30].
> > > @@ -741,6 +741,7 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
> > >         .m4u_plat     = M4U_MT2712,
> > >         .has_4gb_mode = true,
> > >         .has_bclk     = true,
> > > +       .vld_pa_rng   = true,
> > >         .larbid_remap = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9},
> > >  };
> > >
> > > diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
> > > index b46aeaa..a8c5d1e 100644
> > > --- a/drivers/iommu/mtk_iommu.h
> > > +++ b/drivers/iommu/mtk_iommu.h
> > > @@ -48,6 +48,7 @@ struct mtk_iommu_plat_data {
> > >         /* HW will use the EMI clock if there isn't the "bclk". */
> > >         bool                has_bclk;
> > >         bool                reset_axi;
> > > +       bool                vld_pa_rng;
> >
> > I agree with Nicolas that valid_pa_range would be much clearer...
> > although, even now that I know what it's supposed to mean, I don't get
> > what it represents. What is this saying?
>
> This register in the coda is called "vld_pa_rng".
>
> How about I change it to "has_vld_pa_rng"?. In the comment above, I have
> explained the meaning(valid physical address range).
>

Ok, that sounds fine.
-Evan
