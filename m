Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752326AbeEPOvb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 10:51:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:46080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751610AbeEPOti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 10:49:38 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 05/11] perf bpf: Add bpf.h to be used in eBPF proggies
Date: Wed, 16 May 2018 11:49:02 -0300
Message-Id: <20180516144908.22212-6-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180516144908.22212-1-acme@kernel.org>
References: <20180516144908.22212-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
 create mode 100644 tools/perf/include/bpf/bpf.h

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
-- 
2.14.3
