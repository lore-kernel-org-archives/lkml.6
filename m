Return-Path: <dietmar.eggemann@arm.com>
X-Google-Smtp-Source: AIpwx4/Nw/q66581j4k2NRSgEhN7Yl8+WFHysV1Mlv61Lgy+NQDOHbAyruo6lnnpsuABrUHrkbl0
ARC-Seal: i=1; a=rsa-sha256; t=1523029017; cv=none;
        d=google.com; s=arc-20160816;
        b=AqwKLwTZ06EWO6hsvDZ8inxf6T+4rZ8+0I6AOt2DGKhTXfA6kKTrmHKnDEiU27XITN
         SXYFLmFlCm3krOWVudkhIKtnWCl1OVLuFC+nXhEWyfXechAtASKGVO8cyZHonRDwZwsO
         6raWqxGMCMOkkq9hMwf3CP5jF7VgdglmleP9zxvKUCVrKzw9ruZ6ZmWSgYfSt38XslBI
         k3SqNiHOJlubojXtDpvhFPnzT8d1BJN4H0LbDkPD6KcS5x1CBzCRUjxoVO02n9aZQGPB
         9wsCmILsTdQLy/0K+G6Ri/UDY1hB7UDB/Q5Y/rO7iTmXUCIbcHjCYUO3qefSN23LH0wj
         tlwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:arc-authentication-results;
        bh=QAewBfJDfOjOgW0Z2VkzNZPYzvkt6VgqPOaFMeQ+gos=;
        b=J/DbhZtk4kIQDmyudMSbgQFWolxBoBel2o/+bMcYwA2p+E3taz978TZ1Uua2O6Zfft
         d8OPbAdzvhozkshe5YQ3WbHwxh5eJLvGd/0YxO77VqnNRtQltCek0qI+885SXUmDoXdv
         JNRTR5GBs6B7z61PjLx6x8VqSsoqFnS1mydTA6MIQTozEqh3VvcuRzggH3Y7XPuAv7+o
         LVhVia9tLfug2hqakLgfj9zYWdwfZU8plcCUAR/CdHh64FJ1Qwr9L6G4qImbMZixqcs5
         n3hnwiyEbin0KZx0R2b7gG+OfMy5wgdYi902fKq9CB+BA6FhD9MzvjcQWw3mf5G6e6C3
         sIgg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of dietmar.eggemann@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=dietmar.eggemann@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of dietmar.eggemann@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=dietmar.eggemann@arm.com
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
To: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Quentin Perret <quentin.perret@arm.com>,
	Thara Gopinath <thara.gopinath@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Morten Rasmussen <morten.rasmussen@arm.com>,
	Chris Redpath <chris.redpath@arm.com>,
	Patrick Bellasi <patrick.bellasi@arm.com>,
	Valentin Schneider <valentin.schneider@arm.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Todd Kjos <tkjos@google.com>,
	Joel Fernandes <joelaf@google.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steve Muckle <smuckle@google.com>,
	Eduardo Valentin <edubezval@gmail.com>
Subject: [RFC PATCH v2 0/6] Energy Aware Scheduling
Date: Fri,  6 Apr 2018 16:36:01 +0100
Message-Id: <20180406153607.17815-1-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597011674695258054?=
X-GMAIL-MSGID: =?utf-8?q?1597011674695258054?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

1. Overview

The Energy Aware Scheduler (EAS) based on Morten Rasmussen's posting on
LKML [1] is currently part of the AOSP Common Kernel and runs on
today's smartphones with Arm's big.LITTLE CPUs.
Based on the experience gained over the last two and a half years in
product development, we propose an energy model based task placement
for CPUs with asymmetric core capacities (e.g. Arm big.LITTLE or
DynamIQ), to align with the EAS adopted by the AOSP Common Kernel. We
have developed a simplified energy model, based on the physical
active power/performance curve of each core type using existing
SoC power/performance data already known to the kernel. The energy
model is used to select the most energy-efficient CPU to place each
task, taking utilization into account.

