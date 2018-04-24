Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932736AbeDXAj0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 20:39:26 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54680 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932691AbeDXAjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 20:39:00 -0400
From: subhra mazumdar <subhra.mazumdar@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, daniel.lezcano@linaro.org,
        steven.sistare@oracle.com, dhaval.giani@oracle.com,
        rohit.k.jain@oracle.com, subhra.mazumdar@oracle.com
Subject: [PATCH 3/3] sched: limit cpu search and rotate search window for scalability
Date: Mon, 23 Apr 2018 17:41:16 -0700
Message-Id: <20180424004116.28151-4-subhra.mazumdar@oracle.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180424004116.28151-1-subhra.mazumdar@oracle.com>
References: <20180424004116.28151-1-subhra.mazumdar@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8872 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=978
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804240003
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lower the lower limit of idle cpu search in select_idle_cpu() and also put
an upper limit. This helps in scalability of the search by restricting the
search window. Also rotating the search window with help of next_cpu
ensures any idle cpu is eventually found in case of high load.

Signed-off-by: subhra mazumdar <subhra.mazumdar@oracle.com>
---
 kernel/sched/fair.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d1d4769..62d585b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6279,7 +6279,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 	u64 avg_cost, avg_idle;
 	u64 time, cost;
 	s64 delta;
-	int cpu, nr = INT_MAX;
+	int cpu, target_tmp, nr = INT_MAX;
 
 	this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
 	if (!this_sd)
@@ -6297,15 +6297,24 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 
 	if (sched_feat(SIS_PROP)) {
 		u64 span_avg = sd->span_weight * avg_idle;
-		if (span_avg > 4*avg_cost)
+		if (span_avg > 2*avg_cost) {
 			nr = div_u64(span_avg, avg_cost);
-		else
-			nr = 4;
+			if (nr > 4)
+				nr = 4;
+		} else {
+			nr = 2;
+		}
 	}
 
+	if (per_cpu(next_cpu, target) != -1)
+		target_tmp = per_cpu(next_cpu, target);
+	else
+		target_tmp = target;
+
 	time = local_clock();
 
-	for_each_cpu_wrap(cpu, sched_domain_span(sd), target) {
+	for_each_cpu_wrap(cpu, sched_domain_span(sd), target_tmp) {
+		per_cpu(next_cpu, target) = cpu;
 		if (!--nr)
 			return -1;
 		if (!cpumask_test_cpu(cpu, &p->cpus_allowed))
-- 
2.9.3
