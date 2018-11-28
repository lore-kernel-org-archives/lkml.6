Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51883C04EBA
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 00:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1889820645
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 00:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZYKLGhZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1889820645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbeK1L6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 06:58:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:52318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726457AbeK1L6x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 06:58:53 -0500
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A0DA20645;
        Wed, 28 Nov 2018 00:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543366749;
        bh=7q54EERWrarCm09cdl5l6CxJn23chAyNp6Jjc1wr4Ck=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NZYKLGhZD6YUBlFMzPwRuS+Zwp7BVa3wiC32o7vEPWqzxog4/XE2QFp5leOeR23JP
         AjNnbtdDjnDdvA/gfYJP33FTv2RCkIfGdkPYVGBKCO3uzGL8hMTm7LG+HQDZzb92zK
         Ot8vjMGpzJfai61AbTjIciuekTUs0sRG/ZBciyJg=
Received: by mail-wr1-f51.google.com with SMTP id j2so24601670wrw.1;
        Tue, 27 Nov 2018 16:59:09 -0800 (PST)
X-Gm-Message-State: AA+aEWZw7QNij29Y3BXPDiU0CUsoxGV96xfN0LdEqKjvWkND1KPVhSN+
        YcyQFK5WTBIdeXERr+yj6gWCL0HkQpNrUWpZg/I=
X-Google-Smtp-Source: AFSGD/W4Pe6m5arwhWIjPAcyjW9WvUUpUTdDj6zBbZ3ZMyQuFZwpSobhdTQnr7MY85JRZ2pW2R0e9Tkas6sy3VUI2+A=
X-Received: by 2002:a5d:66c1:: with SMTP id k1mr28529061wrw.132.1543366747701;
 Tue, 27 Nov 2018 16:59:07 -0800 (PST)
MIME-Version: 1.0
References: <20181127034254.24721-1-weiyi.lu@mediatek.com> <20181127034254.24721-5-weiyi.lu@mediatek.com>
 <CAGp9Lzro5YHCYqzOWFJJa4g75odf6yK52cean_aS3p2STOtJYg@mail.gmail.com> <CANMq1KB4tt9jdmE+LJXfji=QXC9-6wuhXWjJPkpNfo6hEMXH=A@mail.gmail.com>
In-Reply-To: <CANMq1KB4tt9jdmE+LJXfji=QXC9-6wuhXWjJPkpNfo6hEMXH=A@mail.gmail.com>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Tue, 27 Nov 2018 16:58:57 -0800
X-Gmail-Original-Message-ID: <CAGp9LzqfgLa03p-bEOQaT2qtuOEqUL3e04nDS38TbZ2-2Ohauw@mail.gmail.com>
Message-ID: <CAGp9LzqfgLa03p-bEOQaT2qtuOEqUL3e04nDS38TbZ2-2Ohauw@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] clk: mediatek: Disable tuner_en before change
 PLL rate
To:     drinkcat@chromium.org
Cc:     weiyi.lu@mediatek.com, Matthias Brugger <matthias.bgg@gmail.com>,
        sboyd@codeaurora.org, robh@kernel.org, jamesjj.liao@mediatek.com,
        srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org,
        fan.chen@mediatek.com, linux-mediatek@lists.infradead.org,
        owen.chen@mediatek.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> On Wed, Nov 28, 2018 at 4:37 AM Sean Wang <sean.wang@kernel.org> wrote:
