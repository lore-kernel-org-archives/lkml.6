Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753034AbeA3SaY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 13:30:24 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:39968 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751870AbeA3SaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 13:30:22 -0500
X-Google-Smtp-Source: AH8x227oWCSG7MFOH4cuecZCc0+lgD3i0RJC9gpw6f1nzJA/307miJXaswOEhxCRKyqwJpXjlLIDqw==
From: Leo Yan <leo.yan@linaro.org>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, eas-dev@lists.linaro.org
Cc: Leo Yan <leo.yan@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] samples/bpf: Add program for CPU state statistics
Date: Wed, 31 Jan 2018 02:29:59 +0800
Message-Id: <1517336999-5731-1-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPU is active when have running tasks on it and CPUFreq governor can
select different operating points (OPP) according to different workload;
we use 'pstate' to present CPU state which have running tasks with one
specific OPP.  On the other hand, CPU is idle which only idle task on
it, CPUIdle governor can select one specific idle state to power off
hardware logics; we use 'cstate' to present CPU idle state.

Based on trace events 'cpu_idle' and 'cpu_frequency' we can accomplish
the duration statistics for every state.  Every time when CPU enters
into or exits from idle states, the trace event 'cpu_idle' is recorded;
trace event 'cpu_frequency' records the event for CPU OPP changing, so
it's easily to know how long time the CPU stays in the specified OPP,
and the CPU must be not in any idle state.

This patch is to utilize the mentioned trace events for pstate and
cstate statistics.  To achieve more accurate profiling data, the program
uses below sequence to insure CPU running/idle time aren't missed:

- Before profiling the user space program wakes up all CPUs for once, so
  can avoid to missing account time for CPU staying in idle state for
  long time; the program forces to set 'scaling_max_freq' to lowest
  frequency and then restore 'scaling_max_freq' to highest frequency,
  this can ensure the frequency to be set to lowest frequency and later
  after start to run workload the frequency can be easily to be changed
  to higher frequency;

- User space program reads map data and update statistics for every 5s,
  so this is same with other sample bpf programs for avoiding big
  overload introduced by bpf program self;

- When send signal to terminate program, the signal handler wakes up
  all CPUs, set lowest frequency and restore highest frequency to
  'scaling_max_freq'; this is exactly same with the first step so
  avoid to missing account CPU pstate and cstate time during last
  stage.  Finally it reports the latest statistics.

The program has been tested on Hikey board with octa CA53 CPUs, below
is the example for statistics result:

CPU 0
State    : Duration(ms)  Distribution
cstate 0 : 47555        |*********************************       |
cstate 1 : 0            |                                        |
cstate 2 : 0            |                                        |
pstate 0 : 15239        |*********                               |
pstate 1 : 1521         |                                        |
pstate 2 : 3188         |*                                       |
pstate 3 : 1836         |                                        |
pstate 4 : 94           |                                        |

CPU 1
State    : Duration(ms)  Distribution
cstate 0 : 87           |                                        |
cstate 1 : 16264        |**********                              |
cstate 2 : 50458        |***********************************     |
pstate 0 : 832          |                                        |
pstate 1 : 131          |                                        |
pstate 2 : 825          |                                        |
pstate 3 : 787          |                                        |
pstate 4 : 4            |                                        |

CPU 2
State    : Duration(ms)  Distribution
cstate 0 : 177          |                                        |
cstate 1 : 9363         |*****                                   |
cstate 2 : 55835        |*************************************** |
pstate 0 : 1468         |                                        |
pstate 1 : 350          |                                        |
pstate 2 : 1062         |                                        |
pstate 3 : 1164         |                                        |
pstate 4 : 7            |                                        |

CPU 3
State    : Duration(ms)  Distribution
cstate 0 : 89           |                                        |
cstate 1 : 14546        |*********                               |
cstate 2 : 51591        |***********************************     |
pstate 0 : 907          |                                        |
pstate 1 : 231          |                                        |
pstate 2 : 894          |                                        |
pstate 3 : 1154         |                                        |
pstate 4 : 17           |                                        |

CPU 4
State    : Duration(ms)  Distribution
cstate 0 : 101          |                                        |
cstate 1 : 16904        |***********                             |
cstate 2 : 49544        |**********************************      |
pstate 0 : 678          |                                        |
pstate 1 : 230          |                                        |
pstate 2 : 770          |                                        |
pstate 3 : 1065         |                                        |
pstate 4 : 8            |                                        |

