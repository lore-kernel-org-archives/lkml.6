Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751982AbeCIIlR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 03:41:17 -0500
Received: from terminus.zytor.com ([198.137.202.136]:44981 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751242AbeCIIlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 03:41:14 -0500
Date: Fri, 9 Mar 2018 00:40:01 -0800
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-t126jh4occqvu0xdqlcjygex@git.kernel.org>
Cc: alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
        ravi.bangoria@linux.vnet.ibm.com, acme@redhat.com, jolsa@kernel.org,
        namhyung@kernel.org, tglx@linutronix.de, brueckner@linux.vnet.ibm.com,
        wangnan0@huawei.com, mingo@kernel.org, dsahern@gmail.com,
        hpa@zytor.com, tmricht@linux.vnet.ibm.com, eranian@google.com,
        linux-kernel@vger.kernel.org
Reply-To: acme@redhat.com, jolsa@kernel.org, ravi.bangoria@linux.vnet.ibm.com,
        adrian.hunter@intel.com, alexander.shishkin@linux.intel.com,
        linux-kernel@vger.kernel.org, eranian@google.com,
        tmricht@linux.vnet.ibm.com, hpa@zytor.com, dsahern@gmail.com,
        mingo@kernel.org, wangnan0@huawei.com, tglx@linutronix.de,
        brueckner@linux.vnet.ibm.com, namhyung@kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: Support setting cgroups as targets
Git-Commit-ID: 9ea42ba4411ac502e83baa9c61bb037d0a7355a0
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  9ea42ba4411ac502e83baa9c61bb037d0a7355a0
Gitweb:     https://git.kernel.org/tip/9ea42ba4411ac502e83baa9c61bb037d0a7355a0
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 6 Mar 2018 16:30:51 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 7 Mar 2018 10:22:26 -0300

perf trace: Support setting cgroups as targets

One can set a cgroup as a default cgroup to be used by all events or
set cgroups with the 'perf stat' and 'perf record' behaviour, i.e.
'-G A' will be the cgroup for events defined so far in the command line.

Here in my main machine, with a kvm instance running a rhel6 guinea pig
I have:

  # ls -la /sys/fs/cgroup/perf_event/ | grep drw
  drwxr-xr-x. 14 root root 360 Mar  6 12:04 ..
  drwxr-xr-x.  3 root root   0 Mar  6 15:05 machine.slice
  #

So I can go ahead and use that cgroup hierarchy, say lets see what
syscalls are being emitted by threads in that 'machine.slice' hierarchy
that are taking more than 100ms:

  # perf trace --duration 100 -G machine.slice
     0.188 (249.850 ms): CPU 0/KVM/23744 ioctl(fd: 16<anon_inode:kvm-vcpu:0>, cmd: KVM_RUN) = 0
   250.274 (249.743 ms): CPU 0/KVM/23744 ioctl(fd: 16<anon_inode:kvm-vcpu:0>, cmd: KVM_RUN) = 0
   500.224 (249.755 ms): CPU 0/KVM/23744 ioctl(fd: 16<anon_inode:kvm-vcpu:0>, cmd: KVM_RUN) = 0
   750.097 (249.934 ms): CPU 0/KVM/23744 ioctl(fd: 16<anon_inode:kvm-vcpu:0>, cmd: KVM_RUN) = 0
  1000.244 (249.780 ms): CPU 0/KVM/23744 ioctl(fd: 16<anon_inode:kvm-vcpu:0>, cmd: KVM_RUN) = 0
  1250.197 (249.796 ms): CPU 0/KVM/23744 ioctl(fd: 16<anon_inode:kvm-vcpu:0>, cmd: KVM_RUN) = 0
  1500.124 (249.859 ms): CPU 0/KVM/23744 ioctl(fd: 16<anon_inode:kvm-vcpu:0>, cmd: KVM_RUN) = 0
  1750.076 (172.900 ms): CPU 0/KVM/23744 ioctl(fd: 16<anon_inode:kvm-vcpu:0>, cmd: KVM_RUN) = 0
   902.570 (1021.116 ms): qemu-system-x8/23667 ppoll(ufds: 0x558151e03180, nfds: 74, tsp: 0x7ffc00cd0900, sigsetsize: 8) = 1
  1923.825 (305.133 ms): qemu-system-x8/23667 ppoll(ufds: 0x558151e03180, nfds: 74, tsp: 0x7ffc00cd0900, sigsetsize: 8) = 1
  2000.172 (229.002 ms): CPU 0/KVM/23744 ioctl(fd: 16<anon_inode:kvm-vcpu:0>, cmd: KVM_RUN) = 0
^C  #

If we look inside that cgroup hierarchy we get:

  # ls -la /sys/fs/cgroup/perf_event/machine.slice/ | grep drw
  drwxr-xr-x. 3 root root 0 Mar  6 15:05 .
  drwxr-xr-x. 2 root root 0 Mar  6 16:16 machine-qemu\x2d2\x2drhel6.sandy.scope
  #

There is just one, but lets say there were more and we would want to see
5 seconds worth of syscall summary for the threads in that cgroup:

  # perf trace --summary -G machine.slice/machine-qemu\\x2d2\\x2drhel6.sandy.scope/ -a sleep 5

   Summary of events:

     qemu-system-x86 (23667), 143858 events, 24.2%

     syscall            calls    total       min       avg       max      stddev
                                 (msec)    (msec)    (msec)    (msec)        (%)
     --------------- -------- --------- --------- --------- ---------     ------
     ppoll              28492  4348.631     0.000     0.153    11.616      1.05%
     futex              19661   140.801     0.001     0.007     2.993      3.20%
     read               18440    68.084     0.001     0.004     1.653      4.33%
     ioctl               5387    24.768     0.002     0.005     0.134      1.62%

     CPU 0/KVM (23744), 449455 events, 75.8%

     syscall            calls    total       min       avg       max      stddev
                               (msec)    (msec)    (msec)    (msec)        (%)
     --------------- -------- --------- --------- --------- ---------     ------
     ioctl             148364  3401.812     0.000     0.023    11.801      1.15%
     futex              36131   404.127     0.001     0.011     7.377      2.63%
     writev             29452   339.688     0.003     0.012     1.740      1.36%
     write              11315    45.992     0.001     0.004     0.105      1.10%

  #

See the documentation about how to set more than one cgroup for
different events in the same command line.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-t126jh4occqvu0xdqlcjygex@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-trace.txt | 25 +++++++++++++++++
 tools/perf/builtin-trace.c              | 50 +++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/tools/perf/Documentation/perf-trace.txt b/tools/perf/Documentation/perf-trace.txt
index 33a88e984e66..5a7035c5c523 100644
--- a/tools/perf/Documentation/perf-trace.txt
+++ b/tools/perf/Documentation/perf-trace.txt
@@ -63,6 +63,31 @@ filter out the startup phase of the program, which is often very different.
 --uid=::
         Record events in threads owned by uid. Name or number.
 
+-G::
+--cgroup::
+	Record events in threads in a cgroup.
+
+	Look for cgroups to set at the /sys/fs/cgroup/perf_event directory, then
+	remove the /sys/fs/cgroup/perf_event/ part and try:
+
+		perf trace -G A -e sched:*switch
+
+	Will set all raw_syscalls:sys_{enter,exit}, pgfault, vfs_getname, etc
+	_and_ sched:sched_switch to the 'A' cgroup, while:
+
+		perf trace -e sched:*switch -G A
+
+	will only set the sched:sched_switch event to the 'A' cgroup, all the
+	other events (raw_syscalls:sys_{enter,exit}, etc are left "without"
+	a cgroup (on the root cgroup, sys wide, etc).
+
+	Multiple cgroups:
+
+		perf trace -G A -e sched:*switch -G B
+
+	the syscall ones go to the 'A' cgroup, the sched:sched_switch goes
+	to the 'B' cgroup.
+
 --filter-pids=::
 	Filter out events for these pids and for 'trace' itself (comma separated list).
 
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 1a93debc1e8d..5b81060a8117 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -19,6 +19,7 @@
 #include <traceevent/event-parse.h>
 #include <api/fs/tracing_path.h>
 #include "builtin.h"
+#include "util/cgroup.h"
 #include "util/color.h"
 #include "util/debug.h"
 #include "util/env.h"
@@ -83,6 +84,7 @@ struct trace {
 	struct perf_evlist	*evlist;
 	struct machine		*host;
 	struct thread		*current;
+	struct cgroup		*cgroup;
 	u64			base_time;
 	FILE			*output;
 	unsigned long		nr_events;
@@ -2370,6 +2372,34 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 				   trace__sched_stat_runtime))
 		goto out_error_sched_stat_runtime;
 
+	/*
+	 * If a global cgroup was set, apply it to all the events without an
+	 * explicit cgroup. I.e.:
+	 *
+	 * 	trace -G A -e sched:*switch
+	 *
+	 * Will set all raw_syscalls:sys_{enter,exit}, pgfault, vfs_getname, etc
+	 * _and_ sched:sched_switch to the 'A' cgroup, while:
+	 *
+	 * trace -e sched:*switch -G A
+	 *
+	 * will only set the sched:sched_switch event to the 'A' cgroup, all the
+	 * other events (raw_syscalls:sys_{enter,exit}, etc are left "without"
+	 * a cgroup (on the root cgroup, sys wide, etc).
+	 *
+	 * Multiple cgroups:
+	 *
+	 * trace -G A -e sched:*switch -G B
+	 *
+	 * the syscall ones go to the 'A' cgroup, the sched:sched_switch goes
+	 * to the 'B' cgroup.
+	 *
+	 * evlist__set_default_cgroup() grabs a reference of the passed cgroup
+	 * only for the evsels still without a cgroup, i.e. evsel->cgroup == NULL.
+	 */
+	if (trace->cgroup)
+		evlist__set_default_cgroup(trace->evlist, trace->cgroup);
+
 	err = perf_evlist__create_maps(evlist, &trace->opts.target);
 	if (err < 0) {
 		fprintf(trace->output, "Problems parsing the target to trace, check your options!\n");
@@ -2540,6 +2570,7 @@ out_delete_evlist:
 	trace__symbols__exit(trace);
 
 	perf_evlist__delete(evlist);
+	cgroup__put(trace->cgroup);
 	trace->evlist = NULL;
 	trace->live = false;
 	return err;
@@ -2979,6 +3010,18 @@ out:
 	return err;
 }
 
+static int trace__parse_cgroups(const struct option *opt, const char *str, int unset)
+{
+	struct trace *trace = opt->value;
+
+	if (!list_empty(&trace->evlist->entries))
+		return parse_cgroups(opt, str, unset);
+
+	trace->cgroup = evlist__findnew_cgroup(trace->evlist, str);
+
+	return 0;
+}
+
 int cmd_trace(int argc, const char **argv)
 {
 	const char *trace_usage[] = {
@@ -3069,6 +3112,8 @@ int cmd_trace(int argc, const char **argv)
 			"print the PERF_RECORD_SAMPLE PERF_SAMPLE_ info, for debugging"),
 	OPT_UINTEGER(0, "proc-map-timeout", &trace.opts.proc_map_timeout,
 			"per thread proc mmap processing timeout in ms"),
+	OPT_CALLBACK('G', "cgroup", &trace, "name", "monitor event in cgroup name only",
+		     trace__parse_cgroups),
 	OPT_UINTEGER('D', "delay", &trace.opts.initial_delay,
 		     "ms to wait before starting measurement after program "
 		     "start"),
@@ -3095,6 +3140,11 @@ int cmd_trace(int argc, const char **argv)
 	argc = parse_options_subcommand(argc, argv, trace_options, trace_subcommands,
 				 trace_usage, PARSE_OPT_STOP_AT_NON_OPTION);
 
+	if ((nr_cgroups || trace.cgroup) && !trace.opts.target.system_wide) {
+		usage_with_options_msg(trace_usage, trace_options,
+				       "cgroup monitoring only available in system-wide mode");
+	}
+
 	err = bpf__setup_stdout(trace.evlist);
 	if (err) {
 		bpf__strerror_setup_stdout(trace.evlist, err, bf, sizeof(bf));
