Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751831AbeB0D4A (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 22:56:00 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50241 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751631AbeB0Dz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 22:55:59 -0500
X-Google-Smtp-Source: AH8x22536eIXP4VmcLtfuba9pRZRl8/0+/FYfnIunGtiN+wvs+aP7rce1yK1rcOQ8nAYaJ0THClEatonMKufERvuOOA=
MIME-Version: 1.0
In-Reply-To: <20180227025003.8823-1-jeffy.chen@rock-chips.com>
References: <20180227025003.8823-1-jeffy.chen@rock-chips.com>
From: Brian Norris <briannorris@google.com>
Date: Mon, 26 Feb 2018 19:55:56 -0800
Message-ID: <CA+ASDXOiNSRkG2eme6CUwF1qe4qVdP_uQqVAepRa8KssOY5D9A@mail.gmail.com>
Subject: Re: [RESEND PATCH v3] rtc: cros-ec: return -ETIME when refused to set
 alarms in the past
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        Chris Zhong <zyw@rock-chips.com>, Doug Anderson <dianders@google.com>,
        Julius Werner <jwerner@chromium.org>, linux-rtc@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeffy,

On Mon, Feb 26, 2018 at 6:50 PM, Jeffy Chen <jeffy.chen@rock-chips.com> wrote:
> Since accessing a Chrome OS EC based rtc is a slow operation, there is a
> race window where if the alarm is set for the next second and the second
> ticks over right before calculating the alarm offset.
>
> In this case the current driver is setting a 0-second alarm, which would
> be considered as disabling alarms by the EC(EC_RTC_ALARM_CLEAR).
>
> This breaks, e.g., hwclock which relies on RTC_UIE_ON ->
> rtc_update_irq_enable(), which sets a 1-second alarm and expects it to
> fire an interrupt.
>
> So return -ETIME when the alarm is in the past, follow __rtc_set_alarm().
>
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>

Commit message is better. Thanks! And this is exactly what I was
already testing. I still need to get through a bit more testing to
ensure it has resolved all the races I saw, but it's good on several
of them:

Reviewed-by: Brian Norris <briannorris@chromium.org>
Tested-by: Brian Norris <briannorris@chromium.org>

> ---
>
> Changes in v3:
> Fix alarm time comparing.
>
> Changes in v2:
> Rewrite commit message as Brian suggested.
> Check alarm time only when that alarm is enabled.
>
>  drivers/rtc/rtc-cros-ec.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/rtc/rtc-cros-ec.c b/drivers/rtc/rtc-cros-ec.c
> index f0ea6899c731..bf7ced095c94 100644
> --- a/drivers/rtc/rtc-cros-ec.c
> +++ b/drivers/rtc/rtc-cros-ec.c
> @@ -197,10 +197,10 @@ static int cros_ec_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
>                 cros_ec_rtc->saved_alarm = (u32)alarm_time;
>         } else {
>                 /* Don't set an alarm in the past. */
> -               if ((u32)alarm_time < current_time)
> -                       alarm_offset = EC_RTC_ALARM_CLEAR;
> -               else
> -                       alarm_offset = (u32)alarm_time - current_time;
> +               if ((u32)alarm_time <= current_time)
> +                       return -ETIME;
> +
> +               alarm_offset = (u32)alarm_time - current_time;
>         }
>
>         ret = cros_ec_rtc_set(cros_ec, EC_CMD_RTC_SET_ALARM, alarm_offset);
> --
> 2.11.0
>
>
