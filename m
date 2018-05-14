Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752062AbeENE25 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 00:28:57 -0400
Received: from gandharva.secretlabs.de ([5.9.72.18]:18546 "EHLO
        gandharva.secretlabs.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751515AbeENE2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 00:28:10 -0400
From: Holger Freyther <automatic+kernel@freyther.de>
To: linux-kernel@vger.kernel.org
Cc: Holger Hans Peter Freyther <holgar+kernel@google.com>
Subject: [RFC 3/6] perf probe: Make listing of C++ functions work
Date: Mon, 14 May 2018 12:19:37 +0800
Message-Id: <20180514041940.96126-4-automatic+kernel@freyther.de>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180514041940.96126-1-automatic+kernel@freyther.de>
References: <20180514041940.96126-1-automatic+kernel@freyther.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Holger Hans Peter Freyther <holgar+kernel@google.com>

If die_match_name does not match, attempt to demangle the linkage name.
To use the generic demangling API we require to have a struct dso. Store
it inside the debuginfo and pass it to the relevant callbacks.

./perf probe -x ./foo -L \
	"std::vector<int, std::allocator<int> >::at:2-3"
<...::at@/usr/include/c++/5/bits/stl_vector.h:2>
      2         _M_range_check(__n);
      3         return (*this)[__n];

Signed-off-by: Holger Hans Peter Freyther <holgar+kernel@google.com>
---
 tools/perf/util/probe-finder.c | 55 ++++++++++++++++++++++++++++++++++--------
 tools/perf/util/probe-finder.h |  3 +++
 2 files changed, 48 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index c37fbef..c73dccc 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -96,7 +96,7 @@ static int debuginfo__init_offline_dwarf(struct debuginfo *dbg,
 	return -ENOENT;
 }
 
-static struct debuginfo *__debuginfo__new(const char *path)
+static struct debuginfo *__debuginfo__new(const char *path, struct dso *dso)
 {
 	struct debuginfo *dbg = zalloc(sizeof(*dbg));
 	if (!dbg)
@@ -104,8 +104,10 @@ static struct debuginfo *__debuginfo__new(const char *path)
 
 	if (debuginfo__init_offline_dwarf(dbg, path) < 0)
 		zfree(&dbg);
-	if (dbg)
+	if (dbg) {
 		pr_debug("Open Debuginfo file: %s\n", path);
+		dbg->dso = dso__get(dso);
+	}
 	return dbg;
 }
 
@@ -135,13 +137,15 @@ struct debuginfo *debuginfo__new(const char *path)
 		if (dso__read_binary_type_filename(dso, *type, &nil,
 						   buf, PATH_MAX) < 0)
 			continue;
-		dinfo = __debuginfo__new(buf);
+		dinfo = __debuginfo__new(buf, dso);
 	}
-	dso__put(dso);
 
 out:
 	/* if failed to open all distro debuginfo, open given binary */
-	return dinfo ? : __debuginfo__new(path);
+	if (!dinfo)
+		dinfo = __debuginfo__new(path, dso);
+	dso__put(dso);
+	return dinfo;
 }
 
 void debuginfo__delete(struct debuginfo *dbg)
@@ -149,6 +153,7 @@ void debuginfo__delete(struct debuginfo *dbg)
 	if (dbg) {
 		if (dbg->dwfl)
 			dwfl_end(dbg->dwfl);
+		dso__put(dbg->dso);
 		free(dbg);
 	}
 }
