Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B65C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7A8221534
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:44:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7A8221534
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbeHTM72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 08:59:28 -0400
Received: from foss.arm.com ([217.140.101.70]:34760 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbeHTM71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 08:59:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5634580D;
        Mon, 20 Aug 2018 02:44:33 -0700 (PDT)
Received: from queper01-lin.local (queper01-lin.emea.arm.com [10.4.13.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0FE4B3F2EA;
        Mon, 20 Aug 2018 02:44:28 -0700 (PDT)
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
Subject: [PATCH v6 00/14] Energy Aware Scheduling
Date:   Mon, 20 Aug 2018 10:44:06 +0100
Message-Id: <20180820094420.26590-1-quentin.perret@arm.com>
X-Mailer: git-send-email 2.17.1
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

Changes v5[1]->v6:
- Rebased on Peter’s sched/core branch (that includes Morten's misfit
  patches [2] and the automatic detection of SD_ASYM_CPUCAPACITY [3])
- Removed patch 13/14 (not needed with the automatic flag detection)
- Added patch creating a dependency between sugov and EAS
- Renamed frequency domains to performance domains to avoid creating too
  deep assumptions in the code about the HW
- Renamed the sd_ea shortcut sd_asym_cpucapacity
- Added comment to explain why new tasks are not accounted when
  detecting the 'overutilized' flag
- Added comment explaining why forkees don’t go in
  find_energy_efficient_cpu()

Changes v4[4]->v5:
- Removed the RCU protection of the EM tables and the associated
  need for em_rescale_cpu_capacity().
- Factorized schedutil’s PELT aggregation function with EAS
- Improved comments/doc in the EM framework
- Added check on the uarch of CPUs in one fd in the EM framework
- Reduced CONFIG_ENERGY_MODEL ifdefery in kernel/sched/topology.c
- Cleaned-up update_sg_lb_stats parameters
- Improved comments in compute_energy() to explain the multi-rd
  scenarios

Changes v3[5]->v4:
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

Changes v2[6]->v3:
- Removed the PM_OPP dependency by implementing a new EM framework
- Modified the scheduler topology code to take references on the EM data
  structures
- Simplified the overutilization mechanism into a system-wide flag
- Reworked the integration in the wake-up path using the sd_ea shortcut
- Rebased on tip/sched/core (247f2f6f3c70 "sched/core: Don't schedule
  threads on pre-empted vCPUs")

Changes v1[7]->v2:
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

Base kernel is tip/sched/core (4.18-rc5), with some Hikey960 and Juno
specific patches, the SD_ASYM_CPUCAPACITY flag set at DIE sched domain
level for arm64 and schedutil as cpufreq governor [8].

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
|          | Without patches | With patches            |
+----------+--------+--------+------------------+------+
| Tasks nb |  Mean  | RSD*   | Mean             | RSD* |
+----------+--------+--------+------------------+------+
|       10 |  34.33 |   4.8% |  30.51 (-11.13%) | 6.4% |
|       20 |  52.84 |   1.9% |  44.15 (-16.45%) | 2.0% |
|       30 |  66.20 |   1.8% |  60.14  (-9.15%) | 4.8% |
|       40 |  90.83 |   2.5% |  86.91  (-4.32%) | 2.7% |
|       50 | 136.76 |   4.6% | 108.90 (-20.37%) | 4.7% |
+----------+--------+--------+------------------+------+

2.1.2 Juno r0

Energy is measured with the onboard energy meter. Numbers include
consumption of big and little CPUs.

+----------+-----------------+------------------------+
|          | Without patches | With patches           |
+----------+--------+--------+-----------------+------+
| Tasks nb |  Mean  | RSD*   | Mean            | RSD* |
+----------+--------+--------+-----------------+------+
|       10 |  11.48 |   3.2% |  8.09 (-29.53%) | 3.1% |
|       20 |  20.84 |   3.4% | 14.38 (-31.00%) | 1.1% |
|       30 |  32.94 |   3.2% | 23.97 (-27.23%) | 1.0% |
|       40 |  46.05 |   0.5% | 37.82 (-17.87%) | 6.2% |
|       50 |  57.25 |   0.5% | 55.30 ( -3.41%) | 0.5% |
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
|      1 |    40 |    8.04 | 0.88% |  8.22 (+2.31%) | 1.76% |
|      2 |    80 |   14.78 | 0.67% | 14.83 (+0.35%) | 0.59% |
|      4 |   160 |   30.92 | 0.57% | 30.95 (+0.09%) | 0.51% |
|      8 |   320 |   65.54 | 0.32% | 65.57 (+0.04%) | 0.46% |
+--------+-------+---------+-------+----------------+-------+

2.2.2 Juno r0

+----------------+-----------------+-----------------------+
|                | Without patches | With patches          |
+--------+-------+---------+-------+---------------+-------+
| Groups | Tasks | Mean    | RSD*  | Mean          | RSD*  |
+--------+-------+---------+-------+---------------+-------+
|      1 |    40 |    7.74 | 0.13% |  7.82 (0.01%) | 0.12% |
|      2 |    80 |   14.27 | 0.15% | 14.27 (0.00%) | 0.14% |
|      4 |   160 |   27.07 | 0.35% | 26.96 (0.00%) | 0.18% |
|      8 |   320 |   55.14 | 1.81% | 55.21 (0.00%) | 1.29% |
+--------+-------+---------+-------+---------------+-------+

*RSD: Relative Standard Deviation (std dev / mean)


[1] https://marc.info/?l=linux-pm&m=153243513908731&w=2
[2] https://marc.info/?l=linux-kernel&m=153069968022982&w=2
[3] https://marc.info/?l=linux-kernel&m=153209362826476&w=2
[4] https://marc.info/?l=linux-kernel&m=153018606728533&w=2
[5] https://marc.info/?l=linux-kernel&m=152691273111941&w=2
[6] https://marc.info/?l=linux-kernel&m=152302902427143&w=2
[7] https://marc.info/?l=linux-kernel&m=152153905805048&w=2
[8] http://www.linux-arm.org/git?p=linux-qp.git;a=shortlog;h=refs/heads/upstream/eas_v6

Morten Rasmussen (1):
  sched: Add over-utilization/tipping point indicator

Quentin Perret (13):
  sched: Relocate arch_scale_cpu_capacity
  sched/cpufreq: Factor out utilization to frequency mapping
  PM: Introduce an Energy Model management framework
  PM / EM: Expose the Energy Model in sysfs
  sched/topology: Reference the Energy Model of CPUs when available
  sched/topology: Lowest CPU asymmetry sched_domain level pointer
  sched/topology: Introduce sched_energy_present static key
  sched/fair: Clean-up update_sg_lb_stats parameters
  sched/cpufreq: Refactor the utilization aggregation method
  sched/fair: Introduce an energy estimation helper function
  sched/fair: Select an energy-efficient CPU on task wake-up
  sched/topology: Make Energy Aware Scheduling depend on schedutil
  OPTIONAL: cpufreq: dt: Register an Energy Model

 drivers/cpufreq/cpufreq-dt.c     |  45 ++++-
 drivers/cpufreq/cpufreq.c        |   4 +
 include/linux/cpufreq.h          |   1 +
 include/linux/energy_model.h     | 162 +++++++++++++++++
 include/linux/sched/cpufreq.h    |   6 +
 include/linux/sched/topology.h   |  19 ++
 kernel/power/Kconfig             |  15 ++
 kernel/power/Makefile            |   2 +
 kernel/power/energy_model.c      | 289 +++++++++++++++++++++++++++++
 kernel/sched/cpufreq_schedutil.c | 136 ++++++++++----
 kernel/sched/fair.c              | 301 ++++++++++++++++++++++++++++---
 kernel/sched/sched.h             |  65 ++++---
 kernel/sched/topology.c          | 231 +++++++++++++++++++++++-
 13 files changed, 1195 insertions(+), 81 deletions(-)
 create mode 100644 include/linux/energy_model.h
 create mode 100644 kernel/power/energy_model.c

-- 
2.17.1

