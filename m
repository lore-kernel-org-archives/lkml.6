Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752501AbeEQJ0x (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 05:26:53 -0400
Received: from mga05.intel.com ([192.55.52.43]:6649 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752307AbeEQJYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 05:24:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,409,1520924400";
   d="scan'208";a="41683647"
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
Subject: [PATCH V2 12/20] perf tools: Synthesize and process mmap events for x86 PTI entry trampolines
Date: Thu, 17 May 2018 12:22:00 +0300
Message-Id: <1526548928-20790-13-git-send-email-adrian.hunter@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1526548928-20790-1-git-send-email-adrian.hunter@intel.com>
References: <1526548928-20790-1-git-send-email-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like the kernel text, the location of x86 PTI entry trampolines must be
recorded in the perf.data file. Like the kernel, synthesize a mmap event
for that, and add processing for it.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/arch/x86/util/Build   |  1 +
 tools/perf/arch/x86/util/event.c | 76 ++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/event.c          | 34 ++++++++++++++----
 tools/perf/util/event.h          |  8 +++++
 tools/perf/util/machine.c        | 28 +++++++++++++++
 5 files changed, 140 insertions(+), 7 deletions(-)
 create mode 100644 tools/perf/arch/x86/util/event.c

diff --git a/tools/perf/arch/x86/util/Build b/tools/perf/arch/x86/util/Build
index aa1ce5f6cc00..844b8f335532 100644
--- a/tools/perf/arch/x86/util/Build
+++ b/tools/perf/arch/x86/util/Build
@@ -5,6 +5,7 @@ libperf-y += kvm-stat.o
 libperf-y += perf_regs.o
 libperf-y += group.o
 libperf-y += machine.o
+libperf-y += event.o
 
 libperf-$(CONFIG_DWARF) += dwarf-regs.o
 libperf-$(CONFIG_BPF_PROLOGUE) += dwarf-regs.o
diff --git a/tools/perf/arch/x86/util/event.c b/tools/perf/arch/x86/util/event.c
new file mode 100644
index 000000000000..675a0213044d
--- /dev/null
+++ b/tools/perf/arch/x86/util/event.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/types.h>
+#include <linux/string.h>
+
+#include "../../util/machine.h"
+#include "../../util/tool.h"
+#include "../../util/map.h"
+#include "../../util/util.h"
+#include "../../util/debug.h"
+
+#if defined(__x86_64__)
+
+int perf_event__synthesize_extra_kmaps(struct perf_tool *tool,
+				       perf_event__handler_t process,
+				       struct machine *machine)
+{
+	int rc = 0;
+	struct map *pos;
+	struct map_groups *kmaps = &machine->kmaps;
+	struct maps *maps = &kmaps->maps;
+	union perf_event *event = zalloc(sizeof(event->mmap) +
+					 machine->id_hdr_size);
+
+	if (!event) {
+		pr_debug("Not enough memory synthesizing mmap event "
+			 "for extra kernel maps\n");
+		return -1;
+	}
+
+	for (pos = maps__first(maps); pos; pos = map__next(pos)) {
+		struct kmap *kmap;
+		size_t size;
+
+		if (!__map__is_extra_kernel_map(pos))
+			continue;
+
+		kmap = map__kmap(pos);
+
+		size = sizeof(event->mmap) - sizeof(event->mmap.filename) +
+		       PERF_ALIGN(strlen(kmap->name) + 1, sizeof(u64)) +
+		       machine->id_hdr_size;
+
+		memset(event, 0, size);
+
+		event->mmap.header.type = PERF_RECORD_MMAP;
+
+		/*
+		 * kernel uses 0 for user space maps, see kernel/perf_event.c
+		 * __perf_event_mmap
+		 */
+		if (machine__is_host(machine))
+			event->header.misc = PERF_RECORD_MISC_KERNEL;
+		else
+			event->header.misc = PERF_RECORD_MISC_GUEST_KERNEL;
+
+		event->mmap.header.size = size;
+
+		event->mmap.start = pos->start;
+		event->mmap.len   = pos->end - pos->start;
+		event->mmap.pgoff = pos->pgoff;
+		event->mmap.pid   = machine->pid;
+
+		strlcpy(event->mmap.filename, kmap->name, PATH_MAX);
+
+		if (perf_tool__process_synth_event(tool, event, machine,
+						   process) != 0) {
+			rc = -1;
+			break;
+		}
+	}
+
+	free(event);
+	return rc;
+}
+
+#endif
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index aafa9878465f..0c8ecf0c78a4 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -88,10 +88,10 @@ static const char *perf_ns__name(unsigned int id)
 	return perf_ns__names[id];
 }
 
-static int perf_tool__process_synth_event(struct perf_tool *tool,
-					  union perf_event *event,
-					  struct machine *machine,
-					  perf_event__handler_t process)
+int perf_tool__process_synth_event(struct perf_tool *tool,
+				   union perf_event *event,
+				   struct machine *machine,
+				   perf_event__handler_t process)
 {
 	struct perf_sample synth_sample = {
 	.pid	   = -1,
@@ -888,9 +888,16 @@ int kallsyms__get_function_start(const char *kallsyms_filename,
 	return 0;
 }
 
-int perf_event__synthesize_kernel_mmap(struct perf_tool *tool,
-				       perf_event__handler_t process,
-				       struct machine *machine)
+int __weak perf_event__synthesize_extra_kmaps(struct perf_tool *tool __maybe_unused,
+					      perf_event__handler_t process __maybe_unused,
+					      struct machine *machine __maybe_unused)
+{
+	return 0;
+}
+
+static int __perf_event__synthesize_kernel_mmap(struct perf_tool *tool,
+						perf_event__handler_t process,
+						struct machine *machine)
 {
 	size_t size;
 	struct map *map = machine__kernel_map(machine);
@@ -943,6 +950,19 @@ int perf_event__synthesize_kernel_mmap(struct perf_tool *tool,
 	return err;
 }
 
+int perf_event__synthesize_kernel_mmap(struct perf_tool *tool,
+				       perf_event__handler_t process,
+				       struct machine *machine)
+{
+	int err;
+
+	err = __perf_event__synthesize_kernel_mmap(tool, process, machine);
+	if (err < 0)
+		return err;
+
+	return perf_event__synthesize_extra_kmaps(tool, process, machine);
+}
+
 int perf_event__synthesize_thread_map2(struct perf_tool *tool,
 				      struct thread_map *threads,
 				      perf_event__handler_t process,
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 0f794744919c..bfa60bcafbde 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -750,6 +750,10 @@ int perf_event__process_exit(struct perf_tool *tool,
 			     union perf_event *event,
 			     struct perf_sample *sample,
 			     struct machine *machine);
+int perf_tool__process_synth_event(struct perf_tool *tool,
+				   union perf_event *event,
+				   struct machine *machine,
+				   perf_event__handler_t process);
 int perf_event__process(struct perf_tool *tool,
 			union perf_event *event,
 			struct perf_sample *sample,
@@ -796,6 +800,10 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
 				       bool mmap_data,
 				       unsigned int proc_map_timeout);
 
+int perf_event__synthesize_extra_kmaps(struct perf_tool *tool,
+				       perf_event__handler_t process,
+				       struct machine *machine);
+
 size_t perf_event__fprintf_comm(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_mmap(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_mmap2(union perf_event *event, FILE *fp);
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index a23aecc7328a..775889ae05b7 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1387,6 +1387,32 @@ static bool machine__uses_kcore(struct machine *machine)
 	return false;
 }
 
+static bool perf_event__is_extra_kernel_mmap(struct machine *machine,
+					     union perf_event *event)
+{
+	return machine__is(machine, "x86_64") &&
+	       is_entry_trampoline(event->mmap.filename);
+}
+
+static int machine__process_extra_kernel_map(struct machine *machine,
+					     union perf_event *event)
+{
+	struct map *kernel_map = machine__kernel_map(machine);
+	struct dso *kernel = kernel_map ? kernel_map->dso : NULL;
+	struct extra_kernel_map xm = {
+		.start = event->mmap.start,
+		.end   = event->mmap.start + event->mmap.len,
+		.pgoff = event->mmap.pgoff,
+	};
+
+	if (kernel == NULL)
+		return -1;
+
+	strlcpy(xm.name, event->mmap.filename, KMAP_NAME_LEN);
+
+	return machine__create_extra_kernel_map(machine, kernel, &xm);
+}
+
 static int machine__process_kernel_mmap_event(struct machine *machine,
 					      union perf_event *event)
 {
@@ -1490,6 +1516,8 @@ static int machine__process_kernel_mmap_event(struct machine *machine,
 			 */
 			dso__load(kernel, machine__kernel_map(machine));
 		}
+	} else if (perf_event__is_extra_kernel_mmap(machine, event)) {
+		return machine__process_extra_kernel_map(machine, event);
 	}
 	return 0;
 out_problem:
-- 
1.9.1
