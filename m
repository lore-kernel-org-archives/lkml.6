Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60ADBC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D3A6208C2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:08:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D3A6208C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933656AbeGCQIY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 12:08:24 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:44749 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933465AbeGCQIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 12:08:22 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1faNql-0004tI-V4; Tue, 03 Jul 2018 18:08:20 +0200
Date:   Tue, 3 Jul 2018 18:08:19 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Sudeep Holla <sudeep.holla@arm.com>
cc:     Kevin Hilman <khilman@baylibre.com>,
        lkml <linux-kernel@vger.kernel.org>, fweisbec@gmail.com,
        Arnd Bergmann <arnd@arndb.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH] tick: prefer a lower rating device only if it's CPU
 local device
In-Reply-To: <20180703154459.GA15335@e107155-lin>
Message-ID: <alpine.DEB.2.21.1807031805560.1601@nanos.tec.linutronix.de>
References: <1525881728-4858-1-git-send-email-sudeep.holla@arm.com> <CAOi56cUiPX9JYZzZD5isPF3wZwVDenYY-5J39Ch9CFp-eXXtQQ@mail.gmail.com> <20180703105357.GC1715@e107155-lin> <CAOi56cW-QsL9gmyF-R9iscZ1M-zM-gJPxcvG=dvB=zrDioZJgA@mail.gmail.com>
 <20180703154459.GA15335@e107155-lin>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jul 2018, Sudeep Holla wrote:
> On Tue, Jul 03, 2018 at 08:04:37AM -0700, Kevin Hilman wrote:
> > / # ls -l /sys/devices/system/clocksource
> > total 0
> > drwxr-xr-x    3 root     root             0 Jan  1 00:00 clocksource0
> > drwxr-xr-x    2 root     root             0 Jan  1 00:00 power
> > -rw-r--r--    1 root     root          4096 Jan  1 00:00 uevent
> > / # cat /sys/devices/system/clocksource/clocksource0/available_clocksource
> > timer jiffies
> 
> Looks good.
> 
> > / # cat /sys/devices/system/clocksource/clocksource0/current_clocksource
> > timer
> >
> 
> OK, meson6 clocksource is active
> 
> > / # cat /sys/devices/system/clockevents/broadcast/current_device
> > meson6_tick
> 
> OK, it can support broadcast
> 
> > / # cat /sys/devices/system/clockevents/clockevent0/current_device
> > dummy_timer
> > / # cat /sys/devices/system/clockevents/clockevent1/current_device
> > dummy_timer
> > / # cat /sys/devices/system/clockevents/clockevent2/current_device
> > dummy_timer
> 
> But I can't understand why is dummy_timer the active event source and
> not meson6_tick. And you say this is working case ? Looks suspicious.

Because if it switches to broadcast mode then the meson timer cannot longer
be used as per cpu timer. It's broadcasting to all CPUs via the dummy timer.

Thanks,

	tglx
