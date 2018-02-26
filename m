Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751554AbeBZSYb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 13:24:31 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:40644 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750826AbeBZSY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 13:24:28 -0500
X-Google-Smtp-Source: AH8x226kY2jGRwzzOPuek7KGtIQd32WTvykMI2hCWrYwMq30Ws5eTk6VUjmbsNEo4Imt2YvnBgdtyQ==
Date: Mon, 26 Feb 2018 10:24:25 -0800
From: Brian Norris <briannorris@chromium.org>
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, zyw@rock-chips.com,
        briannorris@google.com, dianders@google.com, jwerner@chromium.org,
        linux-rtc@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>
Subject: Re: [PATCH] rtc: cros-ec: return -ETIME when refused to set alarms
 in the past
Message-ID: <20180226182424.GB225858@rodete-desktop-imager.corp.google.com>
References: <20180225081802.8965-1-jeffy.chen@rock-chips.com>
 <20180226180112.GA225858@rodete-desktop-imager.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180226180112.GA225858@rodete-desktop-imager.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeffy,

A few corrections here. (Sorry, I didn't completely reread the driver
here before sending.)

On Mon, Feb 26, 2018 at 10:01:15AM -0800, Brian Norris wrote:
> On Sun, Feb 25, 2018 at 04:18:02PM +0800, Jeffy Chen wrote:
> > We have a check in __rtc_set_alarm() to return -ETIME when the alarm
> > is in the past.
> > 
> > Since accessing a Chrome OS EC based rtc is a slow operation, we should
> > do that check again inside of the EC rtc driver's .set_alarm() callback.
> 
> Thanks for the patch. I'd note that this is related to the race
> documented in __rtc_set_alarm() (drivers/rtc/interface.c):
> 
>         /*
>          * XXX - We just checked to make sure the alarm time is not
>          * in the past, but there is still a race window where if
>          * the is alarm set for the next second and the second ticks
>          * over right here, before we set the alarm.
>          */
> 
> It feels like we should put this comment somewhere more prominent;
> perhaps some kerneldoc for the .set_alarm() callback? Because I suspect
> that nearly every RTC driver is susceptible to this problem.
> 
> Anyway, I think this patch is helpful, because as you note the EC
> protocol is relatively slow (it's much more than just a register write),
> but your patch still doesn't really cover the whole problem. Even if you
> compare the current time here, time marches on between here and
> EC_CMD_RTC_SET_ALARM. So you can still have the same race, where the RTC
> makes another tick before we set the alarm? Just think: what if we slept
> for a second right after that -ETIME check?
> 
> What happens next...depends on the implementation I suppose. It's
> possible that an alarm could still immediately fire for a "past" event.
> But it's also possible the alarm will get dropped [1].

In the particular case of this driver...we're actually OK because the
alarm time is programmed via an offset. So as long as we give it a
postive number, we're in the clear. We might set a longer than-expected
alarm I suppose, but that's not the end of the world...

> I wonder if a better solution would be to re-check the clock right after
> setting the alarm. If the alarm is already past, then we should return
> -ETIME? Is there any harm in double-reporting an alarm? (If so, we could
> try to add accounting information somehow...)
> 
> I also wonder if that check should be done in the generic code (perhaps
> with a flag to opt-in or opt-out?), since this really seems like a
> fundamental problem of the interface.

Given we actually don't need this approach for the CrOS EC code, it
definitely would need to be possible to disable such code ;) But that
still doesn't mean other RTC drivers are safe.

One more note below:

> Brian
> 
> [1] And lest we think that dropping it is fine: this breaks, e.g.,
> hwclock which relies on RTC_UIE_ON -> rtc_update_irq_enable(), which
> sets a 1-second alarm and expects it to fire an interrupt.

> > Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> > ---
> > 
> >  drivers/rtc/rtc-cros-ec.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/rtc/rtc-cros-ec.c b/drivers/rtc/rtc-cros-ec.c
> > index f0ea6899c731..ee0062e2d222 100644
> > --- a/drivers/rtc/rtc-cros-ec.c
> > +++ b/drivers/rtc/rtc-cros-ec.c
> > @@ -188,6 +188,10 @@ static int cros_ec_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
> >  	if (alarm_time < 0 || alarm_time > U32_MAX)
> >  		return -EINVAL;
> >  
> > +	/* Don't set an alarm in the past. */
> > +	if ((u32)alarm_time <= current_time)
> > +		return -ETIME;

I don't think we want this check on the 'disabled' case. Perhaps just
keep this under the 'else' below still?

In fact, there are *no* callers of __rtc_set_alarm() with
!alrm->enabled, but still, since this driver is *trying* to account for
that, it seems wise to retain that attempt (or else remove it entirely).

Brian

> > +
> >  	if (!alrm->enabled) {
> >  		/*
> >  		 * If the alarm is being disabled, send an alarm
> > @@ -196,11 +200,7 @@ static int cros_ec_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
> >  		alarm_offset = EC_RTC_ALARM_CLEAR;
> >  		cros_ec_rtc->saved_alarm = (u32)alarm_time;
> >  	} else {
> > -		/* Don't set an alarm in the past. */
> > -		if ((u32)alarm_time < current_time)
> > -			alarm_offset = EC_RTC_ALARM_CLEAR;
> > -		else
> > -			alarm_offset = (u32)alarm_time - current_time;
> > +		alarm_offset = (u32)alarm_time - current_time;
> >  	}
> >  
> >  	ret = cros_ec_rtc_set(cros_ec, EC_CMD_RTC_SET_ALARM, alarm_offset);
> > -- 
> > 2.11.0
> > 
> > 
