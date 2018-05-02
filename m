Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751702AbeEBSDA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 14:03:00 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53685 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750930AbeEBSC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 14:02:57 -0400
Date: Wed, 2 May 2018 11:02:47 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-236gyo6cx6iet90u3uc01cws@git.kernel.org>
Cc: namhyung@kernel.org, wangnan0@huawei.com, hpa@zytor.com,
        adrian.hunter@intel.com, acme@redhat.com, dsahern@gmail.com,
        mingo@kernel.org, jolsa@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Reply-To: hpa@zytor.com, wangnan0@huawei.com, namhyung@kernel.org,
        tglx@linutronix.de, mingo@kernel.org, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, acme@redhat.com, dsahern@gmail.com,
        adrian.hunter@intel.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf symbols: Split kernel symbol processing from
 dso__load_sym()
Git-Commit-ID: 4e0d1e8bcb96821ea16c8c025f36a112804e829f
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

Commit-ID:  4e0d1e8bcb96821ea16c8c025f36a112804e829f
Gitweb:     https://git.kernel.org/tip/4e0d1e8bcb96821ea16c8c025f36a112804e829f
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 27 Apr 2018 15:15:24 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 27 Apr 2018 15:15:24 -0300

perf symbols: Split kernel symbol processing from dso__load_sym()

More should be done to split this function, removing stuff map
relocation steps from the actual symbol table loading.

