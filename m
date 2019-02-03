Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C720C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 16:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B98A2177E
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 16:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfBCQas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 11:30:48 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:54012 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbfBCQar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 11:30:47 -0500
Received: from p5492e0d8.dip0.t-ipconnect.de ([84.146.224.216] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gqKfH-0004UY-N9; Sun, 03 Feb 2019 17:30:39 +0100
Date:   Sun, 3 Feb 2019 17:30:39 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
cc:     Sebastian Sewior <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org,
        Stefan Liebler <stli@linux.ibm.com>
Subject: Re: WARN_ON_ONCE(!new_owner) within wake_futex_pi() triggerede
In-Reply-To: <20190202112006.GB3381@osiris>
Message-ID: <alpine.DEB.2.21.1902031718170.8200@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1901302314590.8200@nanos.tec.linutronix.de> <20190130233557.GA4240@linux.ibm.com> <alpine.DEB.2.21.1901310049440.8200@nanos.tec.linutronix.de> <alpine.DEB.2.21.1901310117110.8200@nanos.tec.linutronix.de> <20190131165228.GA32680@osiris>
 <20190131170653.spnrxsiblkssleyd@linutronix.de> <20190201161227.GG3770@osiris> <alpine.DEB.2.21.1902012258290.8200@nanos.tec.linutronix.de> <20190202091043.GA3381@osiris> <alpine.DEB.2.21.1902021027060.8200@nanos.tec.linutronix.de>
 <20190202112006.GB3381@osiris>
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

On Sat, 2 Feb 2019, Heiko Carstens wrote:

> On Sat, Feb 02, 2019 at 11:14:27AM +0100, Thomas Gleixner wrote:
> > On Sat, 2 Feb 2019, Heiko Carstens wrote:
> > So after the unlock @timestamp 337.215675 the kernel does not deal with
> > that futex at all until the failed lock attempt where it rightfully rejects
> > the attempt due to the alleged owner being gone.
> > 
> > So this looks more like user space doing something stupid...
> > 
> > As we talked about the missing barriers before, I just looked at
> > pthread_mutex_trylock() and that does still:
> > 
> > 	if (robust)
> >           {
> >             ENQUEUE_MUTEX_PI (mutex);
> >             THREAD_SETMEM (THREAD_SELF, robust_head.list_op_pending, NULL);
> >           }
> > 
> > So it's missing the barriers which pthread_mutex_lock() has. Grasping for
> > straws obviously....

Looks more like a solid tree than a straw now. :)

> Excellent! Taking a look into the disassembly of nptl/pthread_mutex_trylock.o
> reveals this part:
> 
> 140:   a5 1b 00 01             oill    %r1,1
> 144:   e5 48 a0 f0 00 00       mvghi   240(%r10),0   <--- THREAD_SETMEM (THREAD_SELF, robust_head.list_op_pending, NULL);
> 14a:   e3 10 a0 e0 00 24       stg     %r1,224(%r10) <--- last THREAD_SETMEM of ENQUEUE_MUTEX_PI

Awesome.

> I added a barrier between those two and now the code looks like this:
> 
> 140:   a5 1b 00 01             oill    %r1,1
> 144:   e3 10 a0 e0 00 24       stg     %r1,224(%r10)
> 14a:   e5 48 a0 f0 00 00       mvghi   240(%r10),0
> 
> Looks like this was a one instruction race...

Fun. JFYI, I said that I reversed the stores in glibc and on my x86 test VM
it took more than _3_ days to trigger. But the good news is, that the trace
looks exactly like the ones you provided. So it looks we are on the right
track.

> I'll try to reproduce with the patch below (sprinkling compiler
> barriers just like the other files have).

Looks about right.

Thanks,

	tglx
