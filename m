Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21B1C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E18C23E80
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:37:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E18C23E80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933908AbeGCPhI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:37:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53564 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932531AbeGCPhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:37:05 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w63FZa7v113586
        for <linux-kernel@vger.kernel.org>; Tue, 3 Jul 2018 11:37:05 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k0a7enjuf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 11:37:04 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 3 Jul 2018 11:37:03 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 3 Jul 2018 11:36:58 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w63FavH410354946
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Jul 2018 15:36:57 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 153F5B2065;
        Tue,  3 Jul 2018 11:36:41 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CCE4CB2067;
        Tue,  3 Jul 2018 11:36:40 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  3 Jul 2018 11:36:40 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id B6C3416CA2FE; Tue,  3 Jul 2018 08:39:10 -0700 (PDT)
Date:   Tue, 3 Jul 2018 08:39:10 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 2/3] locking: Clarify requirements for
 smp_mb__after_spinlock()
Reply-To: paulmck@linux.vnet.ibm.com
References: <1530544315-14614-1-git-send-email-andrea.parri@amarulasolutions.com>
 <1530629639-27767-1-git-send-email-andrea.parri@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530629639-27767-1-git-send-email-andrea.parri@amarulasolutions.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18070315-0064-0000-0000-00000324837D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009301; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01055998; UDB=6.00541666; IPR=6.00833920;
 MB=3.00021977; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-03 15:37:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070315-0065-0000-0000-000039CE8384
Message-Id: <20180703153910.GZ3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-03_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=905 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807030177
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 04:53:59PM +0200, Andrea Parri wrote:
> There are 11 interpretations of the requirements described in the header
> comment for smp_mb__after_spinlock(): one for each LKMM maintainer, and
> one currently encoded in the Cat file. Stick to the latter (until a more
> satisfactory solution is available).
> 
> This also reworks some snippets related to the barrier to illustrate the
> requirements and to link them to the idioms which are relied upon at its
> call sites.
> 
> Suggested-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
> Acked-by: Peter Zijlstra <peterz@infradead.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

Looks good, a couple of changes suggested below.

								Thanx, Paul

