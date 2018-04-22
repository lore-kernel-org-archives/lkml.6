Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752071AbeDVKsg (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 06:48:36 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:51398 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751683AbeDVKsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 06:48:30 -0400
Date: Sun, 22 Apr 2018 12:48:22 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] perf fixes for 4.17
Message-ID: <alpine.DEB.2.21.1804221226290.6136@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-825384187-1524394107=:6136"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-825384187-1524394107=:6136
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 8BIT

Linus,

please pull the latest perf-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

A larger set of updates for perf:

  - Kernel:
  
    - Handle the SBOX uncore monitoring correctly on Broadwell CPUs which
      do not have SBOX.

    - Store context switch out type in PERF_RECORD_SWITCH[_CPU_WIDE].
      The percentage of preempting and non-preempting context switches help
      understanding the nature of workloads (CPU or IO bound) that are running
      on a machine. This adds the kernel facility and userspace changes needed
      to show this information in 'perf script' and 'perf report -D' (Alexey Budankov)

    - Remove a WARN_ON() in the trace/kprobes code which is pointless
      because the return error code is already telling the caller what's
      wrong.

    - Revert a fugly workaround for clang BPF targets.

    - Fix sample_max_stack maximum check and do not proceed when an error
      has been detect, return them to avoid misidentifying errors (Jiri Olsa)
    
    - Add SPDX idenitifiers and get rid of GPL boilderplate.

  - Tools:

    - Synchronize kernel ABI headers, v4.17-rc1 (Ingo Molnar)
    
    - Support MAP_FIXED_NOREPLACE, noticed when updating the tools/include/
      copies (Arnaldo Carvalho de Melo)
    
    - Add '\n' at the end of parse-options error messages (Ravi Bangoria)
    
    - Add s390 support for detailed/verbose PMU event description (Thomas Richter)

  - perf annotate fixes and improvements:
    
    - Allow showing offsets in more than just jump targets, use the new
      'O' hotkey in the TUI, config ~/.perfconfig annotate.offset_level
      for it and for --stdio2 (Arnaldo Carvalho de Melo)
    
    - Use the resolved variable names from objdump disassembled lines to
      make them more compact, just like was already done for some instructions,
      like "mov", this eventually will be done more generally, but lets now add
      some more to the existing mechanism (Arnaldo Carvalho de Melo)
    
  - perf record fixes:
    
    - Change warning for missing topology sysfs entry to debug, as not all
      architectures have those files, s390 being one of those (Thomas Richter)

    - Remove old error messages about things that unlikely to be the root cause
      in modern systems (Andi Kleen)
    
  - perf sched fixes:
    
    - Fix -g/--call-graph documentation (Takuya Yamamoto)
    
  - perf stat:
    
    - Enable 1ms interval for printing event counters values in (Alexey Budankov)
    
  - perf test fixes:
    
    - Run dwarf unwind  on arm32 (Kim Phillips)
    
    - Remove unused ptrace.h include from LLVM test, sidesteping older
      clang's lack of support for some asm constructs (Arnaldo Carvalho de Melo)
    
    - Fixup BPF test using epoll_pwait syscall function probe, to cope with
      the syscall routines renames performed in this development cycle
      (Arnaldo Carvalho de Melo)

  - perf version fixes:
    
    - Do not print info about HAVE_LIBAUDIT_SUPPORT in 'perf version --build-options'
      when HAVE_SYSCALL_TABLE_SUPPORT is true, as libaudit won't be used in that
      case, print info about syscall_table support instead (Jin Yao)
    
  - Build system fixes:
    
    - Use HAVE_..._SUPPORT used consistently (Jin Yao)
    
    - Restore READ_ONCE() C++ compatibility in tools/include (Mark Rutland)
    
    - Give hints about package names needed to build jvmti (Arnaldo Carvalho de Melo)


Thanks,

	tglx

------------------>
Alexey Budankov (4):
      perf stat: Enable 1ms interval for printing event counters values
      perf/core: Store context switch out type in PERF_RECORD_SWITCH[_CPU_WIDE]
      perf report: Extend raw dump (-D) out with switch out event type
      perf script: Extend misc field decoding with switch out event type

Andi Kleen (4):
      perf mem: Allow all record/report options
      perf hists browser: Clarify top/report browser help
      perf record: Remove misleading error suggestion
      perf record: Remove suggestion to enable APIC

Arnaldo Carvalho de Melo (11):
      perf annotate: Allow showing offsets in more than just jump targets
      perf annotate browser: Allow showing offsets in more than just jump targets
      perf jvmti: Give hints about package names needed to build
      perf tests bpf: Remove unused ptrace.h include from LLVM test
      Revert "x86/asm: Allow again using asm.h when building for the 'bpf' clang target"
      perf report: Fix switching to another perf.data file
      perf annotate: Allow setting the offset level in .perfconfig
      perf annotate: Handle variables in 'sub', 'or' and many other instructions
      perf trace: Support MAP_FIXED_NOREPLACE
      perf tests mmap: Show which tracepoint is failing
      perf test BPF: Fixup BPF test using epoll_pwait syscall function probe

Ingo Molnar (1):
      tools/headers: Synchronize kernel ABI headers, v4.17-rc1

Jin Yao (3):
      perf script: Use HAVE_LIBXXX_SUPPORT to replace NO_LIBXXX
      perf tools: Rename HAVE_SYSCALL_TABLE to HAVE_SYSCALL_TABLE_SUPPORT
      perf version: Print status for syscall_table

Jiri Olsa (3):
      perf: Return proper values for user stack errors
      perf: Fix sample_max_stack maximum check
      perf: Remove superfluous allocation error check

Kim Phillips (1):
      perf tests: Run dwarf unwind test on arm32

Mark Rutland (1):
      tools headers: Restore READ_ONCE() C++ compatibility

Mathieu Poirier (1):
      coresight: Move to SPDX identifier

Oskar Senft (1):
      perf/x86/intel/uncore: Fix SBOX support for Broadwell CPUs

Ravi Bangoria (1):
      perf tools: Add '\n' at the end of parse-options error messages

Sandipan Das (1):
      perf tests: Disable breakpoint accounting test for powerpc

Song Liu (1):
      trace_kprobe: Remove warning message "Could not insert probe at..."

Stephane Eranian (1):
      perf/x86/intel/uncore: Revert "Remove SBOX support for Broadwell server"

Takuya Yamamoto (1):
      perf sched: Fix documentation for timehist

Thomas Richter (2):
      perf record: Change warning for missing sysfs entry to debug
      perf list: Add s390 support for detailed/verbose PMU event description


 arch/x86/events/intel/uncore_snbep.c              |  37 ++
 arch/x86/include/asm/asm.h                        |   2 -
 include/linux/coresight-pmu.h                     |  13 +-
 include/uapi/linux/perf_event.h                   |  18 +-
 kernel/events/callchain.c                         |  25 +-
 kernel/events/core.c                              |   8 +-
 kernel/trace/trace_kprobe.c                       |   2 -
 tools/arch/arm/include/uapi/asm/kvm.h             |   9 +
 tools/arch/x86/include/asm/required-features.h    |   8 +-
 tools/arch/x86/include/uapi/asm/kvm.h             |  19 +-
 tools/include/linux/compiler.h                    |  20 +-
 tools/include/linux/coresight-pmu.h               |  13 +-
 tools/include/uapi/asm-generic/mman-common.h      |   3 +
 tools/include/uapi/linux/bpf.h                    |   1 +
 tools/include/uapi/linux/if_link.h                |  39 ++
 tools/include/uapi/linux/kvm.h                    |  21 +-
 tools/include/uapi/linux/perf_event.h             |  18 +-
 tools/include/uapi/sound/asound.h                 |   1 +
 tools/lib/subcmd/parse-options.c                  |   6 +-
 tools/perf/Documentation/perf-config.txt          |   5 +
 tools/perf/Documentation/perf-mem.txt             |   3 +
 tools/perf/Documentation/perf-sched.txt           |   4 +-
 tools/perf/Documentation/perf-script.txt          |  17 +-
 tools/perf/Documentation/perf-stat.txt            |   2 +-
 tools/perf/Makefile.config                        |   4 +-
 tools/perf/arch/arm/include/arch-tests.h          |  12 +
 tools/perf/arch/arm/tests/Build                   |   2 +
 tools/perf/arch/arm/tests/arch-tests.c            |  16 +
 tools/perf/arch/arm/util/auxtrace.c               |  13 +-
 tools/perf/arch/arm/util/cs-etm.c                 |  13 +-
 tools/perf/arch/arm/util/cs-etm.h                 |  13 +-
 tools/perf/arch/arm/util/pmu.c                    |  13 +-
 tools/perf/arch/x86/Makefile                      |   2 +-
 tools/perf/arch/x86/annotate/instructions.c       |  67 +-
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl | 712 +++++++++++-----------
 tools/perf/builtin-help.c                         |   2 +-
 tools/perf/builtin-mem.c                          |   4 +-
 tools/perf/builtin-script.c                       |   9 +-
 tools/perf/builtin-stat.c                         |  14 +-
 tools/perf/builtin-version.c                      |   3 +
 tools/perf/perf.c                                 |   4 +-
 tools/perf/tests/bpf-script-example.c             |   2 +-
 tools/perf/tests/bpf-script-test-kbuild.c         |   1 -
 tools/perf/tests/builtin-test.c                   |   1 +
 tools/perf/tests/mmap-basic.c                     |   2 +-
 tools/perf/trace/beauty/mmap.c                    |   3 +
 tools/perf/ui/browsers/annotate.c                 |   5 +
 tools/perf/ui/browsers/hists.c                    |   2 +-
 tools/perf/util/annotate.c                        |  26 +-
 tools/perf/util/annotate.h                        |   9 +
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c   |   3 +-
 tools/perf/util/cs-etm.c                          |   3 +-
 tools/perf/util/cs-etm.h                          |  13 +-
 tools/perf/util/event.c                           |   4 +-
 tools/perf/util/evsel.c                           |   6 +-
 tools/perf/util/generate-cmdlist.sh               |   2 +-
 tools/perf/util/header.c                          |   3 +-
 tools/perf/util/pmu.c                             |   6 +
 tools/perf/util/symbol.c                          |   8 +-
 tools/perf/util/syscalltbl.c                      |   6 +-
 tools/perf/util/trace-event-scripting.c           |   4 +-
 61 files changed, 760 insertions(+), 546 deletions(-)
 create mode 100644 tools/perf/arch/arm/include/arch-tests.h
 create mode 100644 tools/perf/arch/arm/tests/arch-tests.c

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index c98b943e58b4..77076a102e34 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -3028,10 +3028,27 @@ static struct intel_uncore_type bdx_uncore_cbox = {
 	.format_group		= &hswep_uncore_cbox_format_group,
 };
 
+static struct intel_uncore_type bdx_uncore_sbox = {
+	.name			= "sbox",
+	.num_counters		= 4,
+	.num_boxes		= 4,
+	.perf_ctr_bits		= 48,
+	.event_ctl		= HSWEP_S0_MSR_PMON_CTL0,
+	.perf_ctr		= HSWEP_S0_MSR_PMON_CTR0,
+	.event_mask		= HSWEP_S_MSR_PMON_RAW_EVENT_MASK,
+	.box_ctl		= HSWEP_S0_MSR_PMON_BOX_CTL,
+	.msr_offset		= HSWEP_SBOX_MSR_OFFSET,
+	.ops			= &hswep_uncore_sbox_msr_ops,
+	.format_group		= &hswep_uncore_sbox_format_group,
+};
+
+#define BDX_MSR_UNCORE_SBOX	3
+
 static struct intel_uncore_type *bdx_msr_uncores[] = {
 	&bdx_uncore_ubox,
 	&bdx_uncore_cbox,
 	&hswep_uncore_pcu,
+	&bdx_uncore_sbox,
 	NULL,
 };
 
@@ -3043,10 +3060,25 @@ static struct event_constraint bdx_uncore_pcu_constraints[] = {
 
 void bdx_uncore_cpu_init(void)
 {
+	int pkg = topology_phys_to_logical_pkg(0);
+
 	if (bdx_uncore_cbox.num_boxes > boot_cpu_data.x86_max_cores)
 		bdx_uncore_cbox.num_boxes = boot_cpu_data.x86_max_cores;
 	uncore_msr_uncores = bdx_msr_uncores;
 
+	/* BDX-DE doesn't have SBOX */
+	if (boot_cpu_data.x86_model == 86) {
+		uncore_msr_uncores[BDX_MSR_UNCORE_SBOX] = NULL;
+	/* Detect systems with no SBOXes */
+	} else if (uncore_extra_pci_dev[pkg].dev[HSWEP_PCI_PCU_3]) {
+		struct pci_dev *pdev;
+		u32 capid4;
+
+		pdev = uncore_extra_pci_dev[pkg].dev[HSWEP_PCI_PCU_3];
+		pci_read_config_dword(pdev, 0x94, &capid4);
+		if (((capid4 >> 6) & 0x3) == 0)
+			bdx_msr_uncores[BDX_MSR_UNCORE_SBOX] = NULL;
+	}
 	hswep_uncore_pcu.constraints = bdx_uncore_pcu_constraints;
 }
 
@@ -3264,6 +3296,11 @@ static const struct pci_device_id bdx_uncore_pci_ids[] = {
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x6f46),
 		.driver_data = UNCORE_PCI_DEV_DATA(UNCORE_EXTRA_PCI_DEV, 2),
 	},
+	{ /* PCU.3 (for Capability registers) */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x6fc0),
+		.driver_data = UNCORE_PCI_DEV_DATA(UNCORE_EXTRA_PCI_DEV,
+						   HSWEP_PCI_PCU_3),
+	},
 	{ /* end: all zeroes */ }
 };
 
diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index 386a6900e206..219faaec51df 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -136,7 +136,6 @@
 #endif
 
 #ifndef __ASSEMBLY__
