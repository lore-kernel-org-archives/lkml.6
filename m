Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78831C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1557224B0C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:35:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1557224B0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753335AbeGBVfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 17:35:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51104 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752860AbeGBVfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 17:35:05 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w62LTnPc134469
        for <linux-kernel@vger.kernel.org>; Mon, 2 Jul 2018 17:35:05 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jyqp6jtk4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 17:35:05 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 2 Jul 2018 17:35:04 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 2 Jul 2018 17:35:02 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w62LZ1eg66125972
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 Jul 2018 21:35:01 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DBE5AB206B;
        Mon,  2 Jul 2018 17:34:45 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AA0A4B2066;
        Mon,  2 Jul 2018 17:34:45 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  2 Jul 2018 17:34:45 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 4C82916CA390; Mon,  2 Jul 2018 14:37:14 -0700 (PDT)
Date:   Mon, 2 Jul 2018 14:37:14 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        David Rientjes <rientjes@google.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm,oom: Bring OOM notifier callbacks to outside of OOM
 killer.
Reply-To: paulmck@linux.vnet.ibm.com
References: <2d8c3056-1bc2-9a32-d745-ab328fd587a1@i-love.sakura.ne.jp>
 <20180626170345.GA3593@linux.vnet.ibm.com>
 <20180627072207.GB32348@dhcp22.suse.cz>
 <20180627143125.GW3593@linux.vnet.ibm.com>
 <20180628113942.GD32348@dhcp22.suse.cz>
 <20180628213105.GP3593@linux.vnet.ibm.com>
 <20180629090419.GD13860@dhcp22.suse.cz>
 <20180629125218.GX3593@linux.vnet.ibm.com>
 <20180629132638.GD5963@dhcp22.suse.cz>
 <20180630170522.GZ3593@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180630170522.GZ3593@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18070221-0040-0000-0000-000004487B78
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009297; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01055637; UDB=6.00541450; IPR=6.00833559;
 MB=3.00021968; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-02 21:35:04
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070221-0041-0000-0000-0000084E97A0
Message-Id: <20180702213714.GA7604@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-02_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807020240
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 30, 2018 at 10:05:22AM -0700, Paul E. McKenney wrote:
> On Fri, Jun 29, 2018 at 03:26:38PM +0200, Michal Hocko wrote:
> > On Fri 29-06-18 05:52:18, Paul E. McKenney wrote:
> > > On Fri, Jun 29, 2018 at 11:04:19AM +0200, Michal Hocko wrote:
> > > > On Thu 28-06-18 14:31:05, Paul E. McKenney wrote:
> > > > > On Thu, Jun 28, 2018 at 01:39:42PM +0200, Michal Hocko wrote:
> > [...]
> > > > > > Well, I am not really sure what is the objective of the oom notifier to
> > > > > > point you to the right direction. IIUC you just want to kick callbacks
> > > > > > to be handled sooner under a heavy memory pressure, right? How is that
> > > > > > achieved? Kick a worker?
> > > > > 
> > > > > That is achieved by enqueuing a non-lazy callback on each CPU's callback
> > > > > list, but only for those CPUs having non-empty lists.  This causes
> > > > > CPUs with lists containing only lazy callbacks to be more aggressive,
> > > > > in particular, it prevents such CPUs from hanging out idle for seconds
> > > > > at a time while they have callbacks on their lists.
> > > > > 
> > > > > The enqueuing happens via an IPI to the CPU in question.
> > > > 
> > > > I am afraid this is too low level for my to understand what is going on
> > > > here. What are lazy callbacks and why do they need any specific action
> > > > when we are getting close to OOM? I mean, I do understand that we might
> > > > have many callers of call_rcu and free memory lazily. But there is quite
> > > > a long way before we start the reclaim until we reach the OOM killer path.
> > > > So why don't those callbacks get called during that time period? How are
> > > > their triggered when we are not hitting the OOM path? They surely cannot
> > > > sit there for ever, right? Can we trigger them sooner? Maybe the
> > > > shrinker is not the best fit but we have a retry feedback loop in the page
> > > > allocator, maybe we can kick this processing from there.
> > > 
> > > The effect of RCU's current OOM code is to speed up callback invocation
> > > by at most a few seconds (assuming no stalled CPUs, in which case
> > > it is not possible to speed up callback invocation).
> > > 
> > > Given that, I should just remove RCU's OOM code entirely?
> > 
> > Yeah, it seems so. I do not see how this would really help much. If we
> > really need some way to kick callbacks then we should do so much earlier
> > in the reclaim process - e.g. when we start struggling to reclaim any
> > memory.
> 
> One approach would be to tell RCU "It is time to trade CPU for memory"
> at the beginning of that struggle and then tell RCU "Go back to optimizing
> for CPU" at the end of that struggle.  Is there already a way to do this?
> If so, RCU should probably just switch to it.
> 
> But what is the typical duration of such a struggle?  Does this duration
> change with workload?  (I suspect that the answers are "who knows?" and
> "yes", but you tell me!)  Are there other oom handlers that would prefer
> the approach of the previous paragraph?
> 
> > I am curious. Has the notifier been motivated by a real world use case
> > or it was "nice thing to do"?
> 
> It was introduced by b626c1b689364 ("rcu: Provide OOM handler to motivate
> lazy RCU callbacks").  The motivation for this commit was a set of changes
> that improved energy efficiency by making CPUs sleep for longer when all
> of their pending callbacks were known to only free memory (as opposed
> to doing a wakeup or some such).  Prior to this set of changes, a CPU
> with callbacks would invoke those callbacks (thus freeing the memory)
> within a jiffy or so of the end of a grace period.  After this set of
> changes, a CPU might wait several seconds.  This was a concern to people
> with small-memory systems, hence commit b626c1b689364.

And here is a commit removing RCU's OOM handler.  Thoughts?

							Thanx, Paul

------------------------------------------------------------------------

commit d2b8d16b97ac2859919713b2d98b8a3ad22943a2
Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Date:   Mon Jul 2 14:30:37 2018 -0700

    rcu: Remove OOM code
    
    There is reason to believe that RCU's OOM code isn't really helping
    that much, given that the best it can hope to do is accelerate invoking
    callbacks by a few seconds, and even then only if some CPUs have no
    non-lazy callbacks, a condition that has been observed to be rare.
    This commit therefore removes RCU's OOM code.  If this causes problems,
    it can easily be reinserted.
    
    Reported-by: Michal Hocko <mhocko@kernel.org>
    Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
    Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 3f3796b10c71..3d7ce73e7309 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1722,87 +1722,6 @@ static void rcu_idle_count_callbacks_posted(void)
 	__this_cpu_add(rcu_dynticks.nonlazy_posted, 1);
 }
 
