Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752331AbeC1HDN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 03:03:13 -0400
Received: from mga17.intel.com ([192.55.52.151]:31659 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752230AbeC1HC6 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 03:02:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,370,1517904000";
   d="scan'208";a="32013337"
From: Jin Yao <yao.jin@linux.intel.com>
To: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc: Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
        yao.jin@intel.com, Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 4/4] perf: Support perf -vv
Date: Wed, 28 Mar 2018 22:57:08 +0800
Message-Id: <1522249028-15099-5-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522249028-15099-1-git-send-email-yao.jin@linux.intel.com>
References: <1522249028-15099-1-git-send-email-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We keep having bug reports that when users build perf on their own,
but they don't install some needed libraries such as libelf,
libbfd/libibery.

The perf can build, but it is missing important functionality.

This patch provides a new option '-vv' which will print the
compiled-in status of libraries.

The 'perf -vv' is equal to 'perf -version --build-options'.

For example:

$ ./perf -vv or ./perf -version --build-options
perf version 4.13.rc5.gcb1183
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
[ on  ]: library is compiled-in
[ OFF ]: library is disabled in make configuration
         OR library is not installed in build environment

v2:
---
Use a global variable version_verbose to count the number of 'v'.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/perf.c | 22 ++++++++++++++++++----
 tools/perf/perf.h |  1 +
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index 1b3fc8e..355219e 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -32,7 +32,7 @@
 #include <linux/kernel.h>
 
 const char perf_usage_string[] =
-	"perf [--version] [--help] [OPTIONS] COMMAND [ARGS]";
+	"perf [--version [--build-options]] [--help] [OPTIONS] COMMAND [ARGS]";
 
 const char perf_more_info_string[] =
 	"See 'perf help COMMAND' for more information on a specific command.";
@@ -163,6 +163,8 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 {
 	int handled = 0;
 
+	version_verbose = 0;
+
 	while (*argc > 0) {
 		const char *cmd = (*argv)[0];
 		if (cmd[0] != '-')
@@ -185,9 +187,21 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			break;
 		}
 
-		if (!strcmp(cmd, "-v")) {
-			(*argv)[0] = "--version";
-			break;
+		if (strstarts(cmd, "-v")) {
+			int i;
+
+			for (i = 2; cmd[i]; i++) {
+				if (cmd[i] == 'v')
+					version_verbose++;
+			}
+
+			/*
+			 * Only support -v and -vv now
+			 */
+			if (version_verbose < 2) {
+				(*argv)[0] = "--version";
+				break;
+			}
 		}
 
 		/*
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
