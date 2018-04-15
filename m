Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752577AbeDORgT (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 13:36:19 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:47383 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752460AbeDORgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 13:36:16 -0400
Date: Sun, 15 Apr 2018 19:36:13 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] perf updates for 4.17
Message-ID: <alpine.DEB.2.21.1804151926570.17929@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest perf-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

A rather large set of perf updates:

   - Show only failing syscalls with 'perf trace --failure' (Arnaldo Carvalho de Melo)
    
            e.g: See what 'openat' syscalls are failing:
    
      # perf trace --failure -e openat
       762.323 ( 0.007 ms): VideoCapture/4566 openat(dfd: CWD, filename: /dev/video2) = -1 ENOENT No such file or directory
       <SNIP N /dev/videoN open attempts... sigh, where is that improvised camera lid?!? >
       790.228 ( 0.008 ms): VideoCapture/4566 openat(dfd: CWD, filename: /dev/video63) = -1 ENOENT No such file or directory
      ^C#
    
    - Show information about the event (freq, nr_samples, total period/nr_events) in
      the annotate --tui and --stdio2 'perf annotate' output, similar to the
      first line in the 'perf report --tui', but just for the samples for a
      the annotated symbol (Arnaldo Carvalho de Melo)
    
    - Introduce 'perf version --build-options' to show what features were
      linked, aliased as well as a shorter 'perf -vv' (Jin Yao)
    
    - Add a "dso_size" sort order (Kim Phillips)
    
    - Remove redundant ')' in the tracepoint output in 'perf trace' (Changbin Du)
    
    - Synchronize x86's cpufeatures.h, no effect on toolss (Arnaldo Carvalho de Melo)

    - Show group details on the title line in the annotate browser
      and 'perf annotate --stdio2' output, so that the per-event
      columns can have headers (Arnaldo Carvalho de Melo)
    
    - Fixup vertical line separating metrics from instructions and
      cleaning unused lines at the bottom, both in the annotate TUI
      browser (Arnaldo Carvalho de Melo)
    
    - Remove duplicated 'samples' in lost samples warning in
      'perf report' (Arnaldo Carvalho de Melo)
    
    - Synchronize i915_drm.h, silencing the perf build process,
      automagically adding support for the new DRM_I915_QUERY
      ioctl (Arnaldo Carvalho de Melo)
    
    - Make auxtrace_queues__add_buffer() allocate struct buffer,
      from a patchkit already applied (Adrian Hunter)

    . Fix the --stdio2/TUI annotate output to include group details,
      be it for a recorded '{a,b,f}' explicit event group or when
      forcing group display using 'perf report --group' for a set of
      events not recorded as a group (Arnaldo Carvalho de Melo)
    
    . Fix display artifacts in the ui browser (base class for the
      annotate and main report/top TUI browser) related to the extra
      title lines work (Arnaldo Carvalho de Melo)
    
    . perf auxtrace refactorings, leftovers from a previously partially
      processed patchset (Adrian Hunter)
    
    . Fix the builtin clang build (Sandipan Das, Arnaldo Carvalho de Melo)
    
    - Synchronize i915_drm.h, silencing a perf build warning and
      in the process automagically adding support for a new ioctl
      command (Arnaldo Carvalho de Melo)

    - Fix various initialization issues

    - Prevent creating [ku]probes for not CAP_SYS_ADMIN users

    - Fix a strncpy issue in uprobe tracing

Thanks,

	tglx

------------------>
Adrian Hunter (2):
      perf auxtrace: Make auxtrace_queues__add_buffer() allocate struct buffer
      perf auxtrace: Make auxtrace_queues__add_buffer() do CPU filtering

Arnaldo Carvalho de Melo (17):
      tools headers: Synchronize x86's cpufeatures.h
      perf trace: Show only failing syscalls
      perf hists browser: Rename perf_evsel_browser_title to a more descriptive name
      perf hists: Introduce hists__scnprint_title()
      perf hists: Move hists__scnprintf_title() away from the TUI code
      perf ui browser: Move the extra title lines from the hists browser
      perf annotate: Introduce annotation__scnprintf_samples_period() method
      perf annotate browser: Show extra title line with event information
      perf annotate stdio2: Print more descriptive event information header
      perf annotate: Show group details on the title line
      perf annotate browser: Fixup vertical line separating metrics from instructions
      perf ui browser: Fixup cleaning unused lines at the bottom
      perf report: Remove duplicated 'samples' in lost samples warning
      tools headers uapi: Synchronize i915_drm.h
      perf hists browser: Show extra_title_lines in the 'D' debug hotkey
      perf hists browser: Remove leftover from row returned from refresh
      perf tools: No need to include namespaces.h in util.h

Changbin Du (1):
      perf trace: Remove redundant ')'

Jin Yao (5):
      perf config: Add some new -DHAVE_XXX to CFLAGS
      perf config: Rename to HAVE_DWARF_GETLOCATIONS_SUPPORT
      perf version: Print the compiled-in status of libraries
      perf tools: Add 'perf -vv' as an alias to 'perf version --build-options'
      perf version: Add man page

Jiri Olsa (1):
      tools include: Add config.h header file

Kim Phillips (1):
      perf tools: Add a "dso_size" sort order

Masami Hiramatsu (2):
      perf/core: Fix perf_kprobe_init()
      tracing/uprobe_event: Fix strncpy corner case

Prashant Bhole (1):
      perf/core: Fix use-after-free in uprobe_perf_close()

Sandipan Das (3):
      perf tools: Fix perf builds with clang support
      perf clang: Add support for recent clang versions
      perf tests clang: Fix function name for clang IR test

Song Liu (2):
      perf/core: Fix perf_uprobe_init()
      perf/core: Need CAP_SYS_ADMIN to create k/uprobe with perf_event_open()

