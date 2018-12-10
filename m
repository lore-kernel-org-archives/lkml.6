Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C78EC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EE832082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:44:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EE832082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbeLJRoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:44:00 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:34038 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbeLJRn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:43:59 -0500
Received: from p4fea4820.dip0.t-ipconnect.de ([79.234.72.32] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gWPb2-0000sA-Us; Mon, 10 Dec 2018 18:43:57 +0100
Date:   Mon, 10 Dec 2018 18:43:51 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Stefan Liebler <stli@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Darren Hart <dvhart@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [patch] futex: Cure exit race
In-Reply-To: <20181210160205.GQ5289@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1812101824070.1667@nanos.tec.linutronix.de>
References: <20181210152311.986181245@linutronix.de> <20181210160205.GQ5289@hirez.programming.kicks-ass.net>
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

On Mon, 10 Dec 2018, Peter Zijlstra wrote:
> On Mon, Dec 10, 2018 at 04:23:06PM +0100, Thomas Gleixner wrote:
> There is another callers of futex_lock_pi_atomic(),
> futex_proxy_trylock_atomic(), which is part of futex_requeue(), that too
> does a retry loop on -EAGAIN.
> 
> And there is another caller of attach_to_pi_owner(): lookup_pi_state(),
> and that too is in futex_requeue() and handles the retry case properly.
> 
> Yes, this all looks good.
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Bah. The little devil in the unconcious part of my brain insisted on
thinking further about that EAGAIN loop even despite my attempt to page
that futex horrors out again immediately after sending that patch.

There is another related issue which is even worse than just mildly
confusing user space:

   task1(SCHED_OTHER)
   sys_exit()
     do_exit()
      exit_mm()
       task1->flags |= PF_EXITING;

   ---> preemption

   task2(SCHED_FIFO)
     sys_futex(LOCK_PI)
       ....
       attach_to_pi_owner() {
         ...
         if (!task1->flags & PF_EXITING) {
           attach();
         } else {
              if (!(tsk->flags & PF_EXITPIDONE))
	         return -EAGAIN;

Now assume UP or both tasks pinned on the same CPU. That results in a
livelock because task2 is going to loop forever.

No immediate idea how to cure that one w/o creating a mess.

Thanks,

	tglx
