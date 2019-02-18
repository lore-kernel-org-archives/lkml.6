Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85AB7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 07:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5314F218AD
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 07:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbh/3vJT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbfBRHIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 02:08:42 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45580 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbfBRHIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 02:08:42 -0500
Received: by mail-pf1-f195.google.com with SMTP id v21so5080357pfm.12;
        Sun, 17 Feb 2019 23:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AtxCKAT91JRCkb05tIJmackg3Y6pCfaHO7zK/0r/OJY=;
        b=mbh/3vJT+uIUN5qJOWPC6NYHF8D1JzAa8jNCbnQP3PCXPaPY9kQGX1wfuKybYKP6zj
         MgfqXMTBBMds9qGQus1iHAkDl0nWqYKJ0zYV7ln43eTtRYJDlmK9Yw9MSb8roKmhNGqq
         5HGA8yrCatShM7Xjed272nScHwoKtamYEwylf0NhZAWr+SNk9mZOC16X2jk+8j7Dgx+B
         4sCWqhTrwVgv0nC5x533IqNZBTQrr4yH/wNYmziSn0nkLKbb915WxiMk3QhlN6Ptqavs
         idPzXfb8E2AsRp+yEmXPoUXqHExc2lrQLL7kpVrizAmcX+evuSreNm/Xw3Jcs81GVoV6
         4LZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AtxCKAT91JRCkb05tIJmackg3Y6pCfaHO7zK/0r/OJY=;
        b=RhpJm5vDZg8wVyfaDO5MIiEHKnSSEuSbGUzoceiUy2jhhXx5ElILMRuQcUS5OrMiZX
         aha+ejxdmrwux4ucgZ8+BdU1RKW6GzGiQrZfaTyRdHN4FPqOf/KkUZr2jLD03zNvrVOk
         iez1HieokcVtLUKt7MJk/HbZTlVL23VthOmAtJif0Rfa9iL+71QYflUkpHN0YceY+VLS
         xu5WLj09zaHh1lgYE7VanrmGEmXKuFFltQiCwfHG21YHqUECciQMvfLqIQlhxhTt84Z1
         j5BsETZ5NaaAD8/RDyXLq5cjPt9YtfTPFDvNkafbvqb/OeA1B4w50PUptAZ2WTXVnK9l
         QCiA==
X-Gm-Message-State: AHQUAuYs5+8pStcnmHlS6JAnFb3SqurP8xYMB9N9VoplDL5qlGfC0AA/
        IcEs04zF5eLPLyZ8OeXdO7X8+k9r
X-Google-Smtp-Source: AHgI3IZxGnZvN6DWsCvqSyzkcZOB/voRfY2DeFde/GV/b7Asq+uGc+JZCCG0B/x/H/Ob6k9zY5WarQ==
X-Received: by 2002:aa7:808a:: with SMTP id v10mr23120260pff.8.1550473720598;
        Sun, 17 Feb 2019 23:08:40 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id n75sm22537927pfb.39.2019.02.17.23.08.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Feb 2019 23:08:39 -0800 (PST)
Date:   Sun, 17 Feb 2019 23:08:38 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Bastien Nocera <hadess@hadess.net>,
        Rob Herring <robh+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v4 2/4] Input: goodix - Add AVDD28-supply regulator
 support
Message-ID: <20190218070838.GD242714@dtor-ws>
References: <20190212112439.2025-1-jagan@amarulasolutions.com>
 <20190212112439.2025-3-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212112439.2025-3-jagan@amarulasolutions.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jagan,

On Tue, Feb 12, 2019 at 04:54:37PM +0530, Jagan Teki wrote:
> Goodix CTP controllers have AVDD28 pin connected to voltage
> regulator which may not be turned on by default, like for GT5663.
> 
> Add support for such ctp used boards by adding voltage regulator
> handling code to goodix ctp driver.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  drivers/input/touchscreen/goodix.c | 44 ++++++++++++++++++++++++++----
>  1 file changed, 39 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
> index f2d9c2c41885..e92b90be1ac2 100644
> --- a/drivers/input/touchscreen/goodix.c
> +++ b/drivers/input/touchscreen/goodix.c
> @@ -27,6 +27,7 @@
>  #include <linux/delay.h>
>  #include <linux/irq.h>
>  #include <linux/interrupt.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
>  #include <linux/acpi.h>
>  #include <linux/of.h>
> @@ -47,6 +48,7 @@ struct goodix_ts_data {
>  	struct touchscreen_properties prop;
>  	unsigned int max_touch_num;
>  	unsigned int int_trigger_type;
> +	struct regulator *avdd28;
>  	struct gpio_desc *gpiod_int;
>  	struct gpio_desc *gpiod_rst;
>  	u16 id;
> @@ -761,6 +763,13 @@ static void goodix_config_cb(const struct firmware *cfg, void *ctx)
>  	complete_all(&ts->firmware_loading_complete);
>  }
>  
> +static void goodix_disable_regulator(void *arg)
> +{
> +	struct goodix_ts_data *ts = arg;
> +
> +	regulator_disable(ts->avdd28);
> +}
> +
>  static int goodix_ts_probe(struct i2c_client *client,
>  			   const struct i2c_device_id *id)
>  {
> @@ -786,25 +795,46 @@ static int goodix_ts_probe(struct i2c_client *client,
>  	if (error)
>  		return error;
>  
> +	ts->avdd28 = devm_regulator_get(&client->dev, "AVDD28");
> +	if (IS_ERR(ts->avdd28)) {
> +		error = PTR_ERR(ts->avdd28);
> +		if (error != -EPROBE_DEFER)
> +			dev_err(&client->dev,
> +				"Failed to get AVDD28 regulator: %d\n", error);
> +		return error;
> +	}
> +
> +	/* power the controller */
> +	error = regulator_enable(ts->avdd28);
> +	if (error) {
> +		dev_err(&client->dev, "Controller fail to enable AVDD28\n");
> +		return error;
> +	}
> +
> +	error = devm_add_action_or_reset(&client->dev,
> +					 goodix_disable_regulator, ts);
> +	if (error)
> +		return error;
> +
>  	if (ts->gpiod_int && ts->gpiod_rst) {
>  		/* reset the controller */
>  		error = goodix_reset(ts);
>  		if (error) {
>  			dev_err(&client->dev, "Controller reset failed.\n");
> -			return error;
> +			goto error;

Why are you changing this? You added goodix_disable_regulator() as
custom devm action, so it will fire if probe() returns with error.

Thanks.

-- 
Dmitry
