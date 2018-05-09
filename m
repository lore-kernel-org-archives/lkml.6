Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934742AbeEILpt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 07:45:49 -0400
Received: from mga14.intel.com ([192.55.52.115]:26332 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934376AbeEILpp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 07:45:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,381,1520924400";
   d="scan'208";a="54445963"
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
Subject: [PATCH RFC 11/19] perf tools: Synthesize and process mmap events for x86_64 KPTI entry trampolines
Date: Wed,  9 May 2018 14:43:40 +0300
Message-Id: <1525866228-30321-12-git-send-email-adrian.hunter@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1525866228-30321-1-git-send-email-adrian.hunter@intel.com>
References: <1525866228-30321-1-git-send-email-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like the kernel text, the location of x86_64 KPTI entry trampolines must be
recorded in the perf.data file. Like the kernel, synthesize a mmap event
for that, and add processing for it.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/event.c   | 90 +++++++++++++++++++++++++++++++++++++++++++++--
 tools/perf/util/machine.c | 28 +++++++++++++++
 2 files changed, 115 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index aafa9878465f..d810ff8488b1 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -888,9 +888,80 @@ int kallsyms__get_function_start(const char *kallsyms_filename,
 	return 0;
 }
 
-int perf_event__synthesize_kernel_mmap(struct perf_tool *tool,
-				       perf_event__handler_t process,
-				       struct machine *machine)
+#if defined(__x86_64__)
+
+static int perf_event__synthesize_special_kmaps(struct perf_tool *tool,
+						perf_event__handler_t process,
+						struct machine *machine)
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
+			 "for special kernel maps\n");
+		return -1;
+	}
+
+	for (pos = maps__first(maps); pos; pos = map__next(pos)) {
+		struct kmap *kmap;
+		size_t size;
+
+		if (!__map__is_special_kernel_map(pos))
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
+#else
+
+#define perf_event__synthesize_special_kmaps(t, p, m) 0
+
+#endif
+
+static int __perf_event__synthesize_kernel_mmap(struct perf_tool *tool,
+						perf_event__handler_t process,
+						struct machine *machine)
 {
 	size_t size;
 	struct map *map = machine__kernel_map(machine);
@@ -943,6 +1014,19 @@ int perf_event__synthesize_kernel_mmap(struct perf_tool *tool,
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
+	return perf_event__synthesize_special_kmaps(tool, process, machine);
+}
+
 int perf_event__synthesize_thread_map2(struct perf_tool *tool,
 				      struct thread_map *threads,
 				      perf_event__handler_t process,
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index aa6bb493fcfa..aa938f92d6d1 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1493,6 +1493,32 @@ static bool machine__uses_kcore(struct machine *machine)
 	return false;
 }
 
+static bool perf_event__is_special_kernel_mmap(struct machine *machine,
+					       union perf_event *event)
+{
+	return machine__is(machine, "x86_64") &&
+	       is_entry_trampoline(event->mmap.filename);
+}
+
+static int machine__process_special_kernel_map(struct machine *machine,
+					       union perf_event *event)
+{
+	struct map *kernel_map = machine__kernel_map(machine);
+	struct dso *kernel = kernel_map ? kernel_map->dso : NULL;
+	struct special_kernal_map sm = {
+		.start = event->mmap.start,
+		.end   = event->mmap.start + event->mmap.len,
+		.pgoff = event->mmap.pgoff,
+	};
+
+	if (kernel == NULL)
+		return -1;
+
+	strlcpy(sm.name, event->mmap.filename, KMAP_NAME_LEN);
+
+	return machine__create_special_kernel_map(machine, kernel, &sm);
+}
+
 static int machine__process_kernel_mmap_event(struct machine *machine,
 					      union perf_event *event)
 {
@@ -1596,6 +1622,8 @@ static int machine__process_kernel_mmap_event(struct machine *machine,
 			 */
 			dso__load(kernel, machine__kernel_map(machine));
 		}
+	} else if (perf_event__is_special_kernel_mmap(machine, event)) {
+		return machine__process_special_kernel_map(machine, event);
 	}
 	return 0;
 out_problem:
-- 
1.9.1
