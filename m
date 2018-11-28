Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DAAC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 874CB20832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:22:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 874CB20832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbeK2CYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 21:24:04 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:60181 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbeK2CYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 21:24:04 -0500
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gS1ez-0008QK-Bl; Wed, 28 Nov 2018 16:21:53 +0100
Date:   Wed, 28 Nov 2018 16:21:52 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Zhivich, Michael" <mzhivich@akamai.com>
cc:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "tiny.windzz@gmail.com" <tiny.windzz@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "alexander.levin@verizon.com" <alexander.levin@verizon.com>,
        "frederic@kernel.org" <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        "kreview@akamai.com" <kreview@akamai.com>
Subject: Re: [PATCH] softirq: don't push timer softirq handling to
 ksoftirqd
In-Reply-To: <6DB365C6-98F6-4C27-B0BE-0833E5D4962E@akamai.com>
Message-ID: <alpine.DEB.2.21.1811281616570.1532@nanos.tec.linutronix.de>
References: <20181115170701.4696-1-mzhivich@akamai.com> <CALAqxLV0sQaWx837Vrz3hfGdUNSBa+cJWaaL_RpPsgRTMQknuA@mail.gmail.com> <6DB365C6-98F6-4C27-B0BE-0833E5D4962E@akamai.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael,

On Fri, 16 Nov 2018, Zhivich, Michael wrote:
> On 11/15/18, 12:17 PM, "John Stultz" <john.stultz@linaro.org> wrote:
>     Would a more focused fix be to move the clocksource watchdog from a
>     normal timer to a hrtimer?
>     
> That's an interesting idea - it would get clocksource watchdog out of
> ksoftirqd.  However, clocksource watchdog iterates over available CPUs to
> check the TSC on each core (see add_timer_on() call in
> clocksource_watchdog()).  I'm not seeing an API to start an hrtimer on a
> specific CPU - is this possible and I'm missing it?  Or would something
> like this have to be added to hrtimer?

It's surely an interesting idea, but it's not trivial.

There is no way to reliably queue hrtimers remote when high resolution mode
is enabled. It only works when the to be queued timer is not the first to
expire one. If it ends up being the first to expire timer, then there is
currently no way to rearm the remote per cpu clockevent device because it's
not remotely accesible.

It would need an SMP function call, but that needs to be asynchronous due
to locking/interrupt disabled constraints. Maybe ...

Thanks,

	tglx
