Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752139AbeEPOtt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 10:49:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:46154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751880AbeEPOtr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 10:49:47 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 08/11] perf bpf: Add probe() helper to reduce kprobes boilerplate
Date: Wed, 16 May 2018 11:49:05 -0300
Message-Id: <20180516144908.22212-9-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180516144908.22212-1-acme@kernel.org>
References: <20180516144908.22212-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.14.3