1.1 Energy Model

A CPU with asymmetric core capacities features cores with significantly
different energy and performance characteristics. As the configurations
can vary greatly from one SoC to another, designing an energy-efficient
scheduling heuristic that performs well on a broad spectrum of platforms
appears to be particularly hard.
This proposal attempts to solve this issue by providing the scheduler
with an energy model of the platform which enables energy impact
estimation of scheduling decisions in a generic way. The energy model is
kept very simple as it represents only the active power of CPUs at all
available P-states and relies on existing data in the kernel (only used
by the thermal subsystem so far).
This proposal does not include the power consumption of C-states and
cluster-level resources which were originally introduced in [1] since
firstly, their impact on task placement decisions appears to be
neglectable on modern asymmetric platforms and secondly, they require
additional infrastructure and data (e.g new DT entries).
The scheduler is also informed of the span of frequency domains, hence
enabling an accurate accounting of the energy costs of frequency
changes. This appears to be especially important for future Arm CPU
topologies (DynamIQ) where the span of scheduling domains can be
different from the span of frequency domains.

1.2 Overutilization/Tipping Point

The primary job for the task scheduler is to deliver the highest
possible throughput with minimal latency. With increasing utilization
the opportunities to save energy for the scheduler become rarer. There
must be spare CPU time available to place tasks based on utilization
in an energy-aware fashion, i.e. to pack tasks on energy-efficient CPUs
with unnecessary constraining of the task throughput. This spare CPU
time decreases towards zero when the utilization of the system rises.  
To cope with this situation, we introduce the concept of overutilization
in order to enable/disable EAS depending on system utilization.
The point in which a system switches from being not overutilized to
being overutilized or vice versa is called the tipping point. A per
sched domain tipping point indicator implementation is introduced here.

1.3 Wakeup path

On a system which has an energy model, the energy-aware wakeup path
trumps affine and capacity based wake up in case the lowest sched
domain of the task's previous CPU is not overutilized. The energy-aware
algorithm tries to find a new target CPU among the CPUs of the highest
non-overutilized domain which includes previous and current CPU, for
which the placement of the task would contribute a minimum on energy
consumption. The energy model is only enabled on CPUs with asymmetric
core capacities (SD_ASYM_CPUCAPACITY). These systems typically have
less than or equal 8 cores.

2. Tests

Two fundamentally different tests were executed. Firstly the energy
test case shows the impact on energy consumption this patch-set has
using a synthetic set of tasks. Secondly the performance test case
provides the conventional hackbench metric numbers.

The tests run on two arm64 big.LITTLE platforms: Hikey960 (4xA73 +
4xA53) and Juno r0 (2xA57 + 4xA53).

Base kernel is tip/sched/core (4.16-rc6), with some Hikey960 and
Juno specific patches, the SD_ASYM_CPUCAPACITY flag set at DIE sched
domain level for arm64 and schedutil as cpufreq governor [2].

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
|       10 |  41.14 |  1.4%  |  36.51 (-11.25%) | 1.6% |
|       20 |  55.95 |  0.8%  |  50.14 (-10.38%) | 1.9% |
|       30 |  74.37 |  0.2%  |  72.89 ( -1.99%) | 5.3% |
|       40 |  94.12 |  0.7%  |  87.78 ( -6.74%) | 4.5% |
|       50 | 117.88 |  0.2%  | 111.66 ( -5.28%) | 0.9% |
+----------+--------+-------+-----------------+--------+

2.1.2 Juno r0

Energy is measured with the onboard energy meter. Numbers include
consumption of big and little CPUs.

+----------+-----------------+-------------------------+
|          | Without patches | With patches            |
+----------+--------+--------+------------------+------+
| Tasks nb | Mean   | RSD*   | Mean             | RSD* |
+----------+--------+--------+------------------+------+
|       10 |  11.25 |  3.1%  |   7.07 (-37.16%) | 2.1% |
|       20 |  19.18 |  1.1%  |  12.75 (-33.52%) | 2.2% |
|       30 |  28.81 |  1.9%  |  21.29 (-26.10%) | 1.5% |
|       40 |  36.83 |  1.2%  |  30.72 (-16.59%) | 0.6% |
|       50 |  46.41 |  0.6%  |  46.02 ( -0.01%) | 0.5% |
+----------+--------+--------+------------------+------+

