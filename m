Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB4CC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E16DB20836
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:45:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E16DB20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbeHTM7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 08:59:54 -0400
Received: from foss.arm.com ([217.140.101.70]:34952 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbeHTM7y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 08:59:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91C2E15BE;
        Mon, 20 Aug 2018 02:44:59 -0700 (PDT)
Received: from queper01-lin.local (queper01-lin.emea.arm.com [10.4.13.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A5B03F2EA;
        Mon, 20 Aug 2018 02:44:55 -0700 (PDT)
From:   Quentin Perret <quentin.perret@arm.com>
To:     peterz@infradead.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, mingo@redhat.com,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, patrick.bellasi@arm.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        thara.gopinath@linaro.org, viresh.kumar@linaro.org,
        tkjos@google.com, joel@joelfernandes.org, smuckle@google.com,
        adharmap@codeaurora.org, skannan@codeaurora.org,
        pkondeti@codeaurora.org, juri.lelli@redhat.com,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org,
        quentin.perret@arm.com
Subject: [PATCH v6 06/14] sched/topology: Lowest CPU asymmetry sched_domain level pointer
Date:   Mon, 20 Aug 2018 10:44:12 +0100
Message-Id: <20180820094420.26590-7-quentin.perret@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180820094420.26590-1-quentin.perret@arm.com>
References: <20180820094420.26590-1-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add another member to the family of per-cpu sched_domain shortcut
pointers. This one, sd_asym_cpucapacity, points to the lowest level
at which the SD_ASYM_CPUCAPACITY flag is set. While at it, rename the
sd_asym shortcut to sd_asym_packing to avoid confusions.

Generally speaking, the largest opportunity to save energy via
scheduling comes from a smarter exploitation of heterogeneous platforms
(i.e. big.LITTLE). Consequently, the sd_asym_cpucapacity shortcut will
be used at first as the lowest domain where Energy-Aware Scheduling
(EAS) should be applied. For example, it is possible to apply EAS within
a socket on a multi-socket system, as long as each socket has an
asymmetric topology. Cross-sockets wake-up balancing will only happen
when the system is over-utilized, or this_cpu and prev_cpu are in
different sockets.

cc: Ingo Molnar <mingo@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Morten Rasmussen <morten.rasmussen@arm.com>
Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 kernel/sched/fair.c     | 2 +-
 kernel/sched/sched.h    | 3 ++-
 kernel/sched/topology.c | 8 ++++++--
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c60616796483..c28c7adcc7b3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9167,7 +9167,7 @@ static void nohz_balancer_kick(struct rq *rq)
 		}
 	}
 
-	sd = rcu_dereference(per_cpu(sd_asym, cpu));
+	sd = rcu_dereference(per_cpu(sd_asym_packing, cpu));
 	if (sd) {
 		for_each_cpu(i, sched_domain_span(sd)) {
 			if (i == cpu ||
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 97d79429e755..4b884e467545 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1203,7 +1203,8 @@ DECLARE_PER_CPU(int, sd_llc_size);
 DECLARE_PER_CPU(int, sd_llc_id);
 DECLARE_PER_CPU(struct sched_domain_shared *, sd_llc_shared);
 DECLARE_PER_CPU(struct sched_domain *, sd_numa);
-DECLARE_PER_CPU(struct sched_domain *, sd_asym);
+DECLARE_PER_CPU(struct sched_domain *, sd_asym_packing);
+DECLARE_PER_CPU(struct sched_domain *, sd_asym_cpucapacity);
 extern struct static_key_false sched_asym_cpucapacity;
 
 struct sched_group_capacity {
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 545e2c7b6e66..4c6a36a8d7b8 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -508,7 +508,8 @@ DEFINE_PER_CPU(int, sd_llc_size);
 DEFINE_PER_CPU(int, sd_llc_id);
 DEFINE_PER_CPU(struct sched_domain_shared *, sd_llc_shared);
 DEFINE_PER_CPU(struct sched_domain *, sd_numa);
-DEFINE_PER_CPU(struct sched_domain *, sd_asym);
+DEFINE_PER_CPU(struct sched_domain *, sd_asym_packing);
+DEFINE_PER_CPU(struct sched_domain *, sd_asym_cpucapacity);
 DEFINE_STATIC_KEY_FALSE(sched_asym_cpucapacity);
 
 static void update_top_cache_domain(int cpu)
@@ -534,7 +535,10 @@ static void update_top_cache_domain(int cpu)
 	rcu_assign_pointer(per_cpu(sd_numa, cpu), sd);
 
 	sd = highest_flag_domain(cpu, SD_ASYM_PACKING);
-	rcu_assign_pointer(per_cpu(sd_asym, cpu), sd);
+	rcu_assign_pointer(per_cpu(sd_asym_packing, cpu), sd);
+
+	sd = lowest_flag_domain(cpu, SD_ASYM_CPUCAPACITY);
+	rcu_assign_pointer(per_cpu(sd_asym_cpucapacity, cpu), sd);
 }
 
 /*
-- 
2.17.1

