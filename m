Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E15FC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 107A020883
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:49:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 107A020883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729244AbeGZKF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 06:05:28 -0400
Received: from mga07.intel.com ([134.134.136.100]:12914 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728825AbeGZKF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 06:05:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2018 01:49:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,404,1526367600"; 
   d="scan'208";a="219250412"
Received: from taolv-mobl.ccr.corp.intel.com ([10.249.169.42])
  by orsmga004.jf.intel.com with ESMTP; 26 Jul 2018 01:49:32 -0700
Message-ID: <1532594969.2358.40.camel@intel.com>
Subject: Re: [PATCH] drivers: thermal: step_wise: add support for hysteresis
From:   Zhang Rui <rui.zhang@intel.com>
To:     Lina Iyer <ilina@codeaurora.org>, edubezval@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Ram Chandrasekar <rkumbako@codeaurora.org>
Date:   Thu, 26 Jul 2018 16:49:29 +0800
In-Reply-To: <20180507175408.2154-1-ilina@codeaurora.org>
References: <20180507175408.2154-1-ilina@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Lina,

On 一, 2018-05-07 at 11:54 -0600, Lina Iyer wrote:
> From: Ram Chandrasekar <rkumbako@codeaurora.org>
> 
> From: Ram Chandrasekar <rkumbako@codeaurora.org>
> 
> Step wise governor increases the mitigation level when the
> temperature
> goes above a threshold and will decrease the mitigation when the
> temperature falls below the threshold. If it were a case, where the
> temperature hovers around a threshold, the mitigation will be applied
> and removed at every iteration. This reaction to the temperature is
> inefficient for performance.
> 
> The use of hysteresis temperature could avoid this ping-pong of
> mitigation by relaxing the mitigation to happen only when the
> temperature goes below this lower hysteresis value.
> 
the idea looks okay to me, just some minor comments.

> Signed-off-by: Ram Chandrasekar <rkumbako@codeaurora.org>
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> ---
>  drivers/thermal/step_wise.c | 33 +++++++++++++++++++++++----------
>  1 file changed, 23 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/thermal/step_wise.c
> b/drivers/thermal/step_wise.c
> index ee047ca43084..cf07e2269291 100644
> --- a/drivers/thermal/step_wise.c
> +++ b/drivers/thermal/step_wise.c
> @@ -36,7 +36,7 @@
>   *       for this trip point
>   *    d. if the trend is THERMAL_TREND_DROP_FULL, use lower limit
>   *       for this trip point
> - * If the temperature is lower than a trip point,
> + * If the temperature is lower than a hysteresis temperature,

1. if you update this, you should update "if the temperature is higher
than ..." as well.

2. the updated comment does not fully match the code change you made
below.

>   *    a. if the trend is THERMAL_TREND_RAISING, do nothing
>   *    b. if the trend is THERMAL_TREND_DROPPING, use lower cooling
>   *       state for this trip point, if the cooling state already
> @@ -127,7 +127,7 @@ static void update_passive_instance(struct
> thermal_zone_device *tz,
>  
>  static void thermal_zone_trip_update(struct thermal_zone_device *tz,
> int trip)
>  {
> -	int trip_temp;
> +	int trip_temp, hyst_temp;
>  	enum thermal_trip_type trip_type;
>  	enum thermal_trend trend;
>  	struct thermal_instance *instance;
> @@ -135,22 +135,23 @@ static void thermal_zone_trip_update(struct
> thermal_zone_device *tz, int trip)
>  	int old_target;
>  
>  	if (trip == THERMAL_TRIPS_NONE) {
> -		trip_temp = tz->forced_passive;
> +		hyst_temp = trip_temp = tz->forced_passive;
>  		trip_type = THERMAL_TRIPS_NONE;
>  	} else {
>  		tz->ops->get_trip_temp(tz, trip, &trip_temp);
> +		hyst_temp = trip_temp;
> +		if (tz->ops->get_trip_hyst) {
> +			tz->ops->get_trip_hyst(tz, trip,
> &hyst_temp);
> +			hyst_temp = trip_temp - hyst_temp;
> +		}
>  		tz->ops->get_trip_type(tz, trip, &trip_type);
>  	}
>  
>  	trend = get_tz_trend(tz, trip);
>  
> -	if (tz->temperature >= trip_temp) {
> -		throttle = true;
> -		trace_thermal_zone_trip(tz, trip, trip_type);
> -	}
> -
> -	dev_dbg(&tz->device,
> "Trip%d[type=%d,temp=%d]:trend=%d,throttle=%d\n",
> -				trip, trip_type, trip_temp, trend,
> throttle);
> +	dev_dbg(&tz->device,
> +		"Trip%d[type=%d,temp=%d,hyst=%d]:trend=%d,throttle=%
> d\n",
> +		trip, trip_type, trip_temp, hyst_temp, trend,
> throttle);
>  
throttle is not set properly here, so this debug message does not make
sense.

thanks,
rui
>  	mutex_lock(&tz->lock);
>  
> @@ -159,6 +160,18 @@ static void thermal_zone_trip_update(struct
> thermal_zone_device *tz, int trip)
>  			continue;
>  
>  		old_target = instance->target;
> +		throttle = false;
> +		/*
> +		 * Lower the mitigation only if the temperature
> +		 * goes below the hysteresis temperature.
> +		 */
> +		if (tz->temperature >= trip_temp ||
> +		   (tz->temperature >= hyst_temp &&
> +		   old_target != THERMAL_NO_TARGET)) {
> +			throttle = true;
> +			trace_thermal_zone_trip(tz, trip,
> trip_type);
> +		}
> +

>  		instance->target = get_target_state(instance, trend,
> throttle);
>  		dev_dbg(&instance->cdev->device, "old_target=%d,
> target=%d\n",
>  					old_target, (int)instance-
> >target);
