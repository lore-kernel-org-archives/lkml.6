Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D60C04EBB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 03:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 152C020870
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 03:51:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 152C020870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730776AbeKTOSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 09:18:30 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:64809 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730148AbeKTOSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 09:18:30 -0500
X-UUID: 64cc824e71ef4b888f80d3bb9b63cb14-20181120
X-UUID: 64cc824e71ef4b888f80d3bb9b63cb14-20181120
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 981300466; Tue, 20 Nov 2018 11:51:21 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 20 Nov 2018 11:51:20 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 20 Nov 2018 11:51:20 +0800
Message-ID: <1542685880.5132.11.camel@mtksdaap41>
Subject: Re: [PATCH v1 02/11] clk: mediatek: add new member to mtk_pll_data
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>
CC:     Rob Herring <robh@kernel.org>, <srv_heupstream@mediatek.com>,
        <jamesjj.liao@mediatek.com>, <sboyd@codeaurora.org>,
        lkml <linux-kernel@vger.kernel.org>, <fan.chen@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <owen.chen@mediatek.com>, <linux-clk@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 20 Nov 2018 11:51:20 +0800
In-Reply-To: <CANMq1KBjtyQFyJ-mZBndPDSfSDnD0K8izy39jp9zKE4xfiCiog@mail.gmail.com>
References: <20181106064206.17535-1-weiyi.lu@mediatek.com>
         <20181106064206.17535-4-weiyi.lu@mediatek.com>
         <CANMq1KBjtyQFyJ-mZBndPDSfSDnD0K8izy39jp9zKE4xfiCiog@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-11-13 at 08:18 -0800, Nicolas Boichat wrote:
> On Mon, Nov 5, 2018 at 10:43 PM Weiyi Lu <weiyi.lu@mediatek.com> wrote:
> >
> > From: Owen Chen <owen.chen@mediatek.com>
> >
> > 1. pcwibits: The integer bits of pcw for plls is extend to 8 bits,
> >    add a variable to indicate this change and
> >    backward-compatible.
> > 2. fmin: The pll freqency lower-bound is vary from 1GMhz to
> >    1.5Ghz, add a variable to indicate platform-dependent.
> >
> > Signed-off-by: Owen Chen <owen.chen@mediatek.com>
> > ---
> >  drivers/clk/mediatek/clk-mtk.h |  2 ++
> >  drivers/clk/mediatek/clk-pll.c | 10 +++++++---
> >  2 files changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
> > index f83c2bbb677e..1882221fe994 100644
> > --- a/drivers/clk/mediatek/clk-mtk.h
> > +++ b/drivers/clk/mediatek/clk-mtk.h
> > @@ -215,7 +215,9 @@ struct mtk_pll_data {
> >         const struct clk_ops *ops;
> >         u32 rst_bar_mask;
> >         unsigned long fmax;
> > +       unsigned long fmin;
> 
> Minor nit: I'd put fmin before fmax in the structure.
> 

OK, thanks for the suggestion. will fix in next version

> >         int pcwbits;
> > +       int pcwibits;
> >         uint32_t pcw_reg;
> >         int pcw_shift;
> >         const struct mtk_pll_div_table *div_table;
> > diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
> > index f54e4015b0b1..0ec2c62d9383 100644
> > --- a/drivers/clk/mediatek/clk-pll.c
> > +++ b/drivers/clk/mediatek/clk-pll.c
> 
> I'd add a note next to:
> #define INTEGER_BITS            7
> to say that this is the default, and can be overridden with pcwibits.
> 

OK, thanks for the suggestion. will add in next version

> > @@ -69,11 +69,13 @@ static unsigned long __mtk_pll_recalc_rate(struct mtk_clk_pll *pll, u32 fin,
> >  {
> >         int pcwbits = pll->data->pcwbits;
> >         int pcwfbits;
> > +       int ibits;
> >         u64 vco;
> >         u8 c = 0;
> >
> >         /* The fractional part of the PLL divider. */
> > -       pcwfbits = pcwbits > INTEGER_BITS ? pcwbits - INTEGER_BITS : 0;
> > +       ibits = pll->data->pcwibits ? pll->data->pcwibits : INTEGER_BITS;
> > +       pcwfbits = pcwbits > ibits ? pcwbits - ibits : 0;
> >
> >         vco = (u64)fin * pcw;
> >
> > @@ -138,9 +140,10 @@ static void mtk_pll_set_rate_regs(struct mtk_clk_pll *pll, u32 pcw,
> >  static void mtk_pll_calc_values(struct mtk_clk_pll *pll, u32 *pcw, u32 *postdiv,
> >                 u32 freq, u32 fin)
> >  {
> > -       unsigned long fmin = 1000 * MHZ;
> > +       unsigned long fmin = pll->data->fmin ? pll->data->fmin : 1000 * MHZ;
> 
> I'd put parentheses around (1000 * MHZ), to avoid the need to think
> about precedence...
> 

OK, thanks for the suggestion. will add in next version

> >         const struct mtk_pll_div_table *div_table = pll->data->div_table;
> >         u64 _pcw;
> > +       int ibits;
> >         u32 val;
> >
> >         if (freq > pll->data->fmax)
> > @@ -164,7 +167,8 @@ static void mtk_pll_calc_values(struct mtk_clk_pll *pll, u32 *pcw, u32 *postdiv,
> >         }
> >
> >         /* _pcw = freq * postdiv / fin * 2^pcwfbits */
> > -       _pcw = ((u64)freq << val) << (pll->data->pcwbits - INTEGER_BITS);
> > +       ibits = pll->data->pcwibits ? pll->data->pcwibits : INTEGER_BITS;
> > +       _pcw = ((u64)freq << val) << (pll->data->pcwbits - ibits);
> >         do_div(_pcw, fin);
> >
> >         *pcw = (u32)_pcw;
> > --
> > 2.18.0
> >
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek


