Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752719AbeC3Bdh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 21:33:37 -0400
Received: from mga17.intel.com ([192.55.52.151]:18372 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752649AbeC3BdP (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 21:33:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,378,1517904000";
   d="scan'208";a="212506341"
From: Jin Yao <yao.jin@linux.intel.com>
To: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc: Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
        yao.jin@intel.com, Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v4 5/6] perf: Support perf -vv
Date: Fri, 30 Mar 2018 17:27:15 +0800
Message-Id: <1522402036-22915-6-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522402036-22915-1-git-send-email-yao.jin@linux.intel.com>
References: <1522402036-22915-1-git-send-email-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We keep having bug reports that when users build perf on their own,
but they don't install some needed libraries such as libelf,
libbfd/libibery.

The perf can build, but it is missing important functionality.

This patch provides a new option '-vv' for perf which will
print the compiled-in status of libraries.

The 'perf -vv' is mapped to 'perf version --build-options'.

For example:

$ ./perf -vv

perf version 4.13.rc5.g6727c5
                 dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
    dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
                 glibc: [ on  ]  # HAVE_GLIBC_SUPPORT
                  gtk2: [ on  ]  # HAVE_GTK2_SUPPORT
              libaudit: [ OFF ]  # HAVE_LIBAUDIT_SUPPORT
                libbfd: [ on  ]  # HAVE_LIBBFD_SUPPORT
                libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
               libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
               libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
             libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
              libslang: [ on  ]  # HAVE_SLANG_SUPPORT
             libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
             libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
    libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
                  zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
                  lzma: [ on  ]  # HAVE_LZMA_SUPPORT
             get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
                   bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT

v3:
---
One bug is found in v2. It didn't process the option like '-vabc'
correctly. Fix this bug.

v2:
---
Use a global variable version_verbose to record the number of 'v'.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/perf.c | 6 ++++++
 tools/perf/perf.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index 1b3fc8e..1659029 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -190,6 +190,12 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			break;
 		}
 
+		if (!strcmp(cmd, "-vv")) {
+			(*argv)[0] = "version";
+			version_verbose = 1;
+			break;
+		}
+
 		/*
 		 * Check remaining flags.
 		 */
diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index 8fec1ab..a1a9795 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -84,6 +84,7 @@ struct record_opts {
 struct option;
 extern const char * const *record_usage;
 extern struct option *record_options;
+extern int version_verbose;
 
 int record__parse_freq(const struct option *opt, const char *str, int unset);
 #endif
-- 
2.7.4
