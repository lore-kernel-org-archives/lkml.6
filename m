Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752124AbeCZIMx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 04:12:53 -0400
Received: from mga03.intel.com ([134.134.136.65]:56660 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751050AbeCZIMv (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 04:12:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,364,1517904000";
   d="scan'208";a="214862087"
From: Jin Yao <yao.jin@linux.intel.com>
To: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc: Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
        yao.jin@intel.com, Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v1 2/3] perf version: Print the status of compiled-in libraries
Date: Tue, 27 Mar 2018 00:07:03 +0800
Message-Id: <1522080424-12912-3-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522080424-12912-1-git-send-email-yao.jin@linux.intel.com>
References: <1522080424-12912-1-git-send-email-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch checks the values passed by CFLAGS (-DXXX) and then
print the status of libraries.

For example, if HAVE_DWARF_SUPPORT is defined, that means the
library "dwarf" is compiled-in. The patch will print the status
"on" for this library.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/builtin-version.c | 125 +++++++++++++++++++++++++++++++++++++++++++
 tools/perf/builtin.h         |   1 +
 2 files changed, 126 insertions(+)

diff --git a/tools/perf/builtin-version.c b/tools/perf/builtin-version.c
index 37019c5..90a0a7f 100644
--- a/tools/perf/builtin-version.c
+++ b/tools/perf/builtin-version.c
@@ -9,3 +9,128 @@ int cmd_version(int argc __maybe_unused, const char **argv __maybe_unused)
 	printf("perf version %s\n", perf_version_string);
 	return 0;
 }
+
+static void status_print(const char *name, const char *status)
+{
+	printf("%22s: [ %3s ]\n", name, status);
+}
+
+static void library_status(void)
+{
+#ifdef HAVE_DWARF_SUPPORT
+	status_print("dwarf", "on");
+#else
+	status_print("dwarf", "off");
+#endif
+
+#ifdef HAVE_DWARF_GETLOCATIONS
+	status_print("dwarf_getlocations", "on");
+#else
+	status_print("dwarf_getlocations", "off");
+#endif
+
+#ifdef NO_GLIBC
+	status_print("glibc", "off");
+#else
+	status_print("glibc", "on");
+#endif
+
+#ifdef HAVE_GTK2_SUPPORT
+	status_print("gtk2", "on");
+#else
+	status_print("gtk2", "off");
+#endif
+
+#ifdef HAVE_LIBAUDIT_SUPPORT
+	status_print("libaudit", "on");
+#else
+	status_print("libaudit", "off");
+#endif
+
+#ifdef HAVE_LIBBFD_SUPPORT
+	status_print("libbfd", "on");
+#else
+	status_print("libbfd", "off");
+#endif
+
+#ifdef HAVE_LIBELF_SUPPORT
+	status_print("libelf", "on");
+#else
+	status_print("libelf", "off");
+#endif
+
+#ifdef HAVE_LIBNUMA_SUPPORT
+	status_print("libnuma", "on");
+	status_print("numa_num_possible_cpus", "on");
+#else
+	status_print("libnuma", "off");
+	status_print("numa_num_possible_cpus", "off");
+#endif
+
+#ifdef NO_LIBPERL
+	status_print("libperl", "off");
+#else
+	status_print("libperl", "on");
+#endif
+
+#ifdef NO_LIBPYTHON
+	status_print("libpython", "off");
+#else
+	status_print("libpython", "on");
+#endif
+
+#ifdef HAVE_SLANG_SUPPORT
+	status_print("libslang", "on");
+#else
+	status_print("libslang", "off");
+#endif
+
+#ifdef HAVE_LIBCRYPTO_SUPPORT
+	status_print("libcrypto", "on");
+#else
+	status_print("libcrypto", "off");
+#endif
+
+#ifdef HAVE_LIBUNWIND_SUPPORT
+	status_print("libunwind", "on");
+#else
+	status_print("libunwind", "off");
+#endif
+
+#ifdef HAVE_DWARF_SUPPORT
+	status_print("libdw-dwarf-unwind", "on");
+#else
+	status_print("libdw-dwarf-unwind", "off");
+#endif
+
+#ifdef HAVE_ZLIB_SUPPORT
+	status_print("zlib", "on");
+#else
+	status_print("zlib", "off");
+#endif
+
+#ifdef HAVE_LZMA_SUPPORT
+	status_print("lzma", "on");
+#else
+	status_print("lzma", "off");
+#endif
+
+#ifdef HAVE_AUXTRACE_SUPPORT
+	status_print("get_cpuid", "on");
+#else
+	status_print("get_cpuid", "off");
+#endif
+
+#ifdef HAVE_LIBBPF_SUPPORT
+	status_print("bpf", "on");
+#else
+	status_print("bpf", "off");
+#endif
+}
+
+int cmd_version2(int argc, const char **argv)
+{
+	cmd_version(argc, argv);
+	library_status();
+	return 0;
+}
diff --git a/tools/perf/builtin.h b/tools/perf/builtin.h
index 05745f3..c7508ee 100644
--- a/tools/perf/builtin.h
+++ b/tools/perf/builtin.h
@@ -29,6 +29,7 @@ int cmd_timechart(int argc, const char **argv);
 int cmd_top(int argc, const char **argv);
 int cmd_script(int argc, const char **argv);
 int cmd_version(int argc, const char **argv);
+int cmd_version2(int argc, const char **argv);
 int cmd_probe(int argc, const char **argv);
 int cmd_kmem(int argc, const char **argv);
 int cmd_lock(int argc, const char **argv);
-- 
2.7.4
