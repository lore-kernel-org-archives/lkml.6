Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751195AbeBQLpt (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 06:45:49 -0500
Received: from terminus.zytor.com ([198.137.202.136]:38539 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750951AbeBQLpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 06:45:47 -0500
Date: Sat, 17 Feb 2018 03:34:24 -0800
From: tip-bot for Jin Yao <tipbot@zytor.com>
Message-ID: <tip-b40982e8468b46b8f7f5bba5a7e541ec04a29d7d@git.kernel.org>
Cc: hpa@zytor.com, tglx@linutronix.de, mingo@kernel.org,
        ak@linux.intel.com, alexander.shishkin@linux.intel.com,
        yao.jin@intel.com, acme@redhat.com, kan.liang@intel.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org, jolsa@kernel.org,
        yao.jin@linux.intel.com
Reply-To: peterz@infradead.org, kan.liang@intel.com, yao.jin@linux.intel.com,
        jolsa@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org,
        hpa@zytor.com, tglx@linutronix.de, acme@redhat.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        yao.jin@intel.com
In-Reply-To: <1517223473-14750-1-git-send-email-yao.jin@linux.intel.com>
References: <1517223473-14750-1-git-send-email-yao.jin@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf report: Fix wrong jump arrow
Git-Commit-ID: b40982e8468b46b8f7f5bba5a7e541ec04a29d7d
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

Commit-ID:  b40982e8468b46b8f7f5bba5a7e541ec04a29d7d
Gitweb:     https://git.kernel.org/tip/b40982e8468b46b8f7f5bba5a7e541ec04a29d7d
Author:     Jin Yao <yao.jin@linux.intel.com>
AuthorDate: Mon, 29 Jan 2018 18:57:53 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 16 Feb 2018 14:55:47 -0300

perf report: Fix wrong jump arrow

When we use perf report interactive annotate view, we can see
the position of jump arrow is not correct. For example,

1. perf record -b ...
2. perf report
3. In interactive mode, select Annotate 'function'

Percent│ IPC Cycle
       │                                if (flag)
  1.37 │0.4┌──   1      ↓ je     82
       │   │                                    x += x / y + y / x;
  0.00 │0.4│  1310        movsd  (%rsp),%xmm0
  0.00 │0.4│   565        movsd  0x8(%rsp),%xmm4
       │0.4│              movsd  0x8(%rsp),%xmm1
       │0.4│              movsd  (%rsp),%xmm3
       │0.4│              divsd  %xmm4,%xmm0
  0.00 │0.4│   579        divsd  %xmm3,%xmm1
       │0.4│              movsd  (%rsp),%xmm2
       │0.4│              addsd  %xmm1,%xmm0
       │0.4│              addsd  %xmm2,%xmm0
  0.00 │0.4│              movsd  %xmm0,(%rsp)
       │   │                    volatile double x = 1212121212, y = 121212;
       │   │
       │   │                    s_randseed = time(0);
       │   │                    srand(s_randseed);
       │   │
       │   │                    for (i = 0; i < 2000000000; i++) {
  1.37 │0.4└─→      82:   sub    $0x1,%ebx
 28.21 │0.48    17      ↑ jne    38

The jump arrow in above example is not correct. It should add the
width of IPC and Cycle.

With this patch, the result is:

Percent│ IPC Cycle
       │                                if (flag)
  1.37 │0.48     1     ┌──je     82
       │               │                        x += x / y + y / x;
  0.00 │0.48  1310     │  movsd  (%rsp),%xmm0
  0.00 │0.48   565     │  movsd  0x8(%rsp),%xmm4
       │0.48           │  movsd  0x8(%rsp),%xmm1
       │0.48           │  movsd  (%rsp),%xmm3
       │0.48           │  divsd  %xmm4,%xmm0
  0.00 │0.48   579     │  divsd  %xmm3,%xmm1
       │0.48           │  movsd  (%rsp),%xmm2
       │0.48           │  addsd  %xmm1,%xmm0
       │0.48           │  addsd  %xmm2,%xmm0
  0.00 │0.48           │  movsd  %xmm0,(%rsp)
       │               │        volatile double x = 1212121212, y = 121212;
       │               │
       │               │        s_randseed = time(0);
       │               │        srand(s_randseed);
       │               │
       │               │        for (i = 0; i < 2000000000; i++) {
  1.37 │0.48        82:└─→sub    $0x1,%ebx
 28.21 │0.48    17      ↑ jne    38

Committer notes:

Please note that only from LBRv5 (according to Jiri) onwards, i.e. >=
Skylake is that we'll have the cycles counts in each branch record
entry, so to see the Cycles and IPC columns, and be able to test this
patch, one need a capable hardware.

While applying this I first tested it on a Broadwell class machine and
couldn't get those columns, will add code to the annotate browser to
warn the user about that, i.e. you have branch records, but no cycles,
use a more recent hardware to get the cycles and IPC columns.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1517223473-14750-1-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 2864279..e2f6663 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -319,6 +319,7 @@ static void annotate_browser__draw_current_jump(struct ui_browser *browser)
 	struct map_symbol *ms = ab->b.priv;
 	struct symbol *sym = ms->sym;
 	u8 pcnt_width = annotate_browser__pcnt_width(ab);
+	int width = 0;
 
 	/* PLT symbols contain external offsets */
 	if (strstr(sym->name, "@plt"))
@@ -340,13 +341,17 @@ static void annotate_browser__draw_current_jump(struct ui_browser *browser)
 		to = (u64)btarget->idx;
 	}
 
+	if (ab->have_cycles)
+		width = IPC_WIDTH + CYCLES_WIDTH;
+
 	ui_browser__set_color(browser, HE_COLORSET_JUMP_ARROWS);
-	__ui_browser__line_arrow(browser, pcnt_width + 2 + ab->addr_width,
+	__ui_browser__line_arrow(browser,
+				 pcnt_width + 2 + ab->addr_width + width,
 				 from, to);
 
 	if (is_fused(ab, cursor)) {
 		ui_browser__mark_fused(browser,
-				       pcnt_width + 3 + ab->addr_width,
+				       pcnt_width + 3 + ab->addr_width + width,
 				       from - 1,
 				       to > from ? true : false);
 	}