@@ -167,6 +172,32 @@ static struct probe_trace_arg_ref *alloc_trace_arg_ref(long offs)
 }
 
 /*
+ * Check if the the demangled linkage_name matches the function. E.g. the
+ * linkage name of _ZNKSt6vectorIiSaIiEE4sizeEv matching the c++ function name
+ * of std::vector<int, std::allocator<int> >::size() const.
+ */
+static bool matches_demangled(struct debuginfo *dbg, Dwarf_Die *dw_die,
+			      const char *function)
+{
+	const char *name;
+	char *demangled;
+	bool res;
+
+	name = die_get_linkage_name(dw_die);
+	if (!name)
+		return false;
+
+	demangled = dso__demangle_sym(dbg->dso, 0, name);
+	if (!demangled)
+		return false;
+
+	res = strglobmatch(demangled, function);
+	free(demangled);
+	return res;
+}
+
+
+/*
  * Convert a location into trace_arg.
  * If tvar == NULL, this just checks variable can be converted.
  * If fentry == true and vr_die is a parameter, do huristic search
@@ -975,6 +1006,7 @@ static int probe_point_inline_cb(Dwarf_Die *in_die, void *data)
 struct dwarf_callback_param {
 	void *data;
 	int retval;
+	struct debuginfo *dbg;
 };
 
 /* Search function from function name */
@@ -1721,7 +1753,8 @@ static int line_range_search_cb(Dwarf_Die *sp_die, void *data)
 		return DWARF_CB_OK;
 
 	if (die_is_func_def(sp_die) &&
-	    die_match_name(sp_die, lr->function)) {
+	    (die_match_name(sp_die, lr->function) ||
+	     matches_demangled(param->dbg, sp_die, lr->function))) {
 		lf->fname = dwarf_decl_file(sp_die);
 		dwarf_decl_line(sp_die, &lr->offset);
 		pr_debug("fname: %s, lineno:%d\n", lf->fname, lr->offset);
@@ -1744,9 +1777,11 @@ static int line_range_search_cb(Dwarf_Die *sp_die, void *data)
 	return DWARF_CB_OK;
 }
 
-static int find_line_range_by_func(struct line_finder *lf)
+static int find_line_range_by_func(struct debuginfo *dbg,
+				   struct line_finder *lf)
 {
-	struct dwarf_callback_param param = {.data = (void *)lf, .retval = 0};
+	struct dwarf_callback_param param = {
+		.data = (void *)lf, .retval = 0, .dbg = dbg};
 	dwarf_getfuncs(&lf->cu_die, line_range_search_cb, &param, 0);
 	return param.retval;
 }
@@ -1766,7 +1801,7 @@ int debuginfo__find_line_range(struct debuginfo *dbg, struct line_range *lr)
 			.function = lr->function, .file = lr->file,
 			.cu_die = &lf.cu_die, .sp_die = &lf.sp_die, .found = 0};
 		struct dwarf_callback_param line_range_param = {
-			.data = (void *)&lf, .retval = 0};
+			.data = (void *)&lf, .retval = 0, .dbg = dbg};
 
 		dwarf_getpubnames(dbg->dbg, pubname_search_cb,
 				  &pubname_param, 0);
@@ -1796,7 +1831,7 @@ int debuginfo__find_line_range(struct debuginfo *dbg, struct line_range *lr)
 
 		if (!lr->file || lf.fname) {
 			if (lr->function)
-				ret = find_line_range_by_func(&lf);
+				ret = find_line_range_by_func(dbg, &lf);
 			else {
 				lf.lno_s = lr->start;
 				lf.lno_e = lr->end;
diff --git a/tools/perf/util/probe-finder.h b/tools/perf/util/probe-finder.h
index 1625298..e28acbd 100644
--- a/tools/perf/util/probe-finder.h
+++ b/tools/perf/util/probe-finder.h
@@ -14,6 +14,8 @@
 #define PROBE_ARG_VARS		"$vars"
 #define PROBE_ARG_PARAMS	"$params"
 
+struct dso;
+
 static inline int is_c_varname(const char *name)
 {
 	/* TODO */
@@ -32,6 +34,7 @@ struct debuginfo {
 	Dwfl_Module	*mod;
 	Dwfl		*dwfl;
 	Dwarf_Addr	bias;
+	struct dso	*dso;
 };
 
 /* This also tries to open distro debuginfo */
-- 
2.7.4
