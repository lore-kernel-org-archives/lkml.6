Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752198AbeBFOls (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 09:41:48 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38194 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751396AbeBFOll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 09:41:41 -0500
From: Patrick Bellasi <patrick.bellasi@arm.com>
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>,
        Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>
Subject: [PATCH v4 0/3] Utilization estimation (util_est) for FAIR tasks
Date: Tue,  6 Feb 2018 14:41:28 +0000
Message-Id: <20180206144131.31233-1-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a respin of [1], still based on today's tip/sche/core [2], which
includes Juri's series [3] to integrate SCHED_DEADLINE into schedutil.

Thanks to everyone who provided feedback, all of them have been addressed.

Testing on Intel and ARM (Android) devices confirms the negligible overheads
and the power/performance benefits reported in the previous posting [1].

Changes in v4:
 - rebased on today's tip/sched/core (commit 460e8c3340a2)
 - renamed util_est's "last" into "enqueued"
 - using util_est's "enqueued" for both se and cfs_rqs (Joel)
 - update margin check to use more ASM friendly code (Peter)
 - optimize EWMA updates (Peter)
 - ensure cpu_util_wake() is cpu_capacity_orig()'s clamped (Pavan)
 - simplify cpu_util_cfs() integration (Dietmar)

Changes in v3:
 - rebased on today's tip/sched/core (commit 07881166a892)
 - moved util_est into sched_avg (Peter)
 - use {READ,WRITE}_ONCE() for EWMA updates (Peter)
 - using unsigned int to fit all sched_avg into a single 64B cache line
 - schedutil integration using Juri's cpu_util_cfs()
 - first patch dropped since it's already queued in tip/sched/core

Changes in v2:
 - rebased on top of v4.15-rc2
 - tested that overhauled PELT code does not affect the util_est

Cheers Patrick

.:: References
==============
[1] https://lkml.org/lkml/2018/1/23/645
    20180123180847.4477-1-patrick.bellasi@arm.com
[2] git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
    sched/core (commit 460e8c3340a2)
[3] https://lkml.org/lkml/2017/12/4/173
    20171204102325.5110-1-juri.lelli@redhat.com


Patrick Bellasi (3):
  sched/fair: add util_est on top of PELT
  sched/fair: use util_est in LB and WU paths
  sched/cpufreq_schedutil: use util_est for OPP selection

 include/linux/sched.h   |  16 +++++
 kernel/sched/debug.c    |   4 ++
 kernel/sched/fair.c     | 179 ++++++++++++++++++++++++++++++++++++++++++++++--
 kernel/sched/features.h |   5 ++
 kernel/sched/sched.h    |   7 +-
 5 files changed, 204 insertions(+), 7 deletions(-)

-- 
2.15.1
