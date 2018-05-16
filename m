Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752014AbeEPOtq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 10:49:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:46096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751880AbeEPOtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 10:49:41 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 06/11] perf bpf: Add kprobe example to catch 5s naps
Date: Wed, 16 May 2018 11:49:03 -0300
Message-Id: <20180516144908.22212-7-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180516144908.22212-1-acme@kernel.org>
References: <20180516144908.22212-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Description:

. Disable strace like syscall tracing (--no-syscalls), or try tracing
  just some (-e *sleep).

. Attach a filter function to a kernel function, returning when it should
  be considered, i.e. appear on the output:

  $ cat tools/perf/examples/bpf/5sec.c
  #include <bpf.h>

  SEC("func=hrtimer_nanosleep rqtp->tv_sec")
  int func(void *ctx, int err, long sec)
  {
	  return sec == 5;
  }

  char _license[] SEC("license") = "GPL";
  int _version SEC("version") = LINUX_VERSION_CODE;
  $

. Run it system wide, so that any sleep of >= 5 seconds and < than 6
  seconds gets caught.

. Ask for callgraphs using DWARF info, so that userspace can be unwound

. While this is running, run something like "sleep 5s".

  # perf trace --no-syscalls -e tools/perf/examples/bpf/5sec.c/call-graph=dwarf/
     0.000 perf_bpf_probe:func:(ffffffff9811b5f0) tv_sec=5
                                       hrtimer_nanosleep ([kernel.kallsyms])
                                       __x64_sys_nanosleep ([kernel.kallsyms])
                                       do_syscall_64 ([kernel.kallsyms])
                                       entry_SYSCALL_64 ([kernel.kallsyms])
                                       __GI___nanosleep (/usr/lib64/libc-2.26.so)
                                       rpl_nanosleep (/usr/bin/sleep)
                                       xnanosleep (/usr/bin/sleep)
                                       main (/usr/bin/sleep)
                                       __libc_start_main (/usr/lib64/libc-2.26.so)
                                       _start (/usr/bin/sleep)
  ^C#

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-2nmxth2l2h09f9gy85lyexcq@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/5sec.c | 44 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 tools/perf/examples/bpf/5sec.c

diff --git a/tools/perf/examples/bpf/5sec.c b/tools/perf/examples/bpf/5sec.c
new file mode 100644
index 000000000000..3d1ed34aec8b
--- /dev/null
+++ b/tools/perf/examples/bpf/5sec.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+    Description:
+
+    . Disable strace like syscall tracing (--no-syscalls), or try tracing
+      just some (-e *sleep).
+
+    . Attach a filter function to a kernel function, returning when it should
+      be considered, i.e. appear on the output.
+
+    . Run it system wide, so that any sleep of >= 5 seconds and < than 6
+      seconds gets caught.
+
+    . Ask for callgraphs using DWARF info, so that userspace can be unwound
+
+    . While this is running, run something like "sleep 5s".
+
+    # perf trace --no-syscalls -e tools/perf/examples/bpf/5sec.c/call-graph=dwarf/
+         0.000 perf_bpf_probe:func:(ffffffff9811b5f0) tv_sec=5
+                                           hrtimer_nanosleep ([kernel.kallsyms])
+                                           __x64_sys_nanosleep ([kernel.kallsyms])
+                                           do_syscall_64 ([kernel.kallsyms])
+                                           entry_SYSCALL_64 ([kernel.kallsyms])
+                                           __GI___nanosleep (/usr/lib64/libc-2.26.so)
+                                           rpl_nanosleep (/usr/bin/sleep)
+                                           xnanosleep (/usr/bin/sleep)
+                                           main (/usr/bin/sleep)
+                                           __libc_start_main (/usr/lib64/libc-2.26.so)
+                                           _start (/usr/bin/sleep)
+    ^C#
+
+   Copyright (C) 2018 Red Hat, Inc., Arnaldo Carvalho de Melo <acme@redhat.com>
+*/
+
+#include <bpf.h>
+
+SEC("func=hrtimer_nanosleep rqtp->tv_sec")
+int func(void *ctx, int err, long sec)
+{
+	return sec == 5;
+}
+
+char _license[] SEC("license") = "GPL";
+int _version SEC("version") = LINUX_VERSION_CODE;
-- 
2.14.3
