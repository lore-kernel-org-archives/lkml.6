Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751534AbeBRRhL (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 12:37:11 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:58432 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751442AbeBRRhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 12:37:08 -0500
Date: Sun, 18 Feb 2018 18:37:16 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] perf updates for 4.16
Message-ID: <alpine.DEB.2.21.1802181833290.1549@nanos.tec.linutronix.de>
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

Perf and kprobes updates:

  - perf_mmap overwrite mode fixes/overhaul, prep work to get 'perf top'
    using it, making it bearable to use it in large core count systems such
    as Knights Landing/Mill Intel systems (Kan Liang)
    
  - s/390 now uses syscall.tbl, just like x86-64 to generate the syscall
    table id -> string tables used by 'perf trace' (Hendrik Brueckner)
    
  - Use strtoull() instead of home grown function (Andy Shevchenko)
    
  - Synchronize kernel ABI headers, v4.16-rc1 (Ingo Molnar)
    
  - Document missing 'perf data --force' option (Sangwon Hong)
    
  - Add perf vendor JSON metrics for ARM Cortex-A53 Processor (William Cohen)

  - Improve error handling and error propagation of ftrace based kprobes so
    failures when installing kprobes are not silently ignored and create
    disfunctional tracepoints.

Thanks,

	tglx

------------------>
Andy Shevchenko (1):
      perf tools: Substitute yet another strtoull()

Arnaldo Carvalho de Melo (1):
      perf evsel: Expose the perf_missing_features struct

Hendrik Brueckner (3):
      perf s390: Grab a copy of arch/s390/kernel/syscall/syscall.tbl
      perf s390: Rework system call table creation by using syscall.tbl
      Revert "tools include s390: Grab a copy of arch/s390/include/uapi/asm/unistd.h"

Ingo Molnar (1):
      tools/headers: Synchronize kernel ABI headers, v4.16-rc1

Jessica Yu (2):
      kprobes: Propagate error from arm_kprobe_ftrace()
      kprobes: Propagate error from disarm_kprobe_ftrace()

Kan Liang (16):
      perf evlist: Remove stale mmap read for backward
      perf mmap: Recalculate size for overwrite mode
      perf mmap: Cleanup perf_mmap__push()
      perf mmap: Introduce perf_mmap__read_init()
      perf mmap: Add new return value logic for perf_mmap__read_init()
      perf mmap: Discard 'prev' in perf_mmap__read()
      perf mmap: Introduce perf_mmap__read_done()
      perf mmap: Introduce perf_mmap__read_event()
      perf test: Update mmap read functions for backward-ring-buffer test
      perf mmap: Discard legacy interface for mmap read
      perf top: Check per-event overwrite term
      perf top: Add overwrite fall back
      perf hists browser: Add parameter to disable lost event warning
      perf top: Remove lost events checking
      perf top: Switch default mode to overwrite mode
      perf top: Check the latency of perf_top__mmap_read()

Sangwon Hong (1):
      perf data: Document missing --force option

Thomas Richter (1):
      perf test: Fix test trace+probe_libc_inet_pton.sh for s390x

William Cohen (1):
      perf vendor events aarch64: Add JSON metrics for ARM Cortex-A53 Processor


 kernel/kprobes.c                                   | 178 ++++++---
 tools/arch/powerpc/include/uapi/asm/kvm.h          |   2 +
 tools/arch/s390/include/uapi/asm/unistd.h          | 412 ---------------------
 tools/arch/x86/include/asm/cpufeatures.h           |   1 +
 tools/include/uapi/drm/i915_drm.h                  |  77 ++++
 tools/include/uapi/linux/if_link.h                 |   1 +
 tools/include/uapi/linux/kvm.h                     |  90 +++++
 tools/perf/Documentation/perf-data.txt             |   4 +
 tools/perf/arch/s390/Makefile                      |  10 +-
 tools/perf/arch/s390/entry/syscalls/mksyscalltbl   |  18 +-
 tools/perf/arch/s390/entry/syscalls/syscall.tbl    | 390 +++++++++++++++++++
 tools/perf/builtin-c2c.c                           |   4 +-
 tools/perf/builtin-report.c                        |   3 +-
 tools/perf/builtin-top.c                           | 150 +++++++-
 tools/perf/check-headers.sh                        |   1 -
 .../pmu-events/arch/arm64/cortex-a53/branch.json   |  27 ++
 .../perf/pmu-events/arch/arm64/cortex-a53/bus.json |  22 ++
 .../pmu-events/arch/arm64/cortex-a53/cache.json    |  27 ++
 .../pmu-events/arch/arm64/cortex-a53/memory.json   |  22 ++
 .../pmu-events/arch/arm64/cortex-a53/other.json    |  32 ++
 .../pmu-events/arch/arm64/cortex-a53/pipeline.json |  52 +++
 tools/perf/pmu-events/arch/arm64/mapfile.csv       |   1 +
 tools/perf/tests/backward-ring-buffer.c            |   7 +-
 .../perf/tests/shell/trace+probe_libc_inet_pton.sh |  23 +-
 tools/perf/ui/browsers/hists.c                     |  38 +-
 tools/perf/ui/browsers/hists.h                     |   3 +-
 tools/perf/util/evlist.c                           |  17 -
 tools/perf/util/evlist.h                           |   4 -
 tools/perf/util/evsel.c                            |  12 +-
 tools/perf/util/evsel.h                            |  14 +
 tools/perf/util/hist.h                             |   6 +-
 tools/perf/util/mmap.c                             | 141 ++++---
 tools/perf/util/mmap.h                             |  10 +-
 tools/perf/util/util.c                             |  24 +-
 34 files changed, 1195 insertions(+), 628 deletions(-)
 delete mode 100644 tools/arch/s390/include/uapi/asm/unistd.h
 create mode 100644 tools/perf/arch/s390/entry/syscalls/syscall.tbl
 create mode 100644 tools/perf/pmu-events/arch/arm64/cortex-a53/branch.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/cortex-a53/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/cortex-a53/cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/cortex-a53/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/cortex-a53/other.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/cortex-a53/pipeline.json

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index da2ccf142358..102160ff5c66 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -978,67 +978,90 @@ static int prepare_kprobe(struct kprobe *p)
 }
 
 /* Caller must lock kprobe_mutex */
-static void arm_kprobe_ftrace(struct kprobe *p)
+static int arm_kprobe_ftrace(struct kprobe *p)
 {
-	int ret;
+	int ret = 0;
 
 	ret = ftrace_set_filter_ip(&kprobe_ftrace_ops,
 				   (unsigned long)p->addr, 0, 0);
-	WARN(ret < 0, "Failed to arm kprobe-ftrace at %p (%d)\n", p->addr, ret);
-	kprobe_ftrace_enabled++;
-	if (kprobe_ftrace_enabled == 1) {
+	if (ret) {
+		pr_debug("Failed to arm kprobe-ftrace at %p (%d)\n", p->addr, ret);
+		return ret;
+	}
+
+	if (kprobe_ftrace_enabled == 0) {
 		ret = register_ftrace_function(&kprobe_ftrace_ops);
-		WARN(ret < 0, "Failed to init kprobe-ftrace (%d)\n", ret);
+		if (ret) {
+			pr_debug("Failed to init kprobe-ftrace (%d)\n", ret);
+			goto err_ftrace;
+		}
 	}
+
+	kprobe_ftrace_enabled++;
+	return ret;
+
+err_ftrace:
+	/*
+	 * Note: Since kprobe_ftrace_ops has IPMODIFY set, and ftrace requires a
+	 * non-empty filter_hash for IPMODIFY ops, we're safe from an accidental
+	 * empty filter_hash which would undesirably trace all functions.
+	 */
+	ftrace_set_filter_ip(&kprobe_ftrace_ops, (unsigned long)p->addr, 1, 0);
+	return ret;
 }
 
 /* Caller must lock kprobe_mutex */
-static void disarm_kprobe_ftrace(struct kprobe *p)
+static int disarm_kprobe_ftrace(struct kprobe *p)
 {
-	int ret;
+	int ret = 0;
 
-	kprobe_ftrace_enabled--;
-	if (kprobe_ftrace_enabled == 0) {
+	if (kprobe_ftrace_enabled == 1) {
 		ret = unregister_ftrace_function(&kprobe_ftrace_ops);
-		WARN(ret < 0, "Failed to init kprobe-ftrace (%d)\n", ret);
+		if (WARN(ret < 0, "Failed to unregister kprobe-ftrace (%d)\n", ret))
+			return ret;
 	}
+
+	kprobe_ftrace_enabled--;
+
 	ret = ftrace_set_filter_ip(&kprobe_ftrace_ops,
 			   (unsigned long)p->addr, 1, 0);
 	WARN(ret < 0, "Failed to disarm kprobe-ftrace at %p (%d)\n", p->addr, ret);
+	return ret;
 }
 #else	/* !CONFIG_KPROBES_ON_FTRACE */
 #define prepare_kprobe(p)	arch_prepare_kprobe(p)
-#define arm_kprobe_ftrace(p)	do {} while (0)
-#define disarm_kprobe_ftrace(p)	do {} while (0)
+#define arm_kprobe_ftrace(p)	(-ENODEV)
+#define disarm_kprobe_ftrace(p)	(-ENODEV)
 #endif
 
 /* Arm a kprobe with text_mutex */
-static void arm_kprobe(struct kprobe *kp)
+static int arm_kprobe(struct kprobe *kp)
 {
-	if (unlikely(kprobe_ftrace(kp))) {
-		arm_kprobe_ftrace(kp);
-		return;
-	}
+	if (unlikely(kprobe_ftrace(kp)))
+		return arm_kprobe_ftrace(kp);
+
 	cpus_read_lock();
 	mutex_lock(&text_mutex);
 	__arm_kprobe(kp);
 	mutex_unlock(&text_mutex);
 	cpus_read_unlock();
+
+	return 0;
 }
 
 /* Disarm a kprobe with text_mutex */
-static void disarm_kprobe(struct kprobe *kp, bool reopt)
+static int disarm_kprobe(struct kprobe *kp, bool reopt)
 {
-	if (unlikely(kprobe_ftrace(kp))) {
-		disarm_kprobe_ftrace(kp);
-		return;
-	}
+	if (unlikely(kprobe_ftrace(kp)))
+		return disarm_kprobe_ftrace(kp);
 
 	cpus_read_lock();
 	mutex_lock(&text_mutex);
 	__disarm_kprobe(kp, reopt);
 	mutex_unlock(&text_mutex);
 	cpus_read_unlock();
+
+	return 0;
 }
 
 /*
@@ -1362,9 +1385,15 @@ static int register_aggr_kprobe(struct kprobe *orig_p, struct kprobe *p)
 
 	if (ret == 0 && kprobe_disabled(ap) && !kprobe_disabled(p)) {
 		ap->flags &= ~KPROBE_FLAG_DISABLED;
-		if (!kprobes_all_disarmed)
+		if (!kprobes_all_disarmed) {
 			/* Arm the breakpoint again. */
-			arm_kprobe(ap);
+			ret = arm_kprobe(ap);
+			if (ret) {
+				ap->flags |= KPROBE_FLAG_DISABLED;
+				list_del_rcu(&p->list);
+				synchronize_sched();
+			}
+		}
 	}
 	return ret;
 }
@@ -1573,8 +1602,14 @@ int register_kprobe(struct kprobe *p)
 	hlist_add_head_rcu(&p->hlist,
 		       &kprobe_table[hash_ptr(p->addr, KPROBE_HASH_BITS)]);
 
-	if (!kprobes_all_disarmed && !kprobe_disabled(p))
-		arm_kprobe(p);
+	if (!kprobes_all_disarmed && !kprobe_disabled(p)) {
+		ret = arm_kprobe(p);
+		if (ret) {
+			hlist_del_rcu(&p->hlist);
+			synchronize_sched();
+			goto out;
+		}
+	}
 
 	/* Try to optimize kprobe */
 	try_to_optimize_kprobe(p);
@@ -1608,11 +1643,12 @@ static int aggr_kprobe_disabled(struct kprobe *ap)
 static struct kprobe *__disable_kprobe(struct kprobe *p)
 {
 	struct kprobe *orig_p;
+	int ret;
 
 	/* Get an original kprobe for return */
 	orig_p = __get_valid_kprobe(p);
 	if (unlikely(orig_p == NULL))
-		return NULL;
+		return ERR_PTR(-EINVAL);
 
 	if (!kprobe_disabled(p)) {
 		/* Disable probe if it is a child probe */
@@ -1626,8 +1662,13 @@ static struct kprobe *__disable_kprobe(struct kprobe *p)
 			 * should have already been disarmed, so
 			 * skip unneed disarming process.
 			 */
-			if (!kprobes_all_disarmed)
-				disarm_kprobe(orig_p, true);
+			if (!kprobes_all_disarmed) {
+				ret = disarm_kprobe(orig_p, true);
+				if (ret) {
+					p->flags &= ~KPROBE_FLAG_DISABLED;
+					return ERR_PTR(ret);
+				}
+			}
 			orig_p->flags |= KPROBE_FLAG_DISABLED;
 		}
 	}
@@ -1644,8 +1685,8 @@ static int __unregister_kprobe_top(struct kprobe *p)
 
 	/* Disable kprobe. This will disarm it if needed. */
 	ap = __disable_kprobe(p);
-	if (ap == NULL)
-		return -EINVAL;
+	if (IS_ERR(ap))
+		return PTR_ERR(ap);
 
 	if (ap == p)
 		/*
@@ -2078,12 +2119,14 @@ static void kill_kprobe(struct kprobe *p)
 int disable_kprobe(struct kprobe *kp)
 {
 	int ret = 0;
+	struct kprobe *p;
 
 	mutex_lock(&kprobe_mutex);
 
 	/* Disable this kprobe */
-	if (__disable_kprobe(kp) == NULL)
-		ret = -EINVAL;
+	p = __disable_kprobe(kp);
+	if (IS_ERR(p))
+		ret = PTR_ERR(p);
 
 	mutex_unlock(&kprobe_mutex);
 	return ret;
@@ -2116,7 +2159,9 @@ int enable_kprobe(struct kprobe *kp)
 
 	if (!kprobes_all_disarmed && kprobe_disabled(p)) {
 		p->flags &= ~KPROBE_FLAG_DISABLED;
-		arm_kprobe(p);
+		ret = arm_kprobe(p);
+		if (ret)
+			p->flags |= KPROBE_FLAG_DISABLED;
 	}
 out:
 	mutex_unlock(&kprobe_mutex);
