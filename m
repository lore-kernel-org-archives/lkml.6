Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4C4C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 15:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70E632064C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 15:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LjK+8H7l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70E632064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbeJVX2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 19:28:48 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57738 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728546AbeJVX2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 19:28:42 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9MF4Uqj153535;
        Mon, 22 Oct 2018 15:09:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=kQLYHAwTS55UaFBbQ78wIKTcjwXzmXlkX+fzGTQYQ38=;
 b=LjK+8H7lXRwH+83yuCCjAYkSaeTc3hvzLulvTpUfj9o5H0FeaMN5W6pVlVvkpihfdIay
 tT2ztxd8dUI9MeXP/Q5n6Z2wDuy3MJjdMx86uQ59qWt0gd1JNTIcaExw2hhQ+9rSeb8I
 8tlVGzBLt+5eUI7ZGDs53aX7fhbWlOCTjyxJybWKb1/AmFPfWYguceqVFFiqjJKFmqqN
 A2eAGrwSkgrbA/6MevBF2ypmwcMwBuYrnCZCSubOVnYw2MvO5prGFJK/rIBprwXldrNN
 xJ/sqs276XMFJvRi0lve+hWCAV496giV31joteBguXkyQzP0lDfaRTMhWlwdDRg0VtNE RQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2n7vapq6a5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Oct 2018 15:09:18 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9MF9CrU005293
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Oct 2018 15:09:13 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9MF9C9L029285;
        Mon, 22 Oct 2018 15:09:12 GMT
Received: from ca-dev63.us.oracle.com (/10.211.8.221)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 22 Oct 2018 08:09:11 -0700
From:   Steve Sistare <steven.sistare@oracle.com>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     subhra.mazumdar@oracle.com, dhaval.giani@oracle.com,
        rohit.k.jain@oracle.com, daniel.m.jordan@oracle.com,
        pavel.tatashin@microsoft.com, matt@codeblueprint.co.uk,
        umgwanakikbuti@gmail.com, riel@redhat.com, jbacik@fb.com,
        juri.lelli@redhat.com, steven.sistare@oracle.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/10] sched/fair: disable stealing if too many NUMA nodes
Date:   Mon, 22 Oct 2018 07:59:40 -0700
Message-Id: <1540220381-424433-10-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1540220381-424433-1-git-send-email-steven.sistare@oracle.com>
References: <1540220381-424433-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9053 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810220129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The STEAL feature causes regressions on hackbench on larger NUMA systems,
so disable it on systems with more than sched_steal_node_limit nodes
(default 2).  Note that the feature remains enabled as seen in features.h
and /sys/kernel/debug/sched_features, but stealing is only performed if
nodes <= sched_steal_node_limit.  This arrangement allows users to activate
stealing on reboot by setting the kernel parameter sched_steal_node_limit
on kernels built without CONFIG_SCHED_DEBUG.  The parameter is temporary
and will be deleted when the regression is fixed.

Details of the regression follow.  With the STEAL feature set, hackbench
is slower on many-node systems:

X5-8: 8 sockets * 18 cores * 2 hyperthreads = 288 CPUs
Intel(R) Xeon(R) CPU E7-8895 v3 @ 2.60GHz
Average of 10 runs of: hackbench <groups> processes 50000

          --- base --    --- new ---
groups    time %stdev    time %stdev  %speedup
     1   3.627   15.8   3.876    7.3      -6.5
     2   4.545   24.7   5.583   16.7     -18.6
     3   5.716   25.0   7.367   14.2     -22.5
     4   6.901   32.9   7.718   14.5     -10.6
     8   8.604   38.5   9.111   16.0      -5.6
    16   7.734    6.8  11.007    8.2     -29.8

Total CPU time increases.  Profiling shows that CPU time increases
uniformly across all functions, suggesting a systemic increase in cache
or memory latency.  This may be due to NUMA migrations, as they cause
loss of LLC cache footprint and remote memory latencies.

