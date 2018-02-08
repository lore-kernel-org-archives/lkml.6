Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752021AbeBHWPr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 17:15:47 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:39026 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751317AbeBHWPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 17:15:45 -0500
From: Rohit Jain <rohit.k.jain@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, steven.sistare@oracle.com,
        joelaf@google.com, jbacik@fb.com, riel@redhat.com,
        juri.lelli@redhat.com, dhaval.giani@oracle.com, efault@gmx.de
Subject: [RFC 1/2] sched: reduce migration cost between faster caches for idle_balance
Date: Thu,  8 Feb 2018 14:19:54 -0800
Message-Id: <1518128395-14606-2-git-send-email-rohit.k.jain@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518128395-14606-1-git-send-email-rohit.k.jain@oracle.com>
References: <1518128395-14606-1-git-send-email-rohit.k.jain@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8799 signatures=668665
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802080255
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes idle_balance more dynamic as the sched_migration_cost
is now accounted on a sched_domain level. This in turn is done in
sd_init when we know what the topology relationships are.

For introduction sakes cost of migration within the same core is set as
0, across cores is 50 usec and across sockets is 500 usec. sysctl for
these variables are introduced in patch 2.

Signed-off-by: Rohit Jain <rohit.k.jain@oracle.com>
---
 include/linux/sched/topology.h | 1 +
 kernel/sched/fair.c            | 6 +++---
 kernel/sched/topology.c        | 5 +++++
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index cf257c2..bcb4db2 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -104,6 +104,7 @@ struct sched_domain {
 	u64 max_newidle_lb_cost;
 	unsigned long next_decay_max_lb_cost;
 
+	u64 sched_migration_cost;
 	u64 avg_scan_cost;		/* select_idle_sibling */
 
 #ifdef CONFIG_SCHEDSTATS
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2fe3aa8..61d3508 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8782,8 +8782,7 @@ static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
 	 */
 	rq_unpin_lock(this_rq, rf);
 
-	if (this_rq->avg_idle < sysctl_sched_migration_cost ||
-	    !this_rq->rd->overload) {
+	if (!this_rq->rd->overload) {
 		rcu_read_lock();
 		sd = rcu_dereference_check_sched_domain(this_rq->sd);
 		if (sd)
@@ -8804,7 +8803,8 @@ static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
 		if (!(sd->flags & SD_LOAD_BALANCE))
 			continue;
 
-		if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost) {
+		if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost +
+		    sd->sched_migration_cost) {
 			update_next_balance(sd, &next_balance);
 			break;
 		}
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 034cbed..bcd8c64 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1148,12 +1148,14 @@ sd_init(struct sched_domain_topology_level *tl,
 		sd->flags |= SD_PREFER_SIBLING;
 		sd->imbalance_pct = 110;
 		sd->smt_gain = 1178; /* ~15% */
+		sd->sched_migration_cost = 0;
 
 	} else if (sd->flags & SD_SHARE_PKG_RESOURCES) {
 		sd->flags |= SD_PREFER_SIBLING;
 		sd->imbalance_pct = 117;
 		sd->cache_nice_tries = 1;
 		sd->busy_idx = 2;
+		sd->sched_migration_cost = 500000UL;
 
 #ifdef CONFIG_NUMA
 	} else if (sd->flags & SD_NUMA) {
@@ -1162,6 +1164,7 @@ sd_init(struct sched_domain_topology_level *tl,
 		sd->idle_idx = 2;
 
 		sd->flags |= SD_SERIALIZE;
+		sd->sched_migration_cost = 5000000UL;
 		if (sched_domains_numa_distance[tl->numa_level] > RECLAIM_DISTANCE) {
 			sd->flags &= ~(SD_BALANCE_EXEC |
 				       SD_BALANCE_FORK |
@@ -1174,6 +1177,7 @@ sd_init(struct sched_domain_topology_level *tl,
 		sd->cache_nice_tries = 1;
 		sd->busy_idx = 2;
 		sd->idle_idx = 1;
+		sd->sched_migration_cost = 5000000UL;
 	}
 
 	/*
@@ -1622,6 +1626,7 @@ static struct sched_domain *build_sched_domain(struct sched_domain_topology_leve
 		}
 
 	}
+
 	set_domain_attribute(sd, attr);
 
 	return sd;
-- 
2.7.4
