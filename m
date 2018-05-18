Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752026AbeERFEB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 01:04:01 -0400
Received: from mga05.intel.com ([192.55.52.43]:41149 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751601AbeERFD6 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 01:03:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,413,1520924400";
   d="scan'208";a="229565864"
From: Jin Yao <yao.jin@linux.intel.com>
To: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc: Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
        yao.jin@intel.com, Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 3/3] perf annotate: Support '--group' option
Date: Fri, 18 May 2018 20:57:40 +0800
Message-Id: <1526648260-30540-4-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526648260-30540-1-git-send-email-yao.jin@linux.intel.com>
References: <1526648260-30540-1-git-send-email-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the '--group' option, even for non-explicit group, perf annotate
will enable the group output.

For example,

perf record -e cycles,branches ./div
perf annotate main --stdio --group

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

perf annotate main --stdio

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
---
 tools/perf/builtin-annotate.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 6e5d9f7..5272d48 100644
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
+		perf_evlist_forced_leader(annotate.session->evlist);
+
 	ret = symbol__annotation_init();
 	if (ret < 0)
 		goto out_delete;
-- 
2.7.4
