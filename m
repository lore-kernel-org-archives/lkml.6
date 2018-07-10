Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029A9C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 19:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A91D208E8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 19:57:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A91D208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732450AbeGJT5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 15:57:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56904 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732205AbeGJT5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 15:57:17 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6AJt1Yu050550
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 15:56:42 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k4ybq4q0k-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 15:56:41 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 10 Jul 2018 15:56:40 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 10 Jul 2018 15:56:35 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6AJuY8B15073770
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 Jul 2018 19:56:34 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0DB5DB2066;
        Tue, 10 Jul 2018 15:56:08 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CEE2AB2064;
        Tue, 10 Jul 2018 15:56:07 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 10 Jul 2018 15:56:07 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 7DEF516C37D2; Tue, 10 Jul 2018 12:58:53 -0700 (PDT)
Date:   Tue, 10 Jul 2018 12:58:53 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] tools/memory-model: Add extra ordering for locks and
 remove it for ordinary release/acquire
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180710162555.GV3593@linux.vnet.ibm.com>
 <Pine.LNX.4.44L0.1807101416390.1449-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1807101416390.1449-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18071019-0052-0000-0000-0000030BDF49
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009346; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01059444; UDB=6.00543734; IPR=6.00837364;
 MB=3.00022091; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-10 19:56:39
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071019-0053-0000-0000-00005D50910C
Message-Id: <20180710195853.GC3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-10_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807100211
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 02:18:13PM -0400, Alan Stern wrote:
> More than one kernel developer has expressed the opinion that the LKMM
> should enforce ordering of writes by locking.  In other words, given
> the following code:
> 
> 	WRITE_ONCE(x, 1);
> 	spin_unlock(&s):
> 	spin_lock(&s);
> 	WRITE_ONCE(y, 1);
> 
> the stores to x and y should be propagated in order to all other CPUs,
> even though those other CPUs might not access the lock s.  In terms of
> the memory model, this means expanding the cumul-fence relation.
> 
> Locks should also provide read-read (and read-write) ordering in a
> similar way.  Given:
> 
> 	READ_ONCE(x);
> 	spin_unlock(&s);
> 	spin_lock(&s);
> 	READ_ONCE(y);		// or WRITE_ONCE(y, 1);
> 
> the load of x should be executed before the load of (or store to) y.
> The LKMM already provides this ordering, but it provides it even in
> the case where the two accesses are separated by a release/acquire
> pair of fences rather than unlock/lock.  This would prevent
> architectures from using weakly ordered implementations of release and
> acquire, which seems like an unnecessary restriction.  The patch
> therefore removes the ordering requirement from the LKMM for that
> case.
> 
> All the architectures supported by the Linux kernel (including RISC-V)
> do provide this ordering for locks, albeit for varying reasons.
> Therefore this patch changes the model in accordance with the
> developers' wishes.
> 
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

It now applies, thank you very much!

Is this something that you are comfortable pushing into the upcoming
merge window, or should I hold off until the next one?

							Thanx, Paul

