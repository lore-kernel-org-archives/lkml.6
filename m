Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752184AbeBHWQN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 17:16:13 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:44092 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751343AbeBHWPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 17:15:46 -0500
From: Rohit Jain <rohit.k.jain@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, steven.sistare@oracle.com,
        joelaf@google.com, jbacik@fb.com, riel@redhat.com,
        juri.lelli@redhat.com, dhaval.giani@oracle.com, efault@gmx.de
Subject: [RFC 2/2] Introduce sysctl(s) for the migration costs
Date: Thu,  8 Feb 2018 14:19:55 -0800
Message-Id: <1518128395-14606-3-git-send-email-rohit.k.jain@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518128395-14606-1-git-send-email-rohit.k.jain@oracle.com>
References: <1518128395-14606-1-git-send-email-rohit.k.jain@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8799 signatures=668665
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=637
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802080255
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces the sysctl for sched_domain based migration costs.
These in turn can be used for performance tuning of workloads.

Signed-off-by: Rohit Jain <rohit.k.jain@oracle.com>
---
 include/linux/sched/sysctl.h |  2 ++
 kernel/sched/fair.c          |  4 +++-
 kernel/sched/topology.c      |  8 ++++----
 kernel/sysctl.c              | 14 ++++++++++++++
 4 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index 1c1a151..d597f6c 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -39,6 +39,8 @@ extern unsigned int sysctl_numa_balancing_scan_size;
 
 #ifdef CONFIG_SCHED_DEBUG
 extern __read_mostly unsigned int sysctl_sched_migration_cost;
+extern __read_mostly unsigned int sysctl_sched_core_migration_cost;
+extern __read_mostly unsigned int sysctl_sched_thread_migration_cost;
 extern __read_mostly unsigned int sysctl_sched_nr_migrate;
 extern __read_mostly unsigned int sysctl_sched_time_avg;
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 61d3508..f395adc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -99,7 +99,9 @@ unsigned int sysctl_sched_child_runs_first __read_mostly;
 unsigned int sysctl_sched_wakeup_granularity		= 1000000UL;
 unsigned int normalized_sysctl_sched_wakeup_granularity	= 1000000UL;
 
-const_debug unsigned int sysctl_sched_migration_cost	= 500000UL;
+const_debug unsigned int sysctl_sched_migration_cost		= 500000UL;
+const_debug unsigned int sysctl_sched_core_migration_cost	= 500000UL;
+const_debug unsigned int sysctl_sched_thread_migration_cost	= 0UL;
 
 #ifdef CONFIG_SMP
 /*
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index bcd8c64..fc147db 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1148,14 +1148,14 @@ sd_init(struct sched_domain_topology_level *tl,
 		sd->flags |= SD_PREFER_SIBLING;
 		sd->imbalance_pct = 110;
 		sd->smt_gain = 1178; /* ~15% */
-		sd->sched_migration_cost = 0;
+		sd->sched_migration_cost = sysctl_sched_thread_migration_cost;
 
 	} else if (sd->flags & SD_SHARE_PKG_RESOURCES) {
 		sd->flags |= SD_PREFER_SIBLING;
 		sd->imbalance_pct = 117;
 		sd->cache_nice_tries = 1;
 		sd->busy_idx = 2;
-		sd->sched_migration_cost = 500000UL;
+		sd->sched_migration_cost = sysctl_sched_core_migration_cost;
 
 #ifdef CONFIG_NUMA
 	} else if (sd->flags & SD_NUMA) {
@@ -1164,7 +1164,7 @@ sd_init(struct sched_domain_topology_level *tl,
 		sd->idle_idx = 2;
 
 		sd->flags |= SD_SERIALIZE;
-		sd->sched_migration_cost = 5000000UL;
+		sd->sched_migration_cost = sysctl_sched_migration_cost;
 		if (sched_domains_numa_distance[tl->numa_level] > RECLAIM_DISTANCE) {
 			sd->flags &= ~(SD_BALANCE_EXEC |
 				       SD_BALANCE_FORK |
@@ -1177,7 +1177,7 @@ sd_init(struct sched_domain_topology_level *tl,
 		sd->cache_nice_tries = 1;
 		sd->busy_idx = 2;
 		sd->idle_idx = 1;
-		sd->sched_migration_cost = 5000000UL;
+		sd->sched_migration_cost = sysctl_sched_migration_cost;
 	}
 
 	/*
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 557d467..0920795 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -356,6 +356,20 @@ static struct ctl_table kern_table[] = {
 		.proc_handler	= proc_dointvec,
 	},
 	{
+		.procname	= "sched_core_migration_cost_ns",
+		.data		= &sysctl_sched_core_migration_cost,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
+	{
+		.procname	= "sched_thread_migration_cost_ns",
+		.data		= &sysctl_sched_thread_migration_cost,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
+	{
 		.procname	= "sched_nr_migrate",
 		.data		= &sysctl_sched_nr_migrate,
 		.maxlen		= sizeof(unsigned int),
-- 
2.7.4
