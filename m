Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70637C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AFD720863
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbfBAIWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 03:22:20 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:7537 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726665AbfBAIWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 03:22:20 -0500
X-UUID: 6bdfe649cd45443c85f1fb455085a07e-20190201
X-UUID: 6bdfe649cd45443c85f1fb455085a07e-20190201
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 559663866; Fri, 01 Feb 2019 16:22:14 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 1 Feb 2019 16:22:13 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 1 Feb 2019 16:22:13 +0800
Message-ID: <1549009333.22634.2.camel@mtksdaap41>
Subject: Re: [PATCH v3 03/12] clk: mediatek: add configurable pcwibits and
 fmin to mtk_pll_data
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Stephen Boyd <sboyd@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>, <stable@vger.kernel.org>,
        Owen Chen <owen.chen@mediatek.com>
Date:   Fri, 1 Feb 2019 16:22:13 +0800
In-Reply-To: <154482494548.19322.11090762587126084086@swboyd.mtv.corp.google.com>
References: <20181210073240.32278-1-weiyi.lu@mediatek.com>
         <20181210073240.32278-5-weiyi.lu@mediatek.com>
         <154482494548.19322.11090762587126084086@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 2018-12-14 at 14:02 -0800, Stephen Boyd wrote:
> Quoting Weiyi Lu (2018-12-09 23:32:31)
> > diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
> > index f0ff5f535c7e..81400601f107 100644
> > --- a/drivers/clk/mediatek/clk-pll.c
> > +++ b/drivers/clk/mediatek/clk-pll.c
> > @@ -69,11 +71,13 @@ static unsigned long __mtk_pll_recalc_rate(struct mtk_clk_pll *pll, u32 fin,
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
> 
> This is practically unreadable. It should be changed to an if statement.
> 

OK, will be fixed in next version.

> >  
> >         vco = (u64)fin * pcw;
> >  
> > @@ -167,9 +171,10 @@ static void mtk_pll_set_rate_regs(struct mtk_clk_pll *pll, u32 pcw,
> >  static void mtk_pll_calc_values(struct mtk_clk_pll *pll, u32 *pcw, u32 *postdiv,
> >                 u32 freq, u32 fin)
> >  {
> > -       unsigned long fmin = 1000 * MHZ;
> > +       unsigned long fmin = pll->data->fmin ? pll->data->fmin : (1000 * MHZ);
> >         const struct mtk_pll_div_table *div_table = pll->data->div_table;
> >         u64 _pcw;
> > +       int ibits;
> >         u32 val;
> >  
> >         if (freq > pll->data->fmax)
> > @@ -193,7 +198,8 @@ static void mtk_pll_calc_values(struct mtk_clk_pll *pll, u32 *pcw, u32 *postdiv,
> >         }
> >  
> >         /* _pcw = freq * postdiv / fin * 2^pcwfbits */
> > -       _pcw = ((u64)freq << val) << (pll->data->pcwbits - INTEGER_BITS);
> > +       ibits = pll->data->pcwibits ? pll->data->pcwibits : INTEGER_BITS;
> > +       _pcw = ((u64)freq << val) << (pll->data->pcwbits - ibits);
> 
> Similar comment. Readability is low here.

I thought these two lines here are clean enough. Just simple conditional
assignment and shift operation. I'd like to not to change it.

> 