> ---
> Changes since v2:
>   - restore note about RCsc lock (Peter Zijlstra)
>   - add Peter's Acked-by: tag
> 
> Changes since v1:
>   - rework the snippets (Peter Zijlstra)
>   - style fixes (Alan Stern and Matthew Wilcox)
>   - add Boqun's Suggested-by: tag
> 
>  include/linux/spinlock.h | 53 ++++++++++++++++++++++++++++++++----------------
>  kernel/sched/core.c      | 41 +++++++++++++++++++------------------
>  2 files changed, 57 insertions(+), 37 deletions(-)
> 
> diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
> index 1e8a464358384..d70a06ff2bdd2 100644
> --- a/include/linux/spinlock.h
> +++ b/include/linux/spinlock.h
> @@ -114,29 +114,48 @@ do {								\
>  #endif /*arch_spin_is_contended*/
> 
>  /*
> - * This barrier must provide two things:
> + * smp_mb__after_spinlock() provides the equivalent of a full memory barrier
> + * between program-order earlier lock acquisitions and program-order later

Not just the earlier lock acquisition, but also all program-order earlier
memory accesses, correct?

> + * memory accesses.
>   *
> - *   - it must guarantee a STORE before the spin_lock() is ordered against a
> - *     LOAD after it, see the comments at its two usage sites.
> + * This guarantees that the following two properties hold:
>   *
> - *   - it must ensure the critical section is RCsc.
> + *   1) Given the snippet:
>   *
> - * The latter is important for cases where we observe values written by other
> - * CPUs in spin-loops, without barriers, while being subject to scheduling.
> + *	  { X = 0;  Y = 0; }
>   *
> - * CPU0			CPU1			CPU2
> + *	  CPU0				CPU1
>   *
> - *			for (;;) {
> - *			  if (READ_ONCE(X))
> - *			    break;
> - *			}
> - * X=1
> - *			<sched-out>
> - *						<sched-in>
> - *						r = X;
> + *	  WRITE_ONCE(X, 1);		WRITE_ONCE(Y, 1);
> + *	  spin_lock(S);			smp_mb();
> + *	  smp_mb__after_spinlock();	r1 = READ_ONCE(X);
> + *	  r0 = READ_ONCE(Y);
> + *	  spin_unlock(S);
>   *
> - * without transitivity it could be that CPU1 observes X!=0 breaks the loop,
> - * we get migrated and CPU2 sees X==0.
> + *      it is forbidden that CPU0 does not observe CPU1's store to Y (r0 = 0)
> + *      and CPU1 does not observe CPU0's store to X (r1 = 0); see the comments
> + *      preceding the call to smp_mb__after_spinlock() in __schedule() and in
> + *      try_to_wake_up().

Should we say that this is an instance of the SB pattern?  (Am OK either
way, just asking the question.)

> + *
> + *   2) Given the snippet:
> + *
> + *  { X = 0;  Y = 0; }
> + *
> + *  CPU0		CPU1				CPU2
> + *
> + *  spin_lock(S);	spin_lock(S);			r1 = READ_ONCE(Y);
> + *  WRITE_ONCE(X, 1);	smp_mb__after_spinlock();	smp_rmb();
> + *  spin_unlock(S);	r0 = READ_ONCE(X);		r2 = READ_ONCE(X);
> + *			WRITE_ONCE(Y, 1);
> + *			spin_unlock(S);
> + *
> + *      it is forbidden that CPU0's critical section executes before CPU1's
> + *      critical section (r0 = 1), CPU2 observes CPU1's store to Y (r1 = 1)
> + *      and CPU2 does not observe CPU0's store to X (r2 = 0); see the comments
> + *      preceding the calls to smp_rmb() in try_to_wake_up() for similar
> + *      snippets but "projected" onto two CPUs.
> + *
> + * Property (2) upgrades the lock to an RCsc lock.
>   *
>   * Since most load-store architectures implement ACQUIRE with an smp_mb() after
>   * the LL/SC loop, they need no further barriers. Similarly all our TSO
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index da8f12119a127..ec9ef0aec71ac 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1999,21 +1999,20 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
>  	 * be possible to, falsely, observe p->on_rq == 0 and get stuck
>  	 * in smp_cond_load_acquire() below.
>  	 *
> -	 * sched_ttwu_pending()                 try_to_wake_up()
> -	 *   [S] p->on_rq = 1;                  [L] P->state
> -	 *       UNLOCK rq->lock  -----.
> -	 *                              \
> -	 *				 +---   RMB
> -	 * schedule()                   /
> -	 *       LOCK rq->lock    -----'
> -	 *       UNLOCK rq->lock
> +	 * sched_ttwu_pending()			try_to_wake_up()
> +	 *   STORE p->on_rq = 1			  LOAD p->state
> +	 *   UNLOCK rq->lock
> +	 *
> +	 * __schedule() (switch to task 'p')
> +	 *   LOCK rq->lock			  smp_rmb();
> +	 *   smp_mb__after_spinlock();
> +	 *   UNLOCK rq->lock
>  	 *
>  	 * [task p]
> -	 *   [S] p->state = UNINTERRUPTIBLE     [L] p->on_rq
> +	 *   STORE p->state = UNINTERRUPTIBLE	  LOAD p->on_rq
>  	 *
> -	 * Pairs with the UNLOCK+LOCK on rq->lock from the
> -	 * last wakeup of our task and the schedule that got our task
> -	 * current.
> +	 * Pairs with the LOCK+smp_mb__after_spinlock() on rq->lock in
> +	 * __schedule().  See the comment for smp_mb__after_spinlock().
>  	 */
>  	smp_rmb();
>  	if (p->on_rq && ttwu_remote(p, wake_flags))
> @@ -2027,15 +2026,17 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
>  	 * One must be running (->on_cpu == 1) in order to remove oneself
>  	 * from the runqueue.
>  	 *
> -	 *  [S] ->on_cpu = 1;	[L] ->on_rq
> -	 *      UNLOCK rq->lock
> -	 *			RMB
> -	 *      LOCK   rq->lock
> -	 *  [S] ->on_rq = 0;    [L] ->on_cpu
> +	 * __schedule() (switch to task 'p')	try_to_wake_up()
> +	 *   STORE p->on_cpu = 1		  LOAD p->on_rq
> +	 *   UNLOCK rq->lock
> +	 *
> +	 * __schedule() (put 'p' to sleep)
> +	 *   LOCK rq->lock			  smp_rmb();
> +	 *   smp_mb__after_spinlock();
> +	 *   STORE p->on_rq = 0			  LOAD p->on_cpu
>  	 *
> -	 * Pairs with the full barrier implied in the UNLOCK+LOCK on rq->lock
> -	 * from the consecutive calls to schedule(); the first switching to our
> -	 * task, the second putting it to sleep.
> +	 * Pairs with the LOCK+smp_mb__after_spinlock() on rq->lock in
> +	 * __schedule().  See the comment for smp_mb__after_spinlock().
>  	 */
>  	smp_rmb();
> 
> -- 
> 2.7.4
> 

