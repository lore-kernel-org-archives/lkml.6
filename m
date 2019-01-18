Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2966C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA52F2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfARJnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 04:43:05 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:44808 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725898AbfARJnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 04:43:04 -0500
X-UUID: d05e12d814234ef58648877de119eb20-20190118
X-UUID: d05e12d814234ef58648877de119eb20-20190118
Received: from mtkcas36.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 188082392; Fri, 18 Jan 2019 17:42:55 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 18 Jan 2019 17:42:54 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 18 Jan 2019 17:42:53 +0800
Message-ID: <1547804574.8124.6.camel@mtkswgap22>
Subject: Re: [PATCH v1 1/5] pwm: mediatek: add a property "mediatek,num-pwms"
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Sean Wang <sean.wang@kernel.org>,
        Weijie Gao <weijie.gao@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Fri, 18 Jan 2019 17:42:54 +0800
In-Reply-To: <20190118075925.noilab6glzm3cig6@pengutronix.de>
References: <de316385a84e079d3b23891e61c959094b9fa7e5.1547781007.git.ryder.lee@mediatek.com>
         <20190118075925.noilab6glzm3cig6@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-01-18 at 08:59 +0100, Uwe Kleine-König wrote:
> Hello,
> 
> On Fri, Jan 18, 2019 at 11:24:41AM +0800, Ryder Lee wrote:
> > This adds a property "mediatek,num-pwms" to avoid having an endless
> > list of compatibles with no differences for the same driver.
> > 
> > Thus, the driver should have backwards compatibility to older DTs.
> 
> I still think Thierry should bless "num-pwms" without vendor prefix.

Okay.

> > Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> > ---
> > Changes since v1: add some checks for backwards compatibility.
> > ---
> >  drivers/pwm/pwm-mediatek.c | 27 ++++++++++++++++++---------
> >  1 file changed, 18 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
> > index eb6674c..81b7e5e 100644
> > --- a/drivers/pwm/pwm-mediatek.c
> > +++ b/drivers/pwm/pwm-mediatek.c
> > @@ -55,7 +55,7 @@ enum {
> >  };
> >  
> >  struct mtk_pwm_platform_data {
> 
> Unrelated to this patch: This name is bad. This struct is not used as
> platform_data and so should better be named mtk_pwm_of_data. While at
> criticizing existing stuff: I'd prefer pwm_mediatek as common prefix to
> match the filename.

I think we can take care about that in another patch.

> > -	unsigned int num_pwms;
> > +	unsigned int num_pwms;	/* it should not be used in the future SoCs */
> 
> I'd drop this comment in favour of a runtime warning.

Sorry, I can't get you here.

> >  	bool pwm45_fixup;
> >  	bool has_clks;
> >  };
> > @@ -226,27 +226,36 @@ static void mtk_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
> >  
> >  static int mtk_pwm_probe(struct platform_device *pdev)
> >  {
> > -	const struct mtk_pwm_platform_data *data;
> > +	struct device_node *np = pdev->dev.of_node;
> >  	struct mtk_pwm_chip *pc;
> >  	struct resource *res;
> > -	unsigned int i;
> > +	unsigned int i, num_pwms;
> >  	int ret;
> >  
> >  	pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
> >  	if (!pc)
> >  		return -ENOMEM;
> >  
> > -	data = of_device_get_match_data(&pdev->dev);
> > -	if (data == NULL)
> > -		return -EINVAL;
> > -	pc->soc = data;
> > +	pc->soc = of_device_get_match_data(&pdev->dev);
> 
> This might return NULL which ...

The only way to call probe() is to match an entry in
mtk_pwm_of_match[], so match cannot be NULL.

> >  
> >  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >  	pc->regs = devm_ioremap_resource(&pdev->dev, res);
> >  	if (IS_ERR(pc->regs))
> >  		return PTR_ERR(pc->regs);
> >  
> > -	for (i = 0; i < data->num_pwms + 2 && pc->soc->has_clks; i++) {
> > +	/* Check if we have set 'num-pwms' in DTs. */
> > +	ret = of_property_read_u32(np, "mediatek,num-pwms", &num_pwms);
> > +	if (ret < 0) {
> > +		/* If no, fallback to use SoC data for backwards compatibility. */
> > +		if (pc->soc->num_pwms) {
> 
> ... here then results in a NULL pointer dereference. I think you want

So we have no chance to get a NULL pointer, right?

> 		if (pc->soc)
> 
> here.
> 
> > +			num_pwms = pc->soc->num_pwms;
> > +		} else {
> > +			dev_err(&pdev->dev, "failed to get pwm number: %d\n", ret);
> > +			return ret;
> > +		}
> > +	}
> > +
> > +	for (i = 0; i < num_pwms + 2 && pc->soc->has_clks; i++) {
> >  		pc->clks[i] = devm_clk_get(&pdev->dev, mtk_pwm_clk_name[i]);
> >  		if (IS_ERR(pc->clks[i])) {
> >  			dev_err(&pdev->dev, "clock: %s fail: %ld\n",
> > @@ -260,7 +269,7 @@ static int mtk_pwm_probe(struct platform_device *pdev)
> >  	pc->chip.dev = &pdev->dev;
> >  	pc->chip.ops = &mtk_pwm_ops;
> >  	pc->chip.base = -1;
> > -	pc->chip.npwm = data->num_pwms;
> > +	pc->chip.npwm = num_pwms;
> >  
> >  	ret = pwmchip_add(&pc->chip);
> >  	if (ret < 0) {
> 
> Best regards
> Uwe
> 


