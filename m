Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5522BC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED8DF2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="AXfkI8G1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED8DF2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730835AbeIHC0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:26:07 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:13133 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730791AbeIHC0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:26:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1536356591; x=1567892591;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fL5FyRBsnH3lytedn56yQzL76vKd4bPrtf5yNw52c4E=;
  b=AXfkI8G1d6dthi3Yj0ZpAWZGvVt0sDLGmdUBKn48YQRkh2eRvbpnuXZX
   NsSWRzB+R2vLSbArWiE+MI2wbRfXT5bWnvktvuuEQZii8VMhkgeud5VQo
   X+PEsVXPjuGQ9dEAjJhSSNGuXeHdcsIXhu0bHWcOrOObcmu8O3X2XsxK9
   4=;
X-IronPort-AV: E=Sophos;i="5.53,343,1531785600"; 
   d="scan'208";a="696510041"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Sep 2018 21:43:10 +0000
Received: from u7588a65da6b65f.ant.amazon.com (iad7-ws-svc-lb50-vlan2.amazon.com [10.0.93.210])
        by email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w87Lh4uu021881
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Fri, 7 Sep 2018 21:43:07 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id w87Lh2di027857
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Sep 2018 23:43:03 +0200
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id w87Lh1YA027856;
        Fri, 7 Sep 2018 23:43:01 +0200
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC 57/60] cosched: Add sysfs interface to configure coscheduling on cgroups
Date:   Fri,  7 Sep 2018 23:40:44 +0200
Message-Id: <20180907214047.26914-58-jschoenh@amazon.de>
X-Mailer: git-send-email 2.9.3.1.gcba166c.dirty
In-Reply-To: <20180907214047.26914-1-jschoenh@amazon.de>
References: <20180907214047.26914-1-jschoenh@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the sysfs interface to configure the scheduling domain hierarchy
level at which coscheduling should happen for a cgroup. By default,
task groups are created with a value of zero corresponding to regular
task groups without any coscheduling.

Note, that you cannot specify a value that goes beyond that of the
root task group. The value for the root task group cannot be configured
via this interface. It has to be configured with a command line
argument, which will be added later.

