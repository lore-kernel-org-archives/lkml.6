Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B32DC5AE5E
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 02:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59E502084C
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 02:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730397AbfASCy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 21:54:56 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:53964 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729963AbfASCyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 21:54:55 -0500
X-UUID: f327d05bb91348bb9364fa396c7f6d65-20190119
X-UUID: f327d05bb91348bb9364fa396c7f6d65-20190119
Received: from mtkcas35.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 945006064; Sat, 19 Jan 2019 10:54:49 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sat, 19 Jan 2019 10:54:47 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sat, 19 Jan 2019 10:54:48 +0800
Message-ID: <1547866487.14213.10.camel@mtkswgap22>
Subject: Re: [PATCH v1 1/5] pwm: mediatek: add a property "mediatek,num-pwms"
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Sean Wang <sean.wang@kernel.org>,
        Weijie Gao <weijie.gao@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Sat, 19 Jan 2019 10:54:47 +0800
In-Reply-To: <c007d399-af86-98d3-94f9-b9762efdc219@gmail.com>
References: <de316385a84e079d3b23891e61c959094b9fa7e5.1547781007.git.ryder.lee@mediatek.com>
         <c007d399-af86-98d3-94f9-b9762efdc219@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-01-18 at 09:43 +0100, Matthias Brugger wrote:
> 
> On 18/01/2019 04:24, Ryder Lee wrote:
> > This adds a property "mediatek,num-pwms" to avoid having an endless
> > list of compatibles with no differences for the same driver.
> > 
> > Thus, the driver should have backwards compatibility to older DTs.
> > 
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
> > -	unsigned int num_pwms;
> > +	unsigned int num_pwms;	/* it should not be used in the future SoCs */
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
> > +			num_pwms = pc->soc->num_pwms;
> 
> Maybe that's bike shedding, but I think it would be better to carve out the
> num_pwms from the mtk_pwm_platform_data and check against the compatible here.

I'm not sure how to properly curve it out? I think we still need this
variable to save the specific value for some legacy SoCs (with older
DTs).

> With a expressive comment it will help other driver developers to not start
> adding num_pwms in the platform data in their first attempt.

Definitely.

Ryder
> 
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
> > 


