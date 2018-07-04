Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 114EFC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB11B2150E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:21:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB11B2150E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934703AbeGDKVQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 06:21:16 -0400
Received: from foss.arm.com ([217.140.101.70]:34970 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934360AbeGDKSL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 06:18:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D807D18A;
        Wed,  4 Jul 2018 03:18:10 -0700 (PDT)
Received: from e105550-lin.cambridge.arm.com (e105550-lin.cambridge.arm.com [10.1.211.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 600673F5AD;
        Wed,  4 Jul 2018 03:18:09 -0700 (PDT)
From:   Morten Rasmussen <morten.rasmussen@arm.com>
To:     peterz@infradead.org, mingo@redhat.com
Cc:     valentin.schneider@arm.com, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, gaku.inami.xh@renesas.com,
        linux-kernel@vger.kernel.org,
        Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [PATCHv4 00/12] sched/fair: Migrate 'misfit' tasks on asymmetric capacity systems
Date:   Wed,  4 Jul 2018 11:17:38 +0100
Message-Id: <1530699470-29808-1-git-send-email-morten.rasmussen@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
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

Changelog:
v4
- Added check for empty cpu_map in sd_init().
- Added patch to disable SD_ASYM_CPUCAPACITY for root_domains that don't
  observe capacity asymmetry if the system as a whole is asymmetric.
- Added patch to disable SD_PREFER_SIBLING on the sched_domain level below
  SD_ASYM_CPUCAPACITY.
- Rebased against tip/sched/core.
- Fixed uninitialised variable introduced in update_sd_lb_stats.
- Added patch to do a slight variable initialisation cleanup in update_sd_lb_stats.
- Removed superfluous type changes for temp variables assigned to root_domain->overload.
- Reworded commit for the patch setting rq->rd->overload when misfit.
- v3 Tested-by: Gaku Inami <gaku.inami.xh@renesas.com>

v3
- Fixed locking around static_key.
- Changed group per-cpu capacity comparison to be based on max rather
  than min capacity.
- Added patch to prevent occasional pointless high->low capacity
  migrations.
- Changed type of group_misfit_task_load and misfit_task_load to
  unsigned long.
- Changed fbq() to pick the cpu with highest misfit_task_load rather
  than breaking when the first is found.
- Rebased against tip/sched/core.
- v2 Tested-by: Gaku Inami <gaku.inami.xh@renesas.com>

v2
- Removed redudant condition in static_key enablement.
- Fixed logic flaw in patch #2 reported by Yi Yao <yi.yao@intel.com>
- Dropped patch #4 as although the patch seems to make sense no benefit
  has been proven.
- Dropped root_domain->overload renaming
- Changed type of root_domain->overload to int
- Wrapped accesses of rq->rd->overload with READ/WRITE_ONCE
- v1 Tested-by: Gaku Inami <gaku.inami.xh@renesas.com>

Chris Redpath (1):
  sched/fair: Don't move tasks to lower capacity cpus unless necessary

Morten Rasmussen (6):
  sched: Add static_key for asymmetric cpu capacity optimizations
  sched/fair: Add group_misfit_task load-balance type
  sched: Add sched_group per-cpu max capacity
  sched/fair: Consider misfit tasks when load-balancing
  sched/core: Disable SD_ASYM_CPUCAPACITY for root_domains without
    asymmetry
  sched/core: Disable SD_PREFER_SIBLING on asymmetric cpu capacity
    domains

Valentin Schneider (5):
  sched/fair: Kick nohz balance if rq->misfit_task_load
  sched/fair: Change prefer_sibling type to bool
  sched: Change root_domain->overload type to int
  sched: Wrap rq->rd->overload accesses with READ/WRITE_ONCE
  sched/fair: Set rq->rd->overload when misfit

 kernel/sched/fair.c     | 161 +++++++++++++++++++++++++++++++++++++++++-------
 kernel/sched/sched.h    |  16 +++--
 kernel/sched/topology.c |  53 ++++++++++++++--
 3 files changed, 199 insertions(+), 31 deletions(-)

-- 
2.7.4