@@ -2407,11 +2452,12 @@ static const struct file_operations debugfs_kprobe_blacklist_ops = {
 	.release        = seq_release,
 };
 
-static void arm_all_kprobes(void)
+static int arm_all_kprobes(void)
 {
 	struct hlist_head *head;
 	struct kprobe *p;
-	unsigned int i;
+	unsigned int i, total = 0, errors = 0;
+	int err, ret = 0;
 
 	mutex_lock(&kprobe_mutex);
 
@@ -2428,46 +2474,74 @@ static void arm_all_kprobes(void)
 	/* Arming kprobes doesn't optimize kprobe itself */
 	for (i = 0; i < KPROBE_TABLE_SIZE; i++) {
 		head = &kprobe_table[i];
-		hlist_for_each_entry_rcu(p, head, hlist)
-			if (!kprobe_disabled(p))
-				arm_kprobe(p);
+		/* Arm all kprobes on a best-effort basis */
+		hlist_for_each_entry_rcu(p, head, hlist) {
+			if (!kprobe_disabled(p)) {
+				err = arm_kprobe(p);
+				if (err)  {
+					errors++;
+					ret = err;
+				}
+				total++;
+			}
+		}
 	}
 
-	printk(KERN_INFO "Kprobes globally enabled\n");
+	if (errors)
+		pr_warn("Kprobes globally enabled, but failed to arm %d out of %d probes\n",
+			errors, total);
+	else
+		pr_info("Kprobes globally enabled\n");
 
 already_enabled:
 	mutex_unlock(&kprobe_mutex);
-	return;
+	return ret;
 }
 
-static void disarm_all_kprobes(void)
+static int disarm_all_kprobes(void)
 {
 	struct hlist_head *head;
 	struct kprobe *p;
-	unsigned int i;
+	unsigned int i, total = 0, errors = 0;
+	int err, ret = 0;
 
 	mutex_lock(&kprobe_mutex);
 
 	/* If kprobes are already disarmed, just return */
 	if (kprobes_all_disarmed) {
 		mutex_unlock(&kprobe_mutex);
-		return;
+		return 0;
 	}
 
 	kprobes_all_disarmed = true;
-	printk(KERN_INFO "Kprobes globally disabled\n");
 
 	for (i = 0; i < KPROBE_TABLE_SIZE; i++) {
 		head = &kprobe_table[i];
+		/* Disarm all kprobes on a best-effort basis */
 		hlist_for_each_entry_rcu(p, head, hlist) {
-			if (!arch_trampoline_kprobe(p) && !kprobe_disabled(p))
-				disarm_kprobe(p, false);
+			if (!arch_trampoline_kprobe(p) && !kprobe_disabled(p)) {
+				err = disarm_kprobe(p, false);
+				if (err) {
+					errors++;
+					ret = err;
+				}
+				total++;
+			}
 		}
 	}
+
+	if (errors)
+		pr_warn("Kprobes globally disabled, but failed to disarm %d out of %d probes\n",
+			errors, total);
+	else
+		pr_info("Kprobes globally disabled\n");
+
 	mutex_unlock(&kprobe_mutex);
 
 	/* Wait for disarming all kprobes by optimizer */
 	wait_for_kprobe_optimizer();
+
+	return ret;
 }
 
 /*
@@ -2494,6 +2568,7 @@ static ssize_t write_enabled_file_bool(struct file *file,
 {
 	char buf[32];
 	size_t buf_size;
+	int ret = 0;
 
 	buf_size = min(count, (sizeof(buf)-1));
 	if (copy_from_user(buf, user_buf, buf_size))
@@ -2504,17 +2579,20 @@ static ssize_t write_enabled_file_bool(struct file *file,
 	case 'y':
 	case 'Y':
 	case '1':
-		arm_all_kprobes();
+		ret = arm_all_kprobes();
 		break;
 	case 'n':
 	case 'N':
 	case '0':
-		disarm_all_kprobes();
+		ret = disarm_all_kprobes();
 		break;
 	default:
 		return -EINVAL;
 	}
 
+	if (ret)
+		return ret;
+
 	return count;
 }
 
diff --git a/tools/arch/powerpc/include/uapi/asm/kvm.h b/tools/arch/powerpc/include/uapi/asm/kvm.h
index 637b7263cb86..833ed9a16adf 100644
--- a/tools/arch/powerpc/include/uapi/asm/kvm.h
+++ b/tools/arch/powerpc/include/uapi/asm/kvm.h
@@ -632,6 +632,8 @@ struct kvm_ppc_cpu_char {
 #define KVM_REG_PPC_TIDR	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xbc)
 #define KVM_REG_PPC_PSSCR	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xbd)
 
+#define KVM_REG_PPC_DEC_EXPIRY	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xbe)
+
 /* Transactional Memory checkpointed state:
  * This is all GPRs, all VSX regs and a subset of SPRs
  */
diff --git a/tools/arch/s390/include/uapi/asm/unistd.h b/tools/arch/s390/include/uapi/asm/unistd.h
deleted file mode 100644
index 725120939051..000000000000
--- a/tools/arch/s390/include/uapi/asm/unistd.h
+++ /dev/null
@@ -1,412 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-/*
- *  S390 version
- *
- *  Derived from "include/asm-i386/unistd.h"
- */
-
-#ifndef _UAPI_ASM_S390_UNISTD_H_
-#define _UAPI_ASM_S390_UNISTD_H_
-
-/*
- * This file contains the system call numbers.
- */
-
-#define __NR_exit                 1
-#define __NR_fork                 2
-#define __NR_read                 3
-#define __NR_write                4
-#define __NR_open                 5
-#define __NR_close                6
-#define __NR_restart_syscall	  7
-#define __NR_creat                8
-#define __NR_link                 9
-#define __NR_unlink              10
-#define __NR_execve              11
-#define __NR_chdir               12
-#define __NR_mknod               14
-#define __NR_chmod               15
-#define __NR_lseek               19
-#define __NR_getpid              20
-#define __NR_mount               21
-#define __NR_umount              22
-#define __NR_ptrace              26
-#define __NR_alarm               27
-#define __NR_pause               29
-#define __NR_utime               30
-#define __NR_access              33
-#define __NR_nice                34
-#define __NR_sync                36
-#define __NR_kill                37
-#define __NR_rename              38
-#define __NR_mkdir               39
-#define __NR_rmdir               40
-#define __NR_dup                 41
-#define __NR_pipe                42
-#define __NR_times               43
-#define __NR_brk                 45
-#define __NR_signal              48
-#define __NR_acct                51
-#define __NR_umount2             52
-#define __NR_ioctl               54
-#define __NR_fcntl               55
-#define __NR_setpgid             57
-#define __NR_umask               60
-#define __NR_chroot              61
-#define __NR_ustat               62
-#define __NR_dup2                63
-#define __NR_getppid             64
-#define __NR_getpgrp             65
-#define __NR_setsid              66
-#define __NR_sigaction           67
-#define __NR_sigsuspend          72
-#define __NR_sigpending          73
-#define __NR_sethostname         74
-#define __NR_setrlimit           75
-#define __NR_getrusage           77
-#define __NR_gettimeofday        78
-#define __NR_settimeofday        79
-#define __NR_symlink             83
-#define __NR_readlink            85
-#define __NR_uselib              86
-#define __NR_swapon              87
-#define __NR_reboot              88
-#define __NR_readdir             89
-#define __NR_mmap                90
-#define __NR_munmap              91
-#define __NR_truncate            92
-#define __NR_ftruncate           93
-#define __NR_fchmod              94
-#define __NR_getpriority         96
-#define __NR_setpriority         97
-#define __NR_statfs              99
-#define __NR_fstatfs            100
-#define __NR_socketcall         102
-#define __NR_syslog             103
-#define __NR_setitimer          104
-#define __NR_getitimer          105
-#define __NR_stat               106
-#define __NR_lstat              107
-#define __NR_fstat              108
-#define __NR_lookup_dcookie     110
-#define __NR_vhangup            111
-#define __NR_idle               112
-#define __NR_wait4              114
-#define __NR_swapoff            115
-#define __NR_sysinfo            116
-#define __NR_ipc                117
-#define __NR_fsync              118
-#define __NR_sigreturn          119
-#define __NR_clone              120
-#define __NR_setdomainname      121
-#define __NR_uname              122
-#define __NR_adjtimex           124
-#define __NR_mprotect           125
-#define __NR_sigprocmask        126
-#define __NR_create_module      127
-#define __NR_init_module        128
-#define __NR_delete_module      129
-#define __NR_get_kernel_syms    130
-#define __NR_quotactl           131
-#define __NR_getpgid            132
-#define __NR_fchdir             133
-#define __NR_bdflush            134
-#define __NR_sysfs              135
-#define __NR_personality        136
-#define __NR_afs_syscall        137 /* Syscall for Andrew File System */
-#define __NR_getdents           141
-#define __NR_flock              143
-#define __NR_msync              144
-#define __NR_readv              145
-#define __NR_writev             146
-#define __NR_getsid             147
-#define __NR_fdatasync          148
-#define __NR__sysctl            149
-#define __NR_mlock              150
-#define __NR_munlock            151
-#define __NR_mlockall           152
-#define __NR_munlockall         153
-#define __NR_sched_setparam             154
-#define __NR_sched_getparam             155
-#define __NR_sched_setscheduler         156
-#define __NR_sched_getscheduler         157
-#define __NR_sched_yield                158
-#define __NR_sched_get_priority_max     159
-#define __NR_sched_get_priority_min     160
-#define __NR_sched_rr_get_interval      161
-#define __NR_nanosleep          162
-#define __NR_mremap             163
-#define __NR_query_module       167
-#define __NR_poll               168
-#define __NR_nfsservctl         169
-#define __NR_prctl              172
-#define __NR_rt_sigreturn       173
-#define __NR_rt_sigaction       174
-#define __NR_rt_sigprocmask     175
-#define __NR_rt_sigpending      176
-#define __NR_rt_sigtimedwait    177
-#define __NR_rt_sigqueueinfo    178
-#define __NR_rt_sigsuspend      179
-#define __NR_pread64            180
-#define __NR_pwrite64           181
-#define __NR_getcwd             183
-#define __NR_capget             184
-#define __NR_capset             185
-#define __NR_sigaltstack        186
-#define __NR_sendfile           187
-#define __NR_getpmsg		188
-#define __NR_putpmsg		189
-#define __NR_vfork		190
-#define __NR_pivot_root         217
-#define __NR_mincore            218
-#define __NR_madvise            219
-#define __NR_getdents64		220
-#define __NR_readahead		222
-#define __NR_setxattr		224
-#define __NR_lsetxattr		225
-#define __NR_fsetxattr		226
-#define __NR_getxattr		227
-#define __NR_lgetxattr		228
-#define __NR_fgetxattr		229
-#define __NR_listxattr		230
-#define __NR_llistxattr		231
-#define __NR_flistxattr		232
-#define __NR_removexattr	233
-#define __NR_lremovexattr	234
-#define __NR_fremovexattr	235
-#define __NR_gettid		236
-#define __NR_tkill		237
-#define __NR_futex		238
-#define __NR_sched_setaffinity	239
-#define __NR_sched_getaffinity	240
-#define __NR_tgkill		241
-/* Number 242 is reserved for tux */
-#define __NR_io_setup		243
-#define __NR_io_destroy		244
-#define __NR_io_getevents	245
-#define __NR_io_submit		246
-#define __NR_io_cancel		247
-#define __NR_exit_group		248
-#define __NR_epoll_create	249
-#define __NR_epoll_ctl		250
-#define __NR_epoll_wait		251
-#define __NR_set_tid_address	252
-#define __NR_fadvise64		253
-#define __NR_timer_create	254
-#define __NR_timer_settime	255
-#define __NR_timer_gettime	256
-#define __NR_timer_getoverrun	257
-#define __NR_timer_delete	258
-#define __NR_clock_settime	259
-#define __NR_clock_gettime	260
-#define __NR_clock_getres	261
-#define __NR_clock_nanosleep	262
-/* Number 263 is reserved for vserver */
-#define __NR_statfs64		265
-#define __NR_fstatfs64		266
-#define __NR_remap_file_pages	267
-#define __NR_mbind		268
-#define __NR_get_mempolicy	269
-#define __NR_set_mempolicy	270
-#define __NR_mq_open		271
-#define __NR_mq_unlink		272
-#define __NR_mq_timedsend	273
-#define __NR_mq_timedreceive	274
-#define __NR_mq_notify		275
-#define __NR_mq_getsetattr	276
-#define __NR_kexec_load		277
-#define __NR_add_key		278
-#define __NR_request_key	279
-#define __NR_keyctl		280
-#define __NR_waitid		281
-#define __NR_ioprio_set		282
-#define __NR_ioprio_get		283
-#define __NR_inotify_init	284
-#define __NR_inotify_add_watch	285
-#define __NR_inotify_rm_watch	286
-#define __NR_migrate_pages	287
-#define __NR_openat		288
-#define __NR_mkdirat		289
-#define __NR_mknodat		290
-#define __NR_fchownat		291
-#define __NR_futimesat		292
-#define __NR_unlinkat		294
-#define __NR_renameat		295
-#define __NR_linkat		296
-#define __NR_symlinkat		297
-#define __NR_readlinkat		298
-#define __NR_fchmodat		299
-#define __NR_faccessat		300
-#define __NR_pselect6		301
-#define __NR_ppoll		302
-#define __NR_unshare		303
-#define __NR_set_robust_list	304
-#define __NR_get_robust_list	305
-#define __NR_splice		306
-#define __NR_sync_file_range	307
-#define __NR_tee		308
-#define __NR_vmsplice		309
-#define __NR_move_pages		310
-#define __NR_getcpu		311
-#define __NR_epoll_pwait	312
-#define __NR_utimes		313
-#define __NR_fallocate		314
-#define __NR_utimensat		315
-#define __NR_signalfd		316
-#define __NR_timerfd		317
-#define __NR_eventfd		318
-#define __NR_timerfd_create	319
-#define __NR_timerfd_settime	320
-#define __NR_timerfd_gettime	321
-#define __NR_signalfd4		322
-#define __NR_eventfd2		323
-#define __NR_inotify_init1	324
-#define __NR_pipe2		325
-#define __NR_dup3		326
-#define __NR_epoll_create1	327
-#define	__NR_preadv		328
-#define	__NR_pwritev		329
-#define __NR_rt_tgsigqueueinfo	330
-#define __NR_perf_event_open	331
-#define __NR_fanotify_init	332
-#define __NR_fanotify_mark	333
-#define __NR_prlimit64		334
-#define __NR_name_to_handle_at	335
-#define __NR_open_by_handle_at	336
-#define __NR_clock_adjtime	337
-#define __NR_syncfs		338
-#define __NR_setns		339
-#define __NR_process_vm_readv	340
-#define __NR_process_vm_writev	341
-#define __NR_s390_runtime_instr 342
-#define __NR_kcmp		343
-#define __NR_finit_module	344
-#define __NR_sched_setattr	345
-#define __NR_sched_getattr	346
-#define __NR_renameat2		347
-#define __NR_seccomp		348
-#define __NR_getrandom		349
-#define __NR_memfd_create	350
-#define __NR_bpf		351
-#define __NR_s390_pci_mmio_write	352
-#define __NR_s390_pci_mmio_read		353
-#define __NR_execveat		354
-#define __NR_userfaultfd	355
-#define __NR_membarrier		356
-#define __NR_recvmmsg		357
-#define __NR_sendmmsg		358
-#define __NR_socket		359
-#define __NR_socketpair		360
-#define __NR_bind		361
-#define __NR_connect		362
-#define __NR_listen		363
-#define __NR_accept4		364
-#define __NR_getsockopt		365
-#define __NR_setsockopt		366
-#define __NR_getsockname	367
-#define __NR_getpeername	368
-#define __NR_sendto		369
-#define __NR_sendmsg		370
-#define __NR_recvfrom		371
-#define __NR_recvmsg		372
-#define __NR_shutdown		373
-#define __NR_mlock2		374
-#define __NR_copy_file_range	375
-#define __NR_preadv2		376
-#define __NR_pwritev2		377
-#define __NR_s390_guarded_storage	378
-#define __NR_statx		379
-#define __NR_s390_sthyi		380
-#define NR_syscalls 381
-
-/* 
- * There are some system calls that are not present on 64 bit, some
- * have a different name although they do the same (e.g. __NR_chown32
- * is __NR_chown on 64 bit).
- */
-#ifndef __s390x__
-
-#define __NR_time		 13
-#define __NR_lchown		 16
-#define __NR_setuid		 23
-#define __NR_getuid		 24
-#define __NR_stime		 25
-#define __NR_setgid		 46
-#define __NR_getgid		 47
-#define __NR_geteuid		 49
-#define __NR_getegid		 50
-#define __NR_setreuid		 70
-#define __NR_setregid		 71
-#define __NR_getrlimit		 76
-#define __NR_getgroups		 80
-#define __NR_setgroups		 81
-#define __NR_fchown		 95
-#define __NR_ioperm		101
-#define __NR_setfsuid		138
-#define __NR_setfsgid		139
-#define __NR__llseek		140
-#define __NR__newselect 	142
-#define __NR_setresuid		164
-#define __NR_getresuid		165
-#define __NR_setresgid		170
-#define __NR_getresgid		171
-#define __NR_chown		182
-#define __NR_ugetrlimit		191	/* SuS compliant getrlimit */
-#define __NR_mmap2		192
-#define __NR_truncate64		193
-#define __NR_ftruncate64	194
-#define __NR_stat64		195
-#define __NR_lstat64		196
-#define __NR_fstat64		197
-#define __NR_lchown32		198
-#define __NR_getuid32		199
-#define __NR_getgid32		200
-#define __NR_geteuid32		201
-#define __NR_getegid32		202
-#define __NR_setreuid32		203
-#define __NR_setregid32		204
-#define __NR_getgroups32	205
-#define __NR_setgroups32	206
-#define __NR_fchown32		207
-#define __NR_setresuid32	208
-#define __NR_getresuid32	209
-#define __NR_setresgid32	210
-#define __NR_getresgid32	211
-#define __NR_chown32		212
-#define __NR_setuid32		213
-#define __NR_setgid32		214
-#define __NR_setfsuid32		215
-#define __NR_setfsgid32		216
-#define __NR_fcntl64		221
-#define __NR_sendfile64		223
-#define __NR_fadvise64_64	264
-#define __NR_fstatat64		293
-
-#else
-
-#define __NR_select		142
-#define __NR_getrlimit		191	/* SuS compliant getrlimit */
-#define __NR_lchown  		198
-#define __NR_getuid  		199
-#define __NR_getgid  		200
-#define __NR_geteuid  		201
-#define __NR_getegid  		202
-#define __NR_setreuid  		203
-#define __NR_setregid  		204
-#define __NR_getgroups  	205
-#define __NR_setgroups  	206
-#define __NR_fchown  		207
-#define __NR_setresuid  	208
-#define __NR_getresuid  	209
-#define __NR_setresgid  	210
-#define __NR_getresgid  	211
-#define __NR_chown  		212
-#define __NR_setuid  		213
-#define __NR_setgid  		214
-#define __NR_setfsuid  		215
-#define __NR_setfsgid  		216
-#define __NR_newfstatat		293
-
-#endif
-
-#endif /* _UAPI_ASM_S390_UNISTD_H_ */
diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index 1d9199e1c2ad..0dfe4d3f74e2 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -210,6 +210,7 @@
 
 #define X86_FEATURE_MBA			( 7*32+18) /* Memory Bandwidth Allocation */
 #define X86_FEATURE_RSB_CTXSW		( 7*32+19) /* "" Fill RSB on context switches */
