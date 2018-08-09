Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98054C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 20:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4130E21E97
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 20:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MBSVerjj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4130E21E97
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbeHIXVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 19:21:55 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46383 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727141AbeHIXVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 19:21:54 -0400
Received: by mail-pg1-f196.google.com with SMTP id f14-v6so3288050pgv.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 13:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ldQg+XCWGfukZLFgjcU/ib1w3S/tHMnL5QanYI/RZgE=;
        b=MBSVerjj5+U7RMtjU1Ax3clXUzXFaN2vNoFbMkx/1lnAGbAlk9oEKLsT8RdSg2XoJw
         0H/slWFaGS3Fab6na60c97FkyQFI1z+KaDOo+Wuqdh39zeLvPbYcR7UPVJTAfFIB5sTw
         RrCUQ1ejI9xUEUpFWVKp33xjPKND9okCMa4BQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ldQg+XCWGfukZLFgjcU/ib1w3S/tHMnL5QanYI/RZgE=;
        b=eB/aezsJD5BcEvbotspTnWw7UnDynH2qnPZNTwGf0vJeYFHKZ3q4Y8hdIkcMMEffJ9
         0ue8cyAGxej+hwnZ24AawtTJJGDuuF40ozrMmZMIIDcwn7pUd5puBYq7XYcAIw9uQRff
         tNnHXAyMI3RhgAiybNBnoJYfbSMQqp9IVhzZjWd+Vq6PENmmGC/6kHwsfivxGKxCISF/
         ++/QLFSW4Yn7/qIY1/BtB/nTmu8iygJjhzfO0svHnWaZFpL83M4z+K3kX3v1pyPgLnEV
         n7NJjqJqKLQsk1DefjR3bOHXi805tiDMFhDXB61jIcV+tek1uBNN0Swzav4m/f6fb+On
         TF6g==
X-Gm-Message-State: AOUpUlFwnIdmbX/U3Je8EptBlgMu+rbEl01mV6YElmheEnjR4N1jMJuK
        pVEGkw7ac6oUwGAZ83XwJjrD1A==
X-Google-Smtp-Source: AA+uWPxh6AXOmq38qRKSk7wFnYaak9NrGPJx/7ZYUXkueXi0kVHOD1FRR5m+JPrz5tGT/eZMBD8HWA==
X-Received: by 2002:a63:1a49:: with SMTP id a9-v6mr3655438pgm.423.1533848120627;
        Thu, 09 Aug 2018 13:55:20 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id 5-v6sm12710833pgc.86.2018.08.09.13.55.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 13:55:19 -0700 (PDT)
Date:   Thu, 9 Aug 2018 13:55:19 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        edubezval@gmail.com, smohanad@codeaurora.org,
        andy.gross@linaro.org, dianders@chromium.org,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 08/10] thermal: tsens: Get rid of 'id' field
Message-ID: <20180809205519.GP160295@google.com>
References: <cover.1533815718.git.amit.kucheria@linaro.org>
 <3810cbe6b499d265d7e3fb97c408cb80a12d5850.1533815718.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3810cbe6b499d265d7e3fb97c408cb80a12d5850.1533815718.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 06:02:40PM +0530, Amit Kucheria wrote:
> The hw_id field in 'struct tsens_sensor' can do the job of tracking
> unique ids for each sensor connected to each tsens device instance. It
> also allows hw_ids to be overridden (e.g. 8916) in cases where some
> sensors in a sequence are disabled on a particular platform.
> 
> Use the hw_id field instead of the id field consistently across the
> tsens code.
> 
> While, we're at it, document the fields of struct tsens_sensor.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  drivers/thermal/qcom/tsens.c |  5 ++---
>  drivers/thermal/qcom/tsens.h | 10 +++++++++-
>  2 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index 9a8e8f7b4ae1..fb728ec5d77f 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -17,7 +17,7 @@ static int tsens_get_temp(void *data, int *temp)
>  	const struct tsens_sensor *s = data;
>  	struct tsens_device *tmdev = s->tmdev;
>  
> -	return tmdev->ops->get_temp(tmdev, s->id, temp);
> +	return tmdev->ops->get_temp(tmdev, s->hw_id, temp);
>  }
>  
>  static int tsens_get_trend(void *p, int trip, enum thermal_trend *trend)
> @@ -26,7 +26,7 @@ static int tsens_get_trend(void *p, int trip, enum thermal_trend *trend)
>  	struct tsens_device *tmdev = s->tmdev;
>  
>  	if (tmdev->ops->get_trend)
> -		return  tmdev->ops->get_trend(tmdev, s->id, trend);
> +		return  tmdev->ops->get_trend(tmdev, s->hw_id, trend);
>  
>  	return -ENOTSUPP;
>  }
> @@ -83,7 +83,6 @@ static int tsens_register(struct tsens_device *tmdev)
>  
>  	for (i = 0;  i < tmdev->num_sensors; i++) {
>  		tmdev->sensor[i].tmdev = tmdev;
> -		tmdev->sensor[i].id = i;
>  		tzd = devm_thermal_zone_of_sensor_register(tmdev->dev, i,
>  							   &tmdev->sensor[i],
>  							   &tsens_of_ops);
> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> index b9c4bcf255fa..2a3174dfc1a9 100644
> --- a/drivers/thermal/qcom/tsens.h
> +++ b/drivers/thermal/qcom/tsens.h
> @@ -14,11 +14,19 @@
>  
>  struct tsens_device;
>  
> +/**
> + * struct tsens_sensor - sensor-specific data
> + * @tmdev: tsens device instance this sensor is connected to
> + * @tzd: thermal zone corresponding to this sensor
> + * @offset: offset from calibration data to convert ADC data to degrees
> + * @hw_id: unique sensor ID for each sensor connected to tsens device instance
> + * @slope: slope from calibration data to convert ADC data to degrees
> + * @status: 8960-specific status register addresses
> + */
>  struct tsens_sensor {
>  	struct tsens_device		*tmdev;
>  	struct thermal_zone_device	*tzd;
>  	int				offset;
> -	int				id;
>  	int				hw_id;
>  	int				slope;
>  	u32				status;

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
