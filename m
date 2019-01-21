Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85852C282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C779214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729808AbfAUIt6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:49:58 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56065 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729757AbfAUIt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 03:49:57 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1glVHB-0003tK-74; Mon, 21 Jan 2019 09:49:49 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1glVHA-0000YN-GN; Mon, 21 Jan 2019 09:49:48 +0100
Date:   Mon, 21 Jan 2019 09:49:48 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        Sean Wang <sean.wang@kernel.org>,
        Weijie Gao <weijie.gao@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 1/5] pwm: mediatek: add a property "mediatek,num-pwms"
Message-ID: <20190121084948.frpcgg6wkdjxkl7k@pengutronix.de>
References: <de316385a84e079d3b23891e61c959094b9fa7e5.1547781007.git.ryder.lee@mediatek.com>
 <c007d399-af86-98d3-94f9-b9762efdc219@gmail.com>
 <1547866487.14213.10.camel@mtkswgap22>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1547866487.14213.10.camel@mtkswgap22>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 19, 2019 at 10:54:47AM +0800, Ryder Lee wrote:
> On Fri, 2019-01-18 at 09:43 +0100, Matthias Brugger wrote:
> > 
> > On 18/01/2019 04:24, Ryder Lee wrote:
> > > This adds a property "mediatek,num-pwms" to avoid having an endless
> > > list of compatibles with no differences for the same driver.
> > > 
> > > Thus, the driver should have backwards compatibility to older DTs.
> > > 
> > > Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> > > ---
> > > Changes since v1: add some checks for backwards compatibility.
> > > ---
> > >  drivers/pwm/pwm-mediatek.c | 27 ++++++++++++++++++---------
> > >  1 file changed, 18 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
> > > index eb6674c..81b7e5e 100644
> > > --- a/drivers/pwm/pwm-mediatek.c
> > > +++ b/drivers/pwm/pwm-mediatek.c
> > > @@ -55,7 +55,7 @@ enum {
> > >  };
> > >  
> > >  struct mtk_pwm_platform_data {
> > > -	unsigned int num_pwms;
> > > +	unsigned int num_pwms;	/* it should not be used in the future SoCs */
> > >  	bool pwm45_fixup;
> > >  	bool has_clks;
> > >  };
> > > @@ -226,27 +226,36 @@ static void mtk_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
> > >  
> > >  static int mtk_pwm_probe(struct platform_device *pdev)
> > >  {
> > > -	const struct mtk_pwm_platform_data *data;
> > > +	struct device_node *np = pdev->dev.of_node;
> > >  	struct mtk_pwm_chip *pc;
> > >  	struct resource *res;
> > > -	unsigned int i;
> > > +	unsigned int i, num_pwms;
> > >  	int ret;
> > >  
> > >  	pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
> > >  	if (!pc)
> > >  		return -ENOMEM;
> > >  
> > > -	data = of_device_get_match_data(&pdev->dev);
> > > -	if (data == NULL)
> > > -		return -EINVAL;
> > > -	pc->soc = data;
> > > +	pc->soc = of_device_get_match_data(&pdev->dev);
> > >  
> > >  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > >  	pc->regs = devm_ioremap_resource(&pdev->dev, res);
> > >  	if (IS_ERR(pc->regs))
> > >  		return PTR_ERR(pc->regs);
> > >  
> > > -	for (i = 0; i < data->num_pwms + 2 && pc->soc->has_clks; i++) {
> > > +	/* Check if we have set 'num-pwms' in DTs. */
> > > +	ret = of_property_read_u32(np, "mediatek,num-pwms", &num_pwms);
> > > +	if (ret < 0) {
> > > +		/* If no, fallback to use SoC data for backwards compatibility. */
> > > +		if (pc->soc->num_pwms) {
> > > +			num_pwms = pc->soc->num_pwms;
> > 
> > Maybe that's bike shedding, but I think it would be better to carve out the
> > num_pwms from the mtk_pwm_platform_data and check against the compatible here.
> 
> I'm not sure how to properly curve it out? I think we still need this
> variable to save the specific value for some legacy SoCs (with older
> DTs).

I guess he means  something like:

	if (is_compatible_to_variant_A(dev))
		num_pwms = 12;
	else if (is_compatible_to_variant_B(dev))
		num_pwms = 2;

. In my eyes the bike shed should be light red and I prefer to collect
the fallback num_pwms in the compatible_data as is to keep the code
simpler. Maybe rename the member from num_pwms to fallback_num_pwms to
make it more obvious that it doesn't represent the actually used value.

> > With a expressive comment it will help other driver developers to not start
> > adding num_pwms in the platform data in their first attempt.
> 
> Definitely.

My suggestion was to add a dev_warn, which IMHO is still better than a
comment.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
