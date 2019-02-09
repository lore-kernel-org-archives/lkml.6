Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB04AC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 17:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9228721929
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 17:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n5nEYp7v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbfBIRNI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 12:13:08 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37169 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727221AbfBIRNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 12:13:07 -0500
Received: by mail-pf1-f196.google.com with SMTP id y126so3151330pfb.4;
        Sat, 09 Feb 2019 09:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=6Sv+Ll/WSSZa7lPVPCN8g3I1KC1NjyrzjbWn8k0r7Jg=;
        b=n5nEYp7vVhDnGSQYpiiJU4lG6Kt+PAL4IJ/s99VhLLm5bXC5i6YH4FM7S5u/FKqOm2
         11aJTgDcSd2f/UHuRy2ekXwYEh0QtBFajgW8XtedwQ0REN2yIgR4ORq+0DQ0phUln4uC
         HM4oYWoMUQSmelSEBjVH4Qc/407cOQqRQjdZ/Dvh6n4NpSr43OBDcTFyMCmdFcVBMNdJ
         r7Ofig47VXmxvgvN+q6VO+yy/V5HXXJi1+varpjRBv2SGPnTDYVgEAFJ6GfB+rLNEoP8
         MEX62ZVXixu3Vw8GgInyAXyP6IPvOEtiP0pFIPbQCTbgJ2mTeIJ6ZZe9T/3eeG+u0BoT
         qCnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=6Sv+Ll/WSSZa7lPVPCN8g3I1KC1NjyrzjbWn8k0r7Jg=;
        b=GLicsXM0iGcDWxclSFuPiYx6c7CHINoWSlJ/daSn6ePmTFTMuq5X+sIRSPLu+qJTFq
         MbgUH+qOWRSSbT03awHXqv0SyFIGUlqjbE2W39Q70DToLJuQLM3/9wUpEwTHiTmDZptm
         1DLJOmGH/n+djojIJu3RBjQ2F5OgIMSWH0Ba+5XH8Qvyf4jXiBo3FWvuG2adCMWT4Syr
         7M9Ywm37PfscYN5B9JlRlj3/3edleLXtYrqo7gFBcqLy1yLOEbfXSB/XA8B7qu/65KuB
         h/R5UDa7hfR0IaJ9limZYv8HbBIW/7wwhZwaKRLHF7sIItf4vE8rFgB5unPb1iCeNOK4
         Q9Fw==
X-Gm-Message-State: AHQUAuYTQ1qPQd+E4qNaE84P7Hbi9I9VEh/EFuxGWs0iQnSt+eW7GE9U
        0+Fm6rNWydzJGHESb4Sf74LN2Yd2
X-Google-Smtp-Source: AHgI3IY/vr9t37o1lUDGPPBaYlXjFNtCy410FJBfdRWlD2msVS9XlDb7IARujTpXOoWXXaRRFCuHpQ==
X-Received: by 2002:a62:61c3:: with SMTP id v186mr28701857pfb.55.1549732386487;
        Sat, 09 Feb 2019 09:13:06 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id u127sm1608087pfu.165.2019.02.09.09.13.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Feb 2019 09:13:05 -0800 (PST)
Date:   Sat, 9 Feb 2019 09:13:03 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Bakker <xc-racer2@live.ca>
Subject: Re: [PATCH v2 1/2] input: misc: pwm-vibra: Prevent unbalanced
 regulator
Message-ID: <20190209171303.GE197782@dtor-ws>
References: <20190124202732.14723-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190124202732.14723-1-pawel.mikolaj.chmiel@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 09:27:31PM +0100, Paweł Chmiel wrote:
> From: Jonathan Bakker <xc-racer2@live.ca>
> 
> pwm_vibrator_stop disables the regulator, but it can be called from
> multiple places, even when the regulator is already disabled. Fix this
> by using regulator_is_enabled check when starting and stopping device.
> 
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>

Applied, thank you.

> ---
> Changes from v1:
>   - Rather than using regulator_is_enabled api, use local flag for
>     checking if regulator is enabled
> ---
>  drivers/input/misc/pwm-vibra.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/input/misc/pwm-vibra.c b/drivers/input/misc/pwm-vibra.c
> index 55da191ae550..9df87431d7d4 100644
> --- a/drivers/input/misc/pwm-vibra.c
> +++ b/drivers/input/misc/pwm-vibra.c
> @@ -34,6 +34,7 @@ struct pwm_vibrator {
>  	struct work_struct play_work;
>  	u16 level;
>  	u32 direction_duty_cycle;
> +	bool vcc_on;
>  };
>  
>  static int pwm_vibrator_start(struct pwm_vibrator *vibrator)
> @@ -42,10 +43,13 @@ static int pwm_vibrator_start(struct pwm_vibrator *vibrator)
>  	struct pwm_state state;
>  	int err;
>  
> -	err = regulator_enable(vibrator->vcc);
> -	if (err) {
> -		dev_err(pdev, "failed to enable regulator: %d", err);
> -		return err;
> +	if (!vibrator->vcc_on) {
> +		err = regulator_enable(vibrator->vcc);
> +		if (err) {
> +			dev_err(pdev, "failed to enable regulator: %d", err);
> +			return err;
> +		}
> +		vibrator->vcc_on = true;
>  	}
>  
>  	pwm_get_state(vibrator->pwm, &state);
> @@ -76,7 +80,10 @@ static int pwm_vibrator_start(struct pwm_vibrator *vibrator)
>  
>  static void pwm_vibrator_stop(struct pwm_vibrator *vibrator)
>  {
> -	regulator_disable(vibrator->vcc);
> +	if (vibrator->vcc_on) {
> +		regulator_disable(vibrator->vcc);
> +		vibrator->vcc_on = false;
> +	}
>  
>  	if (vibrator->pwm_dir)
>  		pwm_disable(vibrator->pwm_dir);
> -- 
> 2.17.1
> 

-- 
Dmitry
