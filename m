Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425688AbeBOQV0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 11:21:26 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57060 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1425676AbeBOQVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 11:21:24 -0500
From: Morten Rasmussen <morten.rasmussen@arm.com>
To: peterz@infradead.org, mingo@redhat.com
Cc: valentin.schneider@arm.com, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [PATCH 0/7] sched/fair: Migrate 'misfit' tasks on asymmetric capacity systems
Date: Thu, 15 Feb 2018 16:20:47 +0000
Message-Id: <1518711654-23503-1-git-send-email-morten.rasmussen@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On asymmetric cpu capacity systems (e.g. Arm big.LITTLE) it is crucial
for performance that cpu intensive tasks are aggressively migrated to
high capacity cpus as soon as those become available. The capacity
awareness tweaks already in the wake-up path can't handle this as such
tasks might run or be runnable forever. If they happen to be placed on a
low capacity cpu from the beginning they are stuck there forever while
high capacity cpus may have become available in the meantime.

To address this issue this patch set introduces a new "misfit"
load-balancing scenario in periodic/nohz/newly idle balance which tweaks
the load-balance conditions to ignore load per capacity in certain
cases. Since misfit tasks are commonly running alone on a cpu, more
aggressive active load-balancing is needed too.

The fundamental idea of this patch set has been in Android kernels for a
long time and is absolutely essential for consistent performance on
asymmetric cpu capacity systems.

The patches have been tested on:
   1. Arm Juno (r0): 2+4 Cortex A57/A53
   2. Hikey960: 4+4 Cortex A73/A53

Test case:
Big cpus are always kept busy. Pin a shorter running sysbench tasks to
big cpus, while creating a longer running set of unpinned sysbench
tasks.

    REQUESTS=1000
    BIGS="1 2"
    LITTLES="0 3 4 5"
 
    # Don't care about the score for those, just keep the bigs busy
    for i in $BIGS; do
        taskset -c $i sysbench --max-requests=$((REQUESTS / 4)) \
        --test=cpu  run &>/dev/null &
    done
 
    for i in $LITTLES; do
        sysbench --max-requests=$REQUESTS --test=cpu run \
	| grep "total time:" &
    done
 
    wait

Results:
Single runs with completion time of each task
Juno (tip)
    total time:                          1.2608s
    total time:                          1.2995s
    total time:                          1.5954s
    total time:                          1.7463s

Juno (misfit)
    total time:                          1.2575s
    total time:                          1.3004s
    total time:                          1.5860s
    total time:                          1.5871s

Hikey960 (tip)
    total time:                          1.7431s
    total time:                          2.2914s
    total time:                          2.5976s
    total time:                          1.7280s

Hikey960 (misfit)
    total time:                          1.7866s
    total time:                          1.7513s
    total time:                          1.6918s
    total time:                          1.6965s

10 run summary (tracking longest running task for each run)
	Juno		Hikey960
	avg	max	avg	max
tip     1.7465  1.7469  2.5997  2.6131 
misfit  1.6016  1.6192  1.8506  1.9666

Morten Rasmussen (4):
  sched: Add static_key for asymmetric cpu capacity optimizations
  sched/fair: Add group_misfit_task load-balance type
  sched/fair: Consider misfit tasks when load-balancing
  sched/fair: Avoid unnecessary balancing of asymmetric capacity groups

Valentin Schneider (3):
  sched/fair: Kick nohz balance if rq->misfit_task
  sched: Rename root_domain->overload to should_idle_balance
  sched/fair: Set sd->should_idle_balance when misfit

 kernel/sched/fair.c     | 141 +++++++++++++++++++++++++++++++++++++++++-------
 kernel/sched/sched.h    |  15 ++++--
 kernel/sched/topology.c |  10 ++++
 3 files changed, 142 insertions(+), 24 deletions(-)

-- 
2.7.4
