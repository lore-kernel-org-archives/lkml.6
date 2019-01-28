Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A96BC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76C252177E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbfA1Pxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:53:38 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:42479 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729082AbfA1Pxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:53:33 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1go9Dy-0003sj-Om; Mon, 28 Jan 2019 16:53:26 +0100
Date:   Mon, 28 Jan 2019 16:53:19 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org,
        Stefan Liebler <stli@linux.ibm.com>,
        Sebastian Sewior <bigeasy@linutronix.de>
Subject: Re: WARN_ON_ONCE(!new_owner) within wake_futex_pi() triggered
In-Reply-To: <20190128135804.GB28878@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1901281650310.1582@nanos.tec.linutronix.de>
References: <20181127081115.GB3625@osiris> <alpine.DEB.2.21.1811281526430.1532@nanos.tec.linutronix.de> <20181129112321.GB3449@osiris> <20190128134410.GA28485@hirez.programming.kicks-ass.net> <20190128135804.GB28878@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jan 2019, Peter Zijlstra wrote:
> On Mon, Jan 28, 2019 at 02:44:10PM +0100, Peter Zijlstra wrote:
> > On Thu, Nov 29, 2018 at 12:23:21PM +0100, Heiko Carstens wrote:
> > 
> > > And indeed, if I run only this test case in an endless loop and do
> > > some parallel work (like kernel compile) it currently seems to be
> > > possible to reproduce the warning:
> > > 
> > > while true; do time ./testrun.sh nptl/tst-robustpi8 --direct ; done
> > > 
> > > within the build directory of glibc (2.28).
> > 
> > Right; so that reproduces for me.
> > 
> > After staring at all that for a while; trying to remember how it all
> > worked (or supposed to work rather), I became suspiscous of commit:
> > 
> >   56222b212e8e ("futex: Drop hb->lock before enqueueing on the rtmutex")
> > 
> > And indeed, when I revert that; the above reproducer no longer works (as
> > in, it no longer triggers in minutes and has -- so far -- held up for an
> > hour+ or so).

Right after staring long enough at it, the commit simply forgot to give
__rt_mutex_start_proxy_lock() the same treatment as it gave to
rt_mutex_wait_proxy_lock().

Patch below cures that.

Thanks,

	tglx

8<----------------

--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -2845,7 +2845,7 @@ static int futex_lock_pi(u32 __user *uad
 		ret = rt_mutex_futex_trylock(&q.pi_state->pi_mutex);
 		/* Fixup the trylock return value: */
 		ret = ret ? 0 : -EWOULDBLOCK;
-		goto no_block;
+		goto cleanup;
 	}
 
 	rt_mutex_init_waiter(&rt_waiter);
@@ -2870,17 +2870,15 @@ static int futex_lock_pi(u32 __user *uad
 	if (ret) {
 		if (ret == 1)
 			ret = 0;
-
-		spin_lock(q.lock_ptr);
 		goto no_block;
 	}
 
-
 	if (unlikely(to))
 		hrtimer_start_expires(&to->timer, HRTIMER_MODE_ABS);
 
 	ret = rt_mutex_wait_proxy_lock(&q.pi_state->pi_mutex, to, &rt_waiter);
 
+no_block:
 	spin_lock(q.lock_ptr);
 	/*
 	 * If we failed to acquire the lock (signal/timeout), we must
@@ -2894,7 +2892,7 @@ static int futex_lock_pi(u32 __user *uad
 	if (ret && !rt_mutex_cleanup_proxy_lock(&q.pi_state->pi_mutex, &rt_waiter))
 		ret = 0;
 
-no_block:
+cleanup:
 	/*
 	 * Fixup the pi_state owner and possibly acquire the lock if we
 	 * haven't already.
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1749,9 +1749,6 @@ int __rt_mutex_start_proxy_lock(struct r
 		ret = 0;
 	}
 
-	if (unlikely(ret))
-		remove_waiter(lock, waiter);
-
 	debug_rt_mutex_print_deadlock(waiter);
 
 	return ret;
@@ -1778,6 +1775,8 @@ int rt_mutex_start_proxy_lock(struct rt_
 
 	raw_spin_lock_irq(&lock->wait_lock);
 	ret = __rt_mutex_start_proxy_lock(lock, waiter, task);
+	if (unlikely(ret))
+		remove_waiter(lock, waiter);
 	raw_spin_unlock_irq(&lock->wait_lock);
 
 	return ret;