+#define X86_FEATURE_SEV			( 7*32+20) /* AMD Secure Encrypted Virtualization */
 
 #define X86_FEATURE_USE_IBPB		( 7*32+21) /* "" Indirect Branch Prediction Barrier enabled */
 
diff --git a/tools/include/uapi/drm/i915_drm.h b/tools/include/uapi/drm/i915_drm.h
index ac3c6503ca27..536ee4febd74 100644
--- a/tools/include/uapi/drm/i915_drm.h
+++ b/tools/include/uapi/drm/i915_drm.h
@@ -86,6 +86,62 @@ enum i915_mocs_table_index {
 	I915_MOCS_CACHED,
 };
 
+/*
+ * Different engines serve different roles, and there may be more than one
+ * engine serving each role. enum drm_i915_gem_engine_class provides a
+ * classification of the role of the engine, which may be used when requesting
+ * operations to be performed on a certain subset of engines, or for providing
+ * information about that group.
+ */
+enum drm_i915_gem_engine_class {
+	I915_ENGINE_CLASS_RENDER	= 0,
+	I915_ENGINE_CLASS_COPY		= 1,
+	I915_ENGINE_CLASS_VIDEO		= 2,
+	I915_ENGINE_CLASS_VIDEO_ENHANCE	= 3,
+
+	I915_ENGINE_CLASS_INVALID	= -1
+};
+
+/**
+ * DOC: perf_events exposed by i915 through /sys/bus/event_sources/drivers/i915
+ *
+ */
+
+enum drm_i915_pmu_engine_sample {
+	I915_SAMPLE_BUSY = 0,
+	I915_SAMPLE_WAIT = 1,
+	I915_SAMPLE_SEMA = 2
+};
+
+#define I915_PMU_SAMPLE_BITS (4)
+#define I915_PMU_SAMPLE_MASK (0xf)
+#define I915_PMU_SAMPLE_INSTANCE_BITS (8)
+#define I915_PMU_CLASS_SHIFT \
+	(I915_PMU_SAMPLE_BITS + I915_PMU_SAMPLE_INSTANCE_BITS)
+
+#define __I915_PMU_ENGINE(class, instance, sample) \
+	((class) << I915_PMU_CLASS_SHIFT | \
+	(instance) << I915_PMU_SAMPLE_BITS | \
+	(sample))
+
+#define I915_PMU_ENGINE_BUSY(class, instance) \
+	__I915_PMU_ENGINE(class, instance, I915_SAMPLE_BUSY)
+
+#define I915_PMU_ENGINE_WAIT(class, instance) \
+	__I915_PMU_ENGINE(class, instance, I915_SAMPLE_WAIT)
+
+#define I915_PMU_ENGINE_SEMA(class, instance) \
+	__I915_PMU_ENGINE(class, instance, I915_SAMPLE_SEMA)
+
+#define __I915_PMU_OTHER(x) (__I915_PMU_ENGINE(0xff, 0xff, 0xf) + 1 + (x))
+
+#define I915_PMU_ACTUAL_FREQUENCY	__I915_PMU_OTHER(0)
+#define I915_PMU_REQUESTED_FREQUENCY	__I915_PMU_OTHER(1)
+#define I915_PMU_INTERRUPTS		__I915_PMU_OTHER(2)
+#define I915_PMU_RC6_RESIDENCY		__I915_PMU_OTHER(3)
+
+#define I915_PMU_LAST I915_PMU_RC6_RESIDENCY
+
 /* Each region is a minimum of 16k, and there are at most 255 of them.
  */
 #define I915_NR_TEX_REGIONS 255	/* table size 2k - maximum due to use
