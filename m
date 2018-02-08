Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752135AbeBHWPu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 17:15:50 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:34906 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752013AbeBHWPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 17:15:47 -0500
From: Rohit Jain <rohit.k.jain@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, steven.sistare@oracle.com,
        joelaf@google.com, jbacik@fb.com, riel@redhat.com,
        juri.lelli@redhat.com, dhaval.giani@oracle.com, efault@gmx.de
Subject: [RFC 0/2] sched: Make idle_balance smarter about topology
Date: Thu,  8 Feb 2018 14:19:53 -0800
Message-Id: <1518128395-14606-1-git-send-email-rohit.k.jain@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8799 signatures=668665
X-Proofpoint-Spam-Details: rule=notspam policy=default score=1 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=1 mlxscore=1 mlxlogscore=185
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802080255
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current idle_balance does a check against migration cost (fixed value)
with the average idle time of a CPU. There is a huge difference in
migration costs between CPUs of the same core, different cores and
different sockets. Since sched_domain already captures the architectural
dependencies, this patch tries to encapsulate the migration cost based
on the topology of the machine.

Test Results:

* Wins:

1) hackbench results on 44 core (22 core per socket), 2 socket Intel x86
machine (lower is better)

+-------+----+-------+-------------------+--------------------------+
|       |    |       | Without patch     |With patch                |
+-------+----+-------+---------+---------+----------------+---------+
|Loops  |FD  |Groups | Average |%Std Dev |Average         |%Std Dev |
+-------+----+-------+---------+---------+----------------+---------+
|100000 |40  |4      | 9.701   |0.78     |9.623  (+0.81%) |3.67     |
|100000 |40  |8      | 17.186  |0.77     |17.068 (+0.68%) |1.89     |
|100000 |40  |16     | 30.378  |0.55     |30.072 (+1.52%) |0.46     |
|100000 |40  |32     | 54.712  |0.54     |53.588 (+2.28%) |0.21     |
+-------+----+-------+---------+---------+----------------+---------+

Note: I start with 4 groups because the Standard Deviation for groups 1
and 2 was very high.

2) sysbench MySQL results on 2 socket, 44 core and 88 threads Intel x86
machine (higher is better):

+-----------+--------------------------------+-------------------------------+
|           | Without Patch                  | With Patch                    |
+-----------+--------+------------+----------+--------------------+----------+
|Approx.    | Num    |  Average   |          |  Average           |          |
|Utilization| Threads|  througput | %Std Dev |  througput         | %Std Dev |
+-----------+--------+------------+----------+--------------------+----------+
|10.00%     |    8   |  133658.2  |  0.66    |  135071.6 (+1.06%) | 1.39     |
|20.00%     |    16  |  266540    |  0.48    |  268417.4 (+0.70%) | 0.88     |
|40.00%     |    32  |  466315.6  |  0.15    |  468289.0 (+0.42%) | 0.45     |
|75.00%     |    64  |  720039.4  |  0.23    |  726244.2 (+0.86%) | 0.03     |
|82.00%     |    72  |  757284.4  |  0.25    |  769020.6 (+1.55%) | 0.18     |
|90.00%     |    80  |  807955.6  |  0.22    |  818989.4 (+1.37%) | 0.22     |
|98.00%     |    88  |  863173.8  |  0.25    |  876121.8 (+1.50%) | 0.28     |
|100.00%    |    96  |  882950.8  |  0.32    |  890678.8 (+0.88%) | 0.51     |
|100.00%    |    128 |  895112.6  |  0.13    |  899149.6 (+0.47%) | 0.44     |
+-----------+--------+------------+----------+--------------------+----------+

* No change:

3) tbench sample results on 2 socket, 44 core and 88 threads Intel x86
machine:

With Patch:

Throughput 555.834 MB/sec  2 clients    2 procs  max_latency=0.330 ms
Throughput 1388.19 MB/sec  5 clients    5 procs  max_latency=3.666 ms
Throughput 2737.96 MB/sec  10 clients  10 procs  max_latency=1.646 ms
Throughput 5220.17 MB/sec  20 clients  20 procs  max_latency=3.666 ms
Throughput 8324.46 MB/sec  40 clients  40 procs  max_latency=0.732 ms

Without patch:

Throughput 557.142 MB/sec  2 clients    2 procs  max_latency=0.264 ms
Throughput 1381.59 MB/sec  5 clients    5 procs  max_latency=0.335 ms
Throughput 2726.84 MB/sec  10 clients  10 procs  max_latency=0.352 ms
Throughput 5230.12 MB/sec  20 clients  20 procs  max_latency=1.632 ms
Throughput 8474.5 MB/sec  40 clients   40 procs  max_latency=7.756 ms

Note: High variation observed in max_latency in different runs

Rohit Jain (2):
  sched: reduce migration cost between faster caches for idle_balance
  Introduce sysctl(s) for the migration costs

 include/linux/sched/sysctl.h   |  2 ++
 include/linux/sched/topology.h |  1 +
 kernel/sched/fair.c            | 10 ++++++----
 kernel/sched/topology.c        |  5 +++++
 kernel/sysctl.c                | 14 ++++++++++++++
 5 files changed, 28 insertions(+), 4 deletions(-)

-- 
2.7.4
