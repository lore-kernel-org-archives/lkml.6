Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B52BC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 00:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4D2920883
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 00:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G88fSUEF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4D2920883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388547AbeGYBP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 21:15:27 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46973 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388465AbeGYBP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 21:15:26 -0400
Received: by mail-pf1-f196.google.com with SMTP id u24-v6so1232159pfn.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 17:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ZctKtpgyXroelIjVWiulCvYwEcLFyijeCoq4Bi1GqgU=;
        b=G88fSUEFmTHlx9QmICsxjl/U4SHvdczF2lBbnz8xtYOtj8LJ9BQ0TytSxnI0LafKpC
         g301A6J5B+LRhdo9R7YR3Rw6YxkDRAWB2nvuABhhnADlfxl/W6SNBv8B3140kpbbcDQL
         sjOmhS1B7T0aEBF4loCaRuYUm+UfPpkVEmnqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ZctKtpgyXroelIjVWiulCvYwEcLFyijeCoq4Bi1GqgU=;
        b=a4wLzCjl/3F4YuDHosvHQIFWSTBEx5VQi7FaHWKjLccwH4pLQuZtLI6mwx5wc3jb1C
         FZkZBCfKzpwaEhIUNswkflCakVUX0ZF8fkqIxL2g9znYww61+m+9xg4VF/GBw5j3Zo48
         y51HV1IwqG4/dzc+Y/yHKd39RzC9eHDQbufseeESkiJZQiXRHIWWa29NMN1Dyaj58E+W
         UiHYecTtKQUESXyVkWDi1pl32FGfAtRFIvGYVGLihD6pkeh1mMQgwp4mDmhh2RNl8I6H
         fgilPgpeAQjMzc4f/3a4ZEmlEbrvMqYjdekP1dHI8w8rRVd+EWP12EQQstTbOUbF9JS2
         hPBQ==
X-Gm-Message-State: AOUpUlFz9XANdpkc166aUXT/WCwMQjsNIT4FfFVBALd/y+zCyJjsWVAp
        qj2Oa53T7t8xXYwHsxWhmR6Jng==
X-Google-Smtp-Source: AAOMgpethxEZ7haKaC5JEJZ9g2TDJyVhNbTJfkjAD/s0L1jqYoaKKobRWU48rDCrnAV83c9yKCaHyg==
X-Received: by 2002:a63:9856:: with SMTP id l22-v6mr18743571pgo.208.1532477189431;
        Tue, 24 Jul 2018 17:06:29 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id b192-v6sm18714034pga.2.2018.07.24.17.06.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 17:06:28 -0700 (PDT)
Date:   Tue, 24 Jul 2018 17:06:28 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>
Cc:     linux-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        David Collins <collinsd@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v5 1/3] thermal: qcom-spmi: Use PMIC thermal stage 2 for
 critical trip points
Message-ID: <20180725000628.GO129942@google.com>
References: <20180724234636.57137-1-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180724234636.57137-1-mka@chromium.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 04:46:34PM -0700, Matthias Kaehlcke wrote:
> There are three thermal stages defined in the PMIC:
> 
> stage 1: warning
> stage 2: system should shut down
> stage 3: emergency shut down
> 
> By default the PMIC assumes that the OS isn't doing anything and thus
> at stage 2 it does a partial PMIC shutdown and at stage 3 it kills
> all power. When switching between thermal stages the PMIC generates an
> interrupt which is handled by the driver. The partial PMIC shutdown at
> stage 2 can be disabled by software, which allows the OS to initiate a
> shutdown at stage 2 with a thermal zone configured accordingly.
> 
> If a critical trip point is configured in the thermal zone the driver
> adjusts the stage 1-3 temperature thresholds to (closely) match the
> critical temperature with a stage 2 threshold (125/130/135/140 °C).
> If a suitable match is found the partial shutdown at stage 2 is
> disabled. If for some reason the system doesn't shutdown at stage 2
> the emergency shutdown at stage 3 kicks in.
> 
> The partial shutdown at stage 2 remains enabled in these cases:
> - no critical trip point defined
> - the temperature of the critical trip point is < 125°C
> - the temperature of the critical trip point is > 140°C and no
>   ADC channel is configured (thus the OS is not notified when the critical
>   temperature is reached)
> 
> Suggested-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Changes in v5:
> - patch added to the series
> ---
>  drivers/thermal/qcom-spmi-temp-alarm.c | 161 ++++++++++++++++++++++---
>  1 file changed, 142 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/thermal/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom-spmi-temp-alarm.c
> index ad4f3a8d6560..936e4dde4298 100644
> --- a/drivers/thermal/qcom-spmi-temp-alarm.c
> +++ b/drivers/thermal/qcom-spmi-temp-alarm.c
>
> ...
>
> +static int qpnp_tm_update_critical_trip_temp(struct qpnp_tm_chip *chip,
> +					     int temp)
> +{
> +	u8 reg;
> +	bool disable_s2_shutdown = false;
> +	int ret;
> +
> +	WARN_ON(!mutex_is_locked(&chip->lock));
> +
> +	/*
> +	 * Default: S2 and S3 shutdown enabled, thresholds at
> +	 * 105C/125C/145C, monitoring at 25Hz
> +	 */
> +	reg = SHUTDOWN_CTRL1_RATE_25HZ;
> +
> +	if ((temp == THERMAL_TEMP_INVALID) ||
> +	    (temp < STAGE2_THRESHOLD_MIN)) {
> +		chip->thresh = THRESH_MIN;
> +		goto skip;
> +	}
> +
> +	if (temp <= STAGE2_THRESHOLD_MAX) {
> +		chip->thresh = THRESH_MAX -
> +			((STAGE2_THRESHOLD_MAX - temp) /
> +			 TEMP_THRESH_STEP);
> +		disable_s2_shutdown = true;
> +	} else {
> +		chip->thresh = THRESH_MAX;
> +
> +		if (!IS_ERR(chip->adc))

Note to self: with commit 7a4ca51b7040 ("thermal/drivers/qcom-spmi:
Use devm_iio_channel_get") this should be 'if (chip->adc)'.
