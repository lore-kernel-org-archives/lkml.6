Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751351AbeEBSF1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 14:05:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53171 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750859AbeEBSFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 14:05:23 -0400
Date: Wed, 2 May 2018 11:05:13 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-hiw2ryflju000f6wl62128it@git.kernel.org>
Cc: namhyung@kernel.org, acme@redhat.com, linux-kernel@vger.kernel.org,
        wangnan0@huawei.com, mingo@kernel.org, tglx@linutronix.de,
        jolsa@kernel.org, adrian.hunter@intel.com, hpa@zytor.com,
        dsahern@gmail.com
Reply-To: dsahern@gmail.com, hpa@zytor.com, adrian.hunter@intel.com,
        tglx@linutronix.de, jolsa@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, wangnan0@huawei.com, namhyung@kernel.org,
        acme@redhat.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf machine: Ditch find_kernel_function variants
Git-Commit-ID: 107cad95ffd81afad295ed5c29d006e525f1f80f
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

Commit-ID:  107cad95ffd81afad295ed5c29d006e525f1f80f
Gitweb:     https://git.kernel.org/tip/107cad95ffd81afad295ed5c29d006e525f1f80f
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 30 Apr 2018 12:20:54 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 30 Apr 2018 12:20:54 -0300

perf machine: Ditch find_kernel_function variants

Since we do not have split symtabs anymore, no need to have explicit
find_kernel_function variants, use the find_kernel_symbol ones.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-hiw2ryflju000f6wl62128it@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-kallsyms.c       |  2 +-
 tools/perf/builtin-kmem.c           |  6 +++---
 tools/perf/tests/vmlinux-kallsyms.c |  4 ++--
 tools/perf/util/machine.c           |  2 +-
 tools/perf/util/machine.h           | 15 ---------------
 tools/perf/util/map.h               |  7 -------
 tools/perf/util/probe-event.c       | 15 ++-------------
 7 files changed, 9 insertions(+), 42 deletions(-)

