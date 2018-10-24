Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D617AC004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 10:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DD8C2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 10:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I8LiXdrQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DD8C2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbeJXSbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 14:31:08 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35954 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbeJXSbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 14:31:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zt8nk9P+V33pkJPHKaa5TegdnHjmQ/nIxiAqEemNepc=; b=I8LiXdrQ4NIkO2zmRRWOFi+EN
        /zf9RooEMkqsG7slRc9iNHKamjM++kvzsc5FNFNDHE6bG3e7Ufzjd5azFnNGyfFBsagBv0dBv2tFT
        UsbSBN7MOSo4DQQaRrMqaZuPJtoGovHhB9oF9Oly1q+HFGdHbEQY3zzrd9RH+70/2jTiJ/nIUF82t
        U/of+0iAsn5tv7KfxrytSyOvlmQsLyWZQZVQ6SVm8lmBw2nX9N/a5Tlg4nAQruc12aw1lQKOUQJfI
        ZjagwS49nrBGFqzrxQSLVJE4tQ9cApSqfO1ZH18LTxPhj0M3Y/eEwnjM/9/ImtNc7XH02ySaNdpGn
        Oihs79Yzg==;
Received: from [185.7.230.213] (helo=worktop)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gFG0h-0007IK-L7; Wed, 24 Oct 2018 10:03:32 +0000
Received: by worktop (Postfix, from userid 1000)
        id EF2C76E08B3; Wed, 24 Oct 2018 12:03:23 +0200 (CEST)
Date:   Wed, 24 Oct 2018 12:03:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Yi Wang <wang.yi59@zte.com.cn>, zhong.weidong@zte.com.cn,
        Yi Liu <liu.yi24@zte.com.cn>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] sched/core: Don't mix isolcpus and housekeeping CPUs
Message-ID: <20181024100323.GO3109@worktop.c.hoisthospitality.com>
References: <1540350169-18581-1-git-send-email-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540350169-18581-1-git-send-email-srikar@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 08:32:49AM +0530, Srikar Dronamraju wrote:
> Load balancer and NUMA balancer are not suppose to work on isolcpus.
> 
> Currently when setting sched affinity, there are no checks to see if the
> requested cpumask has CPUs from both isolcpus and housekeeping CPUs.
> 
> If user passes a mix of isolcpus and housekeeping CPUs, then
> NUMA balancer can pick a isolcpu to schedule.
> With this change, if a combination of isolcpus and housekeeping CPUs are
> provided, then we restrict ourselves to housekeeping CPUs.

I'm still not liking this much. This adds more special cases for
isolcpus. Also, I don't believe in correcting silly users; give 'em rope
and show them how to tie the knot.

Where does the numa balancer pick the 'wrong' CPU?

task_numa_migrate() checks to see if the task is currently part of a
SD_NUMA domain, otherwise it doesn't do anything. This means your
housekeeping mask spans multiple nodes to begin with, right?

But after that we seem to ignore the sched domains entirely;
task_numa_find_cpu() only tests cpus_allowed.

It appears to me the for_each_online_node() iteration in
task_numa_migrate() needs an addition test to see if the selected node
has any CPUs in the relevant sched_domain _at_all_.

A little something like the below -- except we also need to do something
about cpus_active_mask. Not been near a compiler.

---
 kernel/sched/fair.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ee271bb661cc..287ef7f0203b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1497,6 +1497,8 @@ struct task_numa_env {
 	struct task_struct *best_task;
 	long best_imp;
 	int best_cpu;
+
+	cpumask_var_t cpus;
 };
 
 static void task_numa_assign(struct task_numa_env *env,
@@ -1704,7 +1706,7 @@ static void task_numa_find_cpu(struct task_numa_env *env,
 	 */
 	maymove = !load_too_imbalanced(src_load, dst_load, env);
 
-	for_each_cpu(cpu, cpumask_of_node(env->dst_nid)) {
+	for_each_cpu_and(cpu, cpumask_of_node(env->dst_nid), env->cpus) {
 		/* Skip this CPU if the source task cannot migrate */
 		if (!cpumask_test_cpu(cpu, &env->p->cpus_allowed))
 			continue;
@@ -1734,6 +1736,9 @@ static int task_numa_migrate(struct task_struct *p)
 	int nid, ret, dist;
 	long taskimp, groupimp;
 
+	if (!alloc_cpumask_var(&env.cpus, GFP_KERNEL))
+		return -ENOMEM;
+
 	/*
 	 * Pick the lowest SD_NUMA domain, as that would have the smallest
 	 * imbalance and would be the first to start moving tasks about.
@@ -1744,20 +1749,23 @@ static int task_numa_migrate(struct task_struct *p)
 	 */
 	rcu_read_lock();
 	sd = rcu_dereference(per_cpu(sd_numa, env.src_cpu));
-	if (sd)
-		env.imbalance_pct = 100 + (sd->imbalance_pct - 100) / 2;
-	rcu_read_unlock();
-
 	/*
 	 * Cpusets can break the scheduler domain tree into smaller
 	 * balance domains, some of which do not cross NUMA boundaries.
 	 * Tasks that are "trapped" in such domains cannot be migrated
 	 * elsewhere, so there is no point in (re)trying.
 	 */
-	if (unlikely(!sd)) {
+	if (!sd) {
 		sched_setnuma(p, task_node(p));
-		return -EINVAL;
+		rcu_read_unlock();
+		ret = -EINVAL;
+		goto out;
 	}
+	env.imbalance_pct = 100 + (sd->imbalance_pct - 100) / 2;
+	while (sd->parent)
+		sd = sd->parent;
+	cpumask_copy(env.cpus, sched_domain_span(sd));
+	rcu_read_unlock();
 
 	env.dst_nid = p->numa_preferred_nid;
 	dist = env.dist = node_distance(env.src_nid, env.dst_nid);
@@ -1783,6 +1791,9 @@ static int task_numa_migrate(struct task_struct *p)
 			if (nid == env.src_nid || nid == p->numa_preferred_nid)
 				continue;
 
+			if (!cpumask_intersects(cpumask_of_node(nid), env.cpus))
+				continue;
+
 			dist = node_distance(env.src_nid, env.dst_nid);
 			if (sched_numa_topology_type == NUMA_BACKPLANE &&
 						dist != env.dist) {
@@ -1822,8 +1833,10 @@ static int task_numa_migrate(struct task_struct *p)
 	}
 
 	/* No better CPU than the current one was found. */
-	if (env.best_cpu == -1)
-		return -EAGAIN;
+	if (env.best_cpu == -1) {
+		ret = -EAGAIN;
+		goto out;
+	}
 
 	best_rq = cpu_rq(env.best_cpu);
 	if (env.best_task == NULL) {
@@ -1831,7 +1844,7 @@ static int task_numa_migrate(struct task_struct *p)
 		WRITE_ONCE(best_rq->numa_migrate_on, 0);
 		if (ret != 0)
 			trace_sched_stick_numa(p, env.src_cpu, env.best_cpu);
-		return ret;
+		goto out;
 	}
 
 	ret = migrate_swap(p, env.best_task, env.best_cpu, env.src_cpu);
@@ -1840,6 +1853,9 @@ static int task_numa_migrate(struct task_struct *p)
 	if (ret != 0)
 		trace_sched_stick_numa(p, env.src_cpu, task_cpu(env.best_task));
 	put_task_struct(env.best_task);
+
+out:
+	free_cpumask_var(&env.cpus);
 	return ret;
 }
 
