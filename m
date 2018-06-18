Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=BODY_8BITS,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C630C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 06:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAE09208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 06:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FCeVUI3j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAE09208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932757AbeFRGUL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 02:20:11 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:45781 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932289AbeFRGUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 02:20:08 -0400
Received: by mail-wr0-f196.google.com with SMTP id o12-v6so15428721wrm.12
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jun 2018 23:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=3i3x4jfcKJbLNK51ehJ/j3kzMNKnL+lc0t1GQjnlUqU=;
        b=FCeVUI3joK+LvGnafpsnUHsCIYyAhAyjHK9tFtn+uApbgmlJULJv8OunlMMdb4HGlp
         dJy4CzlYm+DWpSO3MOiDfe476MiFeEu/kYjtWi8LB7/eFWRQYLGKDt0+ky80ZP8rDb30
         5ygBQrv0DFr/GJolyB25y4OX4RyQ7mVRU+7Tc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=3i3x4jfcKJbLNK51ehJ/j3kzMNKnL+lc0t1GQjnlUqU=;
        b=Ol6jjWR2lCUXf8+Zih23xUIwqVk9jPBcvTVFHjwphimZ+tAf/a4jQV1sg24RK35q+P
         ybs28MrtevwJIQR7R+9EuON4yEAQuEC3ib0VkGXZOuhf1/A8jdrzHEmjxnyOL2h0qyL5
         kVgsJSOJC8T8hf0qw+NGTHjhthrE4js96zXG6owSm8aNHjtDMBdsDfRFyBG0it5sUqbZ
         K/4A6KDYnL4AgycarjvJ3fojXEj03ZFljGQuMmtvp6fNW1VArnVy4FqsXEC1a/x+jchE
         Kn8mnxHI0/jRr2rixnQ/NdaQDpGjBoDQ2pLiz4KUVD0D+P/1oGMfNdNGuZSolY9lhJl4
         G87g==
X-Gm-Message-State: APt69E10uFLWT4DNBSHuKCSDeNbAf3bRx+VD+e9uH2iLhaz8Jg4AOH/q
        GPcM8pIv6qiTZA2QiX16BV9LJw==
X-Google-Smtp-Source: ADUXVKKSNRVrO2KwzoKNCpkhCeuNEQyX1a1vOQ4M4NfnWUgeud04safYs+TtUsikHuEbgBsJ6YhlMQ==
X-Received: by 2002:adf:efcf:: with SMTP id i15-v6mr9698432wrp.195.1529302807693;
        Sun, 17 Jun 2018 23:20:07 -0700 (PDT)
Received: from dell ([95.149.160.78])
        by smtp.gmail.com with ESMTPSA id y30-v6sm16876202wrd.70.2018.06.17.23.20.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Jun 2018 23:20:06 -0700 (PDT)
Date:   Mon, 18 Jun 2018 07:20:05 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Doug Anderson <dianders@google.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Richard Purdie <rpurdie@rpsys.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Brian Norris <briannorris@google.com>,
        Guenter Roeck <groeck@google.com>,
        Alexandru Stan <amstan@google.com>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [RESEND PATCH v3 0/4] backlight: pwm_bl: support linear
 interpolation and brightness to human eye
Message-ID: <20180618062005.GE31141@dell>
References: <20180409083333.1249-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180409083333.1249-1-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 Apr 2018, Enric Balletbo i Serra wrote:

> Dear all,
> 
> This series is a third patchset (resend )integrating the requested
> changes.
> 
> The first and second patch what tries to solve is the problem of
> granularity for high resolution PWMs. The idea is simple interpolate
> between 2 brightness values so we can have a high PWM duty cycle (a
> 16 bits PWM is up to 65535 possible steps) without having to list
> out every possible value in the dts. I think that this patch is
> required to not break backward compatibility, to be more flexible and
> also extend the functionality to be able to use high resolution PWM
> with enough steps to have a good UI experience in userspace.
> 
> The thirth and fourth patch is a bit more ambicious, the idea is let
> decide the driver the brightness-levels required in function of the PWM
> resolution. To do this create a brightness-levels table filled with the
> CIE 1931 algorithm values to convert brightness to PWM duty cycle.
> 
> More detailed info is available in the commit message of every patch.
> 
> Both functionalities were tested on a Samsung Chromebook Plus (that has
> a 16 bits PWM) and a SL50 device (with a 8 bits PWM)
> 
> Waiting for your feedback.
> 
> Best regards
> 
> Enric Balletbo i Serra (4):
>   backlight: pwm_bl: linear interpolation between brightness-levels
>   dt-bindings: pwm-backlight: add a num-interpolation-steps property.
>   backlight: pwm_bl: compute brightness of LED linearly to human eye.
>   dt-bindings: pwm-backlight: move brightness-levels to optional.
> 
>  .../bindings/leds/backlight/pwm-backlight.txt      |  34 ++-
>  drivers/video/backlight/pwm_bl.c                   | 232 +++++++++++++++++++--
>  2 files changed, 246 insertions(+), 20 deletions(-)

All applied for v4.18, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