CPU 5
State    : Duration(ms)  Distribution
cstate 0 : 95           |                                        |
cstate 1 : 18377        |************                            |
cstate 2 : 47609        |*********************************       |
pstate 0 : 1165         |                                        |
pstate 1 : 243          |                                        |
pstate 2 : 818          |                                        |
pstate 3 : 1007         |                                        |
pstate 4 : 9            |                                        |

CPU 6
State    : Duration(ms)  Distribution
cstate 0 : 102          |                                        |
cstate 1 : 16629        |**********                              |
cstate 2 : 49335        |**********************************      |
pstate 0 : 836          |                                        |
pstate 1 : 253          |                                        |
pstate 2 : 895          |                                        |
pstate 3 : 1275         |                                        |
pstate 4 : 6            |                                        |

CPU 7
State    : Duration(ms)  Distribution
cstate 0 : 88           |                                        |
cstate 1 : 16070        |**********                              |
cstate 2 : 50279        |***********************************     |
pstate 0 : 948          |                                        |
pstate 1 : 214          |                                        |
pstate 2 : 873          |                                        |
pstate 3 : 952          |                                        |
pstate 4 : 0            |                                        |

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 samples/bpf/Makefile       |   4 +
 samples/bpf/cpustat_kern.c | 281 +++++++++++++++++++++++++++++++++++++++++++++
 samples/bpf/cpustat_user.c | 234 +++++++++++++++++++++++++++++++++++++
 3 files changed, 519 insertions(+)
 create mode 100644 samples/bpf/cpustat_kern.c
 create mode 100644 samples/bpf/cpustat_user.c

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index adeaa13..e5d747f 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -41,6 +41,7 @@ hostprogs-y += xdp_redirect_map
 hostprogs-y += xdp_redirect_cpu
 hostprogs-y += xdp_monitor
 hostprogs-y += syscall_tp
+hostprogs-y += cpustat
 
 # Libbpf dependencies
 LIBBPF := ../../tools/lib/bpf/bpf.o
@@ -89,6 +90,7 @@ xdp_redirect_map-objs := bpf_load.o $(LIBBPF) xdp_redirect_map_user.o
 xdp_redirect_cpu-objs := bpf_load.o $(LIBBPF) xdp_redirect_cpu_user.o
 xdp_monitor-objs := bpf_load.o $(LIBBPF) xdp_monitor_user.o
 syscall_tp-objs := bpf_load.o $(LIBBPF) syscall_tp_user.o
+cpustat-objs := bpf_load.o $(LIBBPF) cpustat_user.o
 
 # Tell kbuild to always build the programs
 always := $(hostprogs-y)
@@ -137,6 +139,7 @@ always += xdp_redirect_map_kern.o
 always += xdp_redirect_cpu_kern.o
 always += xdp_monitor_kern.o
 always += syscall_tp_kern.o
+always += cpustat_kern.o
 
 HOSTCFLAGS += -I$(objtree)/usr/include
 HOSTCFLAGS += -I$(srctree)/tools/lib/
@@ -179,6 +182,7 @@ HOSTLOADLIBES_xdp_redirect_map += -lelf
 HOSTLOADLIBES_xdp_redirect_cpu += -lelf
 HOSTLOADLIBES_xdp_monitor += -lelf
 HOSTLOADLIBES_syscall_tp += -lelf
+HOSTLOADLIBES_cpustat += -lelf
 
 # Allows pointing LLC/CLANG to a LLVM backend with bpf support, redefine on cmdline:
 #  make samples/bpf/ LLC=~/git/llvm/build/bin/llc CLANG=~/git/llvm/build/bin/clang
