Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752976AbeBFS14 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 13:27:56 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44678 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752780AbeBFS1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 13:27:40 -0500
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 11/17] perf tools: Use machine__set_kernel_mmap instead of map_groups__fixup_end
Date: Tue,  6 Feb 2018 19:18:07 +0100
Message-Id: <20180206181813.10943-12-jolsa@kernel.org>
In-Reply-To: <20180206181813.10943-1-jolsa@kernel.org>
References: <20180206181813.10943-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The machine__set_kernel_mmap does the same job as map_groups__fixup_end
when used on kernel maps within machine__create_kernel_maps call.

This way we can also remove map_groups__fixup_end function, because there's
no user to it. Also moving machine__set_kernel_mmap up in code, so we don't
need forward declaration.

Link: http://lkml.kernel.org/n/tip-9kqrs3bsojwe4ktwpnkxc6g4@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/machine.c | 49 ++++++++++++++++++-----------------------------
 1 file changed, 19 insertions(+), 30 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 7838fe56b0c9..279eeb87c594 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1028,13 +1028,6 @@ int machine__load_vmlinux_path(struct machine *machine, enum map_type type)
 	return ret;
 }
 
-static void map_groups__fixup_end(struct map_groups *mg)
-{
-	int i;
-	for (i = 0; i < MAP__NR_TYPES; ++i)
-		__map_groups__fixup_end(mg, i);
-}
-
 static char *get_kernel_version(const char *root_dir)
 {
 	char version[PATH_MAX];
@@ -1220,6 +1213,24 @@ static int machine__create_modules(struct machine *machine)
 	return 0;
 }
 
+static void machine__set_kernel_mmap(struct machine *machine,
+				     u64 start, u64 end)
+{
+	int i;
+
+	for (i = 0; i < MAP__NR_TYPES; i++) {
+		machine->vmlinux_maps[i]->start = start;
+		machine->vmlinux_maps[i]->end   = end;
+
+		/*
+		 * Be a bit paranoid here, some perf.data file came with
+		 * a zero sized synthesized MMAP event for the kernel.
+		 */
+		if (machine->vmlinux_maps[i]->end == 0)
+			machine->vmlinux_maps[i]->end = ~0ULL;
+	}
+}
+
 int machine__create_kernel_maps(struct machine *machine)
 {
 	struct dso *kernel = machine__get_kernel(machine);
@@ -1244,11 +1255,6 @@ int machine__create_kernel_maps(struct machine *machine)
 				 "continuing anyway...\n", machine->pid);
 	}
 
-	/*
-	 * Now that we have all the maps created, just set the ->end of them:
-	 */
-	map_groups__fixup_end(&machine->kmaps);
-
 	if (!machine__get_running_kernel_start(machine, &name, &addr)) {
 		if (name &&
 		    maps__set_kallsyms_ref_reloc_sym(machine->vmlinux_maps, name, addr)) {
@@ -1257,27 +1263,10 @@ int machine__create_kernel_maps(struct machine *machine)
 		}
 	}
 
+	machine__set_kernel_mmap(machine, addr, 0);
 	return 0;
 }
 
-static void machine__set_kernel_mmap(struct machine *machine,
-				     u64 start, u64 end)
-{
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
-		if (machine->vmlinux_maps[i]->end == 0)
-			machine->vmlinux_maps[i]->end = ~0ULL;
-	}
-}
-
 static bool machine__uses_kcore(struct machine *machine)
 {
 	struct dso *dso;
-- 
2.13.6
