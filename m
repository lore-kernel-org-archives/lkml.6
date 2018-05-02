Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751873AbeEBRtY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 13:49:24 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48323 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751617AbeEBRtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 13:49:19 -0400
Date: Wed, 2 May 2018 10:49:07 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-qsgbxfyaohc80c9ma049dubm@git.kernel.org>
Cc: dsahern@gmail.com, adrian.hunter@intel.com, jolsa@kernel.org,
        hpa@zytor.com, tglx@linutronix.de, acme@redhat.com,
        linux-kernel@vger.kernel.org, wangnan0@huawei.com, mingo@kernel.org,
        namhyung@kernel.org
Reply-To: linux-kernel@vger.kernel.org, acme@redhat.com, wangnan0@huawei.com,
        mingo@kernel.org, namhyung@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, adrian.hunter@intel.com, jolsa@kernel.org,
        dsahern@gmail.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf machine: Introduce machine__kernel_maps()
Git-Commit-ID: 68a741868a0612408a46fda4c06663315d40c544
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

Commit-ID:  68a741868a0612408a46fda4c06663315d40c544
Gitweb:     https://git.kernel.org/tip/68a741868a0612408a46fda4c06663315d40c544
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 24 Apr 2018 17:06:25 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 26 Apr 2018 13:47:10 -0300

perf machine: Introduce machine__kernel_maps()

That returns the a data structure contained the ordered list of kernel
modules + the main kernel maps, one more step in removing the
MAP__{FUNCTION,VARIABLE} split.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-qsgbxfyaohc80c9ma049dubm@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/vmlinux-kallsyms.c |  4 ++--
 tools/perf/util/event.c             |  3 +--
 tools/perf/util/machine.h           | 12 ++++++++++++
 tools/perf/util/probe-event.c       |  3 +--
 4 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlinux-kallsyms.c
index d80416e07f4b..9bb84fe365e2 100644
--- a/tools/perf/tests/vmlinux-kallsyms.c
+++ b/tools/perf/tests/vmlinux-kallsyms.c
@@ -20,7 +20,7 @@ int test__vmlinux_matches_kallsyms(struct test *test __maybe_unused, int subtest
 	struct map *kallsyms_map, *vmlinux_map, *map;
 	struct machine kallsyms, vmlinux;
 	enum map_type type = MAP__FUNCTION;
-	struct maps *maps = &vmlinux.kmaps.maps[type];
+	struct maps *maps = machine__kernel_maps(&vmlinux);
 	u64 mem_start, mem_end;
 	bool header_printed;
 
@@ -228,7 +228,7 @@ next_pair:
 
 	header_printed = false;
 
-	maps = &kallsyms.kmaps.maps[type];
+	maps = machine__kernel_maps(&kallsyms);
 
 	for (map = maps__first(maps); map; map = map__next(map)) {
 		if (!map->priv) {
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 9d94c59046d1..542bd5b79e48 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -464,8 +464,7 @@ int perf_event__synthesize_modules(struct perf_tool *tool,
 {
 	int rc = 0;
 	struct map *pos;
-	struct map_groups *kmaps = &machine->kmaps;
-	struct maps *maps = &kmaps->maps[MAP__FUNCTION];
+	struct maps *maps = machine__kernel_maps(machine);
 	union perf_event *event = zalloc((sizeof(event->mmap) +
 					  machine->id_hdr_size));
 	if (event == NULL) {
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index 66cc200ef86f..92303ac718a6 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -70,12 +70,24 @@ struct map *__machine__kernel_map(struct machine *machine, enum map_type type)
 	return machine->vmlinux_maps[type];
 }
 
+/*
+ * The main kernel (vmlinux) map
+ */
 static inline
 struct map *machine__kernel_map(struct machine *machine)
 {
 	return __machine__kernel_map(machine, MAP__FUNCTION);
 }
 
+/*
+ * kernel (the one returned by machine__kernel_map()) plus kernel modules maps
+ */
+static inline
+struct maps *machine__kernel_maps(struct machine *machine)
+{
+	return &machine->kmaps.maps[MAP__FUNCTION];
+}
+
 int machine__get_kernel_start(struct machine *machine);
 
 static inline u64 machine__kernel_start(struct machine *machine)
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index d5e2516d5981..50139764c6d7 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -161,8 +161,7 @@ static int kernel_get_symbol_address_by_name(const char *name, u64 *addr,
 
 static struct map *kernel_get_module_map(const char *module)
 {
-	struct map_groups *grp = &host_machine->kmaps;
-	struct maps *maps = &grp->maps[MAP__FUNCTION];
+	struct maps *maps = machine__kernel_maps(host_machine);
 	struct map *pos;
 
 	/* A file path -- this is an offline module */
