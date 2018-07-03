Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FB3C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBC6B20855
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:54:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBC6B20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753014AbeGCKyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 06:54:02 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47464 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752578AbeGCKyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 06:54:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 89CE480D;
        Tue,  3 Jul 2018 03:54:01 -0700 (PDT)
Received: from e107155-lin (unknown [10.1.210.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 35B8C3F5BA;
        Tue,  3 Jul 2018 03:54:00 -0700 (PDT)
Date:   Tue, 3 Jul 2018 11:53:57 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, fweisbec@gmail.com,
        Arnd Bergmann <arnd@arndb.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] tick: prefer a lower rating device only if it's CPU
 local device
Message-ID: <20180703105357.GC1715@e107155-lin>
References: <1525881728-4858-1-git-send-email-sudeep.holla@arm.com>
 <CAOi56cUiPX9JYZzZD5isPF3wZwVDenYY-5J39Ch9CFp-eXXtQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOi56cUiPX9JYZzZD5isPF3wZwVDenYY-5J39Ch9CFp-eXXtQQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 04:44:33PM -0700, Kevin Hilman wrote:
> Hi Sudeep,
> 
> On Wed, May 9, 2018 at 9:02 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > Checking the equality of cpumask for both new and old tick device doesn't
> > ensure that it's CPU local device. This will cause issue if a low rating
> > clockevent tick device is registered first followed by the registration
> > of higher rating clockevent tick device.
> >
> > In such case, clockevents_released list will never get emptied as both
> > the devices get selected as preferred one and we will loop forever in
> > clockevents_notify_released.
> >
> > Cc: Frederic Weisbecker <fweisbec@gmail.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> 
> I've got a arm32 board (meson8b-odroidc1) that's been failing in
> kernelCI.org since the merge window (boot log[1]), and I finally got
> around to bisecting it[2].  Unfortunately, the bisect pointed at a
> merge commit, but with some trial and error (and a suggestion by Arnd)
> I was able to test that revering $SUBJECT commit[3], my problem goes
> away.
>

Interesting. Sorry for causing the regression.

> Another interesting data point is that disabling SMP (either by
> "nosmp" on the command-line or CONFIG_SMP=n) also makes the problem go
> away, without needing to revert this patch.
>

I am not sure of nosmp, but with CONFIG_SMP=n, TICK_BROADCAST also gets
disabled. dummy_timer won't be registered I assume.

I am not sure if dummy_timer is selected as it's per_cpu but the rating
is low anyways.

> AFAICT, this platform, is using a single timer as a clocksource
> ("amlogic,meson6-timer") which is not a per-CPU timer.
>

Yes that's what I could gather from DT. But this is A5 right ? It may
have per CPU TWD(watchdof timer) but DT doesn't specify it, so should be
fine.

> I ran out of time to keep digging on this issue, and I'm still not
> sure exactly what's going on, but I wanted to report it in case anyone
> else has any ideas, and so we can hopefully get it fixed during the
> -rc cycle.
>

From the log, it looks like the platform has booted to userspace. Any chance
we can have a look at:
$ grep "" /sys/devices/system/clock*/{broadcast,clock*}/{available,current}_*

--
Regards,
Sudeep
