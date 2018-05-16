Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752173AbeEPSEh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 14:04:37 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54509 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751457AbeEPSEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 14:04:36 -0400
Date: Wed, 16 May 2018 11:04:26 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-1v9r8f6ds5av0w9pcwpeknyl@git.kernel.org>
Cc: adrian.hunter@intel.com, wangnan0@huawei.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, dsahern@gmail.com,
        tglx@linutronix.de, acme@redhat.com, jolsa@kernel.org,
        mingo@kernel.org
Reply-To: mingo@kernel.org, acme@redhat.com, jolsa@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, dsahern@gmail.com, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, namhyung@kernel.org, wangnan0@huawei.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf bpf: Add probe() helper to reduce kprobes
 boilerplate
Git-Commit-ID: d8fc764d0b39c912de510b50102b60a64882223e
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

Commit-ID:  d8fc764d0b39c912de510b50102b60a64882223e
Gitweb:     https://git.kernel.org/tip/d8fc764d0b39c912de510b50102b60a64882223e
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 4 May 2018 15:59:16 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 15 May 2018 14:31:24 -0300

perf bpf: Add probe() helper to reduce kprobes boilerplate

So that kprobe definitions become:

  int probe(function, variables)(void *ctx, int err, var1, var2, ...)

The existing 5sec.c, got converted and goes from:

  SEC("func=hrtimer_nanosleep rqtp->tv_sec")
  int func(void *ctx, int err, long sec)
  {
  }

To:

  int probe(hrtimer_nanosleep, rqtp->tv_sec)(void *ctx, int err, long sec)
  {
  }

If we decide to add tv_nsec as well, then it becomes:

  $ cat tools/perf/examples/bpf/5sec.c
  #include <bpf.h>

  int probe(hrtimer_nanosleep, rqtp->tv_sec rqtp->tv_nsec)(void *ctx, int err, long sec, long nsec)
  {
	  return sec == 5;
  }

  license(GPL);
  $

And if we run it, system wide as before and run some 'sleep' with values
for the tv_nsec field, we get:

  # perf trace --no-syscalls -e tools/perf/examples/bpf/5sec.c
     0.000 perf_bpf_probe:hrtimer_nanosleep:(ffffffff9811b5f0) tv_sec=5 tv_nsec=100000000
  9641.650 perf_bpf_probe:hrtimer_nanosleep:(ffffffff9811b5f0) tv_sec=5 tv_nsec=123450001
  ^C#

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-1v9r8f6ds5av0w9pcwpeknyl@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/5sec.c | 10 ++++++++--
 tools/perf/include/bpf/bpf.h   |  3 +++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/perf/examples/bpf/5sec.c b/tools/perf/examples/bpf/5sec.c
index 6fc3697ac749..b9c203219691 100644
--- a/tools/perf/examples/bpf/5sec.c
+++ b/tools/perf/examples/bpf/5sec.c
@@ -15,6 +15,13 @@
 
     . While this is running, run something like "sleep 5s".
 
+    . If we decide to add tv_nsec as well, then it becomes:
+
+      int probe(hrtimer_nanosleep, rqtp->tv_sec rqtp->tv_nsec)(void *ctx, int err, long sec, long nsec)
+
+      I.e. add where it comes from (rqtp->tv_nsec) and where it will be
+      accessible in the function body (nsec)
+
     # perf trace --no-syscalls -e tools/perf/examples/bpf/5sec.c/call-graph=dwarf/
          0.000 perf_bpf_probe:func:(ffffffff9811b5f0) tv_sec=5
                                            hrtimer_nanosleep ([kernel.kallsyms])
@@ -34,8 +41,7 @@
 
 #include <bpf.h>
 
-SEC("func=hrtimer_nanosleep rqtp->tv_sec")
-int func(void *ctx, int err, long sec)
+int probe(hrtimer_nanosleep, rqtp->tv_sec)(void *ctx, int err, long sec)
 {
 	return sec == 5;
 }
diff --git a/tools/perf/include/bpf/bpf.h b/tools/perf/include/bpf/bpf.h
index cdfd18b9c318..dd764ad5efdf 100644
--- a/tools/perf/include/bpf/bpf.h
+++ b/tools/perf/include/bpf/bpf.h
@@ -3,6 +3,9 @@
 #define _PERF_BPF_H
 #define SEC(NAME) __attribute__((section(NAME),  used))
 
+#define probe(function, vars) \
+	SEC(#function "=" #function " " #vars) function
+
 #define license(name) \
 char _license[] SEC("license") = #name; \
 int _version SEC("version") = LINUX_VERSION_CODE;
