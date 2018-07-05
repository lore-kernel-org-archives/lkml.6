Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2C4C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 05:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C63782086E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 05:24:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C63782086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753372AbeGEFYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 01:24:06 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37269 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752100AbeGEFYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 01:24:04 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1fawkC-0000FS-0h; Thu, 05 Jul 2018 07:23:52 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1fawk6-00086v-JP; Thu, 05 Jul 2018 07:23:46 +0200
Date:   Thu, 5 Jul 2018 07:23:46 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Phil Reid <preid@electromag.com.au>,
        Lucas Stach <l.stach@pengutronix.de>,
        Clemens Gruber <clemens.gruber@pqgruber.com>,
        Peter Rosin <peda@axentia.se>, patches@opensource.cirrus.com,
        linux-i2c@vger.kernel.org
Subject: Re: [PATCH] gpiolib: Defer on non-DT find_chip_by_name() failure
Message-ID: <20180705052346.6iwanz5kx3ive42a@pengutronix.de>
References: <20180703172635.32508-1-jmkrzyszt@gmail.com>
 <20180703193141.747fa950@bbrezillon>
 <7058252.SGNltMTCCa@z50>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7058252.SGNltMTCCa@z50>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Jul 04, 2018 at 09:13:42PM +0200, Janusz Krzysztofik wrote:
> On Tuesday, July 3, 2018 7:31:41 PM CEST Boris Brezillon wrote:
> > Hi Janusz,
> > 
> > On Tue,  3 Jul 2018 19:26:35 +0200
> > 
> > Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
> > > Avoid replication of error code conversion in non-DT GPIO consumers'
> > > code by returning -EPROBE_DEFER from gpiod_find() in case a chip
> > > identified by its label in a registered lookup table is not ready.
> > > 
> > > See https://lkml.org/lkml/2018/5/30/176 for example case.
> > > 
> > > Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> > > ---
> > > If accepted, please add
> > > 
> > > 	Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
> > > 
> > > if Boris doesn't mind.
> > > 
> > > Thanks,
> > > Janusz
> > > 
> > >  drivers/gpio/gpiolib.c | 13 ++++++++++---
> > >  1 file changed, 10 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> > > index e11a3bb03820..15dc77c80328 100644
> > > --- a/drivers/gpio/gpiolib.c
> > > +++ b/drivers/gpio/gpiolib.c
> > > @@ -3639,9 +3639,16 @@ static struct gpio_desc *gpiod_find(struct device
> > > *dev, const char *con_id,> 
> > >  		chip = find_chip_by_name(p->chip_label);
> > >  		
> > >  		if (!chip) {
> > > 
> > > -			dev_err(dev, "cannot find GPIO chip %s\n",
> > > -				p->chip_label);
> > > -			return ERR_PTR(-ENODEV);
> > > +			/*
> > > +			 * As the lookup table indicates a chip with
> > > +			 * p->chip_label should exist, assume it may
> > > +			 * still appear latar and let the interested
> > 
> > 					^ later
> > 
> > > +			 * consumer be probed again or let the Deferred
> > > +			 * Probe infrastructure handle the error.
> > > +			 */
> > > +			dev_warn(dev, "cannot find GPIO chip %s, deferring\n",
> > > +				 p->chip_label);
> > > +			return ERR_PTR(-EPROBE_DEFER);
> > > 
> > >  		}
> > >  		
> > >  		if (chip->ngpio <= p->chip_hwnum) {
> > 
> > Looks good otherwise. Let's hope we're not breaking implementations
> > testing for -ENODEV...
> 
> I've reviewed them all and found two which I think may be affected:
> - drivers/mfd/arizona-core.c,
> - drivers/i2c/busses/i2c-imx.c.
> As far as I can understand the code, both depend on error != -EPROBE_DEFER in 
> order to continue in degraded mode. I'm adding their maintainers to the loop.

TL;DR: Either I don't understand the implication for
drivers/i2c/busses/i2c-imx.c or everything is fine.

Given that only i2c_imx_init_recovery_info() uses gpio functions I assume
you mean:

        rinfo->sda_gpiod = devm_gpiod_get(&pdev->dev, "sda", GPIOD_IN);
        rinfo->scl_gpiod = devm_gpiod_get(&pdev->dev, "scl", GPIOD_OUT_HIGH);

        if (PTR_ERR(rinfo->sda_gpiod) == -EPROBE_DEFER ||
            PTR_ERR(rinfo->scl_gpiod) == -EPROBE_DEFER) {
                return -EPROBE_DEFER;
        } else if (IS_ERR(rinfo->sda_gpiod) ||
                   IS_ERR(rinfo->scl_gpiod) ||
                   IS_ERR(i2c_imx->pinctrl_pins_default) ||
                   IS_ERR(i2c_imx->pinctrl_pins_gpio)) {
                dev_dbg(&pdev->dev, "recovery information incomplete\n");
                return 0;
        }

So if a patch changes devm_gpiod_get() to return -EPROBE_DEFER in more
cases that doesn't seem to hurt. Moreover TTBOMK this driver should only
be used by dt-machines today such that changing gpio* for non-DT users
shouldn't affect it.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
