Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D52C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9196220866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:13:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9196220866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbeILOQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 10:16:59 -0400
Received: from foss.arm.com ([217.140.101.70]:55708 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726901AbeILOQ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 10:16:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 511D07A9;
        Wed, 12 Sep 2018 02:13:21 -0700 (PDT)
Received: from queper01-lin.local (queper01-lin.emea.arm.com [10.4.13.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 151043F703;
        Wed, 12 Sep 2018 02:13:16 -0700 (PDT)
From:   Quentin Perret <quentin.perret@arm.com>
To:     peterz@infradead.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, mingo@redhat.com,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, patrick.bellasi@arm.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        thara.gopinath@linaro.org, viresh.kumar@linaro.org,
        tkjos@google.com, joel@joelfernandes.org, smuckle@google.com,
        adharmap@codeaurora.org, skannan@codeaurora.org,
        pkondeti@codeaurora.org, juri.lelli@redhat.com,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org,
        quentin.perret@arm.com
Subject: [PATCH v7 00/14] Energy Aware Scheduling
Date:   Wed, 12 Sep 2018 10:12:55 +0100
Message-Id: <20180912091309.7551-1-quentin.perret@arm.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series introduces Energy Aware Scheduling (EAS) for CFS tasks
on platforms with asymmetric CPU topologies (e.g. Arm big.LITTLE).

For more details about the ideas behind it and the overall design,
please refer to the cover letter of version 5 [1].


1. Version History
------------------

Changes v6[2]->v7:
- Replaced the sched_energy_present static key by a sched_feat
- Replaced the CPUFreq notifier in the dependency between sugov and EAS
  by a function call
- Squashed all sugov-refactoring patches into patch 02
- Clarified comment in em_fd_energy() to explain the choice of “energy”
  over “power”
- Added kerneldoc to structs in include/linux/energy_model.h
- Removed unnecessary memory barrier from the EM framework
- Fixed corner case in find_energy_efficient_cpu when prev_cpu is
  overutilized (and prev_energy = ULONG_MAX)

Changes v5[1]->v6:
- Rebased on Peter’s sched/core branch (that includes Morten's misfit
  patches [3] and the automatic detection of SD_ASYM_CPUCAPACITY [4])
- Removed patch 13/14 (not needed with the automatic flag detection)
- Added patch creating a dependency between sugov and EAS
- Renamed frequency domains to performance domains to avoid creating too
  deep assumptions in the code about the HW
- Renamed the sd_ea shortcut sd_asym_cpucapacity
- Added comment to explain why new tasks are not accounted when
  detecting the 'overutilized' flag
- Added comment explaining why forkees don’t go in
  find_energy_efficient_cpu()

Changes v4[5]->v5:
- Removed the RCU protection of the EM tables and the associated
  need for em_rescale_cpu_capacity().
- Factorized schedutil’s PELT aggregation function with EAS
- Improved comments/doc in the EM framework
- Added check on the uarch of CPUs in one fd in the EM framework
- Reduced CONFIG_ENERGY_MODEL ifdefery in kernel/sched/topology.c
- Cleaned-up update_sg_lb_stats parameters
- Improved comments in compute_energy() to explain the multi-rd
  scenarios

Changes v3[6]->v4:
- Replaced spinlock in EM framework by smp_store_release/READ_ONCE
- Fixed missing locks to protect rcu_assign_pointer in EM framework
- Fixed capacity calculation in EM framework on 32 bits system
- Fixed compilation issue for CONFIG_ENERGY_MODEL=n
- Removed cpumask from struct em_freq_domain, now dynamically allocated
- Power costs of the EM are specified in milliwatts
- Added example of CPUFreq driver modification
- Added doc/comments in the EM framework and better commit header
- Fixed integration issue with util_est in cpu_util_next()
- Changed scheduler topology code to have one freq. dom. list per rd
- Split sched topology patch in smaller patches
- Added doc/comments explaining the heuristic in the wake-up path
- Changed energy threshold for migration to from 1.5% to 6%

Changes v2[7]->v3:
- Removed the PM_OPP dependency by implementing a new EM framework
- Modified the scheduler topology code to take references on the EM data
  structures
- Simplified the overutilization mechanism into a system-wide flag
- Reworked the integration in the wake-up path using the sd_ea shortcut
- Rebased on tip/sched/core (247f2f6f3c70 "sched/core: Don't schedule
  threads on pre-empted vCPUs")

Changes v1[8]->v2:
- Reworked interface between fair.c and energy.[ch] (Remove #ifdef
  CONFIG_PM_OPP from energy.c) (Greg KH)
- Fixed licence & header issue in energy.[ch] (Greg KH)
- Reordered EAS path in select_task_rq_fair() (Joel)
- Avoid prev_cpu if not allowed in select_task_rq_fair() (Morten/Joel)
- Refactored compute_energy() (Patrick)
- Account for RT/IRQ pressure in task_fits() (Patrick)
- Use UTIL_EST and DL utilization during OPP estimation (Patrick/Juri)
- Optimize selection of CPU candidates in the energy-aware wake-up path
- Rebased on top of tip/sched/core (commit b720342849fe “sched/core:
  Update Preempt_notifier_key to modern API”)


2. Test results
---------------

Two fundamentally different tests were executed. Firstly the energy test
case shows the impact on energy consumption this patch-set has using a
synthetic set of tasks. Secondly the performance test case provides the
conventional hackbench metric numbers.

The tests run on two arm64 big.LITTLE platforms: Hikey960 (4xA73 +
4xA53) and Juno r0 (2xA57 + 4xA53).

Base kernel is 4.18-rc6, with some Hikey960 and Juno specific patches,
and Morten's patches from tip/sched/core for detecting the
SD_ASYM_CPUCAPACITY flag [9].

2.1 Energy test case

10 iterations of between 10 and 50 periodic rt-app tasks (16ms period,
5% duty-cycle) for 30 seconds with energy measurement. Unit is Joules.
The goal is to save energy, so lower is better.

2.1.1 Hikey960

Energy is measured with an ACME Cape on an instrumented board. Numbers
include consumption of big and little CPUs, LPDDR memory, GPU and most
of the other small components on the board. They do not include
consumption of the radio chip (turned-off anyway) and external
connectors.

+----------+-----------------+-------------------------+
|          | Without patches | With patches            |
+----------+--------+--------+------------------+------+
| Tasks nb |  Mean  | RSD*   | Mean             | RSD* |
+----------+--------+--------+------------------+------+
|       10 |  34.14 |   4.2% |  29.41 (-13.85%) | 2.0% |
|       20 |  52.83 |   1.5% |  44.57 (-15.64%) | 2.6% |
|       30 |  66.67 |   1.4% |  60.92  (-8.62%) | 3.7% |
|       40 |  93.21 |   3.7% |  86.36  (-7.35%) | 6.4% |
|       50 | 135.52 |   5.0% | 108.36 (-20.04%) | 2.1% |
+----------+--------+--------+------------------+------+

2.1.2 Juno r0

Energy is measured with the onboard energy meter. Numbers include
consumption of big and little CPUs.

+----------+-----------------+------------------------+
|          | Without patches | With patches           |
+----------+--------+--------+-----------------+------+
| Tasks nb |  Mean  | RSD*   | Mean            | RSD* |
+----------+--------+--------+-----------------+------+
|       10 |  10.83 |   6.7% |  7.79 (-28.07%) | 6.4% |
|       20 |  20.84 |   3.3% | 15.69 (-24.71%) | 4.1% |
|       30 |  32.41 |   2.8% | 23.85 (-26.41%) | 4.4% |
|       40 |  43.26 |   1.1% | 33.69 (-22.12%) | 4.1% |
|       50 |  56.26 |   2.5% | 47.95 (-14.77%) | 6.0% |
+----------+--------+--------+-----------------+------+


2.2 Performance test case

30 iterations of perf bench sched messaging --pipe --thread --group G
--loop L with G=[1 2 4 8] and L=50000 (Hikey960)/16000 (Juno r0).

2.2.1 Hikey960

The impact of thermal capping was mitigated thanks to a heatsink, a
fan, and a 30 sec delay between two successive executions. IPA is
disabled to reduce the stddev.

+----------------+-----------------+------------------------+
|                | Without patches | With patches           |
+--------+-------+---------+-------+----------------+-------+
| Groups | Tasks | Mean    | RSD*  | Mean           | RSD*  |
+--------+-------+---------+-------+----------------+-------+
|      1 |    40 |    8.03 | 0.99% |  8.23 (+2.49%) | 1.16% |
|      2 |    80 |   14.75 | 0.76% | 15.01 (+1.76%) | 1.03% |
|      4 |   160 |   31.51 | 0.46% | 31.61 (+0.32%) | 0.47% |
|      8 |   320 |   67.89 | 0.43% | 66.66 (+0.00%) | 0.41% |
+--------+-------+---------+-------+----------------+-------+

2.2.2 Juno r0

+----------------+-----------------+------------------------+
|                | Without patches | With patches           |
+--------+-------+---------+-------+----------------+-------+
| Groups | Tasks | Mean    | RSD*  | Mean           | RSD*  |
+--------+-------+---------+-------+----------------+-------+
|      1 |    40 |    8.23 | 1.14% |  8.24 (+0.12%) | 1.60% |
|      2 |    80 |   15.40 | 0.90% | 15.43 (+1.19%) | 1.23% |
|      4 |   160 |   29.66 | 1.30% | 29.70 (+0.10%) | 0.89% |
|      8 |   320 |   60.07 | 1.93% | 60.14 (+0.12%) | 1.70% |
+--------+-------+---------+-------+----------------+-------+

*RSD: Relative Standard Deviation (std dev / mean)


[1] https://marc.info/?l=linux-pm&m=153243513908731&w=2
[2] https://marc.info/?l=linux-kernel&m=153476300928169&w=2
[3] https://marc.info/?l=linux-kernel&m=153069968022982&w=2
[4] https://marc.info/?l=linux-kernel&m=153209362826476&w=2
[5] https://marc.info/?l=linux-kernel&m=153018606728533&w=2
[6] https://marc.info/?l=linux-kernel&m=152691273111941&w=2
[7] https://marc.info/?l=linux-kernel&m=152302902427143&w=2
[8] https://marc.info/?l=linux-kernel&m=152153905805048&w=2
[9] http://www.linux-arm.org/git?p=linux-qp.git;a=shortlog;h=refs/heads/upstream/eas_v7_04


Morten Rasmussen (1):
  sched: Add over-utilization/tipping point indicator

Quentin Perret (13):
  sched: Relocate arch_scale_cpu_capacity
  sched/cpufreq: Prepare schedutil for Energy Aware Scheduling
  PM: Introduce an Energy Model management framework
  PM / EM: Expose the Energy Model in sysfs
  sched: Introduce a sched_feat for Energy Aware Scheduling
  sched/topology: Reference the Energy Model of CPUs when available
  sched/topology: Lowest CPU asymmetry sched_domain level pointer
  sched/topology: Disable EAS on inappropriate platforms
  sched/fair: Clean-up update_sg_lb_stats parameters
  sched/fair: Introduce an energy estimation helper function
  sched/fair: Select an energy-efficient CPU on task wake-up
  sched/topology: Make Energy Aware Scheduling depend on schedutil
  OPTIONAL: cpufreq: dt: Register an Energy Model

 drivers/cpufreq/cpufreq-dt.c     |  48 ++++-
 drivers/cpufreq/cpufreq.c        |   2 +
 include/linux/energy_model.h     | 187 +++++++++++++++++++
 include/linux/sched/cpufreq.h    |  15 ++
 include/linux/sched/topology.h   |  19 ++
 kernel/power/Kconfig             |  15 ++
 kernel/power/Makefile            |   2 +
 kernel/power/energy_model.c      | 285 +++++++++++++++++++++++++++++
 kernel/sched/cpufreq_schedutil.c | 126 +++++++++----
 kernel/sched/fair.c              | 302 ++++++++++++++++++++++++++++---
 kernel/sched/features.h          |   7 +
 kernel/sched/sched.h             |  64 ++++---
 kernel/sched/topology.c          | 205 ++++++++++++++++++++-
 13 files changed, 1196 insertions(+), 81 deletions(-)
 create mode 100644 include/linux/energy_model.h
 create mode 100644 kernel/power/energy_model.c

-- 
2.18.0

