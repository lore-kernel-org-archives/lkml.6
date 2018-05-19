Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752612AbeESK4L (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 06:56:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:43212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752560AbeESK4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 06:56:05 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 15/18] perf annotate: Create hotkey 'c' to show min/max cycles
Date: Sat, 19 May 2018 07:55:04 -0300
Message-Id: <20180519105507.16450-16-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180519105507.16450-1-acme@kernel.org>
References: <20180519105507.16450-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

In the 'perf annotate' view, a new hotkey 'c' is created for showing the
min/max cycles.

For example, when press 'c', the annotate view is:

  Percent│ IPC     Cycle(min/max)
         │
         │
         │                             Disassembly of section .text:
         │
         │                             000000000003aab0 <random@@GLIBC_2.2.5>:
    8.22 │3.92                           sub    $0x18,%rsp
         │3.92                           mov    $0x1,%esi
         │3.92                           xor    %eax,%eax
         │3.92                           cmpl   $0x0,argp_program_version_hook@@G
         │3.92             1(2/1)      ↓ je     20
         │                               lock   cmpxchg %esi,__abort_msg@@GLIBC_P
         │                             ↓ jne    29
         │                             ↓ jmp    43
         │1.10                     20:   cmpxchg %esi,__abort_msg@@GLIBC_PRIVATE+
    8.93 │1.10             1(5/1)      ↓ je     43

When press 'c' again, the annotate view is switched back:

  Percent│ IPC Cycle
         │
         │
         │                Disassembly of section .text:
         │
         │                000000000003aab0 <random@@GLIBC_2.2.5>:
    8.22 │3.92              sub    $0x18,%rsp
         │3.92              mov    $0x1,%esi
         │3.92              xor    %eax,%eax
         │3.92              cmpl   $0x0,argp_program_version_hook@@GLIBC_2.2.5+0x
         │3.92     1      ↓ je     20
         │                  lock   cmpxchg %esi,__abort_msg@@GLIBC_PRIVATE+0x8a0
         │                ↓ jne    29
         │                ↓ jmp    43
         │1.10        20:   cmpxchg %esi,__abort_msg@@GLIBC_PRIVATE+0x8a0
    8.93 │1.10     1      ↓ je     43

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1526569118-14217-3-git-send-email-yao.jin@linux.intel.com
[ Rename all maxmin to minmax ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c |  8 ++++++++
 tools/perf/util/annotate.c        | 37 +++++++++++++++++++++++++++++++------
 tools/perf/util/annotate.h        |  7 ++++++-
 3 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 3781d74088a7..8be40fa903aa 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -695,6 +695,7 @@ static int annotate_browser__run(struct annotate_browser *browser,
 		"O             Bump offset level (jump targets -> +call -> all -> cycle thru)\n"
 		"s             Toggle source code view\n"
 		"t             Circulate percent, total period, samples view\n"
+		"c             Show min/max cycle\n"
 		"/             Search string\n"
 		"k             Toggle line numbers\n"
 		"P             Print to [symbol_name].annotation file.\n"
@@ -791,6 +792,13 @@ static int annotate_browser__run(struct annotate_browser *browser,
 				notes->options->show_total_period = true;
 			annotation__update_column_widths(notes);
 			continue;
+		case 'c':
+			if (notes->options->show_minmax_cycle)
+				notes->options->show_minmax_cycle = false;
+			else
+				notes->options->show_minmax_cycle = true;
+			annotation__update_column_widths(notes);
+			continue;
 		case K_LEFT:
 		case K_ESC:
 		case 'q':
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 4fcfefea3bc2..6612c7f90af4 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2498,13 +2498,38 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
 		else
 			obj__printf(obj, "%*s ", ANNOTATION__IPC_WIDTH - 1, "IPC");
 
-		if (al->cycles)
-			obj__printf(obj, "%*" PRIu64 " ",
+		if (!notes->options->show_minmax_cycle) {
+			if (al->cycles)
+				obj__printf(obj, "%*" PRIu64 " ",
 					   ANNOTATION__CYCLES_WIDTH - 1, al->cycles);
-		else if (!show_title)
-			obj__printf(obj, "%*s", ANNOTATION__CYCLES_WIDTH, " ");
-		else
-			obj__printf(obj, "%*s ", ANNOTATION__CYCLES_WIDTH - 1, "Cycle");
+			else if (!show_title)
+				obj__printf(obj, "%*s",
+					    ANNOTATION__CYCLES_WIDTH, " ");
+			else
+				obj__printf(obj, "%*s ",
+					    ANNOTATION__CYCLES_WIDTH - 1,
+					    "Cycle");
+		} else {
+			if (al->cycles) {
+				char str[32];
+
+				scnprintf(str, sizeof(str),
+					"%" PRIu64 "(%" PRIu64 "/%" PRIu64 ")",
+					al->cycles, al->cycles_min,
+					al->cycles_max);
+
+				obj__printf(obj, "%*s ",
+					    ANNOTATION__MINMAX_CYCLES_WIDTH - 1,
+					    str);
+			} else if (!show_title)
+				obj__printf(obj, "%*s",
+					    ANNOTATION__MINMAX_CYCLES_WIDTH,
+					    " ");
+			else
+				obj__printf(obj, "%*s ",
+					    ANNOTATION__MINMAX_CYCLES_WIDTH - 1,
+					    "Cycle(min/max)");
+		}
 	}
 
 	obj__printf(obj, " ");
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index d50363d56f73..5080b6dd98b8 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -61,6 +61,7 @@ bool ins__is_fused(struct arch *arch, const char *ins1, const char *ins2);
 
 #define ANNOTATION__IPC_WIDTH 6
 #define ANNOTATION__CYCLES_WIDTH 6
+#define ANNOTATION__MINMAX_CYCLES_WIDTH 19
 
 struct annotation_options {
 	bool hide_src_code,
@@ -69,7 +70,8 @@ struct annotation_options {
 	     show_linenr,
 	     show_nr_jumps,
 	     show_nr_samples,
-	     show_total_period;
+	     show_total_period,
+	     show_minmax_cycle;
 	u8   offset_level;
 };
 
@@ -243,6 +245,9 @@ struct annotation {
 
 static inline int annotation__cycles_width(struct annotation *notes)
 {
+	if (notes->have_cycles && notes->options->show_minmax_cycle)
+		return ANNOTATION__IPC_WIDTH + ANNOTATION__MINMAX_CYCLES_WIDTH;
+
 	return notes->have_cycles ? ANNOTATION__IPC_WIDTH + ANNOTATION__CYCLES_WIDTH : 0;
 }
 
-- 
2.14.3
