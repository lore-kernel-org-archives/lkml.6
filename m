Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BC0C00319
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 04:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2AD0218E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 04:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729518AbfB0Ej1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 23:39:27 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:55225 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729265AbfB0Ej0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 23:39:26 -0500
X-UUID: a69a58daeb3d4044a38b0083edb6fab8-20190227
X-UUID: a69a58daeb3d4044a38b0083edb6fab8-20190227
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 646528219; Wed, 27 Feb 2019 12:39:15 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 27 Feb 2019 12:39:14 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 27 Feb 2019 12:39:14 +0800
Message-ID: <1551242354.1047.37.camel@mtksdaap41>
Subject: Re: [PATCH v4 01/12] clk: mediatek: Disable tuner_en before change
 PLL rate
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Nicolas Boichat <drinkcat@chromium.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Rob Herring <robh@kernel.org>,
        James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>, <stable@vger.kernel.org>,
        Owen Chen <owen.chen@mediatek.com>
Date:   Wed, 27 Feb 2019 12:39:14 +0800
In-Reply-To: <1551239460.1047.30.camel@mtksdaap41>
References: <20190201083016.25856-1-weiyi.lu@mediatek.com>
         <20190201083016.25856-3-weiyi.lu@mediatek.com>
         <41aed6f5-8794-ddf5-d5c2-17ee82e33db3@gmail.com>
         <1551239460.1047.30.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-02-27 at 11:51 +0800, Weiyi Lu wrote:
> On Tue, 2019-02-26 at 16:59 +0100, Matthias Brugger wrote:
> > 
> > On 01/02/2019 09:30, Weiyi Lu wrote:
> > > From: Owen Chen <owen.chen@mediatek.com>
> > > 
> > > PLLs with tuner_en bit, such as APLL1, need to disable
> > > tuner_en before apply new frequency settings, or the new frequency
> > > settings (pcw) will not be applied.
> > > The tuner_en bit will be disabled during changing PLL rate
> > > and be restored after new settings applied.
> > > Another minor change is to correct the macro name of pcw change bit
> > > to CON1_PCW_CHG because PCW_CHG(BIT31) is on CON1.
> > > 
> > > Fixes: e2f744a82d725 (clk: mediatek: Add MT2712 clock support)
> > > Cc: <stable@vger.kernel.org>
> > > Signed-off-by: Owen Chen <owen.chen@mediatek.com>
> > > ---
> > >  drivers/clk/mediatek/clk-pll.c | 33 +++++++++++++++++++++++++++++++--
> > >  1 file changed, 31 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
> > > index f54e4015b0b1..f0ff5f535c7e 100644
> > > --- a/drivers/clk/mediatek/clk-pll.c
> > > +++ b/drivers/clk/mediatek/clk-pll.c
> > > @@ -27,7 +27,7 @@
> > >  #define CON0_BASE_EN		BIT(0)
> > >  #define CON0_PWR_ON		BIT(0)
> > >  #define CON0_ISO_EN		BIT(1)
> > > -#define CON0_PCW_CHG		BIT(31)
> > > +#define CON1_PCW_CHG		BIT(31)
> > >  
> > >  #define AUDPLL_TUNER_EN		BIT(31)
> > >  
> > > @@ -93,9 +93,31 @@ static void mtk_pll_set_rate_regs(struct mtk_clk_pll *pll, u32 pcw,
> > >  {
> > >  	u32 con1, val;
> > >  	int pll_en;
> > > +	u32 tuner_en = 0;
> > > +	u32 tuner_en_mask;
> > > +	void __iomem *tuner_en_addr = NULL;
> > >  
> > >  	pll_en = readl(pll->base_addr + REG_CON0) & CON0_BASE_EN;
> > >  
> > > +	/* disable tuner */
> > > +	if (pll->tuner_en_addr) {
> > > +		tuner_en_addr = pll->tuner_en_addr;
> > > +		tuner_en_mask = BIT(pll->data->tuner_en_bit);
> > > +	} else if (pll->tuner_addr) {
> > > +		tuner_en_addr = pll->tuner_addr;
> > > +		tuner_en_mask = AUDPLL_TUNER_EN;
> > > +	}
> > > +
> > > +	if (tuner_en_addr) {
> > > +		val = readl(tuner_en_addr);
> > > +		tuner_en = val & tuner_en_mask;
> > > +
> > > +		if (tuner_en) {
> > > +			val &= ~tuner_en_mask;
> > > +			writel(val, tuner_en_addr);
> > > +		}
> > > +	}
> > > +
> > 
> > Why don't we use a flag here, it would make the code easier to understand.
> > I think it would also help if you put this code in a separate function.
> > 
> > Regards,
> > Matthias
> > 
> 
> Hi Matthias,
> 
> I guess you suggest to add a flag (e.g. CLK_TUNER_SUPPORT) and declare
> the PLL clock with this flag. And inside this mtk_pll_set_rate_regs()
> function, we could modify it as below. Am I right?
> 
> if (pll->data->flags & CLK_TUNER_SUPPORT)
>     disable_tuner();
> [...]
> if (pll->data->flags & CLK_TUNER_SUPPORT)
>     enable_tuner();
> 
> 
> But I thought this flag might be a customized flags and can only be put
> in clk-mtk.h not clk-provider.h so far. And it might cause 
> potential problem of clock flag re-definition. May I have more
> suggestion?
> 

Please ignore the potential problem I mentioned, I just checked it
carefully and that redefinition problem won't happen in current flow.
Sorry for having you confused.
But I still need to confirm with you if the method in previous mail is
correct? Thanks.

> > 
> > >  	/* set postdiv */
> > >  	val = readl(pll->pd_addr);
> > >  	val &= ~(POSTDIV_MASK << pll->data->pd_shift);
> > > @@ -116,12 +138,19 @@ static void mtk_pll_set_rate_regs(struct mtk_clk_pll *pll, u32 pcw,
> > >  	con1 = readl(pll->base_addr + REG_CON1);
> > >  
> > >  	if (pll_en)
> > > -		con1 |= CON0_PCW_CHG;
> > > +		con1 |= CON1_PCW_CHG;
> > >  
> > >  	writel(con1, pll->base_addr + REG_CON1);
> > >  	if (pll->tuner_addr)
> > >  		writel(con1 + 1, pll->tuner_addr);
> > >  
> > > +	/* restore tuner_en */
> > > +	if (tuner_en_addr && tuner_en) {
> > > +		val = readl(tuner_en_addr);
> > > +		val |= tuner_en_mask;
> > > +		writel(val, tuner_en_addr);
> > > +	}
> > > +
> > >  	if (pll_en)
> > >  		udelay(20);
> > >  }
> > > 
> 