-#ifndef __BPF__
 /*
  * This output constraint should be used for any inline asm which has a "call"
  * instruction.  Otherwise the asm may be inserted before the frame pointer
@@ -146,6 +145,5 @@
 register unsigned long current_stack_pointer asm(_ASM_SP);
 #define ASM_CALL_CONSTRAINT "+r" (current_stack_pointer)
 #endif
-#endif
 
 #endif /* _ASM_X86_ASM_H */
diff --git a/include/linux/coresight-pmu.h b/include/linux/coresight-pmu.h
index edfeaba95429..a1a959ba24ff 100644
--- a/include/linux/coresight-pmu.h
+++ b/include/linux/coresight-pmu.h
@@ -1,18 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright(C) 2015 Linaro Limited. All rights reserved.
  * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef _LINUX_CORESIGHT_PMU_H
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 912b85b52344..b8e288a1f740 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -650,11 +650,23 @@ struct perf_event_mmap_page {
 #define PERF_RECORD_MISC_COMM_EXEC		(1 << 13)
 #define PERF_RECORD_MISC_SWITCH_OUT		(1 << 13)
 /*
- * Indicates that the content of PERF_SAMPLE_IP points to
- * the actual instruction that triggered the event. See also
- * perf_event_attr::precise_ip.
+ * These PERF_RECORD_MISC_* flags below are safely reused
+ * for the following events:
+ *
+ *   PERF_RECORD_MISC_EXACT_IP           - PERF_RECORD_SAMPLE of precise events
+ *   PERF_RECORD_MISC_SWITCH_OUT_PREEMPT - PERF_RECORD_SWITCH* events
+ *
+ *
+ * PERF_RECORD_MISC_EXACT_IP:
+ *   Indicates that the content of PERF_SAMPLE_IP points to
+ *   the actual instruction that triggered the event. See also
+ *   perf_event_attr::precise_ip.
+ *
+ * PERF_RECORD_MISC_SWITCH_OUT_PREEMPT:
+ *   Indicates that thread was preempted in TASK_RUNNING state.
  */
 #define PERF_RECORD_MISC_EXACT_IP		(1 << 14)
+#define PERF_RECORD_MISC_SWITCH_OUT_PREEMPT	(1 << 14)
 /*
  * Reserve the last bit to indicate some extended misc field
  */
diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index 772a43fea825..c187aa3df3c8 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -119,23 +119,20 @@ int get_callchain_buffers(int event_max_stack)
 		goto exit;
 	}
 
-	if (count > 1) {
-		/* If the allocation failed, give up */
-		if (!callchain_cpus_entries)
-			err = -ENOMEM;
-		/*
-		 * If requesting per event more than the global cap,
-		 * return a different error to help userspace figure
-		 * this out.
-		 *
-		 * And also do it here so that we have &callchain_mutex held.
-		 */
-		if (event_max_stack > sysctl_perf_event_max_stack)
-			err = -EOVERFLOW;
+	/*
+	 * If requesting per event more than the global cap,
+	 * return a different error to help userspace figure
+	 * this out.
+	 *
+	 * And also do it here so that we have &callchain_mutex held.
+	 */
+	if (event_max_stack > sysctl_perf_event_max_stack) {
+		err = -EOVERFLOW;
 		goto exit;
 	}
 
-	err = alloc_callchain_buffers();
+	if (count == 1)
+		err = alloc_callchain_buffers();
 exit:
 	if (err)
 		atomic_dec(&nr_callchain_events);
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 2d5fe26551f8..67612ce359ad 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7587,6 +7587,10 @@ static void perf_event_switch(struct task_struct *task,
 		},
 	};
 
+	if (!sched_in && task->state == TASK_RUNNING)
+		switch_event.event_id.header.misc |=
+				PERF_RECORD_MISC_SWITCH_OUT_PREEMPT;
+
 	perf_iterate_sb(perf_event_switch_output,
 		       &switch_event,
 		       NULL);
@@ -10205,9 +10209,9 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
 		 * __u16 sample size limit.
 		 */
 		if (attr->sample_stack_user >= USHRT_MAX)
-			ret = -EINVAL;
+			return -EINVAL;
 		else if (!IS_ALIGNED(attr->sample_stack_user, sizeof(u64)))