2.2 Performance test case

30 iterations of perf bench sched messaging --pipe --thread --group G
--loop L with G=[1 2 4 8] and L=50000 (Hikey960)/16000 (Juno r0).

2.2.1 Hikey960

The impact of thermal capping was mitigated thanks to a heatsink, a
fan, and a 10 sec delay between two successive executions.

+----------------+-----------------+-------------------------+
|                | Without patches | With patches            |
+--------+-------+---------+-------+-----------------+-------+
| Groups | Tasks | Mean    | RSD*  | Mean            | RSD*  |
+--------+-------+---------+-------+-----------------+-------+
|      1 |    40 |    8.58 | 0.81% | 10.34 (+21.24%) | 4.35% |
|      2 |    80 |   15.33 | 0.79% | 15.56 (+1.51%)  | 1.04% |
|      4 |   160 |   31.75 | 0.52% | 31.85 (+0.29%)  | 0.54% |
|      8 |   320 |   67.00 | 0.36% | 66.79 (-0.30%)  | 0.43% |
+--------+-------+---------+-------+-----------------+-------+

2.2.2 Juno r0

+----------------+-----------------+-------------------------+
|                | Without patches | With patches            |
+--------+-------+---------+-------+-----------------+-------+
| Groups | Tasks | Mean    | RSD*  | Mean            | RSD*  |
+--------+-------+---------+-------+-----------------+-------+
|      1 |    40 |    8.44 | 0.12% |  8.39 (-0.01%)  | 0.10% |
|      2 |    80 |   14.65 | 0.11% | 14.73 ( 0.01%)  | 0.12% |
|      4 |   160 |   27.34 | 0.14% | 27.47 ( 0.00%)  | 0.14% |
|      8 |   320 |   53.88 | 0.25% | 54.34 ( 0.01%)  | 0.30% |
+--------+-------+---------+-------+-----------------+-------+

*RSD: Relative Standard Deviation (std dev / mean)

3. Dependencies

This series depends on additional infrastructure being merged in the
OPP core. As this infrastructure can also be useful for other clients,
the related patches have been posted separately [3].

4. Changes between versions

Changes v1[4]->v2:

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

[1] https://lkml.org/lkml/2015/7/7/754
[2] http://www.linux-arm.org/git?p=linux-de.git;a=shortlog;h=refs/heads/upstream/eas_v2_base
[3] https://marc.info/?l=linux-pm&m=151635516419249&w=2
[4] https://marc.info/?l=linux-pm&m=152153905805048&w=2

Dietmar Eggemann (1):
  sched/fair: Create util_fits_capacity()

Quentin Perret (4):
  sched: Introduce energy models of CPUs
  sched/fair: Introduce an energy estimation helper function
  sched/fair: Select an energy-efficient CPU on task wake-up
  drivers: base: arch_topology.c: Enable EAS for arm/arm64 platforms

Thara Gopinath (1):
  sched: Add over-utilization/tipping point indicator

 drivers/base/arch_topology.c   |   2 +
 include/linux/sched/energy.h   |  69 ++++++++++++
 include/linux/sched/topology.h |   1 +
 kernel/sched/Makefile          |   3 +
 kernel/sched/energy.c          | 184 ++++++++++++++++++++++++++++++++
 kernel/sched/fair.c            | 234 +++++++++++++++++++++++++++++++++++++++--
 kernel/sched/sched.h           |   3 +-
 kernel/sched/topology.c        |  12 +--
 8 files changed, 491 insertions(+), 17 deletions(-)
 create mode 100644 include/linux/sched/energy.h
 create mode 100644 kernel/sched/energy.c

-- 
2.11.0