The function sdrq_update_root() will be filled in a follow-up commit.

Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
 kernel/sched/core.c    | 44 +++++++++++++++++++++++++++++++++++++++++
 kernel/sched/cosched.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h   |  4 ++++
 3 files changed, 101 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 75de3b83a8c6..ad2ff9bc535c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6336,6 +6336,9 @@ void sched_offline_group(struct task_group *tg)
 {
 	unsigned long flags;
 
+	/* Don't let offlining/destruction worry about coscheduling aspects */
+	cosched_set_scheduled(tg, 0);
+
 	/* End participation in shares distribution: */
 	unregister_fair_sched_group(tg);
 
@@ -6529,7 +6532,33 @@ static u64 cpu_shares_read_u64(struct cgroup_subsys_state *css,
 
 	return (u64) scale_load_down(tg->shares);
 }
+#endif /* CONFIG_FAIR_GROUP_SCHED */
+
+#ifdef CONFIG_COSCHEDULING
+static int cpu_scheduled_write_u64(struct cgroup_subsys_state *css, struct cftype *cftype,
+				   u64 val)
+{
+	struct task_group *tg = css_tg(css);
+
+	if (tg == &root_task_group)
+		return -EACCES;
+
+	if (val > root_task_group.scheduled)
+		return -EINVAL;
+
+	cosched_set_scheduled(tg, val);
+	return 0;
+}
 
+static u64 cpu_scheduled_read_u64(struct cgroup_subsys_state *css, struct cftype *cft)
+{
+	struct task_group *tg = css_tg(css);
+
+	return cosched_get_scheduled(tg);
+}
+#endif /* !CONFIG_COSCHEDULING */
+
+#ifdef CONFIG_FAIR_GROUP_SCHED
 #ifdef CONFIG_CFS_BANDWIDTH
 static DEFINE_MUTEX(cfs_constraints_mutex);
 
@@ -6825,6 +6854,13 @@ static struct cftype cpu_legacy_files[] = {
 		.write_u64 = cpu_shares_write_u64,
 	},
 #endif
+#ifdef CONFIG_COSCHEDULING
+	{
+		.name = "scheduled",
+		.read_u64 = cpu_scheduled_read_u64,
+		.write_u64 = cpu_scheduled_write_u64,
+	},
+#endif
 #ifdef CONFIG_CFS_BANDWIDTH
 	{
 		.name = "cfs_quota_us",
@@ -7012,6 +7048,14 @@ static struct cftype cpu_files[] = {
 		.write_s64 = cpu_weight_nice_write_s64,
 	},
 #endif
+#ifdef CONFIG_COSCHEDULING
+	/* FIXME: This is not conform to cgroup-v2 conventions. */
+	{
+		.name = "scheduled",
+		.read_u64 = cpu_scheduled_read_u64,
+		.write_u64 = cpu_scheduled_write_u64,
+	},
+#endif
 #ifdef CONFIG_CFS_BANDWIDTH
 	{
 		.name = "max",
diff --git a/kernel/sched/cosched.c b/kernel/sched/cosched.c
index f2d51079b3db..7c8b8c8d2814 100644
--- a/kernel/sched/cosched.c
+++ b/kernel/sched/cosched.c
@@ -515,6 +515,59 @@ void cosched_offline_group(struct task_group *tg)
 		list_del_rcu(&cfs->sdrq.tg_siblings);
 }
 
+static void sdrq_update_root(struct sdrq *sdrq)
+{
+	/* TBD */
+}
+
+void cosched_set_scheduled(struct task_group *tg, int level)
+{
+	struct cfs_rq *cfs_rq;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&tg->lock, flags);
+
+	/*
+	 * Update the is_root-fields of all hierarchical CFS runqueues in this
+	 * task group. To avoid repetitive enqueues and dequeues on every level
+	 * change, we chose pre- or post-order traversal.
+	 */
+	if (level > tg->scheduled) {
+		/*
+		 * roots move upwards: start reconfiguration at the top, so
+		 * that everything is dequeued/enqueued only when we reach
+		 * the previous scheduling level.
+		 */
+		tg->scheduled = level;
+		taskgroup_for_each_cfsrq_topdown(tg, cfs_rq)
+			sdrq_update_root(&cfs_rq->sdrq);
+	}
+	if (level < tg->scheduled) {
+		/*
+		 * roots move downwards: start reconfiguration at the bottom,
+		 * so that we do the dequeuing/enqueuing immediately, when we
+		 * reach the new scheduling level.
+		 */
+		tg->scheduled = level;
+		taskgroup_for_each_cfsrq(tg, cfs_rq)
+			sdrq_update_root(&cfs_rq->sdrq);
+	}
+
+	raw_spin_unlock_irqrestore(&tg->lock, flags);
+}
+
+int cosched_get_scheduled(struct task_group *tg)
+{
+	unsigned long flags;
+	int level;
+
+	raw_spin_lock_irqsave(&tg->lock, flags);
+	level = tg->scheduled;
+	raw_spin_unlock_irqrestore(&tg->lock, flags);
+
+	return level;
+}
+
 /*****************************************************************************
  * Locking related functions
  *****************************************************************************/
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index f6146feb7e55..e257451e05a5 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1212,6 +1212,8 @@ void cosched_init_sdrq(struct task_group *tg, struct cfs_rq *cfs,
 		       struct cfs_rq *sd_parent, struct cfs_rq *tg_parent);
 void cosched_online_group(struct task_group *tg);
 void cosched_offline_group(struct task_group *tg);
+void cosched_set_scheduled(struct task_group *tg, int level);
+int cosched_get_scheduled(struct task_group *tg);
 struct rq *rq_lock_owned(struct rq *rq, struct rq_owner_flags *orf);
 void rq_unlock_owned(struct rq *rq, struct rq_owner_flags *orf);
 void rq_chain_init(struct rq_chain *rc, struct rq *rq);
@@ -1226,6 +1228,8 @@ static inline void cosched_init_sdrq(struct task_group *tg, struct cfs_rq *cfs,
 				     struct cfs_rq *tg_parent) { }
 static inline void cosched_online_group(struct task_group *tg) { }
 static inline void cosched_offline_group(struct task_group *tg) { }
+static inline void cosched_set_scheduled(struct task_group *tg, int level) { }
+static inline int cosched_get_scheduled(struct task_group *tg) { return 0; }
 static inline struct rq *rq_lock_owned(struct rq *rq, struct rq_owner_flags *orf) { return rq; }
 static inline void rq_unlock_owned(struct rq *rq, struct rq_owner_flags *orf) { }
 static inline void rq_chain_init(struct rq_chain *rc, struct rq *rq) { }
-- 
2.9.3.1.gcba166c.dirty