Stephane Eranian (1):
      perf/x86/intel: Move regs->flags EXACT bit init


 arch/x86/events/intel/ds.c                |  34 +++++---
 kernel/events/core.c                      |  14 +++
 kernel/trace/trace_event_perf.c           |   4 +
 kernel/trace/trace_uprobe.c               |   2 +
 tools/arch/x86/include/asm/cpufeatures.h  |   2 +
 tools/include/tools/config.h              |  34 ++++++++
 tools/include/uapi/drm/i915_drm.h         | 112 +++++++++++++++++++++++-
 tools/perf/Documentation/perf-report.txt  |   1 +
 tools/perf/Documentation/perf-trace.txt   |   3 +
 tools/perf/Documentation/perf-version.txt |  24 ++++++
 tools/perf/Makefile.config                |   8 +-
 tools/perf/Makefile.perf                  |   3 +-
 tools/perf/builtin-trace.c                |  11 ++-
 tools/perf/builtin-version.c              |  82 +++++++++++++++++-
 tools/perf/perf.c                         |   6 ++
 tools/perf/perf.h                         |   1 +
 tools/perf/ui/browser.c                   |  12 ++-
 tools/perf/ui/browser.h                   |   2 +
 tools/perf/ui/browsers/annotate.c         |  33 +++++--
 tools/perf/ui/browsers/hists.c            | 138 +++++++-----------------------
 tools/perf/util/annotate.c                |  51 +++++++++--
 tools/perf/util/annotate.h                |  12 +++
 tools/perf/util/auxtrace.c                |  72 +++++++---------
 tools/perf/util/c++/clang-test.cpp        |   2 +-
 tools/perf/util/c++/clang.cpp             |  11 ++-
 tools/perf/util/dwarf-aux.c               |   2 +-
 tools/perf/util/hist.c                    |  81 ++++++++++++++++++
 tools/perf/util/hist.h                    |   7 ++
 tools/perf/util/map.h                     |   4 +
 tools/perf/util/session.c                 |   2 +-
 tools/perf/util/sort.c                    |  41 +++++++++
 tools/perf/util/sort.h                    |   1 +
 tools/perf/util/util.h                    |   4 +-
 33 files changed, 629 insertions(+), 187 deletions(-)
 create mode 100644 tools/include/tools/config.h
 create mode 100644 tools/perf/Documentation/perf-version.txt

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index da6780122786..8a10a045b57b 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1153,7 +1153,6 @@ static void setup_pebs_sample_data(struct perf_event *event,
 	if (pebs == NULL)
 		return;
 
-	regs->flags &= ~PERF_EFLAGS_EXACT;
 	sample_type = event->attr.sample_type;
 	dsrc = sample_type & PERF_SAMPLE_DATA_SRC;
 
@@ -1197,7 +1196,13 @@ static void setup_pebs_sample_data(struct perf_event *event,
 	 * and PMI.
 	 */
 	*regs = *iregs;
-	regs->flags = pebs->flags;
+
+	/*
+	 * Initialize regs_>flags from PEBS,
+	 * Clear exact bit (which uses x86 EFLAGS Reserved bit 3),
+	 * i.e., do not rely on it being zero:
+	 */
+	regs->flags = pebs->flags & ~PERF_EFLAGS_EXACT;
 
 	if (sample_type & PERF_SAMPLE_REGS_INTR) {
 		regs->ax = pebs->ax;
@@ -1217,10 +1222,6 @@ static void setup_pebs_sample_data(struct perf_event *event,
 			regs->sp = pebs->sp;
 		}
 
-		/*
-		 * Preserve PERF_EFLAGS_VM from set_linear_ip().
-		 */
-		regs->flags = pebs->flags | (regs->flags & PERF_EFLAGS_VM);
 #ifndef CONFIG_X86_32
 		regs->r8 = pebs->r8;
 		regs->r9 = pebs->r9;
@@ -1234,20 +1235,33 @@ static void setup_pebs_sample_data(struct perf_event *event,
 	}
 
 	if (event->attr.precise_ip > 1) {
-		/* Haswell and later have the eventing IP, so use it: */
+		/*
+		 * Haswell and later processors have an 'eventing IP'
+		 * (real IP) which fixes the off-by-1 skid in hardware.
+		 * Use it when precise_ip >= 2 :
+		 */
 		if (x86_pmu.intel_cap.pebs_format >= 2) {
 			set_linear_ip(regs, pebs->real_ip);
 			regs->flags |= PERF_EFLAGS_EXACT;
 		} else {
-			/* Otherwise use PEBS off-by-1 IP: */
+			/* Otherwise, use PEBS off-by-1 IP: */
 			set_linear_ip(regs, pebs->ip);
 
-			/* ... and try to fix it up using the LBR entries: */
+			/*
+			 * With precise_ip >= 2, try to fix up the off-by-1 IP
+			 * using the LBR. If successful, the fixup function
+			 * corrects regs->ip and calls set_linear_ip() on regs:
+			 */
 			if (intel_pmu_pebs_fixup_ip(regs))
 				regs->flags |= PERF_EFLAGS_EXACT;
 		}
-	} else
+	} else {
+		/*
+		 * When precise_ip == 1, return the PEBS off-by-1 IP,
+		 * no fixup attempted:
+		 */
 		set_linear_ip(regs, pebs->ip);
+	}
 
 
 	if ((sample_type & (PERF_SAMPLE_ADDR | PERF_SAMPLE_PHYS_ADDR)) &&
diff --git a/kernel/events/core.c b/kernel/events/core.c
index fc1c330c6bd6..2d5fe26551f8 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4447,6 +4447,9 @@ static void _free_event(struct perf_event *event)
 	if (event->ctx)
 		put_ctx(event->ctx);
 
+	if (event->hw.target)
+		put_task_struct(event->hw.target);
+
 	exclusive_event_destroy(event);
 	module_put(event->pmu->module);
 
@@ -8397,6 +8400,10 @@ static int perf_kprobe_event_init(struct perf_event *event)
 
 	if (event->attr.type != perf_kprobe.type)
 		return -ENOENT;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
 	/*
 	 * no branch sampling for probe events
 	 */
@@ -8434,6 +8441,10 @@ static int perf_uprobe_event_init(struct perf_event *event)
 
 	if (event->attr.type != perf_uprobe.type)
 		return -ENOENT;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
 	/*
 	 * no branch sampling for probe events
 	 */
@@ -9955,6 +9966,7 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 		 * and we cannot use the ctx information because we need the
 		 * pmu before we get a ctx.
 		 */
+		get_task_struct(task);
 		event->hw.target = task;
 	}
 
@@ -10070,6 +10082,8 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 		perf_detach_cgroup(event);
 	if (event->ns)
 		put_pid_ns(event->ns);
+	if (event->hw.target)
+		put_task_struct(event->hw.target);
 	kfree(event);
 
 	return ERR_PTR(err);
diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
index 2c416509b834..c79193e598f5 100644
--- a/kernel/trace/trace_event_perf.c
+++ b/kernel/trace/trace_event_perf.c
@@ -252,6 +252,8 @@ int perf_kprobe_init(struct perf_event *p_event, bool is_retprobe)
 		ret = strncpy_from_user(
 			func, u64_to_user_ptr(p_event->attr.kprobe_func),
 			KSYM_NAME_LEN);
+		if (ret == KSYM_NAME_LEN)
+			ret = -E2BIG;
 		if (ret < 0)
 			goto out;
 
@@ -300,6 +302,8 @@ int perf_uprobe_init(struct perf_event *p_event, bool is_retprobe)
 		return -ENOMEM;
 	ret = strncpy_from_user(
 		path, u64_to_user_ptr(p_event->attr.uprobe_path), PATH_MAX);
+	if (ret == PATH_MAX)
+		return -E2BIG;
 	if (ret < 0)
 		goto out;
 	if (path[0] == '\0') {
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 2014f4351ae0..0d450b40988e 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -151,6 +151,8 @@ static void FETCH_FUNC_NAME(memory, string)(struct pt_regs *regs,
 		return;
 
 	ret = strncpy_from_user(dst, src, maxlen);
+	if (ret == maxlen)
+		dst[--ret] = '\0';
 
 	if (ret < 0) {	/* Failed to fetch string */
 		((u8 *)get_rloc_data(dest))[0] = '\0';
diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index f41079da38c5..d554c11e01ff 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -316,6 +316,7 @@
 #define X86_FEATURE_VPCLMULQDQ		(16*32+10) /* Carry-Less Multiplication Double Quadword */
 #define X86_FEATURE_AVX512_VNNI		(16*32+11) /* Vector Neural Network Instructions */
 #define X86_FEATURE_AVX512_BITALG	(16*32+12) /* Support for VPOPCNT[B,W] and VPSHUF-BITQMB instructions */
+#define X86_FEATURE_TME			(16*32+13) /* Intel Total Memory Encryption */
 #define X86_FEATURE_AVX512_VPOPCNTDQ	(16*32+14) /* POPCNT for vectors of DW/QW */
 #define X86_FEATURE_LA57		(16*32+16) /* 5-level page tables */
 #define X86_FEATURE_RDPID		(16*32+22) /* RDPID instruction */
@@ -328,6 +329,7 @@
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (EDX), word 18 */
 #define X86_FEATURE_AVX512_4VNNIW	(18*32+ 2) /* AVX-512 Neural Network Instructions */
 #define X86_FEATURE_AVX512_4FMAPS	(18*32+ 3) /* AVX-512 Multiply Accumulation Single precision */
+#define X86_FEATURE_PCONFIG		(18*32+18) /* Intel PCONFIG */
 #define X86_FEATURE_SPEC_CTRL		(18*32+26) /* "" Speculation Control (IBRS + IBPB) */
 #define X86_FEATURE_INTEL_STIBP		(18*32+27) /* "" Single Thread Indirect Branch Predictors */
 #define X86_FEATURE_ARCH_CAPABILITIES	(18*32+29) /* IA32_ARCH_CAPABILITIES MSR (Intel) */
diff --git a/tools/include/tools/config.h b/tools/include/tools/config.h
new file mode 100644
index 000000000000..08ade7df8132
--- /dev/null
+++ b/tools/include/tools/config.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _TOOLS_CONFIG_H
+#define _TOOLS_CONFIG_H
+
+/* Subset of include/linux/kconfig.h */
+
+#define __ARG_PLACEHOLDER_1 0,
+#define __take_second_arg(__ignored, val, ...) val
+
+/*
+ * Helper macros to use CONFIG_ options in C/CPP expressions. Note that
+ * these only work with boolean and tristate options.
+ */
+
+/*
+ * Getting something that works in C and CPP for an arg that may or may
+ * not be defined is tricky.  Here, if we have "#define CONFIG_BOOGER 1"
+ * we match on the placeholder define, insert the "0," for arg1 and generate
+ * the triplet (0, 1, 0).  Then the last step cherry picks the 2nd arg (a one).
+ * When CONFIG_BOOGER is not defined, we generate a (... 1, 0) pair, and when
+ * the last step cherry picks the 2nd arg, we get a zero.
+ */
+#define __is_defined(x)			___is_defined(x)
+#define ___is_defined(val)		____is_defined(__ARG_PLACEHOLDER_##val)
+#define ____is_defined(arg1_or_junk)	__take_second_arg(arg1_or_junk 1, 0)
+
+/*
+ * IS_BUILTIN(CONFIG_FOO) evaluates to 1 if CONFIG_FOO is set to 'y', 0
+ * otherwise. For boolean options, this is equivalent to
+ * IS_ENABLED(CONFIG_FOO).
+ */
+#define IS_BUILTIN(option) __is_defined(option)
+
+#endif /* _TOOLS_CONFIG_H */
diff --git a/tools/include/uapi/drm/i915_drm.h b/tools/include/uapi/drm/i915_drm.h
index 536ee4febd74..7f5634ce8e88 100644
--- a/tools/include/uapi/drm/i915_drm.h
+++ b/tools/include/uapi/drm/i915_drm.h
@@ -318,6 +318,7 @@ typedef struct _drm_i915_sarea {
 #define DRM_I915_PERF_OPEN		0x36
 #define DRM_I915_PERF_ADD_CONFIG	0x37
 #define DRM_I915_PERF_REMOVE_CONFIG	0x38
+#define DRM_I915_QUERY			0x39
 
 #define DRM_IOCTL_I915_INIT		DRM_IOW( DRM_COMMAND_BASE + DRM_I915_INIT, drm_i915_init_t)
 #define DRM_IOCTL_I915_FLUSH		DRM_IO ( DRM_COMMAND_BASE + DRM_I915_FLUSH)
@@ -375,6 +376,7 @@ typedef struct _drm_i915_sarea {
 #define DRM_IOCTL_I915_PERF_OPEN	DRM_IOW(DRM_COMMAND_BASE + DRM_I915_PERF_OPEN, struct drm_i915_perf_open_param)
 #define DRM_IOCTL_I915_PERF_ADD_CONFIG	DRM_IOW(DRM_COMMAND_BASE + DRM_I915_PERF_ADD_CONFIG, struct drm_i915_perf_oa_config)
 #define DRM_IOCTL_I915_PERF_REMOVE_CONFIG	DRM_IOW(DRM_COMMAND_BASE + DRM_I915_PERF_REMOVE_CONFIG, __u64)
+#define DRM_IOCTL_I915_QUERY			DRM_IOWR(DRM_COMMAND_BASE + DRM_I915_QUERY, struct drm_i915_query)
 
 /* Allow drivers to submit batchbuffers directly to hardware, relying
  * on the security mechanisms provided by hardware.
@@ -1358,7 +1360,9 @@ struct drm_intel_overlay_attrs {
  * active on a given plane.
  */
 
-#define I915_SET_COLORKEY_NONE		(1<<0) /* disable color key matching */
+#define I915_SET_COLORKEY_NONE		(1<<0) /* Deprecated. Instead set
+						* flags==0 to disable colorkeying.
+						*/
 #define I915_SET_COLORKEY_DESTINATION	(1<<1)
 #define I915_SET_COLORKEY_SOURCE	(1<<2)
 struct drm_intel_sprite_colorkey {
@@ -1604,15 +1608,115 @@ struct drm_i915_perf_oa_config {
 	__u32 n_flex_regs;
 
 	/*
-	 * These fields are pointers to tuples of u32 values (register
-	 * address, value). For example the expected length of the buffer
-	 * pointed by mux_regs_ptr is (2 * sizeof(u32) * n_mux_regs).
+	 * These fields are pointers to tuples of u32 values (register address,
+	 * value). For example the expected length of the buffer pointed by
+	 * mux_regs_ptr is (2 * sizeof(u32) * n_mux_regs).
 	 */
 	__u64 mux_regs_ptr;
 	__u64 boolean_regs_ptr;
 	__u64 flex_regs_ptr;
 };
 
+struct drm_i915_query_item {
+	__u64 query_id;
+#define DRM_I915_QUERY_TOPOLOGY_INFO    1
+
+	/*
+	 * When set to zero by userspace, this is filled with the size of the
+	 * data to be written at the data_ptr pointer. The kernel sets this
+	 * value to a negative value to signal an error on a particular query
+	 * item.
+	 */
+	__s32 length;
+
+	/*
+	 * Unused for now. Must be cleared to zero.
+	 */
+	__u32 flags;
+
+	/*
+	 * Data will be written at the location pointed by data_ptr when the
+	 * value of length matches the length of the data to be written by the
+	 * kernel.
+	 */
+	__u64 data_ptr;
+};
+
+struct drm_i915_query {
+	__u32 num_items;
+
+	/*
+	 * Unused for now. Must be cleared to zero.
+	 */
+	__u32 flags;
+
+	/*
+	 * This points to an array of num_items drm_i915_query_item structures.
+	 */
+	__u64 items_ptr;
+};
+
+/*
+ * Data written by the kernel with query DRM_I915_QUERY_TOPOLOGY_INFO :
+ *
+ * data: contains the 3 pieces of information :
+ *
+ * - the slice mask with one bit per slice telling whether a slice is
+ *   available. The availability of slice X can be queried with the following
+ *   formula :
+ *
+ *           (data[X / 8] >> (X % 8)) & 1
+ *
+ * - the subslice mask for each slice with one bit per subslice telling
+ *   whether a subslice is available. The availability of subslice Y in slice
+ *   X can be queried with the following formula :
+ *
+ *           (data[subslice_offset +
+ *                 X * subslice_stride +
+ *                 Y / 8] >> (Y % 8)) & 1
+ *
+ * - the EU mask for each subslice in each slice with one bit per EU telling
+ *   whether an EU is available. The availability of EU Z in subslice Y in
+ *   slice X can be queried with the following formula :
+ *
+ *           (data[eu_offset +
+ *                 (X * max_subslices + Y) * eu_stride +
+ *                 Z / 8] >> (Z % 8)) & 1
+ */
+struct drm_i915_query_topology_info {
+	/*
+	 * Unused for now. Must be cleared to zero.
+	 */
+	__u16 flags;
+
+	__u16 max_slices;
+	__u16 max_subslices;
+	__u16 max_eus_per_subslice;
+
+	/*
+	 * Offset in data[] at which the subslice masks are stored.
+	 */
+	__u16 subslice_offset;
+
+	/*
+	 * Stride at which each of the subslice masks for each slice are
+	 * stored.
+	 */
+	__u16 subslice_stride;
+
+	/*
+	 * Offset in data[] at which the EU masks are stored.
+	 */
+	__u16 eu_offset;
+
+	/*
+	 * Stride at which each of the EU masks for each subslice are stored.
+	 */
+	__u16 eu_stride;
+
+	__u8 data[];
+};
+
 #if defined(__cplusplus)
 }
 #endif
diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index e1a660e60849..917e36fde6d8 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -80,6 +80,7 @@ OPTIONS
 	- comm: command (name) of the task which can be read via /proc/<pid>/comm
 	- pid: command and tid of the task
 	- dso: name of library or module executed at the time of sample
+	- dso_size: size of library or module executed at the time of sample
 	- symbol: name of function executed at the time of sample
 	- symbol_size: size of function executed at the time of sample
 	- parent: name of function matched to the parent regex filter. Unmatched
diff --git a/tools/perf/Documentation/perf-trace.txt b/tools/perf/Documentation/perf-trace.txt
index 5a7035c5c523..115db9e06ecd 100644
--- a/tools/perf/Documentation/perf-trace.txt
+++ b/tools/perf/Documentation/perf-trace.txt
@@ -117,6 +117,9 @@ the thread executes on the designated CPUs. Default is to monitor all CPUs.
 --sched::
 	Accrue thread runtime and provide a summary at the end of the session.
 
+--failure::
+	Show only syscalls that failed, i.e. that returned < 0.
+
 -i::
 --input::
 	Process events from a given perf data file.
diff --git a/tools/perf/Documentation/perf-version.txt b/tools/perf/Documentation/perf-version.txt
new file mode 100644
index 000000000000..e207b7cfca26
--- /dev/null
+++ b/tools/perf/Documentation/perf-version.txt
@@ -0,0 +1,24 @@
+perf-version(1)
+===============
+
+NAME
+----
+perf-version - display the version of perf binary
+
+SYNOPSIS
+--------
+'perf version' [--build-options]
+
+DESCRIPTION
+-----------
+With no options given, the 'perf version' prints the perf version
+on the standard output.
+
+If the option '--build-options' is given, then the status of
+compiled-in libraries are printed on the standard output.
+
+OPTIONS
+-------
+--build-options::
+        Prints the status of compiled-in libraries on the
+        standard output.
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 98ff73648b51..c7abd83a8e19 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -346,12 +346,16 @@ else
       ifneq ($(feature-dwarf_getlocations), 1)
         msg := $(warning Old libdw.h, finding variables at given 'perf probe' point will not work, install elfutils-devel/libdw-dev >= 0.157);
       else
-        CFLAGS += -DHAVE_DWARF_GETLOCATIONS
+        CFLAGS += -DHAVE_DWARF_GETLOCATIONS_SUPPORT
       endif # dwarf_getlocations
     endif # Dwarf support
   endif # libelf support
 endif # NO_LIBELF
 
+ifeq ($(feature-glibc), 1)
+  CFLAGS += -DHAVE_GLIBC_SUPPORT
+endif
+
 ifdef NO_DWARF
   NO_LIBDW_DWARF_UNWIND := 1
 endif
@@ -635,6 +639,7 @@ else
   else
     LDFLAGS += $(PERL_EMBED_LDFLAGS)
     EXTLIBS += $(PERL_EMBED_LIBADD)
+    CFLAGS += -DHAVE_LIBPERL_SUPPORT
     $(call detected,CONFIG_LIBPERL)
   endif
 endif
@@ -671,6 +676,7 @@ else
          LDFLAGS += $(PYTHON_EMBED_LDFLAGS)
          EXTLIBS += $(PYTHON_EMBED_LIBADD)
          LANG_BINDINGS += $(obj-perf)python/perf.so
+         CFLAGS += -DHAVE_LIBPYTHON_SUPPORT
          $(call detected,CONFIG_LIBPYTHON)
       endif
     endif
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index f7517e1b73f8..83e453de36f8 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -364,7 +364,8 @@ LIBS = -Wl,--whole-archive $(PERFLIBS) $(EXTRA_PERFLIBS) -Wl,--no-whole-archive
 
 ifeq ($(USE_CLANG), 1)
   CLANGLIBS_LIST = AST Basic CodeGen Driver Frontend Lex Tooling Edit Sema Analysis Parse Serialization
-  LIBCLANG = $(foreach l,$(CLANGLIBS_LIST),$(wildcard $(shell $(LLVM_CONFIG) --libdir)/libclang$(l).a))
+  CLANGLIBS_NOEXT_LIST = $(foreach l,$(CLANGLIBS_LIST),$(shell $(LLVM_CONFIG) --libdir)/libclang$(l))
+  LIBCLANG = $(foreach l,$(CLANGLIBS_NOEXT_LIST),$(wildcard $(l).a $(l).so))
   LIBS += -Wl,--start-group $(LIBCLANG) -Wl,--end-group
 endif
 
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 87b95c9410b4..3ad17ee89403 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -112,6 +112,7 @@ struct trace {
 	bool			multiple_threads;
 	bool			summary;
 	bool			summary_only;
+	bool			failure_only;
 	bool			show_comm;
 	bool			print_sample;
 	bool			show_tool_stats;
@@ -1565,7 +1566,7 @@ static int trace__printf_interrupted_entry(struct trace *trace)
 	struct thread_trace *ttrace;
 	size_t printed;
 
-	if (trace->current == NULL)
+	if (trace->failure_only || trace->current == NULL)
 		return 0;
 
 	ttrace = thread__priv(trace->current);
@@ -1638,7 +1639,7 @@ static int trace__sys_enter(struct trace *trace, struct perf_evsel *evsel,
 					   args, trace, thread);
 
 	if (sc->is_exit) {
-		if (!(trace->duration_filter || trace->summary_only || trace->min_stack)) {
+		if (!(trace->duration_filter || trace->summary_only || trace->failure_only || trace->min_stack)) {
 			trace__fprintf_entry_head(trace, thread, 0, false, ttrace->entry_time, trace->output);
 			fprintf(trace->output, "%-70s)\n", ttrace->entry_str);
 		}
@@ -1742,7 +1743,7 @@ static int trace__sys_exit(struct trace *trace, struct perf_evsel *evsel,
 		}
 	}
 
-	if (trace->summary_only)
+	if (trace->summary_only || (ret >= 0 && trace->failure_only))
 		goto out;
 
 	trace__fprintf_entry_head(trace, thread, duration, duration_calculated, ttrace->entry_time, trace->output);
@@ -1961,7 +1962,7 @@ static int trace__event_handler(struct trace *trace, struct perf_evsel *evsel,
 				      trace->output);
 	}
 
-	fprintf(trace->output, ")\n");
+	fprintf(trace->output, "\n");
 
 	if (callchain_ret > 0)
 		trace__fprintf_callchain(trace, sample);
@@ -3087,6 +3088,8 @@ int cmd_trace(int argc, const char **argv)
 	OPT_INCR('v', "verbose", &verbose, "be more verbose"),
 	OPT_BOOLEAN('T', "time", &trace.full_time,
 		    "Show full timestamp, not time relative to first start"),
+	OPT_BOOLEAN(0, "failure", &trace.failure_only,
+		    "Show only syscalls that failed"),
 	OPT_BOOLEAN('s', "summary", &trace.summary_only,
 		    "Show only syscall summary with statistics"),
 	OPT_BOOLEAN('S', "with-summary", &trace.summary,
diff --git a/tools/perf/builtin-version.c b/tools/perf/builtin-version.c
index 37019c5d675f..2abe3910d6b6 100644
--- a/tools/perf/builtin-version.c
+++ b/tools/perf/builtin-version.c
@@ -1,11 +1,91 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "builtin.h"
 #include "perf.h"
+#include "color.h"
 #include <linux/compiler.h>
+#include <tools/config.h>
 #include <stdio.h>
+#include <string.h>
+#include <subcmd/parse-options.h>
 
-int cmd_version(int argc __maybe_unused, const char **argv __maybe_unused)
+int version_verbose;
+
+struct version {
+	bool	build_options;
+};
+
+static struct version version;
+
+static struct option version_options[] = {
+	OPT_BOOLEAN(0, "build-options", &version.build_options,
+		    "display the build options"),
+};
+
+static const char * const version_usage[] = {
+	"perf version [<options>]",
+	NULL
+};
+
+static void on_off_print(const char *status)
+{
+	printf("[ ");
+
+	if (!strcmp(status, "OFF"))
+		color_fprintf(stdout, PERF_COLOR_RED, "%-3s", status);
+	else
+		color_fprintf(stdout, PERF_COLOR_GREEN, "%-3s", status);
+
+	printf(" ]");
+}
+
+static void status_print(const char *name, const char *macro,
+			 const char *status)
 {
+	printf("%22s: ", name);
+	on_off_print(status);
+	printf("  # %s\n", macro);
+}
+
+#define STATUS(__d, __m)				\
+do {							\
+	if (IS_BUILTIN(__d))				\
+		status_print(#__m, #__d, "on");		\
+	else						\
+		status_print(#__m, #__d, "OFF");	\
+} while (0)
+
+static void library_status(void)
+{
+	STATUS(HAVE_DWARF_SUPPORT, dwarf);
+	STATUS(HAVE_DWARF_GETLOCATIONS_SUPPORT, dwarf_getlocations);
+	STATUS(HAVE_GLIBC_SUPPORT, glibc);
+	STATUS(HAVE_GTK2_SUPPORT, gtk2);
+	STATUS(HAVE_LIBAUDIT_SUPPORT, libaudit);
+	STATUS(HAVE_LIBBFD_SUPPORT, libbfd);
+	STATUS(HAVE_LIBELF_SUPPORT, libelf);
+	STATUS(HAVE_LIBNUMA_SUPPORT, libnuma);
+	STATUS(HAVE_LIBNUMA_SUPPORT, numa_num_possible_cpus);
+	STATUS(HAVE_LIBPERL_SUPPORT, libperl);
+	STATUS(HAVE_LIBPYTHON_SUPPORT, libpython);
+	STATUS(HAVE_SLANG_SUPPORT, libslang);
+	STATUS(HAVE_LIBCRYPTO_SUPPORT, libcrypto);
+	STATUS(HAVE_LIBUNWIND_SUPPORT, libunwind);
+	STATUS(HAVE_DWARF_SUPPORT, libdw-dwarf-unwind);
+	STATUS(HAVE_ZLIB_SUPPORT, zlib);
+	STATUS(HAVE_LZMA_SUPPORT, lzma);
+	STATUS(HAVE_AUXTRACE_SUPPORT, get_cpuid);
+	STATUS(HAVE_LIBBPF_SUPPORT, bpf);
+}
+
+int cmd_version(int argc, const char **argv)
+{
+	argc = parse_options(argc, argv, version_options, version_usage,
+			     PARSE_OPT_STOP_AT_NON_OPTION);
+
 	printf("perf version %s\n", perf_version_string);
+
+	if (version.build_options || version_verbose == 1)
+		library_status();
+
 	return 0;
 }
diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index 1b3fc8ec0fa2..1659029d03fc 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -190,6 +190,12 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			break;
 		}
 
+		if (!strcmp(cmd, "-vv")) {
+			(*argv)[0] = "version";
+			version_verbose = 1;
+			break;
+		}
+
 		/*
 		 * Check remaining flags.
 		 */
diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index 8fec1abd0f1f..a1a97956136f 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -84,6 +84,7 @@ struct record_opts {
 struct option;
 extern const char * const *record_usage;
 extern struct option *record_options;
+extern int version_verbose;
 
 int record__parse_freq(const struct option *opt, const char *str, int unset);
 #endif
diff --git a/tools/perf/ui/browser.c b/tools/perf/ui/browser.c
index 9f6ce29b83b4..4f75561424ed 100644
--- a/tools/perf/ui/browser.c
+++ b/tools/perf/ui/browser.c
@@ -45,11 +45,16 @@ void ui_browser__set_percent_color(struct ui_browser *browser,
 	 ui_browser__set_color(browser, color);
 }
 
-void ui_browser__gotorc(struct ui_browser *browser, int y, int x)
+void ui_browser__gotorc_title(struct ui_browser *browser, int y, int x)
 {
 	SLsmg_gotorc(browser->y + y, browser->x + x);
 }
 
+void ui_browser__gotorc(struct ui_browser *browser, int y, int x)
+{
+	SLsmg_gotorc(browser->y + y + browser->extra_title_lines, browser->x + x);
+}
+
 void ui_browser__write_nstring(struct ui_browser *browser __maybe_unused, const char *msg,
 			       unsigned int width)
 {
@@ -191,6 +196,7 @@ void ui_browser__refresh_dimensions(struct ui_browser *browser)
 {
 	browser->width = SLtt_Screen_Cols - 1;
 	browser->height = browser->rows = SLtt_Screen_Rows - 2;
+	browser->rows -= browser->extra_title_lines;
 	browser->y = 1;
 	browser->x = 0;
 }
@@ -337,8 +343,8 @@ static int __ui_browser__refresh(struct ui_browser *browser)
 	else
 		width += 1;
 
-	SLsmg_fill_region(browser->y + row, browser->x,
-			  browser->height - row, width, ' ');
+	SLsmg_fill_region(browser->y + row + browser->extra_title_lines, browser->x,
+			  browser->rows - row, width, ' ');
 
 	return 0;
 }
diff --git a/tools/perf/ui/browser.h b/tools/perf/ui/browser.h
index 70057178ee34..aa5932e1d62e 100644
--- a/tools/perf/ui/browser.h
+++ b/tools/perf/ui/browser.h
@@ -17,6 +17,7 @@ struct ui_browser {
 	u64	      index, top_idx;
 	void	      *top, *entries;
 	u16	      y, x, width, height, rows, columns, horiz_scroll;
+	u8	      extra_title_lines;
 	int	      current_color;
 	void	      *priv;
 	const char    *title;
@@ -38,6 +39,7 @@ bool ui_browser__is_current_entry(struct ui_browser *browser, unsigned row);
 void ui_browser__refresh_dimensions(struct ui_browser *browser);
 void ui_browser__reset_index(struct ui_browser *browser);
 
+void ui_browser__gotorc_title(struct ui_browser *browser, int y, int x);
 void ui_browser__gotorc(struct ui_browser *browser, int y, int x);
 void ui_browser__write_nstring(struct ui_browser *browser, const char *msg,
 			       unsigned int width);
diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index c02fb437ac8e..12c099a87f8b 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -218,7 +218,7 @@ static unsigned int annotate_browser__refresh(struct ui_browser *browser)
 		annotate_browser__draw_current_jump(browser);
 
 	ui_browser__set_color(browser, HE_COLORSET_NORMAL);
-	__ui_browser__vline(browser, pcnt_width, 0, browser->height - 1);
+	__ui_browser__vline(browser, pcnt_width, 0, browser->rows - 1);
 	return ret;
 }
 
@@ -592,21 +592,40 @@ bool annotate_browser__continue_search_reverse(struct annotate_browser *browser,
 	return __annotate_browser__search_reverse(browser);
 }
 
+static int annotate_browser__show(struct ui_browser *browser, char *title, const char *help)
+{
+	struct map_symbol *ms = browser->priv;
+	struct symbol *sym = ms->sym;
+	char symbol_dso[SYM_TITLE_MAX_SIZE];
+
+	if (ui_browser__show(browser, title, help) < 0)
+		return -1;
+
+	sym_title(sym, ms->map, symbol_dso, sizeof(symbol_dso));
+
+	ui_browser__gotorc_title(browser, 0, 0);
+	ui_browser__set_color(browser, HE_COLORSET_ROOT);
+	ui_browser__write_nstring(browser, symbol_dso, browser->width + 1);
+	return 0;
+}
+
 static int annotate_browser__run(struct annotate_browser *browser,
 				 struct perf_evsel *evsel,
 				 struct hist_browser_timer *hbt)
 {
 	struct rb_node *nd = NULL;
+	struct hists *hists = evsel__hists(evsel);
 	struct map_symbol *ms = browser->b.priv;
 	struct symbol *sym = ms->sym;
 	struct annotation *notes = symbol__annotation(ms->sym);
 	const char *help = "Press 'h' for help on key bindings";
 	int delay_secs = hbt ? hbt->refresh : 0;
+	char title[256];
 	int key;
-	char title[SYM_TITLE_MAX_SIZE];
 
-	sym_title(sym, ms->map, title, sizeof(title));
-	if (ui_browser__show(&browser->b, title, help) < 0)
+	annotation__scnprintf_samples_period(notes, title, sizeof(title), evsel);
+
+	if (annotate_browser__show(&browser->b, title, help) < 0)
 		return -1;
 
 	annotate_browser__calc_percent(browser, evsel);
@@ -637,8 +656,11 @@ static int annotate_browser__run(struct annotate_browser *browser,
 			if (hbt)
 				hbt->timer(hbt->arg);
 
-			if (delay_secs != 0)
+			if (delay_secs != 0) {
 				symbol__annotate_decay_histogram(sym, evsel->idx);
+				hists__scnprintf_title(hists, title, sizeof(title));
+				annotate_browser__show(&browser->b, title, help);
+			}
 			continue;
 		case K_TAB:
 			if (nd != NULL) {
@@ -812,6 +834,7 @@ int symbol__tui_annotate(struct symbol *sym, struct map *map,
 			.seek	 = ui_browser__list_head_seek,
 			.write	 = annotate_browser__write,
 			.filter  = disasm_line__filter,
+			.extra_title_lines = 1, /* for hists__scnprintf_title() */
 			.priv	 = &ms,
 			.use_navkeypressed = true,
 		},
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 8b4e82548f8e..0eec06c105c6 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -32,8 +32,7 @@
 
 extern void hist_browser__init_hpp(void);
 
-static int perf_evsel_browser_title(struct hist_browser *browser,
-				    char *bf, size_t size);
+static int hists_browser__scnprintf_title(struct hist_browser *browser, char *bf, size_t size);
 static void hist_browser__update_nr_entries(struct hist_browser *hb);
 
 static struct rb_node *hists__filter_entries(struct rb_node *nd,
@@ -62,6 +61,15 @@ static int hist_browser__get_folding(struct hist_browser *browser)
 	return unfolded_rows;
 }
 
+static void hist_browser__set_title_space(struct hist_browser *hb)
+{
+	struct ui_browser *browser = &hb->b;
+	struct hists *hists = hb->hists;
+	struct perf_hpp_list *hpp_list = hists->hpp_list;
+
+	browser->extra_title_lines = hb->show_headers ? hpp_list->nr_header_lines : 0;
+}
+
 static u32 hist_browser__nr_entries(struct hist_browser *hb)
 {
 	u32 nr_entries;
@@ -82,10 +90,16 @@ static void hist_browser__update_rows(struct hist_browser *hb)
 	struct ui_browser *browser = &hb->b;
 	struct hists *hists = hb->hists;
 	struct perf_hpp_list *hpp_list = hists->hpp_list;
-	u16 header_offset, index_row;
+	u16 index_row;
 
-	header_offset = hb->show_headers ? hpp_list->nr_header_lines : 0;
-	browser->rows = browser->height - header_offset;
+	if (!hb->show_headers) {
+		browser->rows += browser->extra_title_lines;
+		browser->extra_title_lines = 0;
+		return;
+	}
+
+	browser->extra_title_lines = hpp_list->nr_header_lines;
+	browser->rows -= browser->extra_title_lines;
 	/*
 	 * Verify if we were at the last line and that line isn't
 	 * visibe because we now show the header line(s).
@@ -108,17 +122,6 @@ static void hist_browser__refresh_dimensions(struct ui_browser *browser)
  	 *	  changeset.
  	 */
 	ui_browser__refresh_dimensions(browser);
-	hist_browser__update_rows(hb);
-}
-
-static void hist_browser__gotorc(struct hist_browser *browser, int row, int column)
-{
-	struct hists *hists = browser->hists;
-	struct perf_hpp_list *hpp_list = hists->hpp_list;
-	u16 header_offset;
-
-	header_offset = browser->show_headers ? hpp_list->nr_header_lines : 0;
-	ui_browser__gotorc(&browser->b, row + header_offset, column);
 }
 
 static void hist_browser__reset(struct hist_browser *browser)
@@ -656,9 +659,10 @@ int hist_browser__run(struct hist_browser *browser, const char *help,
 			struct hist_entry *h = rb_entry(browser->b.top,
 							struct hist_entry, rb_node);
 			ui_helpline__pop();
-			ui_helpline__fpush("%d: nr_ent=(%d,%d), rows=%d, idx=%d, fve: idx=%d, row_off=%d, nrows=%d",
+			ui_helpline__fpush("%d: nr_ent=(%d,%d), etl: %d, rows=%d, idx=%d, fve: idx=%d, row_off=%d, nrows=%d",
 					   seq++, browser->b.nr_entries,
 					   browser->hists->nr_entries,
+					   browser->b.extra_title_lines,
 					   browser->b.rows,
 					   browser->b.index,
 					   browser->b.top_idx,
@@ -733,7 +737,7 @@ static void hist_browser__show_callchain_entry(struct hist_browser *browser,
 	}
 
 	ui_browser__set_color(&browser->b, color);
-	hist_browser__gotorc(browser, row, 0);
+	ui_browser__gotorc(&browser->b, row, 0);
 	ui_browser__write_nstring(&browser->b, " ", offset);
 	ui_browser__printf(&browser->b, "%c", folded_sign);
 	ui_browser__write_graph(&browser->b, show_annotated ? SLSMG_RARROW_CHAR : ' ');
@@ -1249,7 +1253,7 @@ static int hist_browser__show_entry(struct hist_browser *browser,
 		};
 		int column = 0;
 
-		hist_browser__gotorc(browser, row, 0);
+		ui_browser__gotorc(&browser->b, row, 0);
 
 		hists__for_each_format(browser->hists, fmt) {
 			char s[2048];
@@ -1358,7 +1362,7 @@ static int hist_browser__show_hierarchy_entry(struct hist_browser *browser,
 		goto show_callchain;
 	}
 
-	hist_browser__gotorc(browser, row, 0);
+	ui_browser__gotorc(&browser->b, row, 0);
 
 	if (current_entry && browser->b.navkeypressed)
 		ui_browser__set_color(&browser->b, HE_COLORSET_SELECTED);
@@ -1507,7 +1511,7 @@ static int hist_browser__show_no_entry(struct hist_browser *browser,
 		browser->selection = NULL;
 	}
 
-	hist_browser__gotorc(browser, row, 0);
+	ui_browser__gotorc(&browser->b, row, 0);
 
 	if (current_entry && browser->b.navkeypressed)
 		ui_browser__set_color(&browser->b, HE_COLORSET_SELECTED);
@@ -1713,7 +1717,7 @@ static void hists_browser__headers(struct hist_browser *browser)
 		hists_browser__scnprintf_headers(browser, headers,
 						 sizeof(headers), line);
 
-		ui_browser__gotorc(&browser->b, line, 0);
+		ui_browser__gotorc_title(&browser->b, line, 0);
 		ui_browser__set_color(&browser->b, HE_COLORSET_ROOT);
 		ui_browser__write_nstring(&browser->b, headers, browser->b.width + 1);
 	}
@@ -1740,17 +1744,11 @@ static void ui_browser__hists_init_top(struct ui_browser *browser)
 static unsigned int hist_browser__refresh(struct ui_browser *browser)
 {
 	unsigned row = 0;
-	u16 header_offset = 0;
 	struct rb_node *nd;
 	struct hist_browser *hb = container_of(browser, struct hist_browser, b);
-	struct hists *hists = hb->hists;
-
-	if (hb->show_headers) {
-		struct perf_hpp_list *hpp_list = hists->hpp_list;
 
+	if (hb->show_headers)
 		hist_browser__show_headers(hb);
-		header_offset = hpp_list->nr_header_lines;
-	}
 
 	ui_browser__hists_init_top(browser);
 	hb->he_selection = NULL;
@@ -1788,7 +1786,7 @@ static unsigned int hist_browser__refresh(struct ui_browser *browser)
 			break;
 	}
 
-	return row + header_offset;
+	return row;
 }
 
 static struct rb_node *hists__filter_entries(struct rb_node *nd,
@@ -2143,6 +2141,7 @@ void hist_browser__init(struct hist_browser *browser,
 	browser->b.seek			= ui_browser__hists_seek;
 	browser->b.use_navkeypressed	= true;
 	browser->show_headers		= symbol_conf.show_hist_headers;
+	hist_browser__set_title_space(browser);
 
 	if (symbol_conf.report_hierarchy) {
 		struct perf_hpp_list_node *fmt_node;
@@ -2183,7 +2182,7 @@ perf_evsel_browser__new(struct perf_evsel *evsel,
 	if (browser) {
 		browser->hbt   = hbt;
 		browser->env   = env;
-		browser->title = perf_evsel_browser_title;
+		browser->title = hists_browser__scnprintf_title;
 	}
 	return browser;
 }
@@ -2209,84 +2208,11 @@ static inline bool is_report_browser(void *timer)
 	return timer == NULL;
 }
 
-static int perf_evsel_browser_title(struct hist_browser *browser,
-				char *bf, size_t size)
+static int hists_browser__scnprintf_title(struct hist_browser *browser, char *bf, size_t size)
 {
 	struct hist_browser_timer *hbt = browser->hbt;
-	struct hists *hists = browser->hists;
-	char unit;
-	int printed;
-	const struct dso *dso = hists->dso_filter;
-	const struct thread *thread = hists->thread_filter;
-	int socket_id = hists->socket_filter;
-	unsigned long nr_samples = hists->stats.nr_events[PERF_RECORD_SAMPLE];
-	u64 nr_events = hists->stats.total_period;
-	struct perf_evsel *evsel = hists_to_evsel(hists);
-	const char *ev_name = perf_evsel__name(evsel);
-	char buf[512], sample_freq_str[64] = "";
-	size_t buflen = sizeof(buf);
-	char ref[30] = " show reference callgraph, ";
-	bool enable_ref = false;
+	int printed = __hists__scnprintf_title(browser->hists, bf, size, !is_report_browser(hbt));
 
-	if (symbol_conf.filter_relative) {
-		nr_samples = hists->stats.nr_non_filtered_samples;
-		nr_events = hists->stats.total_non_filtered_period;
-	}
-
-	if (perf_evsel__is_group_event(evsel)) {
-		struct perf_evsel *pos;
-
-		perf_evsel__group_desc(evsel, buf, buflen);
-		ev_name = buf;
-
-		for_each_group_member(pos, evsel) {
-			struct hists *pos_hists = evsel__hists(pos);
-
-			if (symbol_conf.filter_relative) {
-				nr_samples += pos_hists->stats.nr_non_filtered_samples;
-				nr_events += pos_hists->stats.total_non_filtered_period;
-			} else {
-				nr_samples += pos_hists->stats.nr_events[PERF_RECORD_SAMPLE];
-				nr_events += pos_hists->stats.total_period;
-			}
-		}
-	}
-
-	if (symbol_conf.show_ref_callgraph &&
-	    strstr(ev_name, "call-graph=no"))
-		enable_ref = true;
-
-	if (!is_report_browser(hbt))
-		scnprintf(sample_freq_str, sizeof(sample_freq_str), " %d Hz,", evsel->attr.sample_freq);
-
-	nr_samples = convert_unit(nr_samples, &unit);
-	printed = scnprintf(bf, size,
-			   "Samples: %lu%c of event%s '%s',%s%sEvent count (approx.): %" PRIu64,
-			   nr_samples, unit, evsel->nr_members > 1 ? "s" : "",
-			   ev_name, sample_freq_str, enable_ref ? ref : " ", nr_events);
-
-
-	if (hists->uid_filter_str)
-		printed += snprintf(bf + printed, size - printed,
-				    ", UID: %s", hists->uid_filter_str);
-	if (thread) {
-		if (hists__has(hists, thread)) {
-			printed += scnprintf(bf + printed, size - printed,
-				    ", Thread: %s(%d)",
-				     (thread->comm_set ? thread__comm_str(thread) : ""),
-				    thread->tid);
-		} else {
-			printed += scnprintf(bf + printed, size - printed,
-				    ", Thread: %s",
-				     (thread->comm_set ? thread__comm_str(thread) : ""));
-		}
-	}
-	if (dso)
-		printed += scnprintf(bf + printed, size - printed,
-				    ", DSO: %s", dso->short_name);
-	if (socket_id > -1)
-		printed += scnprintf(bf + printed, size - printed,
-				    ", Processor Socket: %d", socket_id);
 	if (!is_report_browser(hbt)) {
 		struct perf_top *top = hbt->arg;
 
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 3a428d7c59b9..fbad8dfbb186 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -17,6 +17,7 @@
 #include "config.h"
 #include "cache.h"
 #include "symbol.h"
+#include "units.h"
 #include "debug.h"
 #include "annotate.h"
 #include "evsel.h"
@@ -2324,7 +2325,7 @@ int symbol__tty_annotate2(struct symbol *sym, struct map *map,
 	struct dso *dso = map->dso;
 	struct rb_root source_line = RB_ROOT;
 	struct annotation_options opts = annotation__default_options;
-	const char *ev_name = perf_evsel__name(evsel);
+	struct annotation *notes = symbol__annotation(sym);
 	char buf[1024];
 
 	if (symbol__annotate2(sym, map, evsel, &opts, NULL) < 0)
@@ -2336,12 +2337,8 @@ int symbol__tty_annotate2(struct symbol *sym, struct map *map,
 		print_summary(&source_line, dso->long_name);
 	}
 
-	if (perf_evsel__is_group_event(evsel)) {
-		perf_evsel__group_desc(evsel, buf, sizeof(buf));
-		ev_name = buf;
-	}
-
-	fprintf(stdout, "%s() %s\nEvent: %s\n\n", sym->name, dso->long_name, ev_name);
+	annotation__scnprintf_samples_period(notes, buf, sizeof(buf), evsel);
+	fprintf(stdout, "%s\n%s() %s\n", buf, sym->name, dso->long_name);
 	symbol__annotate_fprintf2(sym, stdout);
 
 	annotated_source__purge(symbol__annotation(sym)->src);
@@ -2597,6 +2594,46 @@ int symbol__annotate2(struct symbol *sym, struct map *map, struct perf_evsel *ev
 	return -1;
 }
 
+int __annotation__scnprintf_samples_period(struct annotation *notes,
+					   char *bf, size_t size,
+					   struct perf_evsel *evsel,
+					   bool show_freq)
+{
+	const char *ev_name = perf_evsel__name(evsel);
+	char buf[1024], ref[30] = " show reference callgraph, ";
+	char sample_freq_str[64] = "";
+	unsigned long nr_samples = 0;
+	int nr_members = 1;
+	bool enable_ref = false;
+	u64 nr_events = 0;
+	char unit;
+	int i;
+
+	if (perf_evsel__is_group_event(evsel)) {
+		perf_evsel__group_desc(evsel, buf, sizeof(buf));
+		ev_name = buf;
+                nr_members = evsel->nr_members;
+	}
+
+	for (i = 0; i < nr_members; i++) {
+		struct sym_hist *ah = annotation__histogram(notes, evsel->idx + i);
+
+		nr_samples += ah->nr_samples;
+		nr_events  += ah->period;
+	}
+
+	if (symbol_conf.show_ref_callgraph && strstr(ev_name, "call-graph=no"))
+		enable_ref = true;
+
+	if (show_freq)
+		scnprintf(sample_freq_str, sizeof(sample_freq_str), " %d Hz,", evsel->attr.sample_freq);
+
+	nr_samples = convert_unit(nr_samples, &unit);
+	return scnprintf(bf, size, "Samples: %lu%c of event%s '%s',%s%sEvent count (approx.): %" PRIu64,
+			 nr_samples, unit, evsel->nr_members > 1 ? "s" : "",
+			 ev_name, sample_freq_str, enable_ref ? ref : " ", nr_events);
+}
+
 #define ANNOTATION__CFG(n) \
 	{ .name = #n, .value = &annotation__default_options.n, }
 
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index ff7e3df31efa..db8d09bea07e 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -151,6 +151,18 @@ double annotation_line__max_percent(struct annotation_line *al, struct annotatio
 void annotation_line__write(struct annotation_line *al, struct annotation *notes,
 			    struct annotation_write_ops *ops);
 
+int __annotation__scnprintf_samples_period(struct annotation *notes,
+					   char *bf, size_t size,
+					   struct perf_evsel *evsel,
+					   bool show_freq);
+
+static inline int annotation__scnprintf_samples_period(struct annotation *notes,
+						       char *bf, size_t size,
+						       struct perf_evsel *evsel)
+{
+	return __annotation__scnprintf_samples_period(notes, bf, size, evsel, true);
+}
+
 int disasm_line__scnprintf(struct disasm_line *dl, char *bf, size_t size, bool raw);
 size_t disasm__fprintf(struct list_head *head, FILE *fp);
 void symbol__calc_percent(struct symbol *sym, struct perf_evsel *evsel);
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index fb357a00dd86..857de69a5361 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -302,13 +302,27 @@ static int auxtrace_queues__split_buffer(struct auxtrace_queues *queues,
 	return 0;
 }
 
+static bool filter_cpu(struct perf_session *session, int cpu)
+{
+	unsigned long *cpu_bitmap = session->itrace_synth_opts->cpu_bitmap;
+
+	return cpu_bitmap && cpu != -1 && !test_bit(cpu, cpu_bitmap);
+}
+
 static int auxtrace_queues__add_buffer(struct auxtrace_queues *queues,
 				       struct perf_session *session,
 				       unsigned int idx,
 				       struct auxtrace_buffer *buffer,
 				       struct auxtrace_buffer **buffer_ptr)
 {
-	int err;
+	int err = -ENOMEM;
+
+	if (filter_cpu(session, buffer->cpu))
+		return 0;
+
+	buffer = memdup(buffer, sizeof(*buffer));
+	if (!buffer)
+		return -ENOMEM;
 
 	if (session->one_mmap) {
 		buffer->data = buffer->data_offset - session->one_mmap_offset +
@@ -316,31 +330,28 @@ static int auxtrace_queues__add_buffer(struct auxtrace_queues *queues,
 	} else if (perf_data__is_pipe(session->data)) {
 		buffer->data = auxtrace_copy_data(buffer->size, session);
 		if (!buffer->data)
-			return -ENOMEM;
+			goto out_free;
 		buffer->data_needs_freeing = true;
 	} else if (BITS_PER_LONG == 32 &&
 		   buffer->size > BUFFER_LIMIT_FOR_32_BIT) {
 		err = auxtrace_queues__split_buffer(queues, idx, buffer);
 		if (err)
-			return err;
+			goto out_free;
 	}
 
 	err = auxtrace_queues__queue_buffer(queues, idx, buffer);
 	if (err)
-		return err;
+		goto out_free;
 
 	/* FIXME: Doesn't work for split buffer */
 	if (buffer_ptr)
 		*buffer_ptr = buffer;
 
 	return 0;
-}
 
-static bool filter_cpu(struct perf_session *session, int cpu)
-{
-	unsigned long *cpu_bitmap = session->itrace_synth_opts->cpu_bitmap;
-
-	return cpu_bitmap && cpu != -1 && !test_bit(cpu, cpu_bitmap);
+out_free:
+	auxtrace_buffer__free(buffer);
+	return err;
 }
 
 int auxtrace_queues__add_event(struct auxtrace_queues *queues,
@@ -348,36 +359,19 @@ int auxtrace_queues__add_event(struct auxtrace_queues *queues,
 			       union perf_event *event, off_t data_offset,
 			       struct auxtrace_buffer **buffer_ptr)
 {
-	struct auxtrace_buffer *buffer;
-	unsigned int idx;
-	int err;
-
-	if (filter_cpu(session, event->auxtrace.cpu))
-		return 0;
-
-	buffer = zalloc(sizeof(struct auxtrace_buffer));
-	if (!buffer)
-		return -ENOMEM;
-
-	buffer->pid = -1;
-	buffer->tid = event->auxtrace.tid;
-	buffer->cpu = event->auxtrace.cpu;
-	buffer->data_offset = data_offset;
-	buffer->offset = event->auxtrace.offset;
-	buffer->reference = event->auxtrace.reference;
-	buffer->size = event->auxtrace.size;
-	idx = event->auxtrace.idx;
-
-	err = auxtrace_queues__add_buffer(queues, session, idx, buffer,
-					  buffer_ptr);
-	if (err)
-		goto out_err;
-
-	return 0;
+	struct auxtrace_buffer buffer = {
+		.pid = -1,
+		.tid = event->auxtrace.tid,
+		.cpu = event->auxtrace.cpu,
+		.data_offset = data_offset,
+		.offset = event->auxtrace.offset,
+		.reference = event->auxtrace.reference,
+		.size = event->auxtrace.size,
+	};
+	unsigned int idx = event->auxtrace.idx;
 
-out_err:
-	auxtrace_buffer__free(buffer);
-	return err;
+	return auxtrace_queues__add_buffer(queues, session, idx, &buffer,
+					   buffer_ptr);
 }
 
 static int auxtrace_queues__add_indexed_event(struct auxtrace_queues *queues,
diff --git a/tools/perf/util/c++/clang-test.cpp b/tools/perf/util/c++/clang-test.cpp
index a4014d786676..7b042a5ebc68 100644
--- a/tools/perf/util/c++/clang-test.cpp
+++ b/tools/perf/util/c++/clang-test.cpp
@@ -41,7 +41,7 @@ int test__clang_to_IR(void)
 	if (!M)
 		return -1;
 	for (llvm::Function& F : *M)
-		if (F.getName() == "bpf_func__SyS_epoll_wait")
+		if (F.getName() == "bpf_func__SyS_epoll_pwait")
 			return 0;
 	return -1;
 }
diff --git a/tools/perf/util/c++/clang.cpp b/tools/perf/util/c++/clang.cpp
index 1bfc946e37dc..bf31ceab33bd 100644
--- a/tools/perf/util/c++/clang.cpp
+++ b/tools/perf/util/c++/clang.cpp
@@ -9,6 +9,7 @@
  * Copyright (C) 2016 Huawei Inc.
  */
 
+#include "clang/Basic/Version.h"
 #include "clang/CodeGen/CodeGenAction.h"
 #include "clang/Frontend/CompilerInvocation.h"
 #include "clang/Frontend/CompilerInstance.h"
@@ -58,7 +59,8 @@ createCompilerInvocation(llvm::opt::ArgStringList CFlags, StringRef& Path,
 
 	FrontendOptions& Opts = CI->getFrontendOpts();
 	Opts.Inputs.clear();
-	Opts.Inputs.emplace_back(Path, IK_C);
+	Opts.Inputs.emplace_back(Path,
+			FrontendOptions::getInputKindForExtension("c"));
 	return CI;
 }
 
@@ -71,10 +73,17 @@ getModuleFromSource(llvm::opt::ArgStringList CFlags,
 
 	Clang.setVirtualFileSystem(&*VFS);
 
+#if CLANG_VERSION_MAJOR < 4
 	IntrusiveRefCntPtr<CompilerInvocation> CI =
 		createCompilerInvocation(std::move(CFlags), Path,
 					 Clang.getDiagnostics());
 	Clang.setInvocation(&*CI);
+#else
+	std::shared_ptr<CompilerInvocation> CI(
+		createCompilerInvocation(std::move(CFlags), Path,
+					 Clang.getDiagnostics()));
+	Clang.setInvocation(CI);
+#endif
 
 	std::unique_ptr<CodeGenAction> Act(new EmitLLVMOnlyAction(&*LLVMCtx));
 	if (!Clang.ExecuteAction(*Act))
diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index f5acda13dcfa..7eb7de5aee44 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -979,7 +979,7 @@ int die_get_varname(Dwarf_Die *vr_die, struct strbuf *buf)
 	return ret < 0 ? ret : strbuf_addf(buf, "\t%s", dwarf_diename(vr_die));
 }
 
-#ifdef HAVE_DWARF_GETLOCATIONS
+#ifdef HAVE_DWARF_GETLOCATIONS_SUPPORT
 /**
  * die_get_var_innermost_scope - Get innermost scope range of given variable DIE
  * @sp_die: a subprogram DIE
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 7d968892ee39..4d602fba40b2 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -6,6 +6,7 @@
 #include "session.h"
 #include "namespaces.h"
 #include "sort.h"
+#include "units.h"
 #include "evlist.h"
 #include "evsel.h"
 #include "annotate.h"
@@ -14,6 +15,7 @@
 #include "ui/progress.h"
 #include <errno.h>
 #include <math.h>
+#include <inttypes.h>
 #include <sys/param.h>
 
 static bool hists__filter_entry_by_dso(struct hists *hists,
@@ -2454,6 +2456,85 @@ u64 hists__total_period(struct hists *hists)
 		hists->stats.total_period;
 }
 
+int __hists__scnprintf_title(struct hists *hists, char *bf, size_t size, bool show_freq)
+{
+	char unit;
+	int printed;
+	const struct dso *dso = hists->dso_filter;
+	const struct thread *thread = hists->thread_filter;
+	int socket_id = hists->socket_filter;
+	unsigned long nr_samples = hists->stats.nr_events[PERF_RECORD_SAMPLE];
+	u64 nr_events = hists->stats.total_period;
+	struct perf_evsel *evsel = hists_to_evsel(hists);
+	const char *ev_name = perf_evsel__name(evsel);
+	char buf[512], sample_freq_str[64] = "";
+	size_t buflen = sizeof(buf);
+	char ref[30] = " show reference callgraph, ";
+	bool enable_ref = false;
+
+	if (symbol_conf.filter_relative) {
+		nr_samples = hists->stats.nr_non_filtered_samples;
+		nr_events = hists->stats.total_non_filtered_period;
+	}
+
+	if (perf_evsel__is_group_event(evsel)) {
+		struct perf_evsel *pos;
+
+		perf_evsel__group_desc(evsel, buf, buflen);
+		ev_name = buf;
+
+		for_each_group_member(pos, evsel) {
+			struct hists *pos_hists = evsel__hists(pos);
+
+			if (symbol_conf.filter_relative) {
+				nr_samples += pos_hists->stats.nr_non_filtered_samples;
+				nr_events += pos_hists->stats.total_non_filtered_period;
+			} else {
+				nr_samples += pos_hists->stats.nr_events[PERF_RECORD_SAMPLE];
+				nr_events += pos_hists->stats.total_period;
+			}
+		}
+	}
+
+	if (symbol_conf.show_ref_callgraph &&
+	    strstr(ev_name, "call-graph=no"))
+		enable_ref = true;
+
+	if (show_freq)
+		scnprintf(sample_freq_str, sizeof(sample_freq_str), " %d Hz,", evsel->attr.sample_freq);
+
+	nr_samples = convert_unit(nr_samples, &unit);
+	printed = scnprintf(bf, size,
+			   "Samples: %lu%c of event%s '%s',%s%sEvent count (approx.): %" PRIu64,
+			   nr_samples, unit, evsel->nr_members > 1 ? "s" : "",
+			   ev_name, sample_freq_str, enable_ref ? ref : " ", nr_events);
+
+
+	if (hists->uid_filter_str)
+		printed += snprintf(bf + printed, size - printed,
+				    ", UID: %s", hists->uid_filter_str);
+	if (thread) {
+		if (hists__has(hists, thread)) {
+			printed += scnprintf(bf + printed, size - printed,
+				    ", Thread: %s(%d)",
+				     (thread->comm_set ? thread__comm_str(thread) : ""),
+				    thread->tid);
+		} else {
+			printed += scnprintf(bf + printed, size - printed,
+				    ", Thread: %s",
+				     (thread->comm_set ? thread__comm_str(thread) : ""));
+		}
+	}
+	if (dso)
+		printed += scnprintf(bf + printed, size - printed,
+				    ", DSO: %s", dso->short_name);
+	if (socket_id > -1)
+		printed += scnprintf(bf + printed, size - printed,
+				    ", Processor Socket: %d", socket_id);
+
+	return printed;
+}
+
 int parse_filter_percentage(const struct option *opt __maybe_unused,
 			    const char *arg, int unset __maybe_unused)
 {
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index e869cad4d89f..fbabfd8a215d 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -61,6 +61,7 @@ enum hist_column {
 	HISTC_SRCLINE_TO,
 	HISTC_TRACE,
 	HISTC_SYM_SIZE,
+	HISTC_DSO_SIZE,
 	HISTC_NR_COLS, /* Last entry */
 };
 
@@ -503,5 +504,11 @@ int __hpp__slsmg_color_printf(struct perf_hpp *hpp, const char *fmt, ...);
 int __hist_entry__snprintf(struct hist_entry *he, struct perf_hpp *hpp,
 			   struct perf_hpp_list *hpp_list);
 int hists__fprintf_headers(struct hists *hists, FILE *fp);
+int __hists__scnprintf_title(struct hists *hists, char *bf, size_t size, bool show_freq);
+
+static inline int hists__scnprintf_title(struct hists *hists, char *bf, size_t size)
+{
+	return __hists__scnprintf_title(hists, bf, size, true);
+}
 
 #endif	/* __PERF_HIST_H */
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index edeb7291c8e1..0e9bbe01b0ab 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -103,6 +103,10 @@ static inline u64 identity__map_ip(struct map *map __maybe_unused, u64 ip)
 	return ip;
 }
 
+static inline size_t map__size(const struct map *map)
+{
+	return map->end - map->start;
+}
 
 /* rip/ip <-> addr suitable for passing to `objdump --start-address=` */
 u64 map__rip_2objdump(struct map *map, u64 rip);
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index c71ced7db152..f4a7a437ee87 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1591,7 +1591,7 @@ static void perf_session__warn_about_errors(const struct perf_session *session)
 		drop_rate = (double)stats->total_lost_samples /
 			    (double) (stats->nr_events[PERF_RECORD_SAMPLE] + stats->total_lost_samples);
 		if (drop_rate > 0.05) {
-			ui__warning("Processed %" PRIu64 " samples and lost %3.2f%% samples!\n\n",
+			ui__warning("Processed %" PRIu64 " samples and lost %3.2f%%!\n\n",
 				    stats->nr_events[PERF_RECORD_SAMPLE] + stats->total_lost_samples,
 				    drop_rate * 100.0);
 		}
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index e8514f651865..26a68dfd8a4f 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -1545,6 +1545,46 @@ struct sort_entry sort_sym_size = {
 	.se_width_idx	= HISTC_SYM_SIZE,
 };
 
+/* --sort dso_size */
+
+static int64_t _sort__dso_size_cmp(struct map *map_l, struct map *map_r)
+{
+	int64_t size_l = map_l != NULL ? map__size(map_l) : 0;
+	int64_t size_r = map_r != NULL ? map__size(map_r) : 0;
+
+	return size_l < size_r ? -1 :
+		size_l == size_r ? 0 : 1;
+}
+
+static int64_t
+sort__dso_size_cmp(struct hist_entry *left, struct hist_entry *right)
+{
+	return _sort__dso_size_cmp(right->ms.map, left->ms.map);
+}
+
+static int _hist_entry__dso_size_snprintf(struct map *map, char *bf,
+					  size_t bf_size, unsigned int width)
+{
+	if (map && map->dso)
+		return repsep_snprintf(bf, bf_size, "%*d", width,
+				       map__size(map));
+
+	return repsep_snprintf(bf, bf_size, "%*s", width, "unknown");
+}
+
+static int hist_entry__dso_size_snprintf(struct hist_entry *he, char *bf,
+					 size_t size, unsigned int width)
+{
+	return _hist_entry__dso_size_snprintf(he->ms.map, bf, size, width);
+}
+
+struct sort_entry sort_dso_size = {
+	.se_header	= "DSO size",
+	.se_cmp		= sort__dso_size_cmp,
+	.se_snprintf	= hist_entry__dso_size_snprintf,
+	.se_width_idx	= HISTC_DSO_SIZE,
+};
+
 
 struct sort_dimension {
 	const char		*name;
@@ -1569,6 +1609,7 @@ static struct sort_dimension common_sort_dimensions[] = {
 	DIM(SORT_TRANSACTION, "transaction", sort_transaction),
 	DIM(SORT_TRACE, "trace", sort_trace),
 	DIM(SORT_SYM_SIZE, "symbol_size", sort_sym_size),
+	DIM(SORT_DSO_SIZE, "dso_size", sort_dso_size),
 	DIM(SORT_CGROUP_ID, "cgroup_id", sort_cgroup_id),
 };
 
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index f5901c10a563..035b62e2c60b 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -220,6 +220,7 @@ enum sort_type {
 	SORT_TRANSACTION,
 	SORT_TRACE,
 	SORT_SYM_SIZE,
+	SORT_DSO_SIZE,
 	SORT_CGROUP_ID,
 
 	/* branch stack specific sort keys */
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index 9496365da3d7..c9626c206208 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -11,8 +11,7 @@
 #include <stdlib.h>
 #include <stdarg.h>
 #include <linux/compiler.h>
-#include <linux/types.h>
-#include "namespaces.h"
+#include <sys/types.h>
 
 /* General helper functions */
 void usage(const char *err) __noreturn;
@@ -26,6 +25,7 @@ static inline void *zalloc(size_t size)
 #define zfree(ptr) ({ free(*ptr); *ptr = NULL; })
 
 struct dirent;
+struct nsinfo;
 struct strlist;
 
 int mkdir_p(char *path, mode_t mode);
