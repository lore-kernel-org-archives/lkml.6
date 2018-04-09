Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753731AbeDIQvp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 12:51:45 -0400
Received: from foss.arm.com ([217.140.101.70]:58432 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753691AbeDIQvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 12:51:41 -0400
From: Patrick Bellasi <patrick.bellasi@arm.com>
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Jonathan Corbet <corbet@lwn.net>, Paul Turner <pjt@google.com>,
        linux-doc@vger.kernel.org
Subject: [PATCH] sched/fair: add support to tune PELT ramp/decay timings
Date: Mon,  9 Apr 2018 17:51:34 +0100
Message-Id: <20180409165134.707-1-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PELT half-life is the time [ms] required by the PELT signal to build
up a 50% load/utilization, starting from zero. This time is currently
hardcoded to be 32ms, a value which seems to make sense for most of the
workloads.

However, 32ms has been verified to be too long for certain classes of
workloads. For example, in the mobile space many tasks affecting the
user-experience run with a 16ms or 8ms cadence, since they need to match
the common 60Hz or 120Hz refresh rate of the graphics pipeline.
This contributed so fare to the idea that "PELT is too slow" to properly
track the utilization of interactive mobile workloads, especially
compared to alternative load tracking solutions which provides a
better representation of tasks demand in the range of 10-20ms.

A faster PELT ramp-up time could give some advantages to speed-up the
time required for the signal to stabilize and thus to better represent
task demands in the mobile space. As a downside, it also reduces the
decay time, and thus we forget the load/utilization of sleeping tasks
(or idle CPUs) faster.

Fortunately, since the integration of the utilization estimation
support in mainline kernel:

   commit 7f65ea42eb00 ("sched/fair: Add util_est on top of PELT")

a fast decay time is no longer an issue for tasks utilization estimation.
Although estimated utilization does not slow down the decay of blocked
utilization on idle CPUs, for mobile workloads this seems not to be a
major concern compared to the benefits in interactivity responsiveness.

Let's add a compile time option to choose the PELT speed which better
fits for a specific system. By default the current 32ms half-life is
used, but we can also compile a kernel to use a faster ramp-up time of
either 16ms or 8ms. These two configurations have been verified to give
PELT a further improvement in performance, compared to other out-of-tree
load tracking solutions, when it comes to track interactive workloads
thus better supporting both tasks placements and frequencies selections.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Paul Turner <pjt@google.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 Documentation/scheduler/sched-pelt.c | 45 ++++++++++++++++++++++--------------
 init/Kconfig                         | 44 +++++++++++++++++++++++++++++++++++
 kernel/sched/sched-pelt.h            | 39 ++++++++++++++++++++++++++-----
 3 files changed, 105 insertions(+), 23 deletions(-)

diff --git a/Documentation/scheduler/sched-pelt.c b/Documentation/scheduler/sched-pelt.c
index e4219139386a..e0ae21616188 100644
--- a/Documentation/scheduler/sched-pelt.c
+++ b/Documentation/scheduler/sched-pelt.c
@@ -10,34 +10,35 @@
 #include <math.h>
 #include <stdio.h>
 
-#define HALFLIFE 32
+#define HALFLIFE { 32, 16, 8 }
 #define SHIFT 32
 
 double y;
 
-void calc_runnable_avg_yN_inv(void)
+void calc_runnable_avg_yN_inv(const int halflife)
 {
 	int i;
 	unsigned int x;
 
 	printf("static const u32 runnable_avg_yN_inv[] = {");
-	for (i = 0; i < HALFLIFE; i++) {
+	for (i = 0; i < halflife; i++) {
 		x = ((1UL<<32)-1)*pow(y, i);
 
-		if (i % 6 == 0) printf("\n\t");
-		printf("0x%8x, ", x);
+		if (i % 4 == 0)
+			printf("\n\t");
+		printf("0x%8x,", x);
 	}
 	printf("\n};\n\n");
 }
 
 int sum = 1024;
 
-void calc_runnable_avg_yN_sum(void)
+void calc_runnable_avg_yN_sum(const int halflife)
 {
 	int i;
 
 	printf("static const u32 runnable_avg_yN_sum[] = {\n\t    0,");
-	for (i = 1; i <= HALFLIFE; i++) {
+	for (i = 1; i <= halflife; i++) {
 		if (i == 1)
 			sum *= y;
 		else
@@ -55,7 +56,7 @@ int n = -1;
 /* first period */
 long max = 1024;
 
-void calc_converged_max(void)
+void calc_converged_max(const int halflife)
 {
 	long last = 0, y_inv = ((1UL<<32)-1)*y;
 
@@ -73,17 +74,17 @@ void calc_converged_max(void)
 		last = max;
 	}
 	n--;
-	printf("#define LOAD_AVG_PERIOD %d\n", HALFLIFE);
+	printf("#define LOAD_AVG_PERIOD %d\n", halflife);
 	printf("#define LOAD_AVG_MAX %ld\n", max);
-//	printf("#define LOAD_AVG_MAX_N %d\n\n", n);
+	/* printf("#define LOAD_AVG_MAX_N %d\n\n", n); */
 }
 
-void calc_accumulated_sum_32(void)
+void calc_accumulated_sum_32(const int halflife)
 {
 	int i, x = sum;
 
 	printf("static const u32 __accumulated_sum_N32[] = {\n\t     0,");
-	for (i = 1; i <= n/HALFLIFE+1; i++) {
+	for (i = 1; i <= n / halflife + 1; i++) {
 		if (i > 1)
 			x = x/2 + sum;
 
@@ -97,12 +98,22 @@ void calc_accumulated_sum_32(void)
 
 void main(void)
 {
+	int hl_value[] = HALFLIFE;
+	int hl_count = sizeof(hl_value) / sizeof(int);
+	int hl_idx, halflife;
+
 	printf("/* Generated by Documentation/scheduler/sched-pelt; do not modify. */\n\n");
 
-	y = pow(0.5, 1/(double)HALFLIFE);
+	for (hl_idx = 0; hl_idx < hl_count; ++hl_idx) {
+		halflife = hl_value[hl_idx];
 
-	calc_runnable_avg_yN_inv();
-//	calc_runnable_avg_yN_sum();
-	calc_converged_max();
-//	calc_accumulated_sum_32();
+		y = pow(0.5, 1 / (double)halflife);
+
+		printf("\n#ifdef CONFIG_PELT_HALFLIFE_%d\n", halflife);
+		calc_runnable_avg_yN_inv(halflife);
+		/* calc_runnable_avg_yN_sum(halflife); */
+		calc_converged_max(halflife);
+		/* calc_accumulated_sum_32(halflife); */
+		printf("#endif\n");
+	}
 }
diff --git a/init/Kconfig b/init/Kconfig
index e37f4b2a6445..6fd13887d2bf 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -585,6 +585,50 @@ config HAVE_UNSTABLE_SCHED_CLOCK
 config GENERIC_SCHED_CLOCK
 	bool
 
+menu "Scheduler features"
+
+choice
+	bool "Configure PELT speed for load/utilization tracking"
+	default PELT_HALFLIFE_32
+	help
+	  Allows to choose one of the possible values for the PELT half-life to
+	  be used for the update of the load and utilization of tasks and CPUs.
+	  The half-life is the amount of [ms] required by the PELT signal to
+	  build up to 50% load/utilization.
+	  The higher the half-life the longer it takes for a task to be
+	  represented as a big one.
+
+	  If not sure, use the default of 32 ms.
+
+config PELT_HALFLIFE_32
+	bool "32 ms, default"
+	help
+	  A 32ms PELT half-life is the default value usually suitable for
+	  server/enterprise class of workloads where tasks can normally
+	  runs for tens or hundreds of milliseconds.
+
+	  If not sure, use this option
+
+config PELT_HALFLIFE_16
+	bool "16 ms, faster"
+	help
+	  A 16ms PELT half-life is suggested for mobile/interactive workloads
+	  where tasks usually run with a 60Hz activation cadence.
+
+	  If not sure, use the default of 32 ms
+
+config PELT_HALFLIFE_8
+	bool "8 ms, very fast"
+	help
+	  An 8ms PELT half-life is suggested for mobile/interactive workloads
+	  where tasks usually run with a 120Hz activation cadence.
+
+	  If not sure, use the default of 32 ms
+
+endchoice
+
+endmenu # Scheduler features"
+
 #
 # For architectures that want to enable the support for NUMA-affine scheduler
 # balancing logic:
diff --git a/kernel/sched/sched-pelt.h b/kernel/sched/sched-pelt.h
index a26473674fb7..c978fe03f788 100644
--- a/kernel/sched/sched-pelt.h
+++ b/kernel/sched/sched-pelt.h
@@ -1,14 +1,41 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Generated by Documentation/scheduler/sched-pelt; do not modify. */
 
+#ifdef CONFIG_PELT_HALFLIFE_32
 static const u32 runnable_avg_yN_inv[] = {
-	0xffffffff, 0xfa83b2da, 0xf5257d14, 0xefe4b99a, 0xeac0c6e6, 0xe5b906e6,
-	0xe0ccdeeb, 0xdbfbb796, 0xd744fcc9, 0xd2a81d91, 0xce248c14, 0xc9b9bd85,
-	0xc5672a10, 0xc12c4cc9, 0xbd08a39e, 0xb8fbaf46, 0xb504f333, 0xb123f581,
-	0xad583ee9, 0xa9a15ab4, 0xa5fed6a9, 0xa2704302, 0x9ef5325f, 0x9b8d39b9,
-	0x9837f050, 0x94f4efa8, 0x91c3d373, 0x8ea4398a, 0x8b95c1e3, 0x88980e80,
-	0x85aac367, 0x82cd8698,
+	0xffffffff, 0xfa83b2da, 0xf5257d14, 0xefe4b99a, 
+	0xeac0c6e6, 0xe5b906e6, 0xe0ccdeeb, 0xdbfbb796, 
+	0xd744fcc9, 0xd2a81d91, 0xce248c14, 0xc9b9bd85, 
+	0xc5672a10, 0xc12c4cc9, 0xbd08a39e, 0xb8fbaf46, 
+	0xb504f333, 0xb123f581, 0xad583ee9, 0xa9a15ab4, 
+	0xa5fed6a9, 0xa2704302, 0x9ef5325f, 0x9b8d39b9, 
+	0x9837f050, 0x94f4efa8, 0x91c3d373, 0x8ea4398a, 
+	0x8b95c1e3, 0x88980e80, 0x85aac367, 0x82cd8698, 
 };
 
 #define LOAD_AVG_PERIOD 32
 #define LOAD_AVG_MAX 47742
+#endif
+
+#ifdef CONFIG_PELT_HALFLIFE_16
+static const u32 runnable_avg_yN_inv[] = {
+	0xffffffff, 0xf5257d14, 0xeac0c6e6, 0xe0ccdeeb, 
+	0xd744fcc9, 0xce248c14, 0xc5672a10, 0xbd08a39e, 
+	0xb504f333, 0xad583ee9, 0xa5fed6a9, 0x9ef5325f, 
+	0x9837f050, 0x91c3d373, 0x8b95c1e3, 0x85aac367, 
+};
+
+#define LOAD_AVG_PERIOD 16
+#define LOAD_AVG_MAX 24152
+#endif
+
+#ifdef CONFIG_PELT_HALFLIFE_8
+static const u32 runnable_avg_yN_inv[] = {
+	0xffffffff, 0xeac0c6e6, 0xd744fcc9, 0xc5672a10, 
+	0xb504f333, 0xa5fed6a9, 0x9837f050, 0x8b95c1e3, 
+};
+
+#define LOAD_AVG_PERIOD 8
+#define LOAD_AVG_MAX 12337
+#endif
+
-- 
2.15.1
