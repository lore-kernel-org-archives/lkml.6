Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753272AbeEOMpa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 08:45:30 -0400
Received: from mga09.intel.com ([134.134.136.24]:14385 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753168AbeEOMp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 08:45:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,403,1520924400";
   d="scan'208";a="41391041"
From: Adrian Hunter <adrian.hunter@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH V1 10/19] perf tools: Create maps for x86 PTI entry trampolines
Date: Tue, 15 May 2018 15:43:24 +0300
Message-Id: <1526388213-30696-11-git-send-email-adrian.hunter@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1526388213-30696-1-git-send-email-adrian.hunter@intel.com>
References: <1526388213-30696-1-git-send-email-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create maps for x86 PTI entry trampolines, based on symbols found in
kallsyms. It is also necessary to keep track of whether the trampolines
have been mapped particularly when the kernel dso is kcore.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/arch/x86/util/Build     |   1 +
 tools/perf/arch/x86/util/machine.c | 103 +++++++++++++++++++++++++++++++++++++
 tools/perf/util/machine.c          |  66 +++++++++++++++++-------
 tools/perf/util/machine.h          |  19 +++++++
 tools/perf/util/symbol.c           |  17 ++++++
 5 files changed, 187 insertions(+), 19 deletions(-)
 create mode 100644 tools/perf/arch/x86/util/machine.c

diff --git a/tools/perf/arch/x86/util/Build b/tools/perf/arch/x86/util/Build
index f95e6f46ef0d..aa1ce5f6cc00 100644
--- a/tools/perf/arch/x86/util/Build
+++ b/tools/perf/arch/x86/util/Build
@@ -4,6 +4,7 @@ libperf-y += pmu.o
 libperf-y += kvm-stat.o
 libperf-y += perf_regs.o
 libperf-y += group.o
+libperf-y += machine.o
 
 libperf-$(CONFIG_DWARF) += dwarf-regs.o
 libperf-$(CONFIG_BPF_PROLOGUE) += dwarf-regs.o
diff --git a/tools/perf/arch/x86/util/machine.c b/tools/perf/arch/x86/util/machine.c
new file mode 100644
index 000000000000..50dd6d0426a9
--- /dev/null
+++ b/tools/perf/arch/x86/util/machine.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/types.h>
+#include <linux/string.h>
+#include <stdlib.h>
+
+#include "../../util/machine.h"
+#include "../../util/map.h"
+#include "../../util/symbol.h"
+#include "../../util/sane_ctype.h"
+
+#include <symbol/kallsyms.h>
+
+#if defined(__x86_64__)
+
+struct extra_kernel_map_info {
+	int cnt;
+	int max_cnt;
+	struct extra_kernel_map *maps;
+	bool get_entry_trampolines;
+	u64 entry_trampoline;
+};
+
+static int add_extra_kernel_map(struct extra_kernel_map_info *mi, u64 start,
+				u64 end, u64 pgoff, const char *name)
+{
+	if (mi->cnt >= mi->max_cnt) {
+		void *buf;
+		size_t sz;
+
+		mi->max_cnt = mi->max_cnt ? mi->max_cnt * 2 : 32;
+		sz = sizeof(struct extra_kernel_map) * mi->max_cnt;
+		buf = realloc(mi->maps, sz);
+		if (!buf)
+			return -1;
+		mi->maps = buf;
+	}
+
+	mi->maps[mi->cnt].start = start;
+	mi->maps[mi->cnt].end   = end;
+	mi->maps[mi->cnt].pgoff = pgoff;
+	strlcpy(mi->maps[mi->cnt].name, name, KMAP_NAME_LEN);
+
+	mi->cnt += 1;
+
+	return 0;
+}
+
+static int find_extra_kernel_maps(void *arg, const char *name, char type,
+				  u64 start)
+{
+	struct extra_kernel_map_info *mi = arg;
+
+	if (!mi->entry_trampoline && kallsyms2elf_binding(type) == STB_GLOBAL &&
+	    !strcmp(name, "_entry_trampoline")) {
+		mi->entry_trampoline = start;
+		return 0;
+	}
+
+	if (is_entry_trampoline(name)) {
+		u64 end = start + page_size;
+
+		return add_extra_kernel_map(mi, start, end, 0, name);
+	}
+
+	return 0;
+}
+
+int machine__create_extra_kernel_maps(struct machine *machine,
+				      struct dso *kernel)
+{
+	struct extra_kernel_map_info mi = {0};
+	char filename[PATH_MAX];
+	int ret;
+	int i;
+
+	machine__get_kallsyms_filename(machine, filename, PATH_MAX);
+
+	if (symbol__restricted_filename(filename, "/proc/kallsyms"))
+		return 0;
+
+	ret = kallsyms__parse(filename, &mi, find_extra_kernel_maps);
+	if (ret)
+		goto out_free;
+
+	if (!mi.entry_trampoline)
+		goto out_free;
+
+	for (i = 0; i < mi.cnt; i++) {
+		struct extra_kernel_map *xm = &mi.maps[i];
+
+		xm->pgoff = mi.entry_trampoline;
+		ret = machine__create_extra_kernel_map(machine, kernel, xm);
+		if (ret)
+			goto out_free;
+	}
+
+	machine->trampolines_mapped = mi.cnt;
+out_free:
+	free(mi.maps);
+	return ret;
+}
+
+#endif
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index c1415d3418f9..21bcf780a3ab 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -807,8 +807,8 @@ struct process_args {
 	u64 start;
 };
 
