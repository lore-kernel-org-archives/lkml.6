Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BF9C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80B3320894
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:32:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80B3320894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731986AbeG3VJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 17:09:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56762 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731860AbeG3VJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 17:09:18 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6UJT9hW136005
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 15:32:46 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kj8rfrc8a-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 15:32:46 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 30 Jul 2018 15:32:46 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 30 Jul 2018 15:32:44 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6UJWhaq11731362
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 30 Jul 2018 19:32:43 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 214AFB2064;
        Mon, 30 Jul 2018 15:32:18 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DC2D1B205F;
        Mon, 30 Jul 2018 15:32:17 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 30 Jul 2018 15:32:17 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id E0C2316CA596; Mon, 30 Jul 2018 12:32:45 -0700 (PDT)
Date:   Mon, 30 Jul 2018 12:32:45 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     David Chen <david.chen@nutanix.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: RCU nocb list not reclaiming causing OOM
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180720233212.GC12945@linux.vnet.ibm.com>
 <BYAPR02MB450146DF9F67788ED1F0801D94500@BYAPR02MB4501.namprd02.prod.outlook.com>
 <BYAPR02MB4501690DB627FBB8640A5C46942A0@BYAPR02MB4501.namprd02.prod.outlook.com>
 <20180727223125.GJ24813@linux.vnet.ibm.com>
 <DM6PR02MB4508A4A735450EAAC469E635942A0@DM6PR02MB4508.namprd02.prod.outlook.com>
 <20180727234723.GN24813@linux.vnet.ibm.com>
 <DM6PR02MB4508E33C65B189DF3B5D6D54942A0@DM6PR02MB4508.namprd02.prod.outlook.com>
 <20180728014700.GO24813@linux.vnet.ibm.com>
 <20180728082944.GA23760@linux.vnet.ibm.com>
 <BYAPR02MB4501BA05FDCDAAC8842B3EBD942F0@BYAPR02MB4501.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BYAPR02MB4501BA05FDCDAAC8842B3EBD942F0@BYAPR02MB4501.namprd02.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18073019-0072-0000-0000-00000387BA33
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009458; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01068185; UDB=6.00549095; IPR=6.00846297;
 MB=3.00022411; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-30 19:32:45
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18073019-0073-0000-0000-000048E5CE99
Message-Id: <20180730193245.GA24813@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-30_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807300206
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 07:08:55PM +0000, David Chen wrote:
> Hi Paul,
> 
> Just want to know what's your plan on stable branches regarding this issue.
> Do you intend to backport the ->nocb_lock? Or are you going with just the
> memory barrier change?

That depends on you.  I am not going to submit to -stable unless someone
(in this case you) have tested it and pronounced it good.  So if you
backport and test the ->nocb_lock changes and test them, I will submit
the patch for -stable.  (Or you can submit to -stable, it does not have
to be me.  Either way works.)

I should have asked this earlier, and perhaps could have saved you quite
a bit of work had I thought to do so (please accept my apologies if so).
Have you filed a bug report with your Linux distribution?

							Thanx, Paul

