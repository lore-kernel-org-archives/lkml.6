Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932178AbeCKQLw (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 12:11:52 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:44567 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932136AbeCKQLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 12:11:50 -0400
Date: Sun, 11 Mar 2018 09:11:40 -0700 (PDT)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] perf updates for 4.16
Message-ID: <alpine.DEB.2.21.1803110856390.3841@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1852947682-1520784708=:3841"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1852947682-1520784708=:3841
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Linus,

please pull the latest perf-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

Another set of perf updates:

 - Fix a Skylake Uncore event format declaration

 - Prevent perf pipe mode from crahsing which was caused by a missing
   buffer allocation

 - Make the perf top popup message which tells the user that it uses
   fallback mode on older kernels a debug message.

 - Make perf context rescheduling work correcctly

 - Robustify the jump error drawing in perf browser mode so it does not try
   to create references to NULL initialized offset entries

 - Make trigger_on() robust so it does not enable the trigger before
   everything is set up correctly to handle it

 - Make perf auxtrace respect the --no-itrace option so it does not try to
   queue AUX data for decoding.

 - Prevent having different number of field separators in CVS output lines
   when a counter is not supported.

 - Make the perf kallsyms man page usage behave like it does for all other
   perf commands.

 - Synchronize the kernel headers


Thanks,

	tglx

------------------>
Adrian Hunter (2):
      perf auxtrace: Prevent decoding when --no-itrace
      perf tools: Fix trigger class trigger_on()

Arnaldo Carvalho de Melo (3):
      perf annotate browser: Be more robust when drawing jump arrows
      tools headers: Sync copy of kvm UAPI headers
      tools headers: Sync x86's cpufeatures.h

Ilya Pronin (1):
      perf stat: Fix CVS output format for non-supported counters

Jiri Olsa (1):
      perf record: Fix crash in pipe mode

Kan Liang (2):
      perf/x86/intel/uncore: Fix Skylake UPI event format
      perf top: Fix annoying fallback message on older kernels

Sangwon Hong (1):
      perf kallsyms: Fix the usage on the man page

