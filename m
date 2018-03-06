Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750973AbeCFGq1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 01:46:27 -0500
Received: from terminus.zytor.com ([198.137.202.136]:60495 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750785AbeCFGq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 01:46:26 -0500
Date: Mon, 5 Mar 2018 22:46:12 -0800
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-uysyojl1e6nm94amzzzs08tf@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, wangnan0@huawei.com, hpa@zytor.com,
        acme@redhat.com, dsahern@gmail.com, tglx@linutronix.de,
        adrian.hunter@intel.com, jolsa@kernel.org, namhyung@kernel.org,
        mingo@kernel.org
Reply-To: dsahern@gmail.com, acme@redhat.com, wangnan0@huawei.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        tglx@linutronix.de, adrian.hunter@intel.com, jolsa@kernel.org,
        namhyung@kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf annotate: Find 'call' instruction target
 symbol at parsing time
Git-Commit-ID: 696703af37a28892db89ff6a6d0cdfde6fb803ab
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

Commit-ID:  696703af37a28892db89ff6a6d0cdfde6fb803ab
Gitweb:     https://git.kernel.org/tip/696703af37a28892db89ff6a6d0cdfde6fb803ab
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 2 Mar 2018 11:59:36 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 5 Mar 2018 09:58:45 -0300

perf annotate: Find 'call' instruction target symbol at parsing time

So that we do it just once, not everytime we press enter or -> on a
'call' instruction line.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-uysyojl1e6nm94amzzzs08tf@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c | 17 +++++------------
 tools/perf/util/annotate.c        | 38 +++++++++++++++++++++-----------------
 tools/perf/util/annotate.h        |  1 +
 3 files changed, 27 insertions(+), 29 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 6ff6839558b0..618edf96353c 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -568,35 +568,28 @@ static bool annotate_browser__callq(struct annotate_browser *browser,
 	struct map_symbol *ms = browser->b.priv;
 	struct disasm_line *dl = disasm_line(browser->selection);
 	struct annotation *notes;
-	struct addr_map_symbol target = {
-		.map = ms->map,
-		.addr = map__objdump_2mem(ms->map, dl->ops.target.addr),
-	};
 	char title[SYM_TITLE_MAX_SIZE];
 
 	if (!ins__is_call(&dl->ins))
 		return false;
 
-	if (map_groups__find_ams(&target) ||
-	    map__rip_2objdump(target.map, target.map->map_ip(target.map,
-							     target.addr)) !=
-	    dl->ops.target.addr) {
+	if (!dl->ops.target.sym) {
 		ui_helpline__puts("The called function was not found.");
 		return true;
 	}
 
-	notes = symbol__annotation(target.sym);
+	notes = symbol__annotation(dl->ops.target.sym);
 	pthread_mutex_lock(&notes->lock);
 
-	if (notes->src == NULL && symbol__alloc_hist(target.sym) < 0) {
+	if (notes->src == NULL && symbol__alloc_hist(dl->ops.target.sym) < 0) {
 		pthread_mutex_unlock(&notes->lock);
 		ui__warning("Not enough memory for annotating '%s' symbol!\n",
-			    target.sym->name);
+			    dl->ops.target.sym->name);
 		return true;
 	}
 
 	pthread_mutex_unlock(&notes->lock);
-	symbol__tui_annotate(target.sym, target.map, evsel, hbt);
+	symbol__tui_annotate(dl->ops.target.sym, ms->map, evsel, hbt);
 	sym_title(ms->sym, ms->map, title, sizeof(title));
 	ui_browser__show_title(&browser->b, title);
 	return true;
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 28b233c3dcbe..49ff825f745c 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -187,6 +187,9 @@ bool ins__is_fused(struct arch *arch, const char *ins1, const char *ins2)
 static int call__parse(struct arch *arch, struct ins_operands *ops, struct map *map)
 {
 	char *endptr, *tok, *name;
+	struct addr_map_symbol target = {
+		.map = map,
+	};
 
 	ops->target.addr = strtoull(ops->raw, &endptr, 16);
 
@@ -208,28 +211,29 @@ static int call__parse(struct arch *arch, struct ins_operands *ops, struct map *
 	ops->target.name = strdup(name);
 	*tok = '>';
 
-	return ops->target.name == NULL ? -1 : 0;
+	if (ops->target.name == NULL)
+		return -1;
+find_target:
+	target.addr = map__objdump_2mem(map, ops->target.addr);
 
-indirect_call:
-	tok = strchr(endptr, '*');
-	if (tok == NULL) {
-		struct symbol *sym = map__find_symbol(map, map->map_ip(map, ops->target.addr));
-		if (sym != NULL)
-			ops->target.name = strdup(sym->name);
-		else
-			ops->target.addr = 0;
-		return 0;
-	}
+	if (map_groups__find_ams(&target) == 0 &&
+	    map__rip_2objdump(target.map, map->map_ip(target.map, target.addr)) == ops->target.addr)
+		ops->target.sym = target.sym;
 
-	ops->target.addr = strtoull(tok + 1, NULL, 16);
 	return 0;
+
+indirect_call:
+	tok = strchr(endptr, '*');
+	if (tok != NULL)
+		ops->target.addr = strtoull(tok + 1, NULL, 16);
+	goto find_target;
 }
 
 static int call__scnprintf(struct ins *ins, char *bf, size_t size,
 			   struct ins_operands *ops)
 {
-	if (ops->target.name)
-		return scnprintf(bf, size, "%-6s %s", ins->name, ops->target.name);
+	if (ops->target.sym)
+		return scnprintf(bf, size, "%-6s %s", ins->name, ops->target.sym->name);
 
 	if (ops->target.addr == 0)
 		return ins__raw_scnprintf(ins, bf, size, ops);
@@ -1283,8 +1287,8 @@ static int symbol__parse_objdump_line(struct symbol *sym, FILE *file,
 		dl->ops.target.offset_avail = true;
 	}
 
-	/* kcore has no symbols, so add the call target name */
-	if (dl->ins.ops && ins__is_call(&dl->ins) && !dl->ops.target.name) {
+	/* kcore has no symbols, so add the call target symbol */
+	if (dl->ins.ops && ins__is_call(&dl->ins) && !dl->ops.target.sym) {
 		struct addr_map_symbol target = {
 			.map = map,
 			.addr = dl->ops.target.addr,
@@ -1292,7 +1296,7 @@ static int symbol__parse_objdump_line(struct symbol *sym, FILE *file,
 
 		if (!map_groups__find_ams(&target) &&
 		    target.sym->start == target.al_addr)
-			dl->ops.target.name = strdup(target.sym->name);
+			dl->ops.target.sym = target.sym;
 	}
 
 	annotation_line__add(&dl->al, &notes->src->source);
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index ce427445671f..7e914e834101 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -24,6 +24,7 @@ struct ins_operands {
 	struct {
 		char	*raw;
 		char	*name;
+		struct symbol *sym;
 		u64	addr;
 		s64	offset;
 		bool	offset_avail;
