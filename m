Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F02C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 19:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1726C2080D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 19:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbeLSTN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 14:13:26 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:59591 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbeLSTN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 14:13:26 -0500
Received: from p4fea4820.dip0.t-ipconnect.de ([79.234.72.32] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gZhHW-0001uC-Kg; Wed, 19 Dec 2018 20:13:22 +0100
Date:   Wed, 19 Dec 2018 20:13:22 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Stefan Liebler <stli@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Darren Hart <dvhart@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [patch] futex: Cure exit race
In-Reply-To: <539c47359b37a5b6b9177da823be45d6@dl.linutronix.de>
Message-ID: <alpine.DEB.2.21.1812191934410.1651@nanos.tec.linutronix.de>
References: <20181210152311.986181245@linutronix.de> <20181210160205.GQ5289@hirez.programming.kicks-ass.net> <alpine.DEB.2.21.1812101824070.1667@nanos.tec.linutronix.de> <20181212090418.GT5289@hirez.programming.kicks-ass.net> <alpine.DEB.2.21.1812172239090.1660@nanos.tec.linutronix.de>
 <539c47359b37a5b6b9177da823be45d6@dl.linutronix.de>
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

On Wed, 19 Dec 2018, Thomas Gleixner wrote:
> On 2018-12-18 10:31, Thomas Gleixner wrote:
> > On Wed, 12 Dec 2018, Peter Zijlstra wrote:
> > > On Mon, Dec 10, 2018 at 06:43:51PM +0100, Thomas Gleixner wrote:
> > > @@ -806,6 +806,8 @@ void __noreturn do_exit(long code)
> > >  		 * task into the wait for ever nirwana as well.
> > >  		 */
> > >  		tsk->flags |= PF_EXITPIDONE;
> > > +		smp_mb();
> > > +		wake_up_bit(&tsk->flags, 3 /* PF_EXITPIDONE */);
> > 
> > Using ilog2(PF_EXITPIDONE) spares that horrible inline comment and more
> > importantly selects the right bit. 0x04 is bit 2 ....
> 
> Plus wake_up_bit() and wait_on_bit() want an unsigned long, but tsk->flags is
> unsigned int....
> 
> Moar staring....

Aside of that calling wake_on_bit() unconditionally can be slow if the
waitqueue in the hash bucket is not empty.

So while cooking up an alternative solution I found yet another exit race:

  CPU0	 	       		   CPU1

  sys_futex()                      sys_exit()
   futex_lock_pi()                  do_exit()
   No waiters:
   *uaddr == 0x00000PID;
   Set waiter bit
   *uaddr = 0x80000PID;
   attach_to_pi_owner()
    tsk = get_task(PID);            exit_signals(tsk)
    if (!(tsk->flags & PF_EXITING))
       ...                           tsk->flags |= PF_EXITING;
                                    mm_release(tsk)
				      exit_robust_list(tsk)
				        Set owner died and clear PID
					*uaddr = 0xC0000000;
                                      if (unlikely(!list_empty(&tsk->pi_state_list)))
       list_add(&pi_state->list,
             &tsk->pi_state_list);

I put that all on hold until Jan 7.

If somebody is really bored, here is the WIP patch series which addresses
the live lock mess: https://tglx.de/~tglx/patches.tar

Thanks,

	tglx

