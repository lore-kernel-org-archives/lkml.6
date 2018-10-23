Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14A6C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 08:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50791207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 08:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EuO1ZH3o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50791207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbeJWQkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 12:40:11 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38672 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727420AbeJWQkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 12:40:11 -0400
Received: by mail-wm1-f65.google.com with SMTP id 193-v6so765308wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 01:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pstTuRLNyfbo8OBAUHO4Carb6ForQeYM6MN8xRaOVp0=;
        b=EuO1ZH3oQZjauw2FGWtXew3RA5+DHailSNEgE0FIqJQV7MUTtbhT468BX9y+KyKvM8
         2t2zjsTRGrrCgcpdhYsx4/7jMPQbTOenkjPsm8T0zh50huX46DMDKzdXK2vrTzCtA3bV
         1ZpPjzyqRVyRwQwrM7EblMYo2OOJWwCoZNBHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pstTuRLNyfbo8OBAUHO4Carb6ForQeYM6MN8xRaOVp0=;
        b=s1auK9H8l3fTQEzQyx/5jfsOXRWXOn8CkzBQd1IsmTcr46MtKWaT8cUyvET8Yrilao
         XXI1RRm2tWb9HSKYwld4Sg1L29WaPnhsEJoq0hHo/DDFskji1z2H5HELNgdwMulE1t2E
         4jkPyna0G9pAcynR/+uVUxoAIurzSC9PL/uFvuEEhLk5IHdMTXYrofTzhnC3NGo8O1G+
         j2Jp+ZGnmi4vMq08d7aUUva7rhunTc7/Ljee4qRxq3OBF8+FUYLlgb2Jkz3qWHlKCEwQ
         v0efx8nvdM6jXdPTHBSRhSWPJbDT55Gqkh1APECV40nwjLBUNuaj3rT77Oo1B8nFfJhe
         j5Lg==
X-Gm-Message-State: ABuFfojG9HAwd7DfTxpgMyec6JtU0Z6ZMzLzJSz7RAuZRciGuWdhMBwc
        CdcClOnzGNoj9aIjfLzErDxdSw==
X-Google-Smtp-Source: AJdET5dJntC25cK5INSyCYGqCSbl+VnpZ/83+q9V1rFX06WU4INFGze5KLFecu0pgIgyyeA2J8ktfw==
X-Received: by 2002:a1c:ce02:: with SMTP id e2-v6mr18686384wmg.85.1540282670449;
        Tue, 23 Oct 2018 01:17:50 -0700 (PDT)
Received: from [192.168.0.40] (59.140.136.77.rev.sfr.net. [77.136.140.59])
        by smtp.googlemail.com with ESMTPSA id l4-v6sm904580wrb.92.2018.10.23.01.17.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 01:17:49 -0700 (PDT)
Subject: Re: [PATCH 1/2] thermal: Add notifier call chain for hot/critical
 events
To:     Ross Zwisler <zwisler@google.com>, linux-kernel@vger.kernel.org
Cc:     Duncan Laurie <dlaurie@chromium.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
References: <20181022203218.7007-1-zwisler@google.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <7c7d14e2-3c58-fcbb-14b1-e0a2fecb0224@linaro.org>
Date:   Tue, 23 Oct 2018 10:17:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181022203218.7007-1-zwisler@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/10/2018 22:32, Ross Zwisler wrote:
> From: Duncan Laurie <dlaurie@chromium.org>
> 
> This will allow drivers to register a callback for important
> thermal events and log critical thresholds that cause the system
> to shut down.
> 
> There are other places this might work, but after consideration
> I think it makes sense to have the chain at this level:
> 
> The ACPI thermal driver has an existing notify function that is
> eventually called into, but that would limit the notifier to only
> working on systems that use ACPI.
> 
> The cpufreq driver is already getting a notify callback executed
> in this path (tz->ops->notify) but the threshold info is not passed
> to the cpu_cooling notifier chain so it is not useful for logging.
> 
> Signed-off-by: Duncan Laurie <dlaurie@chromium.org>
> Reviewed-by: Olof Johansson <olofj@chromium.org>
> Reviewed-by: Vincent Palatin <vpalatin@chromium.org>
> [ rez: updated changelog for upstream ]
> Signed-off-by: Ross Zwisler <zwisler@google.com>
> ---

