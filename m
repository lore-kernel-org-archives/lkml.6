Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751347AbeEBUwq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 16:52:46 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48016 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750939AbeEBUwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 16:52:43 -0400
From: Rohit Jain <rohit.k.jain@oracle.com>
To: matt@codeblueprint.co.uk, peterz@infradead.org
Cc: mingo@kernel.org, dhaval.giani@oracle.com, subhra.mazumdar@oracle.com,
        steven.sistare@oracle.com, linux-kernel@vger.kernel.org
Subject: [RFC] sched/core: Don't schedule threads on pre-empted vcpus
Date: Wed,  2 May 2018 13:52:10 -0700
Message-Id: <1525294330-7759-1-git-send-email-rohit.k.jain@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8881 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=528
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805020174
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In paravirt configurations today, spinlocks figure out whether a vcpu is
running to determine whether or not spinlock should bother spinning. We
can use the same logic to prioritize CPUs when scheduling threads. If a
vcpu has been pre-empted, it will incur the extra cost of VMENTER and
the time it actually spends to be running on the host CPU. If we had
other vcpus which were actually running on the host CPU and idle we
should schedule threads there.

Performance numbers:

Note: With patch is referred to as Paravirt in the following and without
patch is referred to as Base.

1) When only 1 VM is running:

    a) Hackbench test on KVM 8 vcpus, 10,000 loops (lower is better):

+-------+-----------------+----------------+
|Number |Paravirt         |Base            |
|of     +---------+-------+-------+--------+
|Threads|Average  |Std Dev|Average| Std Dev|
+-------+---------+-------+-------+--------+
|1      |1.817    |0.076  |1.721  | 0.067  |
|2      |3.467    |0.120  |3.468  | 0.074  |
|4      |6.266    |0.035  |6.314  | 0.068  |
|8      |11.437   |0.105  |11.418 | 0.132  |
|16     |21.862   |0.167  |22.161 | 0.129  |
|25     |33.341   |0.326  |33.692 | 0.147  |
+-------+---------+-------+-------+--------+ 

2) When two VMs are running with same CPU affinities:

    a) tbench test on VM 8 cpus

Base:

VM1:

Throughput 220.59 MB/sec   1 clients  1 procs  max_latency=12.872 ms
Throughput 448.716 MB/sec  2 clients  2 procs  max_latency=7.555 ms
Throughput 861.009 MB/sec  4 clients  4 procs  max_latency=49.501 ms
Throughput 1261.81 MB/sec  7 clients  7 procs  max_latency=76.990 ms

VM2:

Throughput 219.937 MB/sec  1 clients  1 procs  max_latency=12.517 ms
Throughput 470.99 MB/sec   2 clients  2 procs  max_latency=12.419 ms
Throughput 841.299 MB/sec  4 clients  4 procs  max_latency=37.043 ms
Throughput 1240.78 MB/sec  7 clients  7 procs  max_latency=77.489 ms

Paravirt:

VM1:

Throughput 222.572 MB/sec  1 clients  1 procs  max_latency=7.057 ms
Throughput 485.993 MB/sec  2 clients  2 procs  max_latency=26.049 ms
Throughput 947.095 MB/sec  4 clients  4 procs  max_latency=45.338 ms
Throughput 1364.26 MB/sec  7 clients  7 procs  max_latency=145.124 ms

VM2:

Throughput 224.128 MB/sec  1 clients  1 procs  max_latency=4.564 ms
Throughput 501.878 MB/sec  2 clients  2 procs  max_latency=11.061 ms
Throughput 965.455 MB/sec  4 clients  4 procs  max_latency=45.370 ms
Throughput 1359.08 MB/sec  7 clients  7 procs  max_latency=168.053 ms

    b) Hackbench with 4 fd 1,000,000 loops

+-------+--------------------------------------+----------------------------------------+
|Number |Paravirt                              |Base                                    |
|of     +----------+--------+---------+--------+----------+--------+---------+----------+
|Threads|Average1  |Std Dev1|Average2 | Std Dev|Average1  |Std Dev1|Average2 | Std Dev 2|
+-------+----------+--------+---------+--------+----------+--------+---------+----------+
|  1    | 3.748    | 0.620  | 3.576   | 0.432  | 4.006    | 0.395  | 3.446   | 0.787    |
+-------+----------+--------+---------+--------+----------+--------+---------+----------+

Note that this test was run just to show the interference effect
over-subscription can have in baseline

    c) schbench results with 2 message groups on 8 vcpu VMs
+-----------+-------+---------------+--------------+------------+
|           |       | Paravirt      | Base         |            |
+-----------+-------+-------+-------+-------+------+------------+
|           |Threads| VM1   | VM2   |  VM1  | VM2  |%Improvement|
+-----------+-------+-------+-------+-------+------+------------+
|50.0000th  |    1  | 52    | 53    |  58   | 54   |  +6.25%    |
|75.0000th  |    1  | 69    | 61    |  83   | 59   |  +8.45%    |
|90.0000th  |    1  | 80    | 80    |  89   | 83   |  +6.98%    |
|95.0000th  |    1  | 83    | 83    |  93   | 87   |  +7.78%    |
|*99.0000th |    1  | 92    | 94    |  99   | 97   |  +5.10%    |
|99.5000th  |    1  | 95    | 100   |  102  | 103  |  +4.88%    |
|99.9000th  |    1  | 107   | 123   |  105  | 203  |  +25.32%   |
+-----------+-------+-------+-------+-------+------+------------+
|50.0000th  |    2  | 56    | 62    |  67   | 59   |  +6.35%    |
|75.0000th  |    2  | 69    | 75    |  80   | 71   |  +4.64%    |
|90.0000th  |    2  | 80    | 82    |  90   | 81   |  +5.26%    |
|95.0000th  |    2  | 85    | 87    |  97   | 91   |  +8.51%    |
|*99.0000th |    2  | 98    | 99    |  107  | 109  |  +8.79%    |
|99.5000th  |    2  | 107   | 105   |  109  | 116  |  +5.78%    |
|99.9000th  |    2  | 9968  | 609   |  875  | 3116 | -165.02%   |
+-----------+-------+-------+-------+-------+------+------------+
|50.0000th  |    4  | 78    | 77    |  78   | 79   |  +1.27%    |
|75.0000th  |    4  | 98    | 106   |  100  | 104  |   0.00%    |
|90.0000th  |    4  | 987   | 1001  |  995  | 1015 |  +1.09%    |
|95.0000th  |    4  | 4136  | 5368  |  5752 | 5192 |  +13.16%   |
|*99.0000th |    4  | 11632 | 11344 |  11024| 10736|  -5.59%    |
|99.5000th  |    4  | 12624 | 13040 |  12720| 12144|  -3.22%    |
|99.9000th  |    4  | 13168 | 18912 |  14992| 17824|  +2.24%    |
+-----------+-------+-------+-------+-------+------+------------+

Note: Improvement is measured for (VM1+VM2)

Signed-off-by: Rohit Jain <rohit.k.jain@oracle.com>
---
 kernel/sched/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5e10aae..75d1ecf 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4033,6 +4033,9 @@ int idle_cpu(int cpu)
 		return 0;
 #endif
 
+	if (vcpu_is_preempted(cpu))
+		return 0;
+
 	return 1;
 }
 
-- 
2.7.4
