Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935375AbeEXFjR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 01:39:17 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55875 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751873AbeEXFjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 01:39:13 -0400
Date: Wed, 23 May 2018 22:38:50 -0700
From: tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-4d99e4136580d178e3523281a820be17bf814bf8@git.kernel.org>
Cc: jolsa@redhat.com, ak@linux.intel.com, adrian.hunter@intel.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org, mingo@kernel.org,
        acme@redhat.com, alexander.shishkin@linux.intel.com,
        tglx@linutronix.de, joro@8bytes.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org
Reply-To: jolsa@redhat.com, acme@redhat.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@kernel.org, adrian.hunter@intel.com,
        ak@linux.intel.com, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, luto@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, joro@8bytes.org
In-Reply-To: <1526986485-6562-6-git-send-email-adrian.hunter@intel.com>
References: <1526986485-6562-6-git-send-email-adrian.hunter@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf machine: Workaround missing maps for x86 PTI
 entry trampolines
Git-Commit-ID: 4d99e4136580d178e3523281a820be17bf814bf8
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

Commit-ID:  4d99e4136580d178e3523281a820be17bf814bf8
Gitweb:     https://git.kernel.org/tip/4d99e4136580d178e3523281a820be17bf814bf8
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Tue, 22 May 2018 13:54:33 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 22 May 2018 10:54:22 -0300

perf machine: Workaround missing maps for x86 PTI entry trampolines

On x86_64 the PTI entry trampolines are not in the kernel map created by
perf tools. That results in the addresses having no symbols and prevents
annotation.  It also causes Intel PT to have decoding errors at the
trampoline addresses.

Workaround that by creating maps for the trampolines.

At present the kernel does not export information revealing where the
trampolines are.  Until that happens, the addresses are hardcoded.

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
Link: http://lkml.kernel.org/r/1526986485-6562-6-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 96 +++++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/machine.h |  3 ++
 tools/perf/util/symbol.c  | 12 +++---
 3 files changed, 106 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index f62ecd9c36e8..db695603873b 100644
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