At the critical code path, the thermal framework gives a chance to
orderly_poweroff() to complete but the execution is bounded by a delay
which in turn forces a kernel power off.

The usage of a notifier call chain is inadequate in this code path. When
the system is reaching a critical temperature it has to *urgently* take
action. By adding this notifier that allows anyone to hook this path and
add an overhead/delays.



>  drivers/thermal/thermal_core.c | 38 ++++++++++++++++++++++++++++++++++
>  include/linux/thermal.h        |  4 ++++
>  2 files changed, 42 insertions(+)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 6ab982309e6a0..e1f8764b3d9f9 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -15,6 +15,7 @@
>  #include <linux/slab.h>
>  #include <linux/kdev_t.h>
>  #include <linux/idr.h>
> +#include <linux/notifier.h>
>  #include <linux/thermal.h>
>  #include <linux/reboot.h>
>  #include <linux/string.h>
> @@ -313,12 +314,46 @@ static void monitor_thermal_zone(struct thermal_zone_device *tz)
>  	mutex_unlock(&tz->lock);
>  }
>  
> +static BLOCKING_NOTIFIER_HEAD(thermal_notifier_list);
> +
> +/**
> + * register_thermal_notifier - Register function to be called for
> + *                             critical thermal events.
> + *
> + * @nb: Info about notifier function to be called
> + *
> + * Currently always returns zero, as blocking_notifier_chain_register()
> + * always returns zero.
> + */
> +int register_thermal_notifier(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_register(&thermal_notifier_list, nb);
> +}
> +EXPORT_SYMBOL(register_thermal_notifier);
> +
> +/**
> + * unregister_thermal_notifier - Unregister thermal notifier
> + *
> + * @nb: Hook to be unregistered
> + *
> + * Returns zero on success, or %-ENOENT on failure.
> + */
> +int unregister_thermal_notifier(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_unregister(&thermal_notifier_list, nb);
> +}
> +EXPORT_SYMBOL(unregister_thermal_notifier);
> +
> +
>  static void handle_non_critical_trips(struct thermal_zone_device *tz,
>  				      int trip,
>  				      enum thermal_trip_type trip_type)
>  {
>  	tz->governor ? tz->governor->throttle(tz, trip) :
>  		       def_governor->throttle(tz, trip);
> +
> +	blocking_notifier_call_chain(&thermal_notifier_list,
> +				     trip_type, NULL);
>  }
>  
>  /**
> @@ -385,6 +420,9 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
>  	if (tz->ops->notify)
>  		tz->ops->notify(tz, trip, trip_type);
>  
> +	blocking_notifier_call_chain(&thermal_notifier_list,
> +				     trip_type, NULL);
> +
>  	if (trip_type == THERMAL_TRIP_CRITICAL) {
>  		dev_emerg(&tz->device,
>  			  "critical temperature reached (%d C), shutting down\n",
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 5f4705f46c2f9..b948344d55cab 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -13,6 +13,7 @@
>  #include <linux/of.h>
>  #include <linux/idr.h>
>  #include <linux/device.h>
> +#include <linux/notifier.h>
>  #include <linux/sysfs.h>
>  #include <linux/workqueue.h>
>  #include <uapi/linux/thermal.h>
> @@ -542,4 +543,7 @@ static inline int thermal_generate_netlink_event(struct thermal_zone_device *tz,
>  }
>  #endif
>  
> +extern int register_thermal_notifier(struct notifier_block *);
> +extern int unregister_thermal_notifier(struct notifier_block *);
> +
>  #endif /* __THERMAL_H__ */
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

