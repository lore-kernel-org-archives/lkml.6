Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752516AbeESLrC (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 07:47:02 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51751 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752153AbeESLq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 07:46:59 -0400
Date: Sat, 19 May 2018 04:46:39 -0700
From: tip-bot for Jin Yao <tipbot@zytor.com>
Message-ID: <tip-3e71fc0319775723adc08991ba7fbaeff1150347@git.kernel.org>
Cc: tglx@linutronix.de, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, hpa@zytor.com, acme@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com, mingo@kernel.org, kan.liang@linux.intel.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org
Reply-To: kan.liang@linux.intel.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, alexander.shishkin@linux.intel.com,
        tglx@linutronix.de, hpa@zytor.com, jolsa@kernel.org, acme@redhat.com,
        ak@linux.intel.com, mingo@kernel.org, yao.jin@linux.intel.com
In-Reply-To: <1526569118-14217-3-git-send-email-yao.jin@linux.intel.com>
References: <1526569118-14217-3-git-send-email-yao.jin@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf annotate: Create hotkey 'c' to show min/max
 cycles
Git-Commit-ID: 3e71fc0319775723adc08991ba7fbaeff1150347
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

Commit-ID:  3e71fc0319775723adc08991ba7fbaeff1150347
Gitweb:     https://git.kernel.org/tip/3e71fc0319775723adc08991ba7fbaeff1150347
Author:     Jin Yao <yao.jin@linux.intel.com>
AuthorDate: Thu, 17 May 2018 22:58:38 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Sat, 19 May 2018 06:42:49 -0300

perf annotate: Create hotkey 'c' to show min/max cycles

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
@@ -791,6 +792,13 @@ show_sup_ins:
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
 
