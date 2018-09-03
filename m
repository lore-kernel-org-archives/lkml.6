Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72AD3C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 20:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FEFB2086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 20:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UMQZX/gI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FEFB2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbeIDAon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 20:44:43 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43878 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727413AbeIDAon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 20:44:43 -0400
Received: by mail-pl1-f193.google.com with SMTP id x6-v6so569236plv.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 13:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8fygkBaQGLWT1scFAqCghA9qQKwqujYef/mOquj/oQ8=;
        b=UMQZX/gI+LqyQa/RHtDTtY2Rc6iutDpIWOUe1meChHak0Ifu4E7INTM+hxIyiDDnb6
         nD3+vFFtXSE3TBhmaZwRelqFrVqEqZY1GFt+FV3/Ly2hcp9Z5KqpHoIdGxSZR7TIP4mm
         0fZS2uMm+Oc+QQ//X7hIzHKTkWs6lcIHWXESw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8fygkBaQGLWT1scFAqCghA9qQKwqujYef/mOquj/oQ8=;
        b=U/0cbsZp7V0quz/7L6WxNOKJSAS+7cE3+azjBjdxWXzBFnXEeLfYLfqyvW1NjjkcOF
         BuKKQVPv7w1RYdhanB0hjh6vXj9BI0QEr+z2epGyNmnnWFyq5ksIZyQdcg6YM/POXczt
         4scVR+WfRQEN4zGtjG7fpkq1EDAd6mra1vxk5whW1n2bNvi+FdVLdol/511DD+djynbZ
         6efDAP5yS8DHdzXuxI2KSln/SkD3u8M+7gA0GGQcDpbfj0CRk80vX4056szFEDj8zoJB
         wgc0PiKYCHo7U1radzLu0FfrNwN0kvoFCWvR/dM7R3yC8a4GvA86pG/AEFTOLksaMF+m
         fklQ==
X-Gm-Message-State: APzg51AwLQzj1Z3rLwiGKLs7EEhTxxqDRF3POCN6cHgC71NAQSL6JOTh
        xTImSdk34jaqjStbd4IrxBK7jQ==
X-Google-Smtp-Source: ANB0VdbH3mPs1x6cab8ojevljTvj5VEgwyx4xQG6iWl6AEJQZmMIMT4G+ksyPBKMr+bESVBpl5o3AQ==
X-Received: by 2002:a17:902:145:: with SMTP id 63-v6mr22522326plb.329.1536006174438;
        Mon, 03 Sep 2018 13:22:54 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id i25-v6sm22567829pgi.31.2018.09.03.13.22.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Sep 2018 13:22:53 -0700 (PDT)
Date:   Mon, 3 Sep 2018 13:26:47 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, edubezval@gmail.com,
        smohanad@codeaurora.org, andy.gross@linaro.org,
        dianders@chromium.org, mka@chromium.org,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 09/11] thermal: tsens: Get rid of 'id' field
Message-ID: <20180903202647.GR3456@tuxbook-pro>
References: <cover.1535462942.git.amit.kucheria@linaro.org>
 <6c23d113e19a9ddf9dc9def18943eaf7f5ad4d79.1535462942.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c23d113e19a9ddf9dc9def18943eaf7f5ad4d79.1535462942.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 28 Aug 06:38 PDT 2018, Amit Kucheria wrote:

> The hw_id field in 'struct tsens_sensor' can do the job of tracking
> unique ids for each sensor connected to each tsens device instance. It
> also allows hw_ids to be overridden (e.g. 8916) in cases where some
> sensors in a sequence are disabled on a particular platform.
> 
> Use the hw_id field instead of the id field consistently across the
> tsens code.
> 
> While we're at it, document the fields of struct tsens_sensor.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

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
> -- 
> 2.17.1
> 
