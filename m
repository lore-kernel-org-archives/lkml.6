Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932147AbeCLNYh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 09:24:37 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:36538 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751247AbeCLNYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 09:24:35 -0400
X-Google-Smtp-Source: AG47ELsI1CM7QwYvmE2BuQcwpUDpIp6gBlAydlhnof393AVZ4ZOQfob0pX9JFUlL76Ky9aTv4e8pVw==
Date: Mon, 12 Mar 2018 14:24:27 +0100
From: Andrea Parri <parri.andrea@gmail.com>
To: =?utf-8?B?54Sm5pmT5Yas?= <milestonejxd@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
        peterz@infradead.org, Alan Stern <stern@rowland.harvard.edu>,
        will.deacon@arm.com, torvalds@linux-foundation.org, npiggin@gmail.com,
        mingo@kernel.org, mpe@ellerman.id.au, oleg@redhat.com,
        benh@kernel.crashing.org, Paul McKenney <paulmck@linux.vnet.ibm.com>
Subject: Re: smp_mb__after_spinlock requirement too strong?
Message-ID: <20180312132427.GA11222@andrea>
References: <CAJDTihwMgUqjK6YL2M_WZY4VBaifVYgNvdZOF_fNrnk_p27Kvw@mail.gmail.com>
 <20180312054412.yqyde34ly3kjoajj@tardis>
 <CAJDTihxxhy7zmhTJ-ky4wvMby_o9y8UOcs9R1dABN7NccekAiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJDTihxxhy7zmhTJ-ky4wvMby_o9y8UOcs9R1dABN7NccekAiQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Trol,

[...]


> But this is just one special case that acquire-release chains promise us.
> 
> A=B=0 as initial
> 
>   CPU0                CPU1                CPU2                CPU3
>  write A=1
>                            read A=1
>                            write B=1
>                            release X
>                                                  acquire X
>                                                  read A=?
>                                                  release Y
> 
>     acquire Y
> 
>     read B=?
> 
> assurance 1: CPU3 will surely see B=1 writing by CPU1, and
> assurance 2: CPU2 will also see A=1 writing by CPU0 as a special case
> 
> The second assurance is both in theory and implemented by real hardware.
> 
> As for theory, the C++11 memory model, which is a potential formal model
> for kernel memory model as
> http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2017/p0124r4.html
> descripes, states that:
> 
> If a value computation A of an atomic object M happens before a value
> computation B of M, and A takes its value from a side effect X on M, then
> the value computed by B shall either be the value stored by X or the value
> stored by a side effect Y on M, where Y follows X in the modification
> order of M.

A formal memory consistency model for the Linux kernel is now available at:

 git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git lkmm

Commit

  1c27b644c0fdbc61e113b8faee14baeb8df32486
  ("Automate memory-barriers.txt; provide Linux-kernel memory model")

provides some information (and references) on the development of this work.

---

You can check the above observation against this model: unless I mis-typed
your snippet,

andrea@andrea:~/linux-rcu/tools/memory-model$ cat trol0.litmus
C trol0

{}

P0(int *a)
{
	WRITE_ONCE(*a, 1);
}

P1(int *a, int *b, int *x)
{
	int r0;

	r0 = READ_ONCE(*a);
	WRITE_ONCE(*b, 1);
	smp_store_release(x, 1);
}

P2(int *a, int *x, int *y)
{
	int r0;
	int r1;

	r0 = smp_load_acquire(x);
	r1 = READ_ONCE(*a);
	smp_store_release(y, 1);
}

P3(int *b, int *y)
{
	int r0;
	int r1;

	r0 = smp_load_acquire(y);
	r1 = READ_ONCE(*b);
}

exists (1:r0=1 /\ 2:r0=1 /\ 3:r0=1 /\ (2:r1=0 \/ 3:r1=0))

