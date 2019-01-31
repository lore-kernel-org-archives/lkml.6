Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9864C282D7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 00:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85B432081B
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 00:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbfAaA1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 19:27:34 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:48423 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfAaA1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 19:27:33 -0500
Received: from p5492e0d8.dip0.t-ipconnect.de ([84.146.224.216] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gp0CU-0000WP-9v; Thu, 31 Jan 2019 01:27:26 +0100
Date:   Thu, 31 Jan 2019 01:27:25 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
cc:     Sebastian Sewior <bigeasy@linutronix.de>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org,
        Stefan Liebler <stli@linux.ibm.com>
Subject: Re: WARN_ON_ONCE(!new_owner) within wake_futex_pi() triggerede
In-Reply-To: <alpine.DEB.2.21.1901310049440.8200@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1901310117110.8200@nanos.tec.linutronix.de>
References: <20190129171653.ycl64psq2liy5o5c@linutronix.de> <20190130094913.GC5299@osiris> <alpine.DEB.2.21.1901301303320.5537@nanos.tec.linutronix.de> <20190130125955.GD5299@osiris> <20190130132420.spwrq2d4oxeydk5s@linutronix.de>
 <alpine.DEB.2.21.1901301428390.5537@nanos.tec.linutronix.de> <alpine.DEB.2.21.1901301517220.1950@nanos.tec.linutronix.de> <alpine.DEB.2.21.1901301853290.1622@nanos.tec.linutronix.de> <20190130210733.mg6aascw2gzl3oqz@linutronix.de>
 <alpine.DEB.2.21.1901302314590.8200@nanos.tec.linutronix.de> <20190130233557.GA4240@linux.ibm.com> <alpine.DEB.2.21.1901310049440.8200@nanos.tec.linutronix.de>
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

On Thu, 31 Jan 2019, Thomas Gleixner wrote:

> On Wed, 30 Jan 2019, Paul E. McKenney wrote:
> > On Thu, Jan 31, 2019 at 12:13:51AM +0100, Thomas Gleixner wrote:
> > > I might be wrong as usual, but this would definitely explain the fail very
> > > well.
> > 
> > On recent versions of GCC, the fix would be to put this between the two
> > stores that need ordering:
> > 
> > 	__atomic_thread_fence(__ATOMIC_RELEASE);
> > 
> > I must defer to Heiko on whether s390 GCC might tear the stores.  My
> > guess is "probably not".  ;-)
> 
> So I just checked the latest glibc code. It has:
> 
>             /* We must not enqueue the mutex before we have acquired it.
>                Also see comments at ENQUEUE_MUTEX.  */
>             __asm ("" ::: "memory");
>             ENQUEUE_MUTEX_PI (mutex);
>             /* We need to clear op_pending after we enqueue the mutex.  */
>             __asm ("" ::: "memory");
>             THREAD_SETMEM (THREAD_SELF, robust_head.list_op_pending, NULL);
> 
> 8f9450a0b7a9 ("Add compiler barriers around modifications of the robust mutex list.")
> 
> in the glibc repository, There since Dec 24 2016 ...

And of course, I'm using the latest greatest glibc for testing that, so I'm
not at all surprised that it just does not reproduce on my tests.

I just hacked the ordering and restarted the test. If the theory holds,
then this should die sooner than later.

Thanks,

	tglx