-			ret = -EINVAL;
+			return -EINVAL;
 	}
 
 	if (!attr->sample_max_stack)
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 1cd3fb4d70f8..02aed76e0978 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -512,8 +512,6 @@ static int __register_trace_kprobe(struct trace_kprobe *tk)
 	if (ret == 0)
 		tk->tp.flags |= TP_FLAG_REGISTERED;
 	else {
-		pr_warn("Could not insert probe at %s+%lu: %d\n",
-			trace_kprobe_symbol(tk), trace_kprobe_offset(tk), ret);
 		if (ret == -ENOENT && trace_kprobe_is_on_module(tk)) {
 			pr_warn("This probe might be able to register after target module is loaded. Continue.\n");
 			ret = 0;
diff --git a/tools/arch/arm/include/uapi/asm/kvm.h b/tools/arch/arm/include/uapi/asm/kvm.h
index 6edd177bb1c7..2ba95d6fe852 100644
--- a/tools/arch/arm/include/uapi/asm/kvm.h
+++ b/tools/arch/arm/include/uapi/asm/kvm.h
@@ -135,6 +135,15 @@ struct kvm_arch_memory_slot {
 #define KVM_REG_ARM_CRM_SHIFT		7
 #define KVM_REG_ARM_32_CRN_MASK		0x0000000000007800
 #define KVM_REG_ARM_32_CRN_SHIFT	11
+/*
+ * For KVM currently all guest registers are nonsecure, but we reserve a bit
+ * in the encoding to distinguish secure from nonsecure for AArch32 system
+ * registers that are banked by security. This is 1 for the secure banked
+ * register, and 0 for the nonsecure banked register or if the register is
+ * not banked by security.
+ */
+#define KVM_REG_ARM_SECURE_MASK	0x0000000010000000
+#define KVM_REG_ARM_SECURE_SHIFT	28
 
 #define ARM_CP15_REG_SHIFT_MASK(x,n) \
 	(((x) << KVM_REG_ARM_ ## n ## _SHIFT) & KVM_REG_ARM_ ## n ## _MASK)
diff --git a/tools/arch/x86/include/asm/required-features.h b/tools/arch/x86/include/asm/required-features.h
index fb3a6de7440b..6847d85400a8 100644
--- a/tools/arch/x86/include/asm/required-features.h
+++ b/tools/arch/x86/include/asm/required-features.h
@@ -53,12 +53,6 @@
 # define NEED_MOVBE	0
 #endif
 
-#ifdef CONFIG_X86_5LEVEL
-# define NEED_LA57	(1<<(X86_FEATURE_LA57 & 31))
-#else
-# define NEED_LA57	0
-#endif
-
 #ifdef CONFIG_X86_64
 #ifdef CONFIG_PARAVIRT
 /* Paravirtualized systems may not have PSE or PGE available */
@@ -104,7 +98,7 @@
 #define REQUIRED_MASK13	0
 #define REQUIRED_MASK14	0
 #define REQUIRED_MASK15	0
-#define REQUIRED_MASK16	(NEED_LA57)
+#define REQUIRED_MASK16	0
 #define REQUIRED_MASK17	0
 #define REQUIRED_MASK18	0
 #define REQUIRED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 19)
diff --git a/tools/arch/x86/include/uapi/asm/kvm.h b/tools/arch/x86/include/uapi/asm/kvm.h
index f3a960488eae..c535c2fdea13 100644
--- a/tools/arch/x86/include/uapi/asm/kvm.h
+++ b/tools/arch/x86/include/uapi/asm/kvm.h
@@ -354,8 +354,25 @@ struct kvm_xcrs {
 	__u64 padding[16];
 };
 
-/* definition of registers in kvm_run */
+#define KVM_SYNC_X86_REGS      (1UL << 0)
+#define KVM_SYNC_X86_SREGS     (1UL << 1)
+#define KVM_SYNC_X86_EVENTS    (1UL << 2)
+
+#define KVM_SYNC_X86_VALID_FIELDS \
+	(KVM_SYNC_X86_REGS| \
+	 KVM_SYNC_X86_SREGS| \
+	 KVM_SYNC_X86_EVENTS)
+
+/* kvm_sync_regs struct included by kvm_run struct */
 struct kvm_sync_regs {
+	/* Members of this structure are potentially malicious.
+	 * Care must be taken by code reading, esp. interpreting,
+	 * data fields from them inside KVM to prevent TOCTOU and
+	 * double-fetch types of vulnerabilities.
+	 */
+	struct kvm_regs regs;
+	struct kvm_sregs sregs;
+	struct kvm_vcpu_events events;
 };
 
 #define KVM_X86_QUIRK_LINT0_REENABLED	(1 << 0)
diff --git a/tools/include/linux/compiler.h b/tools/include/linux/compiler.h
index 04e32f965ad7..1827c2f973f9 100644
--- a/tools/include/linux/compiler.h
+++ b/tools/include/linux/compiler.h
@@ -151,11 +151,21 @@ static __always_inline void __write_once_size(volatile void *p, void *res, int s
  * required ordering.
  */
 
-#define READ_ONCE(x) \
-	({ union { typeof(x) __val; char __c[1]; } __u; __read_once_size(&(x), __u.__c, sizeof(x)); __u.__val; })
-
-#define WRITE_ONCE(x, val) \
-	({ union { typeof(x) __val; char __c[1]; } __u = { .__val = (val) }; __write_once_size(&(x), __u.__c, sizeof(x)); __u.__val; })
+#define READ_ONCE(x)					\
+({							\
+	union { typeof(x) __val; char __c[1]; } __u =	\
+		{ .__c = { 0 } };			\
+	__read_once_size(&(x), __u.__c, sizeof(x));	\
+	__u.__val;					\
+})
+
+#define WRITE_ONCE(x, val)				\
+({							\
+	union { typeof(x) __val; char __c[1]; } __u =	\
+		{ .__val = (val) }; 			\
+	__write_once_size(&(x), __u.__c, sizeof(x));	\
+	__u.__val;					\
+})
 
 
 #ifndef __fallthrough
diff --git a/tools/include/linux/coresight-pmu.h b/tools/include/linux/coresight-pmu.h
index edfeaba95429..a1a959ba24ff 100644
--- a/tools/include/linux/coresight-pmu.h
+++ b/tools/include/linux/coresight-pmu.h
@@ -1,18 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright(C) 2015 Linaro Limited. All rights reserved.
  * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef _LINUX_CORESIGHT_PMU_H
diff --git a/tools/include/uapi/asm-generic/mman-common.h b/tools/include/uapi/asm-generic/mman-common.h
index f8b134f5608f..e7ee32861d51 100644
--- a/tools/include/uapi/asm-generic/mman-common.h
+++ b/tools/include/uapi/asm-generic/mman-common.h
@@ -27,6 +27,9 @@
 # define MAP_UNINITIALIZED 0x0		/* Don't support this flag */
 #endif
 
+/* 0x0100 - 0x80000 flags are defined in asm-generic/mman.h */
+#define MAP_FIXED_NOREPLACE	0x100000	/* MAP_FIXED which doesn't unmap underlying mapping */
+
 /*
  * Flags for mlock
  */
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 9d07465023a2..c5ec89732a8d 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -864,6 +864,7 @@ enum bpf_func_id {
 /* BPF_FUNC_skb_set_tunnel_key flags. */
 #define BPF_F_ZERO_CSUM_TX		(1ULL << 1)
 #define BPF_F_DONT_FRAGMENT		(1ULL << 2)
+#define BPF_F_SEQ_NUMBER		(1ULL << 3)
 
 /* BPF_FUNC_perf_event_output, BPF_FUNC_perf_event_read and
  * BPF_FUNC_perf_event_read_value flags.
diff --git a/tools/include/uapi/linux/if_link.h b/tools/include/uapi/linux/if_link.h
index 6d9447700e18..68699f654118 100644
--- a/tools/include/uapi/linux/if_link.h
+++ b/tools/include/uapi/linux/if_link.h
@@ -941,4 +941,43 @@ enum {
 	IFLA_EVENT_BONDING_OPTIONS,	/* change in bonding options */
 };
 
+/* tun section */
+
+enum {
+	IFLA_TUN_UNSPEC,
+	IFLA_TUN_OWNER,
+	IFLA_TUN_GROUP,
+	IFLA_TUN_TYPE,
+	IFLA_TUN_PI,
+	IFLA_TUN_VNET_HDR,
+	IFLA_TUN_PERSIST,
+	IFLA_TUN_MULTI_QUEUE,
+	IFLA_TUN_NUM_QUEUES,
+	IFLA_TUN_NUM_DISABLED_QUEUES,
+	__IFLA_TUN_MAX,
+};
+
+#define IFLA_TUN_MAX (__IFLA_TUN_MAX - 1)
+
+/* rmnet section */
+
+#define RMNET_FLAGS_INGRESS_DEAGGREGATION         (1U << 0)
+#define RMNET_FLAGS_INGRESS_MAP_COMMANDS          (1U << 1)
+#define RMNET_FLAGS_INGRESS_MAP_CKSUMV4           (1U << 2)
+#define RMNET_FLAGS_EGRESS_MAP_CKSUMV4            (1U << 3)
+
+enum {
+	IFLA_RMNET_UNSPEC,
+	IFLA_RMNET_MUX_ID,
+	IFLA_RMNET_FLAGS,
+	__IFLA_RMNET_MAX,
+};
+
+#define IFLA_RMNET_MAX	(__IFLA_RMNET_MAX - 1)
+
+struct ifla_rmnet_flags {
+	__u32	flags;
+	__u32	mask;
+};
+
 #endif /* _UAPI_LINUX_IF_LINK_H */
diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index 6b89f87db200..1065006c9bf5 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -396,6 +396,10 @@ struct kvm_run {
 		char padding[256];
 	};
 
+	/* 2048 is the size of the char array used to bound/pad the size
+	 * of the union that holds sync regs.
+	 */
+	#define SYNC_REGS_SIZE_BYTES 2048
 	/*
 	 * shared registers between kvm and userspace.
 	 * kvm_valid_regs specifies the register classes set by the host
@@ -407,7 +411,7 @@ struct kvm_run {
 	__u64 kvm_dirty_regs;
 	union {
 		struct kvm_sync_regs regs;
-		char padding[2048];
+		char padding[SYNC_REGS_SIZE_BYTES];
 	} s;
 };
 
@@ -936,6 +940,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_PPC_GET_CPU_CHAR 151
 #define KVM_CAP_S390_BPB 152
 #define KVM_CAP_GET_MSR_FEATURES 153
+#define KVM_CAP_HYPERV_EVENTFD 154
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1375,6 +1380,10 @@ struct kvm_enc_region {
 #define KVM_MEMORY_ENCRYPT_REG_REGION    _IOR(KVMIO, 0xbb, struct kvm_enc_region)
 #define KVM_MEMORY_ENCRYPT_UNREG_REGION  _IOR(KVMIO, 0xbc, struct kvm_enc_region)
 
+/* Available with KVM_CAP_HYPERV_EVENTFD */
+#define KVM_HYPERV_EVENTFD        _IOW(KVMIO,  0xbd, struct kvm_hyperv_eventfd)
+
+
 /* Secure Encrypted Virtualization command */
 enum sev_cmd_id {
 	/* Guest initialization commands */
@@ -1515,4 +1524,14 @@ struct kvm_assigned_msix_entry {
 #define KVM_ARM_DEV_EL1_PTIMER		(1 << 1)
 #define KVM_ARM_DEV_PMU			(1 << 2)
 
+struct kvm_hyperv_eventfd {
+	__u32 conn_id;
+	__s32 fd;
+	__u32 flags;
+	__u32 padding[3];
+};
+
+#define KVM_HYPERV_CONN_ID_MASK		0x00ffffff
+#define KVM_HYPERV_EVENTFD_DEASSIGN	(1 << 0)
+
 #endif /* __LINUX_KVM_H */
diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 912b85b52344..b8e288a1f740 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -650,11 +650,23 @@ struct perf_event_mmap_page {
 #define PERF_RECORD_MISC_COMM_EXEC		(1 << 13)
 #define PERF_RECORD_MISC_SWITCH_OUT		(1 << 13)
 /*
- * Indicates that the content of PERF_SAMPLE_IP points to
- * the actual instruction that triggered the event. See also
- * perf_event_attr::precise_ip.
+ * These PERF_RECORD_MISC_* flags below are safely reused
+ * for the following events:
+ *
+ *   PERF_RECORD_MISC_EXACT_IP           - PERF_RECORD_SAMPLE of precise events
+ *   PERF_RECORD_MISC_SWITCH_OUT_PREEMPT - PERF_RECORD_SWITCH* events
+ *
+ *
+ * PERF_RECORD_MISC_EXACT_IP:
+ *   Indicates that the content of PERF_SAMPLE_IP points to
+ *   the actual instruction that triggered the event. See also
+ *   perf_event_attr::precise_ip.
+ *
+ * PERF_RECORD_MISC_SWITCH_OUT_PREEMPT:
+ *   Indicates that thread was preempted in TASK_RUNNING state.
  */
 #define PERF_RECORD_MISC_EXACT_IP		(1 << 14)
+#define PERF_RECORD_MISC_SWITCH_OUT_PREEMPT	(1 << 14)
 /*
  * Reserve the last bit to indicate some extended misc field
  */
diff --git a/tools/include/uapi/sound/asound.h b/tools/include/uapi/sound/asound.h
index 07d61583fd02..ed0a120d4f08 100644
--- a/tools/include/uapi/sound/asound.h
+++ b/tools/include/uapi/sound/asound.h
@@ -242,6 +242,7 @@ typedef int __bitwise snd_pcm_format_t;
 #define	SNDRV_PCM_FORMAT_DSD_U16_BE	((__force snd_pcm_format_t) 51) /* DSD, 2-byte samples DSD (x16), big endian */
 #define	SNDRV_PCM_FORMAT_DSD_U32_BE	((__force snd_pcm_format_t) 52) /* DSD, 4-byte samples DSD (x32), big endian */
 #define	SNDRV_PCM_FORMAT_LAST		SNDRV_PCM_FORMAT_DSD_U32_BE
+#define	SNDRV_PCM_FORMAT_FIRST		SNDRV_PCM_FORMAT_S8
 
 #ifdef SNDRV_LITTLE_ENDIAN
 #define	SNDRV_PCM_FORMAT_S16		SNDRV_PCM_FORMAT_S16_LE
diff --git a/tools/lib/subcmd/parse-options.c b/tools/lib/subcmd/parse-options.c
index f6a1babcbac4..cb7154eccbdc 100644
--- a/tools/lib/subcmd/parse-options.c
+++ b/tools/lib/subcmd/parse-options.c
@@ -433,7 +433,7 @@ static int parse_long_opt(struct parse_opt_ctx_t *p, const char *arg,
 
 	if (ambiguous_option) {
 		 fprintf(stderr,
-			 " Error: Ambiguous option: %s (could be --%s%s or --%s%s)",
+			 " Error: Ambiguous option: %s (could be --%s%s or --%s%s)\n",
 			 arg,
 			 (ambiguous_flags & OPT_UNSET) ?  "no-" : "",
 			 ambiguous_option->long_name,
@@ -458,7 +458,7 @@ static void check_typos(const char *arg, const struct option *options)
 		return;
 
 	if (strstarts(arg, "no-")) {
-		fprintf(stderr, " Error: did you mean `--%s` (with two dashes ?)", arg);
+		fprintf(stderr, " Error: did you mean `--%s` (with two dashes ?)\n", arg);
 		exit(129);
 	}
 
@@ -466,7 +466,7 @@ static void check_typos(const char *arg, const struct option *options)
 		if (!options->long_name)
 			continue;
 		if (strstarts(options->long_name, arg)) {
-			fprintf(stderr, " Error: did you mean `--%s` (with two dashes ?)", arg);
+			fprintf(stderr, " Error: did you mean `--%s` (with two dashes ?)\n", arg);
 			exit(129);
 		}
 	}
diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index 5b4fff3adc4b..32f4a898e3f2 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -334,6 +334,11 @@ annotate.*::
 
 		99.93 Å      mov    %eax,%eax
 
+	annotate.offset_level::
+		Default is '1', meaning just jump targets will have offsets show right beside
+		the instruction. When set to '2' 'call' instructions will also have its offsets
+		shown, 3 or higher will show offsets for all instructions.
+
 hist.*::
 	hist.percentage::
 		This option control the way to calculate overhead of filtered entries -
diff --git a/tools/perf/Documentation/perf-mem.txt b/tools/perf/Documentation/perf-mem.txt
index b0211410969b..8806ed5f3802 100644
--- a/tools/perf/Documentation/perf-mem.txt
+++ b/tools/perf/Documentation/perf-mem.txt
@@ -67,6 +67,9 @@ OPTIONS
 --phys-data::
 	Record/Report sample physical addresses
 
+In addition, for report all perf report options are valid, and for record
+all perf record options.
+
 SEE ALSO
 --------
 linkperf:perf-record[1], linkperf:perf-report[1]
diff --git a/tools/perf/Documentation/perf-sched.txt b/tools/perf/Documentation/perf-sched.txt
index bb33601a823b..63f938b887dd 100644
--- a/tools/perf/Documentation/perf-sched.txt
+++ b/tools/perf/Documentation/perf-sched.txt
@@ -104,8 +104,8 @@ OPTIONS for 'perf sched timehist'
     kallsyms pathname
 
 -g::
---no-call-graph::
-	Do not display call chains if present.
+--call-graph::
+	Display call chains if present (default on).
 
 --max-stack::
 	Maximum number of functions to display in backtrace, default 5.
diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 36ec0257f8d3..afdafe2110a1 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -228,14 +228,15 @@ OPTIONS
 	For sample events it's possible to display misc field with -F +misc option,
 	following letters are displayed for each bit:
 
-	  PERF_RECORD_MISC_KERNEL        K
-	  PERF_RECORD_MISC_USER          U
-	  PERF_RECORD_MISC_HYPERVISOR    H
-	  PERF_RECORD_MISC_GUEST_KERNEL  G
-	  PERF_RECORD_MISC_GUEST_USER    g
-	  PERF_RECORD_MISC_MMAP_DATA*    M
-	  PERF_RECORD_MISC_COMM_EXEC     E
-	  PERF_RECORD_MISC_SWITCH_OUT    S
+	  PERF_RECORD_MISC_KERNEL               K
+	  PERF_RECORD_MISC_USER                 U
+	  PERF_RECORD_MISC_HYPERVISOR           H
+	  PERF_RECORD_MISC_GUEST_KERNEL         G
+	  PERF_RECORD_MISC_GUEST_USER           g
+	  PERF_RECORD_MISC_MMAP_DATA*           M
+	  PERF_RECORD_MISC_COMM_EXEC            E
+	  PERF_RECORD_MISC_SWITCH_OUT           S
+	  PERF_RECORD_MISC_SWITCH_OUT_PREEMPT   Sp
 
 	  $ perf script -F +misc ...
 	   sched-messaging  1414 K     28690.636582:       4590 cycles ...
diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index f15b306be183..e6c3b4e555c2 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -153,7 +153,7 @@ perf stat --repeat 10 --null --sync --pre 'make -s O=defconfig-build/clean' -- m
 
 -I msecs::
 --interval-print msecs::
-Print count deltas every N milliseconds (minimum: 10ms)
+Print count deltas every N milliseconds (minimum: 1ms)
 The overhead percentage could be high in some cases, for instance with small, sub 100ms intervals.  Use with caution.
 	example: 'perf stat -I 1000 -e cycles -a sleep 5'
 
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index c7abd83a8e19..ae7dc46e8f8a 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -68,7 +68,7 @@ ifeq ($(NO_PERF_REGS),0)
 endif
 
 ifneq ($(NO_SYSCALL_TABLE),1)
-  CFLAGS += -DHAVE_SYSCALL_TABLE
+  CFLAGS += -DHAVE_SYSCALL_TABLE_SUPPORT
 endif
 
 # So far there's only x86 and arm libdw unwind support merged in perf.
@@ -847,7 +847,7 @@ ifndef NO_JVMTI
   ifeq ($(feature-jvmti), 1)
     $(call detected_var,JDIR)
   else
-    $(warning No openjdk development package found, please install JDK package)
+    $(warning No openjdk development package found, please install JDK package, e.g. openjdk-8-jdk, java-1.8.0-openjdk-devel)
     NO_JVMTI := 1
   endif
 endif
diff --git a/tools/perf/arch/arm/include/arch-tests.h b/tools/perf/arch/arm/include/arch-tests.h
new file mode 100644
index 000000000000..90ec4c8cb880
--- /dev/null
+++ b/tools/perf/arch/arm/include/arch-tests.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef ARCH_TESTS_H
+#define ARCH_TESTS_H
+
+#ifdef HAVE_DWARF_UNWIND_SUPPORT
+struct thread;
+struct perf_sample;
+#endif
+
+extern struct test arch_tests[];
+
+#endif
diff --git a/tools/perf/arch/arm/tests/Build b/tools/perf/arch/arm/tests/Build
index b30eff9bcc83..883c57ff0c08 100644
--- a/tools/perf/arch/arm/tests/Build
+++ b/tools/perf/arch/arm/tests/Build
@@ -1,2 +1,4 @@
 libperf-y += regs_load.o
 libperf-y += dwarf-unwind.o
+
+libperf-y += arch-tests.o
diff --git a/tools/perf/arch/arm/tests/arch-tests.c b/tools/perf/arch/arm/tests/arch-tests.c
new file mode 100644
index 000000000000..5b1543c98022
--- /dev/null
+++ b/tools/perf/arch/arm/tests/arch-tests.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <string.h>
+#include "tests/tests.h"
+#include "arch-tests.h"
+
+struct test arch_tests[] = {
+#ifdef HAVE_DWARF_UNWIND_SUPPORT
+	{
+		.desc = "DWARF unwind",
+		.func = test__dwarf_unwind,
+	},
+#endif
+	{
+		.func = NULL,
+	},
+};
diff --git a/tools/perf/arch/arm/util/auxtrace.c b/tools/perf/arch/arm/util/auxtrace.c
index fa639e3e52ac..1ce6bdbda561 100644
--- a/tools/perf/arch/arm/util/auxtrace.c
+++ b/tools/perf/arch/arm/util/auxtrace.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright(C) 2015 Linaro Limited. All rights reserved.
  * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <stdbool.h>
diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 5c655ad4621e..2f595cd73da6 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright(C) 2015 Linaro Limited. All rights reserved.
  * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <api/fs/fs.h>
diff --git a/tools/perf/arch/arm/util/cs-etm.h b/tools/perf/arch/arm/util/cs-etm.h
index 5256741be549..1a12e64f5127 100644
--- a/tools/perf/arch/arm/util/cs-etm.h
+++ b/tools/perf/arch/arm/util/cs-etm.h
@@ -1,18 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright(C) 2015 Linaro Limited. All rights reserved.
  * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef INCLUDE__PERF_CS_ETM_H__
diff --git a/tools/perf/arch/arm/util/pmu.c b/tools/perf/arch/arm/util/pmu.c
index ac4dffc807b8..e047571e6080 100644
--- a/tools/perf/arch/arm/util/pmu.c
+++ b/tools/perf/arch/arm/util/pmu.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright(C) 2015 Linaro Limited. All rights reserved.
  * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <string.h>
diff --git a/tools/perf/arch/x86/Makefile b/tools/perf/arch/x86/Makefile
index d74eaa7aa927..1a38e78117ce 100644
--- a/tools/perf/arch/x86/Makefile
+++ b/tools/perf/arch/x86/Makefile
@@ -21,7 +21,7 @@ _dummy := $(shell [ -d '$(out)' ] || mkdir -p '$(out)')
 $(header): $(sys)/syscall_64.tbl $(systbl)
 	@(test -d ../../kernel -a -d ../../tools -a -d ../perf && ( \
         (diff -B arch/x86/entry/syscalls/syscall_64.tbl ../../arch/x86/entry/syscalls/syscall_64.tbl >/dev/null) \
-        || echo "Warning: Kernel ABI header at 'tools/arch/x86/entry/syscalls/syscall_64.tbl' differs from latest version at 'arch/x86/entry/syscalls/syscall_64.tbl'" >&2 )) || true
+        || echo "Warning: Kernel ABI header at 'tools/perf/arch/x86/entry/syscalls/syscall_64.tbl' differs from latest version at 'arch/x86/entry/syscalls/syscall_64.tbl'" >&2 )) || true
 	$(Q)$(SHELL) '$(systbl)' $(sys)/syscall_64.tbl 'x86_64' > $@
 
 clean::
diff --git a/tools/perf/arch/x86/annotate/instructions.c b/tools/perf/arch/x86/annotate/instructions.c
index 5bd1ba8c0282..44f5aba78210 100644
--- a/tools/perf/arch/x86/annotate/instructions.c
+++ b/tools/perf/arch/x86/annotate/instructions.c
@@ -1,21 +1,43 @@
 // SPDX-License-Identifier: GPL-2.0
 static struct ins x86__instructions[] = {
+	{ .name = "adc",	.ops = &mov_ops,  },
+	{ .name = "adcb",	.ops = &mov_ops,  },
+	{ .name = "adcl",	.ops = &mov_ops,  },
 	{ .name = "add",	.ops = &mov_ops,  },
 	{ .name = "addl",	.ops = &mov_ops,  },
 	{ .name = "addq",	.ops = &mov_ops,  },
+	{ .name = "addsd",	.ops = &mov_ops,  },
 	{ .name = "addw",	.ops = &mov_ops,  },
 	{ .name = "and",	.ops = &mov_ops,  },
+	{ .name = "andb",	.ops = &mov_ops,  },
+	{ .name = "andl",	.ops = &mov_ops,  },
+	{ .name = "andpd",	.ops = &mov_ops,  },
+	{ .name = "andps",	.ops = &mov_ops,  },
+	{ .name = "andq",	.ops = &mov_ops,  },
+	{ .name = "andw",	.ops = &mov_ops,  },
+	{ .name = "bsr",	.ops = &mov_ops,  },
+	{ .name = "bt",		.ops = &mov_ops,  },
+	{ .name = "btr",	.ops = &mov_ops,  },
 	{ .name = "bts",	.ops = &mov_ops,  },
+	{ .name = "btsq",	.ops = &mov_ops,  },
 	{ .name = "call",	.ops = &call_ops, },
 	{ .name = "callq",	.ops = &call_ops, },
+	{ .name = "cmovbe",	.ops = &mov_ops,  },
+	{ .name = "cmove",	.ops = &mov_ops,  },
+	{ .name = "cmovae",	.ops = &mov_ops,  },
 	{ .name = "cmp",	.ops = &mov_ops,  },
 	{ .name = "cmpb",	.ops = &mov_ops,  },
 	{ .name = "cmpl",	.ops = &mov_ops,  },
 	{ .name = "cmpq",	.ops = &mov_ops,  },
 	{ .name = "cmpw",	.ops = &mov_ops,  },
 	{ .name = "cmpxch",	.ops = &mov_ops,  },
+	{ .name = "cmpxchg",	.ops = &mov_ops,  },
+	{ .name = "cs",		.ops = &mov_ops,  },
 	{ .name = "dec",	.ops = &dec_ops,  },
 	{ .name = "decl",	.ops = &dec_ops,  },
+	{ .name = "divsd",	.ops = &mov_ops,  },
+	{ .name = "divss",	.ops = &mov_ops,  },
+	{ .name = "gs",		.ops = &mov_ops,  },
 	{ .name = "imul",	.ops = &mov_ops,  },
 	{ .name = "inc",	.ops = &dec_ops,  },
 	{ .name = "incl",	.ops = &dec_ops,  },
@@ -57,25 +79,68 @@ static struct ins x86__instructions[] = {
 	{ .name = "lea",	.ops = &mov_ops,  },
 	{ .name = "lock",	.ops = &lock_ops, },
 	{ .name = "mov",	.ops = &mov_ops,  },
+	{ .name = "movapd",	.ops = &mov_ops,  },
+	{ .name = "movaps",	.ops = &mov_ops,  },
 	{ .name = "movb",	.ops = &mov_ops,  },
 	{ .name = "movdqa",	.ops = &mov_ops,  },
+	{ .name = "movdqu",	.ops = &mov_ops,  },
 	{ .name = "movl",	.ops = &mov_ops,  },
 	{ .name = "movq",	.ops = &mov_ops,  },
+	{ .name = "movsd",	.ops = &mov_ops,  },
 	{ .name = "movslq",	.ops = &mov_ops,  },
+	{ .name = "movss",	.ops = &mov_ops,  },
+	{ .name = "movupd",	.ops = &mov_ops,  },
+	{ .name = "movups",	.ops = &mov_ops,  },
+	{ .name = "movw",	.ops = &mov_ops,  },
 	{ .name = "movzbl",	.ops = &mov_ops,  },
 	{ .name = "movzwl",	.ops = &mov_ops,  },
+	{ .name = "mulsd",	.ops = &mov_ops,  },
+	{ .name = "mulss",	.ops = &mov_ops,  },
 	{ .name = "nop",	.ops = &nop_ops,  },
 	{ .name = "nopl",	.ops = &nop_ops,  },
 	{ .name = "nopw",	.ops = &nop_ops,  },
 	{ .name = "or",		.ops = &mov_ops,  },
+	{ .name = "orb",	.ops = &mov_ops,  },
 	{ .name = "orl",	.ops = &mov_ops,  },
+	{ .name = "orps",	.ops = &mov_ops,  },
+	{ .name = "orq",	.ops = &mov_ops,  },
+	{ .name = "pand",	.ops = &mov_ops,  },
+	{ .name = "paddq",	.ops = &mov_ops,  },
+	{ .name = "pcmpeqb",	.ops = &mov_ops,  },
+	{ .name = "por",	.ops = &mov_ops,  },
+	{ .name = "rclb",	.ops = &mov_ops,  },
+	{ .name = "rcll",	.ops = &mov_ops,  },
+	{ .name = "retq",	.ops = &ret_ops,  },
+	{ .name = "sbb",	.ops = &mov_ops,  },
+	{ .name = "sbbl",	.ops = &mov_ops,  },
+	{ .name = "sete",	.ops = &mov_ops,  },
+	{ .name = "sub",	.ops = &mov_ops,  },
+	{ .name = "subl",	.ops = &mov_ops,  },
+	{ .name = "subq",	.ops = &mov_ops,  },
+	{ .name = "subsd",	.ops = &mov_ops,  },
+	{ .name = "subw",	.ops = &mov_ops,  },
 	{ .name = "test",	.ops = &mov_ops,  },
 	{ .name = "testb",	.ops = &mov_ops,  },
 	{ .name = "testl",	.ops = &mov_ops,  },
+	{ .name = "ucomisd",	.ops = &mov_ops,  },
+	{ .name = "ucomiss",	.ops = &mov_ops,  },
+	{ .name = "vaddsd",	.ops = &mov_ops,  },
+	{ .name = "vandpd",	.ops = &mov_ops,  },
+	{ .name = "vmovdqa",	.ops = &mov_ops,  },
+	{ .name = "vmovq",	.ops = &mov_ops,  },
+	{ .name = "vmovsd",	.ops = &mov_ops,  },
+	{ .name = "vmulsd",	.ops = &mov_ops,  },
+	{ .name = "vorpd",	.ops = &mov_ops,  },
+	{ .name = "vsubsd",	.ops = &mov_ops,  },
+	{ .name = "vucomisd",	.ops = &mov_ops,  },
 	{ .name = "xadd",	.ops = &mov_ops,  },
 	{ .name = "xbeginl",	.ops = &jump_ops, },
 	{ .name = "xbeginq",	.ops = &jump_ops, },
-	{ .name = "retq",	.ops = &ret_ops,  },
+	{ .name = "xchg",	.ops = &mov_ops,  },
+	{ .name = "xor",	.ops = &mov_ops, },
+	{ .name = "xorb",	.ops = &mov_ops, },
+	{ .name = "xorpd",	.ops = &mov_ops, },
+	{ .name = "xorps",	.ops = &mov_ops, },
 };
 
 static bool x86__ins_is_fused(struct arch *arch, const char *ins1,
diff --git a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
index 5aef183e2f85..4dfe42666d0c 100644
--- a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
@@ -4,379 +4,383 @@
 # The format is:
 # <number> <abi> <name> <entry point>
 #
+# The __x64_sys_*() stubs are created on-the-fly for sys_*() system calls
+#
 # The abi is "common", "64" or "x32" for this file.
 #
-0	common	read			sys_read
-1	common	write			sys_write
-2	common	open			sys_open
-3	common	close			sys_close
-4	common	stat			sys_newstat
-5	common	fstat			sys_newfstat
-6	common	lstat			sys_newlstat
-7	common	poll			sys_poll
-8	common	lseek			sys_lseek
-9	common	mmap			sys_mmap
-10	common	mprotect		sys_mprotect
-11	common	munmap			sys_munmap
-12	common	brk			sys_brk
-13	64	rt_sigaction		sys_rt_sigaction
-14	common	rt_sigprocmask		sys_rt_sigprocmask
-15	64	rt_sigreturn		sys_rt_sigreturn/ptregs
-16	64	ioctl			sys_ioctl
-17	common	pread64			sys_pread64
-18	common	pwrite64		sys_pwrite64
-19	64	readv			sys_readv
-20	64	writev			sys_writev
-21	common	access			sys_access
-22	common	pipe			sys_pipe
-23	common	select			sys_select
-24	common	sched_yield		sys_sched_yield
-25	common	mremap			sys_mremap
-26	common	msync			sys_msync
-27	common	mincore			sys_mincore
-28	common	madvise			sys_madvise
-29	common	shmget			sys_shmget
-30	common	shmat			sys_shmat
-31	common	shmctl			sys_shmctl
-32	common	dup			sys_dup
-33	common	dup2			sys_dup2
-34	common	pause			sys_pause
-35	common	nanosleep		sys_nanosleep
-36	common	getitimer		sys_getitimer
-37	common	alarm			sys_alarm
-38	common	setitimer		sys_setitimer
-39	common	getpid			sys_getpid
-40	common	sendfile		sys_sendfile64
-41	common	socket			sys_socket
-42	common	connect			sys_connect
-43	common	accept			sys_accept
-44	common	sendto			sys_sendto
-45	64	recvfrom		sys_recvfrom
-46	64	sendmsg			sys_sendmsg
-47	64	recvmsg			sys_recvmsg
-48	common	shutdown		sys_shutdown
-49	common	bind			sys_bind
-50	common	listen			sys_listen
-51	common	getsockname		sys_getsockname
-52	common	getpeername		sys_getpeername
-53	common	socketpair		sys_socketpair
-54	64	setsockopt		sys_setsockopt
-55	64	getsockopt		sys_getsockopt
-56	common	clone			sys_clone/ptregs
-57	common	fork			sys_fork/ptregs
-58	common	vfork			sys_vfork/ptregs
-59	64	execve			sys_execve/ptregs
-60	common	exit			sys_exit
-61	common	wait4			sys_wait4
-62	common	kill			sys_kill
-63	common	uname			sys_newuname
-64	common	semget			sys_semget
-65	common	semop			sys_semop
-66	common	semctl			sys_semctl
-67	common	shmdt			sys_shmdt
-68	common	msgget			sys_msgget
-69	common	msgsnd			sys_msgsnd
-70	common	msgrcv			sys_msgrcv
-71	common	msgctl			sys_msgctl
-72	common	fcntl			sys_fcntl
-73	common	flock			sys_flock
-74	common	fsync			sys_fsync
-75	common	fdatasync		sys_fdatasync
-76	common	truncate		sys_truncate
-77	common	ftruncate		sys_ftruncate
-78	common	getdents		sys_getdents
-79	common	getcwd			sys_getcwd
-80	common	chdir			sys_chdir
-81	common	fchdir			sys_fchdir
-82	common	rename			sys_rename
-83	common	mkdir			sys_mkdir
-84	common	rmdir			sys_rmdir
-85	common	creat			sys_creat
-86	common	link			sys_link
-87	common	unlink			sys_unlink
-88	common	symlink			sys_symlink
-89	common	readlink		sys_readlink
-90	common	chmod			sys_chmod
-91	common	fchmod			sys_fchmod
-92	common	chown			sys_chown
-93	common	fchown			sys_fchown
-94	common	lchown			sys_lchown
-95	common	umask			sys_umask
-96	common	gettimeofday		sys_gettimeofday
-97	common	getrlimit		sys_getrlimit
-98	common	getrusage		sys_getrusage
-99	common	sysinfo			sys_sysinfo
-100	common	times			sys_times
-101	64	ptrace			sys_ptrace
-102	common	getuid			sys_getuid
-103	common	syslog			sys_syslog
-104	common	getgid			sys_getgid
-105	common	setuid			sys_setuid
-106	common	setgid			sys_setgid
-107	common	geteuid			sys_geteuid
-108	common	getegid			sys_getegid
-109	common	setpgid			sys_setpgid
-110	common	getppid			sys_getppid
-111	common	getpgrp			sys_getpgrp
-112	common	setsid			sys_setsid
-113	common	setreuid		sys_setreuid
-114	common	setregid		sys_setregid
-115	common	getgroups		sys_getgroups
-116	common	setgroups		sys_setgroups
-117	common	setresuid		sys_setresuid
-118	common	getresuid		sys_getresuid
-119	common	setresgid		sys_setresgid
-120	common	getresgid		sys_getresgid
-121	common	getpgid			sys_getpgid
-122	common	setfsuid		sys_setfsuid
-123	common	setfsgid		sys_setfsgid
-124	common	getsid			sys_getsid
-125	common	capget			sys_capget
-126	common	capset			sys_capset
-127	64	rt_sigpending		sys_rt_sigpending
-128	64	rt_sigtimedwait		sys_rt_sigtimedwait
-129	64	rt_sigqueueinfo		sys_rt_sigqueueinfo
-130	common	rt_sigsuspend		sys_rt_sigsuspend
-131	64	sigaltstack		sys_sigaltstack
-132	common	utime			sys_utime
-133	common	mknod			sys_mknod
+0	common	read			__x64_sys_read
+1	common	write			__x64_sys_write
+2	common	open			__x64_sys_open
+3	common	close			__x64_sys_close
+4	common	stat			__x64_sys_newstat
+5	common	fstat			__x64_sys_newfstat
+6	common	lstat			__x64_sys_newlstat
+7	common	poll			__x64_sys_poll
+8	common	lseek			__x64_sys_lseek
+9	common	mmap			__x64_sys_mmap
+10	common	mprotect		__x64_sys_mprotect
+11	common	munmap			__x64_sys_munmap
+12	common	brk			__x64_sys_brk
+13	64	rt_sigaction		__x64_sys_rt_sigaction
+14	common	rt_sigprocmask		__x64_sys_rt_sigprocmask
+15	64	rt_sigreturn		__x64_sys_rt_sigreturn/ptregs
+16	64	ioctl			__x64_sys_ioctl
+17	common	pread64			__x64_sys_pread64
+18	common	pwrite64		__x64_sys_pwrite64
+19	64	readv			__x64_sys_readv
+20	64	writev			__x64_sys_writev
+21	common	access			__x64_sys_access
+22	common	pipe			__x64_sys_pipe
+23	common	select			__x64_sys_select
+24	common	sched_yield		__x64_sys_sched_yield
+25	common	mremap			__x64_sys_mremap
+26	common	msync			__x64_sys_msync
+27	common	mincore			__x64_sys_mincore
+28	common	madvise			__x64_sys_madvise
+29	common	shmget			__x64_sys_shmget
+30	common	shmat			__x64_sys_shmat
+31	common	shmctl			__x64_sys_shmctl
+32	common	dup			__x64_sys_dup
+33	common	dup2			__x64_sys_dup2
+34	common	pause			__x64_sys_pause
+35	common	nanosleep		__x64_sys_nanosleep
+36	common	getitimer		__x64_sys_getitimer
+37	common	alarm			__x64_sys_alarm
+38	common	setitimer		__x64_sys_setitimer
+39	common	getpid			__x64_sys_getpid
+40	common	sendfile		__x64_sys_sendfile64
+41	common	socket			__x64_sys_socket
+42	common	connect			__x64_sys_connect
+43	common	accept			__x64_sys_accept
+44	common	sendto			__x64_sys_sendto
+45	64	recvfrom		__x64_sys_recvfrom
+46	64	sendmsg			__x64_sys_sendmsg
+47	64	recvmsg			__x64_sys_recvmsg
+48	common	shutdown		__x64_sys_shutdown
+49	common	bind			__x64_sys_bind
+50	common	listen			__x64_sys_listen
+51	common	getsockname		__x64_sys_getsockname
+52	common	getpeername		__x64_sys_getpeername
+53	common	socketpair		__x64_sys_socketpair
+54	64	setsockopt		__x64_sys_setsockopt
+55	64	getsockopt		__x64_sys_getsockopt
+56	common	clone			__x64_sys_clone/ptregs
+57	common	fork			__x64_sys_fork/ptregs
+58	common	vfork			__x64_sys_vfork/ptregs
+59	64	execve			__x64_sys_execve/ptregs
+60	common	exit			__x64_sys_exit
+61	common	wait4			__x64_sys_wait4
+62	common	kill			__x64_sys_kill
+63	common	uname			__x64_sys_newuname
+64	common	semget			__x64_sys_semget
+65	common	semop			__x64_sys_semop
+66	common	semctl			__x64_sys_semctl
+67	common	shmdt			__x64_sys_shmdt
+68	common	msgget			__x64_sys_msgget
+69	common	msgsnd			__x64_sys_msgsnd
+70	common	msgrcv			__x64_sys_msgrcv
+71	common	msgctl			__x64_sys_msgctl
+72	common	fcntl			__x64_sys_fcntl
+73	common	flock			__x64_sys_flock
+74	common	fsync			__x64_sys_fsync
+75	common	fdatasync		__x64_sys_fdatasync
+76	common	truncate		__x64_sys_truncate
+77	common	ftruncate		__x64_sys_ftruncate
+78	common	getdents		__x64_sys_getdents
+79	common	getcwd			__x64_sys_getcwd
+80	common	chdir			__x64_sys_chdir
+81	common	fchdir			__x64_sys_fchdir
+82	common	rename			__x64_sys_rename
+83	common	mkdir			__x64_sys_mkdir
+84	common	rmdir			__x64_sys_rmdir
+85	common	creat			__x64_sys_creat
+86	common	link			__x64_sys_link
+87	common	unlink			__x64_sys_unlink
+88	common	symlink			__x64_sys_symlink
+89	common	readlink		__x64_sys_readlink
+90	common	chmod			__x64_sys_chmod
+91	common	fchmod			__x64_sys_fchmod
+92	common	chown			__x64_sys_chown
+93	common	fchown			__x64_sys_fchown
+94	common	lchown			__x64_sys_lchown
+95	common	umask			__x64_sys_umask
+96	common	gettimeofday		__x64_sys_gettimeofday
+97	common	getrlimit		__x64_sys_getrlimit
+98	common	getrusage		__x64_sys_getrusage
+99	common	sysinfo			__x64_sys_sysinfo
+100	common	times			__x64_sys_times
+101	64	ptrace			__x64_sys_ptrace
+102	common	getuid			__x64_sys_getuid
+103	common	syslog			__x64_sys_syslog
+104	common	getgid			__x64_sys_getgid
+105	common	setuid			__x64_sys_setuid
+106	common	setgid			__x64_sys_setgid
+107	common	geteuid			__x64_sys_geteuid
+108	common	getegid			__x64_sys_getegid
+109	common	setpgid			__x64_sys_setpgid
+110	common	getppid			__x64_sys_getppid
+111	common	getpgrp			__x64_sys_getpgrp
+112	common	setsid			__x64_sys_setsid
+113	common	setreuid		__x64_sys_setreuid
+114	common	setregid		__x64_sys_setregid
+115	common	getgroups		__x64_sys_getgroups
+116	common	setgroups		__x64_sys_setgroups
+117	common	setresuid		__x64_sys_setresuid
+118	common	getresuid		__x64_sys_getresuid
+119	common	setresgid		__x64_sys_setresgid
+120	common	getresgid		__x64_sys_getresgid
+121	common	getpgid			__x64_sys_getpgid
+122	common	setfsuid		__x64_sys_setfsuid
+123	common	setfsgid		__x64_sys_setfsgid
+124	common	getsid			__x64_sys_getsid
+125	common	capget			__x64_sys_capget
+126	common	capset			__x64_sys_capset
+127	64	rt_sigpending		__x64_sys_rt_sigpending
+128	64	rt_sigtimedwait		__x64_sys_rt_sigtimedwait
+129	64	rt_sigqueueinfo		__x64_sys_rt_sigqueueinfo
+130	common	rt_sigsuspend		__x64_sys_rt_sigsuspend
+131	64	sigaltstack		__x64_sys_sigaltstack
+132	common	utime			__x64_sys_utime
+133	common	mknod			__x64_sys_mknod
 134	64	uselib
-135	common	personality		sys_personality
-136	common	ustat			sys_ustat
-137	common	statfs			sys_statfs
-138	common	fstatfs			sys_fstatfs
-139	common	sysfs			sys_sysfs
-140	common	getpriority		sys_getpriority
-141	common	setpriority		sys_setpriority
-142	common	sched_setparam		sys_sched_setparam
-143	common	sched_getparam		sys_sched_getparam
-144	common	sched_setscheduler	sys_sched_setscheduler
-145	common	sched_getscheduler	sys_sched_getscheduler
-146	common	sched_get_priority_max	sys_sched_get_priority_max
-147	common	sched_get_priority_min	sys_sched_get_priority_min
-148	common	sched_rr_get_interval	sys_sched_rr_get_interval
-149	common	mlock			sys_mlock
-150	common	munlock			sys_munlock
-151	common	mlockall		sys_mlockall
-152	common	munlockall		sys_munlockall
-153	common	vhangup			sys_vhangup
-154	common	modify_ldt		sys_modify_ldt
-155	common	pivot_root		sys_pivot_root
-156	64	_sysctl			sys_sysctl
-157	common	prctl			sys_prctl
-158	common	arch_prctl		sys_arch_prctl
-159	common	adjtimex		sys_adjtimex
-160	common	setrlimit		sys_setrlimit
-161	common	chroot			sys_chroot
-162	common	sync			sys_sync
-163	common	acct			sys_acct
-164	common	settimeofday		sys_settimeofday
-165	common	mount			sys_mount
-166	common	umount2			sys_umount
-167	common	swapon			sys_swapon
-168	common	swapoff			sys_swapoff
-169	common	reboot			sys_reboot
-170	common	sethostname		sys_sethostname
-171	common	setdomainname		sys_setdomainname
-172	common	iopl			sys_iopl/ptregs
-173	common	ioperm			sys_ioperm
+135	common	personality		__x64_sys_personality
+136	common	ustat			__x64_sys_ustat
+137	common	statfs			__x64_sys_statfs
+138	common	fstatfs			__x64_sys_fstatfs
+139	common	sysfs			__x64_sys_sysfs
+140	common	getpriority		__x64_sys_getpriority
+141	common	setpriority		__x64_sys_setpriority
+142	common	sched_setparam		__x64_sys_sched_setparam
+143	common	sched_getparam		__x64_sys_sched_getparam
+144	common	sched_setscheduler	__x64_sys_sched_setscheduler
+145	common	sched_getscheduler	__x64_sys_sched_getscheduler
+146	common	sched_get_priority_max	__x64_sys_sched_get_priority_max
+147	common	sched_get_priority_min	__x64_sys_sched_get_priority_min
+148	common	sched_rr_get_interval	__x64_sys_sched_rr_get_interval
+149	common	mlock			__x64_sys_mlock
+150	common	munlock			__x64_sys_munlock
+151	common	mlockall		__x64_sys_mlockall
+152	common	munlockall		__x64_sys_munlockall
+153	common	vhangup			__x64_sys_vhangup
+154	common	modify_ldt		__x64_sys_modify_ldt
+155	common	pivot_root		__x64_sys_pivot_root
+156	64	_sysctl			__x64_sys_sysctl
+157	common	prctl			__x64_sys_prctl
+158	common	arch_prctl		__x64_sys_arch_prctl
+159	common	adjtimex		__x64_sys_adjtimex
+160	common	setrlimit		__x64_sys_setrlimit
+161	common	chroot			__x64_sys_chroot
+162	common	sync			__x64_sys_sync
+163	common	acct			__x64_sys_acct
+164	common	settimeofday		__x64_sys_settimeofday
+165	common	mount			__x64_sys_mount
+166	common	umount2			__x64_sys_umount
+167	common	swapon			__x64_sys_swapon
+168	common	swapoff			__x64_sys_swapoff
+169	common	reboot			__x64_sys_reboot
+170	common	sethostname		__x64_sys_sethostname
+171	common	setdomainname		__x64_sys_setdomainname
+172	common	iopl			__x64_sys_iopl/ptregs
+173	common	ioperm			__x64_sys_ioperm
 174	64	create_module
-175	common	init_module		sys_init_module
-176	common	delete_module		sys_delete_module
+175	common	init_module		__x64_sys_init_module
+176	common	delete_module		__x64_sys_delete_module
 177	64	get_kernel_syms
 178	64	query_module
-179	common	quotactl		sys_quotactl
+179	common	quotactl		__x64_sys_quotactl
 180	64	nfsservctl
 181	common	getpmsg
 182	common	putpmsg
 183	common	afs_syscall
 184	common	tuxcall
 185	common	security
-186	common	gettid			sys_gettid
-187	common	readahead		sys_readahead
-188	common	setxattr		sys_setxattr
-189	common	lsetxattr		sys_lsetxattr
-190	common	fsetxattr		sys_fsetxattr
-191	common	getxattr		sys_getxattr
-192	common	lgetxattr		sys_lgetxattr
-193	common	fgetxattr		sys_fgetxattr
-194	common	listxattr		sys_listxattr
-195	common	llistxattr		sys_llistxattr
-196	common	flistxattr		sys_flistxattr
-197	common	removexattr		sys_removexattr
-198	common	lremovexattr		sys_lremovexattr
-199	common	fremovexattr		sys_fremovexattr
-200	common	tkill			sys_tkill
-201	common	time			sys_time
-202	common	futex			sys_futex
-203	common	sched_setaffinity	sys_sched_setaffinity
-204	common	sched_getaffinity	sys_sched_getaffinity
+186	common	gettid			__x64_sys_gettid
+187	common	readahead		__x64_sys_readahead
+188	common	setxattr		__x64_sys_setxattr
+189	common	lsetxattr		__x64_sys_lsetxattr
+190	common	fsetxattr		__x64_sys_fsetxattr
+191	common	getxattr		__x64_sys_getxattr
+192	common	lgetxattr		__x64_sys_lgetxattr
+193	common	fgetxattr		__x64_sys_fgetxattr
+194	common	listxattr		__x64_sys_listxattr
+195	common	llistxattr		__x64_sys_llistxattr
+196	common	flistxattr		__x64_sys_flistxattr
+197	common	removexattr		__x64_sys_removexattr
+198	common	lremovexattr		__x64_sys_lremovexattr
+199	common	fremovexattr		__x64_sys_fremovexattr
+200	common	tkill			__x64_sys_tkill
+201	common	time			__x64_sys_time
+202	common	futex			__x64_sys_futex
+203	common	sched_setaffinity	__x64_sys_sched_setaffinity
+204	common	sched_getaffinity	__x64_sys_sched_getaffinity
 205	64	set_thread_area
-206	64	io_setup		sys_io_setup
-207	common	io_destroy		sys_io_destroy
-208	common	io_getevents		sys_io_getevents
-209	64	io_submit		sys_io_submit
-210	common	io_cancel		sys_io_cancel
+206	64	io_setup		__x64_sys_io_setup
+207	common	io_destroy		__x64_sys_io_destroy
+208	common	io_getevents		__x64_sys_io_getevents
+209	64	io_submit		__x64_sys_io_submit
+210	common	io_cancel		__x64_sys_io_cancel
 211	64	get_thread_area
-212	common	lookup_dcookie		sys_lookup_dcookie
-213	common	epoll_create		sys_epoll_create
+212	common	lookup_dcookie		__x64_sys_lookup_dcookie
+213	common	epoll_create		__x64_sys_epoll_create
 214	64	epoll_ctl_old
 215	64	epoll_wait_old
-216	common	remap_file_pages	sys_remap_file_pages
-217	common	getdents64		sys_getdents64
-218	common	set_tid_address		sys_set_tid_address
-219	common	restart_syscall		sys_restart_syscall
-220	common	semtimedop		sys_semtimedop
-221	common	fadvise64		sys_fadvise64
-222	64	timer_create		sys_timer_create
-223	common	timer_settime		sys_timer_settime
-224	common	timer_gettime		sys_timer_gettime
-225	common	timer_getoverrun	sys_timer_getoverrun
-226	common	timer_delete		sys_timer_delete
-227	common	clock_settime		sys_clock_settime
-228	common	clock_gettime		sys_clock_gettime
-229	common	clock_getres		sys_clock_getres
-230	common	clock_nanosleep		sys_clock_nanosleep
-231	common	exit_group		sys_exit_group
-232	common	epoll_wait		sys_epoll_wait
-233	common	epoll_ctl		sys_epoll_ctl
-234	common	tgkill			sys_tgkill
-235	common	utimes			sys_utimes
+216	common	remap_file_pages	__x64_sys_remap_file_pages
+217	common	getdents64		__x64_sys_getdents64
+218	common	set_tid_address		__x64_sys_set_tid_address
+219	common	restart_syscall		__x64_sys_restart_syscall
+220	common	semtimedop		__x64_sys_semtimedop
+221	common	fadvise64		__x64_sys_fadvise64
+222	64	timer_create		__x64_sys_timer_create
+223	common	timer_settime		__x64_sys_timer_settime
+224	common	timer_gettime		__x64_sys_timer_gettime
+225	common	timer_getoverrun	__x64_sys_timer_getoverrun
+226	common	timer_delete		__x64_sys_timer_delete
+227	common	clock_settime		__x64_sys_clock_settime
+228	common	clock_gettime		__x64_sys_clock_gettime
+229	common	clock_getres		__x64_sys_clock_getres
+230	common	clock_nanosleep		__x64_sys_clock_nanosleep
+231	common	exit_group		__x64_sys_exit_group
+232	common	epoll_wait		__x64_sys_epoll_wait
+233	common	epoll_ctl		__x64_sys_epoll_ctl
+234	common	tgkill			__x64_sys_tgkill
+235	common	utimes			__x64_sys_utimes
 236	64	vserver
-237	common	mbind			sys_mbind
-238	common	set_mempolicy		sys_set_mempolicy
-239	common	get_mempolicy		sys_get_mempolicy
-240	common	mq_open			sys_mq_open
-241	common	mq_unlink		sys_mq_unlink
-242	common	mq_timedsend		sys_mq_timedsend
-243	common	mq_timedreceive		sys_mq_timedreceive
-244	64	mq_notify		sys_mq_notify
-245	common	mq_getsetattr		sys_mq_getsetattr
-246	64	kexec_load		sys_kexec_load
-247	64	waitid			sys_waitid
-248	common	add_key			sys_add_key
-249	common	request_key		sys_request_key
-250	common	keyctl			sys_keyctl
-251	common	ioprio_set		sys_ioprio_set
-252	common	ioprio_get		sys_ioprio_get
-253	common	inotify_init		sys_inotify_init
-254	common	inotify_add_watch	sys_inotify_add_watch
-255	common	inotify_rm_watch	sys_inotify_rm_watch
-256	common	migrate_pages		sys_migrate_pages
-257	common	openat			sys_openat
-258	common	mkdirat			sys_mkdirat
-259	common	mknodat			sys_mknodat
-260	common	fchownat		sys_fchownat
-261	common	futimesat		sys_futimesat
-262	common	newfstatat		sys_newfstatat
-263	common	unlinkat		sys_unlinkat
-264	common	renameat		sys_renameat
-265	common	linkat			sys_linkat
-266	common	symlinkat		sys_symlinkat
-267	common	readlinkat		sys_readlinkat
-268	common	fchmodat		sys_fchmodat
-269	common	faccessat		sys_faccessat
-270	common	pselect6		sys_pselect6
-271	common	ppoll			sys_ppoll
-272	common	unshare			sys_unshare
-273	64	set_robust_list		sys_set_robust_list
-274	64	get_robust_list		sys_get_robust_list
-275	common	splice			sys_splice
-276	common	tee			sys_tee
-277	common	sync_file_range		sys_sync_file_range
-278	64	vmsplice		sys_vmsplice
-279	64	move_pages		sys_move_pages
-280	common	utimensat		sys_utimensat
-281	common	epoll_pwait		sys_epoll_pwait
-282	common	signalfd		sys_signalfd
-283	common	timerfd_create		sys_timerfd_create
-284	common	eventfd			sys_eventfd
-285	common	fallocate		sys_fallocate
-286	common	timerfd_settime		sys_timerfd_settime
-287	common	timerfd_gettime		sys_timerfd_gettime
-288	common	accept4			sys_accept4
-289	common	signalfd4		sys_signalfd4
-290	common	eventfd2		sys_eventfd2
-291	common	epoll_create1		sys_epoll_create1
-292	common	dup3			sys_dup3
-293	common	pipe2			sys_pipe2
-294	common	inotify_init1		sys_inotify_init1
-295	64	preadv			sys_preadv
-296	64	pwritev			sys_pwritev
-297	64	rt_tgsigqueueinfo	sys_rt_tgsigqueueinfo
-298	common	perf_event_open		sys_perf_event_open
-299	64	recvmmsg		sys_recvmmsg
-300	common	fanotify_init		sys_fanotify_init
-301	common	fanotify_mark		sys_fanotify_mark
-302	common	prlimit64		sys_prlimit64
-303	common	name_to_handle_at	sys_name_to_handle_at
-304	common	open_by_handle_at	sys_open_by_handle_at
-305	common	clock_adjtime		sys_clock_adjtime
-306	common	syncfs			sys_syncfs
-307	64	sendmmsg		sys_sendmmsg
-308	common	setns			sys_setns
-309	common	getcpu			sys_getcpu
-310	64	process_vm_readv	sys_process_vm_readv
-311	64	process_vm_writev	sys_process_vm_writev
-312	common	kcmp			sys_kcmp
-313	common	finit_module		sys_finit_module
-314	common	sched_setattr		sys_sched_setattr
-315	common	sched_getattr		sys_sched_getattr
-316	common	renameat2		sys_renameat2
-317	common	seccomp			sys_seccomp
-318	common	getrandom		sys_getrandom
-319	common	memfd_create		sys_memfd_create
-320	common	kexec_file_load		sys_kexec_file_load
-321	common	bpf			sys_bpf
-322	64	execveat		sys_execveat/ptregs
-323	common	userfaultfd		sys_userfaultfd
-324	common	membarrier		sys_membarrier
-325	common	mlock2			sys_mlock2
-326	common	copy_file_range		sys_copy_file_range
-327	64	preadv2			sys_preadv2
-328	64	pwritev2		sys_pwritev2
-329	common	pkey_mprotect		sys_pkey_mprotect
-330	common	pkey_alloc		sys_pkey_alloc
-331	common	pkey_free		sys_pkey_free
-332	common	statx			sys_statx
+237	common	mbind			__x64_sys_mbind
+238	common	set_mempolicy		__x64_sys_set_mempolicy
+239	common	get_mempolicy		__x64_sys_get_mempolicy
+240	common	mq_open			__x64_sys_mq_open
+241	common	mq_unlink		__x64_sys_mq_unlink
+242	common	mq_timedsend		__x64_sys_mq_timedsend
+243	common	mq_timedreceive		__x64_sys_mq_timedreceive
+244	64	mq_notify		__x64_sys_mq_notify
+245	common	mq_getsetattr		__x64_sys_mq_getsetattr
+246	64	kexec_load		__x64_sys_kexec_load
+247	64	waitid			__x64_sys_waitid
+248	common	add_key			__x64_sys_add_key
+249	common	request_key		__x64_sys_request_key
+250	common	keyctl			__x64_sys_keyctl
+251	common	ioprio_set		__x64_sys_ioprio_set
+252	common	ioprio_get		__x64_sys_ioprio_get
+253	common	inotify_init		__x64_sys_inotify_init
+254	common	inotify_add_watch	__x64_sys_inotify_add_watch
+255	common	inotify_rm_watch	__x64_sys_inotify_rm_watch
+256	common	migrate_pages		__x64_sys_migrate_pages
+257	common	openat			__x64_sys_openat
+258	common	mkdirat			__x64_sys_mkdirat
+259	common	mknodat			__x64_sys_mknodat
+260	common	fchownat		__x64_sys_fchownat
+261	common	futimesat		__x64_sys_futimesat
+262	common	newfstatat		__x64_sys_newfstatat
+263	common	unlinkat		__x64_sys_unlinkat
+264	common	renameat		__x64_sys_renameat
+265	common	linkat			__x64_sys_linkat
+266	common	symlinkat		__x64_sys_symlinkat
+267	common	readlinkat		__x64_sys_readlinkat
+268	common	fchmodat		__x64_sys_fchmodat
+269	common	faccessat		__x64_sys_faccessat
+270	common	pselect6		__x64_sys_pselect6
+271	common	ppoll			__x64_sys_ppoll
+272	common	unshare			__x64_sys_unshare
+273	64	set_robust_list		__x64_sys_set_robust_list
+274	64	get_robust_list		__x64_sys_get_robust_list
+275	common	splice			__x64_sys_splice
+276	common	tee			__x64_sys_tee
+277	common	sync_file_range		__x64_sys_sync_file_range
+278	64	vmsplice		__x64_sys_vmsplice
+279	64	move_pages		__x64_sys_move_pages
+280	common	utimensat		__x64_sys_utimensat
+281	common	epoll_pwait		__x64_sys_epoll_pwait
+282	common	signalfd		__x64_sys_signalfd
+283	common	timerfd_create		__x64_sys_timerfd_create
+284	common	eventfd			__x64_sys_eventfd
+285	common	fallocate		__x64_sys_fallocate
+286	common	timerfd_settime		__x64_sys_timerfd_settime
+287	common	timerfd_gettime		__x64_sys_timerfd_gettime
+288	common	accept4			__x64_sys_accept4
+289	common	signalfd4		__x64_sys_signalfd4
+290	common	eventfd2		__x64_sys_eventfd2
+291	common	epoll_create1		__x64_sys_epoll_create1
+292	common	dup3			__x64_sys_dup3
+293	common	pipe2			__x64_sys_pipe2
+294	common	inotify_init1		__x64_sys_inotify_init1
+295	64	preadv			__x64_sys_preadv
+296	64	pwritev			__x64_sys_pwritev
+297	64	rt_tgsigqueueinfo	__x64_sys_rt_tgsigqueueinfo
+298	common	perf_event_open		__x64_sys_perf_event_open
+299	64	recvmmsg		__x64_sys_recvmmsg
+300	common	fanotify_init		__x64_sys_fanotify_init
+301	common	fanotify_mark		__x64_sys_fanotify_mark
+302	common	prlimit64		__x64_sys_prlimit64
+303	common	name_to_handle_at	__x64_sys_name_to_handle_at
+304	common	open_by_handle_at	__x64_sys_open_by_handle_at
+305	common	clock_adjtime		__x64_sys_clock_adjtime
+306	common	syncfs			__x64_sys_syncfs
+307	64	sendmmsg		__x64_sys_sendmmsg
+308	common	setns			__x64_sys_setns
+309	common	getcpu			__x64_sys_getcpu
+310	64	process_vm_readv	__x64_sys_process_vm_readv
+311	64	process_vm_writev	__x64_sys_process_vm_writev
+312	common	kcmp			__x64_sys_kcmp
+313	common	finit_module		__x64_sys_finit_module
+314	common	sched_setattr		__x64_sys_sched_setattr
+315	common	sched_getattr		__x64_sys_sched_getattr
+316	common	renameat2		__x64_sys_renameat2
+317	common	seccomp			__x64_sys_seccomp
+318	common	getrandom		__x64_sys_getrandom
+319	common	memfd_create		__x64_sys_memfd_create
+320	common	kexec_file_load		__x64_sys_kexec_file_load
+321	common	bpf			__x64_sys_bpf
+322	64	execveat		__x64_sys_execveat/ptregs
+323	common	userfaultfd		__x64_sys_userfaultfd
+324	common	membarrier		__x64_sys_membarrier
+325	common	mlock2			__x64_sys_mlock2
+326	common	copy_file_range		__x64_sys_copy_file_range
+327	64	preadv2			__x64_sys_preadv2
+328	64	pwritev2		__x64_sys_pwritev2
+329	common	pkey_mprotect		__x64_sys_pkey_mprotect
+330	common	pkey_alloc		__x64_sys_pkey_alloc
+331	common	pkey_free		__x64_sys_pkey_free
+332	common	statx			__x64_sys_statx
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
-# for native 64-bit operation.
+# for native 64-bit operation. The __x32_compat_sys stubs are created
+# on-the-fly for compat_sys_*() compatibility system calls if X86_X32
+# is defined.
 #
-512	x32	rt_sigaction		compat_sys_rt_sigaction
+512	x32	rt_sigaction		__x32_compat_sys_rt_sigaction
 513	x32	rt_sigreturn		sys32_x32_rt_sigreturn
-514	x32	ioctl			compat_sys_ioctl
-515	x32	readv			compat_sys_readv
-516	x32	writev			compat_sys_writev
-517	x32	recvfrom		compat_sys_recvfrom
-518	x32	sendmsg			compat_sys_sendmsg
-519	x32	recvmsg			compat_sys_recvmsg
-520	x32	execve			compat_sys_execve/ptregs
-521	x32	ptrace			compat_sys_ptrace
-522	x32	rt_sigpending		compat_sys_rt_sigpending
-523	x32	rt_sigtimedwait		compat_sys_rt_sigtimedwait
-524	x32	rt_sigqueueinfo		compat_sys_rt_sigqueueinfo
-525	x32	sigaltstack		compat_sys_sigaltstack
-526	x32	timer_create		compat_sys_timer_create
-527	x32	mq_notify		compat_sys_mq_notify
-528	x32	kexec_load		compat_sys_kexec_load
-529	x32	waitid			compat_sys_waitid
-530	x32	set_robust_list		compat_sys_set_robust_list
-531	x32	get_robust_list		compat_sys_get_robust_list
-532	x32	vmsplice		compat_sys_vmsplice
-533	x32	move_pages		compat_sys_move_pages
-534	x32	preadv			compat_sys_preadv64
-535	x32	pwritev			compat_sys_pwritev64
-536	x32	rt_tgsigqueueinfo	compat_sys_rt_tgsigqueueinfo
-537	x32	recvmmsg		compat_sys_recvmmsg
-538	x32	sendmmsg		compat_sys_sendmmsg
-539	x32	process_vm_readv	compat_sys_process_vm_readv
-540	x32	process_vm_writev	compat_sys_process_vm_writev
-541	x32	setsockopt		compat_sys_setsockopt
-542	x32	getsockopt		compat_sys_getsockopt
-543	x32	io_setup		compat_sys_io_setup
-544	x32	io_submit		compat_sys_io_submit
-545	x32	execveat		compat_sys_execveat/ptregs
-546	x32	preadv2			compat_sys_preadv64v2
-547	x32	pwritev2		compat_sys_pwritev64v2
+514	x32	ioctl			__x32_compat_sys_ioctl
+515	x32	readv			__x32_compat_sys_readv
+516	x32	writev			__x32_compat_sys_writev
+517	x32	recvfrom		__x32_compat_sys_recvfrom
+518	x32	sendmsg			__x32_compat_sys_sendmsg
+519	x32	recvmsg			__x32_compat_sys_recvmsg
+520	x32	execve			__x32_compat_sys_execve/ptregs
+521	x32	ptrace			__x32_compat_sys_ptrace
+522	x32	rt_sigpending		__x32_compat_sys_rt_sigpending
+523	x32	rt_sigtimedwait		__x32_compat_sys_rt_sigtimedwait
+524	x32	rt_sigqueueinfo		__x32_compat_sys_rt_sigqueueinfo
+525	x32	sigaltstack		__x32_compat_sys_sigaltstack
+526	x32	timer_create		__x32_compat_sys_timer_create
+527	x32	mq_notify		__x32_compat_sys_mq_notify
+528	x32	kexec_load		__x32_compat_sys_kexec_load
+529	x32	waitid			__x32_compat_sys_waitid
+530	x32	set_robust_list		__x32_compat_sys_set_robust_list
+531	x32	get_robust_list		__x32_compat_sys_get_robust_list
+532	x32	vmsplice		__x32_compat_sys_vmsplice
+533	x32	move_pages		__x32_compat_sys_move_pages
+534	x32	preadv			__x32_compat_sys_preadv64
+535	x32	pwritev			__x32_compat_sys_pwritev64
+536	x32	rt_tgsigqueueinfo	__x32_compat_sys_rt_tgsigqueueinfo
+537	x32	recvmmsg		__x32_compat_sys_recvmmsg
+538	x32	sendmmsg		__x32_compat_sys_sendmmsg
+539	x32	process_vm_readv	__x32_compat_sys_process_vm_readv
+540	x32	process_vm_writev	__x32_compat_sys_process_vm_writev
+541	x32	setsockopt		__x32_compat_sys_setsockopt
+542	x32	getsockopt		__x32_compat_sys_getsockopt
+543	x32	io_setup		__x32_compat_sys_io_setup
+544	x32	io_submit		__x32_compat_sys_io_submit
+545	x32	execveat		__x32_compat_sys_execveat/ptregs
+546	x32	preadv2			__x32_compat_sys_preadv64v2
+547	x32	pwritev2		__x32_compat_sys_pwritev64v2
diff --git a/tools/perf/builtin-help.c b/tools/perf/builtin-help.c
index 4aca13f23b9d..1c41b4eaf73c 100644
--- a/tools/perf/builtin-help.c
+++ b/tools/perf/builtin-help.c
@@ -439,7 +439,7 @@ int cmd_help(int argc, const char **argv)
 #ifdef HAVE_LIBELF_SUPPORT
 		"probe",
 #endif
-#if defined(HAVE_LIBAUDIT_SUPPORT) || defined(HAVE_SYSCALL_TABLE)
+#if defined(HAVE_LIBAUDIT_SUPPORT) || defined(HAVE_SYSCALL_TABLE_SUPPORT)
 		"trace",
 #endif
 	NULL };
diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index 506564651cda..57393e94d156 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -83,7 +83,7 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
 	};
 
 	argc = parse_options(argc, argv, options, record_mem_usage,
-			     PARSE_OPT_STOP_AT_NON_OPTION);
+			     PARSE_OPT_KEEP_UNKNOWN);
 
 	rec_argc = argc + 9; /* max number of arguments */
 	rec_argv = calloc(rec_argc + 1, sizeof(char *));
@@ -436,7 +436,7 @@ int cmd_mem(int argc, const char **argv)
 	}
 
 	argc = parse_options_subcommand(argc, argv, mem_options, mem_subcommands,
-					mem_usage, PARSE_OPT_STOP_AT_NON_OPTION);
+					mem_usage, PARSE_OPT_KEEP_UNKNOWN);
 
 	if (!argc || !(strncmp(argv[0], "rec", 3) || mem.operation))
 		usage_with_options(mem_usage, mem_options);
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 313c42423393..e0a9845b6cbc 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -657,8 +657,11 @@ static int perf_sample__fprintf_start(struct perf_sample *sample,
 			break;
 		case PERF_RECORD_SWITCH:
 		case PERF_RECORD_SWITCH_CPU_WIDE:
-			if (has(SWITCH_OUT))
+			if (has(SWITCH_OUT)) {
 				ret += fprintf(fp, "S");
+				if (sample->misc & PERF_RECORD_MISC_SWITCH_OUT_PREEMPT)
+					ret += fprintf(fp, "p");
+			}
 		default:
 			break;
 		}
@@ -2801,11 +2804,11 @@ int find_scripts(char **scripts_array, char **scripts_path_array)
 	for_each_lang(scripts_path, scripts_dir, lang_dirent) {
 		scnprintf(lang_path, MAXPATHLEN, "%s/%s", scripts_path,
 			  lang_dirent->d_name);
-#ifdef NO_LIBPERL
+#ifndef HAVE_LIBPERL_SUPPORT
 		if (strstr(lang_path, "perl"))
 			continue;
 #endif
-#ifdef NO_LIBPYTHON
+#ifndef HAVE_LIBPYTHON_SUPPORT
 		if (strstr(lang_path, "python"))
 			continue;
 #endif
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index f5c454855908..147a27e8c937 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1943,7 +1943,8 @@ static const struct option stat_options[] = {
 	OPT_STRING(0, "post", &post_cmd, "command",
 			"command to run after to the measured command"),
 	OPT_UINTEGER('I', "interval-print", &stat_config.interval,
-		    "print counts at regular interval in ms (>= 10)"),
+		    "print counts at regular interval in ms "
+		    "(overhead is possible for values <= 100ms)"),
 	OPT_INTEGER(0, "interval-count", &stat_config.times,
 		    "print counts for fixed number of times"),
 	OPT_UINTEGER(0, "timeout", &stat_config.timeout,
@@ -2923,17 +2924,6 @@ int cmd_stat(int argc, const char **argv)
 		}
 	}
 
-	if (interval && interval < 100) {
-		if (interval < 10) {
-			pr_err("print interval must be >= 10ms\n");
-			parse_options_usage(stat_usage, stat_options, "I", 1);
-			goto out;
-		} else
-			pr_warning("print interval < 100ms. "
-				   "The overhead percentage could be high in some cases. "
-				   "Please proceed with caution.\n");
-	}
-
 	if (stat_config.times && interval)
 		interval_count = true;
 	else if (stat_config.times && !interval) {
diff --git a/tools/perf/builtin-version.c b/tools/perf/builtin-version.c
index 2abe3910d6b6..50df168be326 100644
--- a/tools/perf/builtin-version.c
+++ b/tools/perf/builtin-version.c
@@ -60,7 +60,10 @@ static void library_status(void)
 	STATUS(HAVE_DWARF_GETLOCATIONS_SUPPORT, dwarf_getlocations);
 	STATUS(HAVE_GLIBC_SUPPORT, glibc);
 	STATUS(HAVE_GTK2_SUPPORT, gtk2);
+#ifndef HAVE_SYSCALL_TABLE_SUPPORT
 	STATUS(HAVE_LIBAUDIT_SUPPORT, libaudit);
+#endif
+	STATUS(HAVE_SYSCALL_TABLE_SUPPORT, syscall_table);
 	STATUS(HAVE_LIBBFD_SUPPORT, libbfd);
 	STATUS(HAVE_LIBELF_SUPPORT, libelf);
 	STATUS(HAVE_LIBNUMA_SUPPORT, libnuma);
diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index 1659029d03fc..20a08cb32332 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -73,7 +73,7 @@ static struct cmd_struct commands[] = {
 	{ "lock",	cmd_lock,	0 },
 	{ "kvm",	cmd_kvm,	0 },
 	{ "test",	cmd_test,	0 },
-#if defined(HAVE_LIBAUDIT_SUPPORT) || defined(HAVE_SYSCALL_TABLE)
+#if defined(HAVE_LIBAUDIT_SUPPORT) || defined(HAVE_SYSCALL_TABLE_SUPPORT)
 	{ "trace",	cmd_trace,	0 },
 #endif
 	{ "inject",	cmd_inject,	0 },
@@ -491,7 +491,7 @@ int main(int argc, const char **argv)
 		argv[0] = cmd;
 	}
 	if (strstarts(cmd, "trace")) {
-#if defined(HAVE_LIBAUDIT_SUPPORT) || defined(HAVE_SYSCALL_TABLE)
+#if defined(HAVE_LIBAUDIT_SUPPORT) || defined(HAVE_SYSCALL_TABLE_SUPPORT)
 		setup_path();
 		argv[0] = "trace";
 		return cmd_trace(argc, argv);
diff --git a/tools/perf/tests/bpf-script-example.c b/tools/perf/tests/bpf-script-example.c
index e4123c1b0e88..1ca5106df5f1 100644
--- a/tools/perf/tests/bpf-script-example.c
+++ b/tools/perf/tests/bpf-script-example.c
@@ -31,7 +31,7 @@ struct bpf_map_def SEC("maps") flip_table = {
 	.max_entries = 1,
 };
 
-SEC("func=SyS_epoll_pwait")
+SEC("func=do_epoll_wait")
 int bpf_func__SyS_epoll_pwait(void *ctx)
 {
 	int ind =0;
diff --git a/tools/perf/tests/bpf-script-test-kbuild.c b/tools/perf/tests/bpf-script-test-kbuild.c
index 3626924740d8..ff3ec8337f0a 100644
--- a/tools/perf/tests/bpf-script-test-kbuild.c
+++ b/tools/perf/tests/bpf-script-test-kbuild.c
@@ -9,7 +9,6 @@
 #define SEC(NAME) __attribute__((section(NAME), used))
 
 #include <uapi/linux/fs.h>
-#include <uapi/asm/ptrace.h>
 
 SEC("func=vfs_llseek")
 int bpf_func__vfs_llseek(void *ctx)
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 625f5a6772af..cac8f8889bc3 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -118,6 +118,7 @@ static struct test generic_tests[] = {
 	{
 		.desc = "Breakpoint accounting",
 		.func = test__bp_accounting,
+		.is_supported = test__bp_signal_is_supported,
 	},
 	{
 		.desc = "Number of exit events of a simple workload",
diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index bb8e6bcb0d96..0919b0793e5b 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -75,7 +75,7 @@ int test__basic_mmap(struct test *test __maybe_unused, int subtest __maybe_unuse
 		snprintf(name, sizeof(name), "sys_enter_%s", syscall_names[i]);
 		evsels[i] = perf_evsel__newtp("syscalls", name);
 		if (IS_ERR(evsels[i])) {
-			pr_debug("perf_evsel__new\n");
+			pr_debug("perf_evsel__new(%s)\n", name);
 			goto out_delete_evlist;
 		}
 
diff --git a/tools/perf/trace/beauty/mmap.c b/tools/perf/trace/beauty/mmap.c
index 417e3ecfe9d7..9f68077b241b 100644
--- a/tools/perf/trace/beauty/mmap.c
+++ b/tools/perf/trace/beauty/mmap.c
@@ -54,6 +54,9 @@ static size_t syscall_arg__scnprintf_mmap_flags(char *bf, size_t size,
 	P_MMAP_FLAG(EXECUTABLE);
 	P_MMAP_FLAG(FILE);
 	P_MMAP_FLAG(FIXED);
+#ifdef MAP_FIXED_NOREPLACE
+	P_MMAP_FLAG(FIXED_NOREPLACE);
+#endif
 	P_MMAP_FLAG(GROWSDOWN);
 	P_MMAP_FLAG(HUGETLB);
 	P_MMAP_FLAG(LOCKED);
diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 12c099a87f8b..3781d74088a7 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -692,6 +692,7 @@ static int annotate_browser__run(struct annotate_browser *browser,
 		"J             Toggle showing number of jump sources on targets\n"
 		"n             Search next string\n"
 		"o             Toggle disassembler output/simplified view\n"
+		"O             Bump offset level (jump targets -> +call -> all -> cycle thru)\n"
 		"s             Toggle source code view\n"
 		"t             Circulate percent, total period, samples view\n"
 		"/             Search string\n"
@@ -719,6 +720,10 @@ static int annotate_browser__run(struct annotate_browser *browser,
 			notes->options->use_offset = !notes->options->use_offset;
 			annotation__update_column_widths(notes);
 			continue;
+		case 'O':
+			if (++notes->options->offset_level > ANNOTATION__MAX_OFFSET_LEVEL)
+				notes->options->offset_level = ANNOTATION__MIN_OFFSET_LEVEL;
+			continue;
 		case 'j':
 			notes->options->jump_arrows = !notes->options->jump_arrows;
 			continue;
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 0eec06c105c6..e5f247247daa 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2714,7 +2714,7 @@ static int perf_evsel__hists_browse(struct perf_evsel *evsel, int nr_events,
 	"h/?/F1        Show this window\n"				\
 	"UP/DOWN/PGUP\n"						\
 	"PGDN/SPACE    Navigate\n"					\
-	"q/ESC/CTRL+C  Exit browser\n\n"				\
+	"q/ESC/CTRL+C  Exit browser or go back to previous screen\n\n"	\
 	"For multiple event sessions:\n\n"				\
 	"TAB/UNTAB     Switch events\n\n"				\
 	"For symbolic views (--sort has sym):\n\n"			\
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index fbad8dfbb186..536ee148bff8 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -46,6 +46,7 @@
 struct annotation_options annotation__default_options = {
 	.use_offset     = true,
 	.jump_arrows    = true,
+	.offset_level	= ANNOTATION__OFFSET_JUMP_TARGETS,
 };
 
 const char 	*disassembler_style;
@@ -2512,7 +2513,8 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
 		if (!notes->options->use_offset) {
 			printed = scnprintf(bf, sizeof(bf), "%" PRIx64 ": ", addr);
 		} else {
-			if (al->jump_sources) {
+			if (al->jump_sources &&
+			    notes->options->offset_level >= ANNOTATION__OFFSET_JUMP_TARGETS) {
 				if (notes->options->show_nr_jumps) {
 					int prev;
 					printed = scnprintf(bf, sizeof(bf), "%*d ",
@@ -2523,9 +2525,14 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
 					obj__printf(obj, bf);
 					obj__set_color(obj, prev);
 				}
-
+print_addr:
 				printed = scnprintf(bf, sizeof(bf), "%*" PRIx64 ": ",
 						    notes->widths.target, addr);
+			} else if (ins__is_call(&disasm_line(al)->ins) &&
+				   notes->options->offset_level >= ANNOTATION__OFFSET_CALL) {
+				goto print_addr;
+			} else if (notes->options->offset_level == ANNOTATION__MAX_OFFSET_LEVEL) {
+				goto print_addr;
 			} else {
 				printed = scnprintf(bf, sizeof(bf), "%-*s  ",
 						    notes->widths.addr, " ");
@@ -2642,10 +2649,11 @@ int __annotation__scnprintf_samples_period(struct annotation *notes,
  */
 static struct annotation_config {
 	const char *name;
-	bool *value;
+	void *value;
 } annotation__configs[] = {
 	ANNOTATION__CFG(hide_src_code),
 	ANNOTATION__CFG(jump_arrows),
+	ANNOTATION__CFG(offset_level),
 	ANNOTATION__CFG(show_linenr),
 	ANNOTATION__CFG(show_nr_jumps),
 	ANNOTATION__CFG(show_nr_samples),
@@ -2677,8 +2685,16 @@ static int annotation__config(const char *var, const char *value,
 
 	if (cfg == NULL)
 		pr_debug("%s variable unknown, ignoring...", var);
-	else
-		*cfg->value = perf_config_bool(name, value);
+	else if (strcmp(var, "annotate.offset_level") == 0) {
+		perf_config_int(cfg->value, name, value);
+
+		if (*(int *)cfg->value > ANNOTATION__MAX_OFFSET_LEVEL)
+			*(int *)cfg->value = ANNOTATION__MAX_OFFSET_LEVEL;
+		else if (*(int *)cfg->value < ANNOTATION__MIN_OFFSET_LEVEL)
+			*(int *)cfg->value = ANNOTATION__MIN_OFFSET_LEVEL;
+	} else {
+		*(bool *)cfg->value = perf_config_bool(name, value);
+	}
 	return 0;
 }
 
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index db8d09bea07e..f28a9e43421d 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -70,8 +70,17 @@ struct annotation_options {
 	     show_nr_jumps,
 	     show_nr_samples,
 	     show_total_period;
+	u8   offset_level;
 };
 
+enum {
+	ANNOTATION__OFFSET_JUMP_TARGETS = 1,
+	ANNOTATION__OFFSET_CALL,
+	ANNOTATION__MAX_OFFSET_LEVEL,
+};
+
+#define ANNOTATION__MIN_OFFSET_LEVEL ANNOTATION__OFFSET_JUMP_TARGETS
+
 extern struct annotation_options annotation__default_options;
 
 struct annotation;
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 640af88331b4..c8b98fa22997 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -1,6 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * SPDX-License-Identifier: GPL-2.0
- *
  * Copyright(C) 2015-2018 Linaro Limited.
  *
  * Author: Tor Jeremiassen <tor@ti.com>
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 1b0d422373be..40020b1ca54f 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1,6 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * SPDX-License-Identifier: GPL-2.0
- *
  * Copyright(C) 2015-2018 Linaro Limited.
  *
  * Author: Tor Jeremiassen <tor@ti.com>
diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
index 5864d5dca616..37f8d48179ca 100644
--- a/tools/perf/util/cs-etm.h
+++ b/tools/perf/util/cs-etm.h
@@ -1,18 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright(C) 2015 Linaro Limited. All rights reserved.
  * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef INCLUDE__UTIL_PERF_CS_ETM_H__
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index f0a6cbd033cc..98ff3a6a3d50 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -1421,7 +1421,9 @@ size_t perf_event__fprintf_itrace_start(union perf_event *event, FILE *fp)
 size_t perf_event__fprintf_switch(union perf_event *event, FILE *fp)
 {
 	bool out = event->header.misc & PERF_RECORD_MISC_SWITCH_OUT;
-	const char *in_out = out ? "OUT" : "IN ";
+	const char *in_out = !out ? "IN         " :
+		!(event->header.misc & PERF_RECORD_MISC_SWITCH_OUT_PREEMPT) ?
+				    "OUT        " : "OUT preempt";
 
 	if (event->header.type == PERF_RECORD_SWITCH)
 		return fprintf(fp, " %s\n", in_out);
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 1ac8d9236efd..3e87486c28fe 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2870,8 +2870,7 @@ int perf_evsel__open_strerror(struct perf_evsel *evsel, struct target *target,
 #if defined(__i386__) || defined(__x86_64__)
 		if (evsel->attr.type == PERF_TYPE_HARDWARE)
 			return scnprintf(msg, size, "%s",
-	"No hardware sampling interrupt available.\n"
-	"No APIC? If so then you can boot the kernel with the \"lapic\" boot parameter to force-enable it.");
+	"No hardware sampling interrupt available.\n");
 #endif
 		break;
 	case EBUSY:
@@ -2894,8 +2893,7 @@ int perf_evsel__open_strerror(struct perf_evsel *evsel, struct target *target,
 
 	return scnprintf(msg, size,
 	"The sys_perf_event_open() syscall returned with %d (%s) for event (%s).\n"
-	"/bin/dmesg may provide additional information.\n"
-	"No CONFIG_PERF_EVENTS=y kernel support configured?",
+	"/bin/dmesg | grep -i perf may provide additional information.\n",
 			 err, str_error_r(err, sbuf, sizeof(sbuf)),
 			 perf_evsel__name(evsel));
 }
diff --git a/tools/perf/util/generate-cmdlist.sh b/tools/perf/util/generate-cmdlist.sh
index ff17920a5ebc..c3cef36d4176 100755
--- a/tools/perf/util/generate-cmdlist.sh
+++ b/tools/perf/util/generate-cmdlist.sh
@@ -38,7 +38,7 @@ do
 done
 echo "#endif /* HAVE_LIBELF_SUPPORT */"
 
-echo "#if defined(HAVE_LIBAUDIT_SUPPORT) || defined(HAVE_SYSCALL_TABLE)"
+echo "#if defined(HAVE_LIBAUDIT_SUPPORT) || defined(HAVE_SYSCALL_TABLE_SUPPORT)"
 sed -n -e 's/^perf-\([^ 	]*\)[ 	].* audit*/\1/p' command-list.txt |
 sort |
 while read cmd
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 121df1683c36..a8bff2178fbc 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1320,7 +1320,8 @@ static int build_mem_topology(struct memory_node *nodes, u64 size, u64 *cntp)
 
 	dir = opendir(path);
 	if (!dir) {
-		pr_warning("failed: can't open node sysfs data\n");
+		pr_debug2("%s: could't read %s, does this arch have topology information?\n",
+			  __func__, path);
 		return -1;
 	}
 
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 064bdcb7bd78..61a5e5027338 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -562,6 +562,12 @@ static int is_pmu_core(const char *name)
 	if (stat(path, &st) == 0)
 		return 1;
 
+	/* Look for cpu sysfs (specific to s390) */
+	scnprintf(path, PATH_MAX, "%s/bus/event_source/devices/%s",
+		  sysfs, name);
+	if (stat(path, &st) == 0 && !strncmp(name, "cpum_", 5))
+		return 1;
+
 	return 0;
 }
 
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 62b2dd2253eb..1466814ebada 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -2091,16 +2091,14 @@ static bool symbol__read_kptr_restrict(void)
 
 int symbol__annotation_init(void)
 {
+	if (symbol_conf.init_annotation)
+		return 0;
+
 	if (symbol_conf.initialized) {
 		pr_err("Annotation needs to be init before symbol__init()\n");
 		return -1;
 	}
 
-	if (symbol_conf.init_annotation) {
-		pr_warning("Annotation being initialized multiple times\n");
-		return 0;
-	}
-
 	symbol_conf.priv_size += sizeof(struct annotation);
 	symbol_conf.init_annotation = true;
 	return 0;
diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
index 895122d638dd..0ee7f568d60c 100644
--- a/tools/perf/util/syscalltbl.c
+++ b/tools/perf/util/syscalltbl.c
@@ -17,7 +17,7 @@
 #include <stdlib.h>
 #include <linux/compiler.h>
 
-#ifdef HAVE_SYSCALL_TABLE
+#ifdef HAVE_SYSCALL_TABLE_SUPPORT
 #include <string.h>
 #include "string2.h"
 #include "util.h"
@@ -139,7 +139,7 @@ int syscalltbl__strglobmatch_first(struct syscalltbl *tbl, const char *syscall_g
 	return syscalltbl__strglobmatch_next(tbl, syscall_glob, idx);
 }
 
-#else /* HAVE_SYSCALL_TABLE */
+#else /* HAVE_SYSCALL_TABLE_SUPPORT */
 
 #include <libaudit.h>
 
@@ -176,4 +176,4 @@ int syscalltbl__strglobmatch_first(struct syscalltbl *tbl, const char *syscall_g
 {
 	return syscalltbl__strglobmatch_next(tbl, syscall_glob, idx);
 }
-#endif /* HAVE_SYSCALL_TABLE */
+#endif /* HAVE_SYSCALL_TABLE_SUPPORT */
diff --git a/tools/perf/util/trace-event-scripting.c b/tools/perf/util/trace-event-scripting.c
index 0ac9077f62a2..b1e5c3a2b8e3 100644
--- a/tools/perf/util/trace-event-scripting.c
+++ b/tools/perf/util/trace-event-scripting.c
@@ -98,7 +98,7 @@ static void register_python_scripting(struct scripting_ops *scripting_ops)
 	}
 }
 
-#ifdef NO_LIBPYTHON
+#ifndef HAVE_LIBPYTHON_SUPPORT
 void setup_python_scripting(void)
 {
 	register_python_scripting(&python_scripting_unsupported_ops);
@@ -161,7 +161,7 @@ static void register_perl_scripting(struct scripting_ops *scripting_ops)
 	}
 }
 
-#ifdef NO_LIBPERL
+#ifndef HAVE_LIBPERL_SUPPORT
 void setup_perl_scripting(void)
 {
 	register_perl_scripting(&perl_scripting_unsupported_ops);
--8323329-825384187-1524394107=:6136--
