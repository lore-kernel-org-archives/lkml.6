Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E07C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93D232086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:53:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfARJxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 04:53:21 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46589 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbfARJxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 04:53:21 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gkQpu-00073h-0Z; Fri, 18 Jan 2019 10:53:14 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gkQpt-0006HG-KN; Fri, 18 Jan 2019 10:53:13 +0100
Date:   Fri, 18 Jan 2019 10:53:13 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        Sean Wang <sean.wang@kernel.org>,
        Weijie Gao <weijie.gao@mediatek.com>,
        linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 1/5] pwm: mediatek: add a property "mediatek,num-pwms"
Message-ID: <20190118095313.pbpdn43hd76khg2x@pengutronix.de>
References: <de316385a84e079d3b23891e61c959094b9fa7e5.1547781007.git.ryder.lee@mediatek.com>
 <20190118075925.noilab6glzm3cig6@pengutronix.de>
 <1547804574.8124.6.camel@mtkswgap22>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1547804574.8124.6.camel@mtkswgap22>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ryder,

On Fri, Jan 18, 2019 at 05:42:54PM +0800, Ryder Lee wrote:
> On Fri, 2019-01-18 at 08:59 +0100, Uwe Kleine-König wrote:
> > Hello,
> > 
> > On Fri, Jan 18, 2019 at 11:24:41AM +0800, Ryder Lee wrote:
> > > This adds a property "mediatek,num-pwms" to avoid having an endless
> > > list of compatibles with no differences for the same driver.
> > > 
> > > Thus, the driver should have backwards compatibility to older DTs.
> > 
> > I still think Thierry should bless "num-pwms" without vendor prefix.
> 
> Okay.
> 
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
> > 
> > Unrelated to this patch: This name is bad. This struct is not used as
> > platform_data and so should better be named mtk_pwm_of_data. While at
> > criticizing existing stuff: I'd prefer pwm_mediatek as common prefix to
> > match the filename.
> 
> I think we can take care about that in another patch.

That's what I wanted to say, right. Do you follow up?

> > > -	unsigned int num_pwms;
> > > +	unsigned int num_pwms;	/* it should not be used in the future SoCs */
> > 
> > I'd drop this comment in favour of a runtime warning.
> 
> Sorry, I can't get you here.

I'd do a

	dev_warn(dev, "dt didn't specify number of PWMs, falling back to %d\n", pc->soc->num_pwms);

to make people aware that updating the dt would be nice.

> 
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
> > 
> > This might return NULL which ...
> 
> The only way to call probe() is to match an entry in
> mtk_pwm_of_match[], so match cannot be NULL.

(<pedantic>Theoretically the driver can be probed by device name, but
that is not what I meant here.</pedantic>).

You're right, as long as all entries in mtk_pwm_of_match have a non-NULL
.data entry, you're fine. I somehow thought there might be some without
one. I wouldn't oppose to check for that anyhow as a defensive measure.

> > > [...]
> > > +	/* Check if we have set 'num-pwms' in DTs. */
> > > +	ret = of_property_read_u32(np, "mediatek,num-pwms", &num_pwms);
> > > +	if (ret < 0) {
> > > +		/* If no, fallback to use SoC data for backwards compatibility. */
> > > +		if (pc->soc->num_pwms) {
> > 
> > ... here then results in a NULL pointer dereference. I think you want
> 
> So we have no chance to get a NULL pointer, right?

Ack.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
