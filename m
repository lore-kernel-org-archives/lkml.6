Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965611AbeCTAaM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 20:30:12 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43690 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935255AbeCTAaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 20:30:10 -0400
From: Rohit Jain <rohit.k.jain@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, steven.sistare@oracle.com,
        joelaf@google.com, jbacik@fb.com, juri.lelli@redhat.com,
        dhaval.giani@oracle.com, efault@gmx.de, riel@surriel.com
Subject: [PATCH v3] sched/fair: Remove check in idle_balance against migration_cost
Date: Mon, 19 Mar 2018 17:28:50 -0700
Message-Id: <1521505730-1866-1-git-send-email-rohit.k.jain@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8836 signatures=668693
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=930
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803190149
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch "1b9508f6 sched: Rate-limit newidle" reduced the CPU time spent in
idle_balance() by refusing to balance if the average idle time was less
than sysctl_sched_migration_cost.  Since then, more refined methods for
reducing CPU time have been added, including dynamic measurement of search
cost in curr_cost and a check for this_rq->rd->overload.  The original
check of sysctl_sched_migration_cost is no longer necessary, and is in
fact harmful because it discourages load balancing, so delete it.

1) An internal Oracle RDBMS OLTP test test on an 8-socket Exadata shows
a 2.2% gain in throughput.

2) Hackbench results on 2 socket, 44 core and 88 threads Intel x86 machine
(lower is better):

+--------------+-----------------+-------------------------+
|              | Without Patch   |With Patch               |
+------+-------+--------+--------+----------------+--------+
|Loops | Groups|Average |%Std Dev|Average         |%Std Dev|
+------+-------+--------+--------+----------------+--------+
|100000| 4     |8.313   |0.64    |8.284  (+0.35%) |2.09    |
|100000| 8     |14.606  |1.73    |14.451 (+1.07%) |1.32    |
|100000| 16    |26.203  |0.72    |25.509 (+2.65%) |0.19    |
|100000| 25    |38.270  |0.20    |36.545 (+4.51%) |0.30    |
+------+-------+--------+--------+----------------+--------+

3) tbench sample results on 2 socket, 44 core and 88 threads Intel x86
machine:

Without Patch:

Throughput 670.753 MB/sec   2 clients   2 procs  max_latency=0.150 ms
Throughput 1530.57 MB/sec   5 clients   5 procs  max_latency=0.366 ms
Throughput 2911.36 MB/sec  10 clients  10 procs  max_latency=0.917 ms
Throughput 5626.88 MB/sec  20 clients  20 procs  max_latency=5.037 ms
Throughput 8925.31 MB/sec  40 clients  40 procs  max_latency=7.510 ms

With Patch:

Throughput 672.377 MB/sec   2 clients   2 procs  max_latency=0.269 ms
Throughput 1562.44 MB/sec   5 clients   5 procs  max_latency=5.774 ms
Throughput 2973.76 MB/sec  10 clients  10 procs  max_latency=0.527 ms
Throughput 5726.74 MB/sec  20 clients  20 procs  max_latency=2.187 ms
Throughput 9162.58 MB/sec  40 clients  40 procs  max_latency=4.713 ms

Changelog:
* v1->v2: Changed the per-domain accounting of load-balance cost to just
  removing the check against overall migration_cost, which works well.
* v2->v3: Pulled to the latest source code and re-tested the benchmarks.

Signed-off-by: Rohit Jain <rohit.k.jain@oracle.com>
---
 kernel/sched/fair.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3582117..da619fb 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9587,8 +9587,7 @@ static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
 	 */
 	rq_unpin_lock(this_rq, rf);
 
-	if (this_rq->avg_idle < sysctl_sched_migration_cost ||
-	    !this_rq->rd->overload) {
+	if (!this_rq->rd->overload) {
 
 		rcu_read_lock();
 		sd = rcu_dereference_check_sched_domain(this_rq->sd);
-- 
2.7.4
