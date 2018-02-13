Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965831AbeBMUdA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 15:33:00 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:42031 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965789AbeBMUcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 15:32:54 -0500
X-Google-Smtp-Source: AH8x227wDtFmVwnuk3ZNDCJzMKUtAHAjPrr/kFHO+n1jc1ts6WJIeIQtLmK0D9zpuAp1sWbd2Yk+Tw==
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: peterz@infradead.org
Cc: lizefan@huawei.com, mingo@redhat.com, rostedt@goodmis.org,
        claudio@evidence.eu.com, bristot@redhat.com,
        tommaso.cucinotta@santannapisa.it, juri.lelli@redhat.com,
        luca.abeni@santannapisa.it, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 02/10] sched/topology: Adding function partition_sched_domains_locked()
Date: Tue, 13 Feb 2018 13:32:39 -0700
Message-Id: <1518553967-20656-3-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518553967-20656-1-git-send-email-mathieu.poirier@linaro.org>
References: <1518553967-20656-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introducing function partition_sched_domains_locked() by taking
the mutex locking code out of the original function.  That way
the work done by partition_sched_domains_locked() can be reused
without dropping the mutex lock.

No change of functionality is introduced by this patch.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 include/linux/sched/topology.h | 10 ++++++++++
 kernel/sched/topology.c        | 18 ++++++++++++++----
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 26347741ba50..57997caf61b6 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -162,6 +162,10 @@ static inline struct cpumask *sched_domain_span(struct sched_domain *sd)
 	return to_cpumask(sd->span);
 }
 
+extern void partition_sched_domains_locked(int ndoms_new,
+					   cpumask_var_t doms_new[],
+					   struct sched_domain_attr *dattr_new);
+
 extern void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 				    struct sched_domain_attr *dattr_new);
 
@@ -207,6 +211,12 @@ extern void set_sched_topology(struct sched_domain_topology_level *tl);
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
index 7c744c7425ec..eee721da40fb 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1855,16 +1855,16 @@ static int dattrs_equal(struct sched_domain_attr *cur, int idx_cur,
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
 
 	lockdep_assert_cpus_held();
-	mutex_lock(&sched_domains_mutex);
+	lockdep_assert_held(&sched_domains_mutex);
 
 	/* Always unregister in case we don't destroy any domains: */
 	unregister_sched_domain_sysctl();
@@ -1929,7 +1929,17 @@ void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 	ndoms_cur = ndoms_new;
 
 	register_sched_domain_sysctl();
+}
 
+/*
+ * Call with hotplug lock held
+ */
+void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
+			     struct sched_domain_attr *dattr_new)
+{
+	lockdep_assert_cpus_held();
+	mutex_lock(&sched_domains_mutex);
+	partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
 	mutex_unlock(&sched_domains_mutex);
 }
 
-- 
2.7.4
