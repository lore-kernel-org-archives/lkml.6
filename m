Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935696AbeBLNlQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 08:41:16 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51162 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935671AbeBLNk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 08:40:57 -0500
X-Google-Smtp-Source: AH8x226UHJuvCEOYAZ9H5k1uYetJSdPc4+wXcxNh7iwhhJcXC3cSia1fM6OlvPzaczdQ0sByK8t6Kw==
From: Juri Lelli <juri.lelli@redhat.com>
To: peterz@infradead.org, mingo@redhat.com
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        luca.abeni@santannapisa.it, claudio@evidence.eu.com,
        tommaso.cucinotta@santannapisa.it, bristot@redhat.com,
        mathieu.poirier@linaro.org, tkjos@android.com, joelaf@google.com,
        morten.rasmussen@arm.com, dietmar.eggemann@arm.com,
        patrick.bellasi@arm.com, alessio.balsini@arm.com,
        juri.lelli@redhat.com, Tejun Heo <tj@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [RFC PATCH 3/3] Documentation/scheduler/sched-deadline: add info about cgroup support
Date: Mon, 12 Feb 2018 14:40:30 +0100
Message-Id: <20180212134030.12846-4-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180212134030.12846-1-juri.lelli@redhat.com>
References: <20180212134030.12846-1-juri.lelli@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for SCHED_DEADLINE cgroup support (CONFIG_DEADLINE_
GROUP_SCHED config option).

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Luca Abeni <luca.abeni@santannapisa.it>
Cc: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org
---
 Documentation/scheduler/sched-deadline.txt | 36 ++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/Documentation/scheduler/sched-deadline.txt b/Documentation/scheduler/sched-deadline.txt
index 8ce78f82ae23..65d55c778976 100644
--- a/Documentation/scheduler/sched-deadline.txt
+++ b/Documentation/scheduler/sched-deadline.txt
@@ -528,11 +528,8 @@ CONTENTS
  to -deadline tasks is similar to the one already used for -rt
  tasks with real-time group scheduling (a.k.a. RT-throttling - see
  Documentation/scheduler/sched-rt-group.txt), and is based on readable/
- writable control files located in procfs (for system wide settings).
- Notice that per-group settings (controlled through cgroupfs) are still not
- defined for -deadline tasks, because more discussion is needed in order to
- figure out how we want to manage SCHED_DEADLINE bandwidth at the task group
- level.
+ writable control files located in procfs (for system wide settings) and in
+ cgroupfs (per-group settings).
 
  A main difference between deadline bandwidth management and RT-throttling
  is that -deadline tasks have bandwidth on their own (while -rt ones don't!),
@@ -553,9 +550,9 @@ CONTENTS
  For now the -rt knobs are used for -deadline admission control and the
  -deadline runtime is accounted against the -rt runtime. We realize that this
  isn't entirely desirable; however, it is better to have a small interface for
- now, and be able to change it easily later. The ideal situation (see 5.) is to
- run -rt tasks from a -deadline server; in which case the -rt bandwidth is a
- direct subset of dl_bw.
+ now, and be able to change it easily later. The ideal situation (see 6.) is to
+ run -rt tasks from a -deadline server (H-CBS); in which case the -rt bandwidth
+ is a direct subset of dl_bw.
 
  This means that, for a root_domain comprising M CPUs, -deadline tasks
  can be created while the sum of their bandwidths stays below:
@@ -623,6 +620,27 @@ CONTENTS
  make the leftoever runtime available for reclamation by other
  SCHED_DEADLINE tasks.
 
+4.4 Grouping tasks
+------------------
+
+CONFIG_DEADLINE_GROUP_SCHED depends on CONFIG_RT_GROUP_SCHED, so go on and
+read Documentation/scheduler/sched-rt-group.txt first.
+
+Enabling CONFIG_DEADLINE_GROUP_SCHED lets you explicitly manage CPU bandwidth
+for task groups.
+
+This uses the cgroup virtual file system and "<cgroup>/cpu.rt_runtime_us
+<cgroup>/cpu.rt_period_us" to control the CPU time reserved for each control
+group. Yes, they are the same of CONFIG_RT_GROUP_SCHED since RT and DEADLINE
+share the same bandwidth. In addition to these CONFIG_DEADLINE_GROUP_SCHED
+adds "<cgroup>/cpu.dl_bw" (maximum bandwidth on each CPU available to the
+group, corresponds to cpu.rt_runtime_us/cpu.rt_period_us) and
+"<cgroup>/cpu.dl_total_bw" (a group's current allocated bandwidth); both are
+non-writable.
+
+Group settings are checked against same limits of CONFIG_RT_GROUP_SCHED:
+
+   \Sum_{i} runtime_{i} / global_period <= global_runtime / global_period
 
 5. Tasks CPU affinity
 =====================
@@ -661,7 +679,7 @@ CONTENTS
     of retaining bandwidth isolation among non-interacting tasks. This is
     being studied from both theoretical and practical points of view, and
     hopefully we should be able to produce some demonstrative code soon;
-  - (c)group based bandwidth management, and maybe scheduling;
+  - (c)group based scheduling (Hierachical-CBS);
   - access control for non-root users (and related security concerns to
     address), which is the best way to allow unprivileged use of the mechanisms
     and how to prevent non-root users "cheat" the system?
-- 
2.14.3
