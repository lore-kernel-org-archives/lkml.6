Return-Path: <dietmar.eggemann@arm.com>
X-Google-Smtp-Source: AG47ELtQX23RsRRq0IBfc+su0TyLKOGOeEnIr/GyrRkJ8+m3COjJUGIhMAwahA4ixRPxOpfPko+L
ARC-Seal: i=1; a=rsa-sha256; t=1521539047; cv=none;
        d=google.com; s=arc-20160816;
        b=JHVoZWS2A5LGPSUynn5iXYgE75F/uq1BbX0qF1EAXhcGTVg7yPhTvghRdNuuR2P0nL
         sL4ipcJJNgC7r6hJnHWrljGl8BjKWmm5mw/Sw+WGHpNT/lPMUCFpUtVF6dyUxAaUjn+6
         QmGrVMCa9eGhev8EGKA6fNtqHMcQlM/vgDMwhxiq5mPhuWX29GZdtYShQlaYJ7q+EBX/
         uch+WtsWd4lQk1yndmSDAHQx6vhUoGRyjswAmVPfsAqI+6dvdWSJRinLtQshvy/ckYTw
         mwDQ9IJPkXBOxe8FSvGw29RW8SDdkLjpXZwKrdwkxbRMgW+7v0jkUymzkku17n+Bo7Mi
         By1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=ClwWW8GvXiPTDI97AyxX90Z1e+0HrKGX2Vdlz1boagE=;
        b=W6damQd85KfMWkqb0g6u8B84vz30BFX1JCYWA0W6B6QhG8MkWIX+JVKJwUf7GKxe55
         1GfYVRzBHy8FaHSAM8bsQJ4jwdmvRM6POsopQA7jwc7WN0rpNNkYV/aaUAQou2/KWuY4
         RctzGs+wb76PAe/ZRLFnGc6t6zjC7JgC3MTgraZm/4vkjblYMlvBvichTtb3+sJ/zXQI
         eYlxewOReB0BX8CgzyVF1NvecQmYCccDhcZtZLX0jiwLGtu+PGzjwmmVohU/F2ZGcV/X
         KTUvKldcU+8UH7tzswxGEQdafQZrdAz7ythCAlCKihn/vTY6khpWdF5dw88IkdMSxIVT
         j1Lw==
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
	Joel Fernandes <joelaf@google.com>
Subject: [RFC PATCH 0/6] Energy Aware Scheduling
Date: Tue, 20 Mar 2018 09:43:06 +0000
Message-Id: <20180320094312.24081-1-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.11.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595449328218141298?=
X-GMAIL-MSGID: =?utf-8?q?1595449328218141298?=
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
active power/performance curve of each core type using existing SoC
power/performance data already known to the kernel. The energy model
is used to select the most energy-efficient CPU to place each task,
taking utilization into account.

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
neglectible on modern asymmetric platforms and secondly, they require
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

Base kernel is tip/sched/core (4.16-rc4), with some Hikey960 and
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

+----------+-----------------+------------------------+
|          | Without patches | With patches           |
+----------+---------+-------+-----------------+------+ 
| Tasks nb | Mean   | RSD*   | Mean            | RSD* |
+----------+---------+-------+-----------------+------+
|       10 |   41.50 |  1.1% |  37.43 (-9.81%) | 2.0% |
|       20 |   55.51 |  0.7% |  50.74 (-8.59%) | 1.5% |
|       30 |   75.39 |  0.4% |  70.36 (-6.67%) | 7.3% |
|       40 |   95.82 |  0.3% |  89.90 (-6.18%) | 1.5% |
|       50 |  121.53 |  0.9% | 112.61 (-7.34%) | 0.9% |
+----------+---------+-------+-----------------+------+

2.1.2 Juno r0

Energy is measured with the onboard energy meter. Numbers include
consumption of big and little CPUs.

