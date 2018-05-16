Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752149AbeEPSDJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 14:03:09 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60881 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751328AbeEPSDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 14:03:08 -0400
Date: Wed, 16 May 2018 11:02:58 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-zmeg52dlvy51rdlhyumfl5yf@git.kernel.org>
Cc: namhyung@kernel.org, adrian.hunter@intel.com, hpa@zytor.com,
        dsahern@gmail.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, wangnan0@huawei.com,
        acme@redhat.com
Reply-To: hpa@zytor.com, adrian.hunter@intel.com, namhyung@kernel.org,
        mingo@kernel.org, dsahern@gmail.com, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, tglx@linutronix.de, wangnan0@huawei.com,
        acme@redhat.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf bpf: Add bpf.h to be used in eBPF proggies
Git-Commit-ID: dd8e4ead6e983acea959d10252688ef1471106fe
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

Commit-ID:  dd8e4ead6e983acea959d10252688ef1471106fe
Gitweb:     https://git.kernel.org/tip/dd8e4ead6e983acea959d10252688ef1471106fe
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 4 May 2018 12:23:29 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 15 May 2018 14:31:23 -0300

perf bpf: Add bpf.h to be used in eBPF proggies

So, the first helper is the one shortening a variable/function section
attribute, from, for instance:

  char _license[] __attribute__((section("license"), used)) = "GPL";

to:

  char _license[] SEC("license") = "GPL";

Convert empty.c to that and it becomes:

  # cat ~acme/lib/examples/perf/bpf/empty.c
  #include <bpf.h>

  char _license[] SEC("license") = "GPL";
  int _version SEC("version") = LINUX_VERSION_CODE;
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-zmeg52dlvy51rdlhyumfl5yf@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf        | 1 +
 tools/perf/examples/bpf/empty.c | 6 ++++--
 tools/perf/include/bpf/bpf.h    | 5 +++++
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 9343b7d945bb..c63a3971d719 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -770,6 +770,7 @@ endif
 ifndef NO_LIBBPF
 	$(call QUIET_INSTALL, lib) \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perf_include_instdir_SQ)/bpf'
+		$(INSTALL) include/bpf/*.h '$(DESTDIR_SQ)$(perf_include_instdir_SQ)/bpf'
 	$(call QUIET_INSTALL, lib) \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perf_examples_instdir_SQ)/bpf'
 		$(INSTALL) examples/bpf/*.c '$(DESTDIR_SQ)$(perf_examples_instdir_SQ)/bpf'
diff --git a/tools/perf/examples/bpf/empty.c b/tools/perf/examples/bpf/empty.c
index 78754df53ac1..86f97763355d 100644
--- a/tools/perf/examples/bpf/empty.c
+++ b/tools/perf/examples/bpf/empty.c
@@ -1,2 +1,4 @@
-char _license[] __attribute__((section("license"), used)) = "GPL";
-int _version __attribute__((section("version"), used)) = LINUX_VERSION_CODE;
+#include <bpf.h>
+
+char _license[] SEC("license") = "GPL";
+int _version SEC("version") = LINUX_VERSION_CODE;
diff --git a/tools/perf/include/bpf/bpf.h b/tools/perf/include/bpf/bpf.h
new file mode 100644
index 000000000000..003afcab4e51
--- /dev/null
+++ b/tools/perf/include/bpf/bpf.h
@@ -0,0 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifndef _PERF_BPF_H
+#define _PERF_BPF_H
+#define SEC(NAME) __attribute__((section(NAME),  used))
+#endif /* _PERF_BPF_H */