> >
> > Weiyi Lu <weiyi.lu@mediatek.com> =E6=96=BC 2018=E5=B9=B411=E6=9C=8826=
=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=887:45=E5=AF=AB=E9=81=93=EF=BC=
=9A
> > >
> > > From: Owen Chen <owen.chen@mediatek.com>
> > >
> > > PLLs with tuner_en bit, such as APLL1, need to disable
> > > tuner_en before apply new frequency settings, or the new frequency
> > > settings (pcw) will not be applied.
> > > The tuner_en bit will be disabled during changing PLL rate
> > > and be restored after new settings applied.
> >
> > It looks like a bug fix. If so, you should add a fixes tag and even cc
> > stable tree
> >
> > >
> > > Signed-off-by: Owen Chen <owen.chen@mediatek.com>
> > > ---
> > >  drivers/clk/mediatek/clk-pll.c | 33 +++++++++++++++++++++++++++++++-=
-
> > >  1 file changed, 31 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/cl=
k-pll.c
> > > index 1db161aced31..81400601f107 100644
> > > --- a/drivers/clk/mediatek/clk-pll.c
> > > +++ b/drivers/clk/mediatek/clk-pll.c
> > > @@ -27,7 +27,7 @@
> > >  #define CON0_BASE_EN           BIT(0)
> > >  #define CON0_PWR_ON            BIT(0)
> > >  #define CON0_ISO_EN            BIT(1)
> > > -#define CON0_PCW_CHG           BIT(31)
> > > +#define CON1_PCW_CHG           BIT(31)
> >
> > it seems like an unnecessary change
>
> Below, you have:
> con1 |=3D CON1_PCW_CHG;
>
> Presumably PCW_CHG is on BIT(31) of CON1(?), so I think this is a good
> change. Maybe this needs to be a separate patch, though?
>

Sure, for me it's not easily understood why the change is necessary
from the description. If it's really another fixup, it should be moved
to a separate patch or add more explanations about that in the same
patch.

> > >
> > >  #define AUDPLL_TUNER_EN                BIT(31)
> > >
> > > @@ -97,9 +97,31 @@ static void mtk_pll_set_rate_regs(struct mtk_clk_p=
ll *pll, u32 pcw,
> > >  {
> > >         u32 con1, val;
> > >         int pll_en;
> > > +       u32 tuner_en =3D 0;
> > > +       u32 tuner_en_mask;
> > > +       void __iomem *tuner_en_addr =3D NULL;
> > >
> > >         pll_en =3D readl(pll->base_addr + REG_CON0) & CON0_BASE_EN;
> > >
> > > +       /* disable tuner */
> >
> > similar code pieces are ready on mtk_pll_[un]prepare. maybe we can add
> > common tuner operations for them to reuse.
> >
> > > +       if (pll->tuner_en_addr) {
> > > +               tuner_en_addr =3D pll->tuner_en_addr;
> > > +               tuner_en_mask =3D BIT(pll->data->tuner_en_bit);
> > > +       } else if (pll->tuner_addr) {
> > > +               tuner_en_addr =3D pll->tuner_addr;
> > > +               tuner_en_mask =3D AUDPLL_TUNER_EN;
> > > +       }
> > > +
> > > +       if (tuner_en_addr) {
> > > +               val =3D readl(tuner_en_addr);
> > > +               tuner_en =3D val & tuner_en_mask;
> > > +
> > > +               if (tuner_en) {
> > > +                       val &=3D ~tuner_en_mask;
> > > +                       writel(val, tuner_en_addr);
> > > +               }
> > > +       }
> > > +
> > >         /* set postdiv */
> > >         val =3D readl(pll->pd_addr);
> > >         val &=3D ~(POSTDIV_MASK << pll->data->pd_shift);
> > > @@ -120,12 +142,19 @@ static void mtk_pll_set_rate_regs(struct mtk_cl=
k_pll *pll, u32 pcw,
> > >         con1 =3D readl(pll->base_addr + REG_CON1);
> > >
> > >         if (pll_en)
> > > -               con1 |=3D CON0_PCW_CHG;
> > > +               con1 |=3D CON1_PCW_CHG;
> > >
> > >         writel(con1, pll->base_addr + REG_CON1);
> > >         if (pll->tuner_addr)
> > >                 writel(con1 + 1, pll->tuner_addr);
> > >
> > > +       /* restore tuner_en */
> > > +       if (tuner_en_addr && tuner_en) {
> >
> > if (tuner_en) is sufficient
> >
> > > +               val =3D readl(tuner_en_addr);
> > > +               val |=3D tuner_en_mask;
> > > +               writel(val, tuner_en_addr);
> > > +       }
> > > +
> > >         if (pll_en)
> > >                 udelay(20);
> > >  }
> > > --
> > > 2.18.0
> > >
> > >
> > > _______________________________________________
> > > Linux-mediatek mailing list
> > > Linux-mediatek@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-mediatek