The domains for this system and their flags are:

  domain0 (SMT) : 1 core
    SD_LOAD_BALANCE SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK
    SD_SHARE_PKG_RESOURCES SD_PREFER_SIBLING SD_SHARE_CPUCAPACITY
    SD_WAKE_AFFINE

  domain1 (MC) : 1 socket
    SD_LOAD_BALANCE SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK
    SD_SHARE_PKG_RESOURCES SD_PREFER_SIBLING
    SD_WAKE_AFFINE

  domain2 (NUMA) : 4 sockets
    SD_LOAD_BALANCE SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK
    SD_SERIALIZE SD_OVERLAP SD_NUMA
    SD_WAKE_AFFINE

  domain3 (NUMA) : 8 sockets
    SD_LOAD_BALANCE SD_BALANCE_NEWIDLE
    SD_SERIALIZE SD_OVERLAP SD_NUMA

Schedstats point to the root cause of the regression.  hackbench is run
10 times per group and the average schedstat accumulation per-run and
per-cpu is shown below.  Note that domain3 moves are zero because
SD_WAKE_AFFINE is not set there.

NO_STEAL
                                         --- domain2 ---   --- domain3 ---
grp time %busy sched  idle   wake steal remote  move pull remote  move pull
 1 20.3 10.3  28710  14346  14366     0    490  3378    0   4039     0    0
 2 26.4 18.8  56721  28258  28469     0    792  7026   12   9229     0    7
 3 29.9 28.3  90191  44933  45272     0   5380  7204   19  16481     0    3
 4 30.2 35.8 121324  60409  60933     0   7012  9372   27  21438     0    5
 8 27.7 64.2 229174 111917 117272     0  11991  1837  168  44006     0   32
16 32.6 74.0 334615 146784 188043     0   3404  1468   49  61405     0    8

STEAL
                                         --- domain2 ---   --- domain3 ---
grp time %busy sched  idle   wake steal remote  move pull remote  move pull
 1 20.6 10.2  28490  14232  14261    18      3  3525    0   4254     0    0
 2 27.9 18.8  56757  28203  28562   303   1675  7839    5   9690     0    2
 3 35.3 27.7  87337  43274  44085   698    741 12785   14  15689     0    3
 4 36.8 36.0 118630  58437  60216  1579   2973 14101   28  18732     0    7
 8 48.1 73.8 289374 133681 155600 18646  35340 10179  171  65889     0   34
16 41.4 82.5 268925  91908 177172 47498  17206  6940  176  71776     0   20

Cross-numa-node migrations are caused by load balancing pulls and
wake_affine moves.  Pulls are small and similar for no_steal and steal.
However, moves are significantly higher for steal, and rows above with the
highest moves have the worst regressions for time; see for example grp=8.

Moves increase for steal due to the following logic in wake_affine_idle()
for synchronous wakeup:

    if (sync && cpu_rq(this_cpu)->nr_running == 1)
        return this_cpu;        // move the task

The steal feature does a better job of smoothing the load between idle
and busy CPUs, so nr_running is 1 more often, and moves are performed
more often.  For hackbench, cross-node affine moves early in the run are
good because they colocate wakers and wakees from the same group on the
same node, but continued moves later in the run are bad, because the wakee
is moved away from peers on its previous node.  Note that even no_steal
is far from optimal; binding an instance of "hackbench 2" to each of the
8 NUMA nodes runs much faster than running "hackbench 16" with no binding.

Clearing SD_WAKE_AFFINE for domain2 eliminates the affine cross-node
migrations and eliminates the difference between no_steal and steal
performance.  However, overall performance is lower than WA_IDLE because
some migrations are helpful as explained above.

