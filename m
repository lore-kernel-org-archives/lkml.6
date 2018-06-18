Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20023C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 18:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1A322083D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 18:29:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1A322083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935920AbeFRS3Y (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 14:29:24 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:64322 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935300AbeFRS3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 14:29:22 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id w5IITDj7030462;
        Mon, 18 Jun 2018 20:29:13 +0200
Date:   Mon, 18 Jun 2018 20:29:13 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Kees Cook <keescook@chromium.org>, linux-leds@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] leds: ledtrig-activity: use ktime_get_boot_ns()
Message-ID: <20180618182913.GA30450@1wt.eu>
References: <20180618144210.72367-1-arnd@arndb.de>
 <20180618150715.GA30470@amd>
 <CAK8P3a1K19WoEGaqrj6Fx0GYyj1jmA50dS+dMJuF7ugkwjCiug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1K19WoEGaqrj6Fx0GYyj1jmA50dS+dMJuF7ugkwjCiug@mail.gmail.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Mon, Jun 18, 2018 at 05:47:28PM +0200, Arnd Bergmann wrote:
> On Mon, Jun 18, 2018 at 5:07 PM, Pavel Machek <pavel@ucw.cz> wrote:
> >> diff --git a/drivers/leds/trigger/ledtrig-activity.c b/drivers/leds/trigger/ledtrig-activity.c
> >> index 5081894082bd..589c1bc4d0b9 100644
> >> --- a/drivers/leds/trigger/ledtrig-activity.c
> >> +++ b/drivers/leds/trigger/ledtrig-activity.c
> >> @@ -37,7 +37,6 @@ static void led_activity_function(struct timer_list *t)
> >>       struct activity_data *activity_data = from_timer(activity_data, t,
> >>                                                        timer);
> >>       struct led_classdev *led_cdev = activity_data->led_cdev;
> >> -     struct timespec boot_time;
> >>       unsigned int target;
> >>       unsigned int usage;
> >>       int delay;
> >> @@ -57,7 +56,7 @@ static void led_activity_function(struct timer_list *t)
> >>               return;
> >>       }
> >>
> >> -     get_monotonic_boottime(&boot_time);
> >> +     curr_boot = ktime_get_boot_ns();
> >>
> >>       cpus = 0;
> >>       curr_used = 0;
> >> @@ -76,7 +75,6 @@ static void led_activity_function(struct timer_list *t)
> >>        * down to 16us, ensuring we won't overflow 32-bit computations below
> >>        * even up to 3k CPUs, while keeping divides cheap on smaller systems.
> >>        */
> >> -     curr_boot = timespec_to_ns(&boot_time) * cpus;
> >
> > Original code is pretty weird (notice the * cpus), so I'm
> > double-checking.
> 
> Ok, dropping the *cpus was not intentional, I'll repost a version that puts
> it that back. Thanks for pointing this out!

Pavel is right, the *cpus is intentional. curr_boot contains the cumulated
time for all CPUs in order to measure an average usage over all of them.
By keeping it scaled by #cpus we avoid useless divides.

Cheers,
Willy