> ---
> 
> 
> v.3: Rebased against the dev branch of Paul's linux-rcu tree.
> Changed unlock-rf-lock-po to po-unlock-rf-lock-po, making it more
> symmetrical and more in accordance with the use of fence.tso for
> the release on RISC-V.
> 
> v.2: Restrict the ordering to lock operations, not general release
> and acquire fences.
> 
> [as1871c]
> 
> 
>  tools/memory-model/Documentation/explanation.txt                           |  186 +++++++---
>  tools/memory-model/linux-kernel.cat                                        |    8 
>  tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus |    7 
>  3 files changed, 150 insertions(+), 51 deletions(-)
> 
> Index: usb-4.x/tools/memory-model/linux-kernel.cat
> ===================================================================
> --- usb-4.x.orig/tools/memory-model/linux-kernel.cat
> +++ usb-4.x/tools/memory-model/linux-kernel.cat
> @@ -38,7 +38,7 @@ let strong-fence = mb | gp
>  (* Release Acquire *)
>  let acq-po = [Acquire] ; po ; [M]
>  let po-rel = [M] ; po ; [Release]
> -let rfi-rel-acq = [Release] ; rfi ; [Acquire]
> +let po-unlock-rf-lock-po = po ; [UL] ; rf ; [LKR] ; po
> 
>  (**********************************)
>  (* Fundamental coherence ordering *)
> @@ -60,13 +60,13 @@ let dep = addr | data
>  let rwdep = (dep | ctrl) ; [W]
>  let overwrite = co | fr
>  let to-w = rwdep | (overwrite & int)
> -let to-r = addr | (dep ; rfi) | rfi-rel-acq
> +let to-r = addr | (dep ; rfi)
>  let fence = strong-fence | wmb | po-rel | rmb | acq-po
> -let ppo = to-r | to-w | fence
> +let ppo = to-r | to-w | fence | (po-unlock-rf-lock-po & int)
> 
>  (* Propagation: Ordering from release operations and strong fences. *)
>  let A-cumul(r) = rfe? ; r
> -let cumul-fence = A-cumul(strong-fence | po-rel) | wmb
> +let cumul-fence = A-cumul(strong-fence | po-rel) | wmb | po-unlock-rf-lock-po
>  let prop = (overwrite & ext)? ; cumul-fence* ; rfe?
> 
>  (*
> Index: usb-4.x/tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus
> ===================================================================
> --- usb-4.x.orig/tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus
> +++ usb-4.x/tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus
> @@ -1,11 +1,10 @@
>  C ISA2+pooncelock+pooncelock+pombonce
> 
>  (*
> - * Result: Sometimes
> + * Result: Never
>   *
> - * This test shows that the ordering provided by a lock-protected S
> - * litmus test (P0() and P1()) are not visible to external process P2().
> - * This is likely to change soon.
> + * This test shows that write-write ordering provided by locks
> + * (in P0() and P1()) is visible to external process P2().
>   *)
> 
>  {}
> Index: usb-4.x/tools/memory-model/Documentation/explanation.txt
> ===================================================================
> --- usb-4.x.orig/tools/memory-model/Documentation/explanation.txt
> +++ usb-4.x/tools/memory-model/Documentation/explanation.txt
> @@ -28,7 +28,8 @@ Explanation of the Linux-Kernel Memory C
>    20. THE HAPPENS-BEFORE RELATION: hb
>    21. THE PROPAGATES-BEFORE RELATION: pb
>    22. RCU RELATIONS: rcu-link, gp, rscs, rcu-fence, and rb
> -  23. ODDS AND ENDS
> +  23. LOCKING
> +  24. ODDS AND ENDS
> 
> 
> 
> @@ -1067,28 +1068,6 @@ allowing out-of-order writes like this t
>  violating the write-write coherence rule by requiring the CPU not to
>  send the W write to the memory subsystem at all!)
> 
> -There is one last example of preserved program order in the LKMM: when
> -a load-acquire reads from an earlier store-release.  For example:
> -
> -	smp_store_release(&x, 123);
> -	r1 = smp_load_acquire(&x);
> -
> -If the smp_load_acquire() ends up obtaining the 123 value that was
> -stored by the smp_store_release(), the LKMM says that the load must be
> -executed after the store; the store cannot be forwarded to the load.
> -This requirement does not arise from the operational model, but it
> -yields correct predictions on all architectures supported by the Linux
> -kernel, although for differing reasons.
> -
> -On some architectures, including x86 and ARMv8, it is true that the
> -store cannot be forwarded to the load.  On others, including PowerPC
> -and ARMv7, smp_store_release() generates object code that starts with
> -a fence and smp_load_acquire() generates object code that ends with a
> -fence.  The upshot is that even though the store may be forwarded to
> -the load, it is still true that any instruction preceding the store
> -will be executed before the load or any following instructions, and
> -the store will be executed before any instruction following the load.
> -
> 
>  AND THEN THERE WAS ALPHA
>  ------------------------
> @@ -1766,6 +1745,147 @@ before it does, and the critical section
>  grace period does and ends after it does.
> 
> 
> +LOCKING
> +-------
> +
> +The LKMM includes locking.  In fact, there is special code for locking
> +in the formal model, added in order to make tools run faster.
> +However, this special code is intended to be more or less equivalent
> +to concepts we have already covered.  A spinlock_t variable is treated
> +the same as an int, and spin_lock(&s) is treated almost the same as:
> +
> +	while (cmpxchg_acquire(&s, 0, 1) != 0)
> +		cpu_relax();
> +
> +This waits until s is equal to 0 and then atomically sets it to 1,
> +and the read part of the cmpxchg operation acts as an acquire fence.
> +An alternate way to express the same thing would be:
> +
> +	r = xchg_acquire(&s, 1);
> +
> +along with a requirement that at the end, r = 0.  Similarly,
> +spin_trylock(&s) is treated almost the same as:
> +
> +	return !cmpxchg_acquire(&s, 0, 1);
> +
> +which atomically sets s to 1 if it is currently equal to 0 and returns
> +true if it succeeds (the read part of the cmpxchg operation acts as an
> +acquire fence only if the operation is successful).  spin_unlock(&s)
> +is treated almost the same as:
> +
> +	smp_store_release(&s, 0);
> +
> +The "almost" qualifiers above need some explanation.  In the LKMM, the
> +store-release in a spin_unlock() and the load-acquire which forms the
> +first half of the atomic rmw update in a spin_lock() or a successful
> +spin_trylock() -- we can call these things lock-releases and
> +lock-acquires -- have two properties beyond those of ordinary releases
> +and acquires.
> +
> +First, when a lock-acquire reads from a lock-release, the LKMM
> +requires that every instruction po-before the lock-release must
> +execute before any instruction po-after the lock-acquire.  This would
> +naturally hold if the release and acquire operations were on different
> +CPUs, but the LKMM says it holds even when they are on the same CPU.
> +For example:
> +
> +	int x, y;
> +	spinlock_t s;
> +
> +	P0()
> +	{
> +		int r1, r2;
> +
> +		spin_lock(&s);
> +		r1 = READ_ONCE(x);
> +		spin_unlock(&s);
> +		spin_lock(&s);
> +		r2 = READ_ONCE(y);
> +		spin_unlock(&s);
> +	}
> +
> +	P1()
> +	{
> +		WRITE_ONCE(y, 1);
> +		smp_wmb();
> +		WRITE_ONCE(x, 1);
> +	}
> +
> +Here the second spin_lock() reads from the first spin_unlock(), and
> +therefore the load of x must execute before the load of y.  Thus we
> +cannot have r1 = 1 and r2 = 0 at the end (this is an instance of the
> +MP pattern).
> +
> +This requirement does not apply to ordinary release and acquire
> +fences, only to lock-related operations.  For instance, suppose P0()
> +in the example had been written as:
> +
> +	P0()
> +	{
> +		int r1, r2, r3;
> +
> +		r1 = READ_ONCE(x);
> +		smp_store_release(&s, 1);
> +		r3 = smp_load_acquire(&s);
> +		r2 = READ_ONCE(y);
> +	}
> +
> +Then the CPU would be allowed to forward the s = 1 value from the
> +smp_store_release() to the smp_load_acquire(), executing the
> +instructions in the following order:
> +
> +		r3 = smp_load_acquire(&s);	// Obtains r3 = 1
> +		r2 = READ_ONCE(y);
> +		r1 = READ_ONCE(x);
> +		smp_store_release(&s, 1);	// Value is forwarded
> +
> +and thus it could load y before x, obtaining r2 = 0 and r1 = 1.
> +
> +Second, when a lock-acquire reads from a lock-release, and some other
> +stores W and W' occur po-before the lock-release and po-after the
> +lock-acquire respectively, the LKMM requires that W must propagate to
> +each CPU before W' does.  For example, consider:
> +
> +	int x, y;
> +	spinlock_t x;
> +
> +	P0()
> +	{
> +		spin_lock(&s);
> +		WRITE_ONCE(x, 1);
> +		spin_unlock(&s);
> +	}
> +
> +	P1()
> +	{
> +		int r1;
> +
> +		spin_lock(&s);
> +		r1 = READ_ONCE(x);
> +		WRITE_ONCE(y, 1);
> +		spin_unlock(&s);
> +	}
> +
> +	P2()
> +	{
> +		int r2, r3;
> +
> +		r2 = READ_ONCE(y);
> +		smp_rmb();
> +		r3 = READ_ONCE(x);
> +	}
> +
> +If r1 = 1 at the end then the spin_lock() in P1 must have read from
> +the spin_unlock() in P0.  Hence the store to x must propagate to P2
> +before the store to y does, so we cannot have r2 = 1 and r3 = 0.
> +
> +These two special requirements for lock-release and lock-acquire do
> +not arise from the operational model.  Nevertheless, kernel developers
> +have come to expect and rely on them because they do hold on all
> +architectures supported by the Linux kernel, albeit for various
> +differing reasons.
> +
> +
>  ODDS AND ENDS
>  -------------
> 
> @@ -1831,26 +1951,6 @@ they behave as follows:
>  	events and the events preceding them against all po-later
>  	events.
> 
> -The LKMM includes locking.  In fact, there is special code for locking
> -in the formal model, added in order to make tools run faster.
> -However, this special code is intended to be exactly equivalent to
> -concepts we have already covered.  A spinlock_t variable is treated
> -the same as an int, and spin_lock(&s) is treated the same as:
> -
> -	while (cmpxchg_acquire(&s, 0, 1) != 0)
> -		cpu_relax();
> -
> -which waits until s is equal to 0 and then atomically sets it to 1,
> -and where the read part of the atomic update is also an acquire fence.
> -An alternate way to express the same thing would be:
> -
> -	r = xchg_acquire(&s, 1);
> -
> -along with a requirement that at the end, r = 0.  spin_unlock(&s) is
> -treated the same as:
> -
> -	smp_store_release(&s, 0);
> -
>  Interestingly, RCU and locking each introduce the possibility of
>  deadlock.  When faced with code sequences such as:
> 
> 