diff --git a/tools/perf/builtin-kallsyms.c b/tools/perf/builtin-kallsyms.c
index bcfb363112d3..90d1a2305b72 100644
--- a/tools/perf/builtin-kallsyms.c
+++ b/tools/perf/builtin-kallsyms.c
@@ -27,7 +27,7 @@ static int __cmd_kallsyms(int argc, const char **argv)
 
 	for (i = 0; i < argc; ++i) {
 		struct map *map;
-		struct symbol *symbol = machine__find_kernel_function_by_name(machine, argv[i], &map);
+		struct symbol *symbol = machine__find_kernel_symbol_by_name(machine, argv[i], &map);
 
 		if (symbol == NULL) {
 			printf("%s: not found\n", argv[i]);
diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index ae11e4c3516a..54d3f21b0e62 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -1004,7 +1004,7 @@ static void __print_slab_result(struct rb_root *root,
 		if (is_caller) {
 			addr = data->call_site;
 			if (!raw_ip)
-				sym = machine__find_kernel_function(machine, addr, &map);
+				sym = machine__find_kernel_symbol(machine, addr, &map);
 		} else
 			addr = data->ptr;
 
@@ -1068,7 +1068,7 @@ static void __print_page_alloc_result(struct perf_session *session, int n_lines)
 		char *caller = buf;
 
 		data = rb_entry(next, struct page_stat, node);
-		sym = machine__find_kernel_function(machine, data->callsite, &map);
+		sym = machine__find_kernel_symbol(machine, data->callsite, &map);
 		if (sym)
 			caller = sym->name;
 		else
@@ -1110,7 +1110,7 @@ static void __print_page_caller_result(struct perf_session *session, int n_lines
 		char *caller = buf;
 
 		data = rb_entry(next, struct page_stat, node);
-		sym = machine__find_kernel_function(machine, data->callsite, &map);
+		sym = machine__find_kernel_symbol(machine, data->callsite, &map);
 		if (sym)
 			caller = sym->name;
 		else
diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlinux-kallsyms.c
index 702cea7371ac..7691980b7df1 100644
--- a/tools/perf/tests/vmlinux-kallsyms.c
+++ b/tools/perf/tests/vmlinux-kallsyms.c
@@ -118,7 +118,7 @@ int test__vmlinux_matches_kallsyms(struct test *test __maybe_unused, int subtest
 		mem_start = vmlinux_map->unmap_ip(vmlinux_map, sym->start);
 		mem_end = vmlinux_map->unmap_ip(vmlinux_map, sym->end);
 
-		first_pair = machine__find_kernel_function(&kallsyms, mem_start, NULL);
+		first_pair = machine__find_kernel_symbol(&kallsyms, mem_start, NULL);
 		pair = first_pair;
 
 		if (pair && UM(pair->start) == mem_start) {
@@ -147,7 +147,7 @@ next_pair:
 				 */
 				continue;
 			} else {
-				pair = machine__find_kernel_function_by_name(&kallsyms, sym->name, NULL);
+				pair = machine__find_kernel_symbol_by_name(&kallsyms, sym->name, NULL);
 				if (pair) {
 					if (UM(pair->start) == mem_start)
 						goto next_pair;
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index b707041f9a22..72a351613d85 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2327,7 +2327,7 @@ char *machine__resolve_kernel_addr(void *vmachine, unsigned long long *addrp, ch
 {
 	struct machine *machine = vmachine;
 	struct map *map;
-	struct symbol *sym = machine__find_kernel_function(machine, *addrp, &map);
+	struct symbol *sym = machine__find_kernel_symbol(machine, *addrp, &map);
 
 	if (sym == NULL)
 		return NULL;
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index a625a0a6330d..388fb4741c54 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -210,21 +210,6 @@ struct symbol *machine__find_kernel_symbol_by_name(struct machine *machine,
 	return map_groups__find_symbol_by_name(&machine->kmaps, name, mapp);
 }
 
-static inline
-struct symbol *machine__find_kernel_function(struct machine *machine, u64 addr,
-					     struct map **mapp)
-{
-	return machine__find_kernel_symbol(machine,  addr, mapp);
-}
-
-static inline
-struct symbol *machine__find_kernel_function_by_name(struct machine *machine,
-						     const char *name,
-						     struct map **mapp)
-{
-	return map_groups__find_function_by_name(&machine->kmaps, name, mapp);
-}
-
 struct map *machine__findnew_module_map(struct machine *machine, u64 start,
 					const char *filename);
 int arch__fix_module_text_start(u64 *start, const char *name);
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 6eaa9f19dd47..f1afe1ab6ff7 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -225,13 +225,6 @@ struct addr_map_symbol;
 
 int map_groups__find_ams(struct addr_map_symbol *ams);
 
-static inline
-struct symbol *map_groups__find_function_by_name(struct map_groups *mg,
-						 const char *name, struct map **mapp)
-{
-	return map_groups__find_symbol_by_name(mg, name, mapp);
-}
-
 int map_groups__fixup_overlappings(struct map_groups *mg, struct map *map,
 				   FILE *fp);
 
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index fefe2fdd1b83..3094f11e7d81 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -111,17 +111,6 @@ void exit_probe_symbol_maps(void)
 	symbol__exit();
 }
 
-static struct symbol *__find_kernel_function_by_name(const char *name,
-						     struct map **mapp)
-{
-	return machine__find_kernel_function_by_name(host_machine, name, mapp);
-}
-
-static struct symbol *__find_kernel_function(u64 addr, struct map **mapp)
-{
-	return machine__find_kernel_function(host_machine, addr, mapp);
-}
-
 static struct ref_reloc_sym *kernel_get_ref_reloc_sym(void)
 {
 	/* kmap->ref_reloc_sym should be set if host_machine is initialized */
@@ -149,7 +138,7 @@ static int kernel_get_symbol_address_by_name(const char *name, u64 *addr,
 	if (reloc_sym && strcmp(name, reloc_sym->name) == 0)
 		*addr = (reloc) ? reloc_sym->addr : reloc_sym->unrelocated_addr;
 	else {
-		sym = __find_kernel_function_by_name(name, &map);
+		sym = machine__find_kernel_symbol_by_name(host_machine, name, &map);
 		if (!sym)
 			return -ENOENT;
 		*addr = map->unmap_ip(map, sym->start) -
@@ -2097,7 +2086,7 @@ static int find_perf_probe_point_from_map(struct probe_trace_point *tp,
 		}
 		if (addr) {
 			addr += tp->offset;
-			sym = __find_kernel_function(addr, &map);
+			sym = machine__find_kernel_symbol(host_machine, addr, &map);
 		}
 	}
 