diff --git a/samples/bpf/cpustat_kern.c b/samples/bpf/cpustat_kern.c
new file mode 100644
index 0000000..68c84da
--- /dev/null
+++ b/samples/bpf/cpustat_kern.c
@@ -0,0 +1,281 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/version.h>
+#include <linux/ptrace.h>
+#include <uapi/linux/bpf.h>
+#include "bpf_helpers.h"
+
+/*
+ * The CPU number, cstate number and pstate number are based
+ * on 96boards Hikey with octa CA53 CPUs.
+ *
+ * Every CPU have three idle states for cstate:
+ *   WFI, CPU_OFF, CLUSTER_OFF
+ *
+ * Every CPU have 5 operating points:
+ *   208MHz, 432MHz, 729MHz, 960MHz, 1200MHz
+ *
+ * This code is based on these assumption and other platforms
+ * need to adjust these definitions.
+ */
+#define MAX_CPU			8
+#define MAX_PSTATE_ENTRIES	5
+#define MAX_CSTATE_ENTRIES	3
+
+static int cpu_opps[] = { 208000, 432000, 729000, 960000, 1200000 };
+
+/*
+ * my_map structure is used to record cstate and pstate index and
+ * timestamp (Idx, Ts), when new event incoming we need to update
+ * combination for new state index and timestamp (Idx`, Ts`).
+ *
+ * Based on (Idx, Ts) and (Idx`, Ts`) we can calculate the time
+ * interval for the previous state: Duration(Idx) = Ts` - Ts.
+ *
+ * Every CPU has one below array for recording state index and
+ * timestamp, and record for cstate and pstate saperately:
+ *
+ * +--------------------------+
+ * | cstate timestamp         |
+ * +--------------------------+
+ * | cstate index             |
+ * +--------------------------+
+ * | pstate timestamp         |
+ * +--------------------------+
+ * | pstate index             |
+ * +--------------------------+
+ */
+#define MAP_OFF_CSTATE_TIME	0
+#define MAP_OFF_CSTATE_IDX	1
+#define MAP_OFF_PSTATE_TIME	2
+#define MAP_OFF_PSTATE_IDX	3
+#define MAP_OFF_NUM		4
+
+struct bpf_map_def SEC("maps") my_map = {
+	.type = BPF_MAP_TYPE_ARRAY,
+	.key_size = sizeof(u32),
+	.value_size = sizeof(u64),
+	.max_entries = MAX_CPU * MAP_OFF_NUM,
+};
+
+/* cstate_duration records duration time for every idle state per CPU */
+struct bpf_map_def SEC("maps") cstate_duration = {
+	.type = BPF_MAP_TYPE_ARRAY,
+	.key_size = sizeof(u32),
+	.value_size = sizeof(u64),
+	.max_entries = MAX_CPU * MAX_CSTATE_ENTRIES,
+};
+
+/* pstate_duration records duration time for every operating point per CPU */
+struct bpf_map_def SEC("maps") pstate_duration = {
+	.type = BPF_MAP_TYPE_ARRAY,
+	.key_size = sizeof(u32),
+	.value_size = sizeof(u64),
+	.max_entries = MAX_CPU * MAX_PSTATE_ENTRIES,
+};
+
+/*
+ * The trace events for cpu_idle and cpu_frequency are taken from:
+ * /sys/kernel/debug/tracing/events/power/cpu_idle/format
+ * /sys/kernel/debug/tracing/events/power/cpu_frequency/format
+ *
+ * These two events have same format, so define one common structure.
+ */
+struct cpu_args {
+	u64 pad;
+	u32 state;
+	u32 cpu_id;
+};
+
+/* calculate pstate index, returns MAX_PSTATE_ENTRIES for failure */
+static u32 find_cpu_pstate_idx(u32 frequency)
+{
+	u32 i;
+
+	for (i = 0; i < sizeof(cpu_opps) / sizeof(u32); i++) {
+		if (frequency == cpu_opps[i])
+			return i;
+	}
+
+	return i;
+}
+
+SEC("tracepoint/power/cpu_idle")
+int bpf_prog1(struct cpu_args *ctx)
+{
+	u64 *cts, *pts, *cstate, *pstate, prev_state, cur_ts, delta;
+	u32 key, cpu, pstate_idx;
+	u64 *val;
+
+	if (ctx->cpu_id > MAX_CPU)
+		return 0;
+
+	cpu = ctx->cpu_id;
+
+	key = cpu * MAP_OFF_NUM + MAP_OFF_CSTATE_TIME;
+	cts = bpf_map_lookup_elem(&my_map, &key);
+	if (!cts)
+		return 0;
+
+	key = cpu * MAP_OFF_NUM + MAP_OFF_CSTATE_IDX;
+	cstate = bpf_map_lookup_elem(&my_map, &key);
+	if (!cstate)
+		return 0;
+
+	key = cpu * MAP_OFF_NUM + MAP_OFF_PSTATE_TIME;
+	pts = bpf_map_lookup_elem(&my_map, &key);
+	if (!pts)
+		return 0;
+
+	key = cpu * MAP_OFF_NUM + MAP_OFF_PSTATE_IDX;
+	pstate = bpf_map_lookup_elem(&my_map, &key);
+	if (!pstate)
+		return 0;
+
+	prev_state = *cstate;
+	*cstate = ctx->state;
+
+	if (!*cts) {
+		*cts = bpf_ktime_get_ns();
+		return 0;
+	}
+
+	cur_ts = bpf_ktime_get_ns();
+	delta = cur_ts - *cts;
+	*cts = cur_ts;
+
+	/*
+	 * When state doesn't equal to (u32)-1, the cpu will enter
+	 * one idle state; for this case we need to record interval
+	 * for the pstate.
+	 *
+	 *                 OPP2
+	 *            +---------------------+
+	 *     OPP1   |                     |
+	 *   ---------+                     |
+	 *                                  |  Idle state
+	 *                                  +---------------
+	 *
+	 *            |<- pstate duration ->|
+	 *            ^                     ^
+	 *           pts                  cur_ts
+	 */
+	if (ctx->state != (u32)-1) {
+
+		/* record pstate after have first cpu_frequency event */
+		if (!*pts)
+			return 0;
+
+		delta = cur_ts - *pts;
+
+		pstate_idx = find_cpu_pstate_idx(*pstate);
+		if (pstate_idx >= MAX_PSTATE_ENTRIES)
+			return 0;
+
+		key = cpu * MAX_PSTATE_ENTRIES + pstate_idx;
+		val = bpf_map_lookup_elem(&pstate_duration, &key);
+		if (val)
+			__sync_fetch_and_add((long *)val, delta);
+
+	/*
+	 * When state equal to (u32)-1, the cpu just exits from one
+	 * specific idle state; for this case we need to record
+	 * interval for the pstate.
+	 *
+	 *       OPP2
+	 *   -----------+
+	 *              |                          OPP1
+	 *              |                     +-----------
+	 *              |     Idle state      |
+	 *              +---------------------+
+	 *
+	 *              |<- cstate duration ->|
+	 *              ^                     ^
+	 *             cts                  cur_ts
+	 */
+	} else {
+
+		key = cpu * MAX_CSTATE_ENTRIES + prev_state;
+		val = bpf_map_lookup_elem(&cstate_duration, &key);
+		if (val)
+			__sync_fetch_and_add((long *)val, delta);
+	}
+
+	/* Update timestamp for pstate as new start time */
+	if (*pts)
+		*pts = cur_ts;
+
+	return 0;
+}
+
+SEC("tracepoint/power/cpu_frequency")
+int bpf_prog2(struct cpu_args *ctx)
+{
+	u64 *pts, *cstate, *pstate, prev_state, cur_ts, delta;
+	u32 key, cpu, pstate_idx;
+	u64 *val;
+
+	cpu = ctx->cpu_id;
+
+	key = cpu * MAP_OFF_NUM + MAP_OFF_PSTATE_TIME;
+	pts = bpf_map_lookup_elem(&my_map, &key);
+	if (!pts)
+		return 0;
+
+	key = cpu * MAP_OFF_NUM + MAP_OFF_PSTATE_IDX;
+	pstate = bpf_map_lookup_elem(&my_map, &key);
+	if (!pstate)
+		return 0;
+
+	key = cpu * MAP_OFF_NUM + MAP_OFF_CSTATE_IDX;
+	cstate = bpf_map_lookup_elem(&my_map, &key);
+	if (!cstate)
+		return 0;
+
+	prev_state = *pstate;
+	*pstate = ctx->state;
+
+	if (!*pts) {
+		*pts = bpf_ktime_get_ns();
+		return 0;
+	}
+
+	cur_ts = bpf_ktime_get_ns();
+	delta = cur_ts - *pts;
+	*pts = cur_ts;
+
+	/* When CPU is in idle, bail out to skip pstate statistics */
+	if (*cstate != (u32)(-1))
+		return 0;
+
+	/*
+	 * The cpu changes to another different OPP (in below diagram
+	 * change frequency from OPP3 to OPP1), need recording interval
+	 * for previous frequency OPP3 and update timestamp as start
+	 * time for new frequency OPP1.
+	 *
+	 *                 OPP3
+	 *            +---------------------+
+	 *     OPP2   |                     |
+	 *   ---------+                     |
+	 *                                  |    OPP1
+	 *                                  +---------------
+	 *
+	 *            |<- pstate duration ->|
+	 *            ^                     ^
+	 *           pts                  cur_ts
+	 */
+	pstate_idx = find_cpu_pstate_idx(*pstate);
+	if (pstate_idx >= MAX_PSTATE_ENTRIES)
+		return 0;
+
+	key = cpu * MAX_PSTATE_ENTRIES + pstate_idx;
+	val = bpf_map_lookup_elem(&pstate_duration, &key);
+	if (val)
+		__sync_fetch_and_add((long *)val, delta);
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
+u32 _version SEC("version") = LINUX_VERSION_CODE;
diff --git a/samples/bpf/cpustat_user.c b/samples/bpf/cpustat_user.c
new file mode 100644
index 0000000..e497f85
--- /dev/null
+++ b/samples/bpf/cpustat_user.c
@@ -0,0 +1,234 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <signal.h>
+#include <sched.h>
+#include <string.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <linux/bpf.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/time.h>
+#include <sys/resource.h>
+#include <sys/wait.h>
+
+#include "libbpf.h"
+#include "bpf_load.h"
+
+#define MAX_CPU			8
+#define MAX_PSTATE_ENTRIES	5
+#define MAX_CSTATE_ENTRIES	3
+#define MAX_STARS		40
+
+#define CPUFREQ_MAX_SYSFS_PATH	"/sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq"
+#define CPUFREQ_LOWEST_FREQ	"208000"
+#define CPUFREQ_HIGHEST_FREQ	"12000000"
+
+struct cpu_hist {
+	unsigned long cstate[MAX_CSTATE_ENTRIES];
+	unsigned long pstate[MAX_PSTATE_ENTRIES];
+};
+
+static struct cpu_hist cpu_hist[MAX_CPU];
+static unsigned long max_data;
+
+static void stars(char *str, long val, long max, int width)
+{
+	int i;
+
+	for (i = 0; i < (width * val / max) - 1 && i < width - 1; i++)
+		str[i] = '*';
+	if (val > max)
+		str[i - 1] = '+';
+	str[i] = '\0';
+}
+
+static void print_hist(void)
+{
+	char starstr[MAX_STARS];
+	struct cpu_hist *hist;
+	int i, j;
+
+	/* ignore without data */
+	if (max_data == 0)
+		return;
+
+	/* clear screen */
+	printf("\033[2J");
+
+	for (j = 0; j < MAX_CPU; j++) {
+		hist = &cpu_hist[j];
+
+		printf("CPU %d\n", j);
+		printf("State    : Duration(ms)  Distribution\n");
+		for (i = 0; i < MAX_CSTATE_ENTRIES; i++) {
+			stars(starstr, hist->cstate[i], max_data, MAX_STARS);
+			printf("cstate %d : %-8ld     |%-*s|\n", i,
+				hist->cstate[i] / 1000000, MAX_STARS, starstr);
+		}
+
+		for (i = 0; i < MAX_PSTATE_ENTRIES; i++) {
+			stars(starstr, hist->pstate[i], max_data, MAX_STARS);
+			printf("pstate %d : %-8ld     |%-*s|\n", i,
+				hist->pstate[i] / 1000000, MAX_STARS, starstr);
+		}
+
+		printf("\n");
+	}
+}
+
+static void get_data(int cstate_fd, int pstate_fd)
+{
+	unsigned long key, value;
+	int c, i;
+
+	max_data = 0;
+
+	for (c = 0; c < MAX_CPU; c++) {
+		for (i = 0; i < MAX_CSTATE_ENTRIES; i++) {
+			key = c * MAX_CSTATE_ENTRIES + i;
+			bpf_map_lookup_elem(cstate_fd, &key, &value);
+			cpu_hist[c].cstate[i] = value;
+
+			if (value > max_data)
+				max_data = value;
+		}
+
+		for (i = 0; i < MAX_PSTATE_ENTRIES; i++) {
+			key = c * MAX_PSTATE_ENTRIES + i;
+			bpf_map_lookup_elem(pstate_fd, &key, &value);
+			cpu_hist[c].pstate[i] = value;
+
+			if (value > max_data)
+				max_data = value;
+		}
+	}
+}
+
+/*
+ * This function is copied from function idlestat_wake_all()
+ * in idlestate.c, it set the self task affinity to cpus
+ * one by one so can wake up the CPU to handle the scheduling;
+ * as result all cpus can be waken up once and produce trace
+ * event 'cpu_idle'.
+ */
+static int cpu_stat_inject_cpu_idle_event(void)
+{
+	int rcpu, i, ret;
+	cpu_set_t cpumask;
+	cpu_set_t original_cpumask;
+
+	ret = sysconf(_SC_NPROCESSORS_CONF);
+	if (ret < 0)
+		return -1;
+
+	rcpu = sched_getcpu();
+	if (rcpu < 0)
+		return -1;
+
+	/* Keep track of the CPUs we will run on */
+	sched_getaffinity(0, sizeof(original_cpumask), &original_cpumask);
+
+	for (i = 0; i < ret; i++) {
+
+		/* Pointless to wake up ourself */
+		if (i == rcpu)
+			continue;
+
+		/* Pointless to wake CPUs we will not run on */
+		if (!CPU_ISSET(i, &original_cpumask))
+			continue;
+
+		CPU_ZERO(&cpumask);
+		CPU_SET(i, &cpumask);
+
+		sched_setaffinity(0, sizeof(cpumask), &cpumask);
+	}
+
+	/* Enable all the CPUs of the original mask */
+	sched_setaffinity(0, sizeof(original_cpumask), &original_cpumask);
+	return 0;
+}
+
+/*
+ * It's possible to have long time have no any frequency change
+ * and cannot get trace event 'cpu_frequency' for long time, this
+ * can introduce big deviation for pstate statistics.
+ *
+ * To solve this issue, we can force to set 'scaling_max_freq' to
+ * trigger trace event 'cpu_frequency' and then we can recovery
+ * back the maximum frequency value.  For this purpose, below
+ * firstly set highest frequency to 208MHz and then recovery to
+ * 1200MHz again.
+ */
+static int cpu_stat_inject_cpu_frequency_event(void)
+{
+	int len, fd;
+
+	fd = open(CPUFREQ_MAX_SYSFS_PATH, O_WRONLY);
+	if (fd < 0) {
+		printf("failed to open scaling_max_freq, errno=%d\n", errno);
+		return fd;
+	}
+
+	len = write(fd, CPUFREQ_LOWEST_FREQ, strlen(CPUFREQ_LOWEST_FREQ));
+	if (len < 0) {
+		printf("failed to open scaling_max_freq, errno=%d\n", errno);
+		goto err;
+	}
+
+	len = write(fd, CPUFREQ_HIGHEST_FREQ, strlen(CPUFREQ_HIGHEST_FREQ));
+	if (len < 0) {
+		printf("failed to open scaling_max_freq, errno=%d\n", errno);
+		goto err;
+	}
+
+err:
+	close(fd);
+	return len;
+}
+
+static void int_exit(int sig)
+{
+	cpu_stat_inject_cpu_idle_event();
+	cpu_stat_inject_cpu_frequency_event();
+	get_data(map_fd[1], map_fd[2]);
+	print_hist();
+	exit(0);
+}
+
+int main(int argc, char **argv)
+{
+	char filename[256];
+	int ret;
+
+	snprintf(filename, sizeof(filename), "%s_kern.o", argv[0]);
+
+	if (load_bpf_file(filename)) {
+		printf("%s", bpf_log_buf);
+		return 1;
+	}
+
+	ret = cpu_stat_inject_cpu_idle_event();
+	if (ret < 0)
+		return 1;
+
+	ret = cpu_stat_inject_cpu_frequency_event();
+	if (ret < 0)
+		return 1;
+
+	signal(SIGINT, int_exit);
+	signal(SIGTERM, int_exit);
+
+	while (1) {
+		get_data(map_fd[1], map_fd[2]);
+		print_hist();
+		sleep(5);
+	}
+
+	return 0;
+}
-- 
2.7.4
