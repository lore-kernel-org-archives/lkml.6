Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A089C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B677A23C19
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:48:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B677A23C19
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934236AbeGCQsa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 12:48:30 -0400
Received: from foss.arm.com ([217.140.101.70]:52756 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933637AbeGCQs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 12:48:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6DDD97A9;
        Tue,  3 Jul 2018 09:48:27 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.211.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 195063F5BA;
        Tue,  3 Jul 2018 09:48:25 -0700 (PDT)
Date:   Tue, 3 Jul 2018 17:48:23 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        lkml <linux-kernel@vger.kernel.org>, fweisbec@gmail.com,
        Arnd Bergmann <arnd@arndb.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] tick: prefer a lower rating device only if it's CPU
 local device
Message-ID: <20180703164823.GB15335@e107155-lin>
References: <1525881728-4858-1-git-send-email-sudeep.holla@arm.com>
 <CAOi56cUiPX9JYZzZD5isPF3wZwVDenYY-5J39Ch9CFp-eXXtQQ@mail.gmail.com>
 <20180703105357.GC1715@e107155-lin>
 <CAOi56cW-QsL9gmyF-R9iscZ1M-zM-gJPxcvG=dvB=zrDioZJgA@mail.gmail.com>
 <20180703154459.GA15335@e107155-lin>
 <alpine.DEB.2.21.1807031805560.1601@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1807031805560.1601@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Tue, Jul 03, 2018 at 06:08:19PM +0200, Thomas Gleixner wrote:

[...]

> > > / # cat /sys/devices/system/clockevents/broadcast/current_device
> > > meson6_tick
> >
> > OK, it can support broadcast
> >
> > > / # cat /sys/devices/system/clockevents/clockevent0/current_device
> > > dummy_timer
> > > / # cat /sys/devices/system/clockevents/clockevent1/current_device
> > > dummy_timer
> > > / # cat /sys/devices/system/clockevents/clockevent2/current_device
> > > dummy_timer
> >
> > But I can't understand why is dummy_timer the active event source and
> > not meson6_tick. And you say this is working case ? Looks suspicious.
>
> Because if it switches to broadcast mode then the meson timer cannot longer
> be used as per cpu timer. It's broadcasting to all CPUs via the dummy timer.

Thanks for the explanation. I completely misread the sysfs entry and
assume clockevent_register failed for meson6 and hence regarded as
suspicious which is complete non-sense, my bad. Sorry for that.
I think I now understand the issue.

1. Juno usecase for which $subject was added as fix:

Two system wide timers(cpumask=possible cpus) with rating 300 and 400.
When second one with 400 is added, timer with rating 300 is added to
released list and again added back to main one. In this case both were
chosen as preferred and that resulted in deadlock.

2. Meson6 usecase:

When meson6_tick is added, it's set as preferred and dummy_timer is released.
When it's being added back from the released list, it will be chosen as
preferred as it's per_cpu resulting in deadlock.

I am not sure how to fix this. Should the fix to my original problem have
checks for both old and new for per-cpu  to prevent the issue reported on
Meson6

--
Regards,
Sudeep