I have tried many heuristics in a attempt to optimize the number of
cross-node moves in all conditions, with limited success.  The fundamental
problem is that the scheduler does not track which groups of tasks talk to
each other.  Parts of several groups become entrenched on the same node,
filling it to capacity, leaving no room for either group to pull its peers
over, and there is neither data nor mechanism for the scheduler to evict
one group to make room for the other.

For now, disable STEAL on such systems until we can do better, or it is
shown that hackbench is atypical and most workloads benefit from stealing.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 kernel/sched/fair.c     | 16 +++++++++++++---
 kernel/sched/sched.h    |  2 +-
 kernel/sched/topology.c | 25 +++++++++++++++++++++++++
 3 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index cb86ec9..33d24ee 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3726,11 +3726,21 @@ static inline bool within_margin(int value, int margin)
 
 #define IF_SMP(statement)	statement
 
+static inline bool steal_enabled(void)
+{
+#ifdef CONFIG_NUMA
+	bool allow = static_branch_likely(&sched_steal_allow);
+#else
+	bool allow = true;
+#endif
+	return sched_feat(STEAL) && allow;
+}
+
 static void overload_clear(struct rq *rq)
 {
 	struct sparsemask *overload_cpus;
 
-	if (!sched_feat(STEAL))
+	if (!steal_enabled())
 		return;
 
 	rcu_read_lock();
@@ -3744,7 +3754,7 @@ static void overload_set(struct rq *rq)
 {
 	struct sparsemask *overload_cpus;
 
-	if (!sched_feat(STEAL))
+	if (!steal_enabled())
 		return;
 
 	rcu_read_lock();
@@ -9782,7 +9792,7 @@ static int try_steal(struct rq *dst_rq, struct rq_flags *dst_rf)
 	int stolen = 0;
 	struct sparsemask *overload_cpus;
 
-	if (!sched_feat(STEAL))
+	if (!steal_enabled())
 		return 0;
 
 	if (!cpu_active(dst_cpu))
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index aadfe68..5f181e9 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -928,7 +928,6 @@ static inline int cpu_of(struct rq *rq)
 #endif
 }
 
-
 #ifdef CONFIG_SCHED_SMT
 
 extern struct static_key_false sched_smt_present;
@@ -1083,6 +1082,7 @@ enum numa_topology_type {
 #endif
 
 #ifdef CONFIG_NUMA
+extern struct static_key_true sched_steal_allow;
 extern void sched_init_numa(void);
 extern void sched_domains_numa_masks_set(unsigned int cpu);
 extern void sched_domains_numa_masks_clear(unsigned int cpu);
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index f18c416..b7d2070 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1337,6 +1337,30 @@ static void init_numa_topology_type(void)
 	}
 }
 
+DEFINE_STATIC_KEY_TRUE(sched_steal_allow);
+static int sched_steal_node_limit;
+#define SCHED_STEAL_NODE_LIMIT_DEFAULT 1
+
+static int __init steal_node_limit_setup(char *buf)
+{
+	get_option(&buf, &sched_steal_node_limit);
+	return 0;
+}
+
+early_param("sched_steal_node_limit", steal_node_limit_setup);
+
+static void check_node_limit(void)
+{
+	int n = num_possible_nodes();
+
+	if (sched_steal_node_limit == 0)
+		sched_steal_node_limit = SCHED_STEAL_NODE_LIMIT_DEFAULT;
+	if (n > sched_steal_node_limit) {
+		static_branch_disable(&sched_steal_allow);
+		pr_debug("Suppressing sched STEAL. To enable, reboot with sched_steal_node_limit=%d", n);
+	}
+}
+
 void sched_init_numa(void)
 {
 	int next_distance, curr_distance = node_distance(0, 0);
@@ -1485,6 +1509,7 @@ void sched_init_numa(void)
 	sched_max_numa_distance = sched_domains_numa_distance[level - 1];
 
 	init_numa_topology_type();
+	check_node_limit();
 }
 
 void sched_domains_numa_masks_set(unsigned int cpu)
-- 
1.8.3.1