-static void machine__get_kallsyms_filename(struct machine *machine, char *buf,
-					   size_t bufsz)
+void machine__get_kallsyms_filename(struct machine *machine, char *buf,
+				    size_t bufsz)
 {
 	if (machine__is_default_guest(machine))
 		scnprintf(buf, bufsz, "%s", symbol_conf.default_guest_kallsyms);
@@ -851,17 +851,9 @@ static int machine__get_running_kernel_start(struct machine *machine,
 	return 0;
 }
 
-/* Kernel-space maps for symbols that are outside the main kernel map and module maps */
-struct extra_kernel_map {
-	u64 start;
-	u64 end;
-	u64 pgoff;
-	char name[KMAP_NAME_LEN];
-};
-
-static int machine__create_extra_kernel_map(struct machine *machine,
-					    struct dso *kernel,
-					    struct extra_kernel_map *xm)
+int machine__create_extra_kernel_map(struct machine *machine,
+				     struct dso *kernel,
+				     struct extra_kernel_map *xm)
 {
 	struct kmap *kmap;
 	struct map *map;
@@ -923,9 +915,33 @@ static u64 find_entry_trampoline(struct dso *dso)
 int machine__map_x86_64_entry_trampolines(struct machine *machine,
 					  struct dso *kernel)
 {
-	u64 pgoff = find_entry_trampoline(kernel);
+	struct map_groups *kmaps = &machine->kmaps;
+	struct maps *maps = &kmaps->maps;
 	int nr_cpus_avail = 0, cpu;
+	bool found = false;
+	struct map *map;
+	u64 pgoff;
+
+	/*
+	 * In the vmlinux case, pgoff is a virtual address which must now be
+	 * mapped to a vmlinux offset.
+	 */
+	for (map = maps__first(maps); map; map = map__next(map)) {
+		struct kmap *kmap = __map__kmap(map);
+		struct map *dest_map;
+
+		if (!kmap || !is_entry_trampoline(kmap->name))
+			continue;
+
+		dest_map = map_groups__find(kmaps, map->pgoff);
+		if (dest_map != map)
+			map->pgoff = dest_map->map_ip(dest_map, map->pgoff);
+		found = true;
+	}
+	if (found || machine->trampolines_mapped)
+		return 0;
 
+	pgoff = find_entry_trampoline(kernel);
 	if (!pgoff)
 		return 0;
 
@@ -949,6 +965,14 @@ int machine__map_x86_64_entry_trampolines(struct machine *machine,
 			return -1;
 	}
 
+	machine->trampolines_mapped = nr_cpus_avail;
+
+	return 0;
+}
+
+int __weak machine__create_extra_kernel_maps(struct machine *machine __maybe_unused,
+					     struct dso *kernel __maybe_unused)
+{
 	return 0;
 }
 
@@ -1307,9 +1331,8 @@ int machine__create_kernel_maps(struct machine *machine)
 		return -1;
 
 	ret = __machine__create_kernel_maps(machine, kernel);
-	dso__put(kernel);
 	if (ret < 0)
-		return -1;
+		goto out_put;
 
 	if (symbol_conf.use_modules && machine__create_modules(machine) < 0) {
 		if (machine__is_host(machine))
@@ -1324,7 +1347,8 @@ int machine__create_kernel_maps(struct machine *machine)
 		if (name &&
 		    map__set_kallsyms_ref_reloc_sym(machine->vmlinux_map, name, addr)) {
 			machine__destroy_kernel_maps(machine);
-			return -1;
+			ret = -1;
+			goto out_put;
 		}
 
 		/* we have a real start address now, so re-order the kmaps */
@@ -1340,12 +1364,16 @@ int machine__create_kernel_maps(struct machine *machine)
 		map__put(map);
 	}
 
+	if (machine__create_extra_kernel_maps(machine, kernel))
+		pr_debug("Problems creating extra kernel maps, continuing anyway...\n");
+
 	/* update end address of the kernel map using adjacent module address */
 	map = map__next(machine__kernel_map(machine));
 	if (map)
 		machine__set_kernel_mmap(machine, addr, map->start);
-
-	return 0;
+out_put:
+	dso__put(kernel);
+	return ret;
 }
 
 static bool machine__uses_kcore(struct machine *machine)
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index 6e1c63d3a625..40a09f7267de 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -56,6 +56,7 @@ struct machine {
 		void	  *priv;
 		u64	  db_id;
 	};
+	bool		  trampolines_mapped;
 };
 
 static inline struct threads *machine__threads(struct machine *machine, pid_t tid)
