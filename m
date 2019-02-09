Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F16FFC282CB
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 16:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF25E218D2
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 16:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljHRmsvR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfBIQzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 11:55:00 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42944 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfBIQy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 11:54:59 -0500
Received: by mail-pg1-f194.google.com with SMTP id d72so2937457pga.9;
        Sat, 09 Feb 2019 08:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qEZzJHcylJ9LHFY0jUcwu5U2MgfuaTdVAvvabfd0KS0=;
        b=ljHRmsvRMBH70O1VIvTrPWEIDz98MKOB0sz/TnBk/i7ZxvFuZa2tg+8tCGYNnNDFyO
         TXorArovxsbl5zS+CnxJMTqQGwFVLUcFa5sSFJNGz4+p07staeONEFrxUbdWfi5gJ+do
         TH4hgDJCxljbv3SpMqxX5kLKw2bo1sd/4bum6qOucRphMfIa4ft3A65RL84jP1mTP1W1
         EAAg+woGg8BooDskLxvmGB65tBwmFwhpCF6mH8xgR3QAnpsQKx4nv+GA2IIZ3F+o6+mu
         Bn9ItUo8vZSAlobQh59mWu488rvKBAF7aSMHIJXERNcnAysHHNQ9kN2sOmxQ9V429Dpu
         Tg/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qEZzJHcylJ9LHFY0jUcwu5U2MgfuaTdVAvvabfd0KS0=;
        b=UqyXugLRoNKbNEFRKylhkA2V0MTk3sZ4caBObq+C3BNBdUbnDQI9P9uazvULMBos43
         8Z0VfLAOfa0kc+QvpWj8gpZ8orvoH1aH5yTlpUpIPkl0P1WlSMBxaFl1WGqkUekV4ZwJ
         bw3xIlTB/vcOEDRVNk92mwoR7irJSCYLfU8Qw5jeOP1EOf/unG0fJdF5hRUOHRWpc7TX
         DoqDHCFA6dLxTy305ZUDvxLK+elzIsXZUq3Q0M4Edr3PoDwjc/keuDMdTwvXlANXvOPt
         +ahN4cvP6nnw5JtNdaBJH8rmgt75RraJTMCXEN9H+fFVLP0DSXfXd4heyPoUDe2NiW1R
         ydGw==
X-Gm-Message-State: AHQUAubco+h8F5VDInsK3TXbYGMX5hsv6n6/XcPBWi+Mo1/gb46svdJ2
        WuDWgaWNhMbqvpEXoOiKB5E=
X-Google-Smtp-Source: AHgI3Ibt/C/kuey/ZoIO+9I+IdyilbqwLup3Qe53GhiNo7srlsrpix5v34AULuYmgq+vHtitDWZdIQ==
X-Received: by 2002:a63:c303:: with SMTP id c3mr11431128pgd.268.1549731298550;
        Sat, 09 Feb 2019 08:54:58 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id t3sm6182016pgv.31.2019.02.09.08.54.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Feb 2019 08:54:57 -0800 (PST)
Date:   Sat, 9 Feb 2019 08:54:56 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Martin Kepplinger <martin.kepplinger@ginzinger.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Input: st1232 - switch to gpiod API
Message-ID: <20190209165456.GD197782@dtor-ws>
References: <20190208161533.25230-1-martin.kepplinger@ginzinger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208161533.25230-1-martin.kepplinger@ginzinger.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 05:15:33PM +0100, Martin Kepplinger wrote:
> Use devm_gpiod_get_optional() and gpiod_set_value_cansleep() instead
> of the old API. The st1232_ts_power() now passes on the inverted "poweron"
> value to reflect the correct logical value.
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>

Applied, thank you.

> ---
> 
> ok. tested. If i get that right, assigning different gpio functions
> would now be difficult, but afaik isn't needed anyways.
> 
> thanks
>                                   martin
> 
> 
> 
> revision history
> ----------------
> v2: retain dts compatibility by allowing current reset-gpios setting
> 
> 
>  drivers/input/touchscreen/st1232.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/st1232.c b/drivers/input/touchscreen/st1232.c
> index 634d6c243845..1fbc0847416b 100644
> --- a/drivers/input/touchscreen/st1232.c
> +++ b/drivers/input/touchscreen/st1232.c
> @@ -45,7 +45,7 @@ struct st1232_ts_data {
>  	struct i2c_client *client;
>  	struct input_dev *input_dev;
>  	struct dev_pm_qos_request low_latency_req;
> -	int reset_gpio;
> +	struct gpio_desc *reset_gpio;
>  	const struct st_chip_info *chip_info;
>  	int read_buf_len;
>  	u8 *read_buf;
> @@ -142,8 +142,8 @@ static irqreturn_t st1232_ts_irq_handler(int irq, void *dev_id)
>  
>  static void st1232_ts_power(struct st1232_ts_data *ts, bool poweron)
>  {
> -	if (gpio_is_valid(ts->reset_gpio))
> -		gpio_direction_output(ts->reset_gpio, poweron);
> +	if (ts->reset_gpio)
> +		gpiod_set_value_cansleep(ts->reset_gpio, !poweron);
>  }
>  
>  static const struct st_chip_info st1232_chip_info = {
> @@ -215,15 +215,13 @@ static int st1232_ts_probe(struct i2c_client *client,
>  	ts->client = client;
>  	ts->input_dev = input_dev;
>  
> -	ts->reset_gpio = of_get_gpio(client->dev.of_node, 0);
> -	if (gpio_is_valid(ts->reset_gpio)) {
> -		error = devm_gpio_request(&client->dev, ts->reset_gpio, NULL);
> -		if (error) {
> -			dev_err(&client->dev,
> -				"Unable to request GPIO pin %d.\n",
> -				ts->reset_gpio);
> -				return error;
> -		}
> +	ts->reset_gpio = devm_gpiod_get_optional(&client->dev, NULL,
> +						 GPIOD_OUT_HIGH);
> +	if (IS_ERR(ts->reset_gpio)) {
> +		error = PTR_ERR(ts->reset_gpio);
> +		dev_err(&client->dev, "Unable to request GPIO pin: %d.\n",
> +			error);
> +		return error;
>  	}
>  
>  	st1232_ts_power(ts, true);
> -- 
> 2.20.1
> 



-- 
Dmitry