Song Liu (1):
      perf/core: Fix ctx_event_type in ctx_resched()


 arch/x86/events/intel/uncore_snbep.c       |  2 +-
 kernel/events/core.c                       |  4 +++-
 tools/arch/x86/include/asm/cpufeatures.h   |  1 +
 tools/include/uapi/linux/kvm.h             |  2 ++
 tools/perf/Documentation/perf-kallsyms.txt |  2 +-
 tools/perf/builtin-record.c                |  9 +++++++++
 tools/perf/builtin-stat.c                  |  2 +-
 tools/perf/builtin-top.c                   |  2 +-
 tools/perf/perf.h                          |  1 +
 tools/perf/ui/browsers/annotate.c          | 25 +++++++++++++++++++++++++
 tools/perf/util/auxtrace.c                 | 15 +++++++++------
 tools/perf/util/record.c                   |  8 ++++++--
 tools/perf/util/trigger.h                  |  9 +++++----
 13 files changed, 65 insertions(+), 17 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 6d8044ab1060..22ec65bc033a 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -3606,7 +3606,7 @@ static struct intel_uncore_type skx_uncore_imc = {
 };
 
 static struct attribute *skx_upi_uncore_formats_attr[] = {
-	&format_attr_event_ext.attr,
+	&format_attr_event.attr,
 	&format_attr_umask_ext.attr,
 	&format_attr_edge.attr,
 	&format_attr_inv.attr,
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 96db9ae5d5af..4b838470fac4 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2246,7 +2246,7 @@ static void ctx_resched(struct perf_cpu_context *cpuctx,
 			struct perf_event_context *task_ctx,
 			enum event_type_t event_type)
 {
-	enum event_type_t ctx_event_type = event_type & EVENT_ALL;
+	enum event_type_t ctx_event_type;
 	bool cpu_event = !!(event_type & EVENT_CPU);
 
 	/*
@@ -2256,6 +2256,8 @@ static void ctx_resched(struct perf_cpu_context *cpuctx,
 	if (event_type & EVENT_PINNED)
 		event_type |= EVENT_FLEXIBLE;
 
+	ctx_event_type = event_type & EVENT_ALL;
+
 	perf_pmu_disable(cpuctx->ctx.pmu);
 	if (task_ctx)
 		task_ctx_sched_out(cpuctx, task_ctx, event_type);
diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index 0dfe4d3f74e2..f41079da38c5 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -213,6 +213,7 @@
 #define X86_FEATURE_SEV			( 7*32+20) /* AMD Secure Encrypted Virtualization */
 
 #define X86_FEATURE_USE_IBPB		( 7*32+21) /* "" Indirect Branch Prediction Barrier enabled */
+#define X86_FEATURE_USE_IBRS_FW		( 7*32+22) /* "" Use IBRS during runtime firmware calls */
 
 /* Virtualization flags: Linux defined, word 8 */
 #define X86_FEATURE_TPR_SHADOW		( 8*32+ 0) /* Intel TPR Shadow */
diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index 0fb5ef939732..7b26d4b0b052 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -761,6 +761,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_TRACE_PAUSE           __KVM_DEPRECATED_MAIN_0x07
 #define KVM_TRACE_DISABLE         __KVM_DEPRECATED_MAIN_0x08
 #define KVM_GET_EMULATED_CPUID	  _IOWR(KVMIO, 0x09, struct kvm_cpuid2)
+#define KVM_GET_MSR_FEATURE_INDEX_LIST    _IOWR(KVMIO, 0x0a, struct kvm_msr_list)
 
 /*
  * Extension capability list.
@@ -934,6 +935,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_S390_AIS_MIGRATION 150
 #define KVM_CAP_PPC_GET_CPU_CHAR 151
 #define KVM_CAP_S390_BPB 152
+#define KVM_CAP_GET_MSR_FEATURES 153
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
diff --git a/tools/perf/Documentation/perf-kallsyms.txt b/tools/perf/Documentation/perf-kallsyms.txt
index 954ea9e21236..cf9f4040ea5c 100644
--- a/tools/perf/Documentation/perf-kallsyms.txt
+++ b/tools/perf/Documentation/perf-kallsyms.txt
@@ -8,7 +8,7 @@ perf-kallsyms - Searches running kernel for symbols
 SYNOPSIS
 --------
 [verse]
-'perf kallsyms <options> symbol_name[,symbol_name...]'
+'perf kallsyms' [<options>] symbol_name[,symbol_name...]
 
 DESCRIPTION
 -----------
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index bf4ca749d1ac..a217623fec2e 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -881,6 +881,15 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		}
 	}
 
+	/*
+	 * If we have just single event and are sending data
+	 * through pipe, we need to force the ids allocation,
+	 * because we synthesize event name through the pipe
+	 * and need the id for that.
+	 */
+	if (data->is_pipe && rec->evlist->nr_entries == 1)
+		rec->opts.sample_id = true;
+
 	if (record__open(rec) != 0) {
 		err = -1;
 		goto out_child;
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 98bf9d32f222..54a4c152edb3 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -917,7 +917,7 @@ static void print_metric_csv(void *ctx,
 	char buf[64], *vals, *ends;
 
 	if (unit == NULL || fmt == NULL) {
-		fprintf(out, "%s%s%s%s", csv_sep, csv_sep, csv_sep, csv_sep);
+		fprintf(out, "%s%s", csv_sep, csv_sep);
 		return;
 	}
 	snprintf(buf, sizeof(buf), fmt, val);
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index b7c823ba8374..35ac016fcb98 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -991,7 +991,7 @@ static int perf_top_overwrite_fallback(struct perf_top *top,
 	evlist__for_each_entry(evlist, counter)
 		counter->attr.write_backward = false;
 	opts->overwrite = false;
-	ui__warning("fall back to non-overwrite mode\n");
+	pr_debug2("fall back to non-overwrite mode\n");
 	return 1;
 }
 
diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index cfe46236a5e5..57b9b342d533 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -61,6 +61,7 @@ struct record_opts {
 	bool	     tail_synthesize;
 	bool	     overwrite;
 	bool	     ignore_missing_thread;
+	bool	     sample_id;
 	unsigned int freq;
 	unsigned int mmap_pages;
 	unsigned int auxtrace_mmap_pages;
diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 286427975112..fbf927cf775d 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -327,7 +327,32 @@ static void annotate_browser__draw_current_jump(struct ui_browser *browser)
 	if (!disasm_line__is_valid_jump(cursor, sym))
 		return;
 
+	/*
+	 * This first was seen with a gcc function, _cpp_lex_token, that
+	 * has the usual jumps:
+	 *
+	 *  │1159e6c: ↓ jne    115aa32 <_cpp_lex_token@@Base+0xf92>
+	 *
+	 * I.e. jumps to a label inside that function (_cpp_lex_token), and
+	 * those works, but also this kind:
+	 *
+	 *  │1159e8b: ↓ jne    c469be <cpp_named_operator2name@@Base+0xa72>
+	 *
+	 *  I.e. jumps to another function, outside _cpp_lex_token, which
+	 *  are not being correctly handled generating as a side effect references
+	 *  to ab->offset[] entries that are set to NULL, so to make this code
+	 *  more robust, check that here.
+	 *
+	 *  A proper fix for will be put in place, looking at the function
+	 *  name right after the '<' token and probably treating this like a
+	 *  'call' instruction.
+	 */
 	target = ab->offsets[cursor->ops.target.offset];
+	if (target == NULL) {
+		ui_helpline__printf("WARN: jump target inconsistency, press 'o', ab->offsets[%#x] = NULL\n",
+				    cursor->ops.target.offset);
+		return;
+	}
 
 	bcursor = browser_line(&cursor->al);
 	btarget = browser_line(target);
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 9faf3b5367db..6470ea2aa25e 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -60,6 +60,12 @@
 #include "sane_ctype.h"
 #include "symbol/kallsyms.h"
 
+static bool auxtrace__dont_decode(struct perf_session *session)
+{
+	return !session->itrace_synth_opts ||
+	       session->itrace_synth_opts->dont_decode;
+}
+
 int auxtrace_mmap__mmap(struct auxtrace_mmap *mm,
 			struct auxtrace_mmap_params *mp,
 			void *userpg, int fd)
@@ -762,6 +768,9 @@ int auxtrace_queues__process_index(struct auxtrace_queues *queues,
 	size_t i;
 	int err;
 
+	if (auxtrace__dont_decode(session))
+		return 0;
+
 	list_for_each_entry(auxtrace_index, &session->auxtrace_index, list) {
 		for (i = 0; i < auxtrace_index->nr; i++) {
 			ent = &auxtrace_index->entries[i];
@@ -892,12 +901,6 @@ int perf_event__synthesize_auxtrace_info(struct auxtrace_record *itr,
 	return err;
 }
 
-static bool auxtrace__dont_decode(struct perf_session *session)
-{
-	return !session->itrace_synth_opts ||
-	       session->itrace_synth_opts->dont_decode;
-}
-
 int perf_event__process_auxtrace_info(struct perf_tool *tool __maybe_unused,
 				      union perf_event *event,
 				      struct perf_session *session)
diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
index 1e97937b03a9..6f09e4962dad 100644
--- a/tools/perf/util/record.c
+++ b/tools/perf/util/record.c
@@ -137,6 +137,7 @@ void perf_evlist__config(struct perf_evlist *evlist, struct record_opts *opts,
 	struct perf_evsel *evsel;
 	bool use_sample_identifier = false;
 	bool use_comm_exec;
+	bool sample_id = opts->sample_id;
 
 	/*
 	 * Set the evsel leader links before we configure attributes,
@@ -163,8 +164,7 @@ void perf_evlist__config(struct perf_evlist *evlist, struct record_opts *opts,
 		 * match the id.
 		 */
 		use_sample_identifier = perf_can_sample_identifier();
-		evlist__for_each_entry(evlist, evsel)
-			perf_evsel__set_sample_id(evsel, use_sample_identifier);
+		sample_id = true;
 	} else if (evlist->nr_entries > 1) {
 		struct perf_evsel *first = perf_evlist__first(evlist);
 
@@ -174,6 +174,10 @@ void perf_evlist__config(struct perf_evlist *evlist, struct record_opts *opts,
 			use_sample_identifier = perf_can_sample_identifier();
 			break;
 		}
+		sample_id = true;
+	}
+
+	if (sample_id) {
 		evlist__for_each_entry(evlist, evsel)
 			perf_evsel__set_sample_id(evsel, use_sample_identifier);
 	}
diff --git a/tools/perf/util/trigger.h b/tools/perf/util/trigger.h
index 370138e7e35c..88223bc7c82b 100644
--- a/tools/perf/util/trigger.h
+++ b/tools/perf/util/trigger.h
@@ -12,7 +12,7 @@
  * States and transits:
  *
  *
- *  OFF--(on)--> READY --(hit)--> HIT
+ *  OFF--> ON --> READY --(hit)--> HIT
  *                 ^               |
  *                 |            (ready)
  *                 |               |
@@ -27,8 +27,9 @@ struct trigger {
 	volatile enum {
 		TRIGGER_ERROR		= -2,
 		TRIGGER_OFF		= -1,
-		TRIGGER_READY		= 0,
-		TRIGGER_HIT		= 1,
+		TRIGGER_ON		= 0,
+		TRIGGER_READY		= 1,
+		TRIGGER_HIT		= 2,
 	} state;
 	const char *name;
 };
@@ -50,7 +51,7 @@ static inline bool trigger_is_error(struct trigger *t)
 static inline void trigger_on(struct trigger *t)
 {
 	TRIGGER_WARN_ONCE(t, TRIGGER_OFF);
-	t->state = TRIGGER_READY;
+	t->state = TRIGGER_ON;
 }
 
 static inline void trigger_ready(struct trigger *t)
--8323329-1852947682-1520784708=:3841--