> Thanks,
> David
> 
> 
> From: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Sent: Saturday, July 28, 2018 1:29 AM
> To: David Chen
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: RCU nocb list not reclaiming causing OOM
>   
> 
> On Fri, Jul 27, 2018 at 06:47:00PM -0700, Paul E. McKenney wrote:
> > On Sat, Jul 28, 2018 at 12:07:19AM +0000, David Chen wrote:
> > > Hi Paul,
> > > 
> > > I wasn't talking about the xchg() though.
> > > 
> > > The smp_mb__after_atomic() is not for xchg(), it's for `*tail = rdp->nocb_gp_head;`
> > > it's stated so in the comment. And I do think we need ordering between
> > > `*tail = rdp->nocb_gp_head;` and wake up, because the waiter is checking on head not tail.
> > > 
> > >                      swait_event_interruptible(rdp->nocb_wq,
> > >                                               READ_ONCE(rdp->nocb_follower_head));
> > > 
> > > So what I'm saying is that since we need to maintain ordering between `*tail = rdp->nocb_gp_head;`
> > > and wake up, we need to change the smp_mb__after_atomic() to smp_mb(). Because
> > > smp_mb__after_atomic() wouldn't guarantee 
> > > 
> > > So this is what I'm proposing.
> > 
> > Good eyes!
> > 
> > Hmmm...  What do I do about this in mainline?  Ah, I introduced a
> > ->nocb_lock in mainline to prevent this from happening.  In that same
> > commit that you didn't want to use because it is hard to backport.  ;-)
> > 
> > So yes, but there might well be other misorderings fixed by the
> > hard-to-backport commit that your change below does not cover.  Still I
> > do agree that you need full ordering at that point.
> 
> Another approach would be to backport only the ->nocb_lock portions
> of that patch.  This would still potentially leave failure-to-wake
> (as opposed to misordering-on-wake) issues, but it should cover all
> of the misordering-on-wake issues.
> 
>                                                         Thanx, Paul
> 
> > > diff -ru linux-4.9.37.orig/kernel/rcu/tree_plugin.h linux-4.9.37/kernel/rcu/tree_plugin.h
> > > --- linux-4.9.37.orig/kernel/rcu/tree_plugin.h      2017-07-12 06:42:41.000000000 -0700
> > > +++ linux-4.9.37/kernel/rcu/tree_plugin.h   2018-07-27 16:23:41.349044259 -0700
> > > @@ -2076,7 +2076,7 @@
> > >              /* Append callbacks to follower's "done" list. */
> > >              tail = xchg(&rdp->nocb_follower_tail, rdp->nocb_gp_tail);
> > >              *tail = rdp->nocb_gp_head;
> > > -           smp_mb__after_atomic(); /* Store *tail before wakeup. */
> > > +           smp_mb(); /* Store *tail before wakeup. */
> > >              if (rdp != my_rdp && tail == &rdp->nocb_follower_head) {
> > >                      /*
> > >                       * List was empty, wake up the follower.
> > > 
> > > Thanks,
> > > David
> > > 
> > > From: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > > Sent: Friday, July 27, 2018 4:47 PM
> > > To: David Chen
> > > Cc: linux-kernel@vger.kernel.org
> > > Subject: Re: RCU nocb list not reclaiming causing OOM
> > >   
> > > 
> > > On Fri, Jul 27, 2018 at 11:16:39PM +0000, David Chen wrote:
> > > > Hi Paul,
> > > > 
> > > > Thanks for the advice.
> > > > The bug is kind of hard to hit, so I can't say for certain yet.
> > > 
> > > Well, you can always remove the "tail == &rdp->nocb_follower_head" as an
> > > extra belt-and-suspenders safety net.  I am not putting that in mainline,
> > > but in the privacy of your own copy of the kernel, I don't see any really
> > > serious problem with it.  (As long as you aren't going for absolute maximum
> > > performance, but even then there are other more important tuning actions
> > > and code changes you could make.)
> > > 
> > > > Though after another look at the code, I found out the `smp_mb__after_atomic();`
> > > > seems to be only a compiler barrier on x86.
> > > 
> > > Yes, and that is because the locked xchg instruction used on x86 to
> > > implement xchg() already provides full ordering.  ;-)
> > > 
> > > >                tail = xchg(&rdp->nocb_follower_tail, rdp->nocb_gp_tail);
> > > >                *tail = rdp->nocb_gp_head;
> > > >                smp_mb__after_atomic(); /* Store *tail before wakeup. */
> > > >                if (rdp != my_rdp && tail == &rdp->nocb_follower_head) {
> > > >                        swake_up(&rdp->nocb_wq);
> > > > 
> > > > But that wouldn't be enough right? Because from 6b5fc3a13318, it stated that
> > > > wakeup operation don't guarantee ordering. And when the follower wakes up, it checks
> > > > for nocb_follower_head, which is assigned by `*tail = rdp->nocb_gp_head;` which doesn't
> > > > have LOCK prefix. So it's possible for follower to wake up and see the list is empty and go
> > > > back to sleep.
> > > 
> > > Again, xchg() is defined to provide full ordering against all operations
> > > before and after it.  Each architecture is required to do whatever is
> > > necessary to implement that full ordering, and x86 need only provide
> > > its "lock xchg" instruction.
> > > 
> > > The smp_mb__after_atomic() has effect only after atomic read-modify-write
> > > operations that do not return a value, for example, atomic_inc().
> > > If you use it after a value-returning atomic read-modify-write operation
> > > like xchg(), all you do is needlessly slow things down on platforms
> > > that provide non-empty smp_mb__after_atomic() definitions.  So again,
> > > smp_mb__after_atomic() after xchg() is pointless.
> > > 
> > > Please take a look at Documentation/core-api/atomic_ops.rst in the
> > > Linux-kernel source tree for more information.  Or get a v4.17 kernel
> > > source tree and check this using the memory model (tools/memory-model
> > > in that version).
> > > 
> > >                                                         Thanx, Paul
> > > 
> > > > Thanks,
> > > > David
> > > > 
> > > > From: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > > > Sent: Friday, July 27, 2018 3:31 PM
> > > > To: David Chen
> > > > Cc: linux-kernel@vger.kernel.org
> > > > Subject: Re: RCU nocb list not reclaiming causing OOM
> > > >   
> > > > 
> > > > On Fri, Jul 27, 2018 at 07:07:46PM +0000, David Chen wrote:
> > > > > Hi Paul,
> > > > > 
> > > > > I'd like to opinion again on this subject.
> > > > > 
> > > > > So we are going to backport this patch:
> > > > > 6b5fc3a13318 ("rcu: Add memory barriers for NOCB leader wakeup")
> > > > 
> > > > Does this one solve the problem, or are you still seeing hangs?
> > > > If you are no longer seeing hangs, my advice is "hands off keyboard",
> > > > though some would no doubt point out that I should follow that advice
> > > > more myself.  ;-)
> > > > 
> > > > > But the other one:
> > > > > 8be6e1b15c54 ("rcu: Use timer as backstop for NOCB deferred wakeups")
> > > > > It doesn't apply cleanly, and I'm not too comfortable porting it myself.
> > > > 
> > > > Yeah, that one is a bit on the non-trivial side, no two ways about it.
> > > > 
> > > > > So I'm wondering if I use the following change to always wake up follower thread
> > > > > regardless if the list was empty or not, just to be on the safe side. Do you think
> > > > > this change is reasonable? Do you see any problem it might cause?
> > > > > 
> > > > > Thanks,
> > > > > David
> > > > > 
> > > > > diff -ru linux-4.9.37.orig/kernel/rcu/tree_plugin.h linux-4.9.37/kernel/rcu/tree_plugin.h
> > > > > --- linux-4.9.37.orig/kernel/rcu/tree_plugin.h        2017-07-12 06:42:41.000000000 -0700
> > > > > +++ linux-4.9.37/kernel/rcu/tree_plugin.h     2018-07-27 11:57:03.582134519 -0700
> > > > > @@ -2077,7 +2077,7 @@
> > > > >                tail = xchg(&rdp->nocb_follower_tail, rdp->nocb_gp_tail);
> > > > >                *tail = rdp->nocb_gp_head;
> > > > >                smp_mb__after_atomic(); /* Store *tail before wakeup. */
> > > > > -             if (rdp != my_rdp && tail == &rdp->nocb_follower_head) {
> > > > > +             if (rdp != my_rdp) {
> > > > 
> > > > This will burn a bit of extra CPU time, but it should be fine other than
> > > > that.
> > > > 
> > > >                                                         Thanx, Paul
> > > > 
> > > > >                        /*
> > > > >                         * List was empty, wake up the follower.
> > > > >                         * Memory barriers supplied by atomic_long_add().
> > > > > 
> > > > > 
> > > > > From: David Chen
> > > > > Sent: Friday, July 20, 2018 5:12 PM
> > > > > To: paulmck@linux.vnet.ibm.com
> > > > > Cc: linux-kernel@vger.kernel.org
> > > > > Subject: Re: RCU nocb list not reclaiming causing OOM
> > > > >    
> > > > > 
> > > > > Hi Paul,
> > > > > 
> > > > > Ok, I'll try those patches.
> > > > > 
> > > > > Thanks,
> > > > > David
> > > > >   
> > > > > From: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > > > > Sent: Friday, July 20, 2018 4:32:12 PM
> > > > > To: David Chen
> > > > > Cc: linux-kernel@vger.kernel.org
> > > > > Subject: Re: RCU nocb list not reclaiming causing OOM
> > > > >   
> > > > > 
> > > > > On Fri, Jul 20, 2018 at 11:05:52PM +0000, David Chen wrote:
> > > > > > Hi Paul,
> > > > > > 
> > > > > > We hit an RCU issue on 4.9.37 kernel. One of the nocb_follower list grows too
> > > > > > large, and not getting reclaimed, causing the system to OOM.
> > > > > > 
> > > > > > Printing the culprit rcu_sched_data:
> > > > > > 
> > > > > >   nocb_q_count = {
> > > > > >     counter = 32369635
> > > > > >   },
> > > > > >   nocb_follower_head = 0xffff88ae901c0a00,
> > > > > >   nocb_follower_tail = 0xffff88af1538b8d8,
> > > > > >   nocb_kthread = 0xffff88b06d290000,
> > > > > > 
> > > > > > As you can see here, the nocb_follower_head is not empty, so in theory, the
> > > > > > nocb_kthread shouldn't go to sleep. However, if dump the stack of the kthread:
> > > > > > 
> > > > > > crash> bt 0xffff88b06d290000
> > > > > > PID: 21     TASK: ffff88b06d290000  CPU: 3   COMMAND: "rcuos/1"
> > > > > >  #0 [ffffafc9020b7dc0] __schedule at ffffffff8d8789dc
> > > > > >  #1 [ffffafc9020b7e38] schedule at ffffffff8d878e76
> > > > > >  #2 [ffffafc9020b7e50] rcu_nocb_kthread at ffffffff8d112337
> > > > > >  #3 [ffffafc9020b7ec8] kthread at ffffffff8d0c6ce7
> > > > > >  #4 [ffffafc9020b7f50] ret_from_fork at ffffffff8d87d755
> > > > > > 
> > > > > > And if we dis the address at ffffffff8d112337:
> > > > > > 
> > > > > > /usr/src/debug/kernel-4.9.37/linux-4.9.37-29.nutanix.07142017.el7.centos.x86_64/kernel/rcu/tree_plugin.h: 2106
> > > > > > 0xffffffff8d11232d <rcu_nocb_kthread+381>:      test   %rax,%rax
> > > > > > 0xffffffff8d112330 <rcu_nocb_kthread+384>:      jne    0xffffffff8d112355 <rcu_nocb_kthread+421>
> > > > > > 0xffffffff8d112332 <rcu_nocb_kthread+386>:      callq  0xffffffff8d878e40 <schedule>
> > > > > > 0xffffffff8d112337 <rcu_nocb_kthread+391>:      lea    -0x40(%rbp),%rsi
> > > > > > 
> > > > > > So the kthread is blocked at swait_event_interruptible in the nocb_follower_wait.
> > > > > > This contradict with the fact that nocb_follower_head was not empty. So I
> > > > > > wonder if this is caused by the lack of memory barrier in the place shown below.
> > > > > > If the head is set to NULL after doing xchg, it will overwrite the head set
> > > > > > by leader. This caused the kthread to sleep the next iteration, and the leader
> > > > > > won't wake him up as the tail doesn't point to head.
> > > > > > 
> > > > > > Please tell me what do you think.
> > > > > > 
> > > > > > Thanks,
> > > > > > David
> > > > > > 
> > > > > > diff -ru linux-4.9.37.orig/kernel/rcu/tree_plugin.h linux-4.9.37/kernel/rcu/tree_plugin.h
> > > > > > --- linux-4.9.37.orig/kernel/rcu/tree_plugin.h        2017-07-12 06:42:41.000000000 -0700
> > > > > > +++ linux-4.9.37/kernel/rcu/tree_plugin.h     2018-07-20 15:25:57.311206343 -0700
> > > > > > @@ -2149,6 +2149,7 @@
> > > > > >                BUG_ON(!list);
> > > > > >                trace_rcu_nocb_wake(rdp->rsp->name, rdp->cpu, "WokeNonEmpty");
> > > > > >                WRITE_ONCE(rdp->nocb_follower_head, NULL);
> > > > > > +             smp_mb();
> > > > > >                tail = xchg(&rdp->nocb_follower_tail, &rdp->nocb_follower_head);
> > > > > 
> > > > > The xchg() operation implies full memory barriers both before and after,
> > > > > so adding the smp_mb() before would have no effect.
> > > > > 
> > > > > But let me take a look at post-4.9 changes to this code...
> > > > > 
> > > > > I suggest trying out the following commit:
> > > > > 
> > > > > 6b5fc3a13318 ("rcu: Add memory barriers for NOCB leader wakeup")
> > > > > 
> > > > > If that one doesn't help, the following might be worth trying, but probably
> > > > > a lot harder to backport:
> > > > > 
> > > > > 8be6e1b15c54 ("rcu: Use timer as backstop for NOCB deferred wakeups")
> > > > > 
> > > > > Please let me know how it goes!
> > > > > 
> > > > >                                                         Thanx, Paul
> > > > > 
> > > > > ------------------------------------------------------------------------
> > > > > 
> > > > > commit 6b5fc3a1331810db407c9e0e673dc1837afdc9d0
> > > > > Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > > > > Date:   Fri Apr 28 20:11:09 2017 -0700
> > > > > 
> > > > >     rcu: Add memory barriers for NOCB leader wakeup
> > > > >     
> > > > >     Wait/wakeup operations do not guarantee ordering on their own.  Instead,
> > > > >     either locking or memory barriers are required.  This commit therefore
> > > > >     adds memory barriers to wake_nocb_leader() and nocb_leader_wait().
> > > > >     
> > > > >     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > > > >     Tested-by: Krister Johansen <kjlx@templeofstupid.com>
> > > > >     Cc: <stable@vger.kernel.org> # 4.6.x
> > > > > 
> > > > > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > > > > index 0b1042545116..573fbe9640a0 100644
> > > > > --- a/kernel/rcu/tree_plugin.h
> > > > > +++ b/kernel/rcu/tree_plugin.h
> > > > > @@ -1810,6 +1810,7 @@ static void wake_nocb_leader(struct rcu_data *rdp, bool force)
> > > > >          if (READ_ONCE(rdp_leader->nocb_leader_sleep) || force) {
> > > > >                  /* Prior smp_mb__after_atomic() orders against prior enqueue. */
> > > > >                  WRITE_ONCE(rdp_leader->nocb_leader_sleep, false);
> > > > > +               smp_mb(); /* ->nocb_leader_sleep before swake_up(). */
> > > > >                  swake_up(&rdp_leader->nocb_wq);
> > > > >          }
> > > > >  }
> > > > > @@ -2064,6 +2065,7 @@ static void nocb_leader_wait(struct rcu_data *my_rdp)
> > > > >           * nocb_gp_head, where they await a grace period.
> > > > >           */
> > > > >          gotcbs = false;
> > > > > +       smp_mb(); /* wakeup before ->nocb_head reads. */
> > > > >          for (rdp = my_rdp; rdp; rdp = rdp->nocb_next_follower) {
> > > > >                  rdp->nocb_gp_head = READ_ONCE(rdp->nocb_head);
> > > > >                  if (!rdp->nocb_gp_head)
> > > > > 
> > > > >      
> > > > 
> > > >     
> > > 
> > >     
> 
>     

