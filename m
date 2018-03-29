Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752154AbeC2HCS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 03:02:18 -0400
Received: from mga12.intel.com ([192.55.52.136]:44564 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750732AbeC2HCP (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 03:02:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,375,1517904000";
   d="scan'208";a="29381158"
From: Jin Yao <yao.jin@linux.intel.com>
To: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc: Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
        yao.jin@intel.com, Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v3 3/5] perf version: Print the compiled-in status of libraries
Date: Thu, 29 Mar 2018 22:56:20 +0800
Message-Id: <1522335382-11983-4-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522335382-11983-1-git-send-email-yao.jin@linux.intel.com>
References: <1522335382-11983-1-git-send-email-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch checks the values passed by CFLAGS (-DHAVE_XXX) and then
print the status of libraries.

For example, if HAVE_DWARF_SUPPORT is defined, that means the
library "dwarf" is compiled-in. The patch will print the status
"on" for this library otherwise it print the status "OFF".

A new option '--build-options' created for 'perf version' supports
the printing of library status.

For example:

$ ./perf version --build-options
    or
  ./perf --version --build-options
    or
  ./perf -v --build-options

perf version 4.13.rc5.g4c1df1
                 dwarf: [ on  ]
    dwarf_getlocations: [ on  ]
                 glibc: [ on  ]
                  gtk2: [ on  ]
              libaudit: [ OFF ]
                libbfd: [ on  ]
                libelf: [ on  ]
               libnuma: [ on  ]
numa_num_possible_cpus: [ on  ]
               libperl: [ on  ]
             libpython: [ on  ]
              libslang: [ on  ]
             libcrypto: [ on  ]
             libunwind: [ on  ]
    libdw-dwarf-unwind: [ on  ]
                  zlib: [ on  ]
                  lzma: [ on  ]
             get_cpuid: [ on  ]
                   bpf: [ on  ]

v3:
---
Remove following unnecessary help message.

1. [ on  ]: library is compiled-in
   [ OFF ]: library is disabled in make configuration
            OR library is not installed in build environment

2. Create '--build-options' option.

3. Use standard option parsing API 'parse_options'.

v2:
---
1. Use IS_BUILTIN macro to replace #ifdef/#endif block.

2. Print color for on/OFF.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/builtin-version.c | 81 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 80 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-version.c b/tools/perf/builtin-version.c
index 37019c5..8b393b9 100644
--- a/tools/perf/builtin-version.c
+++ b/tools/perf/builtin-version.c
@@ -1,11 +1,90 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "builtin.h"
 #include "perf.h"
+#include "color.h"
 #include <linux/compiler.h>
+#include <tools/config.h>
 #include <stdio.h>
+#include <string.h>
+#include <subcmd/parse-options.h>
 
-int cmd_version(int argc __maybe_unused, const char **argv __maybe_unused)
+int version_verbose;
+
+struct version {
+	bool	build_options;
+};
+
+static struct version version;
+
+static struct option version_options[] = {
+	OPT_BOOLEAN(0, "build-options", &version.build_options,
+		    "display the build options"),
+};
+
+static const char * const version_usage[] = {
+	"perf version [<options>]",
+	NULL
+};
+
+static void on_off_print(const char *status)
+{
+	printf("[ ");
+
+	if (!strcmp(status, "OFF"))
+		color_fprintf(stdout, PERF_COLOR_RED, "%-3s", status);
+	else
+		color_fprintf(stdout, PERF_COLOR_GREEN, "%-3s", status);
+
+	printf(" ]");
+}
+
+static void status_print(const char *name, const char *status)
 {
+	printf("%22s: ", name);
+	on_off_print(status);
+	printf("\n");
+}
+
+#define STATUS(__d, __m)			\
+do {						\
+	if (IS_BUILTIN(__d))			\
+		status_print(#__m, "on");	\
+	else					\
+		status_print(#__m, "OFF");	\
+} while (0)
+
+static void library_status(void)
+{
+	STATUS(HAVE_DWARF_SUPPORT, dwarf);
+	STATUS(HAVE_DWARF_GETLOCATIONS, dwarf_getlocations);
+	STATUS(HAVE_GLIBC_SUPPORT, glibc);
+	STATUS(HAVE_GTK2_SUPPORT, gtk2);
+	STATUS(HAVE_LIBAUDIT_SUPPORT, libaudit);
+	STATUS(HAVE_LIBBFD_SUPPORT, libbfd);
+	STATUS(HAVE_LIBELF_SUPPORT, libelf);
+	STATUS(HAVE_LIBNUMA_SUPPORT, libnuma);
+	STATUS(HAVE_LIBNUMA_SUPPORT, numa_num_possible_cpus);
+	STATUS(HAVE_LIBPERL_SUPPORT, libperl);
+	STATUS(HAVE_LIBPYTHON_SUPPORT, libpython);
+	STATUS(HAVE_SLANG_SUPPORT, libslang);
+	STATUS(HAVE_LIBCRYPTO_SUPPORT, libcrypto);
+	STATUS(HAVE_LIBUNWIND_SUPPORT, libunwind);
+	STATUS(HAVE_DWARF_SUPPORT, libdw-dwarf-unwind);
+	STATUS(HAVE_ZLIB_SUPPORT, zlib);
+	STATUS(HAVE_LZMA_SUPPORT, lzma);
+	STATUS(HAVE_AUXTRACE_SUPPORT, get_cpuid);
+	STATUS(HAVE_LIBBPF_SUPPORT, bpf);
+}
+
+int cmd_version(int argc, const char **argv)
+{
+	argc = parse_options(argc, argv, version_options, version_usage,
+			     PARSE_OPT_STOP_AT_NON_OPTION);
+
 	printf("perf version %s\n", perf_version_string);
+
+	if (version.build_options || version_verbose == 1)
+		library_status();
+
 	return 0;
 }
-- 
2.7.4
