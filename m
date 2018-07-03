Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7DDC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6537623EDE
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:59:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6537623EDE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933467AbeGCP6z (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:58:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56358 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932392AbeGCP6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:58:54 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w63Fuadk002531
        for <linux-kernel@vger.kernel.org>; Tue, 3 Jul 2018 11:58:53 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k0a3hprd9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 11:58:53 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 3 Jul 2018 11:58:52 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 3 Jul 2018 11:58:49 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w63FwmeB8978782
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Jul 2018 15:58:48 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C11AB206A;
        Tue,  3 Jul 2018 11:58:32 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D85C5B2072;
        Tue,  3 Jul 2018 11:58:31 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  3 Jul 2018 11:58:31 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id CC37B16C649E; Tue,  3 Jul 2018 09:01:01 -0700 (PDT)
Date:   Tue, 3 Jul 2018 09:01:01 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        David Rientjes <rientjes@google.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm,oom: Bring OOM notifier callbacks to outside of OOM
 killer.
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180627072207.GB32348@dhcp22.suse.cz>
 <20180627143125.GW3593@linux.vnet.ibm.com>
 <20180628113942.GD32348@dhcp22.suse.cz>
 <20180628213105.GP3593@linux.vnet.ibm.com>
 <20180629090419.GD13860@dhcp22.suse.cz>
 <20180629125218.GX3593@linux.vnet.ibm.com>
 <20180629132638.GD5963@dhcp22.suse.cz>
 <20180630170522.GZ3593@linux.vnet.ibm.com>
 <20180702213714.GA7604@linux.vnet.ibm.com>
 <20180703072413.GD16767@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703072413.GD16767@dhcp22.suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18070315-0060-0000-0000-00000286C1CE
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009301; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01056005; UDB=6.00541670; IPR=6.00833928;
 MB=3.00021978; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-03 15:58:50
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070315-0061-0000-0000-000045AA8987
Message-Id: <20180703160101.GC3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-03_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807030181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 09:24:13AM +0200, Michal Hocko wrote:
> On Mon 02-07-18 14:37:14, Paul E. McKenney wrote:
> [...]
> > commit d2b8d16b97ac2859919713b2d98b8a3ad22943a2
> > Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > Date:   Mon Jul 2 14:30:37 2018 -0700
> > 
> >     rcu: Remove OOM code
> >     
> >     There is reason to believe that RCU's OOM code isn't really helping
> >     that much, given that the best it can hope to do is accelerate invoking
> >     callbacks by a few seconds, and even then only if some CPUs have no
> >     non-lazy callbacks, a condition that has been observed to be rare.
> >     This commit therefore removes RCU's OOM code.  If this causes problems,
> >     it can easily be reinserted.
> >     
> >     Reported-by: Michal Hocko <mhocko@kernel.org>
> >     Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> >     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> 
> I would also note that waiting in the notifier might be a problem on its
> own because we are holding the oom_lock and the system cannot trigger
> the OOM killer while we are holding it and waiting for oom_callback_wq
> event. I am not familiar with the code to tell whether this can deadlock
> but from a quick glance I _suspect_ that we might depend on __rcu_reclaim
> and basically an arbitrary callback so no good.
> 
> Acked-by: Michal Hocko <mhocko@suse.com>
> 
> Thanks!

Like this?

							Thanx, Paul

------------------------------------------------------------------------

commit d3cf56333af5e65054f533f6f271a7bd36b868f4
Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Date:   Mon Jul 2 14:30:37 2018 -0700

    rcu: Remove OOM code
    
    There is reason to believe that RCU's OOM code isn't really helping
    that much, given that the best it can hope to do is accelerate invoking
    callbacks by a few seconds, and even then only if some CPUs have no
    non-lazy callbacks, a condition that has been observed to be rare.
    In addition, it can block on the oom_callback_wq wait queue, which could
    delay more urgent and productive OOM actions.  This commit therefore
    removes RCU's OOM code.  If this causes problems, this commit can easily
    be reverted.
    
    Reported-by: Michal Hocko <mhocko@kernel.org>
    Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
    Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
    Acked-by: Michal Hocko <mhocko@suse.com>

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

