Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5191C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 01:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A85E2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 01:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfARBpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 20:45:19 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:21551 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726329AbfARBpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 20:45:18 -0500
X-UUID: 08a6df000c5645ce88415a3bce428800-20190118
X-UUID: 08a6df000c5645ce88415a3bce428800-20190118
Received: from mtkcas36.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1526395871; Fri, 18 Jan 2019 09:45:10 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 18 Jan 2019 09:45:09 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 18 Jan 2019 09:45:02 +0800
Message-ID: <1547775902.22794.1.camel@mtkswgap22>
Subject: Re: [PATCH 1/5] pwm: mediatek: add a property "mediatek,num-pwms"
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Weijie Gao <weijie.gao@mediatek.com>,
        <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Fri, 18 Jan 2019 09:45:02 +0800
In-Reply-To: <0546d8b6-ac67-d445-677a-ff888edf9646@gmail.com>
References: <0c400cb1899c1afb4c9f021350cdc0c6ca3f6239.1547453586.git.ryder.lee@mediatek.com>
         <0546d8b6-ac67-d445-677a-ff888edf9646@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-01-14 at 12:16 +0100, Matthias Brugger wrote:
> 
> On 14/01/2019 09:21, Ryder Lee wrote:
> > This adds a property "mediatek,num-pwms" to avoid having an endless
> > list of compatibles with no other differences for the same driver.
> > 
> > Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> > ---
> >  drivers/pwm/pwm-mediatek.c | 25 +++++++++++--------------
> >  1 file changed, 11 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
> > index eb6674c..37daa84 100644
> > --- a/drivers/pwm/pwm-mediatek.c
> > +++ b/drivers/pwm/pwm-mediatek.c
> > @@ -55,7 +55,6 @@ enum {
> >  };
> >  
> >  struct mtk_pwm_platform_data {
> > -	unsigned int num_pwms;
> >  	bool pwm45_fixup;
> >  	bool has_clks;
> >  };
> > @@ -226,10 +225,11 @@ static void mtk_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
> >  
> >  static int mtk_pwm_probe(struct platform_device *pdev)
> >  {
> > +	struct device_node *np = pdev->dev.of_node;
> >  	const struct mtk_pwm_platform_data *data;
> >  	struct mtk_pwm_chip *pc;
> >  	struct resource *res;
> > -	unsigned int i;
> > +	unsigned int i, num_pwms;
> >  	int ret;
> >  
> >  	pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
> > @@ -246,7 +246,13 @@ static int mtk_pwm_probe(struct platform_device *pdev)
> >  	if (IS_ERR(pc->regs))
> >  		return PTR_ERR(pc->regs);
> >  
> > -	for (i = 0; i < data->num_pwms + 2 && pc->soc->has_clks; i++) {
> > +	ret = of_property_read_u32(np, "mediatek,num-pwms", &num_pwms);
> > +	if (ret < 0) {
> > +		dev_err(&pdev->dev, "failed to get pwm number: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	for (i = 0; i < num_pwms + 2 && pc->soc->has_clks; i++) {
> >  		pc->clks[i] = devm_clk_get(&pdev->dev, mtk_pwm_clk_name[i]);
> >  		if (IS_ERR(pc->clks[i])) {
> >  			dev_err(&pdev->dev, "clock: %s fail: %ld\n",
> > @@ -260,7 +266,7 @@ static int mtk_pwm_probe(struct platform_device *pdev)
> >  	pc->chip.dev = &pdev->dev;
> >  	pc->chip.ops = &mtk_pwm_ops;
> >  	pc->chip.base = -1;
> > -	pc->chip.npwm = data->num_pwms;
> > +	pc->chip.npwm = num_pwms;
> >  
> >  	ret = pwmchip_add(&pc->chip);
> >  	if (ret < 0) {
> > @@ -279,32 +285,23 @@ static int mtk_pwm_remove(struct platform_device *pdev)
> >  }
> >  
> >  static const struct mtk_pwm_platform_data mt2712_pwm_data = {
> > -	.num_pwms = 8,
> > -	.pwm45_fixup = false,
> > -	.has_clks = true,
> > -};
> > -
> > -static const struct mtk_pwm_platform_data mt7622_pwm_data = {
> > -	.num_pwms = 6,
> >  	.pwm45_fixup = false,
> >  	.has_clks = true,
> >  };
> 
> From my point of view that's not perfect. We should make sure that a newer
> kernel does not break with an older device tree and vice versa.
> Just imagine I use some board where u-boot passes the device tree to the kernel,
> I update the kernel and PWM is broken.
> 
> So also it is crappy we will need to have the num_pwms variable for the older
> boards.
> Maybe put a switch in the probe function which checks the compatible with a
> comment message saying that this is for legacy device tree, so that no new
> contributer just copys the wrong code.
> 
> What do you think?

Okay, I will do that.

Ryder
> 
> >  
> >  static const struct mtk_pwm_platform_data mt7623_pwm_data = {
> > -	.num_pwms = 5,
> >  	.pwm45_fixup = true,
> >  	.has_clks = true,
> >  };
> >  
> >  static const struct mtk_pwm_platform_data mt7628_pwm_data = {
> > -	.num_pwms = 4,
> >  	.pwm45_fixup = true,
> >  	.has_clks = false,
> >  };
> >  
> >  static const struct of_device_id mtk_pwm_of_match[] = {
> >  	{ .compatible = "mediatek,mt2712-pwm", .data = &mt2712_pwm_data },
> > -	{ .compatible = "mediatek,mt7622-pwm", .data = &mt7622_pwm_data },
> > +	{ .compatible = "mediatek,mt7622-pwm", .data = &mt2712_pwm_data },
> >  	{ .compatible = "mediatek,mt7623-pwm", .data = &mt7623_pwm_data },
> >  	{ .compatible = "mediatek,mt7628-pwm", .data = &mt7628_pwm_data },
> >  	{ },
> > 


