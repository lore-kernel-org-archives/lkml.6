Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934988AbeEWUZ3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 16:25:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:33726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934808AbeEWUV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 16:21:27 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 03/18] perf annotate: Support '--group' option
Date: Wed, 23 May 2018 17:20:51 -0300
Message-Id: <20180523202106.17286-4-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180523202106.17286-1-acme@kernel.org>
References: <20180523202106.17286-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

With the '--group' option, even for non-explicit group, 'perf annotate'
will enable the group output.

For example,

  $ perf record -e cycles,branches ./div
  $ perf annotate main --stdio --group

                 :            Disassembly of section .text:
                 :
                 :            00000000004004b0 <main>:
                 :            main():
                 :
                 :                    return i;
                 :            }
                 :
                 :            int main(void)
                 :            {
    0.00    0.00 :   4004b0:       push   %rbx
                 :                    int i;
                 :                    int flag;
                 :                    volatile double x = 1212121212, y = 121212;
                 :
                 :                    s_randseed = time(0);
    0.00    0.00 :   4004b1:       xor    %edi,%edi
                 :                    srand(s_randseed);
    0.00    0.00 :   4004b3:       mov    $0x77359400,%ebx
                 :
                 :                    return i;
                 :            }
                 :

But if without --group, there is only one event reported.

  $ perf annotate main --stdio

         :            Disassembly of section .text:
         :
         :            00000000004004b0 <main>:
         :            main():
         :
         :                    return i;
         :            }
         :
         :            int main(void)
         :            {
    0.00 :   4004b0:       push   %rbx
         :                    int i;
         :                    int flag;
         :                    volatile double x = 1212121212, y = 121212;
         :
         :                    s_randseed = time(0);
    0.00 :   4004b1:       xor    %edi,%edi
         :                    srand(s_randseed);
    0.00 :   4004b3:       mov    $0x77359400,%ebx
         :
         :                    return i;
         :            }

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1526914666-31839-4-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-annotate.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 6e5d9f718154..da5704240239 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -45,6 +45,7 @@ struct perf_annotate {
 	bool	   print_line;
 	bool	   skip_missing;
 	bool	   has_br_stack;
+	bool	   group_set;
 	const char *sym_hist_filter;
 	const char *cpu_list;
 	DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
@@ -508,6 +509,9 @@ int cmd_annotate(int argc, const char **argv)
 		    "Don't shorten the displayed pathnames"),
 	OPT_BOOLEAN(0, "skip-missing", &annotate.skip_missing,
 		    "Skip symbols that cannot be annotated"),
+	OPT_BOOLEAN_SET(0, "group", &symbol_conf.event_group,
+			&annotate.group_set,
+			"Show event group information together"),
 	OPT_STRING('C', "cpu", &annotate.cpu_list, "cpu", "list of cpus to profile"),
 	OPT_CALLBACK(0, "symfs", NULL, "directory",
 		     "Look for files with symbols relative to this directory",
@@ -570,6 +574,9 @@ int cmd_annotate(int argc, const char **argv)
 	annotate.has_br_stack = perf_header__has_feat(&annotate.session->header,
 						      HEADER_BRANCH_STACK);
 
+	if (annotate.group_set)
+		perf_evlist__force_leader(annotate.session->evlist);
+
 	ret = symbol__annotation_init();
 	if (ret < 0)
 		goto out_delete;
-- 
2.14.3
