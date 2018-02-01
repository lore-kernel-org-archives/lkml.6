Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752787AbeBAQvU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 11:51:20 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:44191 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752696AbeBAQvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 11:51:14 -0500
X-Google-Smtp-Source: AH8x225AbWbQJMvncypoF58P+aRiGZzx8H7pj2FMxu+12nP2jsqAP9f5gezmV8dST7JbyOqN+yShJQ==
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: peterz@infradead.org
Cc: lizefan@huawei.com, mingo@redhat.com, rostedt@goodmis.org,
        claudio@evidence.eu.com, bristot@redhat.com,
        tommaso.cucinotta@santannapisa.it, juri.lelli@redhat.com,
        luca.abeni@santannapisa.it, linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/7] sched/topology: Adding function partition_sched_domains_locked()
Date: Thu,  1 Feb 2018 09:51:03 -0700
Message-Id: <1517503869-3179-2-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517503869-3179-1-git-send-email-mathieu.poirier@linaro.org>
References: <1517503869-3179-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introducing function partition_sched_domains_locked() by taking
the mutex locking code out of the original function.  That way
the work done by partition_sched_domains_locked() can be reused
without dropping the mutex lock.

This patch doesn't change the functionality provided by the
original code.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 include/linux/sched/topology.h |  9 +++++++++
 kernel/sched/topology.c        | 17 +++++++++++++----
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index cf257c2e728d..118141c3216a 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -162,6 +162,9 @@ static inline struct cpumask *sched_domain_span(struct sched_domain *sd)
 	return to_cpumask(sd->span);
 }
 
+extern void partition_sched_domains_locked(int ndoms_new,
+					   cpumask_var_t doms_new[],
+					   struct sched_domain_attr *dattr_new);
 extern void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 				    struct sched_domain_attr *dattr_new);
 
@@ -207,6 +210,12 @@ extern void set_sched_topology(struct sched_domain_topology_level *tl);
 struct sched_domain_attr;
 
 static inline void
+partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
+			       struct sched_domain_attr *dattr_new)
+{
+}
+
+static inline void
 partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 			struct sched_domain_attr *dattr_new)
 {
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 41bf2a531ee5..892e1f9c78f0 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1842,15 +1842,15 @@ static int dattrs_equal(struct sched_domain_attr *cur, int idx_cur,
  * ndoms_new == 0 is a special case for destroying existing domains,
  * and it will not create the default domain.
  *
- * Call with hotplug lock held
+ * Call with hotplug lock and sched_domains_mutex held
  */
-void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
-			     struct sched_domain_attr *dattr_new)
+void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
+				    struct sched_domain_attr *dattr_new)
 {
 	int i, j, n;
 	int new_topology;
 
-	mutex_lock(&sched_domains_mutex);
+	lockdep_assert_held(&sched_domains_mutex);
 
 	/* Always unregister in case we don't destroy any domains: */
 	unregister_sched_domain_sysctl();
@@ -1915,7 +1915,16 @@ void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 	ndoms_cur = ndoms_new;
 
 	register_sched_domain_sysctl();
+}
 
+/*
+ * Call with hotplug lock held
+ */
+void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
+			     struct sched_domain_attr *dattr_new)
+{
+	mutex_lock(&sched_domains_mutex);
+	partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
 	mutex_unlock(&sched_domains_mutex);
 }
 
-- 
2.7.4
