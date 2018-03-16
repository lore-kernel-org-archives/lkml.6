Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753881AbeCPLZw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 07:25:52 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36805 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753678AbeCPLZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 07:25:51 -0400
X-Google-Smtp-Source: AG47ELuLavxmekAcekfOgRNhgZ7EuNAX0AADFK/0f9XALuLoKnpHcOn1wvvtiCPI2LTim2CSeW6EbQ==
From: Vincent Guittot <vincent.guittot@linaro.org>
To: peterz@infradead.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net
Cc: juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, viresh.kumar@linaro.org,
        valentin.schneider@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 0/4 v4] sched/rt: track rt rq utilization
Date: Fri, 16 Mar 2018 12:25:37 +0100
Message-Id: <1521199541-15308-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When both cfs and rt tasks compete to run on a CPU, we can see some frequency
drops with schedutil governor. In such case, the cfs_rq's utilization doesn't
reflect anymore the utilization of cfs tasks but only the remaining part that
is not used by rt tasks. We should monitor the stolen utilization and take
it into account when selecting OPP. This patchset doesn't change the OPP
selection policy for RT tasks but only for CFS tasks

A rt-app use case which creates an always running cfs thread and a rt threads
that wakes up periodically with both threads pinned on same CPU, show lot of 
frequency switches of the CPU whereas the CPU never goes idles during the 
test. I can share the json file that I used for the test if someone is
interested in.

For a 15 seconds long test on a hikey 6220 (octo core cortex A53 platfrom),
the cpufreq statistics outputs (stats are reset just before the test) : 
$ cat /sys/devices/system/cpu/cpufreq/policy0/stats/total_trans
without patchset : 1230
with patchset : 14

If we replace the cfs thread of rt-app by a sysbench cpu test, we can see
performance improvements:

- Without patchset :
Test execution summary:
    total time:                          15.0009s
    total number of events:              4903
    total time taken by event execution: 14.9972
    per-request statistics:
         min:                                  1.23ms
         avg:                                  3.06ms
         max:                                 13.16ms
         approx.  95 percentile:              12.73ms

Threads fairness:
    events (avg/stddev):           4903.0000/0.00
    execution time (avg/stddev):   14.9972/0.00

- With patchset:
Test execution summary:
    total time:                          15.0014s
    total number of events:              7694
    total time taken by event execution: 14.9979
    per-request statistics:
         min:                                  1.23ms
         avg:                                  1.95ms
         max:                                 10.49ms
         approx.  95 percentile:              10.39ms

Threads fairness:
    events (avg/stddev):           7694.0000/0.00
    execution time (avg/stddev):   14.9979/0.00

The performance improvement is 56% for this use case.

Patch 1 move pelt code in pelt.c file
Patch 2 tracks utilization of rt_rq.
Patch 3 adds the rt_rq's utilization when selection OPP for cfs tasks
Patch 4 support periodic update of blocked rt utilization

Change since v3:
- add support of periodic update of blocked utilization
- rebase on lastest tip/sched/core

Change since v2:
- move pelt code into a dedicated pelt.c file
- rebase on load tracking changes

Change since v1:
- Only a rebase. I have addressed the comments on previous version in
  patch 1/2

Vincent Guittot (4):
  sched/pelt: Move pelt related code in a dedicated file
  sched/rt: add rt_rq utilization tracking
  cpufreq/schedutil: add rt utilization tracking
  sched/nohz: monitor rt utilization

 kernel/sched/Makefile            |   2 +-
 kernel/sched/cpufreq_schedutil.c |   4 +-
 kernel/sched/fair.c              | 321 ++-----------------------------------
 kernel/sched/pelt.c              | 331 +++++++++++++++++++++++++++++++++++++++
 kernel/sched/pelt.h              |  24 +++
 kernel/sched/rt.c                |   8 +
 kernel/sched/sched.h             |  28 ++++
 7 files changed, 410 insertions(+), 308 deletions(-)
 create mode 100644 kernel/sched/pelt.c
 create mode 100644 kernel/sched/pelt.h

-- 
2.7.4
