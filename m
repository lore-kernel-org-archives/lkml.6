Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49339C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F43D2084A
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725298AbfA2Jpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 04:45:53 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:43871 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727901AbfA2Jpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 04:45:50 -0500
Received: from p5492e0d8.dip0.t-ipconnect.de ([84.146.224.216] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1goPxg-0006Oz-VO; Tue, 29 Jan 2019 10:45:45 +0100
Date:   Tue, 29 Jan 2019 10:45:44 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org,
        Stefan Liebler <stli@linux.ibm.com>,
        Sebastian Sewior <bigeasy@linutronix.de>
Subject: Re: WARN_ON_ONCE(!new_owner) within wake_futex_pi() triggered
In-Reply-To: <20190129090108.GA26906@osiris>
Message-ID: <alpine.DEB.2.21.1901291012330.1669@nanos.tec.linutronix.de>
References: <20181127081115.GB3625@osiris> <alpine.DEB.2.21.1811281526430.1532@nanos.tec.linutronix.de> <20181129112321.GB3449@osiris> <20190128134410.GA28485@hirez.programming.kicks-ass.net> <20190128135804.GB28878@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1901281650310.1582@nanos.tec.linutronix.de> <20190129090108.GA26906@osiris>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2019, Heiko Carstens wrote:
> On Mon, Jan 28, 2019 at 04:53:19PM +0100, Thomas Gleixner wrote:
> > Patch below cures that.
> 
> With your patch the kernel warning doesn't occur anymore. So if this
> is supposed to be the fix feel free to add:

Yes, it's supposed to be the fix.
> 
> However now I see every now and then the following failure from the
> same test case:
> 
> tst-robustpi8: ../nptl/pthread_mutex_lock.c:425: __pthread_mutex_lock_full: Assertion `INTERNAL_SYSCALL_ERRNO (e, __err) != ESRCH || !robust' failed.
> 
> 		/* ESRCH can happen only for non-robust PI mutexes where
> 		   the owner of the lock died.	*/
> 		assert (INTERNAL_SYSCALL_ERRNO (e, __err) != ESRCH || !robust);
> 
> I just verified that this happened also without your patch, I just
> didn't see it since I started my tests with panic_on_warn=1 and the
> warning triggered always earlier.
> So, this seems to be something different.

Moo. I ran the test loop all night (simply because I forgot to stop it) and
of course this does not trigger here. Could you try to gather a bit more
information with lightweight tracing?

Something like the below should give us at least a clue. Stop the tst loop
when the assert triggers and then extract the trace.

Thanks,

	tglx

8<--------------

#!/bin/sh

# Substitute with your ld comm string if it starts differently 
C=ld-linux

echo 'comm ~ "$C*"' >/sys/kernel/debug/tracing/events/syscalls/sys_enter_futex/filter
echo 'comm ~ "$C*"' >/sys/kernel/debug/tracing/events/syscalls/sys_exit_futex/filter
echo 'comm ~ "$C*"' >/sys/kernel/debug/tracing/events/sched/sched_process_exit/filter
echo 'prev_comm ~ "$C*" || next_comm ~ "$C*"' >/sys/kernel/debug/tracing/events/sched/sched_switch/filter

echo 1 > /sys/kernel/debug/tracing/events/syscalls/sys_enter_futex/enable
echo 1 > /sys/kernel/debug/tracing/events/syscalls/sys_exit_futex/enable
echo 1 > /sys/kernel/debug/tracing/events/sched/sched_process_exit/enable
echo 1 > /sys/kernel/debug/tracing/events/sched/sched_switch/enable

