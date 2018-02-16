Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753855AbeBPTT4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 14:19:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:56712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753834AbeBPTTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 14:19:46 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A20A217CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jin Yao <yao.jin@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 31/41] perf report: Fix wrong jump arrow
Date: Fri, 16 Feb 2018 16:17:36 -0300
Message-Id: <20180216191746.11095-32-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180216191746.11095-1-acme@kernel.org>
References: <20180216191746.11095-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

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
index 286427975112..e2f666391ac4 100644
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
-- 
2.14.3
