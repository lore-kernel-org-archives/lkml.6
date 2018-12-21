Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9B3C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 05:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75673218E0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 05:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Y8hd4ECS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbeLUFBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 00:01:19 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:39722 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbeLUFBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 00:01:19 -0500
Received: from avalon.localnet (unknown [212.213.198.112])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 78366558;
        Fri, 21 Dec 2018 06:01:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1545368475;
        bh=b/ny2p9pitdlV0AfO232pxMv/D3gBr9SRaVq4Gls2Es=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y8hd4ECSGVM4dgxnMyXB20Jv7do/jj5L/jm50XfR8XZEG/dQgA5u/F6EBHN/wkGFj
         youXheUzZCuYZDDoKlsoPW/Bxvr27OlJw4mcW2Ei54xoCLYb6A1gzPr2teH3xfaY4y
         RVBIlyvAu+s5yDL12pY61yEjC6A4yDVgtfRPk+tc=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpu: anx7808: fix a missing check of return value
Date:   Fri, 21 Dec 2018 07:02:11 +0200
Message-ID: <3157460.hcpWlpvoCn@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20181220074116.40546-1-kjlu@umn.edu>
References: <20181220074116.40546-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kangjie,

Thank you for the patch.

On Thursday, 20 December 2018 09:41:16 EET Kangjie Lu wrote:
> Both anx78xx_set_bits() and anx78xx_clear_bits() in the poweron process
> may fail. The fix inserts checks for their return values. If the poweron
> process fails, it calls anx78xx_poweroff().
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/gpu/drm/bridge/analogix-anx78xx.c | 26 ++++++++++++++++-------
>  1 file changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix-anx78xx.c
> b/drivers/gpu/drm/bridge/analogix-anx78xx.c index
> f8433c93f463..a57104c71739 100644
> --- a/drivers/gpu/drm/bridge/analogix-anx78xx.c
> +++ b/drivers/gpu/drm/bridge/analogix-anx78xx.c
> @@ -610,20 +610,20 @@ static int anx78xx_enable_interrupts(struct anx78xx
> *anx78xx) return 0;
>  }
> 
> -static void anx78xx_poweron(struct anx78xx *anx78xx)
> +static int anx78xx_poweron(struct anx78xx *anx78xx)
>  {
>  	struct anx78xx_platform_data *pdata = &anx78xx->pdata;
> -	int err;
> +	int err = 0;
> 
>  	if (WARN_ON(anx78xx->powered))
> -		return;
> +		return err;

You can return 0 here.

> 
>  	if (pdata->dvdd10) {
>  		err = regulator_enable(pdata->dvdd10);
>  		if (err) {
>  			DRM_ERROR("Failed to enable DVDD10 regulator: %d\n",
>  				  err);
> -			return;
> +			return err;
>  		}
> 
>  		usleep_range(1000, 2000);
> @@ -638,12 +638,18 @@ static void anx78xx_poweron(struct anx78xx *anx78xx)
>  	gpiod_set_value_cansleep(pdata->gpiod_reset, 0);
> 
>  	/* Power on registers module */
> -	anx78xx_set_bits(anx78xx->map[I2C_IDX_TX_P2], SP_POWERDOWN_CTRL_REG,
> +	err = anx78xx_set_bits(anx78xx->map[I2C_IDX_TX_P2], SP_POWERDOWN_CTRL_REG,
> SP_HDCP_PD | SP_AUDIO_PD | SP_VIDEO_PD | SP_LINK_PD);
> -	anx78xx_clear_bits(anx78xx->map[I2C_IDX_TX_P2], SP_POWERDOWN_CTRL_REG,
> +	err |= anx78xx_clear_bits(anx78xx->map[I2C_IDX_TX_P2],
> SP_POWERDOWN_CTRL_REG, SP_REGISTER_PD | SP_TOTAL_PD);

If both functions fail with a different error code, this may result in a 
meaningless error being returned. One option is to do

	err = anx78xx_set_bits(...);
	if (!err)
		err = anx78xx_clear_bits(...);

The construct gets quickly ugly though, so I sometimes define register 
accessors as taking an int * for the error code instead of returning it.

void write(..., int *status)
{
	if (*status)
		return;

	*status = real_write(...);
}

and then use it as

	int status = 0;

	write(..., &status);
	write(..., &status);
	write(..., &status);
	write(..., &status);
	write(..., &status);

	return status;

This may be overkill here.

> +	if (err) {
> +		anx78xx_poweroff(anx78xx);
> +		return err;
> +	}
> 
>  	anx78xx->powered = true;
> +
> +	return err;

And return 0 here too, removing the need to initialize the err variable to 0.

>  }
> 
>  static void anx78xx_poweroff(struct anx78xx *anx78xx)
> @@ -1144,7 +1150,9 @@ static irqreturn_t anx78xx_hpd_threaded_handler(int
> irq, void *data) mutex_lock(&anx78xx->lock);
> 
>  	/* Cable is pulled, power on the chip */
> -	anx78xx_poweron(anx78xx);
> +	err = anx78xx_poweron(anx78xx);
> +	if (err)
> +		DRM_ERROR("Failed to power on the chip: %d\n", err);

Wouldn't it be better to move the error message to the an78xx_poweron() 
function ? That way it would also be printed in the probe() path.

>  	err = anx78xx_enable_interrupts(anx78xx);
>  	if (err)
> @@ -1379,7 +1387,9 @@ static int anx78xx_i2c_probe(struct i2c_client
> *client, }
> 
>  	/* Look for supported chip ID */
> -	anx78xx_poweron(anx78xx);
> +	err = anx78xx_poweron(anx78xx);
> +	if (err)
> +		goto err_poweroff;

If poweron fails, doesn't it clean up after itself ? Do you need to call 
poweroff here ?

>  	err = regmap_read(anx78xx->map[I2C_IDX_TX_P2], SP_DEVICE_IDL_REG,
>  			  &idl);

-- 
Regards,

Laurent Pinchart



