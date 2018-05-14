Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752035AbeENE2M (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 00:28:12 -0400
Received: from gandharva.secretlabs.de ([5.9.72.18]:38437 "EHLO
        gandharva.secretlabs.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751362AbeENE2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 00:28:08 -0400
From: Holger Freyther <automatic+kernel@freyther.de>
To: linux-kernel@vger.kernel.org
Cc: Holger Hans Peter Freyther <holgar+kernel@google.com>
Subject: [RFC 5/6] perf probe: Make listing of variables work for C++ functions
Date: Mon, 14 May 2018 12:19:39 +0800
Message-Id: <20180514041940.96126-6-automatic+kernel@freyther.de>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180514041940.96126-1-automatic+kernel@freyther.de>
References: <20180514041940.96126-1-automatic+kernel@freyther.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Holger Hans Peter Freyther <holgar+kernel@google.com>

Update call sites with die_match_name to call matches_demangled as well.
This requires to pass the struct debuginfo/struct dso to the callbacks
and modifies the closure/void *data parameter. For most functions this
will change the parameter from struct probe_finder to the generic struct
dwarf_callback_param.

$ ./perf probe -x ./foo -V "std::vector<int, std::allocator<int> >::at"
Available variables at std::vector<int, std::allocator<int> >::at
        @<at+0>
                size_type       __n
                vector<int, std::allocator<int> >*      this

Signed-off-by: Holger Hans Peter Freyther <holgar+kernel@google.com>
---
 tools/perf/util/probe-finder.c | 88 +++++++++++++++++++++++++++---------------
 1 file changed, 56 insertions(+), 32 deletions(-)

diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index c73dccc..4ba4b18 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -760,6 +760,7 @@ struct find_scope_param {
 	int line;
 	int diff;
 	Dwarf_Die *die_mem;
+	struct debuginfo *dbg;
 	bool found;
 };
 
@@ -777,7 +778,8 @@ static int find_best_scope_cb(Dwarf_Die *fn_die, void *data)
 	}
 	/* If the function name is given, that's what user expects */
 	if (fsp->function) {
-		if (die_match_name(fn_die, fsp->function)) {
+		if (die_match_name(fn_die, fsp->function) ||
+			matches_demangled(fsp->dbg, fn_die, fsp->function)) {
 			memcpy(fsp->die_mem, fn_die, sizeof(Dwarf_Die));
 			fsp->found = true;
 			return 1;
@@ -795,8 +797,16 @@ static int find_best_scope_cb(Dwarf_Die *fn_die, void *data)
 	return 0;
 }
 
+/* Callback parameter with return value for libdw */
+struct dwarf_callback_param {
+	void *data;
+	int retval;
+	struct debuginfo *dbg;
+};
+
 /* Find an appropriate scope fits to given conditions */
-static Dwarf_Die *find_best_scope(struct probe_finder *pf, Dwarf_Die *die_mem)
+static Dwarf_Die *find_best_scope(struct debuginfo *dbg,
+				  struct probe_finder *pf, Dwarf_Die *die_mem)
 {
 	struct find_scope_param fsp = {
 		.function = pf->pev->point.function,
@@ -804,6 +814,7 @@ static Dwarf_Die *find_best_scope(struct probe_finder *pf, Dwarf_Die *die_mem)
 		.line = pf->lno,
 		.diff = INT_MAX,
 		.die_mem = die_mem,
+		.dbg = dbg,
 		.found = false,
 	};
 
@@ -815,7 +826,8 @@ static Dwarf_Die *find_best_scope(struct probe_finder *pf, Dwarf_Die *die_mem)
 static int probe_point_line_walker(const char *fname, int lineno,
 				   Dwarf_Addr addr, void *data)
 {
-	struct probe_finder *pf = data;
+	struct dwarf_callback_param *param = data;
+	struct probe_finder *pf = param->data;
 	Dwarf_Die *sc_die, die_mem;
 	int ret;
 
@@ -823,7 +835,7 @@ static int probe_point_line_walker(const char *fname, int lineno,
 		return 0;
 
 	pf->addr = addr;
-	sc_die = find_best_scope(pf, &die_mem);
+	sc_die = find_best_scope(param->dbg, pf, &die_mem);
 	if (!sc_die) {
 		pr_warning("Failed to find scope of probe point.\n");
 		return -ENOENT;
@@ -836,9 +848,12 @@ static int probe_point_line_walker(const char *fname, int lineno,
 }
 
 /* Find probe point from its line number */
-static int find_probe_point_by_line(struct probe_finder *pf)
+static int find_probe_point_by_line(struct debuginfo *dbg,
+				    struct probe_finder *pf)
 {
-	return die_walk_lines(&pf->cu_die, probe_point_line_walker, pf);
+	struct dwarf_callback_param param = {
+		.data = (void *)pf, .dbg = dbg, .retval = 0};
+	return die_walk_lines(&pf->cu_die, probe_point_line_walker, &param);
 }
 
 /* Find lines which match lazy pattern */
@@ -884,7 +899,8 @@ static int find_lazy_match_lines(struct intlist *list,
 static int probe_point_lazy_walker(const char *fname, int lineno,
 				   Dwarf_Addr addr, void *data)
 {
-	struct probe_finder *pf = data;
+	struct dwarf_callback_param *param = data;
+	struct probe_finder *pf = param->data;
 	Dwarf_Die *sc_die, die_mem;
 	int ret;
 
@@ -896,7 +912,7 @@ static int probe_point_lazy_walker(const char *fname, int lineno,
 		 lineno, (unsigned long long)addr);
 	pf->addr = addr;
 	pf->lno = lineno;
-	sc_die = find_best_scope(pf, &die_mem);
+	sc_die = find_best_scope(param->dbg, pf, &die_mem);
 	if (!sc_die) {
 		pr_warning("Failed to find scope of probe point.\n");
 		return -ENOENT;
@@ -912,8 +928,10 @@ static int probe_point_lazy_walker(const char *fname, int lineno,
 }
 
 /* Find probe points from lazy pattern  */
-static int find_probe_point_lazy(Dwarf_Die *sp_die, struct probe_finder *pf)
+static int find_probe_point_lazy(Dwarf_Die *sp_die,
+				 struct dwarf_callback_param *param)
 {
+	struct probe_finder *pf = param->data;
 	int ret = 0;
 	char *fpath;
 
@@ -935,7 +953,7 @@ static int find_probe_point_lazy(Dwarf_Die *sp_die, struct probe_finder *pf)
 			return ret;
 	}
 
-	return die_walk_lines(sp_die, probe_point_lazy_walker, pf);
+	return die_walk_lines(sp_die, probe_point_lazy_walker, param);
 }
 
 static void skip_prologue(Dwarf_Die *sp_die, struct probe_finder *pf)
@@ -972,13 +990,14 @@ static void skip_prologue(Dwarf_Die *sp_die, struct probe_finder *pf)
 
 static int probe_point_inline_cb(Dwarf_Die *in_die, void *data)
 {
-	struct probe_finder *pf = data;
+	struct dwarf_callback_param *param = data;
+	struct probe_finder *pf = param->data;
 	struct perf_probe_point *pp = &pf->pev->point;
 	Dwarf_Addr addr;
 	int ret;
 
 	if (pp->lazy_line)
-		ret = find_probe_point_lazy(in_die, pf);
+		ret = find_probe_point_lazy(in_die, param);
 	else {
 		/* Get probe address */
 		if (dwarf_entrypc(in_die, &addr) != 0) {
@@ -1002,13 +1021,6 @@ static int probe_point_inline_cb(Dwarf_Die *in_die, void *data)
 	return ret;
 }
 
-/* Callback parameter with return value for libdw */
-struct dwarf_callback_param {
-	void *data;
-	int retval;
-	struct debuginfo *dbg;
-};
-
 /* Search function from function name */
 static int probe_point_search_cb(Dwarf_Die *sp_die, void *data)
 {
@@ -1018,7 +1030,8 @@ static int probe_point_search_cb(Dwarf_Die *sp_die, void *data)
 
 	/* Check tag and diename */
 	if (!die_is_func_def(sp_die) ||
-	    !die_match_name(sp_die, pp->function))
+	    (!die_match_name(sp_die, pp->function) &&
+	     !matches_demangled(param->dbg, sp_die, pp->function)))
 		return DWARF_CB_OK;
 
 	/* Check declared file */
@@ -1031,7 +1044,7 @@ static int probe_point_search_cb(Dwarf_Die *sp_die, void *data)
 	if (pp->line) { /* Function relative line */
 		dwarf_decl_line(sp_die, &pf->lno);
 		pf->lno += pp->line;
-		param->retval = find_probe_point_by_line(pf);
+		param->retval = find_probe_point_by_line(param->dbg, pf);
 	} else if (die_is_func_instance(sp_die)) {
 		/* Instances always have the entry address */
 		dwarf_entrypc(sp_die, &pf->addr);
@@ -1042,7 +1055,7 @@ static int probe_point_search_cb(Dwarf_Die *sp_die, void *data)
 			param->retval = 0;
 		/* Real function */
 		} else if (pp->lazy_line)
-			param->retval = find_probe_point_lazy(sp_die, pf);
+			param->retval = find_probe_point_lazy(sp_die, param);
 		else {
 			skip_prologue(sp_die, pf);
 			pf->addr += pp->offset;
@@ -1052,7 +1065,7 @@ static int probe_point_search_cb(Dwarf_Die *sp_die, void *data)
 	} else if (!probe_conf.no_inlines) {
 		/* Inlined function: search instances */
 		param->retval = die_walk_instances(sp_die,
-					probe_point_inline_cb, (void *)pf);
+					probe_point_inline_cb, data);
 		/* This could be a non-existed inline definition */
 		if (param->retval == -ENOENT)
 			param->retval = 0;
@@ -1067,9 +1080,10 @@ static int probe_point_search_cb(Dwarf_Die *sp_die, void *data)
 	return DWARF_CB_ABORT; /* Exit; no same symbol in this CU. */
 }
 
-static int find_probe_point_by_func(struct probe_finder *pf)
+static int find_probe_point_by_func(struct debuginfo *dbg,
+				    struct probe_finder *pf)
 {
-	struct dwarf_callback_param _param = {.data = (void *)pf,
+	struct dwarf_callback_param _param = {.data = (void *)pf, .dbg = dbg,
 					      .retval = 0};
 	dwarf_getfuncs(&pf->cu_die, probe_point_search_cb, &_param, 0);
 	return _param.retval;
@@ -1080,6 +1094,7 @@ struct pubname_callback_param {
 	char *file;
 	Dwarf_Die *cu_die;
 	Dwarf_Die *sp_die;
+	struct debuginfo *dbg;
 	int found;
 };
 
@@ -1091,7 +1106,9 @@ static int pubname_search_cb(Dwarf *dbg, Dwarf_Global *gl, void *data)
 		if (dwarf_tag(param->sp_die) != DW_TAG_subprogram)
 			return DWARF_CB_OK;
 
-		if (die_match_name(param->sp_die, param->function)) {
+		if (die_match_name(param->sp_die, param->function) ||
+			matches_demangled(param->dbg, param->sp_die,
+					  param->function)) {
 			if (!dwarf_offdie(dbg, gl->cu_offset, param->cu_die))
 				return DWARF_CB_OK;
 
@@ -1128,10 +1145,12 @@ static int debuginfo__find_probe_location(struct debuginfo *dbg,
 			.file	  = pp->file,
 			.cu_die	  = &pf->cu_die,
 			.sp_die	  = &pf->sp_die,
+			.dbg      = dbg,
 			.found	  = 0,
 		};
 		struct dwarf_callback_param probe_param = {
 			.data = pf,
+			.dbg  = dbg,
 		};
 
 		dwarf_getpubnames(dbg->dbg, pubname_search_cb,
@@ -1158,12 +1177,17 @@ static int debuginfo__find_probe_location(struct debuginfo *dbg,
 
 		if (!pp->file || pf->fname) {
 			if (pp->function)
-				ret = find_probe_point_by_func(pf);
-			else if (pp->lazy_line)
-				ret = find_probe_point_lazy(&pf->cu_die, pf);
-			else {
+				ret = find_probe_point_by_func(dbg, pf);
+			else if (pp->lazy_line) {
+				struct dwarf_callback_param probe_param = {
+					.data = pf,
+					.dbg  = dbg,
+				};
+				ret = find_probe_point_lazy(&pf->cu_die,
+							    &probe_param);
+			} else {
 				pf->lno = pp->line;
-				ret = find_probe_point_by_line(pf);
+				ret = find_probe_point_by_line(dbg, pf);
 			}
 			if (ret < 0)
 				break;
@@ -1798,7 +1822,7 @@ int debuginfo__find_line_range(struct debuginfo *dbg, struct line_range *lr)
 	/* Fastpath: lookup by function name from .debug_pubnames section */
 	if (lr->function) {
 		struct pubname_callback_param pubname_param = {
-			.function = lr->function, .file = lr->file,
+			.function = lr->function, .file = lr->file, .dbg = dbg,
 			.cu_die = &lf.cu_die, .sp_die = &lf.sp_die, .found = 0};
 		struct dwarf_callback_param line_range_param = {
 			.data = (void *)&lf, .retval = 0, .dbg = dbg};
-- 
2.7.4
