Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E23C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF5202086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfARJrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 04:47:41 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:50663 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726095AbfARJrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 04:47:40 -0500
X-UUID: 87cf04890925441fb7e609f0cdf5bfed-20190118
X-UUID: 87cf04890925441fb7e609f0cdf5bfed-20190118
Received: from mtkcas32.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1951519869; Fri, 18 Jan 2019 17:47:35 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 18 Jan 2019 17:47:34 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 18 Jan 2019 17:47:33 +0800
Message-ID: <1547804853.8124.9.camel@mtkswgap22>
Subject: Re: [PATCH v1 1/5] pwm: mediatek: add a property "mediatek,num-pwms"
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Sean Wang <sean.wang@kernel.org>,
        Weijie Gao <weijie.gao@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Fri, 18 Jan 2019 17:47:33 +0800
In-Reply-To: <20190118080552.ppwgxboh3gt3nasv@pengutronix.de>
References: <de316385a84e079d3b23891e61c959094b9fa7e5.1547781007.git.ryder.lee@mediatek.com>
         <20190118080552.ppwgxboh3gt3nasv@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-01-18 at 09:05 +0100, Uwe Kleine-König wrote:
> Hello,
> 
> just realized another issue while looking up a driver detail ...
> 
> On Fri, Jan 18, 2019 at 11:24:41AM +0800, Ryder Lee wrote:
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
> > +		} else {
> > +			dev_err(&pdev->dev, "failed to get pwm number: %d\n", ret);
> > +			return ret;
> > +		}
> > +	}
> > +
> > +	for (i = 0; i < num_pwms + 2 && pc->soc->has_clks; i++) {
> >  		pc->clks[i] = devm_clk_get(&pdev->dev, mtk_pwm_clk_name[i]);
> 
> If a dt contains
> 
> 	mediatek,num-pwms = <17>;
> 
> you're accessing pc->clks[18] which is an out-of-bounds access, so
> better check the limit or allocate the clks array dynamically.
> 

Thanks for the reminder. I will fix it in v2.

Ryder


