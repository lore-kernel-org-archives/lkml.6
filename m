Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752603AbeEBPYX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 11:24:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:48274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752353AbeEBPWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 11:22:21 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 45/52] perf symbols: Unify symbol maps
Date: Wed,  2 May 2018 12:19:35 -0300
Message-Id: <20180502151942.20542-46-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180502151942.20542-1-acme@kernel.org>
References: <20180502151942.20542-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Remove the split of symbol tables for data (MAP__VARIABLE) and for
functions (MAP__FUNCTION), its unneeded and there were various places
doing two lookups to find a symbol, so simplify this.

We still will consider only the symbols that matched the filters in
place, i.e. see the (elf_(sec,sym)|symbol_type)__filter() routines in
the patch, just so that we consider only the same symbols as before,
to reduce the possibility of regressions.

All the tests on 50-something build environments, in varios versions
of lots of distros and cross build environments were performed without
build regressions, as usual with all pull requests the other tests were
also performed: 'perf test' and 'make -C tools/perf build-test'.

Also this was done at a great granularity so that regressions can be
bisected more easily.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-hiq0fy2rsleupnqqwuojo1ne@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-annotate.c    |   2 +-
 tools/perf/builtin-report.c      |   5 +-
 tools/perf/tests/hists_common.c  |   4 +-
 tools/perf/ui/browsers/map.c     |   2 +-
 tools/perf/util/db-export.c      |   2 +-
 tools/perf/util/dso.c            |  34 ++++------
 tools/perf/util/dso.h            |  36 +++++-----
 tools/perf/util/event.c          |  13 +---
 tools/perf/util/machine.c        | 124 +++++++++++++----------------------
 tools/perf/util/machine.h        |  32 +++------
 tools/perf/util/map.c            |  91 ++++++++------------------
 tools/perf/util/map.h            |  54 ++++-----------
 tools/perf/util/probe-event.c    |   9 ++-
 tools/perf/util/session.c        |  13 ++--
 tools/perf/util/symbol-elf.c     |  51 +++++----------
 tools/perf/util/symbol-minimal.c |   3 +-
 tools/perf/util/symbol.c         | 138 +++++++++++++++------------------------
 tools/perf/util/symbol.h         |  16 ++---
 tools/perf/util/symbol_fprintf.c |   4 +-
 tools/perf/util/thread.c         |  30 ++++-----
 20 files changed, 232 insertions(+), 431 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 51709a961496..6e5d9f718154 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -228,7 +228,7 @@ static int perf_evsel__add_sample(struct perf_evsel *evsel,
 		 */
 		if (al->sym != NULL) {
 			rb_erase(&al->sym->rb_node,
-				 &al->map->dso->symbols[al->map->type]);
+				 &al->map->dso->symbols);
 			symbol__delete(al->sym);
 			dso__reset_find_symbol_cache(al->map->dso);
 		}
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 68ea336bf311..4c931afb2e80 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -715,10 +715,7 @@ static size_t maps__fprintf_task(struct maps *maps, int indent, FILE *fp)
 
 static int map_groups__fprintf_task(struct map_groups *mg, int indent, FILE *fp)
 {
-	int printed = 0, i;
-	for (i = 0; i < MAP__NR_TYPES; ++i)
-		printed += maps__fprintf_task(&mg->maps[i], indent, fp);
-	return printed;
+	return maps__fprintf_task(&mg->maps, indent, fp);
 }
 
 static void task__print_level(struct task *task, FILE *fp, int level)
diff --git a/tools/perf/tests/hists_common.c b/tools/perf/tests/hists_common.c
index d0366fde72a3..b889a28fd80b 100644
--- a/tools/perf/tests/hists_common.c
+++ b/tools/perf/tests/hists_common.c
@@ -131,7 +131,7 @@ struct machine *setup_fake_machine(struct machines *machines)
 			goto out;
 
 		/* emulate dso__load() */
-		dso__set_loaded(dso, MAP__FUNCTION);
+		dso__set_loaded(dso);
 
 		for (k = 0; k < fake_symbols[i].nr_syms; k++) {
 			struct symbol *sym;
@@ -144,7 +144,7 @@ struct machine *setup_fake_machine(struct machines *machines)
 				goto out;
 			}
 
-			symbols__insert(&dso->symbols[MAP__FUNCTION], sym);
+			symbols__insert(&dso->symbols, sym);
 		}
 
 		dso__put(dso);
