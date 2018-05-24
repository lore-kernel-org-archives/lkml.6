Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755023AbeEXFjP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 01:39:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42587 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751845AbeEXFjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 01:39:13 -0400
Date: Wed, 23 May 2018 22:37:52 -0700
From: tip-bot for Jin Yao <tipbot@zytor.com>
Message-ID: <tip-7ebaf4890f63eb90856b76864a0847413cdf6c86@git.kernel.org>
Cc: alexander.shishkin@linux.intel.com, yao.jin@linux.intel.com,
        peterz@infradead.org, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, acme@redhat.com, hpa@zytor.com,
        kan.liang@linux.intel.com, tglx@linutronix.de, mingo@kernel.org
Reply-To: hpa@zytor.com, kan.liang@linux.intel.com, mingo@kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, acme@redhat.com,
        linux-kernel@vger.kernel.org, ak@linux.intel.com, peterz@infradead.org,
        yao.jin@linux.intel.com, alexander.shishkin@linux.intel.com
In-Reply-To: <1526914666-31839-4-git-send-email-yao.jin@linux.intel.com>
References: <1526914666-31839-4-git-send-email-yao.jin@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf annotate: Support '--group' option
Git-Commit-ID: 7ebaf4890f63eb90856b76864a0847413cdf6c86
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

Commit-ID:  7ebaf4890f63eb90856b76864a0847413cdf6c86
Gitweb:     https://git.kernel.org/tip/7ebaf4890f63eb90856b76864a0847413cdf6c86
Author:     Jin Yao <yao.jin@linux.intel.com>
AuthorDate: Mon, 21 May 2018 22:57:46 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 21 May 2018 14:41:25 -0300

perf annotate: Support '--group' option

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
