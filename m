Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751773AbeBRTv7 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 14:51:59 -0500
Received: from mail-lf0-f42.google.com ([209.85.215.42]:47081 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751689AbeBRTv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 14:51:57 -0500
X-Google-Smtp-Source: AH8x225qmyredLz62ciEOjoEu4hAI39GrvNQ1GHZLPffJHal45XhvSf4qoLr6wvojYLsCd0mJ4gUlA==
Date: Sun, 18 Feb 2018 20:51:53 +0100
From: =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
To: Jonathan Woithe <jwoithe@just42.net>
Cc: Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] platform/x86: fujitsu-laptop: Define constants for
 backlight power control
Message-ID: <20180218195153.GA3665@kmp-mobile.hq.kempniu.pl>
References: <20180211210727.12130-1-kernel@kempniu.pl>
 <20180211210727.12130-7-kernel@kempniu.pl>
 <20180216105014.GB25974@marvin.atrad.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180216105014.GB25974@marvin.atrad.com.au>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +/* FUNC interface - backlight power control */
> > +#define BACKLIGHT_POWER	0x4
> > +#define BACKLIGHT_OFF	0x3
> > +#define BACKLIGHT_ON	0x0
> 
> A minor detail: BACKLIGHT_OFF and BACKLIGHT_ON are potential parameter
> values while BACKLIGHT_POWER is essentially a parameter selector.  Should
> the name of BACKLIGHT_POWER reflect this difference?  It could be difficult
> to do without making the resulting identifier a little long.  The best I can
> come up with is BACKLIGHT_PARAM_POWER or (if a saving of one character is
> desired) BACKLIGHT_PARM_POWER.

So, I tried to somehow unify constant naming throughout the module a few
times by now, but it seems that whichever naming pattern I chose, there
was always some exception to the rule.  Of course the module code is not
to blame, it is caused by the firmware treating logically related
features (like controlling various LEDs) in diverse ways.

Thus, I am perfectly fine with using BACKLIGHT_PARAM_POWER for now,
because I do not have a better idea yet.  If I ever come up with a
constant naming scheme that would cover all the constants in the module
(or at least all those directly related to call_fext_func()), I will
propose it here.

> > @@ -818,7 +825,8 @@ static int acpi_fujitsu_laptop_add(struct acpi_device *device)
> >  	/* Sync backlight power status */
> >  	if (fujitsu_bl && fujitsu_bl->bl_device &&
> >  	    acpi_video_get_backlight_type() == acpi_backlight_vendor) {
> > -		if (call_fext_func(fext, FUNC_BACKLIGHT, 0x2, 0x4, 0x0) == 3)
> > +		if (call_fext_func(fext, FUNC_BACKLIGHT, 0x2, BACKLIGHT_POWER,
> > +				   0x0) == 3)
> >  			fujitsu_bl->bl_device->props.power = FB_BLANK_POWERDOWN;
> >  		else
> >  			fujitsu_bl->bl_device->props.power = FB_BLANK_UNBLANK;
> 
> I'm curious: this fext function call is, I think, returning the current
> backlight power value.  If that's the case, is the value of 3 used in the
> test of the return function conceptually BACKLIGHT_OFF, and if so, should we
> use BACKLIGHT_OFF instead of the numeric constant?  It seems likely given
> that it results in the backlight power property being set to
> FB_BLANK_POWERDOWN.

Ah, yes, good catch.  Will fix, thanks.

-- 
Best regards,
Michał Kępień
