Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751485AbeBZShd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 13:37:33 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:34531 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751328AbeBZShb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 13:37:31 -0500
X-Google-Smtp-Source: AH8x22417xNF9vrjmwhLWAkmdNDGTuhZLgcWLtLTicYcFyiEBKtX34seHXeYvHEu026s7Pbtkcd5Mg==
Date: Mon, 26 Feb 2018 10:37:28 -0800
From: Brian Norris <briannorris@chromium.org>
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, zyw@rock-chips.com,
        briannorris@google.com, dianders@google.com, jwerner@chromium.org,
        linux-rtc@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>
Subject: Re: [PATCH] rtc: cros-ec: return -ETIME when refused to set alarms
 in the past
Message-ID: <20180226183727.GC225858@rodete-desktop-imager.corp.google.com>
References: <20180225081802.8965-1-jeffy.chen@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180225081802.8965-1-jeffy.chen@rock-chips.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One last note:

On Sun, Feb 25, 2018 at 04:18:02PM +0800, Jeffy Chen wrote:
> We have a check in __rtc_set_alarm() to return -ETIME when the alarm
> is in the past.
> 
> Since accessing a Chrome OS EC based rtc is a slow operation, we should
> do that check again inside of the EC rtc driver's .set_alarm() callback.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
> 
>  drivers/rtc/rtc-cros-ec.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-cros-ec.c b/drivers/rtc/rtc-cros-ec.c
> index f0ea6899c731..ee0062e2d222 100644
> --- a/drivers/rtc/rtc-cros-ec.c
> +++ b/drivers/rtc/rtc-cros-ec.c
> @@ -188,6 +188,10 @@ static int cros_ec_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
>  	if (alarm_time < 0 || alarm_time > U32_MAX)
>  		return -EINVAL;
>  
> +	/* Don't set an alarm in the past. */
> +	if ((u32)alarm_time <= current_time)
> +		return -ETIME;
> +
>  	if (!alrm->enabled) {
>  		/*
>  		 * If the alarm is being disabled, send an alarm
> @@ -196,11 +200,7 @@ static int cros_ec_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
>  		alarm_offset = EC_RTC_ALARM_CLEAR;
>  		cros_ec_rtc->saved_alarm = (u32)alarm_time;
>  	} else {
> -		/* Don't set an alarm in the past. */
> -		if ((u32)alarm_time < current_time)

It's probably worth noting in the commit message that you're also fixing
the case where 'alarm_time == current_time'; in the current driver
source, it *looks* like you're setting a 0-second alarm. But in fact, 0
means EC_RTC_ALARM_CLEAR, which would disable the alarm. So you are
(correctly) returning -ETIME in that case.

Brian

> -			alarm_offset = EC_RTC_ALARM_CLEAR;
> -		else
> -			alarm_offset = (u32)alarm_time - current_time;
> +		alarm_offset = (u32)alarm_time - current_time;
>  	}
>  
>  	ret = cros_ec_rtc_set(cros_ec, EC_CMD_RTC_SET_ALARM, alarm_offset);
> -- 
> 2.11.0
> 
> 