diff --git a/tools/perf/ui/browsers/map.c b/tools/perf/ui/browsers/map.c
index e03fa75f108a..5b8b8c637686 100644
--- a/tools/perf/ui/browsers/map.c
+++ b/tools/perf/ui/browsers/map.c
@@ -104,7 +104,7 @@ int map__browse(struct map *map)
 {
 	struct map_browser mb = {
 		.b = {
-			.entries = &map->dso->symbols[map->type],
+			.entries = &map->dso->symbols,
 			.refresh = ui_browser__rb_tree_refresh,
 			.seek	 = ui_browser__rb_tree_seek,
 			.write	 = map_browser__write,
diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index 12d60703c8fc..7123746edcf4 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -249,7 +249,7 @@ static int db_ids_from_al(struct db_export *dbe, struct addr_location *al,
 		if (!al->sym) {
 			al->sym = symbol__new(al->addr, 0, 0, 0, "unknown");
 			if (al->sym)
-				dso__insert_symbol(dso, al->map->type, al->sym);
+				dso__insert_symbol(dso, al->sym);
 		}
 
 		if (al->sym) {
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 36ef45b2e89d..cdfc2e5f55f5 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1014,7 +1014,7 @@ struct map *dso__new_map(const char *name)
 	struct dso *dso = dso__new(name);
 
 	if (dso)
-		map = map__new2(0, dso, MAP__FUNCTION);
+		map = map__new2(0, dso);
 
 	return map;
 }
@@ -1176,19 +1176,19 @@ int dso__name_len(const struct dso *dso)
 	return dso->short_name_len;
 }
 
-bool dso__loaded(const struct dso *dso, enum map_type type)
+bool dso__loaded(const struct dso *dso)
 {
-	return dso->loaded & (1 << type);
+	return dso->loaded;
 }
 
-bool dso__sorted_by_name(const struct dso *dso, enum map_type type)
+bool dso__sorted_by_name(const struct dso *dso)
 {
-	return dso->sorted_by_name & (1 << type);
+	return dso->sorted_by_name;
 }
 
-void dso__set_sorted_by_name(struct dso *dso, enum map_type type)
+void dso__set_sorted_by_name(struct dso *dso)
 {
-	dso->sorted_by_name |= (1 << type);
+	dso->sorted_by_name = true;
 }
 
 struct dso *dso__new(const char *name)
@@ -1196,12 +1196,10 @@ struct dso *dso__new(const char *name)
 	struct dso *dso = calloc(1, sizeof(*dso) + strlen(name) + 1);
 
 	if (dso != NULL) {
-		int i;
 		strcpy(dso->name, name);
 		dso__set_long_name(dso, dso->name, false);
 		dso__set_short_name(dso, dso->name, false);
-		for (i = 0; i < MAP__NR_TYPES; ++i)
-			dso->symbols[i] = dso->symbol_names[i] = RB_ROOT;
+		dso->symbols = dso->symbol_names = RB_ROOT;
 		dso->data.cache = RB_ROOT;
 		dso->inlined_nodes = RB_ROOT;
 		dso->srclines = RB_ROOT;
@@ -1231,8 +1229,6 @@ struct dso *dso__new(const char *name)
 
 void dso__delete(struct dso *dso)
 {
-	int i;
-
 	if (!RB_EMPTY_NODE(&dso->rb_node))
 		pr_err("DSO %s is still in rbtree when being deleted!\n",
 		       dso->long_name);
@@ -1240,8 +1236,7 @@ void dso__delete(struct dso *dso)
 	/* free inlines first, as they reference symbols */
 	inlines__tree_delete(&dso->inlined_nodes);
 	srcline__tree_delete(&dso->srclines);
-	for (i = 0; i < MAP__NR_TYPES; ++i)
-		symbols__delete(&dso->symbols[i]);
+	symbols__delete(&dso->symbols);
 
 	if (dso->short_name_allocated) {
 		zfree((char **)&dso->short_name);
@@ -1451,9 +1446,7 @@ size_t __dsos__fprintf(struct list_head *head, FILE *fp)
 	size_t ret = 0;
 
 	list_for_each_entry(pos, head, node) {
-		int i;
-		for (i = 0; i < MAP__NR_TYPES; ++i)
-			ret += dso__fprintf(pos, i, fp);
+		ret += dso__fprintf(pos, fp);
 	}
 
 	return ret;
@@ -1467,18 +1460,17 @@ size_t dso__fprintf_buildid(struct dso *dso, FILE *fp)
 	return fprintf(fp, "%s", sbuild_id);
 }
 
-size_t dso__fprintf(struct dso *dso, enum map_type type, FILE *fp)
+size_t dso__fprintf(struct dso *dso, FILE *fp)
 {
 	struct rb_node *nd;
 	size_t ret = fprintf(fp, "dso: %s (", dso->short_name);
 
 	if (dso->short_name != dso->long_name)
 		ret += fprintf(fp, "%s, ", dso->long_name);
-	ret += fprintf(fp, "%s, %sloaded, ", map_type__name[type],
-		       dso__loaded(dso, type) ? "" : "NOT ");
+	ret += fprintf(fp, "%sloaded, ", dso__loaded(dso) ? "" : "NOT ");
 	ret += dso__fprintf_buildid(dso, fp);
 	ret += fprintf(fp, ")\n");
-	for (nd = rb_first(&dso->symbols[type]); nd; nd = rb_next(nd)) {
+	for (nd = rb_first(&dso->symbols); nd; nd = rb_next(nd)) {
 		struct symbol *pos = rb_entry(nd, struct symbol, rb_node);
 		ret += symbol__fprintf(pos, fp);
 	}
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 881d572be6aa..ef69de2e69ea 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -140,14 +140,14 @@ struct dso {
 	struct list_head node;
 	struct rb_node	 rb_node;	/* rbtree node sorted by long name */
 	struct rb_root	 *root;		/* root of rbtree that rb_node is in */
-	struct rb_root	 symbols[MAP__NR_TYPES];
-	struct rb_root	 symbol_names[MAP__NR_TYPES];
+	struct rb_root	 symbols;
+	struct rb_root	 symbol_names;
 	struct rb_root	 inlined_nodes;
 	struct rb_root	 srclines;
 	struct {
 		u64		addr;
 		struct symbol	*symbol;
-	} last_find_result[MAP__NR_TYPES];
+	} last_find_result;
 	void		 *a2l;
 	char		 *symsrc_filename;
 	unsigned int	 a2l_fails;
@@ -164,8 +164,8 @@ struct dso {
 	u8		 short_name_allocated:1;
 	u8		 long_name_allocated:1;
 	u8		 is_64_bit:1;
-	u8		 sorted_by_name;
-	u8		 loaded;
+	bool		 sorted_by_name;
+	bool		 loaded;
 	u8		 rel;
 	u8		 build_id[BUILD_ID_SIZE];
 	u64		 text_offset;
@@ -202,14 +202,13 @@ struct dso {
  * @dso: the 'struct dso *' in which symbols itereated
  * @pos: the 'struct symbol *' to use as a loop cursor
  * @n: the 'struct rb_node *' to use as a temporary storage
- * @type: the 'enum map_type' type of symbols
  */
-#define dso__for_each_symbol(dso, pos, n, type)	\
-	symbols__for_each_entry(&(dso)->symbols[(type)], pos, n)
+#define dso__for_each_symbol(dso, pos, n)	\
+	symbols__for_each_entry(&(dso)->symbols, pos, n)
 
-static inline void dso__set_loaded(struct dso *dso, enum map_type type)
+static inline void dso__set_loaded(struct dso *dso)
 {
-	dso->loaded |= (1 << type);
+	dso->loaded = true;
 }
 
 struct dso *dso__new(const char *name);
@@ -231,16 +230,16 @@ static inline void __dso__zput(struct dso **dso)
 
 #define dso__zput(dso) __dso__zput(&dso)
 
-bool dso__loaded(const struct dso *dso, enum map_type type);
+bool dso__loaded(const struct dso *dso);
 
-static inline bool dso__has_symbols(const struct dso *dso, enum map_type type)
+static inline bool dso__has_symbols(const struct dso *dso)
 {
-	return !RB_EMPTY_ROOT(&dso->symbols[type]);
+	return !RB_EMPTY_ROOT(&dso->symbols);
 }
 
-bool dso__sorted_by_name(const struct dso *dso, enum map_type type);
-void dso__set_sorted_by_name(struct dso *dso, enum map_type type);
-void dso__sort_by_name(struct dso *dso, enum map_type type);
+bool dso__sorted_by_name(const struct dso *dso);
+void dso__set_sorted_by_name(struct dso *dso);
+void dso__sort_by_name(struct dso *dso);
 
 void dso__set_build_id(struct dso *dso, void *build_id);
 bool dso__build_id_equal(const struct dso *dso, u8 *build_id);
@@ -354,9 +353,8 @@ size_t __dsos__fprintf_buildid(struct list_head *head, FILE *fp,
 size_t __dsos__fprintf(struct list_head *head, FILE *fp);
 
 size_t dso__fprintf_buildid(struct dso *dso, FILE *fp);
-size_t dso__fprintf_symbols_by_name(struct dso *dso,
-				    enum map_type type, FILE *fp);
-size_t dso__fprintf(struct dso *dso, enum map_type type, FILE *fp);
+size_t dso__fprintf_symbols_by_name(struct dso *dso, FILE *fp);
+size_t dso__fprintf(struct dso *dso, FILE *fp);
 
 static inline bool dso__is_vmlinux(struct dso *dso)
 {
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 7831c2266118..244135b5ea43 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -1488,8 +1488,8 @@ int perf_event__process(struct perf_tool *tool __maybe_unused,
 	return machine__process_event(machine, event, sample);
 }
 
-static struct map *__thread__find_map(struct thread *thread, u8 cpumode, enum map_type type,
-				      u64 addr, struct addr_location *al)
+struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
+			     struct addr_location *al)
 {
 	struct map_groups *mg = thread->mg;
 	struct machine *machine = mg->machine;
@@ -1534,7 +1534,7 @@ static struct map *__thread__find_map(struct thread *thread, u8 cpumode, enum ma
 		return NULL;
 	}
 try_again:
-	al->map = __map_groups__find(mg, type, al->addr);
+	al->map = map_groups__find(mg, al->addr);
 	if (al->map == NULL) {
 		/*
 		 * If this is outside of all known maps, and is a negative
@@ -1565,13 +1565,6 @@ static struct map *__thread__find_map(struct thread *thread, u8 cpumode, enum ma
 	return al->map;
 }
 
-struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
-			     struct addr_location *al)
-{
-	struct map *map = __thread__find_map(thread, cpumode, MAP__FUNCTION, addr, al);
-	return map ?: __thread__find_map(thread, cpumode, MAP__VARIABLE, addr, al);
-}
-
 struct symbol *thread__find_symbol(struct thread *thread, u8 cpumode,
 				   u64 addr, struct addr_location *al)
 {
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 53bc2fb88be4..b707041f9a22 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -82,8 +82,7 @@ int machine__init(struct machine *machine, const char *root_dir, pid_t pid)
 	machine->kptr_restrict_warned = false;
 	machine->comm_exec = false;
 	machine->kernel_start = 0;
-
-	memset(machine->vmlinux_maps, 0, sizeof(machine->vmlinux_maps));
+	machine->vmlinux_map = NULL;
 
 	machine->root_dir = strdup(root_dir);
 	if (machine->root_dir == NULL)
@@ -687,7 +686,7 @@ struct map *machine__findnew_module_map(struct machine *machine, u64 start,
 	if (dso == NULL)
 		goto out;
 
-	map = map__new2(start, dso, MAP__FUNCTION);
+	map = map__new2(start, dso);
 	if (map == NULL)
 		goto out;
 
@@ -855,62 +854,44 @@ static int machine__get_running_kernel_start(struct machine *machine,
 static int
 __machine__create_kernel_maps(struct machine *machine, struct dso *kernel)
 {
-	int type;
+	struct kmap *kmap;
+	struct map *map;
 
 	/* In case of renewal the kernel map, destroy previous one */
 	machine__destroy_kernel_maps(machine);
 
-	for (type = 0; type < MAP__NR_TYPES; ++type) {
-		struct kmap *kmap;
-		struct map *map;
-
-		machine->vmlinux_maps[type] = map__new2(0, kernel, type);
-		if (machine->vmlinux_maps[type] == NULL)
-			return -1;
+	machine->vmlinux_map = map__new2(0, kernel);
+	if (machine->vmlinux_map == NULL)
+		return -1;
 
-		machine->vmlinux_maps[type]->map_ip =
-			machine->vmlinux_maps[type]->unmap_ip =
-				identity__map_ip;
-		map = __machine__kernel_map(machine, type);
-		kmap = map__kmap(map);
-		if (!kmap)
-			return -1;
+	machine->vmlinux_map->map_ip = machine->vmlinux_map->unmap_ip = identity__map_ip;
+	map = machine__kernel_map(machine);
+	kmap = map__kmap(map);
+	if (!kmap)
+		return -1;
 
-		kmap->kmaps = &machine->kmaps;
-		map_groups__insert(&machine->kmaps, map);
-	}
+	kmap->kmaps = &machine->kmaps;
+	map_groups__insert(&machine->kmaps, map);
 
 	return 0;
 }
 
 void machine__destroy_kernel_maps(struct machine *machine)
 {
-	int type;
-
-	for (type = 0; type < MAP__NR_TYPES; ++type) {
-		struct kmap *kmap;
-		struct map *map = __machine__kernel_map(machine, type);
-
-		if (map == NULL)
-			continue;
+	struct kmap *kmap;
+	struct map *map = machine__kernel_map(machine);
 
-		kmap = map__kmap(map);
-		map_groups__remove(&machine->kmaps, map);
-		if (kmap && kmap->ref_reloc_sym) {
-			/*
-			 * ref_reloc_sym is shared among all maps, so free just
-			 * on one of them.
-			 */
-			if (type == MAP__FUNCTION) {
-				zfree((char **)&kmap->ref_reloc_sym->name);
-				zfree(&kmap->ref_reloc_sym);
-			} else
-				kmap->ref_reloc_sym = NULL;
-		}
+	if (map == NULL)
+		return;
 
-		map__put(machine->vmlinux_maps[type]);
-		machine->vmlinux_maps[type] = NULL;
+	kmap = map__kmap(map);
+	map_groups__remove(&machine->kmaps, map);
+	if (kmap && kmap->ref_reloc_sym) {
+		zfree((char **)&kmap->ref_reloc_sym->name);
+		zfree(&kmap->ref_reloc_sym);
 	}
+
+	map__zput(machine->vmlinux_map);
 }
 
 int machines__create_guest_kernel_maps(struct machines *machines)
@@ -987,20 +968,19 @@ int machines__create_kernel_maps(struct machines *machines, pid_t pid)
 	return machine__create_kernel_maps(machine);
 }
 
-int __machine__load_kallsyms(struct machine *machine, const char *filename,
-			     enum map_type type)
+int machine__load_kallsyms(struct machine *machine, const char *filename)
 {
 	struct map *map = machine__kernel_map(machine);
 	int ret = __dso__load_kallsyms(map->dso, filename, map, true);
 
 	if (ret > 0) {
-		dso__set_loaded(map->dso, type);
+		dso__set_loaded(map->dso);
 		/*
 		 * Since /proc/kallsyms will have multiple sessions for the
 		 * kernel, with modules between them, fixup the end of all
 		 * sections.
 		 */
-		__map_groups__fixup_end(&machine->kmaps, type);
+		map_groups__fixup_end(&machine->kmaps);
 	}
 
 	return ret;
@@ -1012,7 +992,7 @@ int machine__load_vmlinux_path(struct machine *machine)
 	int ret = dso__load_vmlinux_path(map->dso, map);
 
 	if (ret > 0)
-		dso__set_loaded(map->dso, map->type);
+		dso__set_loaded(map->dso);
 
 	return ret;
 }
@@ -1204,19 +1184,14 @@ static int machine__create_modules(struct machine *machine)
 static void machine__set_kernel_mmap(struct machine *machine,
 				     u64 start, u64 end)
 {
-	int i;
-
-	for (i = 0; i < MAP__NR_TYPES; i++) {
-		machine->vmlinux_maps[i]->start = start;
-		machine->vmlinux_maps[i]->end   = end;
-
-		/*
-		 * Be a bit paranoid here, some perf.data file came with
-		 * a zero sized synthesized MMAP event for the kernel.
-		 */
-		if (start == 0 && end == 0)
-			machine->vmlinux_maps[i]->end = ~0ULL;
-	}
+	machine->vmlinux_map->start = start;
+	machine->vmlinux_map->end   = end;
+	/*
+	 * Be a bit paranoid here, some perf.data file came with
+	 * a zero sized synthesized MMAP event for the kernel.
+	 */
+	if (start == 0 && end == 0)
+		machine->vmlinux_map->end = ~0ULL;
 }
 
 int machine__create_kernel_maps(struct machine *machine)
@@ -1246,7 +1221,7 @@ int machine__create_kernel_maps(struct machine *machine)
 
 	if (!machine__get_running_kernel_start(machine, &name, &addr)) {
 		if (name &&
-		    maps__set_kallsyms_ref_reloc_sym(machine->vmlinux_maps, name, addr)) {
+		    map__set_kallsyms_ref_reloc_sym(machine->vmlinux_map, name, addr)) {
 			machine__destroy_kernel_maps(machine);
 			return -1;
 		}
@@ -1376,9 +1351,9 @@ static int machine__process_kernel_mmap_event(struct machine *machine,
 		 * time /proc/sys/kernel/kptr_restrict was non zero.
 		 */
 		if (event->mmap.pgoff != 0) {
-			maps__set_kallsyms_ref_reloc_sym(machine->vmlinux_maps,
-							 symbol_name,
-							 event->mmap.pgoff);
+			map__set_kallsyms_ref_reloc_sym(machine->vmlinux_map,
+							symbol_name,
+							event->mmap.pgoff);
 		}
 
 		if (machine__is_default_guest(machine)) {
@@ -1399,7 +1374,6 @@ int machine__process_mmap2_event(struct machine *machine,
 {
 	struct thread *thread;
 	struct map *map;
-	enum map_type type;
 	int ret = 0;
 
 	if (dump_trace)
@@ -1418,11 +1392,6 @@ int machine__process_mmap2_event(struct machine *machine,
 	if (thread == NULL)
 		goto out_problem;
 
-	if (event->header.misc & PERF_RECORD_MISC_MMAP_DATA)
-		type = MAP__VARIABLE;
-	else
-		type = MAP__FUNCTION;
-
 	map = map__new(machine, event->mmap2.start,
 			event->mmap2.len, event->mmap2.pgoff,
 			event->mmap2.maj,
@@ -1430,7 +1399,7 @@ int machine__process_mmap2_event(struct machine *machine,
 			event->mmap2.ino_generation,
 			event->mmap2.prot,
 			event->mmap2.flags,
-			event->mmap2.filename, type, thread);
+			event->mmap2.filename, thread);
 
 	if (map == NULL)
 		goto out_problem_map;
@@ -1457,7 +1426,6 @@ int machine__process_mmap_event(struct machine *machine, union perf_event *event
 {
 	struct thread *thread;
 	struct map *map;
-	enum map_type type;
 	u32 prot = 0;
 	int ret = 0;
 
@@ -1477,18 +1445,14 @@ int machine__process_mmap_event(struct machine *machine, union perf_event *event
 	if (thread == NULL)
 		goto out_problem;
 
-	if (event->header.misc & PERF_RECORD_MISC_MMAP_DATA)
-		type = MAP__VARIABLE;
-	else {
-		type = MAP__FUNCTION;
+	if (!(event->header.misc & PERF_RECORD_MISC_MMAP_DATA))
 		prot = PROT_EXEC;
-	}
 
 	map = map__new(machine, event->mmap.start,
 			event->mmap.len, event->mmap.pgoff,
 			0, 0, 0, 0, prot, 0,
 			event->mmap.filename,
-			type, thread);
+			thread);
 
 	if (map == NULL)
 		goto out_problem_map;
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index ac3b8403df2e..a625a0a6330d 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -49,7 +49,7 @@ struct machine {
 	struct perf_env   *env;
 	struct dsos	  dsos;
 	struct map_groups kmaps;
-	struct map	  *vmlinux_maps[MAP__NR_TYPES];
+	struct map	  *vmlinux_map;
 	u64		  kernel_start;
 	pid_t		  *current_tid;
 	union { /* Tool specific area */
@@ -64,19 +64,13 @@ static inline struct threads *machine__threads(struct machine *machine, pid_t ti
 	return &machine->threads[(unsigned int)tid % THREADS__TABLE_SIZE];
 }
 
-static inline
-struct map *__machine__kernel_map(struct machine *machine, enum map_type type)
-{
-	return machine->vmlinux_maps[type];
-}
-
 /*
  * The main kernel (vmlinux) map
  */
 static inline
 struct map *machine__kernel_map(struct machine *machine)
 {
-	return __machine__kernel_map(machine, MAP__FUNCTION);
+	return machine->vmlinux_map;
 }
 
 /*
@@ -85,7 +79,7 @@ struct map *machine__kernel_map(struct machine *machine)
 static inline
 struct maps *machine__kernel_maps(struct machine *machine)
 {
-	return &machine->kmaps.maps[MAP__FUNCTION];
+	return &machine->kmaps.maps;
 }
 
 int machine__get_kernel_start(struct machine *machine);
@@ -202,27 +196,25 @@ struct dso *machine__findnew_dso(struct machine *machine, const char *filename);
 size_t machine__fprintf(struct machine *machine, FILE *fp);
 
 static inline
-struct symbol *machine__find_kernel_symbol(struct machine *machine,
-					   enum map_type type, u64 addr,
+struct symbol *machine__find_kernel_symbol(struct machine *machine, u64 addr,
 					   struct map **mapp)
 {
-	return map_groups__find_symbol(&machine->kmaps, type, addr, mapp);
+	return map_groups__find_symbol(&machine->kmaps, addr, mapp);
 }
 
 static inline
 struct symbol *machine__find_kernel_symbol_by_name(struct machine *machine,
-						   enum map_type type, const char *name,
+						   const char *name,
 						   struct map **mapp)
 {
-	return map_groups__find_symbol_by_name(&machine->kmaps, type, name, mapp);
+	return map_groups__find_symbol_by_name(&machine->kmaps, name, mapp);
 }
 
 static inline
 struct symbol *machine__find_kernel_function(struct machine *machine, u64 addr,
 					     struct map **mapp)
 {
-	return machine__find_kernel_symbol(machine, MAP__FUNCTION, addr,
-					   mapp);
+	return machine__find_kernel_symbol(machine,  addr, mapp);
 }
 
 static inline
@@ -237,13 +229,7 @@ struct map *machine__findnew_module_map(struct machine *machine, u64 start,
 					const char *filename);
 int arch__fix_module_text_start(u64 *start, const char *name);
 
-int __machine__load_kallsyms(struct machine *machine, const char *filename,
-			     enum map_type type);
-
-static inline int machine__load_kallsyms(struct machine *machine, const char *filename)
-{
-	return __machine__load_kallsyms(machine, filename, MAP__FUNCTION);
-}
+int machine__load_kallsyms(struct machine *machine, const char *filename);
 
 int machine__load_vmlinux_path(struct machine *machine);
 
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index a164e1ed5462..c8fe836e4c3c 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -22,11 +22,6 @@
 
 static void __maps__insert(struct maps *maps, struct map *map);
 
-const char *map_type__name[MAP__NR_TYPES] = {
-	[MAP__FUNCTION] = "Functions",
-	[MAP__VARIABLE] = "Variables",
-};
-
 static inline int is_anon_memory(const char *filename, u32 flags)
 {
 	return flags & MAP_HUGETLB ||
@@ -129,10 +124,8 @@ static inline bool replace_android_lib(const char *filename, char *newfilename)
 	return false;
 }
 
-void map__init(struct map *map, enum map_type type,
-	       u64 start, u64 end, u64 pgoff, struct dso *dso)
+void map__init(struct map *map, u64 start, u64 end, u64 pgoff, struct dso *dso)
 {
-	map->type     = type;
 	map->start    = start;
 	map->end      = end;
 	map->pgoff    = pgoff;
@@ -149,7 +142,7 @@ void map__init(struct map *map, enum map_type type,
 struct map *map__new(struct machine *machine, u64 start, u64 len,
 		     u64 pgoff, u32 d_maj, u32 d_min, u64 ino,
 		     u64 ino_gen, u32 prot, u32 flags, char *filename,
-		     enum map_type type, struct thread *thread)
+		     struct thread *thread)
 {
 	struct map *map = malloc(sizeof(*map));
 	struct nsinfo *nsi = NULL;
@@ -203,7 +196,7 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
 		if (dso == NULL)
 			goto out_delete;
 
-		map__init(map, type, start, start + len, pgoff, dso);
+		map__init(map, start, start + len, pgoff, dso);
 
 		if (anon || no_dso) {
 			map->map_ip = map->unmap_ip = identity__map_ip;
@@ -214,7 +207,7 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
 			 * unnecessary map__load warning.
 			 */
 			if (!(prot & PROT_EXEC))
-				dso__set_loaded(dso, map->type);
+				dso__set_loaded(dso);
 		}
 		dso->nsinfo = nsi;
 		dso__put(dso);
@@ -231,7 +224,7 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
  * they are loaded) and for vmlinux, where only after we load all the
  * symbols we'll know where it starts and ends.
  */
-struct map *map__new2(u64 start, struct dso *dso, enum map_type type)
+struct map *map__new2(u64 start, struct dso *dso)
 {
 	struct map *map = calloc(1, (sizeof(*map) +
 				     (dso->kernel ? sizeof(struct kmap) : 0)));
@@ -239,7 +232,7 @@ struct map *map__new2(u64 start, struct dso *dso, enum map_type type)
 		/*
 		 * ->end will be filled after we load all the symbols
 		 */
-		map__init(map, type, start, 0, 0, dso);
+		map__init(map, start, 0, 0, dso);
 	}
 
 	return map;
@@ -256,12 +249,12 @@ struct map *map__new2(u64 start, struct dso *dso, enum map_type type)
  */
 bool __map__is_kernel(const struct map *map)
 {
-	return __machine__kernel_map(map->groups->machine, map->type) == map;
+	return machine__kernel_map(map->groups->machine) == map;
 }
 
 bool map__has_symbols(const struct map *map)
 {
-	return dso__has_symbols(map->dso, map->type);
+	return dso__has_symbols(map->dso);
 }
 
 static void map__exit(struct map *map)
@@ -284,7 +277,7 @@ void map__put(struct map *map)
 
 void map__fixup_start(struct map *map)
 {
-	struct rb_root *symbols = &map->dso->symbols[map->type];
+	struct rb_root *symbols = &map->dso->symbols;
 	struct rb_node *nd = rb_first(symbols);
 	if (nd != NULL) {
 		struct symbol *sym = rb_entry(nd, struct symbol, rb_node);
@@ -294,7 +287,7 @@ void map__fixup_start(struct map *map)
 
 void map__fixup_end(struct map *map)
 {
-	struct rb_root *symbols = &map->dso->symbols[map->type];
+	struct rb_root *symbols = &map->dso->symbols;
 	struct rb_node *nd = rb_last(symbols);
 	if (nd != NULL) {
 		struct symbol *sym = rb_entry(nd, struct symbol, rb_node);
@@ -309,7 +302,7 @@ int map__load(struct map *map)
 	const char *name = map->dso->long_name;
 	int nr;
 
-	if (dso__loaded(map->dso, map->type))
+	if (dso__loaded(map->dso))
 		return 0;
 
 	nr = dso__load(map->dso, map);
@@ -353,7 +346,7 @@ struct symbol *map__find_symbol(struct map *map, u64 addr)
 	if (map__load(map) < 0)
 		return NULL;
 
-	return __dso__find_symbol(map->dso, map->type, addr);
+	return dso__find_symbol(map->dso, addr);
 }
 
 struct symbol *map__find_symbol_by_name(struct map *map, const char *name)
@@ -361,10 +354,10 @@ struct symbol *map__find_symbol_by_name(struct map *map, const char *name)
 	if (map__load(map) < 0)
 		return NULL;
 
-	if (!dso__sorted_by_name(map->dso, map->type))
-		dso__sort_by_name(map->dso, map->type);
+	if (!dso__sorted_by_name(map->dso))
+		dso__sort_by_name(map->dso);
 
-	return __dso__find_symbol_by_name(map->dso, map->type, name);
+	return dso__find_symbol_by_name(map->dso, name);
 }
 
 struct map *map__clone(struct map *from)
@@ -499,10 +492,7 @@ static void maps__init(struct maps *maps)
 
 void map_groups__init(struct map_groups *mg, struct machine *machine)
 {
-	int i;
-	for (i = 0; i < MAP__NR_TYPES; ++i) {
-		maps__init(&mg->maps[i]);
-	}
+	maps__init(&mg->maps);
 	mg->machine = machine;
 	refcount_set(&mg->refcnt, 1);
 }
@@ -530,22 +520,12 @@ static void maps__exit(struct maps *maps)
 
 void map_groups__exit(struct map_groups *mg)
 {
-	int i;
-
-	for (i = 0; i < MAP__NR_TYPES; ++i)
-		maps__exit(&mg->maps[i]);
+	maps__exit(&mg->maps);
 }
 
 bool map_groups__empty(struct map_groups *mg)
 {
-	int i;
-
-	for (i = 0; i < MAP__NR_TYPES; ++i) {
-		if (maps__first(&mg->maps[i]))
-			return false;
-	}
-
-	return true;
+	return !maps__first(&mg->maps);
 }
 
 struct map_groups *map_groups__new(struct machine *machine)
@@ -571,10 +551,9 @@ void map_groups__put(struct map_groups *mg)
 }
 
 struct symbol *map_groups__find_symbol(struct map_groups *mg,
-				       enum map_type type, u64 addr,
-				       struct map **mapp)
+				       u64 addr, struct map **mapp)
 {
-	struct map *map = __map_groups__find(mg, type, addr);
+	struct map *map = map_groups__find(mg, addr);
 
 	/* Ensure map is loaded before using map->map_ip */
 	if (map != NULL && map__load(map) >= 0) {
@@ -613,13 +592,10 @@ struct symbol *maps__find_symbol_by_name(struct maps *maps, const char *name,
 }
 
 struct symbol *map_groups__find_symbol_by_name(struct map_groups *mg,
-					       enum map_type type,
 					       const char *name,
 					       struct map **mapp)
 {
-	struct symbol *sym = maps__find_symbol_by_name(&mg->maps[type], name, mapp);
-
-	return sym;
+	return maps__find_symbol_by_name(&mg->maps, name, mapp);
 }
 
 int map_groups__find_ams(struct addr_map_symbol *ams)
@@ -627,7 +603,7 @@ int map_groups__find_ams(struct addr_map_symbol *ams)
 	if (ams->addr < ams->map->start || ams->addr >= ams->map->end) {
 		if (ams->map->groups == NULL)
 			return -1;
-		ams->map = __map_groups__find(ams->map->groups, ams->map->type, ams->addr);
+		ams->map = map_groups__find(ams->map->groups, ams->addr);
 		if (ams->map == NULL)
 			return -1;
 	}
@@ -650,7 +626,7 @@ static size_t maps__fprintf(struct maps *maps, FILE *fp)
 		printed += fprintf(fp, "Map:");
 		printed += map__fprintf(pos, fp);
 		if (verbose > 2) {
-			printed += dso__fprintf(pos->dso, pos->type, fp);
+			printed += dso__fprintf(pos->dso, fp);
 			printed += fprintf(fp, "--\n");
 		}
 	}
@@ -660,24 +636,14 @@ static size_t maps__fprintf(struct maps *maps, FILE *fp)
 	return printed;
 }
 
-size_t __map_groups__fprintf_maps(struct map_groups *mg, enum map_type type,
-				  FILE *fp)
-{
-	size_t printed = fprintf(fp, "%s:\n", map_type__name[type]);
-	return printed += maps__fprintf(&mg->maps[type], fp);
-}
-
 size_t map_groups__fprintf(struct map_groups *mg, FILE *fp)
 {
-	size_t printed = 0, i;
-	for (i = 0; i < MAP__NR_TYPES; ++i)
-		printed += __map_groups__fprintf_maps(mg, i, fp);
-	return printed;
+	return maps__fprintf(&mg->maps, fp);
 }
 
 static void __map_groups__insert(struct map_groups *mg, struct map *map)
 {
-	__maps__insert(&mg->maps[map->type], map);
+	__maps__insert(&mg->maps, map);
 	map->groups = mg;
 }
 
@@ -762,19 +728,18 @@ static int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp
 int map_groups__fixup_overlappings(struct map_groups *mg, struct map *map,
 				   FILE *fp)
 {
-	return maps__fixup_overlappings(&mg->maps[map->type], map, fp);
+	return maps__fixup_overlappings(&mg->maps, map, fp);
 }
 
 /*
  * XXX This should not really _copy_ te maps, but refcount them.
  */
-int map_groups__clone(struct thread *thread,
-		      struct map_groups *parent, enum map_type type)
+int map_groups__clone(struct thread *thread, struct map_groups *parent)
 {
 	struct map_groups *mg = thread->mg;
 	int err = -ENOMEM;
 	struct map *map;
-	struct maps *maps = &parent->maps[type];
+	struct maps *maps = &parent->maps;
 
 	down_read(&maps->lock);
 
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index d035d8f0d5b2..6eaa9f19dd47 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -12,15 +12,6 @@
 #include <linux/types.h>
 #include "rwsem.h"
 
-enum map_type {
-	MAP__FUNCTION = 0,
-	MAP__VARIABLE,
-};
-
-#define MAP__NR_TYPES (MAP__VARIABLE + 1)
-
-extern const char *map_type__name[MAP__NR_TYPES];
-
 struct dso;
 struct ip_callchain;
 struct ref_reloc_sym;
@@ -35,7 +26,6 @@ struct map {
 	};
 	u64			start;
 	u64			end;
-	u8 /* enum map_type */	type;
 	bool			erange_warned;
 	u32			priv;
 	u32			prot;
@@ -67,7 +57,7 @@ struct maps {
 };
 
 struct map_groups {
-	struct maps	 maps[MAP__NR_TYPES];
+	struct maps	 maps;
 	struct machine	 *machine;
 	refcount_t	 refcnt;
 };
@@ -125,7 +115,7 @@ struct thread;
  * Note: caller must ensure map->dso is not NULL (map is loaded).
  */
 #define map__for_each_symbol(map, pos, n)	\
-	dso__for_each_symbol(map->dso, pos, n, map->type)
+	dso__for_each_symbol(map->dso, pos, n)
 
 /* map__for_each_symbol_with_name - iterate over the symbols in the given map
  *                                  that have the given name
@@ -144,13 +134,13 @@ struct thread;
 #define map__for_each_symbol_by_name(map, sym_name, pos)		\
 	__map__for_each_symbol_by_name(map, sym_name, (pos))
 
-void map__init(struct map *map, enum map_type type,
+void map__init(struct map *map,
 	       u64 start, u64 end, u64 pgoff, struct dso *dso);
 struct map *map__new(struct machine *machine, u64 start, u64 len,
 		     u64 pgoff, u32 d_maj, u32 d_min, u64 ino,
 		     u64 ino_gen, u32 prot, u32 flags,
-		     char *filename, enum map_type type, struct thread *thread);
-struct map *map__new2(u64 start, struct dso *dso, enum map_type type);
+		     char *filename, struct thread *thread);
+struct map *map__new2(u64 start, struct dso *dso);
 void map__delete(struct map *map);
 struct map *map__clone(struct map *map);
 
@@ -185,8 +175,6 @@ void map__fixup_end(struct map *map);
 
 void map__reloc_vmlinux(struct map *map);
 
-size_t __map_groups__fprintf_maps(struct map_groups *mg, enum map_type type,
-				  FILE *fp);
 void maps__insert(struct maps *maps, struct map *map);
 void maps__remove(struct maps *maps, struct map *map);
 struct map *maps__find(struct maps *maps, u64 addr);
@@ -197,33 +185,26 @@ struct symbol *maps__find_symbol_by_name(struct maps *maps, const char *name,
 void map_groups__init(struct map_groups *mg, struct machine *machine);
 void map_groups__exit(struct map_groups *mg);
 int map_groups__clone(struct thread *thread,
-		      struct map_groups *parent, enum map_type type);
+		      struct map_groups *parent);
 size_t map_groups__fprintf(struct map_groups *mg, FILE *fp);
 
-int maps__set_kallsyms_ref_reloc_sym(struct map **maps, const char *symbol_name,
-				     u64 addr);
+int map__set_kallsyms_ref_reloc_sym(struct map *map, const char *symbol_name,
+				    u64 addr);
 
 static inline void map_groups__insert(struct map_groups *mg, struct map *map)
 {
-	maps__insert(&mg->maps[map->type], map);
+	maps__insert(&mg->maps, map);
 	map->groups = mg;
 }
 
 static inline void map_groups__remove(struct map_groups *mg, struct map *map)
 {
-	maps__remove(&mg->maps[map->type], map);
-}
-
-static inline struct map *__map_groups__find(struct map_groups *mg,
-					     enum map_type type, u64 addr)
-{
-	return maps__find(&mg->maps[type], addr);
+	maps__remove(&mg->maps, map);
 }
 
 static inline struct map *map_groups__find(struct map_groups *mg, u64 addr)
 {
-	struct map *map = __map_groups__find(mg, MAP__FUNCTION, addr);
-	return map ?: __map_groups__find(mg, MAP__VARIABLE, addr);
+	return maps__find(&mg->maps, addr);
 }
 
 struct map *map_groups__first(struct map_groups *mg);
@@ -234,11 +215,9 @@ static inline struct map *map_groups__next(struct map *map)
 }
 
 struct symbol *map_groups__find_symbol(struct map_groups *mg,
-				       enum map_type type, u64 addr,
-				       struct map **mapp);
+				       u64 addr, struct map **mapp);
 
 struct symbol *map_groups__find_symbol_by_name(struct map_groups *mg,
-					       enum map_type type,
 					       const char *name,
 					       struct map **mapp);
 
@@ -250,18 +229,13 @@ static inline
 struct symbol *map_groups__find_function_by_name(struct map_groups *mg,
 						 const char *name, struct map **mapp)
 {
-	return map_groups__find_symbol_by_name(mg, MAP__FUNCTION, name, mapp);
+	return map_groups__find_symbol_by_name(mg, name, mapp);
 }
 
 int map_groups__fixup_overlappings(struct map_groups *mg, struct map *map,
 				   FILE *fp);
 
-struct map *__map_groups__find_by_name(struct map_groups *mg, enum map_type type, const char *name);
-
-static inline struct map *map_groups__find_by_name(struct map_groups *mg, const char *name)
-{
-	return __map_groups__find_by_name(mg, MAP__FUNCTION, name);
-}
+struct map *map_groups__find_by_name(struct map_groups *mg, const char *name);
 
 bool __map__is_kernel(const struct map *map);
 
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 50139764c6d7..fefe2fdd1b83 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -3503,19 +3503,18 @@ int show_available_funcs(const char *target, struct nsinfo *nsi,
 			       (target) ? : "kernel");
 		goto end;
 	}
-	if (!dso__sorted_by_name(map->dso, map->type))
-		dso__sort_by_name(map->dso, map->type);
+	if (!dso__sorted_by_name(map->dso))
+		dso__sort_by_name(map->dso);
 
 	/* Show all (filtered) symbols */
 	setup_pager();
 
-        for (nd = rb_first(&map->dso->symbol_names[map->type]); nd; nd = rb_next(nd)) {
+	for (nd = rb_first(&map->dso->symbol_names); nd; nd = rb_next(nd)) {
 		struct symbol_name_rb_node *pos = rb_entry(nd, struct symbol_name_rb_node, rb_node);
 
 		if (strfilter__compare(_filter, pos->sym.name))
 			printf("%s\n", pos->sym.name);
-        }
-
+	}
 end:
 	map__put(map);
 	exit_probe_symbol_maps();
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index f4a7a437ee87..b998bb475589 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1973,12 +1973,11 @@ bool perf_session__has_traces(struct perf_session *session, const char *msg)
 	return false;
 }
 
-int maps__set_kallsyms_ref_reloc_sym(struct map **maps,
-				     const char *symbol_name, u64 addr)
+int map__set_kallsyms_ref_reloc_sym(struct map *map, const char *symbol_name, u64 addr)
 {
 	char *bracket;
-	int i;
 	struct ref_reloc_sym *ref;
+	struct kmap *kmap;
 
 	ref = zalloc(sizeof(struct ref_reloc_sym));
 	if (ref == NULL)
@@ -1996,13 +1995,9 @@ int maps__set_kallsyms_ref_reloc_sym(struct map **maps,
 
 	ref->addr = addr;
 
-	for (i = 0; i < MAP__NR_TYPES; ++i) {
-		struct kmap *kmap = map__kmap(maps[i]);
-
-		if (!kmap)
-			continue;
+	kmap = map__kmap(map);
+	if (kmap)
 		kmap->ref_reloc_sym = ref;
-	}
 
 	return 0;
 }
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 82a1aadc245f..5fd81c19eebf 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -114,16 +114,9 @@ static inline int elf_sym__is_label(const GElf_Sym *sym)
 		sym->st_shndx != SHN_ABS;
 }
 
-static bool elf_sym__is_a(GElf_Sym *sym, enum map_type type)
+static bool elf_sym__filter(GElf_Sym *sym)
 {
-	switch (type) {
-	case MAP__FUNCTION:
-		return elf_sym__is_function(sym);
-	case MAP__VARIABLE:
-		return elf_sym__is_object(sym);
-	default:
-		return false;
-	}
+	return elf_sym__is_function(sym) || elf_sym__is_object(sym);
 }
 
 static inline const char *elf_sym__name(const GElf_Sym *sym,
@@ -150,17 +143,10 @@ static inline bool elf_sec__is_data(const GElf_Shdr *shdr,
 	return strstr(elf_sec__name(shdr, secstrs), "data") != NULL;
 }
 
-static bool elf_sec__is_a(GElf_Shdr *shdr, Elf_Data *secstrs,
-			  enum map_type type)
+static bool elf_sec__filter(GElf_Shdr *shdr, Elf_Data *secstrs)
 {
-	switch (type) {
-	case MAP__FUNCTION:
-		return elf_sec__is_text(shdr, secstrs);
-	case MAP__VARIABLE:
-		return elf_sec__is_data(shdr, secstrs);
-	default:
-		return false;
-	}
+	return elf_sec__is_text(shdr, secstrs) || 
+	       elf_sec__is_data(shdr, secstrs);
 }
 
 static size_t elf_addr_to_index(Elf *elf, GElf_Addr addr)
@@ -256,7 +242,7 @@ static char *demangle_sym(struct dso *dso, int kmodule, const char *elf_name)
  * And always look at the original dso, not at debuginfo packages, that
  * have the PLT data stripped out (shdr_rel_plt.sh_type == SHT_NOBITS).
  */
-int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss, struct map *map)
+int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss)
 {
 	uint32_t nr_rel_entries, idx;
 	GElf_Sym sym;
@@ -369,7 +355,7 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss, struct map *
 				goto out_elf_end;
 
 			plt_offset += plt_entry_size;
-			symbols__insert(&dso->symbols[map->type], f);
+			symbols__insert(&dso->symbols, f);
 			++nr;
 		}
 	} else if (shdr_rel_plt.sh_type == SHT_REL) {
@@ -395,7 +381,7 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss, struct map *
 				goto out_elf_end;
 
 			plt_offset += plt_entry_size;
-			symbols__insert(&dso->symbols[map->type], f);
+			symbols__insert(&dso->symbols, f);
 			++nr;
 		}
 	}
@@ -844,7 +830,7 @@ int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 	 * have the wrong values for the dso maps, so remove them.
 	 */
 	if (kmodule && syms_ss->symtab)
-		symbols__delete(&dso->symbols[map->type]);
+		symbols__delete(&dso->symbols);
 
 	if (!syms_ss->symtab) {
 		/*
@@ -936,7 +922,7 @@ int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 		const char *section_name;
 		bool used_opd = false;
 
-		if (!is_label && !elf_sym__is_a(&sym, map->type))
+		if (!is_label && !elf_sym__filter(&sym))
 			continue;
 
 		/* Reject ARM ELF "mapping symbols": these aren't unique and
@@ -974,7 +960,7 @@ int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 
 		gelf_getshdr(sec, &shdr);
 
-		if (is_label && !elf_sec__is_a(&shdr, secstrs, map->type))
+		if (is_label && !elf_sec__filter(&shdr, secstrs))
 			continue;
 
 		section_name = elf_sec__name(&shdr, secstrs);
@@ -1042,7 +1028,7 @@ int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 			snprintf(dso_name, sizeof(dso_name),
 				 "%s%s", dso->short_name, section_name);
 
-			curr_map = __map_groups__find_by_name(kmaps, map->type, dso_name);
+			curr_map = map_groups__find_by_name(kmaps, dso_name);
 			if (curr_map == NULL) {
 				u64 start = sym.st_value;
 
@@ -1055,8 +1041,7 @@ int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 				curr_dso->kernel = dso->kernel;
 				curr_dso->long_name = dso->long_name;
 				curr_dso->long_name_len = dso->long_name_len;
-				curr_map = map__new2(start, curr_dso,
-						     map->type);
+				curr_map = map__new2(start, curr_dso);
 				dso__put(curr_dso);
 				if (curr_map == NULL) {
 					goto out_elf_end;
@@ -1081,7 +1066,7 @@ int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 				dsos__add(&map->groups->machine->dsos, curr_dso);
 				/* kmaps already got it */
 				map__put(curr_map);
-				dso__set_loaded(curr_dso, map->type);
+				dso__set_loaded(curr_dso);
 			} else
 				curr_dso = curr_map->dso;
 
@@ -1110,7 +1095,7 @@ int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 
 		arch__sym_update(f, &sym);
 
-		__symbols__insert(&curr_dso->symbols[curr_map->type], f, dso->kernel);
+		__symbols__insert(&curr_dso->symbols, f, dso->kernel);
 		nr++;
 	}
 
@@ -1118,14 +1103,14 @@ int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 	 * For misannotated, zeroed, ASM function sizes.
 	 */
 	if (nr > 0) {
-		symbols__fixup_end(&dso->symbols[map->type]);
-		symbols__fixup_duplicate(&dso->symbols[map->type]);
+		symbols__fixup_end(&dso->symbols);
+		symbols__fixup_duplicate(&dso->symbols);
 		if (kmap) {
 			/*
 			 * We need to fixup this here too because we create new
 			 * maps here, for things like vsyscall sections.
 			 */
-			__map_groups__fixup_end(kmaps, map->type);
+			map_groups__fixup_end(kmaps);
 		}
 	}
 	err = nr;
diff --git a/tools/perf/util/symbol-minimal.c b/tools/perf/util/symbol-minimal.c
index ff48d0d49584..7119df77dc0b 100644
--- a/tools/perf/util/symbol-minimal.c
+++ b/tools/perf/util/symbol-minimal.c
@@ -288,8 +288,7 @@ void symsrc__destroy(struct symsrc *ss)
 }
 
 int dso__synthesize_plt_symbols(struct dso *dso __maybe_unused,
-				struct symsrc *ss __maybe_unused,
-				struct map *map __maybe_unused)
+				struct symsrc *ss __maybe_unused)
 {
 	return 0;
 }
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index fe0e0d84a586..efc16a3e0b45 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -71,18 +71,10 @@ static enum dso_binary_type binary_type_symtab[] = {
 
 #define DSO_BINARY_TYPE__SYMTAB_CNT ARRAY_SIZE(binary_type_symtab)
 
-static bool symbol_type__is_a(char symbol_type, enum map_type map_type)
+static bool symbol_type__filter(char symbol_type)
 {
 	symbol_type = toupper(symbol_type);
-
-	switch (map_type) {
-	case MAP__FUNCTION:
-		return symbol_type == 'T' || symbol_type == 'W';
-	case MAP__VARIABLE:
-		return symbol_type == 'D';
-	default:
-		return false;
-	}
+	return symbol_type == 'T' || symbol_type == 'W' || symbol_type == 'D';
 }
 
 static int prefix_underscores_count(const char *str)
@@ -229,9 +221,9 @@ void symbols__fixup_end(struct rb_root *symbols)
 		curr->end = roundup(curr->start, 4096) + 4096;
 }
 
-void __map_groups__fixup_end(struct map_groups *mg, enum map_type type)
+void map_groups__fixup_end(struct map_groups *mg)
 {
-	struct maps *maps = &mg->maps[type];
+	struct maps *maps = &mg->maps;
 	struct map *next, *curr;
 
 	down_write(&maps->lock);
@@ -486,55 +478,40 @@ static struct symbol *symbols__find_by_name(struct rb_root *symbols,
 
 void dso__reset_find_symbol_cache(struct dso *dso)
 {
-	enum map_type type;
-
-	for (type = MAP__FUNCTION; type <= MAP__VARIABLE; ++type) {
-		dso->last_find_result[type].addr   = 0;
-		dso->last_find_result[type].symbol = NULL;
-	}
+	dso->last_find_result.addr   = 0;
+	dso->last_find_result.symbol = NULL;
 }
 
-void dso__insert_symbol(struct dso *dso, enum map_type type, struct symbol *sym)
+void dso__insert_symbol(struct dso *dso, struct symbol *sym)
 {
-	__symbols__insert(&dso->symbols[type], sym, dso->kernel);
+	__symbols__insert(&dso->symbols, sym, dso->kernel);
 
 	/* update the symbol cache if necessary */
-	if (dso->last_find_result[type].addr >= sym->start &&
-	    (dso->last_find_result[type].addr < sym->end ||
+	if (dso->last_find_result.addr >= sym->start &&
+	    (dso->last_find_result.addr < sym->end ||
 	    sym->start == sym->end)) {
-		dso->last_find_result[type].symbol = sym;
+		dso->last_find_result.symbol = sym;
 	}
 }
 
-struct symbol *__dso__find_symbol(struct dso *dso,
-				  enum map_type type, u64 addr)
+struct symbol *dso__find_symbol(struct dso *dso, u64 addr)
 {
-	if (dso->last_find_result[type].addr != addr || dso->last_find_result[type].symbol == NULL) {
-		dso->last_find_result[type].addr   = addr;
-		dso->last_find_result[type].symbol = symbols__find(&dso->symbols[type], addr);
+	if (dso->last_find_result.addr != addr || dso->last_find_result.symbol == NULL) {
+		dso->last_find_result.addr   = addr;
+		dso->last_find_result.symbol = symbols__find(&dso->symbols, addr);
 	}
 
-	return dso->last_find_result[type].symbol;
-}
-
-static struct symbol *__dso__first_symbol(struct dso *dso, enum map_type type)
-{
-	return symbols__first(&dso->symbols[type]);
+	return dso->last_find_result.symbol;
 }
 
 struct symbol *dso__first_symbol(struct dso *dso)
 {
-	return __dso__first_symbol(dso, MAP__FUNCTION);
-}
-
-static struct symbol *__dso__last_symbol(struct dso *dso, enum map_type type)
-{
-	return symbols__last(&dso->symbols[type]);
+	return symbols__first(&dso->symbols);
 }
 
 struct symbol *dso__last_symbol(struct dso *dso)
 {
-	return __dso__last_symbol(dso, MAP__FUNCTION);
+	return symbols__last(&dso->symbols);
 }
 
 struct symbol *dso__next_symbol(struct symbol *sym)
@@ -553,22 +530,20 @@ struct symbol *symbol__next_by_name(struct symbol *sym)
  /*
   * Returns first symbol that matched with @name.
   */
-struct symbol *__dso__find_symbol_by_name(struct dso *dso, enum map_type type,
-					  const char *name)
+struct symbol *dso__find_symbol_by_name(struct dso *dso, const char *name)
 {
-	struct symbol *s = symbols__find_by_name(&dso->symbol_names[type], name,
+	struct symbol *s = symbols__find_by_name(&dso->symbol_names, name,
 						 SYMBOL_TAG_INCLUDE__NONE);
 	if (!s)
-		s = symbols__find_by_name(&dso->symbol_names[type], name,
+		s = symbols__find_by_name(&dso->symbol_names, name,
 					  SYMBOL_TAG_INCLUDE__DEFAULT_ONLY);
 	return s;
 }
 
-void dso__sort_by_name(struct dso *dso, enum map_type type)
+void dso__sort_by_name(struct dso *dso)
 {
-	dso__set_sorted_by_name(dso, type);
-	return symbols__sort_by_name(&dso->symbol_names[type],
-				     &dso->symbols[type]);
+	dso__set_sorted_by_name(dso);
+	return symbols__sort_by_name(&dso->symbol_names, &dso->symbols);
 }
 
 int modules__parse(const char *filename, void *arg,
@@ -674,9 +649,9 @@ static int map__process_kallsym_symbol(void *arg, const char *name,
 {
 	struct symbol *sym;
 	struct process_kallsyms_args *a = arg;
-	struct rb_root *root = &a->dso->symbols[a->map->type];
+	struct rb_root *root = &a->dso->symbols;
 
-	if (!symbol_type__is_a(type, a->map->type))
+	if (!symbol_type__filter(type))
 		return 0;
 
 	/*
@@ -714,8 +689,8 @@ static int dso__split_kallsyms_for_kcore(struct dso *dso, struct map *map)
 	struct map *curr_map;
 	struct symbol *pos;
 	int count = 0;
-	struct rb_root old_root = dso->symbols[map->type];
-	struct rb_root *root = &dso->symbols[map->type];
+	struct rb_root old_root = dso->symbols;
+	struct rb_root *root = &dso->symbols;
 	struct rb_node *next = rb_first(root);
 
 	if (!kmaps)
@@ -735,7 +710,7 @@ static int dso__split_kallsyms_for_kcore(struct dso *dso, struct map *map)
 		if (module)
 			*module = '\0';
 
-		curr_map = __map_groups__find(kmaps, map->type, pos->start);
+		curr_map = map_groups__find(kmaps, pos->start);
 
 		if (!curr_map) {
 			symbol__delete(pos);
@@ -745,7 +720,7 @@ static int dso__split_kallsyms_for_kcore(struct dso *dso, struct map *map)
 		pos->start -= curr_map->start - curr_map->pgoff;
 		if (pos->end)
 			pos->end -= curr_map->start - curr_map->pgoff;
-		symbols__insert(&curr_map->dso->symbols[curr_map->type], pos);
+		symbols__insert(&curr_map->dso->symbols, pos);
 		++count;
 	}
 
@@ -767,7 +742,7 @@ static int dso__split_kallsyms(struct dso *dso, struct map *map, u64 delta)
 	struct map *curr_map = map;
 	struct symbol *pos;
 	int count = 0, moved = 0;
-	struct rb_root *root = &dso->symbols[map->type];
+	struct rb_root *root = &dso->symbols;
 	struct rb_node *next = rb_first(root);
 	int kernel_range = 0;
 
@@ -800,11 +775,10 @@ static int dso__split_kallsyms(struct dso *dso, struct map *map, u64 delta)
 					 * symbols are in its kmap. Mark it as
 					 * loaded.
 					 */
-					dso__set_loaded(curr_map->dso,
-							curr_map->type);
+					dso__set_loaded(curr_map->dso);
 				}
 
-				curr_map = __map_groups__find_by_name(kmaps, map->type, module);
+				curr_map = map_groups__find_by_name(kmaps, module);
 				if (curr_map == NULL) {
 					pr_debug("%s/proc/{kallsyms,modules} "
 					         "inconsistency while looking "
@@ -854,7 +828,7 @@ static int dso__split_kallsyms(struct dso *dso, struct map *map, u64 delta)
 
 			ndso->kernel = dso->kernel;
 
-			curr_map = map__new2(pos->start, ndso, map->type);
+			curr_map = map__new2(pos->start, ndso);
 			if (curr_map == NULL) {
 				dso__put(ndso);
 				return -1;
@@ -871,7 +845,7 @@ static int dso__split_kallsyms(struct dso *dso, struct map *map, u64 delta)
 add_symbol:
 		if (curr_map != map) {
 			rb_erase(&pos->rb_node, root);
-			symbols__insert(&curr_map->dso->symbols[curr_map->type], pos);
+			symbols__insert(&curr_map->dso->symbols, pos);
 			++moved;
 		} else
 			++count;
@@ -885,7 +859,7 @@ static int dso__split_kallsyms(struct dso *dso, struct map *map, u64 delta)
 	if (curr_map != map &&
 	    dso->kernel == DSO_TYPE_GUEST_KERNEL &&
 	    machine__is_default_guest(kmaps->machine)) {
-		dso__set_loaded(curr_map->dso, curr_map->type);
+		dso__set_loaded(curr_map->dso);
 	}
 
 	return count + moved;
@@ -1046,14 +1020,9 @@ int compare_proc_modules(const char *from, const char *to)
 	return ret;
 }
 
-static struct map *__map_groups__first(struct map_groups *mg, enum map_type type)
-{
-	return maps__first(&mg->maps[type]);
-}
-
 struct map *map_groups__first(struct map_groups *mg)
 {
-	return __map_groups__first(mg, MAP__FUNCTION);
+	return maps__first(&mg->maps);
 }
 
 static int do_validate_kcore_modules(const char *filename, struct map *map,
@@ -1067,7 +1036,7 @@ static int do_validate_kcore_modules(const char *filename, struct map *map,
 	if (err)
 		return err;
 
-	old_map = __map_groups__first(kmaps, map->type);
+	old_map = map_groups__first(kmaps);
 	while (old_map) {
 		struct map *next = map_groups__next(old_map);
 		struct module_info *mi;
@@ -1159,7 +1128,6 @@ static int validate_kcore_addresses(const char *kallsyms_filename,
 
 struct kcore_mapfn_data {
 	struct dso *dso;
-	enum map_type type;
 	struct list_head maps;
 };
 
@@ -1168,7 +1136,7 @@ static int kcore_mapfn(u64 start, u64 len, u64 pgoff, void *data)
 	struct kcore_mapfn_data *md = data;
 	struct map *map;
 
-	map = map__new2(start, md->dso, md->type);
+	map = map__new2(start, md->dso);
 	if (map == NULL)
 		return -ENOMEM;
 
@@ -1207,7 +1175,6 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 		return -EINVAL;
 
 	md.dso = dso;
-	md.type = map->type;
 	INIT_LIST_HEAD(&md.maps);
 
 	fd = open(kcore_filename, O_RDONLY);
@@ -1230,7 +1197,7 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 	}
 
 	/* Remove old maps */
-	old_map = __map_groups__first(kmaps, map->type);
+	old_map = map_groups__first(kmaps);
 	while (old_map) {
 		struct map *next = map_groups__next(old_map);
 
@@ -1240,7 +1207,7 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 	}
 
 	/* Find the kernel map using the first symbol */
-	sym = __dso__first_symbol(dso, map->type);
+	sym = dso__first_symbol(dso);
 	list_for_each_entry(new_map, &md.maps, node) {
 		if (sym && sym->start >= new_map->start &&
 		    sym->start < new_map->end) {
@@ -1339,8 +1306,8 @@ int __dso__load_kallsyms(struct dso *dso, const char *filename,
 	if (kallsyms__delta(map, filename, &delta))
 		return -1;
 
-	symbols__fixup_end(&dso->symbols[map->type]);
-	symbols__fixup_duplicate(&dso->symbols[map->type]);
+	symbols__fixup_end(&dso->symbols);
+	symbols__fixup_duplicate(&dso->symbols);
 
 	if (dso->kernel == DSO_TYPE_GUEST_KERNEL)
 		dso->symtab_type = DSO_BINARY_TYPE__GUEST_KALLSYMS;
@@ -1359,8 +1326,7 @@ int dso__load_kallsyms(struct dso *dso, const char *filename,
 	return __dso__load_kallsyms(dso, filename, map, false);
 }
 
-static int dso__load_perf_map(const char *map_path, struct dso *dso,
-			      struct map *map)
+static int dso__load_perf_map(const char *map_path, struct dso *dso)
 {
 	char *line = NULL;
 	size_t n;
@@ -1402,7 +1368,7 @@ static int dso__load_perf_map(const char *map_path, struct dso *dso,
 		if (sym == NULL)
 			goto out_delete_line;
 
-		symbols__insert(&dso->symbols[map->type], sym);
+		symbols__insert(&dso->symbols, sym);
 		nr_syms++;
 	}
 
@@ -1527,7 +1493,7 @@ int dso__load(struct dso *dso, struct map *map)
 	pthread_mutex_lock(&dso->lock);
 
 	/* check again under the dso->lock */
-	if (dso__loaded(dso, map->type)) {
+	if (dso__loaded(dso)) {
 		ret = 1;
 		goto out;
 	}
@@ -1560,7 +1526,7 @@ int dso__load(struct dso *dso, struct map *map)
 			goto out;
 		}
 
-		ret = dso__load_perf_map(map_path, dso, map);
+		ret = dso__load_perf_map(map_path, dso);
 		dso->symtab_type = ret > 0 ? DSO_BINARY_TYPE__JAVA_JIT :
 					     DSO_BINARY_TYPE__NOT_FOUND;
 		goto out;
@@ -1669,7 +1635,7 @@ int dso__load(struct dso *dso, struct map *map)
 	if (ret > 0) {
 		int nr_plt;
 
-		nr_plt = dso__synthesize_plt_symbols(dso, runtime_ss, map);
+		nr_plt = dso__synthesize_plt_symbols(dso, runtime_ss);
 		if (nr_plt > 0)
 			ret += nr_plt;
 	}
@@ -1681,16 +1647,16 @@ int dso__load(struct dso *dso, struct map *map)
 	if (ret < 0 && strstr(dso->name, " (deleted)") != NULL)
 		ret = 0;
 out:
-	dso__set_loaded(dso, map->type);
+	dso__set_loaded(dso);
 	pthread_mutex_unlock(&dso->lock);
 	nsinfo__mountns_exit(&nsc);
 
 	return ret;
 }
 
-struct map *__map_groups__find_by_name(struct map_groups *mg, enum map_type type, const char *name)
+struct map *map_groups__find_by_name(struct map_groups *mg, const char *name)
 {
-	struct maps *maps = &mg->maps[type];
+	struct maps *maps = &mg->maps;
 	struct map *map;
 
 	down_read(&maps->lock);
@@ -1737,7 +1703,7 @@ int dso__load_vmlinux(struct dso *dso, struct map *map,
 		else
 			dso->binary_type = DSO_BINARY_TYPE__VMLINUX;
 		dso__set_long_name(dso, vmlinux, vmlinux_allocated);
-		dso__set_loaded(dso, map->type);
+		dso__set_loaded(dso);
 		pr_debug("Using %s for symbols\n", symfs_vmlinux);
 	}
 
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 3e2ac485c6d9..1a16438eb3ce 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -260,16 +260,11 @@ int __dso__load_kallsyms(struct dso *dso, const char *filename, struct map *map,
 			 bool no_kcore);
 int dso__load_kallsyms(struct dso *dso, const char *filename, struct map *map);
 
-void dso__insert_symbol(struct dso *dso, enum map_type type,
+void dso__insert_symbol(struct dso *dso,
 			struct symbol *sym);
 
-struct symbol *__dso__find_symbol(struct dso *dso, enum map_type type, u64 addr);
-struct symbol *__dso__find_symbol_by_name(struct dso *dso, enum map_type type, const char *name);
-
-static inline struct symbol *dso__find_symbol(struct dso *dso, u64 addr)
-{
-	return __dso__find_symbol(dso, MAP__FUNCTION, addr);
-}
+struct symbol *dso__find_symbol(struct dso *dso, u64 addr);
+struct symbol *dso__find_symbol_by_name(struct dso *dso, const char *name);
 
 struct symbol *symbol__next_by_name(struct symbol *sym);
 
@@ -312,8 +307,7 @@ int symbol__config_symfs(const struct option *opt __maybe_unused,
 
 int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 		  struct symsrc *runtime_ss, int kmodule);
-int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss,
-				struct map *map);
+int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss);
 
 char *dso__demangle_sym(struct dso *dso, int kmodule, const char *elf_name);
 
@@ -321,7 +315,7 @@ void __symbols__insert(struct rb_root *symbols, struct symbol *sym, bool kernel)
 void symbols__insert(struct rb_root *symbols, struct symbol *sym);
 void symbols__fixup_duplicate(struct rb_root *symbols);
 void symbols__fixup_end(struct rb_root *symbols);
-void __map_groups__fixup_end(struct map_groups *mg, enum map_type type);
+void map_groups__fixup_end(struct map_groups *mg);
 
 typedef int (*mapfn_t)(u64 start, u64 len, u64 pgoff, void *data);
 int file__read_maps(int fd, bool exe, mapfn_t mapfn, void *data,
diff --git a/tools/perf/util/symbol_fprintf.c b/tools/perf/util/symbol_fprintf.c
index 6dd2cb88ccbe..ed0205cc7942 100644
--- a/tools/perf/util/symbol_fprintf.c
+++ b/tools/perf/util/symbol_fprintf.c
@@ -58,13 +58,13 @@ size_t symbol__fprintf_symname(const struct symbol *sym, FILE *fp)
 }
 
 size_t dso__fprintf_symbols_by_name(struct dso *dso,
-				    enum map_type type, FILE *fp)
+				    FILE *fp)
 {
 	size_t ret = 0;
 	struct rb_node *nd;
 	struct symbol_name_rb_node *pos;
 
-	for (nd = rb_first(&dso->symbol_names[type]); nd; nd = rb_next(nd)) {
+	for (nd = rb_first(&dso->symbol_names); nd; nd = rb_next(nd)) {
 		pos = rb_entry(nd, struct symbol_name_rb_node, rb_node);
 		fprintf(fp, "%s\n", pos->sym.name);
 	}
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index ddbf0470b048..2048d393ece6 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -302,23 +302,20 @@ int thread__insert_map(struct thread *thread, struct map *map)
 static int __thread__prepare_access(struct thread *thread)
 {
 	bool initialized = false;
-	int i, err = 0;
-
-	for (i = 0; i < MAP__NR_TYPES; ++i) {
-		struct maps *maps = &thread->mg->maps[i];
-		struct map *map;
+	int err = 0;
+	struct maps *maps = &thread->mg->maps;
+	struct map *map;
 
-		down_read(&maps->lock);
+	down_read(&maps->lock);
 
-		for (map = maps__first(maps); map; map = map__next(map)) {
-			err = unwind__prepare_access(thread, map, &initialized);
-			if (err || initialized)
-				break;
-		}
-
-		up_read(&maps->lock);
+	for (map = maps__first(maps); map; map = map__next(map)) {
+		err = unwind__prepare_access(thread, map, &initialized);
+		if (err || initialized)
+			break;
 	}
 
+	up_read(&maps->lock);
+
 	return err;
 }
 
@@ -335,8 +332,6 @@ static int thread__prepare_access(struct thread *thread)
 static int thread__clone_map_groups(struct thread *thread,
 				    struct thread *parent)
 {
-	int i;
-
 	/* This is new thread, we share map groups for process. */
 	if (thread->pid_ == parent->pid_)
 		return thread__prepare_access(thread);
@@ -348,9 +343,8 @@ static int thread__clone_map_groups(struct thread *thread,
 	}
 
 	/* But this one is new process, copy maps. */
-	for (i = 0; i < MAP__NR_TYPES; ++i)
-		if (map_groups__clone(thread, parent->mg, i) < 0)
-			return -ENOMEM;
+	if (map_groups__clone(thread, parent->mg) < 0)
+		return -ENOMEM;
 
 	return 0;
 }
-- 
2.14.3
