Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D194C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA6DF21473
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:56:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA6DF21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbeLCJ46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 04:56:58 -0500
Received: from foss.arm.com ([217.140.101.70]:60758 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbeLCJ45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 04:56:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 431AA80D;
        Mon,  3 Dec 2018 01:56:38 -0800 (PST)
Received: from queper01-lin.cambridge.arm.com (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 017663F59C;
        Mon,  3 Dec 2018 01:56:33 -0800 (PST)
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
Subject: [PATCH v10 00/15] Energy Aware Scheduling
Date:   Mon,  3 Dec 2018 09:56:13 +0000
Message-Id: <20181203095628.11858-1-quentin.perret@arm.com>
X-Mailer: git-send-email 2.19.2
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

1. Version history
------------------

Changes v9[2]->v10:
- Re-factored schedutil_freq_util() to avoid useless identation (patch 02)
- Moved sched_cpufreq_governor_change() to linux/cpufreq.h (patch 08)
- Reworked the static key enabling code (patch 09)

Changes v8[3]->v9:
- Rebased on latest tip/sched/core (trivial conflict with PSI stuff in
  sched.h)
- Added documentation for the sched_energy_aware sysctl

Changes v7[4]->v8:
- Added kerneldoc to enum schedutil_type (patch 02)
- Added 'max' argument to schedutil_freq_util() (patch 02)
- Added schedutil_energy_util() wrapper (patch 02)
- Added smp_store_release() to the EM loading code (patch 03)
- Renamed 'obj' field of struct perf_domain to 'em_pd' (patch 05)
- Added plain WARN when the EM is too large for EAS (patch 07)
- Added dmesg warning when EAS gets disabled by switching from sugov
  (patch 08)
- Replaced sched_feat(ENERGY_AWARE) by a sysctl + static key (patches 09
  and 10)
- Improved/refactored find_energy_efficient_cpu() and compute_energy()
  for readability (patches 13 and 14)

Changes v6[5]->v7:
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
  patches [6] and the automatic detection of SD_ASYM_CPUCAPACITY [7])
- Removed patch 13/14 (not needed with the automatic flag detection)
- Added patch creating a dependency between sugov and EAS
- Renamed frequency domains to performance domains to avoid creating too
  deep assumptions in the code about the HW
- Renamed the sd_ea shortcut sd_asym_cpucapacity
- Added comment to explain why new tasks are not accounted when
  detecting the 'overutilized' flag
- Added comment explaining why forkees don’t go in
  find_energy_efficient_cpu()

Changes v4[8]->v5:
- Removed the RCU protection of the EM tables and the associated
  need for em_rescale_cpu_capacity().
- Factorized schedutil’s PELT aggregation function with EAS
- Improved comments/doc in the EM framework
- Added check on the uarch of CPUs in one fd in the EM framework
- Reduced CONFIG_ENERGY_MODEL ifdefery in kernel/sched/topology.c
- Cleaned-up update_sg_lb_stats parameters
- Improved comments in compute_energy() to explain the multi-rd
  scenarios

Changes v3[9]->v4:
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

Changes v2[10]->v3:
- Removed the PM_OPP dependency by implementing a new EM framework
- Modified the scheduler topology code to take references on the EM data
  structures
- Simplified the overutilization mechanism into a system-wide flag
- Reworked the integration in the wake-up path using the sd_ea shortcut
- Rebased on tip/sched/core (247f2f6f3c70 "sched/core: Don't schedule
  threads on pre-empted vCPUs")

Changes v1[11]->v2:
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

Base kernel is tip/sched/core (based on 4.19), with some Hikey960 and
Juno specific patches. Test branch: [12].


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
|       10 |  32.55 |   1.59 |  28.91 (-11.20%) | 1.59 |
|       20 |  53.39 |   0.91 |  42.58 (-20.25%) | 0.60 |
|       30 |  66.16 |   2.73 |  60.30  (-8.86%) | 3.84 |
|       40 |  90.70 |   3.63 |  81.42 (-10.23%) | 3.76 |
|       50 | 132.07 |   7.37 | 108.18 (-18.09%) | 7.43 |
+----------+-----------------+-------------------------+

2.1.2 Juno r0

Energy is measured with the onboard energy meter. Numbers include
consumption of big and little CPUs.

+----------+-----------------+-------------------------+
|          | Without patches | With patches            |
+----------+--------+--------+------------------+------+
| Tasks nb |  Mean  | RSD*   | Mean             | RSD* |
+----------+--------+--------+------------------+------+
|       10 |   8.96 |   0.35 |   6.54 (-27.00%) | 0.38 |
|       20 |  16.79 |   0.90 |  13.66 (-18.66%) | 0.94 |
|       30 |  28.60 |   2.71 |  21.06 (-26.37%) | 0.98 |
|       40 |  41.21 |   1.95 |  31.20 (-24.30%) | 2.80 |
|       50 |  53.69 |   1.21 |  49.29  (-8.20%) | 1.39 |
+----------+-----------------+-------------------------+


2.2 Performance test case

30 iterations of perf bench sched messaging --pipe --thread --group G
--loop L with G=[1 2 4 8] and L=50000 (Hikey960)/16000 (Juno r0).

2.2.1 Hikey960

The impact of thermal capping was mitigated thanks to a heatsink, a
fan, and a 30 sec delay between two successive executions. IPA is
disabled to reduce the stddev.

+----------------+-----------------+-----------------------+
|                | Without patches | With patches          |
+--------+-------+---------+-------+----------------+------+
| Groups | Tasks | Mean    | RSD*  | Mean           | RSD* |
+--------+-------+---------+-------+----------------+------+
|      1 |    40 |    8.32 |  0.09 |  8.45 (+1.64%) | 0.10 |
|      2 |    80 |   15.16 |  0.07 | 15.32 (+1.04%) | 0.08 |
|      4 |   160 |   31.29 |  0.20 | 31.64 (+1.12%) | 0.19 |
|      8 |   320 |   66.25 |  0.28 | 66.69 (+0.67%) | 0.33 |
+--------+-------+---------+-------+----------------+------+

2.2.2 Juno r0

+----------------+-----------------+-----------------------+
|                | Without patches | With patches          |
+--------+-------+---------+-------+----------------+------+
| Groups | Tasks | Mean    | RSD*  | Mean           | RSD* |
+--------+-------+---------+-------+----------------+------+
|      1 |    40 |    8.38 |  0.09 |  8.50 (+1.41%) | 0.11 |
|      2 |    80 |   15.32 |  0.10 | 15.67 (+2.31%) | 0.20 |
|      4 |   160 |   29.12 |  0.20 | 29.65 (+1.82%) | 0.14 |
|      8 |   320 |   58.42 |  0.26 | 59.81 (+2.38%) | 0.37 |
+--------+-------+---------+-------+----------------+------+


*RSD: Relative Standard Deviation (std dev / mean)


[1]  https://marc.info/?l=linux-kernel&m=153243513908731&w=2 (V5)
[2]  https://marc.info/?l=linux-kernel&m=154269969931689&w=2 (V9)
[3]  https://marc.info/?l=linux-kernel&m=153968492908835&w=2 (V8)
[4]  https://marc.info/?l=linux-kernel&m=153674360525432&w=2 (V7)
[5]  https://marc.info/?l=linux-kernel&m=153476300928169&w=2 (V6)
[6]  https://marc.info/?l=linux-kernel&m=153069968022982&w=2 (Misfit)
[7]  https://marc.info/?l=linux-kernel&m=153209362826476&w=2 (SD_ASYM_CPUCAPACITY)
[8]  https://marc.info/?l=linux-kernel&m=153018606728533&w=2 (V4)
[9]  https://marc.info/?l=linux-kernel&m=152691273111941&w=2 (V3)
[10] https://marc.info/?l=linux-kernel&m=152302902427143&w=2 (V2)
[11] https://marc.info/?l=linux-kernel&m=152153905805048&w=2 (V1)
[12] http://www.linux-arm.org/git?p=linux-qp.git;a=shortlog;h=refs/heads/upstream/eas_v10


Morten Rasmussen (1):
  sched: Add over-utilization/tipping point indicator

Quentin Perret (14):
  sched: Relocate arch_scale_cpu_capacity
  sched/cpufreq: Prepare schedutil for Energy Aware Scheduling
  PM: Introduce an Energy Model management framework
  PM / EM: Expose the Energy Model in sysfs
  sched/topology: Reference the Energy Model of CPUs when available
  sched/topology: Lowest CPU asymmetry sched_domain level pointer
  sched/topology: Disable EAS on inappropriate platforms
  sched/topology: Make Energy Aware Scheduling depend on schedutil
  sched: Introduce sched_energy_present static key
  sched: Introduce a sysctl for Energy Aware Scheduling
  sched/fair: Clean-up update_sg_lb_stats parameters
  sched/fair: Introduce an energy estimation helper function
  sched/fair: Select an energy-efficient CPU on task wake-up
  OPTIONAL: cpufreq: dt: Register an Energy Model

 Documentation/sysctl/kernel.txt  |  12 ++
 drivers/cpufreq/cpufreq-dt.c     |  48 ++++-
 drivers/cpufreq/cpufreq.c        |   1 +
 include/linux/cpufreq.h          |   8 +
 include/linux/energy_model.h     | 189 +++++++++++++++++++
 include/linux/sched/cpufreq.h    |   6 +
 include/linux/sched/sysctl.h     |   7 +
 include/linux/sched/topology.h   |  19 ++
 kernel/power/Kconfig             |  15 ++
 kernel/power/Makefile            |   2 +
 kernel/power/energy_model.c      | 291 +++++++++++++++++++++++++++++
 kernel/sched/cpufreq_schedutil.c |  90 +++++++--
 kernel/sched/fair.c              | 305 +++++++++++++++++++++++++++++--
 kernel/sched/sched.h             |  84 ++++++---
 kernel/sched/topology.c          | 258 +++++++++++++++++++++++++-
 kernel/sysctl.c                  |  11 ++
 16 files changed, 1280 insertions(+), 66 deletions(-)
 create mode 100644 include/linux/energy_model.h
 create mode 100644 kernel/power/energy_model.c

-- 
2.19.2

