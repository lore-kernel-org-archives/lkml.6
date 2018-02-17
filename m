Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751177AbeBQLhS (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 06:37:18 -0500
Received: from terminus.zytor.com ([198.137.202.136]:50401 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750830AbeBQLhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 06:37:16 -0500
Date: Sat, 17 Feb 2018 03:26:54 -0800
From: tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-1fb87b8e9599932e1d8b11c3a1b03b4414aaf7ba@git.kernel.org>
Cc: alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, jolsa@kernel.org, tglx@linutronix.de,
        dsahern@gmail.com, peterz@infradead.org, namhyung@kernel.org,
        acme@redhat.com, hpa@zytor.com
Reply-To: tglx@linutronix.de, dsahern@gmail.com, mingo@kernel.org,
        alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, hpa@zytor.com, peterz@infradead.org, acme@redhat.com,
        namhyung@kernel.org
In-Reply-To: <20180215122635.24029-7-jolsa@kernel.org>
References: <20180215122635.24029-7-jolsa@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf machine: Don't search for active kernel start
 in __machine__create_kernel_maps
Git-Commit-ID: 1fb87b8e9599932e1d8b11c3a1b03b4414aaf7ba
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

Commit-ID:  1fb87b8e9599932e1d8b11c3a1b03b4414aaf7ba
Gitweb:     https://git.kernel.org/tip/1fb87b8e9599932e1d8b11c3a1b03b4414aaf7ba
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 15 Feb 2018 13:26:32 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 16 Feb 2018 14:25:57 -0300

perf machine: Don't search for active kernel start in __machine__create_kernel_maps

We should not search for the kernel start address in
__machine__create_kernel_maps(), because it's being used in the 'report'
code path, where we are interested in kernel MMAP data address (the one
recorded via 'perf record', possibly on another machine, or an older or
newer kernel on the same machine where analysis is being performed)
instead of in current kernel address.

The __machine__create_kernel_maps() function serves purely for creating
the machines kernel maps and setting up the kmap group. The report code
path then sets the address based on the data from kernel MMAP event in
the machine__set_kernel_mmap() function.

The kallsyms search address logic is used for test code, that calls
machine__create_kernel_maps() to get current maps and calls
machine__get_running_kernel_start() to get kernel starting address.

Use machine__set_kernel_mmap() to set the kernel maps start address and
moving map_groups__fixup_end to be call when all maps are in place.

Also make __machine__create_kernel_maps static, because there's no
external user.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180215122635.24029-7-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 55 ++++++++++++++++++++++-------------------------
 tools/perf/util/machine.h |  1 -
 2 files changed, 26 insertions(+), 30 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 292e70c..2db8d7d 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -856,13 +856,10 @@ static int machine__get_running_kernel_start(struct machine *machine,
 	return 0;
 }
 
-int __machine__create_kernel_maps(struct machine *machine, struct dso *kernel)
+static int
+__machine__create_kernel_maps(struct machine *machine, struct dso *kernel)
 {
 	int type;
-	u64 start = 0;
-
-	if (machine__get_running_kernel_start(machine, NULL, &start))
-		return -1;
 
 	/* In case of renewal the kernel map, destroy previous one */
 	machine__destroy_kernel_maps(machine);
@@ -871,7 +868,7 @@ int __machine__create_kernel_maps(struct machine *machine, struct dso *kernel)
 		struct kmap *kmap;
 		struct map *map;
 
-		machine->vmlinux_maps[type] = map__new2(start, kernel, type);
+		machine->vmlinux_maps[type] = map__new2(0, kernel, type);
 		if (machine->vmlinux_maps[type] == NULL)
 			return -1;
 
@@ -1222,6 +1219,24 @@ static int machine__create_modules(struct machine *machine)
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
@@ -1246,40 +1261,22 @@ int machine__create_kernel_maps(struct machine *machine)
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
 			machine__destroy_kernel_maps(machine);
 			return -1;
 		}
+		machine__set_kernel_mmap(machine, addr, 0);
 	}
 
+	/*
+	 * Now that we have all the maps created, just set the ->end of them:
+	 */
+	map_groups__fixup_end(&machine->kmaps);
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
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index cb0a20f..50d587d 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -238,7 +238,6 @@ size_t machines__fprintf_dsos_buildid(struct machines *machines, FILE *fp,
 				     bool (skip)(struct dso *dso, int parm), int parm);
 
 void machine__destroy_kernel_maps(struct machine *machine);
-int __machine__create_kernel_maps(struct machine *machine, struct dso *kernel);
 int machine__create_kernel_maps(struct machine *machine);
 
 int machines__create_kernel_maps(struct machines *machines, pid_t pid);