-/*
- * Data for flushing lazy RCU callbacks at OOM time.
- */
-static atomic_t oom_callback_count;
-static DECLARE_WAIT_QUEUE_HEAD(oom_callback_wq);
-
-/*
- * RCU OOM callback -- decrement the outstanding count and deliver the
- * wake-up if we are the last one.
- */
-static void rcu_oom_callback(struct rcu_head *rhp)
-{
-	if (atomic_dec_and_test(&oom_callback_count))
-		wake_up(&oom_callback_wq);
-}
-
-/*
- * Post an rcu_oom_notify callback on the current CPU if it has at
- * least one lazy callback.  This will unnecessarily post callbacks
- * to CPUs that already have a non-lazy callback at the end of their
- * callback list, but this is an infrequent operation, so accept some
- * extra overhead to keep things simple.
- */
-static void rcu_oom_notify_cpu(void *unused)
-{
-	struct rcu_state *rsp;
-	struct rcu_data *rdp;
-
-	for_each_rcu_flavor(rsp) {
-		rdp = raw_cpu_ptr(rsp->rda);
-		if (rcu_segcblist_n_lazy_cbs(&rdp->cblist)) {
-			atomic_inc(&oom_callback_count);
-			rsp->call(&rdp->oom_head, rcu_oom_callback);
-		}
-	}
-}
-
-/*
- * If low on memory, ensure that each CPU has a non-lazy callback.
- * This will wake up CPUs that have only lazy callbacks, in turn
- * ensuring that they free up the corresponding memory in a timely manner.
- * Because an uncertain amount of memory will be freed in some uncertain
- * timeframe, we do not claim to have freed anything.
- */
-static int rcu_oom_notify(struct notifier_block *self,
-			  unsigned long notused, void *nfreed)
-{
-	int cpu;
-
-	/* Wait for callbacks from earlier instance to complete. */
-	wait_event(oom_callback_wq, atomic_read(&oom_callback_count) == 0);
-	smp_mb(); /* Ensure callback reuse happens after callback invocation. */
-
-	/*
-	 * Prevent premature wakeup: ensure that all increments happen
-	 * before there is a chance of the counter reaching zero.
-	 */
-	atomic_set(&oom_callback_count, 1);
-
-	for_each_online_cpu(cpu) {
-		smp_call_function_single(cpu, rcu_oom_notify_cpu, NULL, 1);
-		cond_resched_tasks_rcu_qs();
-	}
-
-	/* Unconditionally decrement: no need to wake ourselves up. */
-	atomic_dec(&oom_callback_count);
-
-	return NOTIFY_OK;
-}
-
-static struct notifier_block rcu_oom_nb = {
-	.notifier_call = rcu_oom_notify
-};
-
-static int __init rcu_register_oom_notifier(void)
-{
-	register_oom_notifier(&rcu_oom_nb);
-	return 0;
-}
-early_initcall(rcu_register_oom_notifier);
-
 #endif /* #else #if !defined(CONFIG_RCU_FAST_NO_HZ) */
 
 #ifdef CONFIG_RCU_FAST_NO_HZ

