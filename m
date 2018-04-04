Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752772AbeDDF3m (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 01:29:42 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34947 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752506AbeDDF3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 01:29:40 -0400
Date: Tue, 3 Apr 2018 22:29:29 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-8f7d3mngaxvi7tlzloz3n7cs@git.kernel.org>
Cc: tglx@linutronix.de, jolsa@kernel.org, dsahern@gmail.com,
        wangnan0@huawei.com, hpa@zytor.com, acme@redhat.com, mingo@kernel.org,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com
Reply-To: dsahern@gmail.com, wangnan0@huawei.com, jolsa@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, acme@redhat.com, hpa@zytor.com,
        mingo@kernel.org, namhyung@kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf trace: Show only failing syscalls
Git-Commit-ID: 0a6545bda2756807a089c64352edfc5628c57e6c
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

Commit-ID:  0a6545bda2756807a089c64352edfc5628c57e6c
Gitweb:     https://git.kernel.org/tip/0a6545bda2756807a089c64352edfc5628c57e6c
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 29 Mar 2018 12:22:59 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 2 Apr 2018 07:57:37 -0300

perf trace: Show only failing syscalls

For instance:

  # perf probe "vfs_getname=getname_flags:72 pathname=result->name:string"
  Added new event:
    probe:vfs_getname    (on getname_flags:72 with pathname=result->name:string)

  You can now use it in all perf tools, such as:

	  perf record -e probe:vfs_getname -aR sleep 1

  # perf trace --failure sleep 1
     0.043 ( 0.010 ms): sleep/10978 access(filename: /etc/ld.so.preload, mode: R) = -1 ENOENT No such file or directory

For reference, here are all the syscalls in this case:

  # perf trace sleep 1
         ? (         ): sleep/10976  ... [continued]: execve()) = 0
       0.027 ( 0.001 ms): sleep/10976 brk() = 0x55bdc2d04000
       0.044 ( 0.010 ms): sleep/10976 access(filename: /etc/ld.so.preload, mode: R) = -1 ENOENT No such file or directory
       0.057 ( 0.006 ms): sleep/10976 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC) = 3
       0.064 ( 0.002 ms): sleep/10976 fstat(fd: 3, statbuf: 0x7fffac22b370) = 0
       0.067 ( 0.003 ms): sleep/10976 mmap(len: 111457, prot: READ, flags: PRIVATE, fd: 3) = 0x7feec8615000
       0.071 ( 0.001 ms): sleep/10976 close(fd: 3) = 0
       0.080 ( 0.007 ms): sleep/10976 openat(dfd: CWD, filename: /lib64/libc.so.6, flags: CLOEXEC) = 3
       0.088 ( 0.002 ms): sleep/10976 read(fd: 3, buf: 0x7fffac22b538, count: 832) = 832
       0.092 ( 0.001 ms): sleep/10976 fstat(fd: 3, statbuf: 0x7fffac22b3d0) = 0
       0.094 ( 0.002 ms): sleep/10976 mmap(len: 8192, prot: READ|WRITE, flags: PRIVATE|ANONYMOUS) = 0x7feec8613000
       0.099 ( 0.004 ms): sleep/10976 mmap(len: 3889792, prot: EXEC|READ, flags: PRIVATE|DENYWRITE, fd: 3) = 0x7feec8057000
       0.104 ( 0.007 ms): sleep/10976 mprotect(start: 0x7feec8203000, len: 2097152) = 0
       0.112 ( 0.005 ms): sleep/10976 mmap(addr: 0x7feec8403000, len: 24576, prot: READ|WRITE, flags: PRIVATE|DENYWRITE|FIXED, fd: 3, off: 1753088) = 0x7feec8403000
       0.120 ( 0.003 ms): sleep/10976 mmap(addr: 0x7feec8409000, len: 14976, prot: READ|WRITE, flags: PRIVATE|ANONYMOUS|FIXED) = 0x7feec8409000
       0.128 ( 0.001 ms): sleep/10976 close(fd: 3) = 0
       0.139 ( 0.001 ms): sleep/10976 arch_prctl(option: 4098, arg2: 140663540761856) = 0
       0.186 ( 0.004 ms): sleep/10976 mprotect(start: 0x7feec8403000, len: 16384, prot: READ) = 0
       0.204 ( 0.003 ms): sleep/10976 mprotect(start: 0x55bdc0ec3000, len: 4096, prot: READ) = 0
       0.209 ( 0.004 ms): sleep/10976 mprotect(start: 0x7feec8631000, len: 4096, prot: READ) = 0
       0.214 ( 0.010 ms): sleep/10976 munmap(addr: 0x7feec8615000, len: 111457) = 0
       0.269 ( 0.001 ms): sleep/10976 brk() = 0x55bdc2d04000
       0.271 ( 0.002 ms): sleep/10976 brk(brk: 0x55bdc2d25000) = 0x55bdc2d25000
       0.274 ( 0.001 ms): sleep/10976 brk() = 0x55bdc2d25000
       0.278 ( 0.007 ms): sleep/10976 open(filename: /usr/lib/locale/locale-archive, flags: CLOEXEC) = 3
       0.288 ( 0.001 ms): sleep/10976 fstat(fd: 3</usr/lib/locale/locale-archive>, statbuf: 0x7feec8408aa0) = 0
       0.290 ( 0.003 ms): sleep/10976 mmap(len: 113045344, prot: READ, flags: PRIVATE, fd: 3) = 0x7feec1488000
       0.297 ( 0.001 ms): sleep/10976 close(fd: 3</usr/lib/locale/locale-archive>) = 0
       0.325 (1000.193 ms): sleep/10976 nanosleep(rqtp: 0x7fffac22c0b0) = 0
    1000.560 ( 0.006 ms): sleep/10976 close(fd: 1) = 0
    1000.573 ( 0.005 ms): sleep/10976 close(fd: 2) = 0
    1000.596 (         ): sleep/10976 exit_group()
  #

