Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718D4ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0C962075B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:45:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0C962075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731687AbeGQPSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 11:18:14 -0400
Received: from ozlabs.org ([203.11.71.1]:44317 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729673AbeGQPSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 11:18:14 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41VNNf18D3z9s0n;
        Wed, 18 Jul 2018 00:45:06 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        andrea.parri@amarulasolutions.com,
        Will Deacon <will.deacon@arm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nick Piggin <npiggin@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tools/memory-model: Add extra ordering for locks and remove it for ordinary release/acquire
In-Reply-To: <CA+55aFzjcKv40hT_aD4jsdERi+a1pLU2SWPTwvyT2PDnoOmSpQ@mail.gmail.com>
References: <20180712134821.GT2494@hirez.programming.kicks-ass.net> <Pine.LNX.4.44L0.1807121236470.1306-100000@iolanthe.rowland.org> <20180712172838.GU3593@linux.vnet.ibm.com> <20180712180511.GP2476@hirez.programming.kicks-ass.net> <CA+55aFxwez8zSa2f2GpcaAkFX27Vt-s0nWdd0mZ6yGM8ipCR0A@mail.gmail.com> <20180713110851.GY2494@hirez.programming.kicks-ass.net> <87tvp3xonl.fsf@concordia.ellerman.id.au> <20180713164239.GZ2494@hirez.programming.kicks-ass.net> <87601fz1kc.fsf@concordia.ellerman.id.au> <CA+55aFzjcKv40hT_aD4jsdERi+a1pLU2SWPTwvyT2PDnoOmSpQ@mail.gmail.com>
Date:   Wed, 18 Jul 2018 00:45:01 +1000
Message-ID: <87va9dyl8y.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:
> On Mon, Jul 16, 2018 at 7:40 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
...
>> I guess arguably it's not a very macro benchmark, but we have a
>> context_switch benchmark in the tree[1] which we often use to tune
>> things, and it degrades badly. It just spins up two threads and has them
>> ping-pong using yield.
>
> I hacked that up to run on x86, and it only is about 5% locking
> overhead in my profiles. It's about 18% __switch_to, and a lot of
> system call entry/exit, but not a lot of locking.

Interesting. I don't see anything as high as 18%, it's more spread out:

     7.81%  context_switch  [kernel.kallsyms]  [k] cgroup_rstat_updated
     7.60%  context_switch  [kernel.kallsyms]  [k] system_call_exit
     5.91%  context_switch  [kernel.kallsyms]  [k] __switch_to
     5.69%  context_switch  [kernel.kallsyms]  [k] __sched_text_start
     5.61%  context_switch  [kernel.kallsyms]  [k] _raw_spin_lock
     4.15%  context_switch  [kernel.kallsyms]  [k] system_call
     3.76%  context_switch  [kernel.kallsyms]  [k] finish_task_switch

And it doesn't change much before/after the spinlock change.

(I should work out how to turn that cgroup stuff off.)

I tried uninlining spin_unlock() and that makes it a bit clearer.

Before:
     9.67%  context_switch  [kernel.kallsyms]  [k] _raw_spin_lock
     7.74%  context_switch  [kernel.kallsyms]  [k] cgroup_rstat_updated
     7.39%  context_switch  [kernel.kallsyms]  [k] system_call_exit
     5.84%  context_switch  [kernel.kallsyms]  [k] __sched_text_start
     4.83%  context_switch  [kernel.kallsyms]  [k] __switch_to
     4.08%  context_switch  [kernel.kallsyms]  [k] system_call
     <snip 16 lines>
     1.24%  context_switch  [kernel.kallsyms]  [k] arch_spin_unlock	<--

After:
     8.69%  context_switch  [kernel.kallsyms]  [k] _raw_spin_lock
     7.01%  context_switch  [kernel.kallsyms]  [k] cgroup_rstat_updated
     6.76%  context_switch  [kernel.kallsyms]  [k] system_call_exit
     5.59%  context_switch  [kernel.kallsyms]  [k] arch_spin_unlock	<--
     5.10%  context_switch  [kernel.kallsyms]  [k] __sched_text_start
     4.36%  context_switch  [kernel.kallsyms]  [k] __switch_to
     3.80%  context_switch  [kernel.kallsyms]  [k] system_call


I was worried spectre/meltdown mitigations might be confusing things, but not
really, updated numbers with them off are higher but the delta is about the
same in percentage terms:

	  | lwsync/lwsync | lwsync/sync | Change     | Change %
	  +---------------+-------------+------------+----------
Average   |    47,938,888 |  43,655,184 | -4,283,703 |   -9.00%


> I'm actually surprised it is even that much locking, since it seems to
> be single-cpu, so there should be no contention and the lock (which
> seems to be
>
>         rq = this_rq();
>         rq_lock(rq, &rf);
>
> in do_sched_yield()) should stay local to the cpu.
>
> And for you the locking is apparently even _more_ noticeable.

> But yes, a 10% regression on that context switch thing is huge. You
> shouldn't do ping-pong stuff, but people kind of do.

Yeah.

There also seem to be folks who have optimised the rest of their stack pretty
hard, and therefore care about context switch performance because it's pure
overhead and they're searching for every cycle.

So although this test is not a real workload it's a proxy for something people
do complain to us about.

cheers
