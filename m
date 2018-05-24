Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755077AbeEXFkw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 01:40:52 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60085 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754995AbeEXFks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 01:40:48 -0400
Date: Wed, 23 May 2018 22:40:24 -0700
From: tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-1c5aae7710bb9ecf82a5cc88e35a028a8b385763@git.kernel.org>
Cc: alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        tglx@linutronix.de, jolsa@redhat.com, linux-kernel@vger.kernel.org,
        acme@redhat.com, peterz@infradead.org, hpa@zytor.com,
        adrian.hunter@intel.com, mingo@kernel.org, luto@kernel.org,
        joro@8bytes.org, dave.hansen@linux.intel.com
Reply-To: adrian.hunter@intel.com, mingo@kernel.org, luto@kernel.org,
        joro@8bytes.org, dave.hansen@linux.intel.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        tglx@linutronix.de, jolsa@redhat.com, linux-kernel@vger.kernel.org,
        acme@redhat.com, peterz@infradead.org, hpa@zytor.com
In-Reply-To: <1526986485-6562-9-git-send-email-adrian.hunter@intel.com>
References: <1526986485-6562-9-git-send-email-adrian.hunter@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf machine: Create maps for x86 PTI entry
 trampolines
Git-Commit-ID: 1c5aae7710bb9ecf82a5cc88e35a028a8b385763
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

Commit-ID:  1c5aae7710bb9ecf82a5cc88e35a028a8b385763
Gitweb:     https://git.kernel.org/tip/1c5aae7710bb9ecf82a5cc88e35a028a8b385763
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Tue, 22 May 2018 13:54:36 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 23 May 2018 10:24:08 -0300

perf machine: Create maps for x86 PTI entry trampolines

Create maps for x86 PTI entry trampolines, based on symbols found in
kallsyms. It is also necessary to keep track of whether the trampolines
have been mapped particularly when the kernel dso is kcore.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
Link: http://lkml.kernel.org/r/1526986485-6562-9-git-send-email-adrian.hunter@intel.com
[ Fix extra_kernel_map_info.cnt designed struct initializer on gcc 4.4.7 (centos:6, etc) ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/util/Build     |   1 +
 tools/perf/arch/x86/util/machine.c | 103 +++++++++++++++++++++++++++++++++++++
 tools/perf/util/machine.c          |  66 +++++++++++++++++-------
 tools/perf/util/machine.h          |  19 +++++++
 tools/perf/util/symbol.c           |  17 ++++++
 5 files changed, 187 insertions(+), 19 deletions(-)

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
index 000000000000..4520ac53caa9
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
+	struct extra_kernel_map_info mi = { .cnt = 0, };
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
index 355d23bcd443..dd7ab0731167 100644
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
 	int nr_cpus_avail, cpu;
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
 
@@ -948,6 +964,14 @@ int machine__map_x86_64_entry_trampolines(struct machine *machine,
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
 
@@ -1306,9 +1330,8 @@ int machine__create_kernel_maps(struct machine *machine)
 		return -1;
 
 	ret = __machine__create_kernel_maps(machine, kernel);
-	dso__put(kernel);
 	if (ret < 0)
-		return -1;
+		goto out_put;
 
 	if (symbol_conf.use_modules && machine__create_modules(machine) < 0) {
 		if (machine__is_host(machine))
@@ -1323,7 +1346,8 @@ int machine__create_kernel_maps(struct machine *machine)
 		if (name &&
 		    map__set_kallsyms_ref_reloc_sym(machine->vmlinux_map, name, addr)) {
 			machine__destroy_kernel_maps(machine);
-			return -1;
+			ret = -1;
+			goto out_put;
 		}
 
 		/* we have a real start address now, so re-order the kmaps */
@@ -1339,12 +1363,16 @@ int machine__create_kernel_maps(struct machine *machine)
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
index b6a1c3eb3d65..1de7660d93e9 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -56,6 +56,7 @@ struct machine {
 		void	  *priv;
 		u64	  db_id;
 	};
+	bool		  trampolines_mapped;
 };
 
 static inline struct threads *machine__threads(struct machine *machine, pid_t tid)
@@ -268,6 +269,24 @@ int machine__set_current_tid(struct machine *machine, int cpu, pid_t pid,
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
