Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751971AbeDFVJA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 17:09:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57716 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751435AbeDFVI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 17:08:58 -0400
Date: Fri, 6 Apr 2018 14:09:53 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Waiman Long <longman@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        mingo@kernel.org, boqun.feng@gmail.com, catalin.marinas@arm.com
Subject: Re: [PATCH 02/10] locking/qspinlock: Remove unbounded cmpxchg loop
 from locking slowpath
Reply-To: paulmck@linux.vnet.ibm.com
References: <1522947547-24081-1-git-send-email-will.deacon@arm.com>
 <1522947547-24081-3-git-send-email-will.deacon@arm.com>
 <dc5f5e43-a60a-05f2-16fb-46960c40459e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc5f5e43-a60a-05f2-16fb-46960c40459e@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18040621-0024-0000-0000-0000034286FD
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008813; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000256; SDB=6.01014106; UDB=6.00516972; IPR=6.00793367;
 MB=3.00020452; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-06 21:08:55
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18040621-0025-0000-0000-000047921BB3
Message-Id: <20180406210953.GA24165@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-06_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804060212
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 06, 2018 at 04:50:19PM -0400, Waiman Long wrote:
> On 04/05/2018 12:58 PM, Will Deacon wrote:
> > The qspinlock locking slowpath utilises a "pending" bit as a simple form
> > of an embedded test-and-set lock that can avoid the overhead of explicit
> > queuing in cases where the lock is held but uncontended. This bit is
> > managed using a cmpxchg loop which tries to transition the uncontended
> > lock word from (0,0,0) -> (0,0,1) or (0,0,1) -> (0,1,1).
> >
> > Unfortunately, the cmpxchg loop is unbounded and lockers can be starved
> > indefinitely if the lock word is seen to oscillate between unlocked
> > (0,0,0) and locked (0,0,1). This could happen if concurrent lockers are
> > able to take the lock in the cmpxchg loop without queuing and pass it
> > around amongst themselves.
> >
> > This patch fixes the problem by unconditionally setting _Q_PENDING_VAL
> > using atomic_fetch_or, and then inspecting the old value to see whether
> > we need to spin on the current lock owner, or whether we now effectively
> > hold the lock. The tricky scenario is when concurrent lockers end up
> > queuing on the lock and the lock becomes available, causing us to see
> > a lockword of (n,0,0). With pending now set, simply queuing could lead
> > to deadlock as the head of the queue may not have observed the pending
> > flag being cleared. Conversely, if the head of the queue did observe
> > pending being cleared, then it could transition the lock from (n,0,0) ->
> > (0,0,1) meaning that any attempt to "undo" our setting of the pending
> > bit could race with a concurrent locker trying to set it.
> >
> > We handle this race by preserving the pending bit when taking the lock
> > after reaching the head of the queue and leaving the tail entry intact
> > if we saw pending set, because we know that the tail is going to be
> > updated shortly.
> >
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > ---
> 
> The pending bit was added to the qspinlock design to counter performance
> degradation compared with ticket lock for workloads with light
> spinlock contention. I run my spinlock stress test on a Intel Skylake
> server running the vanilla 4.16 kernel vs a patched kernel with this
> patchset. The locking rates with different number of locking threads
> were as follows:
> 
>   # of threads  4.16 kernel     patched 4.16 kernel
>   ------------  -----------     -------------------
>         1       7,417 kop/s         7,408 kop/s
>         2       5,755 kop/s         4,486 kop/s
>         3       4,214 kop/s         4,169 kop/s
>         4       4,396 kop/s         4,383 kop/s
>        
> The 2 contending threads case is the one that exercise the pending bit
> code path the most. So it is obvious that this is the one that is most
> impacted by this patchset. The differences in the other cases are mostly
> noise or maybe just a little bit on the 3 contending threads case.
> 
> I am not against this patch, but we certainly need to find out a way to
> bring the performance number up closer to what it is before applying
> the patch.

It would indeed be good to not be in the position of having to trade off
forward-progress guarantees against performance, but that does appear to
be where we are at the moment.

							Thanx, Paul
