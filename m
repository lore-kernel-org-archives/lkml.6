Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB89C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8AFB218A3
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731058AbfA3NZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 08:25:33 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:47172 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfA3NZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 08:25:32 -0500
Received: from [2a01:598:b890:92b7:fc90:b8ff:fed0:1fb6] (helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1goprr-0000wj-5r; Wed, 30 Jan 2019 14:25:27 +0100
Date:   Wed, 30 Jan 2019 14:25:20 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
cc:     Sebastian Sewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org,
        Stefan Liebler <stli@linux.ibm.com>
Subject: Re: WARN_ON_ONCE(!new_owner) within wake_futex_pi() triggered
In-Reply-To: <20190130125955.GD5299@osiris>
Message-ID: <alpine.DEB.2.21.1901301423130.5537@nanos.tec.linutronix.de>
References: <20190129090108.GA26906@osiris> <alpine.DEB.2.21.1901291012330.1669@nanos.tec.linutronix.de> <20190129102409.GB26906@osiris> <20190129103557.GF28485@hirez.programming.kicks-ass.net> <alpine.DEB.2.21.1901291402410.1513@nanos.tec.linutronix.de>
 <20190129132303.GE26906@osiris> <20190129151058.GG26906@osiris> <20190129171653.ycl64psq2liy5o5c@linutronix.de> <20190130094913.GC5299@osiris> <alpine.DEB.2.21.1901301303320.5537@nanos.tec.linutronix.de> <20190130125955.GD5299@osiris>
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

On Wed, 30 Jan 2019, Heiko Carstens wrote:
> On Wed, Jan 30, 2019 at 01:15:18PM +0100, Thomas Gleixner wrote:
> > On Wed, 30 Jan 2019, Heiko Carstens wrote:
> > > On Tue, Jan 29, 2019 at 06:16:53PM +0100, Sebastian Sewior wrote:
> > > >  	if (unlikely(p->flags & PF_KTHREAD)) {
> > > >  		put_task_struct(p);
> > > 
> > > Last lines of the trace with your additional patch (full log attached):
> > > 
> > >            <...>-50539 [003] ....  2376.398223: sys_futex -> 0x0
> > >            <...>-50539 [003] ....  2376.398223: sys_futex(uaddr: 3ffb7700208, op: 6, val: 1, utime: 0, uaddr2: 3, val3: 0)
> > >            <...>-50539 [003] ....  2376.398225: attach_to_pi_owner: Missing pid 50734
> > >            <...>-50539 [003] ....  2376.398226: handle_exit_race: uval2 vs uval 8000c62e vs 8000c62e (-1)
> > 
> > So the user space value is: 8000c62e. FUTEX_WAITER bit is set and the owner
> > of the futex is PID 50734, which exited long time ago:
> > 
> >            <...>-50734 [000] ....  2376.394936: sched_process_exit: comm=ld64.so.1 pid=50734 prio=120
> > 
> > But at least from the kernel view 50734 has released it last:
> > 
> >            <...>-50734 [000] ....  2376.394930: sys_futex(uaddr: 3ffb7700208, op: 7, val: 3ff00000007, utime: 3ffb3ef8910, uaddr2: 3ffb3ef8910, val3: 3ffc0afe987)
> >            <...>-50539 [003] ....  2376.398223: sys_futex(uaddr: 3ffb7700208, op: 6, val: 1, utime: 0, uaddr2: 3, val3: 0)
> > 
> > Now, if it would have acquired it in userspace again before exiting, then
> > the robust list exit code should have set the OWNER_DIED bit as well, but
> > that's not set....
> > 
> > debug patch for the robust list exit handling below.
> 
> Last lines of trace below (full log attached):

SNIP...

It's the same picture as last time and the only occurence of the futex in
question in the context of the dead task is:

           <...>-56956 [007] ....   658.804018: sys_futex(uaddr: 3ff9e880050, op: 7, val: 3ff00000007, utime: 3ff9b078910, uaddr2: 3ff9b078910, val3: 3ffea67e3f7)

The robust list exit of that task does not contain the user space address 3ff9e880050.

Confused and of course the problem does not reproduce on x86. Sigh.

I'll think about it some more.

Thanks,

	tglx