@@ -267,6 +268,24 @@ int machine__set_current_tid(struct machine *machine, int cpu, pid_t pid,
  */
 char *machine__resolve_kernel_addr(void *vmachine, unsigned long long *addrp, char **modp);
 
+void machine__get_kallsyms_filename(struct machine *machine, char *buf,
+				    size_t bufsz);
+
+int machine__create_extra_kernel_maps(struct machine *machine,
+				      struct dso *kernel);
+
+/* Kernel-space maps for symbols that are outside the main kernel map and module maps */
+struct extra_kernel_map {
+	u64 start;
+	u64 end;
+	u64 pgoff;
+	char name[KMAP_NAME_LEN];
+};
+
+int machine__create_extra_kernel_map(struct machine *machine,
+				     struct dso *kernel,
+				     struct extra_kernel_map *xm);
+
 int machine__map_x86_64_entry_trampolines(struct machine *machine,
 					  struct dso *kernel);
 
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index cdddae67f40c..8c84437f2a10 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1158,6 +1158,7 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 	struct map_groups *kmaps = map__kmaps(map);
 	struct kcore_mapfn_data md;
 	struct map *old_map, *new_map, *replacement_map = NULL;
+	struct machine *machine;
 	bool is_64_bit;
 	int err, fd;
 	char kcore_filename[PATH_MAX];
@@ -1166,6 +1167,8 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 	if (!kmaps)
 		return -EINVAL;
 
+	machine = kmaps->machine;
+
 	/* This function requires that the map is the kernel map */
 	if (!__map__is_kernel(map))
 		return -EINVAL;
@@ -1209,6 +1212,7 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 			map_groups__remove(kmaps, old_map);
 		old_map = next;
 	}
+	machine->trampolines_mapped = false;
 
 	/* Find the kernel map using the '_stext' symbol */
 	if (!kallsyms__get_function_start(kallsyms_filename, "_stext", &stext)) {
@@ -1245,6 +1249,19 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 		map__put(new_map);
 	}
 
+	if (machine__is(machine, "x86_64")) {
+		u64 addr;
+
+		/*
+		 * If one of the corresponding symbols is there, assume the
+		 * entry trampoline maps are too.
+		 */
+		if (!kallsyms__get_function_start(kallsyms_filename,
+						  ENTRY_TRAMPOLINE_NAME,
+						  &addr))
+			machine->trampolines_mapped = true;
+	}
+
 	/*
 	 * Set the data type and long name so that kcore can be read via
 	 * dso__data_read_addr().
-- 
1.9.1
