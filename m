Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752224AbeEQJX5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 05:23:57 -0400
Received: from mga05.intel.com ([192.55.52.43]:6649 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752189AbeEQJXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 05:23:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,409,1520924400";
   d="scan'208";a="41683595"
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
Subject: [PATCH V2 08/20] perf tools: Workaround missing maps for x86 PTI entry trampolines
Date: Thu, 17 May 2018 12:21:56 +0300
Message-Id: <1526548928-20790-9-git-send-email-adrian.hunter@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1526548928-20790-1-git-send-email-adrian.hunter@intel.com>
References: <1526548928-20790-1-git-send-email-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On x86_64 the PTI entry trampolines are not in the kernel map created by
perf tools. That results in the addresses having no symbols and prevents
annotation. It also causes Intel PT to have decoding errors at the
trampoline addresses. Workaround that by creating maps for the trampolines.
At present the kernel does not export information revealing where the
trampolines are. Until that happens, the addresses are hardcoded.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/machine.c | 96 +++++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/machine.h |  3 ++
 tools/perf/util/symbol.c  | 12 +++---
 3 files changed, 106 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 10a440025174..13fb283635ad 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -851,6 +851,102 @@ static int machine__get_running_kernel_start(struct machine *machine,
 	return 0;
 }
 
+/* Kernel-space maps for symbols that are outside the main kernel map and module maps */
+struct extra_kernel_map {
+	u64 start;
+	u64 end;
+	u64 pgoff;
+};
+
+static int machine__create_extra_kernel_map(struct machine *machine,
+					    struct dso *kernel,
+					    struct extra_kernel_map *xm)
+{
+	struct kmap *kmap;
+	struct map *map;
+
+	map = map__new2(xm->start, kernel);
+	if (!map)
+		return -1;
+
+	map->end   = xm->end;
+	map->pgoff = xm->pgoff;
+
+	kmap = map__kmap(map);
+
+	kmap->kmaps = &machine->kmaps;
+
+	map_groups__insert(&machine->kmaps, map);
+
+	pr_debug2("Added extra kernel map %" PRIx64 "-%" PRIx64 "\n",
+		  map->start, map->end);
+
+	map__put(map);
+
+	return 0;
+}
+
+static u64 find_entry_trampoline(struct dso *dso)
+{
+	/* Duplicates are removed so lookup all aliases */
+	const char *syms[] = {
+		"_entry_trampoline",
+		"__entry_trampoline_start",
+		"entry_SYSCALL_64_trampoline",
+	};
+	struct symbol *sym = dso__first_symbol(dso);
+	unsigned int i;
+
+	for (; sym; sym = dso__next_symbol(sym)) {
+		if (sym->binding != STB_GLOBAL)
+			continue;
+		for (i = 0; i < ARRAY_SIZE(syms); i++) {
+			if (!strcmp(sym->name, syms[i]))
+				return sym->start;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * These values can be used for kernels that do not have symbols for the entry
+ * trampolines in kallsyms.
+ */
+#define X86_64_CPU_ENTRY_AREA_PER_CPU	0xfffffe0000000000ULL
+#define X86_64_CPU_ENTRY_AREA_SIZE	0x2c000
+#define X86_64_ENTRY_TRAMPOLINE		0x6000
+
+/* Map x86_64 PTI entry trampolines */
+int machine__map_x86_64_entry_trampolines(struct machine *machine,
+					  struct dso *kernel)
+{
+	u64 pgoff = find_entry_trampoline(kernel);
+	int nr_cpus_avail, cpu;
+
+	if (!pgoff)
+		return 0;
+
+	nr_cpus_avail = machine__nr_cpus_avail(machine);
+
+	/* Add a 1 page map for each CPU's entry trampoline */
+	for (cpu = 0; cpu < nr_cpus_avail; cpu++) {
+		u64 va = X86_64_CPU_ENTRY_AREA_PER_CPU +
+			 cpu * X86_64_CPU_ENTRY_AREA_SIZE +
+			 X86_64_ENTRY_TRAMPOLINE;
+		struct extra_kernel_map xm = {
+			.start = va,
+			.end   = va + page_size,
+			.pgoff = pgoff,
+		};
+
+		if (machine__create_extra_kernel_map(machine, kernel, &xm) < 0)
+			return -1;
+	}
+
+	return 0;
+}
+
 static int
 __machine__create_kernel_maps(struct machine *machine, struct dso *kernel)
 {
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index 2d2b092ba753..b6a1c3eb3d65 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -268,4 +268,7 @@ int machine__set_current_tid(struct machine *machine, int cpu, pid_t pid,
  */
 char *machine__resolve_kernel_addr(void *vmachine, unsigned long long *addrp, char **modp);
 
+int machine__map_x86_64_entry_trampolines(struct machine *machine,
+					  struct dso *kernel);
+
 #endif /* __PERF_MACHINE_H */
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 4a39f4d0a174..701144094183 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1490,20 +1490,22 @@ int dso__load(struct dso *dso, struct map *map)
 		goto out;
 	}
 
+	if (map->groups && map->groups->machine)
+		machine = map->groups->machine;
+	else
+		machine = NULL;
+
 	if (dso->kernel) {
 		if (dso->kernel == DSO_TYPE_KERNEL)
 			ret = dso__load_kernel_sym(dso, map);
 		else if (dso->kernel == DSO_TYPE_GUEST_KERNEL)
 			ret = dso__load_guest_kernel_sym(dso, map);
 
+		if (machine__is(machine, "x86_64"))
+			machine__map_x86_64_entry_trampolines(machine, dso);
 		goto out;
 	}
 
-	if (map->groups && map->groups->machine)
-		machine = map->groups->machine;
-	else
-		machine = NULL;
-
 	dso->adjust_symbols = 0;
 
 	if (perfmap) {
-- 
1.9.1
