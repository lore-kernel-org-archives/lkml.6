Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752274AbeCNSi3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 14:38:29 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39780 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751381AbeCNSi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 14:38:27 -0400
From: Rohit Jain <rohit.k.jain@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, steven.sistare@oracle.com,
        joelaf@google.com, jbacik@fb.com, juri.lelli@redhat.com,
        dhaval.giani@oracle.com, efault@gmx.de, riel@surriel.com
Subject: [RESEND PATCH v2] sched/fair: Remove check in idle_balance against migration_cost
Date: Wed, 14 Mar 2018 11:36:47 -0700
Message-Id: <1521052607-24622-1-git-send-email-rohit.k.jain@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8832 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=644
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803140203
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

1) An internal Oracle RDBMS OLTP test on an 8-socket Exadata shows a 2.2%
gain in throughput.

2) Hackbench results on 2 socket, 44 core and 88 threads Intel x86 machine
(lower is better):

+--------------+-----------------+-------------------------+
|              | Without Patch   |With Patch               |
+------+-------+--------+--------+----------------+--------+
|Loops | Groups|Average |%Std Dev|Average         |%Std Dev|
+------+-------+--------+--------+----------------+--------+
|100000| 4     |9.701   |0.78    |8.919  (+8.07%) |1.07    |
|100000| 8     |17.186  |0.77    |17.043 (+0.83%) |0.83    |
|100000| 16    |30.378  |0.55    |29.565 (+2.67%) |0.29    |
|100000| 32    |54.712  |0.54    |52.158 (+4.67%) |0.22    |
+------+-------+--------+--------+----------------+--------+

3) Sysbench MySQL results on 2 socket, 44 core and 88 threads Intel x86
machine (higher is better):

+-------+--------------------+----------------------------+
|       | Without Patch      | With Patch                 |
+-------+-----------+--------+-------------------+--------+
|Num    | Average   |        | Average           |        |
|Threads| throughput|%Std Dev| throughput        |%Std Dev|
+-------+-----------+--------+-------------------+--------+
|    8  | 133658.2  | 0.66   | 134232.2 (+0.43%) | 1.29   |
|   16  | 266540    | 0.48   | 268584.6 (+0.77%) | 0.37   |
|   32  | 466315.6  | 0.15   | 468594.2 (+0.49%) | 0.23   |
|   64  | 720039.4  | 0.23   | 717253.8 (-0.39%) | 0.36   |
|   72  | 757284.4  | 0.25   | 764984.0 (+1.02%) | 0.38   |
|   80  | 807955.6  | 0.22   | 831372.2 (+2.90%) | 0.10   |
|   88  | 863173.8  | 0.25   | 887049.0 (+2.77%) | 0.56   |
|   96  | 882950.8  | 0.32   | 892913.8 (+1.13%) | 0.41   |
|  128  | 895112.6  | 0.13   | 901195.0 (+0.68%) | 0.28   |
+-------+-----------+--------+-------------------+--------+ 

4) tbench sample results on 2 socket, 44 core and 88 threads Intel x86
machine:

With Patch:

Throughput 562.783 MB/sec   2 clients   2 procs  max_latency=0.365 ms
Throughput 1394.5  MB/sec   5 clients   5 procs  max_latency=0.531 ms
Throughput 2741.27 MB/sec  10 clients  10 procs  max_latency=0.692 ms
Throughput 5279.49 MB/sec  20 clients  20 procs  max_latency=1.029 ms
Throughput 8529.22 MB/sec  40 clients  40 procs  max_latency=1.693 ms

Without patch:

Throughput 557.142 MB/sec   2 clients   2 procs  max_latency=0.264 ms
Throughput 1381.59 MB/sec   5 clients   5 procs  max_latency=0.335 ms
Throughput 2726.84 MB/sec  10 clients  10 procs  max_latency=0.352 ms
Throughput 5230.12 MB/sec  20 clients  20 procs  max_latency=1.632 ms
Throughput 8474.5  MB/sec  40 clients  40 procs  max_latency=7.756 ms


Signed-off-by: Rohit Jain <rohit.k.jain@oracle.com>

Signed-off-by: Rohit Jain <rohit.k.jain@oracle.com>
---
 kernel/sched/fair.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5eb3ffc..569ea83 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8804,8 +8804,7 @@ static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
 	 */
 	rq_unpin_lock(this_rq, rf);
 
-	if (this_rq->avg_idle < sysctl_sched_migration_cost ||
-	    !this_rq->rd->overload) {
+	if (!this_rq->rd->overload) {
 		rcu_read_lock();
 		sd = rcu_dereference_check_sched_domain(this_rq->sd);
 		if (sd)
-- 
2.7.4
