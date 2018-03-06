Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932589AbeCFGnA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 01:43:00 -0500
Received: from terminus.zytor.com ([198.137.202.136]:46671 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932259AbeCFGm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 01:42:59 -0500
Date: Mon, 5 Mar 2018 22:42:35 -0800
From: tip-bot for Jin Yao <tipbot@zytor.com>
Message-ID: <tip-ab6c79b819f5a50cf41a11ebec17bef63b530333@git.kernel.org>
Cc: alexander.shishkin@linux.intel.com, acme@redhat.com,
        linux-kernel@vger.kernel.org, jolsa@kernel.org, mingo@kernel.org,
        yao.jin@linux.intel.com, ak@linux.intel.com, kan.liang@intel.com,
        peterz@infradead.org, hpa@zytor.com, tglx@linutronix.de
Reply-To: peterz@infradead.org, tglx@linutronix.de, hpa@zytor.com,
        ak@linux.intel.com, yao.jin@linux.intel.com, kan.liang@intel.com,
        mingo@kernel.org, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        acme@redhat.com, alexander.shishkin@linux.intel.com
In-Reply-To: <1516117388-10120-1-git-send-email-yao.jin@linux.intel.com>
References: <1516117388-10120-1-git-send-email-yao.jin@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf stat: Ignore error thread when enabling
 system-wide --per-thread
Git-Commit-ID: ab6c79b819f5a50cf41a11ebec17bef63b530333
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

Commit-ID:  ab6c79b819f5a50cf41a11ebec17bef63b530333
Gitweb:     https://git.kernel.org/tip/ab6c79b819f5a50cf41a11ebec17bef63b530333
Author:     Jin Yao <yao.jin@linux.intel.com>
AuthorDate: Tue, 16 Jan 2018 23:43:08 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 27 Feb 2018 11:29:21 -0300

perf stat: Ignore error thread when enabling system-wide --per-thread

If we execute 'perf stat --per-thread' with non-root account (even set
kernel.perf_event_paranoid = -1 yet), it reports the error:

  jinyao@skl:~$ perf stat --per-thread
  Error:
  You may not have permission to collect system-wide stats.

  Consider tweaking /proc/sys/kernel/perf_event_paranoid,
  which controls use of the performance events system by
  unprivileged users (without CAP_SYS_ADMIN).

  The current value is 2:

    -1: Allow use of (almost) all events by all users
        Ignore mlock limit after perf_event_mlock_kb without CAP_IPC_LOCK
  >= 0: Disallow ftrace function tracepoint by users without CAP_SYS_ADMIN
        Disallow raw tracepoint access by users without CAP_SYS_ADMIN
  >= 1: Disallow CPU event access by users without CAP_SYS_ADMIN
  >= 2: Disallow kernel profiling by users without CAP_SYS_ADMIN

  To make this setting permanent, edit /etc/sysctl.conf too, e.g.:

          kernel.perf_event_paranoid = -1

Perhaps the ptrace rule doesn't allow to trace some processes. But anyway
the global --per-thread mode had better ignore such errors and continue
working on other threads.

This patch will record the index of error thread in perf_evsel__open()
and remove this thread before retrying.

For example (run with non-root, kernel.perf_event_paranoid isn't set):

  jinyao@skl:~$ perf stat --per-thread
  ^C
   Performance counter stats for 'system wide':

         vmstat-3458    6.171984   cpu-clock:u (msec) #  0.000 CPUs utilized
           perf-3670    0.515599   cpu-clock:u (msec) #  0.000 CPUs utilized
         vmstat-3458   1,163,643   cycles:u           #  0.189 GHz
           perf-3670      40,881   cycles:u           #  0.079 GHz
         vmstat-3458   1,410,238   instructions:u     #  1.21  insn per cycle
           perf-3670       3,536   instructions:u     #  0.09  insn per cycle
         vmstat-3458     288,937   branches:u         # 46.814 M/sec
           perf-3670         936   branches:u         #  1.815 M/sec
         vmstat-3458      15,195   branch-misses:u    #  5.26% of all branches
           perf-3670          76   branch-misses:u    #  8.12% of all branches

        12.651675247 seconds time elapsed

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1516117388-10120-1-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c    | 14 +++++++++++++-
 tools/perf/util/evsel.c      |  3 +++
 tools/perf/util/thread_map.c |  1 +
 tools/perf/util/thread_map.h |  1 +
 4 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index fadcff52cd09..6214d2b220b2 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -637,7 +637,19 @@ try_again:
                                 if (verbose > 0)
                                         ui__warning("%s\n", msg);
                                 goto try_again;
-                        }
+			} else if (target__has_per_thread(&target) &&
+				   evsel_list->threads &&
+				   evsel_list->threads->err_thread != -1) {
+				/*
+				 * For global --per-thread case, skip current
+				 * error thread.
+				 */
+				if (!thread_map__remove(evsel_list->threads,
+							evsel_list->threads->err_thread)) {
+					evsel_list->threads->err_thread = -1;
+					goto try_again;
+				}
+			}
 
 			perf_evsel__open_strerror(counter, &target,
 						  errno, msg, sizeof(msg));
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index ef351688b797..b56e1c2ddaee 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1915,6 +1915,9 @@ try_fallback:
 		goto fallback_missing_features;
 	}
 out_close:
+	if (err)
+		threads->err_thread = thread;
+
 	do {
 		while (--thread >= 0) {
 			close(FD(evsel, cpu, thread));
diff --git a/tools/perf/util/thread_map.c b/tools/perf/util/thread_map.c
index 729dad8f412d..5d467d8ae9ab 100644
--- a/tools/perf/util/thread_map.c
+++ b/tools/perf/util/thread_map.c
@@ -32,6 +32,7 @@ static void thread_map__reset(struct thread_map *map, int start, int nr)
 	size_t size = (nr - start) * sizeof(map->map[0]);
 
 	memset(&map->map[start], 0, size);
+	map->err_thread = -1;
 }
 
 static struct thread_map *thread_map__realloc(struct thread_map *map, int nr)
diff --git a/tools/perf/util/thread_map.h b/tools/perf/util/thread_map.h
index 5ec91cfd1869..2f689c90a8c6 100644
--- a/tools/perf/util/thread_map.h
+++ b/tools/perf/util/thread_map.h
@@ -14,6 +14,7 @@ struct thread_map_data {
 struct thread_map {
 	refcount_t refcnt;
 	int nr;
+	int err_thread;
 	struct thread_map_data map[];
 };
 
