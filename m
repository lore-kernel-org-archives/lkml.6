Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751985AbeEPSDl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 14:03:41 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45553 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750799AbeEPSDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 14:03:39 -0400
Date: Wed, 16 May 2018 11:03:29 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-2nmxth2l2h09f9gy85lyexcq@git.kernel.org>
Cc: tglx@linutronix.de, dsahern@gmail.com, wangnan0@huawei.com,
        acme@redhat.com, namhyung@kernel.org, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, mingo@kernel.org, hpa@zytor.com,
        adrian.hunter@intel.com
Reply-To: wangnan0@huawei.com, dsahern@gmail.com, tglx@linutronix.de,
        namhyung@kernel.org, acme@redhat.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, adrian.hunter@intel.com, hpa@zytor.com,
        mingo@kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf bpf: Add kprobe example to catch 5s naps
Git-Commit-ID: 7542b767b0469f4a76afa3feae6246d8a3d44e7f
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

Commit-ID:  7542b767b0469f4a76afa3feae6246d8a3d44e7f
Gitweb:     https://git.kernel.org/tip/7542b767b0469f4a76afa3feae6246d8a3d44e7f
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 4 May 2018 15:08:01 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 15 May 2018 14:31:24 -0300

perf bpf: Add kprobe example to catch 5s naps

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
