Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052B1C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0DAD2077C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:28:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0DAD2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbeICSsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 14:48:54 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35377 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727636AbeICSsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 14:48:53 -0400
Received: by mail-wr1-f65.google.com with SMTP id j26-v6so898193wre.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 07:28:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=flB6Avs1BCi12+S/SEuaSdhO9tBjTvRcvegTwyRjkqk=;
        b=WGA0X4QSoqySOSQahWaSpJ1xMEdudS9abuzcFRfu2qoK4W3/XqBb9NHQ+S51a/Sb0G
         e/3RqBuw7CLEfNvcM6T+QVm1ApBy+Ehxca9cEZkCyb1vOGlFhDtxd/y3eVrHgoa+FkoR
         bprNrZ3bp/tAiDBBsxOE0C61pga4G1T///ZTB0rWDU9rmyR9vjsC69xUdaa5rV8cPR9f
         bC4Gi94z/68gscVQkxjTRmiJYvxNiDmeM6JPcgR20+jpyqt7qz6ZA8G/M9y43iNs9fod
         E/+uzjuuEXPwCUX1YFCmKGPhGuR52EkluGcT31QtqI0giN3guZZ1IwfcCbPhOOmfsOic
         0M4Q==
X-Gm-Message-State: APzg51D11/rkRMrozR43Vowa1TUOUepAx1HH1K6s068AGM86QbIvMplW
        4x6jyLwmv/ZCIlEVbVMSqEwUVaJLH6k=
X-Google-Smtp-Source: ANB0VdYlBgqR6v+20f/BVP5zSp9YSqx+6ZAdUk6ncw7wo2hZpsK/qB5503HXO54/Y3hx5zEr4BZrag==
X-Received: by 2002:adf:b357:: with SMTP id k23-v6mr20006567wrd.207.1535984905767;
        Mon, 03 Sep 2018 07:28:25 -0700 (PDT)
Received: from localhost.localdomain.com ([151.15.227.30])
        by smtp.gmail.com with ESMTPSA id b74-v6sm14175880wma.8.2018.09.03.07.28.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Sep 2018 07:28:25 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org
Subject: [PATCH v5 5/5] cpuset: Rebuild root domain deadline accounting information
Date:   Mon,  3 Sep 2018 16:28:01 +0200
Message-Id: <20180903142801.20046-6-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180903142801.20046-1-juri.lelli@redhat.com>
References: <20180903142801.20046-1-juri.lelli@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

When the topology of root domains is modified by CPUset or CPUhotplug
operations information about the current deadline bandwidth held in the
root domain is lost.

This patch address the issue by recalculating the lost deadline
bandwidth information by circling through the deadline tasks held in
CPUsets and adding their current load to the root domain they are
associated with.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 include/linux/sched.h          |  5 +++
 include/linux/sched/deadline.h |  8 +++++
 kernel/cgroup/cpuset.c         | 63 +++++++++++++++++++++++++++++++++-
 kernel/sched/deadline.c        | 31 +++++++++++++++++
 kernel/sched/sched.h           |  3 --
 kernel/sched/topology.c        | 13 ++++++-
 6 files changed, 118 insertions(+), 5 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index e0f4f56c9310..2bf3edc8658d 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -279,6 +279,11 @@ struct vtime {
 	u64			gtime;
 };
 
