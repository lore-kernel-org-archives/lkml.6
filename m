Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11A2ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C53320685
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:48:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C53320685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389807AbeGWNsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:48:36 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51215 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389782AbeGWNse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:48:34 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1fhaFM-0006uC-4L; Mon, 23 Jul 2018 14:47:28 +0200
Message-ID: <1532350048.3163.101.camel@pengutronix.de>
Subject: Re: [PATCH/RFT 2/6] i2c: imx: use open drain for recovery GPIO
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-i2c@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Date:   Mon, 23 Jul 2018 14:47:28 +0200
In-Reply-To: <20180713210920.3648-3-wsa+renesas@sang-engineering.com>
References: <20180713210920.3648-1-wsa+renesas@sang-engineering.com>
         <20180713210920.3648-3-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, den 13.07.2018, 23:09 +0200 schrieb Wolfram Sang:
> I2C is open drain, so set up the GPIO accordingly.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

I don't think this matters on any of the i.MX platforms, as the GPIO
pin configuration (including open-drain) is only taken from the DT
pinctrl, with the GPIO driver not being able to change any of those. On
 the flipside this results in a near zero probability of regressions.
;)

As this is obviously right even if it doesn't have any effect on
current software:

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/i2c/busses/i2c-imx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index 0207e194f84b..3e23ee26c55c 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -1010,7 +1010,7 @@ static int i2c_imx_init_recovery_info(struct imx_i2c_struct *i2c_imx,
> >  	i2c_imx->pinctrl_pins_gpio = pinctrl_lookup_state(i2c_imx->pinctrl,
> >  			"gpio");
> >  	rinfo->sda_gpiod = devm_gpiod_get(&pdev->dev, "sda", GPIOD_IN);
> > -	rinfo->scl_gpiod = devm_gpiod_get(&pdev->dev, "scl", GPIOD_OUT_HIGH);
> > +	rinfo->scl_gpiod = devm_gpiod_get(&pdev->dev, "scl", GPIOD_OUT_HIGH_OPEN_DRAIN);
>  
> >  	if (PTR_ERR(rinfo->sda_gpiod) == -EPROBE_DEFER ||
> >  	    PTR_ERR(rinfo->scl_gpiod) == -EPROBE_DEFER) {
