Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751717AbeEBSBK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 14:01:10 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43567 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751616AbeEBSBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 14:01:06 -0400
Date: Wed, 2 May 2018 10:58:23 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-9ugwxz0i8ryg5702rx8u5q6z@git.kernel.org>
Cc: mingo@kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org,
        hpa@zytor.com, adrian.hunter@intel.com, acme@redhat.com,
        wangnan0@huawei.com, namhyung@kernel.org, dsahern@gmail.com,
        tglx@linutronix.de
Reply-To: hpa@zytor.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, dsahern@gmail.com, namhyung@kernel.org,
        wangnan0@huawei.com, acme@redhat.com, adrian.hunter@intel.com,
        tglx@linutronix.de
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf symbols: Store the ELF symbol type in the
 symbol struct
Git-Commit-ID: af30bffa2f9aa73a648ea932ed468dc3031ac1f9
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

Commit-ID:  af30bffa2f9aa73a648ea932ed468dc3031ac1f9
Gitweb:     https://git.kernel.org/tip/af30bffa2f9aa73a648ea932ed468dc3031ac1f9
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 26 Apr 2018 11:09:10 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 26 Apr 2018 13:47:18 -0300

perf symbols: Store the ELF symbol type in the symbol struct

There is code that needs to see if a resolved address is a function, so,
since we're going to ditch the MAP__{FUNCTION,VARIABLE} split, store
that info in the per symbol struct.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-9ugwxz0i8ryg5702rx8u5q6z@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/hists_common.c | 2 +-
 tools/perf/util/db-export.c     | 2 +-
 tools/perf/util/srcline.c       | 1 +
 tools/perf/util/symbol-elf.c    | 7 ++++---
 tools/perf/util/symbol.c        | 7 ++++---
 tools/perf/util/symbol.h        | 5 +++--
 6 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/tools/perf/tests/hists_common.c b/tools/perf/tests/hists_common.c
index f7c5b613d667..d0366fde72a3 100644
--- a/tools/perf/tests/hists_common.c
+++ b/tools/perf/tests/hists_common.c
@@ -138,7 +138,7 @@ struct machine *setup_fake_machine(struct machines *machines)
 			struct fake_sym *fsym = &fake_symbols[i].syms[k];
 
 			sym = symbol__new(fsym->start, fsym->length,
-					  STB_GLOBAL, fsym->name);
+					  STB_GLOBAL, STT_FUNC, fsym->name);
 			if (sym == NULL) {
 				dso__put(dso);
 				goto out;
diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index 04fb1a99c737..12d60703c8fc 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -247,7 +247,7 @@ static int db_ids_from_al(struct db_export *dbe, struct addr_location *al,
 		*dso_db_id = dso->db_id;
 
 		if (!al->sym) {
-			al->sym = symbol__new(al->addr, 0, 0, "unknown");
+			al->sym = symbol__new(al->addr, 0, 0, 0, "unknown");
 			if (al->sym)
 				dso__insert_symbol(dso, al->map->type, al->sym);
 		}
diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index 3c21fd059b64..09d6746e6ec8 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -103,6 +103,7 @@ static struct symbol *new_inline_sym(struct dso *dso,
 		inline_sym = symbol__new(base_sym ? base_sym->start : 0,
 					 base_sym ? base_sym->end : 0,
 					 base_sym ? base_sym->binding : 0,
+					 base_sym ? base_sym->type : 0,
 					 funcname);
 		if (inline_sym)
 			inline_sym->inlined = 1;
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index b6be6062cae0..88f6f3050665 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -364,7 +364,7 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss, struct map *
 			free(demangled);
 
 			f = symbol__new(plt_offset, plt_entry_size,
-					STB_GLOBAL, sympltname);
+					STB_GLOBAL, STT_FUNC, sympltname);
 			if (!f)
 				goto out_elf_end;
 
@@ -390,7 +390,7 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss, struct map *
 			free(demangled);
 
 			f = symbol__new(plt_offset, plt_entry_size,
-					STB_GLOBAL, sympltname);
+					STB_GLOBAL, STT_FUNC, sympltname);
 			if (!f)
 				goto out_elf_end;
 
@@ -1102,7 +1102,8 @@ new_symbol:
 			elf_name = demangled;
 
 		f = symbol__new(sym.st_value, sym.st_size,
-				GELF_ST_BIND(sym.st_info), elf_name);
+				GELF_ST_BIND(sym.st_info),
+				GELF_ST_TYPE(sym.st_info), elf_name);
 		free(demangled);
 		if (!f)
 			goto out_elf_end;
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 2b81ccc94a7e..e1fd236c96d3 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -256,7 +256,7 @@ out_unlock:
 	up_write(&maps->lock);
 }
 
-struct symbol *symbol__new(u64 start, u64 len, u8 binding, const char *name)
+struct symbol *symbol__new(u64 start, u64 len, u8 binding, u8 type, const char *name)
 {
 	size_t namelen = strlen(name) + 1;
 	struct symbol *sym = calloc(1, (symbol_conf.priv_size +
@@ -274,6 +274,7 @@ struct symbol *symbol__new(u64 start, u64 len, u8 binding, const char *name)
 
 	sym->start   = start;
 	sym->end     = len ? start + len : start;
+	sym->type    = type;
 	sym->binding = binding;
 	sym->namelen = namelen - 1;
 
@@ -682,7 +683,7 @@ static int map__process_kallsym_symbol(void *arg, const char *name,
 	 * symbols, setting length to 0, and rely on
 	 * symbols__fixup_end() to fix it up.
 	 */
-	sym = symbol__new(start, 0, kallsyms2elf_binding(type), name);
+	sym = symbol__new(start, 0, kallsyms2elf_binding(type), kallsyms2elf_type(type), name);
 	if (sym == NULL)
 		return -ENOMEM;
 	/*
@@ -1395,7 +1396,7 @@ static int dso__load_perf_map(const char *map_path, struct dso *dso,
 		if (len + 2 >= line_len)
 			continue;
 
-		sym = symbol__new(start, size, STB_GLOBAL, line + len);
+		sym = symbol__new(start, size, STB_GLOBAL, STT_FUNC, line + len);
 
 		if (sym == NULL)
 			goto out_delete_line;
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 2b985ff2e725..3e2ac485c6d9 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -57,7 +57,8 @@ struct symbol {
 	u64		start;
 	u64		end;
 	u16		namelen;
-	u8		binding;
+	u8		type:4;
+	u8		binding:4;
 	u8		idle:1;
 	u8		ignore:1;
 	u8		inlined:1;
@@ -292,7 +293,7 @@ void symbol__exit(void);
 void symbol__elf_init(void);
 int symbol__annotation_init(void);
 
-struct symbol *symbol__new(u64 start, u64 len, u8 binding, const char *name);
+struct symbol *symbol__new(u64 start, u64 len, u8 binding, u8 type, const char *name);
 size_t __symbol__fprintf_symname_offs(const struct symbol *sym,
 				      const struct addr_location *al,
 				      bool unknown_as_addr,
