Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751731AbeCNU67 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 16:58:59 -0400
Received: from avasout05.plus.net ([84.93.230.250]:35272 "EHLO
        avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbeCNU65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 16:58:57 -0400
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=J9KEEjvS c=1 sm=1 tr=0
 a=o7Djd4SkmPXITDn8qH+ssQ==:117 a=o7Djd4SkmPXITDn8qH+ssQ==:17
 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10 a=pGLkceISAAAA:8 a=RMjmPgqFiLURycAYgZkA:9
 a=CjuIK1q_8ugA:10
Date: Wed, 14 Mar 2018 20:51:24 +0000
From: Nick Dyer <nick@shmanahar.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/14] Input: atmel_mxt_ts - do not pass suspend mode in
 platform data
Message-ID: <20180314205123.GA26353@lava.h.shmanahar.org>
References: <20180312190907.174301-1-dmitry.torokhov@gmail.com>
 <20180312190907.174301-2-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312190907.174301-2-dmitry.torokhov@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CMAE-Envelope: MS4wfBg5HndNXzZIqiwp/cT9/vwMkDO5FlhTgQcix9op7nQGGmgj6bJ4+8UouebsH0u3X7lL5hUhNv0hZNcu8rYKq+Af4tdWCcdt8uEGWHdwvj0ZY9dBJ7DK
 RJX5IJ2Gf3AKCbevbJtb35ZT4r8IGptvcf3rA/1/TpwtxRvahUniTR4o
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry-

Thanks for sending these patches!

On Mon, Mar 12, 2018 at 12:08:54PM -0700, Dmitry Torokhov wrote:
> The way we are supposed to put controller to sleep and wake it up does not
> depend on the platform, but rather on controller itself. Controllers using
> T9 require manipulating T9 control register, while others, using newer
> T100, should be put to sleep by adjusting T7 power config.

I'm afraid this is actually a misconception. If you look at object table
for the older T9 device, you'll find it has the T7 object and it in fact
works exactly the same way as the T100-based device.

The MXT_SUSPEND_T9_CTRL is in there because on your older Pixel devices
the config saved into NVRAM on the touch controller has a zero byte in
the T9 CTRL setting, meaning the touch controller will never wake up
unless the driver knows to write 0x83 into it.

> We'll keep pdata->suspend_mode for now and remove it when we rework
> chromeos-laptop driver.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/touchscreen/atmel_mxt_ts.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> index 7659bc48f1db8..1aabfae1297ba 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -2868,8 +2868,8 @@ static const struct attribute_group mxt_attr_group = {
>  
>  static void mxt_start(struct mxt_data *data)
>  {
> -	switch (data->pdata->suspend_mode) {
> -	case MXT_SUSPEND_T9_CTRL:
> +	switch (data->multitouch) {
> +	case MXT_TOUCH_MULTI_T9:
>  		mxt_soft_reset(data);
>  
>  		/* Touch enable */
> @@ -2878,7 +2878,7 @@ static void mxt_start(struct mxt_data *data)
>  				MXT_TOUCH_MULTI_T9, MXT_T9_CTRL, 0x83);
>  		break;
>  
> -	case MXT_SUSPEND_DEEP_SLEEP:
> +	case MXT_TOUCH_MULTITOUCHSCREEN_T100:
>  	default:
>  		mxt_set_t7_power_cfg(data, MXT_POWER_CFG_RUN);
>  
> @@ -2886,19 +2886,18 @@ static void mxt_start(struct mxt_data *data)
>  		mxt_t6_command(data, MXT_COMMAND_CALIBRATE, 1, false);
>  		break;
>  	}
> -
>  }
>  
>  static void mxt_stop(struct mxt_data *data)
>  {
> -	switch (data->pdata->suspend_mode) {
> -	case MXT_SUSPEND_T9_CTRL:
> +	switch (data->multitouch) {
> +	case MXT_TOUCH_MULTI_T9:
>  		/* Touch disable */
>  		mxt_write_object(data,
>  				MXT_TOUCH_MULTI_T9, MXT_T9_CTRL, 0);
>  		break;
>  
> -	case MXT_SUSPEND_DEEP_SLEEP:
> +	case MXT_TOUCH_MULTITOUCHSCREEN_T100:
>  	default:
>  		mxt_set_t7_power_cfg(data, MXT_POWER_CFG_DEEPSLEEP);
>  		break;
> @@ -2954,8 +2953,6 @@ static const struct mxt_platform_data *mxt_parse_dt(struct i2c_client *client)
>  		pdata->t19_keymap = keymap;
>  	}
>  
> -	pdata->suspend_mode = MXT_SUSPEND_DEEP_SLEEP;
> -
>  	return pdata;
>  }
>  #else
> -- 
> 2.16.2.660.g709887971b-goog
> 
