Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935541AbeEXFlY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 01:41:24 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44021 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935396AbeEXFlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 01:41:20 -0400
Date: Wed, 23 May 2018 22:40:55 -0700
From: tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-a8ce99b0ee9ad32debad0a9f28d21451ba237cc1@git.kernel.org>
Cc: ak@linux.intel.com, hpa@zytor.com, alexander.shishkin@linux.intel.com,
        luto@kernel.org, acme@redhat.com, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, tglx@linutronix.de, peterz@infradead.org,
        dave.hansen@linux.intel.com, adrian.hunter@intel.com, joro@8bytes.org,
        mingo@kernel.org
Reply-To: mingo@kernel.org, adrian.hunter@intel.com, joro@8bytes.org,
        linux-kernel@vger.kernel.org, luto@kernel.org, acme@redhat.com,
        jolsa@redhat.com, hpa@zytor.com, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com, dave.hansen@linux.intel.com,
        peterz@infradead.org, tglx@linutronix.de
In-Reply-To: <1526986485-6562-10-git-send-email-adrian.hunter@intel.com>
References: <1526986485-6562-10-git-send-email-adrian.hunter@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf machine: Synthesize and process mmap events
 for x86 PTI entry trampolines
Git-Commit-ID: a8ce99b0ee9ad32debad0a9f28d21451ba237cc1
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

Commit-ID:  a8ce99b0ee9ad32debad0a9f28d21451ba237cc1
Gitweb:     https://git.kernel.org/tip/a8ce99b0ee9ad32debad0a9f28d21451ba237cc1
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Tue, 22 May 2018 13:54:37 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 23 May 2018 10:26:39 -0300

perf machine: Synthesize and process mmap events for x86 PTI entry trampolines

Like the kernel text, the location of x86 PTI entry trampolines must be
recorded in the perf.data file. Like the kernel, synthesize a mmap event
for that, and add processing for it.

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
Link: http://lkml.kernel.org/r/1526986485-6562-10-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/util/Build   |  1 +
 tools/perf/arch/x86/util/event.c | 76 ++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/event.c          | 34 ++++++++++++++----
 tools/perf/util/event.h          |  8 +++++
 tools/perf/util/machine.c        | 28 +++++++++++++++
 5 files changed, 140 insertions(+), 7 deletions(-)

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
index dd7ab0731167..e7b4a8b513f2 100644
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