+----------+-----------------+------------------------+
|          | Without patches | With patches           |
+----------+--------+--------+-----------------+------+
| Tasks nb | Mean   | RSD*   | Mean            | RSD* |
+----------+--------+--------+-----------------+------+
|       10 |  11.52 |  1.1%  |  7.67 (-33.42%) | 2.8% |
|       20 |  19.25 |  0.9%  | 13.39 (-30.44%) | 1.8% |
|       30 |  28.73 |  1.3%  | 21.85 (-31.49%) | 0.6% |
|       40 |  37.58 |  0.9%  | 31.40 (-16.44%) | 0.4% |
|       50 |  47.24 |  0.6%  | 45.37 ( -3.96%) | 0.6% |
+----------+--------+--------+-----------------+------+

2.2 Performance test case

30 iterations of perf bench sched messaging --pipe --thread --group G
--loop L with G=[1 2 4 8] and L=50000 (Hikey960)/16000 (Juno r0).

2.2.1 Hikey960

The impact of thermal capping was mitigated thanks to a heatsink, a
fan, and a 10 sec delay between two successive executions.

+----------------+-----------------+------------------------+
|                | Without patches | With patches           |
+--------+-------+---------+-------+----------------+-------+
| Groups | Tasks | Mean    | RSD*  | Mean           | RSD*  |
+--------+-------+---------+-------+----------------+-------+
|      1 |    40 |    8.01 | 1.70% |  8.16 (+1.90%) | 1.79% |
|      2 |    80 |   15.59 | 0.76% | 15.79 (+1.33%) | 0.92% |
|      4 |   160 |   32.23 | 0.70% | 32.46 (+0.72%) | 0.55% |
|      8 |   320 |   66.93 | 0.46% | 67.40 (+0.69%) | 0.37% |
+--------+-------+---------+-------+----------------+-------+

2.2.2 Juno r0

+----------------+-----------------+------------------------+
|                | Without patches | With patches           |
+--------+-------+---------+-------+----------------+-------+
| Groups | Tasks | Mean    | RSD*  | Mean           | RSD*  |
+--------+-------+---------+-------+----------------+-------+
|      1 |    40 |    8.37 | 0.12% |  8.33 ( 0.00%) | 0.08% |
|      2 |    80 |   14.63 | 0.12% | 14.49 (-0.01%) | 0.14% |
|      4 |   160 |   27.17 | 0.14% | 26.80 (-0.01%) | 0.14% |
|      8 |   320 |   52.50 | 0.25% | 51.54 (-0.02%) | 0.23% |
+--------+-------+---------+-------+----------------+-------+

*RSD: Relative Standard Deviation (std dev / mean)

3. Dependencies

This series depends on additional infrastructure being merged in the
OPP core. As this infrastructure can also be useful for other clients,
the related patches have been posted separately [3].

[1] https://lkml.org/lkml/2015/7/7/754
[2] http://www.linux-arm.org/git?p=linux-de.git;a=shortlog;h=refs/heads/upstream/eas_v1_base
[3] https://marc.info/?l=linux-pm&m=151635516419249&w=2

Dietmar Eggemang (1):
  sched/fair: Create util_fits_capacity()

Quentin Perret (4):
  sched: Introduce energy models of CPUs
  sched/fair: Introduce an energy estimation helper function
  sched/fair: Select an energy-efficient CPU on task wake-up
  drivers: base: arch_topology.c: Enable EAS for arm/arm64 platforms

Thara Gopinath (1):
  sched: Add over-utilization/tipping point indicator

 drivers/base/arch_topology.c   |   2 +
 include/linux/sched/energy.h   |  31 ++++++
 include/linux/sched/topology.h |   1 +
 kernel/sched/Makefile          |   2 +-
 kernel/sched/energy.c          | 190 ++++++++++++++++++++++++++++++++++
 kernel/sched/fair.c            | 226 +++++++++++++++++++++++++++++++++++++++--
 kernel/sched/sched.h           |   1 +
 kernel/sched/topology.c        |  12 +--
 8 files changed, 449 insertions(+), 16 deletions(-)
 create mode 100644 include/linux/sched/energy.h
 create mode 100644 kernel/sched/energy.c

-- 
2.11.0