Arch specific stuff also should go elsewhere, to tools/arch/ and
we should have it keyed by data from the perf_env either in the
perf.data header or from the running environment.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-236gyo6cx6iet90u3uc01cws@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol-elf.c | 205 +++++++++++++++++++++++--------------------
 1 file changed, 108 insertions(+), 97 deletions(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 0b230f1a31c4..48943b834f11 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -797,6 +797,110 @@ static u64 ref_reloc(struct kmap *kmap)
 void __weak arch__sym_update(struct symbol *s __maybe_unused,
 		GElf_Sym *sym __maybe_unused) { }
 
+static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
+				      GElf_Sym *sym, GElf_Shdr *shdr,
+				      struct map_groups *kmaps, struct kmap *kmap,
+				      struct dso **curr_dsop, struct map **curr_mapp,
+				      const char *section_name,
+				      bool adjust_kernel_syms, bool kmodule, bool *remap_kernel)
+{
+	struct dso *curr_dso = *curr_dsop;
+	struct map *curr_map;
+	char dso_name[PATH_MAX];
+
+	/* Adjust symbol to map to file offset */
+	if (adjust_kernel_syms)
+		sym->st_value -= shdr->sh_addr - shdr->sh_offset;
+
+	if (strcmp(section_name, (curr_dso->short_name + dso->short_name_len)) == 0)
+		return 0;
+
+	if (strcmp(section_name, ".text") == 0) {
+		/*
+		 * The initial kernel mapping is based on
+		 * kallsyms and identity maps.  Overwrite it to
+		 * map to the kernel dso.
+		 */
+		if (*remap_kernel && dso->kernel) {
+			*remap_kernel = false;
+			map->start = shdr->sh_addr + ref_reloc(kmap);
+			map->end = map->start + shdr->sh_size;
+			map->pgoff = shdr->sh_offset;
+			map->map_ip = map__map_ip;
+			map->unmap_ip = map__unmap_ip;
+			/* Ensure maps are correctly ordered */
+			if (kmaps) {
+				map__get(map);
+				map_groups__remove(kmaps, map);
+				map_groups__insert(kmaps, map);
+				map__put(map);
+			}
+		}
+
+		/*
+		 * The initial module mapping is based on
+		 * /proc/modules mapped to offset zero.
+		 * Overwrite it to map to the module dso.
+		 */
+		if (*remap_kernel && kmodule) {
+			*remap_kernel = false;
+			map->pgoff = shdr->sh_offset;
+		}
+
+		*curr_mapp = map;
+		*curr_dsop = dso;
+		return 0;
+	}
+
+	if (!kmap)
+		return 0;
+
+	snprintf(dso_name, sizeof(dso_name), "%s%s", dso->short_name, section_name);
+
+	curr_map = map_groups__find_by_name(kmaps, dso_name);
+	if (curr_map == NULL) {
+		u64 start = sym->st_value;
+
+		if (kmodule)
+			start += map->start + shdr->sh_offset;
+
+		curr_dso = dso__new(dso_name);
+		if (curr_dso == NULL)
+			return -1;
+		curr_dso->kernel = dso->kernel;
+		curr_dso->long_name = dso->long_name;
+		curr_dso->long_name_len = dso->long_name_len;
+		curr_map = map__new2(start, curr_dso);
+		dso__put(curr_dso);
+		if (curr_map == NULL)
+			return -1;
+
+		if (adjust_kernel_syms) {
+			curr_map->start  = shdr->sh_addr + ref_reloc(kmap);
+			curr_map->end	 = curr_map->start + shdr->sh_size;
+			curr_map->pgoff	 = shdr->sh_offset;
+		} else {
+			curr_map->map_ip = curr_map->unmap_ip = identity__map_ip;
+		}
+		curr_dso->symtab_type = dso->symtab_type;
+		map_groups__insert(kmaps, curr_map);
+		/*
+		 * Add it before we drop the referece to curr_map, i.e. while
+		 * we still are sure to have a reference to this DSO via
+		 * *curr_map->dso.
+		 */
+		dsos__add(&map->groups->machine->dsos, curr_dso);
+		/* kmaps already got it */
+		map__put(curr_map);
+		dso__set_loaded(curr_dso);
+		*curr_mapp = curr_map;
+		*curr_dsop = curr_dso;
+	} else
+		*curr_dsop = curr_map->dso;
+
+	return 0;
+}
+
 int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 		  struct symsrc *runtime_ss, int kmodule)
 {
@@ -973,102 +1077,9 @@ int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 			--sym.st_value;
 
 		if (dso->kernel || kmodule) {
-			char dso_name[PATH_MAX];
-
-			/* Adjust symbol to map to file offset */
-			if (adjust_kernel_syms)
-				sym.st_value -= shdr.sh_addr - shdr.sh_offset;
-
-			if (strcmp(section_name,
-				   (curr_dso->short_name +
-				    dso->short_name_len)) == 0)
-				goto new_symbol;
-
-			if (strcmp(section_name, ".text") == 0) {
-				/*
-				 * The initial kernel mapping is based on
-				 * kallsyms and identity maps.  Overwrite it to
-				 * map to the kernel dso.
-				 */
-				if (remap_kernel && dso->kernel) {
-					remap_kernel = false;
-					map->start = shdr.sh_addr +
-						     ref_reloc(kmap);
-					map->end = map->start + shdr.sh_size;
-					map->pgoff = shdr.sh_offset;
-					map->map_ip = map__map_ip;
-					map->unmap_ip = map__unmap_ip;
-					/* Ensure maps are correctly ordered */
-					if (kmaps) {
-						map__get(map);
-						map_groups__remove(kmaps, map);
-						map_groups__insert(kmaps, map);
-						map__put(map);
-					}
-				}
-
-				/*
-				 * The initial module mapping is based on
-				 * /proc/modules mapped to offset zero.
-				 * Overwrite it to map to the module dso.
-				 */
-				if (remap_kernel && kmodule) {
-					remap_kernel = false;
-					map->pgoff = shdr.sh_offset;
-				}
-
-				curr_map = map;
-				curr_dso = dso;
-				goto new_symbol;
-			}
-
-			if (!kmap)
-				goto new_symbol;
-
-			snprintf(dso_name, sizeof(dso_name),
-				 "%s%s", dso->short_name, section_name);
-
-			curr_map = map_groups__find_by_name(kmaps, dso_name);
-			if (curr_map == NULL) {
-				u64 start = sym.st_value;
-
-				if (kmodule)
-					start += map->start + shdr.sh_offset;
-
-				curr_dso = dso__new(dso_name);
-				if (curr_dso == NULL)
-					goto out_elf_end;
-				curr_dso->kernel = dso->kernel;
-				curr_dso->long_name = dso->long_name;
-				curr_dso->long_name_len = dso->long_name_len;
-				curr_map = map__new2(start, curr_dso);
-				dso__put(curr_dso);
-				if (curr_map == NULL) {
-					goto out_elf_end;
-				}
-				if (adjust_kernel_syms) {
-					curr_map->start = shdr.sh_addr +
-							  ref_reloc(kmap);
-					curr_map->end = curr_map->start +
-							shdr.sh_size;
-					curr_map->pgoff = shdr.sh_offset;
-				} else {
-					curr_map->map_ip = identity__map_ip;
-					curr_map->unmap_ip = identity__map_ip;
-				}
-				curr_dso->symtab_type = dso->symtab_type;
-				map_groups__insert(kmaps, curr_map);
-				/*
-				 * Add it before we drop the referece to curr_map,
-				 * i.e. while we still are sure to have a reference
-				 * to this DSO via curr_map->dso.
-				 */
-				dsos__add(&map->groups->machine->dsos, curr_dso);
-				/* kmaps already got it */
-				map__put(curr_map);
-				dso__set_loaded(curr_dso);
-			} else
-				curr_dso = curr_map->dso;
+			if (dso__process_kernel_symbol(dso, map, &sym, &shdr, kmaps, kmap, &curr_dso, &curr_map,
+						       section_name, adjust_kernel_syms, kmodule, &remap_kernel))
+				goto out_elf_end;
 		} else if ((used_opd && runtime_ss->adjust_symbols) ||
 			   (!used_opd && syms_ss->adjust_symbols)) {
 			pr_debug4("%s: adjusting symbol: st_value: %#" PRIx64 " "
@@ -1077,7 +1088,7 @@ int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 				  (u64)shdr.sh_offset);
 			sym.st_value -= shdr.sh_addr - shdr.sh_offset;
 		}
-new_symbol:
+
 		demangled = demangle_sym(dso, kmodule, elf_name);
 		if (demangled != NULL)
 			elf_name = demangled;
