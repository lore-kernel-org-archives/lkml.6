Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E758BC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 10:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DE44208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 10:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I10LxchS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DE44208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731638AbeGaMjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 08:39:14 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54810 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731261AbeGaMjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 08:39:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2OHHUznN7jB/GyqlBJCzOBJLBWN8f8+sPQnsPgyBxv0=; b=I10LxchS9grrIFLT6jCpfYrmu
        M6R7lquL403wly61MVwzisv8ZRsPU2Jy+7D3wCGUHMdOf++RBe9J80JO7EZhUwOzzITmNX7P/LYh9
        X/vdUMe25JI2QCx91v3Smb0sB+nDbFO6zqeGCjSnRLwZgKbdhUkswDlTJppqWVm0OOgUBWNFEztUk
        +u3B0pMyVNrGBgE/vT4uHL48YEoZ1OnH78JnoS3Qze5XsjFJdX4BtCLHHaGgHtZ2lERm30ZpUawHE
        4AT3DYAn9iPndNLdn90qafOoe+wUkfpV83zgjb9RqE5FrdcIB/J1n1BHxKhd8DpPqLyFmFEkkAed3
        0BM9fJocA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fkSN3-0005Qo-Cr; Tue, 31 Jul 2018 10:59:17 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1960A20268338; Tue, 31 Jul 2018 12:59:16 +0200 (CEST)
Date:   Tue, 31 Jul 2018 12:59:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Morten Rasmussen <morten.rasmussen@arm.com>
Cc:     mingo@redhat.com, valentin.schneider@arm.com,
        dietmar.eggemann@arm.com, vincent.guittot@linaro.org,
        gaku.inami.xh@renesas.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4 01/12] sched: Add static_key for asymmetric cpu
 capacity optimizations
Message-ID: <20180731105916.GR2476@hirez.programming.kicks-ass.net>
References: <1530699470-29808-1-git-send-email-morten.rasmussen@arm.com>
 <1530699470-29808-2-git-send-email-morten.rasmussen@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530699470-29808-2-git-send-email-morten.rasmussen@arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Combined with that SD_ASYM.. rework I ended up with the below.

Holler if you want it changed :-)


---


Subject: sched: Add static_key for asymmetric cpu capacity optimizations
From: Morten Rasmussen <morten.rasmussen@arm.com>
Date: Wed, 4 Jul 2018 11:17:39 +0100

The existing asymmetric cpu capacity code should cause minimal overhead
for others. Putting it behind a static_key, it has been done for SMT
optimizations, would make it easier to extend and improve without
causing harm to others moving forward.

cc: Ingo Molnar <mingo@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>

Cc: valentin.schneider@arm.com
Cc: mingo@redhat.com
Cc: vincent.guittot@linaro.org
Cc: dietmar.eggemann@arm.com
Cc: gaku.inami.xh@renesas.com
Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1530699470-29808-2-git-send-email-morten.rasmussen@arm.com
---
 kernel/sched/fair.c     |    3 +++
 kernel/sched/sched.h    |    1 +
 kernel/sched/topology.c |    9 ++++++++-
 3 files changed, 12 insertions(+), 1 deletion(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6186,6 +6186,9 @@ static int wake_cap(struct task_struct *
 {
 	long min_cap, max_cap;
 
+	if (!static_branch_unlikely(&sched_asym_cpucapacity))
+		return 0;
+
 	min_cap = min(capacity_orig_of(prev_cpu), capacity_orig_of(cpu));
 	max_cap = cpu_rq(cpu)->rd->max_cpu_capacity;
 
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1185,6 +1185,7 @@ DECLARE_PER_CPU(int, sd_llc_id);
 DECLARE_PER_CPU(struct sched_domain_shared *, sd_llc_shared);
 DECLARE_PER_CPU(struct sched_domain *, sd_numa);
 DECLARE_PER_CPU(struct sched_domain *, sd_asym);
+extern struct static_key_false sched_asym_cpucapacity;
 
 struct sched_group_capacity {
 	atomic_t		ref;
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -398,6 +398,7 @@ DEFINE_PER_CPU(int, sd_llc_id);
 DEFINE_PER_CPU(struct sched_domain_shared *, sd_llc_shared);
 DEFINE_PER_CPU(struct sched_domain *, sd_numa);
 DEFINE_PER_CPU(struct sched_domain *, sd_asym);
+DEFINE_STATIC_KEY_FALSE(sched_asym_cpucapacity);
 
 static void update_top_cache_domain(int cpu)
 {
@@ -1708,6 +1709,7 @@ build_sched_domains(const struct cpumask
 	struct rq *rq = NULL;
 	int i, ret = -ENOMEM;
 	struct sched_domain_topology_level *tl_asym;
+	bool has_asym = false;
 
 	alloc_state = __visit_domain_allocation_hell(&d, cpu_map);
 	if (alloc_state != sa_rootdomain)
@@ -1723,8 +1725,10 @@ build_sched_domains(const struct cpumask
 		for_each_sd_topology(tl) {
 			int dflags = 0;
 
-			if (tl == tl_asym)
+			if (tl == tl_asym) {
 				dflags |= SD_ASYM_CPUCAPACITY;
+				has_asym = true;
+			}
 
 			sd = build_sched_domain(tl, cpu_map, attr, sd, dflags, i);
 
@@ -1776,6 +1780,9 @@ build_sched_domains(const struct cpumask
 	}
 	rcu_read_unlock();
 
+	if (has_asym)
+		static_branch_enable_cpuslocked(&sched_asym_cpucapacity);
+
 	if (rq && sched_debug_enabled) {
 		pr_info("root domain span: %*pbl (max cpu_capacity = %lu)\n",
 			cpumask_pr_args(cpu_map), rq->rd->max_cpu_capacity);
