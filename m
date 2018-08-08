Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6C8C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E963E216FB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:05:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E963E216FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbeHHLYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 07:24:02 -0400
Received: from muru.com ([72.249.23.125]:53058 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727229AbeHHLYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 07:24:02 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id C9C06805C;
        Wed,  8 Aug 2018 09:08:47 +0000 (UTC)
Date:   Wed, 8 Aug 2018 02:05:12 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>, nekit1000@gmail.com,
        mpartap@gmx.net, Merlijn Wajer <merlijn@wizzup.org>
Subject: Re: Droid 4: suspend to RAM?
Message-ID: <20180808090512.GQ99251@atomide.com>
References: <20180725200205.GA29594@amd>
 <CAOf5uwkyPoDT8TZe9V24p+nQMiee9XfD=943xwx0ThGi9_cPng@mail.gmail.com>
 <20180725212853.GA1965@amd>
 <20180727113214.GA32069@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727113214.GA32069@amd>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [180727 11:35]:
> Hi!
> > > > high even before modem (and thus USB) is enabled.
> > > >
> > > > Interestingly, CyanogenMod and Jolla seem to have higher power
> > > > consumption than stock operating system.
> > > >
> > > > (My Linux can survive for 10 hours, stock system could survive for 4
> > > > days if I'm not mistaken).
> > > >
> > > > I thought I would experiment with suspend to RAM.. and it indeed
> > > > seemed to suspend ok, but I could not wake it up. Do I need to set up
> > > > wakeup with button somehow? Is suspend to RAM required for good power
> > > > consumption?
> > > 
> > > Sorry but pm subsystem has debug mode that you can test in a easy way.
> > > You can even wakeup by any rtc alarm easily.
> > 
> > Yes, that is how it works on PC (but there power button works,
> > too). Is it expected to work on Droid in v4.18?
> 
> I tried setting up wakeup using RTC, but no, it does not seem to work:
> 
> root@devuan:/my/tui/d4# rtcwake -m no -s 5
> rtcwake: wakeup using /dev/rtc0 at Fri Jul 27 11:28:44 2018
> root@devuan:/my/tui/d4# echo mem > /sys/power/state

Works for me here as tested on next-20180808, maybe you don't have
CONFIG_RTC_DRV_CPCAP? Maybe you are trying to use CONFIG_RTC_DRV_OMAP?

Then for deeper idle modes, you need to also idle UARTs, and unbind or
unload USB related modules. You should get to something like 160mW
power consumption with mdm6600 enabled and SoC suspended that way.

Then again system running idle is about the same with timers and
interrupts working so I'd just idle UARTs and unload USB modules :)

My UART idle script below for reference.

Regards,

Tony

8< ----------------
#!/bin/bash

# Configure PM runtime autosuspend
uarts=$(find /sys/bus/platform/devices/4*.serial/power/ -type d)
for uart in $uarts; do
        echo -n 3000 > $uart/autosuspend_delay_ms
        echo -n enabled > $uart/wakeup
        echo -n auto > $uart/control
done

# Configure wake-up from suspend
uarts=$(find /sys/class/tty/tty[SO]*/power/ -type d 2>/dev/null)
for uart in $uarts; do
        echo -n enabled > $uart/wakeup
done

echo -n 1 > /sys/kernel/debug/pm_debug/enable_off_mode





