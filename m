Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752912AbeDDFcg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 01:32:36 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59045 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751097AbeDDFcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 01:32:35 -0400
Date: Tue, 3 Apr 2018 22:32:12 -0700
From: tip-bot for Jin Yao <tipbot@zytor.com>
Message-ID: <tip-3aa94b10ab0a818ed9fa2dc06c40812c136f9a5a@git.kernel.org>
Cc: acme@redhat.com, tglx@linutronix.de, peterz@infradead.org,
        ak@linux.intel.com, kan.liang@intel.com,
        alexander.shishkin@linux.intel.com, hpa@zytor.com,
        yao.jin@linux.intel.com, yao.jin@intel.com, jolsa@kernel.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org
Reply-To: hpa@zytor.com, yao.jin@linux.intel.com, mingo@kernel.org,
        jolsa@kernel.org, yao.jin@intel.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, acme@redhat.com, ak@linux.intel.com,
        peterz@infradead.org, alexander.shishkin@linux.intel.com,
        kan.liang@intel.com
In-Reply-To: <1522402036-22915-6-git-send-email-yao.jin@linux.intel.com>
References: <1522402036-22915-6-git-send-email-yao.jin@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tools: Add 'perf -vv' as an alias to 'perf
 version --build-options'
Git-Commit-ID: 3aa94b10ab0a818ed9fa2dc06c40812c136f9a5a
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

Commit-ID:  3aa94b10ab0a818ed9fa2dc06c40812c136f9a5a
Gitweb:     https://git.kernel.org/tip/3aa94b10ab0a818ed9fa2dc06c40812c136f9a5a
Author:     Jin Yao <yao.jin@linux.intel.com>
AuthorDate: Fri, 30 Mar 2018 17:27:15 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 2 Apr 2018 13:50:35 -0300

perf tools: Add 'perf -vv' as an alias to 'perf version --build-options'

We keep having bug reports that when users build perf on their own, but
they don't install some needed libraries such as libelf,
libbfd/libibery.

The perf can build, but it is missing important functionality.

This patch provides a new option '-vv' for perf which will print the
compiled-in status of libraries.

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

One bug is found in v2. It didn't process the option like '-vabc'
correctly. Fix this bug.

v2:

Use a global variable version_verbose to record the number of 'v'.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1522402036-22915-6-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/perf.c | 6 ++++++
 tools/perf/perf.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index 1b3fc8ec0fa2..1659029d03fc 100644
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
index 8fec1abd0f1f..a1a97956136f 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -84,6 +84,7 @@ struct record_opts {
 struct option;
 extern const char * const *record_usage;
 extern struct option *record_options;
+extern int version_verbose;
 
 int record__parse_freq(const struct option *opt, const char *str, int unset);
 #endif
