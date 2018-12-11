Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F90C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB5C720672
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:36:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB5C720672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbeLKPf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:35:59 -0500
Received: from terminus.zytor.com ([198.137.202.136]:45807 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbeLKPf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:35:58 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBBFZWPt4042916
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 11 Dec 2018 07:35:32 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBBFZV7K4042913;
        Tue, 11 Dec 2018 07:35:31 -0800
Date:   Tue, 11 Dec 2018 07:35:31 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Quentin Perret <tipbot@zytor.com>
Message-ID: <tip-b68a4c0dba3b1e1dda1ede49f3c2fc72d3b54567@git.kernel.org>
Cc:     mingo@kernel.org, peterz@infradead.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, efault@gmx.de,
        torvalds@linux-foundation.org, quentin.perret@arm.com,
        hpa@zytor.com
Reply-To: torvalds@linux-foundation.org, hpa@zytor.com,
          quentin.perret@arm.com, efault@gmx.de,
          linux-kernel@vger.kernel.org, peterz@infradead.org,
          tglx@linutronix.de, mingo@kernel.org
In-Reply-To: <20181203095628.11858-8-quentin.perret@arm.com>
References: <20181203095628.11858-8-quentin.perret@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/topology: Disable EAS on inappropriate
 platforms
Git-Commit-ID: b68a4c0dba3b1e1dda1ede49f3c2fc72d3b54567
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  b68a4c0dba3b1e1dda1ede49f3c2fc72d3b54567
Gitweb:     https://git.kernel.org/tip/b68a4c0dba3b1e1dda1ede49f3c2fc72d3b54567
Author:     Quentin Perret <quentin.perret@arm.com>
AuthorDate: Mon, 3 Dec 2018 09:56:20 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 11 Dec 2018 15:17:00 +0100

sched/topology: Disable EAS on inappropriate platforms

Energy Aware Scheduling (EAS) in its current form is most relevant on
platforms with asymmetric CPU topologies (e.g. Arm big.LITTLE) since
this is where there is a lot of potential for saving energy through
scheduling. This is particularly true since the Energy Model only
includes the active power costs of CPUs, hence not providing enough data
to compare packing-vs-spreading strategies.

As such, disable EAS on root domains where the SD_ASYM_CPUCAPACITY flag
is not set. While at it, disable EAS on systems where the complexity of
the Energy Model is too high since that could lead to unacceptable
scheduling overhead.

All in all, EAS can be used on a root domain if and only if:
  1. an Energy Model is available;
  2. the root domain has an asymmetric CPU capacity topology;
  3. the complexity of the root domain's EM is low enough to keep
     scheduling overheads low.

Signed-off-by: Quentin Perret <quentin.perret@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: adharmap@codeaurora.org
Cc: chris.redpath@arm.com
Cc: currojerez@riseup.net
Cc: dietmar.eggemann@arm.com
Cc: edubezval@gmail.com
Cc: gregkh@linuxfoundation.org
Cc: javi.merino@kernel.org
Cc: joel@joelfernandes.org
Cc: juri.lelli@redhat.com
Cc: morten.rasmussen@arm.com
Cc: patrick.bellasi@arm.com
Cc: pkondeti@codeaurora.org
Cc: rjw@rjwysocki.net
Cc: skannan@codeaurora.org
Cc: smuckle@google.com
Cc: srinivas.pandruvada@linux.intel.com
Cc: thara.gopinath@linaro.org
Cc: tkjos@google.com
Cc: valentin.schneider@arm.com
Cc: vincent.guittot@linaro.org
Cc: viresh.kumar@linaro.org
Link: https://lkml.kernel.org/r/20181203095628.11858-8-quentin.perret@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/topology.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 137ccfed9a43..6ddb804b2dec 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -270,12 +270,45 @@ static void destroy_perf_domain_rcu(struct rcu_head *rp)
 	free_pd(pd);
 }
 
+/*
+ * EAS can be used on a root domain if it meets all the following conditions:
+ *    1. an Energy Model (EM) is available;
+ *    2. the SD_ASYM_CPUCAPACITY flag is set in the sched_domain hierarchy.
+ *    3. the EM complexity is low enough to keep scheduling overheads low;
+ *
+ * The complexity of the Energy Model is defined as:
+ *
+ *              C = nr_pd * (nr_cpus + nr_cs)
+ *
+ * with parameters defined as:
+ *  - nr_pd:    the number of performance domains
+ *  - nr_cpus:  the number of CPUs
+ *  - nr_cs:    the sum of the number of capacity states of all performance
+ *              domains (for example, on a system with 2 performance domains,
+ *              with 10 capacity states each, nr_cs = 2 * 10 = 20).
+ *
+ * It is generally not a good idea to use such a model in the wake-up path on
+ * very complex platforms because of the associated scheduling overheads. The
+ * arbitrary constraint below prevents that. It makes EAS usable up to 16 CPUs
+ * with per-CPU DVFS and less than 8 capacity states each, for example.
+ */
+#define EM_MAX_COMPLEXITY 2048
+
 static void build_perf_domains(const struct cpumask *cpu_map)
 {
+	int i, nr_pd = 0, nr_cs = 0, nr_cpus = cpumask_weight(cpu_map);
 	struct perf_domain *pd = NULL, *tmp;
 	int cpu = cpumask_first(cpu_map);
 	struct root_domain *rd = cpu_rq(cpu)->rd;
-	int i;
+
+	/* EAS is enabled for asymmetric CPU capacity topologies. */
+	if (!per_cpu(sd_asym_cpucapacity, cpu)) {
+		if (sched_debug()) {
+			pr_info("rd %*pbl: CPUs do not have asymmetric capacities\n",
+					cpumask_pr_args(cpu_map));
+		}
+		goto free;
+	}
 
 	for_each_cpu(i, cpu_map) {
 		/* Skip already covered CPUs. */
@@ -288,6 +321,20 @@ static void build_perf_domains(const struct cpumask *cpu_map)
 			goto free;
 		tmp->next = pd;
 		pd = tmp;
+
+		/*
+		 * Count performance domains and capacity states for the
+		 * complexity check.
+		 */
+		nr_pd++;
+		nr_cs += em_pd_nr_cap_states(pd->em_pd);
+	}
+
+	/* Bail out if the Energy Model complexity is too high. */
+	if (nr_pd * (nr_cs + nr_cpus) > EM_MAX_COMPLEXITY) {
+		WARN(1, "rd %*pbl: Failed to start EAS, EM complexity is too high\n",
+						cpumask_pr_args(cpu_map));
+		goto free;
 	}
 
 	perf_domain_debug(cpu_map, pd);
