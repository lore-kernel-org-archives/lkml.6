Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753504AbeCXUFR (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 16:05:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:38268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753153AbeCXUFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 16:05:13 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EFBE2178E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>,
        Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 42/44] perf annotate: Support jumping from one function to another
Date: Sat, 24 Mar 2018 17:02:09 -0300
Message-Id: <20180324200211.21326-43-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180324200211.21326-1-acme@kernel.org>
References: <20180324200211.21326-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

For instance:

  entry_SYSCALL_64  /lib/modules/4.16.0-rc5-00086-gdf09348f78dc/build/vmlinux
    5.50 │     → callq  do_syscall_64
   14.56 │       mov    0x58(%rsp),%rcx
    7.44 │       mov    0x80(%rsp),%r11
    0.32 │       cmp    %rcx,%r11
         │     → jne    swapgs_restore_regs_and_return_to_usermode
    0.32 │       shl    $0x10,%rcx
    0.32 │       sar    $0x10,%rcx
    3.24 │       cmp    %rcx,%r11
         │     → jne    swapgs_restore_regs_and_return_to_usermode
    2.27 │       cmpq   $0x33,0x88(%rsp)
    1.29 │     → jne    swapgs_restore_regs_and_return_to_usermode
         │       mov    0x30(%rsp),%r11
    8.74 │       cmp    %r11,0x90(%rsp)
         │     → jne    swapgs_restore_regs_and_return_to_usermode
    0.32 │       test   $0x10100,%r11
         │     → jne    swapgs_restore_regs_and_return_to_usermode
    0.32 │       cmpq   $0x2b,0xa0(%rsp)
    0.65 │     → jne    swapgs_restore_regs_and_return_to_usermode

It'll behave just like a "call" instruction, i.e. press enter or right
arrow over one such line and the browser will navigate to the annotated
disassembly of that function, which when exited, via left arrow or esc,
will come back to the calling function.

Now to support jump to an offset on a different function...

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-78o508mqvr8inhj63ddtw7mo@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c | 23 ++++++++++++++++++-----
 tools/perf/util/annotate.c        |  6 ++++--
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index d77896a99570..c02fb437ac8e 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -384,6 +384,15 @@ static int sym_title(struct symbol *sym, struct map *map, char *title,
 	return snprintf(title, sz, "%s  %s", sym->name, map->dso->long_name);
 }
 
+/*
+ * This can be called from external jumps, i.e. jumps from one functon
+ * to another, like from the kernel's entry_SYSCALL_64 function to the
+ * swapgs_restore_regs_and_return_to_usermode() function.
+ *
+ * So all we check here is that dl->ops.target.sym is set, if it is, just
+ * go to that function and when exiting from its disassembly, come back
+ * to the calling function.
+ */
 static bool annotate_browser__callq(struct annotate_browser *browser,
 				    struct perf_evsel *evsel,
 				    struct hist_browser_timer *hbt)
@@ -393,9 +402,6 @@ static bool annotate_browser__callq(struct annotate_browser *browser,
 	struct annotation *notes;
 	char title[SYM_TITLE_MAX_SIZE];
 
-	if (!ins__is_call(&dl->ins))
-		return false;
-
 	if (!dl->ops.target.sym) {
 		ui_helpline__puts("The called function was not found.");
 		return true;
@@ -436,7 +442,9 @@ struct disasm_line *annotate_browser__find_offset(struct annotate_browser *brows
 	return NULL;
 }
 
-static bool annotate_browser__jump(struct annotate_browser *browser)
+static bool annotate_browser__jump(struct annotate_browser *browser,
+				   struct perf_evsel *evsel,
+				   struct hist_browser_timer *hbt)
 {
 	struct disasm_line *dl = disasm_line(browser->selection);
 	u64 offset;
@@ -445,6 +453,11 @@ static bool annotate_browser__jump(struct annotate_browser *browser)
 	if (!ins__is_jump(&dl->ins))
 		return false;
 
+	if (dl->ops.target.outside) {
+		annotate_browser__callq(browser, evsel, hbt);
+		return true;
+	}
+
 	offset = dl->ops.target.offset;
 	dl = annotate_browser__find_offset(browser, offset, &idx);
 	if (dl == NULL) {
@@ -731,7 +744,7 @@ static int annotate_browser__run(struct annotate_browser *browser,
 				goto show_sup_ins;
 			else if (ins__is_ret(&dl->ins))
 				goto out;
-			else if (!(annotate_browser__jump(browser) ||
+			else if (!(annotate_browser__jump(browser, evsel, hbt) ||
 				     annotate_browser__callq(browser, evsel, hbt))) {
 show_sup_ins:
 				ui_helpline__puts("Actions are only available for function call/return & jump/branch instructions.");
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 9524f322f597..5fa270b24eea 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -332,11 +332,10 @@ static int jump__parse(struct arch *arch __maybe_unused, struct ins_operands *op
 	 *
 	 * Actual navigation will come next, with further understanding of how
 	 * the symbol searching and disassembly should be done.
-
+	 */
 	if (map_groups__find_ams(&target) == 0 &&
 	    map__rip_2objdump(target.map, map->map_ip(target.map, target.addr)) == ops->target.addr)
 		ops->target.sym = target.sym;
-	 */
 
 	if (s++ != NULL) {
 		ops->target.offset = strtoull(s, NULL, 16);
@@ -356,6 +355,9 @@ static int jump__scnprintf(struct ins *ins, char *bf, size_t size,
 	if (!ops->target.addr || ops->target.offset < 0)
 		return ins__raw_scnprintf(ins, bf, size, ops);
 
+	if (ops->target.outside && ops->target.sym != NULL)
+		return scnprintf(bf, size, "%-6s %s", ins->name, ops->target.sym->name);
+
 	if (c != NULL) {
 		const char *c2 = strchr(c + 1, ',');
 
-- 
2.14.3
