Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934728AbeEILpo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 07:45:44 -0400
Received: from mga14.intel.com ([192.55.52.115]:26332 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934376AbeEILpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 07:45:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,381,1520924400";
   d="scan'208";a="54445952"
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
Subject: [PATCH RFC 10/19] perf tools: Create maps for x86_64 KPTI entry trampolines
Date: Wed,  9 May 2018 14:43:39 +0300
Message-Id: <1525866228-30321-11-git-send-email-adrian.hunter@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1525866228-30321-1-git-send-email-adrian.hunter@intel.com>
References: <1525866228-30321-1-git-send-email-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create maps for x86_64 KPTI entry trampolines, based on symbols found in
kallsyms. It is also necessary to keep track of whether the trampolines
have been mapped particularly when the kernel dso is kcore.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/machine.c | 138 ++++++++++++++++++++++++++++++++++++++++++++--
 tools/perf/util/machine.h |   1 +
 tools/perf/util/symbol.c  |  17 ++++++
 3 files changed, 150 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index f8c8e95062d0..aa6bb493fcfa 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -930,9 +930,33 @@ static u64 find_entry_trampoline(struct dso *dso)
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
+
+	pgoff = find_entry_trampoline(kernel);
 	if (!pgoff)
 		return 0;
 
@@ -956,9 +980,107 @@ int machine__map_x86_64_entry_trampolines(struct machine *machine,
 			return -1;
 	}
 
+	machine->trampolines_mapped = nr_cpus_avail;
+
+	return 0;
+}
+
+#if defined(__x86_64__)
+
+struct special_kernal_map_info {
+	int cnt;
+	int max_cnt;
+	struct special_kernal_map *maps;
+	bool get_entry_trampolines;
+	u64 entry_trampoline;
+};
+
+static int add_special_kernal_map(struct special_kernal_map_info *si, u64 start,
+				  u64 end, u64 pgoff, const char *name)
+{
+	if (si->cnt >= si->max_cnt) {
+		void *buf;
+		size_t sz;
+
+		si->max_cnt = si->max_cnt ? si->max_cnt * 2 : 32;
+		sz = sizeof(struct special_kernal_map) * si->max_cnt;
+		buf = realloc(si->maps, sz);
+		if (!buf)
+			return -1;
+		si->maps = buf;
+	}
+
+	si->maps[si->cnt].start = start;
+	si->maps[si->cnt].end   = end;
+	si->maps[si->cnt].pgoff = pgoff;
+	strlcpy(si->maps[si->cnt].name, name, KMAP_NAME_LEN);
+
+	si->cnt += 1;
+
+	return 0;
+}
+
+static int find_special_kernal_maps(void *arg, const char *name, char type,
+				    u64 start)
+{
+	struct special_kernal_map_info *si = arg;
+
+	if (!si->entry_trampoline && kallsyms2elf_binding(type) == STB_GLOBAL &&
+	    !strcmp(name, "_entry_trampoline")) {
+		si->entry_trampoline = start;
+		return 0;
+	}
+
+	if (is_entry_trampoline(name)) {
+		u64 end = start + page_size;
+
+		return add_special_kernal_map(si, start, end, 0, name);
+	}
+
 	return 0;
 }
 
+static int machine__create_special_kernel_maps(struct machine *machine,
+					       struct dso *kernel)
+{
+	struct special_kernal_map_info si = {0};
+	char filename[PATH_MAX];
+	int ret;
+	int i;
+
+	machine__get_kallsyms_filename(machine, filename, PATH_MAX);
+
+	if (symbol__restricted_filename(filename, "/proc/kallsyms"))
+		return 0;
+
+	ret = kallsyms__parse(filename, &si, find_special_kernal_maps);
+	if (ret)
+		goto out_free;
+
+	if (!si.entry_trampoline)
+		goto out_free;
+
+	for (i = 0; i < si.cnt; i++) {
+		struct special_kernal_map *sm = &si.maps[i];
+
+		sm->pgoff = si.entry_trampoline;
+		ret = machine__create_special_kernel_map(machine, kernel, sm);
+		if (ret)
+			goto out_free;
+	}
+
+	machine->trampolines_mapped = si.cnt;
+out_free:
+	free(si.maps);
+	return ret;
+}
+
+#else
+
+#define machine__create_special_kernel_maps(m, k) 0
+
+#endif
+
 static int
 __machine__create_kernel_maps(struct machine *machine, struct dso *kernel)
 {
@@ -1314,9 +1436,8 @@ int machine__create_kernel_maps(struct machine *machine)
 		return -1;
 
 	ret = __machine__create_kernel_maps(machine, kernel);
-	dso__put(kernel);
 	if (ret < 0)
-		return -1;
+		goto out_put;
 
 	if (symbol_conf.use_modules && machine__create_modules(machine) < 0) {
 		if (machine__is_host(machine))
@@ -1331,7 +1452,8 @@ int machine__create_kernel_maps(struct machine *machine)
 		if (name &&
 		    map__set_kallsyms_ref_reloc_sym(machine->vmlinux_map, name, addr)) {
 			machine__destroy_kernel_maps(machine);
-			return -1;
+			ret = -1;
+			goto out_put;
 		}
 
 		/* we have a real start address now, so re-order the kmaps */
@@ -1347,12 +1469,16 @@ int machine__create_kernel_maps(struct machine *machine)
 		map__put(map);
 	}
 
+	if (machine__create_special_kernel_maps(machine, kernel))
+		pr_debug("Problems creating special kernel maps, continuing anyway...\n");
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
index 6e1c63d3a625..da430cf57e37 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -56,6 +56,7 @@ struct machine {
 		void	  *priv;
 		u64	  db_id;
 	};
+	bool		  trampolines_mapped;
 };
 
 static inline struct threads *machine__threads(struct machine *machine, pid_t tid)
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 35a91c1b7d3e..927998f33e4f 100644
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
+						  "entry_trampoline_cpu0",
+						  &addr))
+			machine->trampolines_mapped = true;
+	}
+
 	/*
 	 * Set the data type and long name so that kcore can be read via
 	 * dso__data_read_addr().
-- 
1.9.1