andrea@andrea:~/linux-rcu/tools/memory-model$ herd7 -conf linux-kernel.cfg trol0.litmus
Test trol0 Allowed
States 25
1:r0=0; 2:r0=0; 2:r1=0; 3:r0=0; 3:r1=0;
1:r0=0; 2:r0=0; 2:r1=0; 3:r0=0; 3:r1=1;
1:r0=0; 2:r0=0; 2:r1=0; 3:r0=1; 3:r1=0;
1:r0=0; 2:r0=0; 2:r1=0; 3:r0=1; 3:r1=1;
1:r0=0; 2:r0=0; 2:r1=1; 3:r0=0; 3:r1=0;
1:r0=0; 2:r0=0; 2:r1=1; 3:r0=0; 3:r1=1;
1:r0=0; 2:r0=0; 2:r1=1; 3:r0=1; 3:r1=0;
1:r0=0; 2:r0=0; 2:r1=1; 3:r0=1; 3:r1=1;
1:r0=0; 2:r0=1; 2:r1=0; 3:r0=0; 3:r1=0;
1:r0=0; 2:r0=1; 2:r1=0; 3:r0=0; 3:r1=1;
1:r0=0; 2:r0=1; 2:r1=0; 3:r0=1; 3:r1=1;
1:r0=0; 2:r0=1; 2:r1=1; 3:r0=0; 3:r1=0;
1:r0=0; 2:r0=1; 2:r1=1; 3:r0=0; 3:r1=1;
1:r0=0; 2:r0=1; 2:r1=1; 3:r0=1; 3:r1=1;
1:r0=1; 2:r0=0; 2:r1=0; 3:r0=0; 3:r1=0;
1:r0=1; 2:r0=0; 2:r1=0; 3:r0=0; 3:r1=1;
1:r0=1; 2:r0=0; 2:r1=0; 3:r0=1; 3:r1=0;
1:r0=1; 2:r0=0; 2:r1=0; 3:r0=1; 3:r1=1;
1:r0=1; 2:r0=0; 2:r1=1; 3:r0=0; 3:r1=0;
1:r0=1; 2:r0=0; 2:r1=1; 3:r0=0; 3:r1=1;
1:r0=1; 2:r0=0; 2:r1=1; 3:r0=1; 3:r1=0;
1:r0=1; 2:r0=0; 2:r1=1; 3:r0=1; 3:r1=1;
1:r0=1; 2:r0=1; 2:r1=1; 3:r0=0; 3:r1=0;
1:r0=1; 2:r0=1; 2:r1=1; 3:r0=0; 3:r1=1;
1:r0=1; 2:r0=1; 2:r1=1; 3:r0=1; 3:r1=1;
No
Witnesses
Positive: 0 Negative: 25
Condition exists (1:r0=1 /\ 2:r0=1 /\ 3:r0=1 /\ (2:r1=0 \/ 3:r1=0))
Observation trol0 Never 0 25
Time trol0 0.03
Hash=21369772c98e442dd382bd84b43067ee

Please see "tools/memory-model/README" or "tools/memory-model/Documentation/"
for further information about these tools/model.

Best,
  Andrea


> 
> at
> $1.10 rule 18, on page 14
> http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2014/n4296.pdf
> 
> As for real hardware, Luc provided detailed test and explanation on
> ARM and POWER in 5.1 Cumulative Barriers for WRC  on page 19
> in this paper:
> 
> A Tutorial Introduction to the ARM and POWER Relaxed Memory Models
> https://www.cl.cam.ac.uk/~pes20/ppc-supplemental/test7.pdf
> 
> So, I think we may remove RCsc from smp_mb__after_spinlock which is
> really confusing.
> 
> Best Regards,
> Trol
> 
> >
> >> And for stopped tasks,
> >>
> >>  CPU0         CPU1            CPU2
> >>
> >> <ACCESS before schedule out A>
> >>
> >> lock(rq0)
> >> schedule out A
> >> remove A from rq0
> >> store-release(A->on_cpu)
> >> unock(rq0)
> >>
> >>               load_acquire(A->on_cpu)
> >>               set_task_cpu(A, 2)
> >>
> >>               lock(rq2)
> >>               add A into rq2
> >>               unlock(rq2)
> >>
> >>                                         lock(rq2)
> >>                                         schedule in A
> >>                                         unlock(rq2)
> >>
> >>                                         <ACCESS after schedule in A>
> >>
> >> <ACCESS before schedule out A> happens-before
> >> store-release(A->on_cpu)  happens-before
> >> load_acquire(A->on_cpu)  happens-before
> >> unlock(rq2) happens-before
> >> lock(rq2) happens-before
> >> <ACCESS after schedule in A>
> >>
> >> So, I think the only requirement to smp_mb__after_spinlock is
> >> to guarantee a STORE before the spin_lock() is ordered
> >> against a LOAD after it. So we could remove the RCsc requirement
> >> to allow more efficient implementation.
> >>
> >> Did I miss something or this RCsc requirement does not really matter?
