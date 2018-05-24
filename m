Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935570AbeEXFlu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 01:41:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54341 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935396AbeEXFlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 01:41:46 -0400
Date: Wed, 23 May 2018 22:41:25 -0700
From: tip-bot for Jin Yao <tipbot@zytor.com>
Message-ID: <tip-787e4da9f95fd44376b3af6fa163ac0b3a48a1fc@git.kernel.org>
Cc: acme@redhat.com, jolsa@kernel.org, mingo@kernel.org,
        yao.jin@linux.intel.com, hpa@zytor.com,
        alexander.shishkin@linux.intel.com, tglx@linutronix.de,
        kan.liang@linux.intel.com, ak@linux.intel.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org
Reply-To: linux-kernel@vger.kernel.org, peterz@infradead.org,
        kan.liang@linux.intel.com, ak@linux.intel.com, jolsa@kernel.org,
        acme@redhat.com, alexander.shishkin@linux.intel.com,
        tglx@linutronix.de, mingo@kernel.org, yao.jin@linux.intel.com,
        hpa@zytor.com
In-Reply-To: <1526989115-14435-1-git-send-email-yao.jin@linux.intel.com>
References: <1526989115-14435-1-git-send-email-yao.jin@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf annotate: Show group event string for stdio
Git-Commit-ID: 787e4da9f95fd44376b3af6fa163ac0b3a48a1fc
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

Commit-ID:  787e4da9f95fd44376b3af6fa163ac0b3a48a1fc
Gitweb:     https://git.kernel.org/tip/787e4da9f95fd44376b3af6fa163ac0b3a48a1fc
Author:     Jin Yao <yao.jin@linux.intel.com>
AuthorDate: Tue, 22 May 2018 19:38:35 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 23 May 2018 10:26:40 -0300

perf annotate: Show group event string for stdio

When we enable the group, for tui/stdio2, the output first line includes
the group event string. While for stdio, it will show only one event.

For example,

perf record -e cycles,branches ./div
perf annotate --group --stdio

    Percent |      Source code & Disassembly of div for cycles (44407 samples)
    ......

The first line doesn't include the event 'branches'.

With this patch, it will show the correct group even string.

perf annotate --group --stdio

    Percent |      Source code & Disassembly of div for cycles, branches (44407 samples)
    ......

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Suggested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1526989115-14435-1-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 6612c7f90af4..71897689dacf 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1965,6 +1965,7 @@ int symbol__annotate_printf(struct symbol *sym, struct map *map,
 	u64 len;
 	int width = symbol_conf.show_total_period ? 12 : 8;
 	int graph_dotted_len;
+	char buf[512];
 
 	filename = strdup(dso->long_name);
 	if (!filename)
@@ -1977,8 +1978,11 @@ int symbol__annotate_printf(struct symbol *sym, struct map *map,
 
 	len = symbol__size(sym);
 
-	if (perf_evsel__is_group_event(evsel))
+	if (perf_evsel__is_group_event(evsel)) {
 		width *= evsel->nr_members;
+		perf_evsel__group_desc(evsel, buf, sizeof(buf));
+		evsel_name = buf;
+	}
 
 	graph_dotted_len = printf(" %-*.*s|	Source code & Disassembly of %s for %s (%" PRIu64 " samples)\n",
 				  width, width, symbol_conf.show_total_period ? "Period" :