+#ifdef CONFIG_SMP
+extern struct root_domain def_root_domain;
+extern struct mutex sched_domains_mutex;
+#endif
+
 struct sched_info {
 #ifdef CONFIG_SCHED_INFO
 	/* Cumulative counters: */
diff --git a/include/linux/sched/deadline.h b/include/linux/sched/deadline.h
index 0cb034331cbb..1aff00b65f3c 100644
--- a/include/linux/sched/deadline.h
+++ b/include/linux/sched/deadline.h
@@ -24,3 +24,11 @@ static inline bool dl_time_before(u64 a, u64 b)
 {
 	return (s64)(a - b) < 0;
 }
+
+#ifdef CONFIG_SMP
+
+struct root_domain;
+extern void dl_add_task_root_domain(struct task_struct *p);
+extern void dl_clear_root_domain(struct root_domain *rd);
+
+#endif /* CONFIG_SMP */
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 8dc26005bb1e..e5d782c5b191 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -44,6 +44,7 @@
 #include <linux/proc_fs.h>
 #include <linux/rcupdate.h>
 #include <linux/sched.h>
+#include <linux/sched/deadline.h>
 #include <linux/sched/mm.h>
 #include <linux/sched/task.h>
 #include <linux/seq_file.h>
@@ -813,6 +814,66 @@ static int generate_sched_domains(cpumask_var_t **domains,
 	return ndoms;
 }
 
+static void update_tasks_root_domain(struct cpuset *cs)
+{
+	struct css_task_iter it;
+	struct task_struct *task;
+
+	css_task_iter_start(&cs->css, 0, &it);
+
+	while ((task = css_task_iter_next(&it)))
+		dl_add_task_root_domain(task);
+
+	css_task_iter_end(&it);
+}
+
+/*
+ * Called with cpuset_mutex held (rebuild_sched_domains())
+ * Called with hotplug lock held (rebuild_sched_domains_locked())
+ * Called with sched_domains_mutex held (partition_and_rebuild_domains())
+ */
+static void rebuild_root_domains(void)
+{
+	struct cpuset *cs = NULL;
+	struct cgroup_subsys_state *pos_css;
+
+	rcu_read_lock();
+
+	/*
+	 * Clear default root domain DL accounting, it will be computed again
+	 * if a task belongs to it.
+	 */
+	dl_clear_root_domain(&def_root_domain);
+
+	cpuset_for_each_descendant_pre(cs, pos_css, &top_cpuset) {
+
+		if (cpumask_empty(cs->effective_cpus)) {
+			pos_css = css_rightmost_descendant(pos_css);
+			continue;
+		}
+
+		css_get(&cs->css);
+
+		rcu_read_unlock();
+
+		update_tasks_root_domain(cs);
+
+		rcu_read_lock();
+		css_put(&cs->css);
+	}
+	rcu_read_unlock();
+}
+
+static void
+partition_and_rebuild_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
+				    struct sched_domain_attr *dattr_new)
+{
+	mutex_lock(&sched_domains_mutex);
+	partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
+	rebuild_root_domains();
+	mutex_unlock(&sched_domains_mutex);
+}
+
 /*
  * Rebuild scheduler domains.
  *
@@ -845,7 +906,7 @@ static void rebuild_sched_domains_locked(void)
 	ndoms = generate_sched_domains(&doms, &attr);
 
 	/* Have scheduler rebuild the domains */
-	partition_sched_domains(ndoms, doms, attr);
+	partition_and_rebuild_sched_domains(ndoms, doms, attr);
 out:
 	put_online_cpus();
 }
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 997ea7b839fa..5c5938acf89a 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2285,6 +2285,37 @@ void __init init_sched_dl_class(void)
 					GFP_KERNEL, cpu_to_node(i));
 }
 
+void dl_add_task_root_domain(struct task_struct *p)
+{
+	unsigned long flags;
+	struct rq_flags rf;
+	struct rq *rq;
+	struct dl_bw *dl_b;
+
+	rq = task_rq_lock(p, &rf);
+	if (!dl_task(p))
+		goto unlock;
+
+	dl_b = &rq->rd->dl_bw;
+	raw_spin_lock_irqsave(&dl_b->lock, flags);
+
+	dl_b->total_bw += p->dl.dl_bw;
+
+	raw_spin_unlock_irqrestore(&dl_b->lock, flags);
+
+unlock:
+	task_rq_unlock(rq, p, &rf);
+}
+
+void dl_clear_root_domain(struct root_domain *rd)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&rd->dl_bw.lock, flags);
+	rd->dl_bw.total_bw = 0;
+	raw_spin_unlock_irqrestore(&rd->dl_bw.lock, flags);
+}
+
 #endif /* CONFIG_SMP */
 
 static void switched_from_dl(struct rq *rq, struct task_struct *p)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 4a2e8cae63c4..84215d464dd1 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -750,9 +750,6 @@ struct root_domain {
 	unsigned long		max_cpu_capacity;
 };
 
-extern struct root_domain def_root_domain;
-extern struct mutex sched_domains_mutex;
-
 extern void init_defrootdomain(void);
 extern int sched_init_domains(const struct cpumask *cpu_map);
 extern void rq_attach_root(struct rq *rq, struct root_domain *rd);
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index fb7ae691cb82..08128bdf3944 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1883,8 +1883,19 @@ void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
 	for (i = 0; i < ndoms_cur; i++) {
 		for (j = 0; j < n && !new_topology; j++) {
 			if (cpumask_equal(doms_cur[i], doms_new[j])
-			    && dattrs_equal(dattr_cur, i, dattr_new, j))
+			    && dattrs_equal(dattr_cur, i, dattr_new, j)) {
+				struct root_domain *rd;
+
+				/*
+				 * This domain won't be destroyed and as such
+				 * its dl_bw->total_bw needs to be cleared.  It
+				 * will be recomputed in function
+				 * update_tasks_root_domain().
+				 */
+				rd = cpu_rq(cpumask_any(doms_cur[i]))->rd;
+				dl_clear_root_domain(rd);
 				goto match1;
+			}
 		}
 		/* No match - a current sched domain not in new doms_new[] */
 		detach_destroy_domains(doms_cur[i]);
-- 
2.17.1