@@ -450,6 +506,27 @@ typedef struct drm_i915_irq_wait {
  */
 #define I915_PARAM_HAS_EXEC_FENCE_ARRAY  49
 
+/*
+ * Query whether every context (both per-file default and user created) is
+ * isolated (insofar as HW supports). If this parameter is not true, then
+ * freshly created contexts may inherit values from an existing context,
+ * rather than default HW values. If true, it also ensures (insofar as HW
+ * supports) that all state set by this context will not leak to any other
+ * context.
+ *
+ * As not every engine across every gen support contexts, the returned
+ * value reports the support of context isolation for individual engines by
+ * returning a bitmask of each engine class set to true if that class supports
+ * isolation.
+ */
+#define I915_PARAM_HAS_CONTEXT_ISOLATION 50
+
+/* Frequency of the command streamer timestamps given by the *_TIMESTAMP
+ * registers. This used to be fixed per platform but from CNL onwards, this
+ * might vary depending on the parts.
+ */
+#define I915_PARAM_CS_TIMESTAMP_FREQUENCY 51
+
 typedef struct drm_i915_getparam {
 	__s32 param;
 	/*
diff --git a/tools/include/uapi/linux/if_link.h b/tools/include/uapi/linux/if_link.h
index 8616131e2c61..6d9447700e18 100644
--- a/tools/include/uapi/linux/if_link.h
+++ b/tools/include/uapi/linux/if_link.h
@@ -163,6 +163,7 @@ enum {
 	IFLA_IF_NETNSID,
 	IFLA_CARRIER_UP_COUNT,
 	IFLA_CARRIER_DOWN_COUNT,
+	IFLA_NEW_IFINDEX,
 	__IFLA_MAX
 };
 
diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index 8fb90a0819c3..0fb5ef939732 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -1362,6 +1362,96 @@ struct kvm_s390_ucas_mapping {
 /* Available with KVM_CAP_S390_CMMA_MIGRATION */
 #define KVM_S390_GET_CMMA_BITS      _IOWR(KVMIO, 0xb8, struct kvm_s390_cmma_log)
 #define KVM_S390_SET_CMMA_BITS      _IOW(KVMIO, 0xb9, struct kvm_s390_cmma_log)
+/* Memory Encryption Commands */
+#define KVM_MEMORY_ENCRYPT_OP      _IOWR(KVMIO, 0xba, unsigned long)
+
+struct kvm_enc_region {
+	__u64 addr;
+	__u64 size;
+};
+
+#define KVM_MEMORY_ENCRYPT_REG_REGION    _IOR(KVMIO, 0xbb, struct kvm_enc_region)
+#define KVM_MEMORY_ENCRYPT_UNREG_REGION  _IOR(KVMIO, 0xbc, struct kvm_enc_region)
+
+/* Secure Encrypted Virtualization command */
+enum sev_cmd_id {
+	/* Guest initialization commands */
+	KVM_SEV_INIT = 0,
+	KVM_SEV_ES_INIT,
+	/* Guest launch commands */
+	KVM_SEV_LAUNCH_START,
+	KVM_SEV_LAUNCH_UPDATE_DATA,
+	KVM_SEV_LAUNCH_UPDATE_VMSA,
+	KVM_SEV_LAUNCH_SECRET,
+	KVM_SEV_LAUNCH_MEASURE,
+	KVM_SEV_LAUNCH_FINISH,
+	/* Guest migration commands (outgoing) */
+	KVM_SEV_SEND_START,
+	KVM_SEV_SEND_UPDATE_DATA,
+	KVM_SEV_SEND_UPDATE_VMSA,
+	KVM_SEV_SEND_FINISH,
+	/* Guest migration commands (incoming) */
+	KVM_SEV_RECEIVE_START,
+	KVM_SEV_RECEIVE_UPDATE_DATA,
+	KVM_SEV_RECEIVE_UPDATE_VMSA,
+	KVM_SEV_RECEIVE_FINISH,
+	/* Guest status and debug commands */
+	KVM_SEV_GUEST_STATUS,
+	KVM_SEV_DBG_DECRYPT,
+	KVM_SEV_DBG_ENCRYPT,
+	/* Guest certificates commands */
+	KVM_SEV_CERT_EXPORT,
+
+	KVM_SEV_NR_MAX,
+};
+
+struct kvm_sev_cmd {
+	__u32 id;
+	__u64 data;
+	__u32 error;
+	__u32 sev_fd;
+};
+
+struct kvm_sev_launch_start {
+	__u32 handle;
+	__u32 policy;
+	__u64 dh_uaddr;
+	__u32 dh_len;
+	__u64 session_uaddr;
+	__u32 session_len;
+};
+
+struct kvm_sev_launch_update_data {
+	__u64 uaddr;
+	__u32 len;
+};
+
+
+struct kvm_sev_launch_secret {
+	__u64 hdr_uaddr;
+	__u32 hdr_len;
+	__u64 guest_uaddr;
+	__u32 guest_len;
+	__u64 trans_uaddr;
+	__u32 trans_len;
+};
+
+struct kvm_sev_launch_measure {
+	__u64 uaddr;
+	__u32 len;
+};
+
+struct kvm_sev_guest_status {
+	__u32 handle;
+	__u32 policy;
+	__u32 state;
+};
+
+struct kvm_sev_dbg {
+	__u64 src_uaddr;
+	__u64 dst_uaddr;
+	__u32 len;
+};
 
 #define KVM_DEV_ASSIGN_ENABLE_IOMMU	(1 << 0)
 #define KVM_DEV_ASSIGN_PCI_2_3		(1 << 1)
diff --git a/tools/perf/Documentation/perf-data.txt b/tools/perf/Documentation/perf-data.txt
index f0796a47dfa3..90bb4aabe4f8 100644
--- a/tools/perf/Documentation/perf-data.txt
+++ b/tools/perf/Documentation/perf-data.txt
@@ -30,6 +30,10 @@ OPTIONS for 'convert'
 -i::
 	Specify input perf data file path.
 
+-f::
+--force::
+	Don't complain, do it.
+
 -v::
 --verbose::
         Be more verbose (show counter open errors, etc).
diff --git a/tools/perf/arch/s390/Makefile b/tools/perf/arch/s390/Makefile
index 48228de415d0..dfa6e3103437 100644
--- a/tools/perf/arch/s390/Makefile
+++ b/tools/perf/arch/s390/Makefile
@@ -10,15 +10,19 @@ PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET := 1
 
 out    := $(OUTPUT)arch/s390/include/generated/asm
 header := $(out)/syscalls_64.c
-sysdef := $(srctree)/tools/arch/s390/include/uapi/asm/unistd.h
-sysprf := $(srctree)/tools/perf/arch/s390/entry/syscalls/
+syskrn := $(srctree)/arch/s390/kernel/syscalls/syscall.tbl
+sysprf := $(srctree)/tools/perf/arch/s390/entry/syscalls
+sysdef := $(sysprf)/syscall.tbl
 systbl := $(sysprf)/mksyscalltbl
 
 # Create output directory if not already present
 _dummy := $(shell [ -d '$(out)' ] || mkdir -p '$(out)')
 
 $(header): $(sysdef) $(systbl)
-	$(Q)$(SHELL) '$(systbl)' '$(CC)' $(sysdef) > $@
+	@(test -d ../../kernel -a -d ../../tools -a -d ../perf && ( \
+        (diff -B $(sysdef) $(syskrn) >/dev/null) \
+        || echo "Warning: Kernel ABI header at '$(sysdef)' differs from latest version at '$(syskrn)'" >&2 )) || true
+	$(Q)$(SHELL) '$(systbl)' $(sysdef) > $@
 
 clean::
 	$(call QUIET_CLEAN, s390) $(RM) $(header)
diff --git a/tools/perf/arch/s390/entry/syscalls/mksyscalltbl b/tools/perf/arch/s390/entry/syscalls/mksyscalltbl
index 7fa0d0abd419..72ecbb676370 100755
--- a/tools/perf/arch/s390/entry/syscalls/mksyscalltbl
+++ b/tools/perf/arch/s390/entry/syscalls/mksyscalltbl
@@ -3,25 +3,23 @@
 #
 # Generate system call table for perf
 #
-#
-# Copyright IBM Corp. 2017
+# Copyright IBM Corp. 2017, 2018
 # Author(s):  Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
 #
 
-gcc=$1
-input=$2
+SYSCALL_TBL=$1
 
-if ! test -r $input; then
+if ! test -r $SYSCALL_TBL; then
 	echo "Could not read input file" >&2
 	exit 1
 fi
 
 create_table()
 {
-	local max_nr
+	local max_nr nr abi sc discard
 
 	echo 'static const char *syscalltbl_s390_64[] = {'
-	while read sc nr; do
+	while read nr abi sc discard; do
 		printf '\t[%d] = "%s",\n' $nr $sc
 		max_nr=$nr
 	done
@@ -29,8 +27,6 @@ create_table()
 	echo "#define SYSCALLTBL_S390_64_MAX_ID $max_nr"
 }
 
-
-$gcc -m64 -E -dM -x c  $input	       \
-	|sed -ne 's/^#define __NR_//p' \
-	|sort -t' ' -k2 -nu	       \
+grep -E "^[[:digit:]]+[[:space:]]+(common|64)" $SYSCALL_TBL	\
+	|sort -k1 -n					\
 	|create_table
diff --git a/tools/perf/arch/s390/entry/syscalls/syscall.tbl b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
new file mode 100644
index 000000000000..b38d48464368
--- /dev/null
+++ b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
@@ -0,0 +1,390 @@
+# SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
+#
+# System call table for s390
+#
+# Format:
+#
+# <nr> <abi> <syscall> <entry-64bit> <compat-entry>
+#
+# where <abi> can be common, 64, or 32
+
+1    common	exit			sys_exit			sys_exit
+2    common	fork			sys_fork			sys_fork
+3    common	read			sys_read			compat_sys_s390_read
+4    common	write			sys_write			compat_sys_s390_write
+5    common	open			sys_open			compat_sys_open
+6    common	close			sys_close			sys_close
+7    common	restart_syscall		sys_restart_syscall		sys_restart_syscall
+8    common	creat			sys_creat			compat_sys_creat
+9    common	link			sys_link			compat_sys_link
+10   common	unlink			sys_unlink			compat_sys_unlink
+11   common	execve			sys_execve			compat_sys_execve
+12   common	chdir			sys_chdir			compat_sys_chdir
+13   32		time			-				compat_sys_time
+14   common	mknod			sys_mknod			compat_sys_mknod
+15   common	chmod			sys_chmod			compat_sys_chmod
+16   32		lchown			-				compat_sys_s390_lchown16
+19   common	lseek			sys_lseek			compat_sys_lseek
+20   common	getpid			sys_getpid			sys_getpid
+21   common	mount			sys_mount			compat_sys_mount
+22   common	umount			sys_oldumount			compat_sys_oldumount
+23   32		setuid			-				compat_sys_s390_setuid16
+24   32		getuid			-				compat_sys_s390_getuid16
+25   32		stime			-				compat_sys_stime
+26   common	ptrace			sys_ptrace			compat_sys_ptrace
+27   common	alarm			sys_alarm			sys_alarm
+29   common	pause			sys_pause			sys_pause
+30   common	utime			sys_utime			compat_sys_utime
+33   common	access			sys_access			compat_sys_access
+34   common	nice			sys_nice			sys_nice
+36   common	sync			sys_sync			sys_sync
+37   common	kill			sys_kill			sys_kill
+38   common	rename			sys_rename			compat_sys_rename
+39   common	mkdir			sys_mkdir			compat_sys_mkdir
+40   common	rmdir			sys_rmdir			compat_sys_rmdir
+41   common	dup			sys_dup				sys_dup
+42   common	pipe			sys_pipe			compat_sys_pipe
+43   common	times			sys_times			compat_sys_times
+45   common	brk			sys_brk				compat_sys_brk
+46   32		setgid			-				compat_sys_s390_setgid16
+47   32		getgid			-				compat_sys_s390_getgid16
+48   common	signal			sys_signal			compat_sys_signal
+49   32		geteuid			-				compat_sys_s390_geteuid16
+50   32		getegid			-				compat_sys_s390_getegid16
+51   common	acct			sys_acct			compat_sys_acct
+52   common	umount2			sys_umount			compat_sys_umount
+54   common	ioctl			sys_ioctl			compat_sys_ioctl
+55   common	fcntl			sys_fcntl			compat_sys_fcntl
+57   common	setpgid			sys_setpgid			sys_setpgid
+60   common	umask			sys_umask			sys_umask
+61   common	chroot			sys_chroot			compat_sys_chroot
+62   common	ustat			sys_ustat			compat_sys_ustat
+63   common	dup2			sys_dup2			sys_dup2
+64   common	getppid			sys_getppid			sys_getppid
+65   common	getpgrp			sys_getpgrp			sys_getpgrp
+66   common	setsid			sys_setsid			sys_setsid
+67   common	sigaction		sys_sigaction			compat_sys_sigaction
+70   32		setreuid		-				compat_sys_s390_setreuid16
+71   32		setregid		-				compat_sys_s390_setregid16
+72   common	sigsuspend		sys_sigsuspend			compat_sys_sigsuspend
+73   common	sigpending		sys_sigpending			compat_sys_sigpending
+74   common	sethostname		sys_sethostname			compat_sys_sethostname
+75   common	setrlimit		sys_setrlimit			compat_sys_setrlimit
+76   32		getrlimit		-				compat_sys_old_getrlimit
+77   common	getrusage		sys_getrusage			compat_sys_getrusage
+78   common	gettimeofday		sys_gettimeofday		compat_sys_gettimeofday
+79   common	settimeofday		sys_settimeofday		compat_sys_settimeofday
+80   32		getgroups		-				compat_sys_s390_getgroups16
+81   32		setgroups		-				compat_sys_s390_setgroups16
+83   common	symlink			sys_symlink			compat_sys_symlink
+85   common	readlink		sys_readlink			compat_sys_readlink
+86   common	uselib			sys_uselib			compat_sys_uselib
+87   common	swapon			sys_swapon			compat_sys_swapon
+88   common	reboot			sys_reboot			compat_sys_reboot
+89   common	readdir			-				compat_sys_old_readdir
+90   common	mmap			sys_old_mmap			compat_sys_s390_old_mmap
+91   common	munmap			sys_munmap			compat_sys_munmap
+92   common	truncate		sys_truncate			compat_sys_truncate
+93   common	ftruncate		sys_ftruncate			compat_sys_ftruncate
+94   common	fchmod			sys_fchmod			sys_fchmod
+95   32		fchown			-				compat_sys_s390_fchown16
+96   common	getpriority		sys_getpriority			sys_getpriority
+97   common	setpriority		sys_setpriority			sys_setpriority
+99   common	statfs			sys_statfs			compat_sys_statfs
+100  common	fstatfs			sys_fstatfs			compat_sys_fstatfs
+101  32		ioperm			-				-
+102  common	socketcall		sys_socketcall			compat_sys_socketcall
+103  common	syslog			sys_syslog			compat_sys_syslog
+104  common	setitimer		sys_setitimer			compat_sys_setitimer
+105  common	getitimer		sys_getitimer			compat_sys_getitimer
+106  common	stat			sys_newstat			compat_sys_newstat
+107  common	lstat			sys_newlstat			compat_sys_newlstat
+108  common	fstat			sys_newfstat			compat_sys_newfstat
+110  common	lookup_dcookie		sys_lookup_dcookie		compat_sys_lookup_dcookie
+111  common	vhangup			sys_vhangup			sys_vhangup
+112  common	idle			-				-
+114  common	wait4			sys_wait4			compat_sys_wait4
+115  common	swapoff			sys_swapoff			compat_sys_swapoff
+116  common	sysinfo			sys_sysinfo			compat_sys_sysinfo
+117  common	ipc			sys_s390_ipc			compat_sys_s390_ipc
+118  common	fsync			sys_fsync			sys_fsync
+119  common	sigreturn		sys_sigreturn			compat_sys_sigreturn
+120  common	clone			sys_clone			compat_sys_clone
+121  common	setdomainname		sys_setdomainname		compat_sys_setdomainname
+122  common	uname			sys_newuname			compat_sys_newuname
+124  common	adjtimex		sys_adjtimex			compat_sys_adjtimex
+125  common	mprotect		sys_mprotect			compat_sys_mprotect
+126  common	sigprocmask		sys_sigprocmask			compat_sys_sigprocmask
+127  common	create_module		-				-
+128  common	init_module		sys_init_module			compat_sys_init_module
+129  common	delete_module		sys_delete_module		compat_sys_delete_module
+130  common	get_kernel_syms		-				-
+131  common	quotactl		sys_quotactl			compat_sys_quotactl
+132  common	getpgid			sys_getpgid			sys_getpgid
+133  common	fchdir			sys_fchdir			sys_fchdir
+134  common	bdflush			sys_bdflush			compat_sys_bdflush
+135  common	sysfs			sys_sysfs			compat_sys_sysfs
+136  common	personality		sys_s390_personality		sys_s390_personality
+137  common	afs_syscall		-				-
+138  32		setfsuid		-				compat_sys_s390_setfsuid16
+139  32		setfsgid		-				compat_sys_s390_setfsgid16
+140  32		_llseek			-				compat_sys_llseek
+141  common	getdents		sys_getdents			compat_sys_getdents
+142  32		_newselect		-				compat_sys_select
+142  64		select			sys_select			-
+143  common	flock			sys_flock			sys_flock
+144  common	msync			sys_msync			compat_sys_msync
+145  common	readv			sys_readv			compat_sys_readv
+146  common	writev			sys_writev			compat_sys_writev
+147  common	getsid			sys_getsid			sys_getsid
+148  common	fdatasync		sys_fdatasync			sys_fdatasync
+149  common	_sysctl			sys_sysctl			compat_sys_sysctl
+150  common	mlock			sys_mlock			compat_sys_mlock
+151  common	munlock			sys_munlock			compat_sys_munlock
+152  common	mlockall		sys_mlockall			sys_mlockall
+153  common	munlockall		sys_munlockall			sys_munlockall
+154  common	sched_setparam		sys_sched_setparam		compat_sys_sched_setparam
+155  common	sched_getparam		sys_sched_getparam		compat_sys_sched_getparam
+156  common	sched_setscheduler	sys_sched_setscheduler		compat_sys_sched_setscheduler
+157  common	sched_getscheduler	sys_sched_getscheduler		sys_sched_getscheduler
+158  common	sched_yield		sys_sched_yield			sys_sched_yield
+159  common	sched_get_priority_max	sys_sched_get_priority_max	sys_sched_get_priority_max
+160  common	sched_get_priority_min	sys_sched_get_priority_min	sys_sched_get_priority_min
+161  common	sched_rr_get_interval	sys_sched_rr_get_interval	compat_sys_sched_rr_get_interval
+162  common	nanosleep		sys_nanosleep			compat_sys_nanosleep
+163  common	mremap			sys_mremap			compat_sys_mremap
+164  32		setresuid		-				compat_sys_s390_setresuid16
+165  32		getresuid		-				compat_sys_s390_getresuid16
+167  common	query_module		-				-
+168  common	poll			sys_poll			compat_sys_poll
+169  common	nfsservctl		-				-
+170  32		setresgid		-				compat_sys_s390_setresgid16
+171  32		getresgid		-				compat_sys_s390_getresgid16
+172  common	prctl			sys_prctl			compat_sys_prctl
+173  common	rt_sigreturn		sys_rt_sigreturn		compat_sys_rt_sigreturn
+174  common	rt_sigaction		sys_rt_sigaction		compat_sys_rt_sigaction
+175  common	rt_sigprocmask		sys_rt_sigprocmask		compat_sys_rt_sigprocmask
+176  common	rt_sigpending		sys_rt_sigpending		compat_sys_rt_sigpending
+177  common	rt_sigtimedwait		sys_rt_sigtimedwait		compat_sys_rt_sigtimedwait
+178  common	rt_sigqueueinfo		sys_rt_sigqueueinfo		compat_sys_rt_sigqueueinfo
+179  common	rt_sigsuspend		sys_rt_sigsuspend		compat_sys_rt_sigsuspend
+180  common	pread64			sys_pread64			compat_sys_s390_pread64
+181  common	pwrite64		sys_pwrite64			compat_sys_s390_pwrite64
+182  32		chown			-				compat_sys_s390_chown16
+183  common	getcwd			sys_getcwd			compat_sys_getcwd
+184  common	capget			sys_capget			compat_sys_capget
+185  common	capset			sys_capset			compat_sys_capset
+186  common	sigaltstack		sys_sigaltstack			compat_sys_sigaltstack
+187  common	sendfile		sys_sendfile64			compat_sys_sendfile
+188  common	getpmsg			-				-
+189  common	putpmsg			-				-
+190  common	vfork			sys_vfork			sys_vfork
+191  32		ugetrlimit		-				compat_sys_getrlimit
+191  64		getrlimit		sys_getrlimit			-
+192  32		mmap2			-				compat_sys_s390_mmap2
+193  32		truncate64		-				compat_sys_s390_truncate64
+194  32		ftruncate64		-				compat_sys_s390_ftruncate64
+195  32		stat64			-				compat_sys_s390_stat64
+196  32		lstat64			-				compat_sys_s390_lstat64
+197  32		fstat64			-				compat_sys_s390_fstat64
+198  32		lchown32		-				compat_sys_lchown
+198  64		lchown			sys_lchown			-
+199  32		getuid32		-				sys_getuid
+199  64		getuid			sys_getuid			-
+200  32		getgid32		-				sys_getgid
+200  64		getgid			sys_getgid			-
+201  32		geteuid32		-				sys_geteuid
+201  64		geteuid			sys_geteuid			-
+202  32		getegid32		-				sys_getegid
+202  64		getegid			sys_getegid			-
+203  32		setreuid32		-				sys_setreuid
+203  64		setreuid		sys_setreuid			-
+204  32		setregid32		-				sys_setregid
+204  64		setregid		sys_setregid			-
+205  32		getgroups32		-				compat_sys_getgroups
+205  64		getgroups		sys_getgroups			-
+206  32		setgroups32		-				compat_sys_setgroups
+206  64		setgroups		sys_setgroups			-
+207  32		fchown32		-				sys_fchown
+207  64		fchown			sys_fchown			-
+208  32		setresuid32		-				sys_setresuid
+208  64		setresuid		sys_setresuid			-
+209  32		getresuid32		-				compat_sys_getresuid
+209  64		getresuid		sys_getresuid			-
+210  32		setresgid32		-				sys_setresgid
+210  64		setresgid		sys_setresgid			-
+211  32		getresgid32		-				compat_sys_getresgid
+211  64		getresgid		sys_getresgid			-
+212  32		chown32			-				compat_sys_chown
+212  64		chown			sys_chown			-
+213  32		setuid32		-				sys_setuid
+213  64		setuid			sys_setuid			-
+214  32		setgid32		-				sys_setgid
+214  64		setgid			sys_setgid			-
+215  32		setfsuid32		-				sys_setfsuid
+215  64		setfsuid		sys_setfsuid			-
+216  32		setfsgid32		-				sys_setfsgid
+216  64		setfsgid		sys_setfsgid			-
+217  common	pivot_root		sys_pivot_root			compat_sys_pivot_root
+218  common	mincore			sys_mincore			compat_sys_mincore
+219  common	madvise			sys_madvise			compat_sys_madvise
+220  common	getdents64		sys_getdents64			compat_sys_getdents64
+221  32		fcntl64			-				compat_sys_fcntl64
+222  common	readahead		sys_readahead			compat_sys_s390_readahead
+223  32		sendfile64		-				compat_sys_sendfile64
+224  common	setxattr		sys_setxattr			compat_sys_setxattr
+225  common	lsetxattr		sys_lsetxattr			compat_sys_lsetxattr
+226  common	fsetxattr		sys_fsetxattr			compat_sys_fsetxattr
+227  common	getxattr		sys_getxattr			compat_sys_getxattr
+228  common	lgetxattr		sys_lgetxattr			compat_sys_lgetxattr
+229  common	fgetxattr		sys_fgetxattr			compat_sys_fgetxattr
+230  common	listxattr		sys_listxattr			compat_sys_listxattr
+231  common	llistxattr		sys_llistxattr			compat_sys_llistxattr
+232  common	flistxattr		sys_flistxattr			compat_sys_flistxattr
+233  common	removexattr		sys_removexattr			compat_sys_removexattr
+234  common	lremovexattr		sys_lremovexattr		compat_sys_lremovexattr
+235  common	fremovexattr		sys_fremovexattr		compat_sys_fremovexattr
+236  common	gettid			sys_gettid			sys_gettid
+237  common	tkill			sys_tkill			sys_tkill
+238  common	futex			sys_futex			compat_sys_futex
+239  common	sched_setaffinity	sys_sched_setaffinity		compat_sys_sched_setaffinity
+240  common	sched_getaffinity	sys_sched_getaffinity		compat_sys_sched_getaffinity
+241  common	tgkill			sys_tgkill			sys_tgkill
+243  common	io_setup		sys_io_setup			compat_sys_io_setup
+244  common	io_destroy		sys_io_destroy			compat_sys_io_destroy
+245  common	io_getevents		sys_io_getevents		compat_sys_io_getevents
+246  common	io_submit		sys_io_submit			compat_sys_io_submit
+247  common	io_cancel		sys_io_cancel			compat_sys_io_cancel
+248  common	exit_group		sys_exit_group			sys_exit_group
+249  common	epoll_create		sys_epoll_create		sys_epoll_create
+250  common	epoll_ctl		sys_epoll_ctl			compat_sys_epoll_ctl
+251  common	epoll_wait		sys_epoll_wait			compat_sys_epoll_wait
+252  common	set_tid_address		sys_set_tid_address		compat_sys_set_tid_address
+253  common	fadvise64		sys_fadvise64_64		compat_sys_s390_fadvise64
+254  common	timer_create		sys_timer_create		compat_sys_timer_create
+255  common	timer_settime		sys_timer_settime		compat_sys_timer_settime
+256  common	timer_gettime		sys_timer_gettime		compat_sys_timer_gettime
+257  common	timer_getoverrun	sys_timer_getoverrun		sys_timer_getoverrun
+258  common	timer_delete		sys_timer_delete		sys_timer_delete
+259  common	clock_settime		sys_clock_settime		compat_sys_clock_settime
+260  common	clock_gettime		sys_clock_gettime		compat_sys_clock_gettime
+261  common	clock_getres		sys_clock_getres		compat_sys_clock_getres
+262  common	clock_nanosleep		sys_clock_nanosleep		compat_sys_clock_nanosleep
+264  32		fadvise64_64		-				compat_sys_s390_fadvise64_64
+265  common	statfs64		sys_statfs64			compat_sys_statfs64
+266  common	fstatfs64		sys_fstatfs64			compat_sys_fstatfs64
+267  common	remap_file_pages	sys_remap_file_pages		compat_sys_remap_file_pages
+268  common	mbind			sys_mbind			compat_sys_mbind
+269  common	get_mempolicy		sys_get_mempolicy		compat_sys_get_mempolicy
+270  common	set_mempolicy		sys_set_mempolicy		compat_sys_set_mempolicy
+271  common	mq_open			sys_mq_open			compat_sys_mq_open
+272  common	mq_unlink		sys_mq_unlink			compat_sys_mq_unlink
+273  common	mq_timedsend		sys_mq_timedsend		compat_sys_mq_timedsend
+274  common	mq_timedreceive		sys_mq_timedreceive		compat_sys_mq_timedreceive
+275  common	mq_notify		sys_mq_notify			compat_sys_mq_notify
+276  common	mq_getsetattr		sys_mq_getsetattr		compat_sys_mq_getsetattr
+277  common	kexec_load		sys_kexec_load			compat_sys_kexec_load
+278  common	add_key			sys_add_key			compat_sys_add_key
+279  common	request_key		sys_request_key			compat_sys_request_key
+280  common	keyctl			sys_keyctl			compat_sys_keyctl
+281  common	waitid			sys_waitid			compat_sys_waitid
+282  common	ioprio_set		sys_ioprio_set			sys_ioprio_set
+283  common	ioprio_get		sys_ioprio_get			sys_ioprio_get
+284  common	inotify_init		sys_inotify_init		sys_inotify_init
+285  common	inotify_add_watch	sys_inotify_add_watch		compat_sys_inotify_add_watch
+286  common	inotify_rm_watch	sys_inotify_rm_watch		sys_inotify_rm_watch
+287  common	migrate_pages		sys_migrate_pages		compat_sys_migrate_pages
+288  common	openat			sys_openat			compat_sys_openat
+289  common	mkdirat			sys_mkdirat			compat_sys_mkdirat
+290  common	mknodat			sys_mknodat			compat_sys_mknodat
+291  common	fchownat		sys_fchownat			compat_sys_fchownat
+292  common	futimesat		sys_futimesat			compat_sys_futimesat
+293  32		fstatat64		-				compat_sys_s390_fstatat64
+293  64		newfstatat		sys_newfstatat			-
+294  common	unlinkat		sys_unlinkat			compat_sys_unlinkat
+295  common	renameat		sys_renameat			compat_sys_renameat
+296  common	linkat			sys_linkat			compat_sys_linkat
+297  common	symlinkat		sys_symlinkat			compat_sys_symlinkat
+298  common	readlinkat		sys_readlinkat			compat_sys_readlinkat
+299  common	fchmodat		sys_fchmodat			compat_sys_fchmodat
+300  common	faccessat		sys_faccessat			compat_sys_faccessat
+301  common	pselect6		sys_pselect6			compat_sys_pselect6
+302  common	ppoll			sys_ppoll			compat_sys_ppoll
+303  common	unshare			sys_unshare			compat_sys_unshare
+304  common	set_robust_list		sys_set_robust_list		compat_sys_set_robust_list
+305  common	get_robust_list		sys_get_robust_list		compat_sys_get_robust_list
+306  common	splice			sys_splice			compat_sys_splice
+307  common	sync_file_range		sys_sync_file_range		compat_sys_s390_sync_file_range
+308  common	tee			sys_tee				compat_sys_tee
+309  common	vmsplice		sys_vmsplice			compat_sys_vmsplice
+310  common	move_pages		sys_move_pages			compat_sys_move_pages
+311  common	getcpu			sys_getcpu			compat_sys_getcpu
+312  common	epoll_pwait		sys_epoll_pwait			compat_sys_epoll_pwait
+313  common	utimes			sys_utimes			compat_sys_utimes
+314  common	fallocate		sys_fallocate			compat_sys_s390_fallocate
+315  common	utimensat		sys_utimensat			compat_sys_utimensat
+316  common	signalfd		sys_signalfd			compat_sys_signalfd
+317  common	timerfd			-				-
+318  common	eventfd			sys_eventfd			sys_eventfd
+319  common	timerfd_create		sys_timerfd_create		sys_timerfd_create
+320  common	timerfd_settime		sys_timerfd_settime		compat_sys_timerfd_settime
+321  common	timerfd_gettime		sys_timerfd_gettime		compat_sys_timerfd_gettime
+322  common	signalfd4		sys_signalfd4			compat_sys_signalfd4
+323  common	eventfd2		sys_eventfd2			sys_eventfd2
+324  common	inotify_init1		sys_inotify_init1		sys_inotify_init1
+325  common	pipe2			sys_pipe2			compat_sys_pipe2
+326  common	dup3			sys_dup3			sys_dup3
+327  common	epoll_create1		sys_epoll_create1		sys_epoll_create1
+328  common	preadv			sys_preadv			compat_sys_preadv
+329  common	pwritev			sys_pwritev			compat_sys_pwritev
+330  common	rt_tgsigqueueinfo	sys_rt_tgsigqueueinfo		compat_sys_rt_tgsigqueueinfo
+331  common	perf_event_open		sys_perf_event_open		compat_sys_perf_event_open
+332  common	fanotify_init		sys_fanotify_init		sys_fanotify_init
+333  common	fanotify_mark		sys_fanotify_mark		compat_sys_fanotify_mark
+334  common	prlimit64		sys_prlimit64			compat_sys_prlimit64
+335  common	name_to_handle_at	sys_name_to_handle_at		compat_sys_name_to_handle_at
+336  common	open_by_handle_at	sys_open_by_handle_at		compat_sys_open_by_handle_at
+337  common	clock_adjtime		sys_clock_adjtime		compat_sys_clock_adjtime
+338  common	syncfs			sys_syncfs			sys_syncfs
+339  common	setns			sys_setns			sys_setns
+340  common	process_vm_readv	sys_process_vm_readv		compat_sys_process_vm_readv
+341  common	process_vm_writev	sys_process_vm_writev		compat_sys_process_vm_writev
+342  common	s390_runtime_instr	sys_s390_runtime_instr		sys_s390_runtime_instr
+343  common	kcmp			sys_kcmp			compat_sys_kcmp
+344  common	finit_module		sys_finit_module		compat_sys_finit_module
+345  common	sched_setattr		sys_sched_setattr		compat_sys_sched_setattr
+346  common	sched_getattr		sys_sched_getattr		compat_sys_sched_getattr
+347  common	renameat2		sys_renameat2			compat_sys_renameat2
+348  common	seccomp			sys_seccomp			compat_sys_seccomp
+349  common	getrandom		sys_getrandom			compat_sys_getrandom
+350  common	memfd_create		sys_memfd_create		compat_sys_memfd_create
+351  common	bpf			sys_bpf				compat_sys_bpf
+352  common	s390_pci_mmio_write	sys_s390_pci_mmio_write		compat_sys_s390_pci_mmio_write
+353  common	s390_pci_mmio_read	sys_s390_pci_mmio_read		compat_sys_s390_pci_mmio_read
+354  common	execveat		sys_execveat			compat_sys_execveat
+355  common	userfaultfd		sys_userfaultfd			sys_userfaultfd
+356  common	membarrier		sys_membarrier			sys_membarrier
+357  common	recvmmsg		sys_recvmmsg			compat_sys_recvmmsg
+358  common	sendmmsg		sys_sendmmsg			compat_sys_sendmmsg
+359  common	socket			sys_socket			sys_socket
+360  common	socketpair		sys_socketpair			compat_sys_socketpair
+361  common	bind			sys_bind			compat_sys_bind
+362  common	connect			sys_connect			compat_sys_connect
+363  common	listen			sys_listen			sys_listen
+364  common	accept4			sys_accept4			compat_sys_accept4
+365  common	getsockopt		sys_getsockopt			compat_sys_getsockopt
+366  common	setsockopt		sys_setsockopt			compat_sys_setsockopt
+367  common	getsockname		sys_getsockname			compat_sys_getsockname
+368  common	getpeername		sys_getpeername			compat_sys_getpeername
+369  common	sendto			sys_sendto			compat_sys_sendto
+370  common	sendmsg			sys_sendmsg			compat_sys_sendmsg
+371  common	recvfrom		sys_recvfrom			compat_sys_recvfrom
+372  common	recvmsg			sys_recvmsg			compat_sys_recvmsg
+373  common	shutdown		sys_shutdown			sys_shutdown
+374  common	mlock2			sys_mlock2			compat_sys_mlock2
+375  common	copy_file_range		sys_copy_file_range		compat_sys_copy_file_range
+376  common	preadv2			sys_preadv2			compat_sys_preadv2
+377  common	pwritev2		sys_pwritev2			compat_sys_pwritev2
+378  common	s390_guarded_storage	sys_s390_guarded_storage	compat_sys_s390_guarded_storage
+379  common	statx			sys_statx			compat_sys_statx
+380  common	s390_sthyi		sys_s390_sthyi			compat_sys_s390_sthyi
diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index c0815a37fdb5..539c3d460158 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2245,7 +2245,7 @@ static int perf_c2c__browse_cacheline(struct hist_entry *he)
 	c2c_browser__update_nr_entries(browser);
 
 	while (1) {
-		key = hist_browser__run(browser, "? - help");
+		key = hist_browser__run(browser, "? - help", true);
 
 		switch (key) {
 		case 's':
@@ -2314,7 +2314,7 @@ static int perf_c2c__hists_browse(struct hists *hists)
 	c2c_browser__update_nr_entries(browser);
 
 	while (1) {
-		key = hist_browser__run(browser, "? - help");
+		key = hist_browser__run(browser, "? - help", true);
 
 		switch (key) {
 		case 'q':
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 42a52dcc41cd..4ad5dc649716 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -530,7 +530,8 @@ static int report__browse_hists(struct report *rep)
 	case 1:
 		ret = perf_evlist__tui_browse_hists(evlist, help, NULL,
 						    rep->min_percent,
-						    &session->header.env);
+						    &session->header.env,
+						    true);
 		/*
 		 * Usually "ret" is the last pressed key, and we only
 		 * care if the key notifies us to switch data file.
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index c6ccda52117d..b7c823ba8374 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -283,8 +283,9 @@ static void perf_top__print_sym_table(struct perf_top *top)
 
 	printf("%-*.*s\n", win_width, win_width, graph_dotted_line);
 
-	if (hists->stats.nr_lost_warned !=
-	    hists->stats.nr_events[PERF_RECORD_LOST]) {
+	if (!top->record_opts.overwrite &&
+	    (hists->stats.nr_lost_warned !=
+	    hists->stats.nr_events[PERF_RECORD_LOST])) {
 		hists->stats.nr_lost_warned =
 			      hists->stats.nr_events[PERF_RECORD_LOST];
 		color_fprintf(stdout, PERF_COLOR_RED,
@@ -611,7 +612,8 @@ static void *display_thread_tui(void *arg)
 
 	perf_evlist__tui_browse_hists(top->evlist, help, &hbt,
 				      top->min_percent,
-				      &top->session->header.env);
+				      &top->session->header.env,
+				      !top->record_opts.overwrite);
 
 	done = 1;
 	return NULL;
@@ -807,15 +809,23 @@ static void perf_event__process_sample(struct perf_tool *tool,
 
 static void perf_top__mmap_read_idx(struct perf_top *top, int idx)
 {
+	struct record_opts *opts = &top->record_opts;
+	struct perf_evlist *evlist = top->evlist;
 	struct perf_sample sample;
 	struct perf_evsel *evsel;
+	struct perf_mmap *md;
 	struct perf_session *session = top->session;
 	union perf_event *event;
 	struct machine *machine;
+	u64 end, start;
 	int ret;
 
-	while ((event = perf_evlist__mmap_read(top->evlist, idx)) != NULL) {
-		ret = perf_evlist__parse_sample(top->evlist, event, &sample);
+	md = opts->overwrite ? &evlist->overwrite_mmap[idx] : &evlist->mmap[idx];
+	if (perf_mmap__read_init(md, opts->overwrite, &start, &end) < 0)
+		return;
+
+	while ((event = perf_mmap__read_event(md, opts->overwrite, &start, end)) != NULL) {
+		ret = perf_evlist__parse_sample(evlist, event, &sample);
 		if (ret) {
 			pr_err("Can't parse sample, err = %d\n", ret);
 			goto next_event;
@@ -869,16 +879,120 @@ static void perf_top__mmap_read_idx(struct perf_top *top, int idx)
 		} else
 			++session->evlist->stats.nr_unknown_events;
 next_event:
-		perf_evlist__mmap_consume(top->evlist, idx);
+		perf_mmap__consume(md, opts->overwrite);
 	}
+
+	perf_mmap__read_done(md);
 }
 
 static void perf_top__mmap_read(struct perf_top *top)
 {
+	bool overwrite = top->record_opts.overwrite;
+	struct perf_evlist *evlist = top->evlist;
+	unsigned long long start, end;
 	int i;
 
+	start = rdclock();
+	if (overwrite)
+		perf_evlist__toggle_bkw_mmap(evlist, BKW_MMAP_DATA_PENDING);
+
 	for (i = 0; i < top->evlist->nr_mmaps; i++)
 		perf_top__mmap_read_idx(top, i);
+
+	if (overwrite) {
+		perf_evlist__toggle_bkw_mmap(evlist, BKW_MMAP_EMPTY);
+		perf_evlist__toggle_bkw_mmap(evlist, BKW_MMAP_RUNNING);
+	}
+	end = rdclock();
+
+	if ((end - start) > (unsigned long long)top->delay_secs * NSEC_PER_SEC)
+		ui__warning("Too slow to read ring buffer.\n"
+			    "Please try increasing the period (-c) or\n"
+			    "decreasing the freq (-F) or\n"
+			    "limiting the number of CPUs (-C)\n");
+}
+
+/*
+ * Check per-event overwrite term.
+ * perf top should support consistent term for all events.
+ * - All events don't have per-event term
+ *   E.g. "cpu/cpu-cycles/,cpu/instructions/"
+ *   Nothing change, return 0.
+ * - All events have same per-event term
+ *   E.g. "cpu/cpu-cycles,no-overwrite/,cpu/instructions,no-overwrite/
+ *   Using the per-event setting to replace the opts->overwrite if
+ *   they are different, then return 0.
+ * - Events have different per-event term
+ *   E.g. "cpu/cpu-cycles,overwrite/,cpu/instructions,no-overwrite/"
+ *   Return -1
+ * - Some of the event set per-event term, but some not.
+ *   E.g. "cpu/cpu-cycles/,cpu/instructions,no-overwrite/"
+ *   Return -1
+ */
+static int perf_top__overwrite_check(struct perf_top *top)
+{
+	struct record_opts *opts = &top->record_opts;
+	struct perf_evlist *evlist = top->evlist;
+	struct perf_evsel_config_term *term;
+	struct list_head *config_terms;
+	struct perf_evsel *evsel;
+	int set, overwrite = -1;
+
+	evlist__for_each_entry(evlist, evsel) {
+		set = -1;
+		config_terms = &evsel->config_terms;
+		list_for_each_entry(term, config_terms, list) {
+			if (term->type == PERF_EVSEL__CONFIG_TERM_OVERWRITE)
+				set = term->val.overwrite ? 1 : 0;
+		}
+
+		/* no term for current and previous event (likely) */
+		if ((overwrite < 0) && (set < 0))
+			continue;
+
+		/* has term for both current and previous event, compare */
+		if ((overwrite >= 0) && (set >= 0) && (overwrite != set))
+			return -1;
+
+		/* no term for current event but has term for previous one */
+		if ((overwrite >= 0) && (set < 0))
+			return -1;
+
+		/* has term for current event */
+		if ((overwrite < 0) && (set >= 0)) {
+			/* if it's first event, set overwrite */
+			if (evsel == perf_evlist__first(evlist))
+				overwrite = set;
+			else
+				return -1;
+		}
+	}
+
+	if ((overwrite >= 0) && (opts->overwrite != overwrite))
+		opts->overwrite = overwrite;
+
+	return 0;
+}
+
+static int perf_top_overwrite_fallback(struct perf_top *top,
+				       struct perf_evsel *evsel)
+{
+	struct record_opts *opts = &top->record_opts;
+	struct perf_evlist *evlist = top->evlist;
+	struct perf_evsel *counter;
+
+	if (!opts->overwrite)
+		return 0;
+
+	/* only fall back when first event fails */
+	if (evsel != perf_evlist__first(evlist))
+		return 0;
+
+	evlist__for_each_entry(evlist, counter)
+		counter->attr.write_backward = false;
+	opts->overwrite = false;
+	ui__warning("fall back to non-overwrite mode\n");
+	return 1;
 }
 
 static int perf_top__start_counters(struct perf_top *top)
@@ -888,12 +1002,33 @@ static int perf_top__start_counters(struct perf_top *top)
 	struct perf_evlist *evlist = top->evlist;
 	struct record_opts *opts = &top->record_opts;
 
+	if (perf_top__overwrite_check(top)) {
+		ui__error("perf top only support consistent per-event "
+			  "overwrite setting for all events\n");
+		goto out_err;
+	}
+
 	perf_evlist__config(evlist, opts, &callchain_param);
 
 	evlist__for_each_entry(evlist, counter) {
 try_again:
 		if (perf_evsel__open(counter, top->evlist->cpus,
 				     top->evlist->threads) < 0) {
+
+			/*
+			 * Specially handle overwrite fall back.
+			 * Because perf top is the only tool which has
+			 * overwrite mode by default, support
+			 * both overwrite and non-overwrite mode, and
+			 * require consistent mode for all events.
+			 *
+			 * May move it to generic code with more tools
+			 * have similar attribute.
+			 */
+			if (perf_missing_features.write_backward &&
+			    perf_top_overwrite_fallback(top, counter))
+				goto try_again;
+
 			if (perf_evsel__fallback(counter, errno, msg, sizeof(msg))) {
 				if (verbose > 0)
 					ui__warning("%s\n", msg);
@@ -1033,7 +1168,7 @@ static int __cmd_top(struct perf_top *top)
 
 		perf_top__mmap_read(top);
 
-		if (hits == top->samples)
+		if (opts->overwrite || (hits == top->samples))
 			ret = perf_evlist__poll(top->evlist, 100);
 
 		if (resize) {
@@ -1127,6 +1262,7 @@ int cmd_top(int argc, const char **argv)
 				.uses_mmap   = true,
 			},
 			.proc_map_timeout    = 500,
+			.overwrite	= 1,
 		},
 		.max_stack	     = sysctl_perf_event_max_stack,
 		.sym_pcnt_filter     = 5,
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 51abdb0a4047..790ec25919a0 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -33,7 +33,6 @@ arch/s390/include/uapi/asm/kvm.h
 arch/s390/include/uapi/asm/kvm_perf.h
 arch/s390/include/uapi/asm/ptrace.h
 arch/s390/include/uapi/asm/sie.h
-arch/s390/include/uapi/asm/unistd.h
 arch/arm/include/uapi/asm/kvm.h
 arch/arm64/include/uapi/asm/kvm.h
 arch/alpha/include/uapi/asm/errno.h
diff --git a/tools/perf/pmu-events/arch/arm64/cortex-a53/branch.json b/tools/perf/pmu-events/arch/arm64/cortex-a53/branch.json
new file mode 100644
index 000000000000..3b6208763e50
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/cortex-a53/branch.json
@@ -0,0 +1,27 @@
+[
+  {,
+    "EventCode": "0x7A",
+    "EventName": "BR_INDIRECT_SPEC",
+    "BriefDescription": "Branch speculatively executed - Indirect branch"
+  },
+  {,
+    "EventCode": "0xC9",
+    "EventName": "BR_COND",
+    "BriefDescription": "Conditional branch executed"
+  },
+  {,
+    "EventCode": "0xCA",
+    "EventName": "BR_INDIRECT_MISPRED",
+    "BriefDescription": "Indirect branch mispredicted"
+  },
+  {,
+    "EventCode": "0xCB",
+    "EventName": "BR_INDIRECT_MISPRED_ADDR",
+    "BriefDescription": "Indirect branch mispredicted because of address miscompare"
+  },
+  {,
+    "EventCode": "0xCC",
+    "EventName": "BR_COND_MISPRED",
+    "BriefDescription": "Conditional branch mispredicted"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/cortex-a53/bus.json b/tools/perf/pmu-events/arch/arm64/cortex-a53/bus.json
new file mode 100644
index 000000000000..480d9f7460ab
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/cortex-a53/bus.json
@@ -0,0 +1,22 @@
+[
+  {,
+    "EventCode": "0x60",
+    "EventName": "BUS_ACCESS_LD",
+    "BriefDescription": "Bus access - Read"
+  },
+  {,
+    "EventCode": "0x61",
+    "EventName": "BUS_ACCESS_ST",
+    "BriefDescription": "Bus access - Write"
+  },
+  {,
+    "EventCode": "0xC0",
+    "EventName": "EXT_MEM_REQ",
+    "BriefDescription": "External memory request"
+  },
+  {,
+    "EventCode": "0xC1",
+    "EventName": "EXT_MEM_REQ_NC",
+    "BriefDescription": "Non-cacheable external memory request"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/cortex-a53/cache.json b/tools/perf/pmu-events/arch/arm64/cortex-a53/cache.json
new file mode 100644
index 000000000000..11baad6344b9
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/cortex-a53/cache.json
@@ -0,0 +1,27 @@
+[
+  {,
+    "EventCode": "0xC2",
+    "EventName": "PREFETCH_LINEFILL",
+    "BriefDescription": "Linefill because of prefetch"
+  },
+  {,
+    "EventCode": "0xC3",
+    "EventName": "PREFETCH_LINEFILL_DROP",
+    "BriefDescription": "Instruction Cache Throttle occurred"
+  },
+  {,
+    "EventCode": "0xC4",
+    "EventName": "READ_ALLOC_ENTER",
+    "BriefDescription": "Entering read allocate mode"
+  },
+  {,
+    "EventCode": "0xC5",
+    "EventName": "READ_ALLOC",
+    "BriefDescription": "Read allocate mode"
+  },
+  {,
+    "EventCode": "0xC8",
+    "EventName": "EXT_SNOOP",
+    "BriefDescription": "SCU Snooped data from another CPU for this CPU"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/cortex-a53/memory.json b/tools/perf/pmu-events/arch/arm64/cortex-a53/memory.json
new file mode 100644
index 000000000000..480d9f7460ab
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/cortex-a53/memory.json
@@ -0,0 +1,22 @@
+[
+  {,
+    "EventCode": "0x60",
+    "EventName": "BUS_ACCESS_LD",
+    "BriefDescription": "Bus access - Read"
+  },
+  {,
+    "EventCode": "0x61",
+    "EventName": "BUS_ACCESS_ST",
+    "BriefDescription": "Bus access - Write"
+  },
+  {,
+    "EventCode": "0xC0",
+    "EventName": "EXT_MEM_REQ",
+    "BriefDescription": "External memory request"
+  },
+  {,
+    "EventCode": "0xC1",
+    "EventName": "EXT_MEM_REQ_NC",
+    "BriefDescription": "Non-cacheable external memory request"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/cortex-a53/other.json b/tools/perf/pmu-events/arch/arm64/cortex-a53/other.json
new file mode 100644
index 000000000000..73a22402d003
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/cortex-a53/other.json
@@ -0,0 +1,32 @@
+[
+  {,
+    "EventCode": "0x86",
+    "EventName": "EXC_IRQ",
+    "BriefDescription": "Exception taken, IRQ"
+  },
+  {,
+    "EventCode": "0x87",
+    "EventName": "EXC_FIQ",
+    "BriefDescription": "Exception taken, FIQ"
+  },
+  {,
+    "EventCode": "0xC6",
+    "EventName": "PRE_DECODE_ERR",
+    "BriefDescription": "Pre-decode error"
+  },
+  {,
+    "EventCode": "0xD0",
+    "EventName": "L1I_CACHE_ERR",
+    "BriefDescription": "L1 Instruction Cache (data or tag) memory error"
+  },
+  {,
+    "EventCode": "0xD1",
+    "EventName": "L1D_CACHE_ERR",
+    "BriefDescription": "L1 Data Cache (data, tag or dirty) memory error, correctable or non-correctable"
+  },
+  {,
+    "EventCode": "0xD2",
+    "EventName": "TLB_ERR",
+    "BriefDescription": "TLB memory error"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/cortex-a53/pipeline.json b/tools/perf/pmu-events/arch/arm64/cortex-a53/pipeline.json
new file mode 100644
index 000000000000..3149fb90555a
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/cortex-a53/pipeline.json
@@ -0,0 +1,52 @@
+[
+  {,
+    "EventCode": "0xC7",
+    "EventName": "STALL_SB_FULL",
+    "BriefDescription": "Data Write operation that stalls the pipeline because the store buffer is full"
+  },
+  {,
+    "EventCode": "0xE0",
+    "EventName": "OTHER_IQ_DEP_STALL",
+    "BriefDescription": "Cycles that the DPU IQ is empty and that is not because of a recent micro-TLB miss, instruction cache miss or pre-decode error"
+  },
+  {,
+    "EventCode": "0xE1",
+    "EventName": "IC_DEP_STALL",
+    "BriefDescription": "Cycles the DPU IQ is empty and there is an instruction cache miss being processed"
+  },
+  {,
+    "EventCode": "0xE2",
+    "EventName": "IUTLB_DEP_STALL",
+    "BriefDescription": "Cycles the DPU IQ is empty and there is an instruction micro-TLB miss being processed"
+  },
+  {,
+    "EventCode": "0xE3",
+    "EventName": "DECODE_DEP_STALL",
+    "BriefDescription": "Cycles the DPU IQ is empty and there is a pre-decode error being processed"
+  },
+  {,
+    "EventCode": "0xE4",
+    "EventName": "OTHER_INTERLOCK_STALL",
+    "BriefDescription": "Cycles there is an interlock other than  Advanced SIMD/Floating-point instructions or load/store instruction"
+  },
+  {,
+    "EventCode": "0xE5",
+    "EventName": "AGU_DEP_STALL",
+    "BriefDescription": "Cycles there is an interlock for a load/store instruction waiting for data to calculate the address in the AGU"
+  },
+  {,
+    "EventCode": "0xE6",
+    "EventName": "SIMD_DEP_STALL",
+    "BriefDescription": "Cycles there is an interlock for an Advanced SIMD/Floating-point operation."
+  },
+  {,
+    "EventCode": "0xE7",
+    "EventName": "LD_DEP_STALL",
+    "BriefDescription": "Cycles there is a stall in the Wr stage because of a load miss"
+  },
+  {,
+    "EventCode": "0xE8",
+    "EventName": "ST_DEP_STALL",
+    "BriefDescription": "Cycles there is a stall in the Wr stage because of a store"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
index 219d6756134e..e61c9ca6cf9e 100644
--- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
+++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
@@ -13,3 +13,4 @@
 #
 #Family-model,Version,Filename,EventType
 0x00000000420f5160,v1,cavium,core
+0x00000000410fd03[[:xdigit:]],v1,cortex-a53,core
diff --git a/tools/perf/tests/backward-ring-buffer.c b/tools/perf/tests/backward-ring-buffer.c
index 4035d43523c3..e0b1b414d466 100644
--- a/tools/perf/tests/backward-ring-buffer.c
+++ b/tools/perf/tests/backward-ring-buffer.c
@@ -31,10 +31,12 @@ static int count_samples(struct perf_evlist *evlist, int *sample_count,
 	int i;
 
 	for (i = 0; i < evlist->nr_mmaps; i++) {
+		struct perf_mmap *map = &evlist->overwrite_mmap[i];
 		union perf_event *event;
+		u64 start, end;
 
-		perf_mmap__read_catchup(&evlist->overwrite_mmap[i]);
-		while ((event = perf_mmap__read_backward(&evlist->overwrite_mmap[i])) != NULL) {
+		perf_mmap__read_init(map, true, &start, &end);
+		while ((event = perf_mmap__read_event(map, true, &start, end)) != NULL) {
 			const u32 type = event->header.type;
 
 			switch (type) {
@@ -49,6 +51,7 @@ static int count_samples(struct perf_evlist *evlist, int *sample_count,
 				return TEST_FAIL;
 			}
 		}
+		perf_mmap__read_done(map);
 	}
 	return TEST_OK;
 }
diff --git a/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh b/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh
index 8b3da21a08f1..c446c894b297 100755
--- a/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh
@@ -22,10 +22,23 @@ trace_libc_inet_pton_backtrace() {
 	expected[4]="rtt min.*"
 	expected[5]="[0-9]+\.[0-9]+[[:space:]]+probe_libc:inet_pton:\([[:xdigit:]]+\)"
 	expected[6]=".*inet_pton[[:space:]]\($libc\)$"
-	expected[7]="getaddrinfo[[:space:]]\($libc\)$"
-	expected[8]=".*\(.*/bin/ping.*\)$"
-
-	perf trace --no-syscalls -e probe_libc:inet_pton/max-stack=3/ ping -6 -c 1 ::1 2>&1 | grep -v ^$ | while read line ; do
+	case "$(uname -m)" in
+	s390x)
+		eventattr='call-graph=dwarf'
+		expected[7]="gaih_inet[[:space:]]\(inlined\)$"
+		expected[8]="__GI_getaddrinfo[[:space:]]\(inlined\)$"
+		expected[9]="main[[:space:]]\(.*/bin/ping.*\)$"
+		expected[10]="__libc_start_main[[:space:]]\($libc\)$"
+		expected[11]="_start[[:space:]]\(.*/bin/ping.*\)$"
+		;;
+	*)
+		eventattr='max-stack=3'
+		expected[7]="getaddrinfo[[:space:]]\($libc\)$"
+		expected[8]=".*\(.*/bin/ping.*\)$"
+		;;
+	esac
+
+	perf trace --no-syscalls -e probe_libc:inet_pton/$eventattr/ ping -6 -c 1 ::1 2>&1 | grep -v ^$ | while read line ; do
 		echo $line
 		echo "$line" | egrep -q "${expected[$idx]}"
 		if [ $? -ne 0 ] ; then
@@ -33,7 +46,7 @@ trace_libc_inet_pton_backtrace() {
 			exit 1
 		fi
 		let idx+=1
-		[ $idx -eq 9 ] && break
+		[ -z "${expected[$idx]}" ] && break
 	done
 }
 
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 68146f4620a5..6495ee55d9c3 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -608,7 +608,8 @@ static int hist_browser__title(struct hist_browser *browser, char *bf, size_t si
 	return browser->title ? browser->title(browser, bf, size) : 0;
 }
 
-int hist_browser__run(struct hist_browser *browser, const char *help)
+int hist_browser__run(struct hist_browser *browser, const char *help,
+		      bool warn_lost_event)
 {
 	int key;
 	char title[160];
@@ -638,8 +639,9 @@ int hist_browser__run(struct hist_browser *browser, const char *help)
 			nr_entries = hist_browser__nr_entries(browser);
 			ui_browser__update_nr_entries(&browser->b, nr_entries);
 
-			if (browser->hists->stats.nr_lost_warned !=
-			    browser->hists->stats.nr_events[PERF_RECORD_LOST]) {
+			if (warn_lost_event &&
+			    (browser->hists->stats.nr_lost_warned !=
+			    browser->hists->stats.nr_events[PERF_RECORD_LOST])) {
 				browser->hists->stats.nr_lost_warned =
 					browser->hists->stats.nr_events[PERF_RECORD_LOST];
 				ui_browser__warn_lost_events(&browser->b);
@@ -2763,7 +2765,8 @@ static int perf_evsel__hists_browse(struct perf_evsel *evsel, int nr_events,
 				    bool left_exits,
 				    struct hist_browser_timer *hbt,
 				    float min_pcnt,
-				    struct perf_env *env)
+				    struct perf_env *env,
+				    bool warn_lost_event)
 {
 	struct hists *hists = evsel__hists(evsel);
 	struct hist_browser *browser = perf_evsel_browser__new(evsel, hbt, env);
@@ -2844,7 +2847,8 @@ static int perf_evsel__hists_browse(struct perf_evsel *evsel, int nr_events,
 
 		nr_options = 0;
 
-		key = hist_browser__run(browser, helpline);
+		key = hist_browser__run(browser, helpline,
+					warn_lost_event);
 
 		if (browser->he_selection != NULL) {
 			thread = hist_browser__selected_thread(browser);
@@ -3184,7 +3188,8 @@ static void perf_evsel_menu__write(struct ui_browser *browser,
 
 static int perf_evsel_menu__run(struct perf_evsel_menu *menu,
 				int nr_events, const char *help,
-				struct hist_browser_timer *hbt)
+				struct hist_browser_timer *hbt,
+				bool warn_lost_event)
 {
 	struct perf_evlist *evlist = menu->b.priv;
 	struct perf_evsel *pos;
@@ -3203,7 +3208,9 @@ static int perf_evsel_menu__run(struct perf_evsel_menu *menu,
 		case K_TIMER:
 			hbt->timer(hbt->arg);
 
-			if (!menu->lost_events_warned && menu->lost_events) {
+			if (!menu->lost_events_warned &&
+			    menu->lost_events &&
+			    warn_lost_event) {
 				ui_browser__warn_lost_events(&menu->b);
 				menu->lost_events_warned = true;
 			}
@@ -3224,7 +3231,8 @@ static int perf_evsel_menu__run(struct perf_evsel_menu *menu,
 			key = perf_evsel__hists_browse(pos, nr_events, help,
 						       true, hbt,
 						       menu->min_pcnt,
-						       menu->env);
+						       menu->env,
+						       warn_lost_event);
 			ui_browser__show_title(&menu->b, title);
 			switch (key) {
 			case K_TAB:
@@ -3282,7 +3290,8 @@ static int __perf_evlist__tui_browse_hists(struct perf_evlist *evlist,
 					   int nr_entries, const char *help,
 					   struct hist_browser_timer *hbt,
 					   float min_pcnt,
-					   struct perf_env *env)
+					   struct perf_env *env,
+					   bool warn_lost_event)
 {
 	struct perf_evsel *pos;
 	struct perf_evsel_menu menu = {
@@ -3309,13 +3318,15 @@ static int __perf_evlist__tui_browse_hists(struct perf_evlist *evlist,
 			menu.b.width = line_len;
 	}
 
-	return perf_evsel_menu__run(&menu, nr_entries, help, hbt);
+	return perf_evsel_menu__run(&menu, nr_entries, help,
+				    hbt, warn_lost_event);
 }
 
 int perf_evlist__tui_browse_hists(struct perf_evlist *evlist, const char *help,
 				  struct hist_browser_timer *hbt,
 				  float min_pcnt,
-				  struct perf_env *env)
+				  struct perf_env *env,
+				  bool warn_lost_event)
 {
 	int nr_entries = evlist->nr_entries;
 
@@ -3325,7 +3336,7 @@ int perf_evlist__tui_browse_hists(struct perf_evlist *evlist, const char *help,
 
 		return perf_evsel__hists_browse(first, nr_entries, help,
 						false, hbt, min_pcnt,
-						env);
+						env, warn_lost_event);
 	}
 
 	if (symbol_conf.event_group) {
@@ -3342,5 +3353,6 @@ int perf_evlist__tui_browse_hists(struct perf_evlist *evlist, const char *help,
 	}
 
 	return __perf_evlist__tui_browse_hists(evlist, nr_entries, help,
-					       hbt, min_pcnt, env);
+					       hbt, min_pcnt, env,
+					       warn_lost_event);
 }
diff --git a/tools/perf/ui/browsers/hists.h b/tools/perf/ui/browsers/hists.h
index ba431777f559..9428bee076f2 100644
--- a/tools/perf/ui/browsers/hists.h
+++ b/tools/perf/ui/browsers/hists.h
@@ -28,7 +28,8 @@ struct hist_browser {
 
 struct hist_browser *hist_browser__new(struct hists *hists);
 void hist_browser__delete(struct hist_browser *browser);
-int hist_browser__run(struct hist_browser *browser, const char *help);
+int hist_browser__run(struct hist_browser *browser, const char *help,
+		      bool warn_lost_event);
 void hist_browser__init(struct hist_browser *browser,
 			struct hists *hists);
 #endif /* _PERF_UI_BROWSER_HISTS_H_ */
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index ac35cd214feb..e5fc14e53c05 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -715,28 +715,11 @@ union perf_event *perf_evlist__mmap_read_forward(struct perf_evlist *evlist, int
 	return perf_mmap__read_forward(md);
 }
 
-union perf_event *perf_evlist__mmap_read_backward(struct perf_evlist *evlist, int idx)
-{
-	struct perf_mmap *md = &evlist->mmap[idx];
-
-	/*
-	 * No need to check messup for backward ring buffer:
-	 * We can always read arbitrary long data from a backward
-	 * ring buffer unless we forget to pause it before reading.
-	 */
-	return perf_mmap__read_backward(md);
-}
-
 union perf_event *perf_evlist__mmap_read(struct perf_evlist *evlist, int idx)
 {
 	return perf_evlist__mmap_read_forward(evlist, idx);
 }
 
-void perf_evlist__mmap_read_catchup(struct perf_evlist *evlist, int idx)
-{
-	perf_mmap__read_catchup(&evlist->mmap[idx]);
-}
-
 void perf_evlist__mmap_consume(struct perf_evlist *evlist, int idx)
 {
 	perf_mmap__consume(&evlist->mmap[idx], false);
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 75f8e0ad5d76..336b838e6957 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -133,10 +133,6 @@ union perf_event *perf_evlist__mmap_read(struct perf_evlist *evlist, int idx);
 
 union perf_event *perf_evlist__mmap_read_forward(struct perf_evlist *evlist,
 						 int idx);
-union perf_event *perf_evlist__mmap_read_backward(struct perf_evlist *evlist,
-						  int idx);
-void perf_evlist__mmap_read_catchup(struct perf_evlist *evlist, int idx);
-
 void perf_evlist__mmap_consume(struct perf_evlist *evlist, int idx);
 
 int perf_evlist__open(struct perf_evlist *evlist);
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index ff359c9ece2e..ef351688b797 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -41,17 +41,7 @@
 
 #include "sane_ctype.h"
 
-static struct {
-	bool sample_id_all;
-	bool exclude_guest;
-	bool mmap2;
-	bool cloexec;
-	bool clockid;
-	bool clockid_wrong;
-	bool lbr_flags;
-	bool write_backward;
-	bool group_read;
-} perf_missing_features;
+struct perf_missing_features perf_missing_features;
 
 static clockid_t clockid;
 
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 846e41644525..a7487c6d1866 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -149,6 +149,20 @@ union u64_swap {
 	u32 val32[2];
 };
 
+struct perf_missing_features {
+	bool sample_id_all;
+	bool exclude_guest;
+	bool mmap2;
+	bool cloexec;
+	bool clockid;
+	bool clockid_wrong;
+	bool lbr_flags;
+	bool write_backward;
+	bool group_read;
+};
+
+extern struct perf_missing_features perf_missing_features;
+
 struct cpu_map;
 struct target;
 struct thread_map;
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index f6630cb95eff..02721b579746 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -430,7 +430,8 @@ int hist_entry__tui_annotate(struct hist_entry *he, struct perf_evsel *evsel,
 int perf_evlist__tui_browse_hists(struct perf_evlist *evlist, const char *help,
 				  struct hist_browser_timer *hbt,
 				  float min_pcnt,
-				  struct perf_env *env);
+				  struct perf_env *env,
+				  bool warn_lost_event);
 int script_browse(const char *script_opt);
 #else
 static inline
@@ -438,7 +439,8 @@ int perf_evlist__tui_browse_hists(struct perf_evlist *evlist __maybe_unused,
 				  const char *help __maybe_unused,
 				  struct hist_browser_timer *hbt __maybe_unused,
 				  float min_pcnt __maybe_unused,
-				  struct perf_env *env __maybe_unused)
+				  struct perf_env *env __maybe_unused,
+				  bool warn_lost_event __maybe_unused)
 {
 	return 0;
 }
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 05076e683938..91531a7c8fbf 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -22,29 +22,27 @@ size_t perf_mmap__mmap_len(struct perf_mmap *map)
 
 /* When check_messup is true, 'end' must points to a good entry */
 static union perf_event *perf_mmap__read(struct perf_mmap *map,
-					 u64 start, u64 end, u64 *prev)
+					 u64 *startp, u64 end)
 {
 	unsigned char *data = map->base + page_size;
 	union perf_event *event = NULL;
-	int diff = end - start;
+	int diff = end - *startp;
 
 	if (diff >= (int)sizeof(event->header)) {
 		size_t size;
 
-		event = (union perf_event *)&data[start & map->mask];
+		event = (union perf_event *)&data[*startp & map->mask];
 		size = event->header.size;
 
-		if (size < sizeof(event->header) || diff < (int)size) {
-			event = NULL;
-			goto broken_event;
-		}
+		if (size < sizeof(event->header) || diff < (int)size)
+			return NULL;
 
 		/*
 		 * Event straddles the mmap boundary -- header should always
 		 * be inside due to u64 alignment of output.
 		 */
-		if ((start & map->mask) + size != ((start + size) & map->mask)) {
-			unsigned int offset = start;
+		if ((*startp & map->mask) + size != ((*startp + size) & map->mask)) {
+			unsigned int offset = *startp;
 			unsigned int len = min(sizeof(*event), size), cpy;
 			void *dst = map->event_copy;
 
@@ -59,20 +57,19 @@ static union perf_event *perf_mmap__read(struct perf_mmap *map,
 			event = (union perf_event *)map->event_copy;
 		}
 
-		start += size;
+		*startp += size;
 	}
 
-broken_event:
-	if (prev)
-		*prev = start;
-
 	return event;
 }
 
+/*
+ * legacy interface for mmap read.
+ * Don't use it. Use perf_mmap__read_event().
+ */
 union perf_event *perf_mmap__read_forward(struct perf_mmap *map)
 {
 	u64 head;
-	u64 old = map->prev;
 
 	/*
 	 * Check if event was unmapped due to a POLLHUP/POLLERR.
@@ -82,13 +79,26 @@ union perf_event *perf_mmap__read_forward(struct perf_mmap *map)
 
 	head = perf_mmap__read_head(map);
 
-	return perf_mmap__read(map, old, head, &map->prev);
+	return perf_mmap__read(map, &map->prev, head);
 }
 
-union perf_event *perf_mmap__read_backward(struct perf_mmap *map)
+/*
+ * Read event from ring buffer one by one.
+ * Return one event for each call.
+ *
+ * Usage:
+ * perf_mmap__read_init()
+ * while(event = perf_mmap__read_event()) {
+ *	//process the event
+ *	perf_mmap__consume()
+ * }
+ * perf_mmap__read_done()
+ */
+union perf_event *perf_mmap__read_event(struct perf_mmap *map,
+					bool overwrite,
+					u64 *startp, u64 end)
 {
-	u64 head, end;
-	u64 start = map->prev;
+	union perf_event *event;
 
 	/*
 	 * Check if event was unmapped due to a POLLHUP/POLLERR.
@@ -96,40 +106,19 @@ union perf_event *perf_mmap__read_backward(struct perf_mmap *map)
 	if (!refcount_read(&map->refcnt))
 		return NULL;
 
-	head = perf_mmap__read_head(map);
-	if (!head)
+	if (startp == NULL)
 		return NULL;
 
-	/*
-	 * 'head' pointer starts from 0. Kernel minus sizeof(record) form
-	 * it each time when kernel writes to it, so in fact 'head' is
-	 * negative. 'end' pointer is made manually by adding the size of
-	 * the ring buffer to 'head' pointer, means the validate data can
-	 * read is the whole ring buffer. If 'end' is positive, the ring
-	 * buffer has not fully filled, so we must adjust 'end' to 0.
-	 *
-	 * However, since both 'head' and 'end' is unsigned, we can't
-	 * simply compare 'end' against 0. Here we compare '-head' and
-	 * the size of the ring buffer, where -head is the number of bytes
-	 * kernel write to the ring buffer.
-	 */
-	if (-head < (u64)(map->mask + 1))
-		end = 0;
-	else
-		end = head + map->mask + 1;
-
-	return perf_mmap__read(map, start, end, &map->prev);
-}
+	/* non-overwirte doesn't pause the ringbuffer */
+	if (!overwrite)
+		end = perf_mmap__read_head(map);
 
-void perf_mmap__read_catchup(struct perf_mmap *map)
-{
-	u64 head;
+	event = perf_mmap__read(map, startp, end);
 
-	if (!refcount_read(&map->refcnt))
-		return;
+	if (!overwrite)
+		map->prev = *startp;
 
-	head = perf_mmap__read_head(map);
-	map->prev = head;
+	return event;
 }
 
 static bool perf_mmap__empty(struct perf_mmap *map)
@@ -267,41 +256,60 @@ static int overwrite_rb_find_range(void *buf, int mask, u64 head, u64 *start, u6
 	return -1;
 }
 
-int perf_mmap__push(struct perf_mmap *md, bool overwrite,
-		    void *to, int push(void *to, void *buf, size_t size))
+/*
+ * Report the start and end of the available data in ringbuffer
+ */
+int perf_mmap__read_init(struct perf_mmap *md, bool overwrite,
+			 u64 *startp, u64 *endp)
 {
 	u64 head = perf_mmap__read_head(md);
 	u64 old = md->prev;
-	u64 end = head, start = old;
 	unsigned char *data = md->base + page_size;
 	unsigned long size;
-	void *buf;
-	int rc = 0;
 
-	start = overwrite ? head : old;
-	end = overwrite ? old : head;
+	*startp = overwrite ? head : old;
+	*endp = overwrite ? old : head;
 
-	if (start == end)
-		return 0;
+	if (*startp == *endp)
+		return -EAGAIN;
 
-	size = end - start;
+	size = *endp - *startp;
 	if (size > (unsigned long)(md->mask) + 1) {
 		if (!overwrite) {
 			WARN_ONCE(1, "failed to keep up with mmap data. (warn only once)\n");
 
 			md->prev = head;
 			perf_mmap__consume(md, overwrite);
-			return 0;
+			return -EAGAIN;
 		}
 
 		/*
 		 * Backward ring buffer is full. We still have a chance to read
 		 * most of data from it.
 		 */
-		if (overwrite_rb_find_range(data, md->mask, head, &start, &end))
-			return -1;
+		if (overwrite_rb_find_range(data, md->mask, head, startp, endp))
+			return -EINVAL;
 	}
 
+	return 0;
+}
+
+int perf_mmap__push(struct perf_mmap *md, bool overwrite,
+		    void *to, int push(void *to, void *buf, size_t size))
+{
+	u64 head = perf_mmap__read_head(md);
+	u64 end, start;
+	unsigned char *data = md->base + page_size;
+	unsigned long size;
+	void *buf;
+	int rc = 0;
+
+	rc = perf_mmap__read_init(md, overwrite, &start, &end);
+	if (rc < 0)
+		return (rc == -EAGAIN) ? 0 : -1;
+
+	size = end - start;
+
 	if ((start & md->mask) + size != (end & md->mask)) {
 		buf = &data[start & md->mask];
 		size = md->mask + 1 - (start & md->mask);
@@ -327,3 +335,14 @@ int perf_mmap__push(struct perf_mmap *md, bool overwrite,
 out:
 	return rc;
 }
+
+/*
+ * Mandatory for overwrite mode
+ * The direction of overwrite mode is backward.
+ * The last perf_mmap__read() will set tail to map->prev.
+ * Need to correct the map->prev to head which is the end of next read.
+ */
+void perf_mmap__read_done(struct perf_mmap *map)
+{
+	map->prev = perf_mmap__read_head(map);
+}
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index e43d7b55a55f..ec7d3a24e276 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -65,8 +65,6 @@ void perf_mmap__put(struct perf_mmap *map);
 
 void perf_mmap__consume(struct perf_mmap *map, bool overwrite);
 
-void perf_mmap__read_catchup(struct perf_mmap *md);
-
 static inline u64 perf_mmap__read_head(struct perf_mmap *mm)
 {
 	struct perf_event_mmap_page *pc = mm->base;
@@ -87,11 +85,17 @@ static inline void perf_mmap__write_tail(struct perf_mmap *md, u64 tail)
 }
 
 union perf_event *perf_mmap__read_forward(struct perf_mmap *map);
-union perf_event *perf_mmap__read_backward(struct perf_mmap *map);
+
+union perf_event *perf_mmap__read_event(struct perf_mmap *map,
+					bool overwrite,
+					u64 *startp, u64 end);
 
 int perf_mmap__push(struct perf_mmap *md, bool backward,
 		    void *to, int push(void *to, void *buf, size_t size));
 
 size_t perf_mmap__mmap_len(struct perf_mmap *map);
 
+int perf_mmap__read_init(struct perf_mmap *md, bool overwrite,
+			 u64 *startp, u64 *endp);
+void perf_mmap__read_done(struct perf_mmap *map);
 #endif /*__PERF_MMAP_H */
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 443892dabedb..1019bbc5dbd8 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -340,35 +340,15 @@ size_t hex_width(u64 v)
 	return n;
 }
 
-static int hex(char ch)
-{
-	if ((ch >= '0') && (ch <= '9'))
-		return ch - '0';
-	if ((ch >= 'a') && (ch <= 'f'))
-		return ch - 'a' + 10;
-	if ((ch >= 'A') && (ch <= 'F'))
-		return ch - 'A' + 10;
-	return -1;
-}
-
 /*
  * While we find nice hex chars, build a long_val.
  * Return number of chars processed.
  */
 int hex2u64(const char *ptr, u64 *long_val)
 {
-	const char *p = ptr;
-	*long_val = 0;
-
-	while (*p) {
-		const int hex_val = hex(*p);
+	char *p;
 
-		if (hex_val < 0)
-			break;
-
-		*long_val = (*long_val << 4) | hex_val;
-		p++;
-	}
+	*long_val = strtoull(ptr, &p, 16);
 
 	return p - ptr;
 }