And can be done systemwide, etc, with backtraces:

  # perf trace --max-stack=16 --failure sleep 1
     0.048 ( 0.015 ms): sleep/11092 access(filename: /etc/ld.so.preload, mode: R) = -1 ENOENT No such file or directory
                                       __access (inlined)
                                       dl_main (/usr/lib64/ld-2.26.so)
  #

Or for some specific syscalls:

  # perf trace --max-stack=16 -e openat --failure cat /tmp/rien
  cat: /tmp/rien: No such file or directory
       0.251 ( 0.012 ms): cat/11106 openat(dfd: CWD, filename: /tmp/rien) = -1 ENOENT No such file or directory
                                         __libc_open64 (inlined)
                                         main (/usr/bin/cat)
                                         __libc_start_main (/usr/lib64/libc-2.26.so)
                                         _start (/usr/bin/cat)
  #

Look for inotify* syscalls that fail, system wide, for 2 seconds, with backtraces:

  # perf trace -a --max-stack=16 --failure -e inotify* sleep 2
   819.165 ( 0.058 ms): gmain/1724 inotify_add_watch(fd: 8<anon_inode:inotify>, pathname: /home/acme/~, mask: 16789454) = -1 ENOENT No such file or directory
                                       __GI_inotify_add_watch (inlined)
                                       _ik_watch (/usr/lib64/libgio-2.0.so.0.5400.3)
                                       _ip_start_watching (/usr/lib64/libgio-2.0.so.0.5400.3)
                                       im_scan_missing (/usr/lib64/libgio-2.0.so.0.5400.3)
                                       g_timeout_dispatch (/usr/lib64/libglib-2.0.so.0.5400.3)
                                       g_main_context_dispatch (/usr/lib64/libglib-2.0.so.0.5400.3)
                                       g_main_context_iterate.isra.23 (/usr/lib64/libglib-2.0.so.0.5400.3)
                                       g_main_context_iteration (/usr/lib64/libglib-2.0.so.0.5400.3)
                                       glib_worker_main (/usr/lib64/libglib-2.0.so.0.5400.3)
                                       g_thread_proxy (/usr/lib64/libglib-2.0.so.0.5400.3)
                                       start_thread (/usr/lib64/libpthread-2.26.so)
                                       __GI___clone (inlined)
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-8f7d3mngaxvi7tlzloz3n7cs@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-trace.txt | 3 +++
 tools/perf/builtin-trace.c              | 9 ++++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-trace.txt b/tools/perf/Documentation/perf-trace.txt
index 5a7035c5c523..115db9e06ecd 100644
--- a/tools/perf/Documentation/perf-trace.txt
+++ b/tools/perf/Documentation/perf-trace.txt
@@ -117,6 +117,9 @@ the thread executes on the designated CPUs. Default is to monitor all CPUs.
 --sched::
 	Accrue thread runtime and provide a summary at the end of the session.
 
+--failure::
+	Show only syscalls that failed, i.e. that returned < 0.
+
 -i::
 --input::
 	Process events from a given perf data file.
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 87b95c9410b4..4e03f0f68241 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -112,6 +112,7 @@ struct trace {
 	bool			multiple_threads;
 	bool			summary;
 	bool			summary_only;
+	bool			failure_only;
 	bool			show_comm;
 	bool			print_sample;
 	bool			show_tool_stats;
@@ -1565,7 +1566,7 @@ static int trace__printf_interrupted_entry(struct trace *trace)
 	struct thread_trace *ttrace;
 	size_t printed;
 
-	if (trace->current == NULL)
+	if (trace->failure_only || trace->current == NULL)
 		return 0;
 
 	ttrace = thread__priv(trace->current);
@@ -1638,7 +1639,7 @@ static int trace__sys_enter(struct trace *trace, struct perf_evsel *evsel,
 					   args, trace, thread);
 
 	if (sc->is_exit) {
-		if (!(trace->duration_filter || trace->summary_only || trace->min_stack)) {
+		if (!(trace->duration_filter || trace->summary_only || trace->failure_only || trace->min_stack)) {
 			trace__fprintf_entry_head(trace, thread, 0, false, ttrace->entry_time, trace->output);
 			fprintf(trace->output, "%-70s)\n", ttrace->entry_str);
 		}
@@ -1742,7 +1743,7 @@ static int trace__sys_exit(struct trace *trace, struct perf_evsel *evsel,
 		}
 	}
 
-	if (trace->summary_only)
+	if (trace->summary_only || (ret >= 0 && trace->failure_only))
 		goto out;
 
 	trace__fprintf_entry_head(trace, thread, duration, duration_calculated, ttrace->entry_time, trace->output);
@@ -3087,6 +3088,8 @@ int cmd_trace(int argc, const char **argv)
 	OPT_INCR('v', "verbose", &verbose, "be more verbose"),
 	OPT_BOOLEAN('T', "time", &trace.full_time,
 		    "Show full timestamp, not time relative to first start"),
+	OPT_BOOLEAN(0, "failure", &trace.failure_only,
+		    "Show only syscalls that failed"),
 	OPT_BOOLEAN('s', "summary", &trace.summary_only,
 		    "Show only syscall summary with statistics"),
 	OPT_BOOLEAN('S', "with-summary", &trace.summary,
