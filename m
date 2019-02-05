Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035CCC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 21:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBFE92077B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 21:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbfBEVz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 16:55:58 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:46043 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbfBEVz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 16:55:58 -0500
X-Originating-IP: 86.202.150.119
Received: from localhost (lfbn-lyo-1-59-119.w86-202.abo.wanadoo.fr [86.202.150.119])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id A6A601BF207;
        Tue,  5 Feb 2019 21:55:54 +0000 (UTC)
Date:   Tue, 5 Feb 2019 22:55:52 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Oliver.Rohe@wago.com
Cc:     a.zummo@towertech.it, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: rs5c372: Fix reading from rtc when the oscillator
 got interrupted.
Message-ID: <20190205215552.GH24598@piout.net>
References: <1547212521-14871-1-git-send-email-oliver.rohe@wago.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547212521-14871-1-git-send-email-oliver.rohe@wago.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/01/2019 13:15:39+0000, Oliver.Rohe@wago.com wrote:
> When the oscillator of the rtc gets interrupted,
> e.g. due to an empty battery, reading from the rtc will now return an error
> and the oscillator bit will be cleared, once the rtc is successfully reset.
> 
> Signed-off-by: Oliver Rohe <oliver.rohe@wago.com>
> ---
>  drivers/rtc/rtc-rs5c372.c | 60 ++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 52 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-rs5c372.c b/drivers/rtc/rtc-rs5c372.c
> index ff35dce..91d1475 100644
> --- a/drivers/rtc/rtc-rs5c372.c
> +++ b/drivers/rtc/rtc-rs5c372.c
> @@ -52,8 +52,10 @@
>  #	define RS5C_CTRL1_CT4		(4 << 0)	/* 1 Hz level irq */
>  #define RS5C_REG_CTRL2		15
>  #	define RS5C372_CTRL2_24		(1 << 5)
> -#	define R2x2x_CTRL2_XSTP		(1 << 5)	/* only if R2x2x */
> -#	define RS5C_CTRL2_XSTP		(1 << 4)	/* only if !R2x2x */
> +#	define RS5C_CTRL2_XSTP          (1 << 4)        /* only if !R2x2x */

This should probably use tabs instead of spaces

> +#	define R2x2x_CTRL2_VDET		(1 << 6)	/* only if  R2x2x */
> +#	define R2x2x_CTRL2_XSTP		(1 << 5)	/* only if  R2x2x */
> +#	define R2x2x_CTRL2_PON		(1 << 4)	/* only if  R2x2x */
>  #	define RS5C_CTRL2_CTFG		(1 << 2)
>  #	define RS5C_CTRL2_AAFG		(1 << 1)	/* or WAFG */
>  #	define RS5C_CTRL2_BAFG		(1 << 0)	/* or DAFG */
> @@ -212,10 +214,31 @@ static int rs5c372_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  	struct i2c_client *client = to_i2c_client(dev);
>  	struct rs5c372	*rs5c = i2c_get_clientdata(client);
>  	int		status = rs5c_get_regs(rs5c);
> +	unsigned char ctrl2 = rs5c->regs[RS5C_REG_CTRL2];
>  
>  	if (status < 0)
>  		return status;
>  
> +	switch (rs5c->type) {
> +	case rtc_r2025sd:
> +	case rtc_r2221tl:
> +		if (ctrl2 & R2x2x_CTRL2_VDET)
> +			dev_warn(&client->dev, "rtc battery voltage drop below threshold detected.\n");

VDET doesn't mean anything specific regarding timekeeping so I wouldn't warn here.

> +		if (ctrl2 & R2x2x_CTRL2_PON)
> +			dev_warn(&client->dev, "rtc battery voltage drop to zero detected.\n");

You should return -EINVAL directly here

> +		if ((rs5c->type == rtc_r2025sd && !(ctrl2 & R2x2x_CTRL2_XSTP)) ||
> +		    (rs5c->type == rtc_r2221tl &&  (ctrl2 & R2x2x_CTRL2_XSTP))) {
> +			dev_warn(&client->dev, "rtc oscillator interruption detected. Please reset the rtc clock.\n");
> +			return -EIO;

-EINVAL is the correct error code here.

> +		}
> +		break;
> +	default:
> +		if (ctrl2 & RS5C_CTRL2_XSTP) {
> +			dev_warn(&client->dev, "rtc oscillator interruption detected. Please reset the rtc clock.\n");
> +			return -EIO;

and here.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
