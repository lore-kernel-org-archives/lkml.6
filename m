Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C1CECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 08:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AE6A2075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 08:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bsI7yQTf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AE6A2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbeGRIp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 04:45:58 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45297 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbeGRIp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 04:45:58 -0400
Received: by mail-wr1-f68.google.com with SMTP id c4-v6so3652851wrs.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 01:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=2pSlMJC9hxDL+y2l4uA71YPcpZQLRESfor/PoAxgbcU=;
        b=bsI7yQTfA506toiWMrRLrtT3UOcwMCeFtPiH9IpZ95scJOo06S6mpxlDMikN512iTE
         ZuLhZZedj0LOJy14VW+jwlft2ErIA37+GlaGAzsNxoVDV49bCIK8nYH5Kiq4Cmd+tx1L
         JGsSkVjBsjWvOeyJcbJDo3QyxVKjVh3Kw9Olc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=2pSlMJC9hxDL+y2l4uA71YPcpZQLRESfor/PoAxgbcU=;
        b=qzlZZjXUcFYMUkWCO1cJdH+fU+Ck+gVs6+FLcZt26Nd2csD6McRgGPeWAMZZfObh/Z
         NeQRKcatl7EZUuQ1kjG6LGu0oxEFrsDiCY+pxI0TLtbmrE8YUamlK69pkKqWeFCLzWNk
         ZJBg4tqbyfGn3jimdeZ10WiqZtmi10DrFp9IDo1cOhUdTDE2hDl3MWnpuS53SYMxFx/j
         CjTZWDRIAa996pasi9m8FLvbGgOMwF/ULGMqWbCCtGX9ykVfxbyYOceJ6q40vCOreoYw
         ukTwATG3VluNbp2uBh/1AsKo2ak/6hShLW11b+AvH998mxljifQ+rq1WHpXqP5WSRUyJ
         6big==
X-Gm-Message-State: AOUpUlGzbeMmD8MMqw1mtjINk5CrnwZ4K9NyHv/0kUhEq2ipVGIUO2oA
        +OX8TpdxZD0euWTdoWhy2+DSQw==
X-Google-Smtp-Source: AAOMgpf+KKiAMy7Rh4AqIDkMguU7/i/zg7VCxmpwSu7e0Jp0tJZ9kw9IkLtQ0CsJ2fUL5N7/l5elBA==
X-Received: by 2002:adf:9c91:: with SMTP id d17-v6mr3523435wre.11.1531901355748;
        Wed, 18 Jul 2018 01:09:15 -0700 (PDT)
Received: from dell ([2.27.167.87])
        by smtp.gmail.com with ESMTPSA id g1-v6sm3245710wrq.51.2018.07.18.01.09.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jul 2018 01:09:14 -0700 (PDT)
Date:   Wed, 18 Jul 2018 09:09:13 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@linaro.org, Marcel Ziswiler <marcel.ziswiler@toradex.com>
Subject: Re: [PATCH] backlight: pwm_bl: Fix uninitialized variable
Message-ID: <20180718080913.GB4641@dell>
References: <20180716210241.9457-1-daniel.thompson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180716210241.9457-1-daniel.thompson@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jul 2018, Daniel Thompson wrote:

> Currently, if the DT does not define num-interpolated-steps then
> num_steps is undefined and the interpolation code will deploy randomly.
> Fix this.
> 
> Fixes: 573fe6d1c25c ("backlight: pwm_bl: Linear interpolation between
> brightness-levels")
> Reported-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

This line is confusing.  Did you guys author this patch together?

My guess is that this line should be dropped and the RB and TB tags
should remain?  If it was reviewed too, perhaps an AB too?

> Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> ---
>  drivers/video/backlight/pwm_bl.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index 9ee4c1b735b2..e3c22b79fbcd 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -299,15 +299,14 @@ static int pwm_backlight_parse_dt(struct device *dev,
>  		 * interpolation between each of the values of brightness levels
>  		 * and creates a new pre-computed table.
>  		 */
> -		of_property_read_u32(node, "num-interpolated-steps",
> -				     &num_steps);
> -
> -		/*
> -		 * Make sure that there is at least two entries in the
> -		 * brightness-levels table, otherwise we can't interpolate
> -		 * between two points.
> -		 */
> -		if (num_steps) {
> +		if ((of_property_read_u32(node, "num-interpolated-steps",
> +					  &num_steps) == 0) && num_steps) {

This is pretty ugly, and isn't it suffering from over-bracketing?  My
suggestion would be to break out the invocation of
of_property_read_u32() from the if and test only the result.

		of_property_read_u32(node, "num-interpolated-steps", &num_steps);
		if (!ret && num_steps) {

I haven't checked the underling code, but is it even feasible for
of_property_read_u32() to not succeed AND for num_steps to be set?

If not, the check for !ret if superfluous and you can drop it.

> +			/*
> +			 * Make sure that there is at least two entries in the

s/is/are/

> +			 * brightness-levels table, otherwise we can't
> +			 * interpolate

Why break the line here?

> +			 * between two points.
> +			 */
>  			if (data->max_brightness < 2) {
>  				dev_err(dev, "can't interpolate\n");
>  				return -EINVAL;

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
