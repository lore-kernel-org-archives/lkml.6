Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6396AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B52720896
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbfARQAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:00:51 -0500
Received: from foss.arm.com ([217.140.101.70]:60340 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727983AbfARQAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 11:00:47 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A00D71596;
        Fri, 18 Jan 2019 08:00:47 -0800 (PST)
Received: from e119886-lin.cambridge.arm.com (unknown [10.37.6.11])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 19C333F557;
        Fri, 18 Jan 2019 08:00:44 -0800 (PST)
From:   Andrew Murray <andrew.murray@arm.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, Grant Likely <Grant.Likely@arm.com>,
        Steven Price <Steven.Price@arm.com>,
        Dave P Martin <Dave.Martin@arm.com>
Subject: [PATCH 3/3] arm64: update headers to use STUB_UNLESS macro
Date:   Fri, 18 Jan 2019 16:00:30 +0000
Message-Id: <1547827230-55132-4-git-send-email-andrew.murray@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547827230-55132-1-git-send-email-andrew.murray@arm.com>
References: <1547827230-55132-1-git-send-email-andrew.murray@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the STUB_UNLESS macro to simplify function declaration.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
---
 arch/arm64/include/asm/acpi.h           | 38 +++++++++-------------
 arch/arm64/include/asm/alternative.h    |  6 +---
 arch/arm64/include/asm/cpufeature.h     |  6 +---
 arch/arm64/include/asm/cpuidle.h        | 18 +++--------
 arch/arm64/include/asm/debug-monitors.h | 10 ++----
 arch/arm64/include/asm/fpsimd.h         | 57 +++++++++++++--------------------
 arch/arm64/include/asm/hw_breakpoint.h  | 16 +++------
 arch/arm64/include/asm/kasan.h          |  9 ++----
 arch/arm64/include/asm/numa.h           | 19 ++++-------
 arch/arm64/include/asm/ptdump.h         | 13 +++-----
 arch/arm64/include/asm/signal32.h       | 29 +++++------------
 11 files changed, 73 insertions(+), 148 deletions(-)

diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index 2def77e..81836ff 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -109,22 +109,17 @@ static inline u32 get_acpi_id_for_cpu(unsigned int cpu)
 }
 
 static inline void arch_fix_phys_package_id(int num, u32 slot) { }
-void __init acpi_init_cpus(void);
-
-#else
-static inline void acpi_init_cpus(void) { }
 #endif /* CONFIG_ACPI */
 
-#ifdef CONFIG_ARM64_ACPI_PARKING_PROTOCOL
-bool acpi_parking_protocol_valid(int cpu);
+STUB_UNLESS(CONFIG_ACPI,
+void __init acpi_init_cpus(void));
+
+STUB_UNLESS(CONFIG_ARM64_ACPI_PARKING_PROTOCOL, return false,
+bool acpi_parking_protocol_valid(int cpu));
+
+STUB_UNLESS(CONFIG_ARM64_ACPI_PARKING_PROTOCOL,
 void __init
-acpi_set_mailbox_entry(int cpu, struct acpi_madt_generic_interrupt *processor);
-#else
-static inline bool acpi_parking_protocol_valid(int cpu) { return false; }
-static inline void
-acpi_set_mailbox_entry(int cpu, struct acpi_madt_generic_interrupt *processor)
-{}
-#endif
+acpi_set_mailbox_entry(int cpu, struct acpi_madt_generic_interrupt *processor));
 
 static inline const char *acpi_get_enable_method(int cpu)
 {
@@ -152,15 +147,14 @@ static inline pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr)
 }
 #endif /* CONFIG_ACPI_APEI */
 
-#ifdef CONFIG_ACPI_NUMA
-int arm64_acpi_numa_init(void);
-int acpi_numa_get_nid(unsigned int cpu);
-void acpi_map_cpus_to_nodes(void);
-#else
-static inline int arm64_acpi_numa_init(void) { return -ENOSYS; }
-static inline int acpi_numa_get_nid(unsigned int cpu) { return NUMA_NO_NODE; }
-static inline void acpi_map_cpus_to_nodes(void) { }
-#endif /* CONFIG_ACPI_NUMA */
+STUB_UNLESS(CONFIG_ACPI_NUMA, return -ENOSYS,
+int arm64_acpi_numa_init(void));
+
+STUB_UNLESS(CONFIG_ACPI_NUMA, return NUMA_NO_NODE,
+int acpi_numa_get_nid(unsigned int cpu));
+
+STUB_UNLESS(CONFIG_ACPI_NUMA,
+void acpi_map_cpus_to_nodes(void));
 
 #define ACPI_TABLE_UPGRADE_MAX_PHYS MEMBLOCK_ALLOC_ACCESSIBLE
 
diff --git a/arch/arm64/include/asm/alternative.h b/arch/arm64/include/asm/alternative.h
index 4b650ec..3dfbc15 100644
--- a/arch/arm64/include/asm/alternative.h
+++ b/arch/arm64/include/asm/alternative.h
@@ -29,11 +29,7 @@ typedef void (*alternative_cb_t)(struct alt_instr *alt,
 
 void __init apply_alternatives_all(void);
 
-#ifdef CONFIG_MODULES
-void apply_alternatives_module(void *start, size_t length);
-#else
-static inline void apply_alternatives_module(void *start, size_t length) { }
-#endif
+STUB_UNLESS(CONFIG_MODULES, void apply_alternatives_module(void *start, size_t length));
 
 #define ALTINSTR_ENTRY(feature,cb)					      \
 	" .word 661b - .\n"				/* label           */ \
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index dfcfba7..27edb5e 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -628,11 +628,7 @@ static inline int arm64_get_ssbd_state(void)
 #endif
 }
 
-#ifdef CONFIG_ARM64_SSBD
-void arm64_set_ssbd_mitigation(bool state);
-#else
-static inline void arm64_set_ssbd_mitigation(bool state) {}
-#endif
+STUB_UNLESS(CONFIG_ARM64_SSBD, void arm64_set_ssbd_mitigation(bool state));
 
 extern int do_emulate_mrs(struct pt_regs *regs, u32 sys_reg, u32 rt);
 
diff --git a/arch/arm64/include/asm/cpuidle.h b/arch/arm64/include/asm/cpuidle.h
index 3c5ddb4..fecde4f 100644
--- a/arch/arm64/include/asm/cpuidle.h
+++ b/arch/arm64/include/asm/cpuidle.h
@@ -4,18 +4,10 @@
 
 #include <asm/proc-fns.h>
 
-#ifdef CONFIG_CPU_IDLE
-extern int arm_cpuidle_init(unsigned int cpu);
-extern int arm_cpuidle_suspend(int index);
-#else
-static inline int arm_cpuidle_init(unsigned int cpu)
-{
-	return -EOPNOTSUPP;
-}
+STUB_UNLESS(CONFIG_CPU_IDLE, return -EOPNOTSUPP,
+int arm_cpuidle_init(unsigned int cpu));
+
+STUB_UNLESS(CONFIG_CPU_IDLE, return -EOPNOTSUPP,
+int arm_cpuidle_suspend(int index));
 
-static inline int arm_cpuidle_suspend(int index)
-{
-	return -EOPNOTSUPP;
-}
-#endif
 #endif
diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/asm/debug-monitors.h
index a44cf52..8b91d8e 100644
--- a/arch/arm64/include/asm/debug-monitors.h
+++ b/arch/arm64/include/asm/debug-monitors.h
@@ -124,14 +124,8 @@ void kernel_enable_single_step(struct pt_regs *regs);
 void kernel_disable_single_step(void);
 int kernel_active_single_step(void);
 
-#ifdef CONFIG_HAVE_HW_BREAKPOINT
-int reinstall_suspended_bps(struct pt_regs *regs);
-#else
-static inline int reinstall_suspended_bps(struct pt_regs *regs)
-{
-	return -ENODEV;
-}
-#endif
+STUB_UNLESS(CONFIG_HAVE_HW_BREAKPOINT, return -ENODEV,
+int reinstall_suspended_bps(struct pt_regs *regs));
 
 int aarch32_break_handler(struct pt_regs *regs);
 
diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index dd1ad39..f247eb1 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -92,17 +92,10 @@ extern int __ro_after_init sve_max_vl;
 
 extern size_t sve_state_size(struct task_struct const *task);
 
-extern void sve_alloc(struct task_struct *task);
-extern void fpsimd_release_task(struct task_struct *task);
-extern void fpsimd_sync_to_sve(struct task_struct *task);
-extern void sve_sync_to_fpsimd(struct task_struct *task);
-extern void sve_sync_from_fpsimd_zeropad(struct task_struct *task);
 
 extern int sve_set_vector_length(struct task_struct *task,
 				 unsigned long vl, unsigned long flags);
 
-extern int sve_set_current_vl(unsigned long arg);
-extern int sve_get_current_vl(void);
 
 static inline void sve_user_disable(void)
 {
@@ -113,43 +106,37 @@ static inline void sve_user_enable(void)
 {
 	sysreg_clear_set(cpacr_el1, 0, CPACR_EL1_ZEN_EL0EN);
 }
-
-/*
- * Probing and setup functions.
- * Calls to these functions must be serialised with one another.
- */
-extern void __init sve_init_vq_map(void);
-extern void sve_update_vq_map(void);
-extern int sve_verify_vq_map(void);
-extern void __init sve_setup(void);
+extern void fpsimd_sync_to_sve(struct task_struct *task);
 
 #else /* ! CONFIG_ARM64_SVE */
 
-static inline void sve_alloc(struct task_struct *task) { }
-static inline void fpsimd_release_task(struct task_struct *task) { }
-static inline void sve_sync_to_fpsimd(struct task_struct *task) { }
-static inline void sve_sync_from_fpsimd_zeropad(struct task_struct *task) { }
-
-static inline int sve_set_current_vl(unsigned long arg)
-{
-	return -EINVAL;
-}
-
-static inline int sve_get_current_vl(void)
-{
-	return -EINVAL;
-}
-
 static inline void sve_user_disable(void) { BUILD_BUG(); }
 static inline void sve_user_enable(void) { BUILD_BUG(); }
 
-static inline void sve_init_vq_map(void) { }
-static inline void sve_update_vq_map(void) { }
-static inline int sve_verify_vq_map(void) { return 0; }
-static inline void sve_setup(void) { }
 
 #endif /* ! CONFIG_ARM64_SVE */
 
+STUB_UNLESS(CONFIG_ARM64_SVE, return -EINVAL,
+int sve_set_current_vl(unsigned long arg));
+
+STUB_UNLESS(CONFIG_ARM64_SVE, return -EINVAL,
+int sve_get_current_vl(void));
+
+STUB_UNLESS(CONFIG_ARM64_SVE, void sve_alloc(struct task_struct *task));
+STUB_UNLESS(CONFIG_ARM64_SVE, void fpsimd_release_task(struct task_struct *task));
+STUB_UNLESS(CONFIG_ARM64_SVE, void sve_sync_to_fpsimd(struct task_struct *task));
+STUB_UNLESS(CONFIG_ARM64_SVE, void sve_sync_from_fpsimd_zeropad(struct task_struct *task));
+
+/*
+ * Probing and setup functions.
+ * Calls to these functions must be serialised with one another.
+ */
+STUB_UNLESS(CONFIG_ARM64_SVE, void __init sve_init_vq_map(void));
+STUB_UNLESS(CONFIG_ARM64_SVE, void sve_update_vq_map(void));
+STUB_UNLESS(CONFIG_ARM64_SVE, return 0, int sve_verify_vq_map(void));
+STUB_UNLESS(CONFIG_ARM64_SVE, void __init sve_setup(void));
+
+
 /* For use by EFI runtime services calls only */
 extern void __efi_fpsimd_begin(void);
 extern void __efi_fpsimd_end(void);
diff --git a/arch/arm64/include/asm/hw_breakpoint.h b/arch/arm64/include/asm/hw_breakpoint.h
index 6a53e59..ba451fc 100644
--- a/arch/arm64/include/asm/hw_breakpoint.h
+++ b/arch/arm64/include/asm/hw_breakpoint.h
@@ -137,17 +137,11 @@ extern void arch_uninstall_hw_breakpoint(struct perf_event *bp);
 extern void hw_breakpoint_pmu_read(struct perf_event *bp);
 extern int hw_breakpoint_slots(int type);
 
-#ifdef CONFIG_HAVE_HW_BREAKPOINT
-extern void hw_breakpoint_thread_switch(struct task_struct *next);
-extern void ptrace_hw_copy_thread(struct task_struct *task);
-#else
-static inline void hw_breakpoint_thread_switch(struct task_struct *next)
-{
-}
-static inline void ptrace_hw_copy_thread(struct task_struct *task)
-{
-}
-#endif
+STUB_UNLESS(CONFIG_HAVE_HW_BREAKPOINT,
+void hw_breakpoint_thread_switch(struct task_struct *next));
+
+STUB_UNLESS(CONFIG_HAVE_HW_BREAKPOINT,
+void ptrace_hw_copy_thread(struct task_struct *task));
 
 /* Determine number of BRP registers available. */
 static inline int get_num_brps(void)
diff --git a/arch/arm64/include/asm/kasan.h b/arch/arm64/include/asm/kasan.h
index b52aacd..e67d1a3 100644
--- a/arch/arm64/include/asm/kasan.h
+++ b/arch/arm64/include/asm/kasan.h
@@ -36,14 +36,11 @@
 #define KASAN_SHADOW_OFFSET     (KASAN_SHADOW_END - (1ULL << \
 					(64 - KASAN_SHADOW_SCALE_SHIFT)))
 
-void kasan_init(void);
-void kasan_copy_shadow(pgd_t *pgdir);
 asmlinkage void kasan_early_init(void);
-
-#else
-static inline void kasan_init(void) { }
-static inline void kasan_copy_shadow(pgd_t *pgdir) { }
 #endif
 
+STUB_UNLESS(CONFIG_KASAN, void kasan_init(void));
+STUB_UNLESS(CONFIG_KASAN, void kasan_copy_shadow(pgd_t *pgdir));
+
 #endif
 #endif
diff --git a/arch/arm64/include/asm/numa.h b/arch/arm64/include/asm/numa.h
index 626ad01..700a4a9 100644
--- a/arch/arm64/include/asm/numa.h
+++ b/arch/arm64/include/asm/numa.h
@@ -29,23 +29,16 @@ static inline const struct cpumask *cpumask_of_node(int node)
 }
 #endif
 
-void __init arm64_numa_init(void);
 int __init numa_add_memblk(int nodeid, u64 start, u64 end);
 void __init numa_set_distance(int from, int to, int distance);
 void __init numa_free_distance(void);
-void __init early_map_cpu_to_node(unsigned int cpu, int nid);
-void numa_store_cpu_info(unsigned int cpu);
-void numa_add_cpu(unsigned int cpu);
-void numa_remove_cpu(unsigned int cpu);
-
-#else	/* CONFIG_NUMA */
-
-static inline void numa_store_cpu_info(unsigned int cpu) { }
-static inline void numa_add_cpu(unsigned int cpu) { }
-static inline void numa_remove_cpu(unsigned int cpu) { }
-static inline void arm64_numa_init(void) { }
-static inline void early_map_cpu_to_node(unsigned int cpu, int nid) { }
 
 #endif	/* CONFIG_NUMA */
 
+STUB_UNLESS(CONFIG_NUMA, void __init arm64_numa_init(void));
+STUB_UNLESS(CONFIG_NUMA, void __init early_map_cpu_to_node(unsigned int cpu, int nid));
+STUB_UNLESS(CONFIG_NUMA, void numa_store_cpu_info(unsigned int cpu));
+STUB_UNLESS(CONFIG_NUMA, void numa_add_cpu(unsigned int cpu));
+STUB_UNLESS(CONFIG_NUMA, void numa_remove_cpu(unsigned int cpu));
+
 #endif	/* __ASM_NUMA_H */
diff --git a/arch/arm64/include/asm/ptdump.h b/arch/arm64/include/asm/ptdump.h
index 6afd847..8d27672 100644
--- a/arch/arm64/include/asm/ptdump.h
+++ b/arch/arm64/include/asm/ptdump.h
@@ -33,15 +33,10 @@ struct ptdump_info {
 };
 
 void ptdump_walk_pgd(struct seq_file *s, struct ptdump_info *info);
-#ifdef CONFIG_ARM64_PTDUMP_DEBUGFS
-int ptdump_debugfs_register(struct ptdump_info *info, const char *name);
-#else
-static inline int ptdump_debugfs_register(struct ptdump_info *info,
-					const char *name)
-{
-	return 0;
-}
-#endif
+
+STUB_UNLESS(CONFIG_ARM64_PTDUMP_DEBUGFS, return 0,
+int ptdump_debugfs_register(struct ptdump_info *info, const char *name));
+
 void ptdump_check_wx(void);
 #endif /* CONFIG_ARM64_PTDUMP_CORE */
 
diff --git a/arch/arm64/include/asm/signal32.h b/arch/arm64/include/asm/signal32.h
index 81abea0..9dc06bd 100644
--- a/arch/arm64/include/asm/signal32.h
+++ b/arch/arm64/include/asm/signal32.h
@@ -21,30 +21,17 @@
 #include <linux/compat.h>
 
 #define AARCH32_KERN_SIGRET_CODE_OFFSET	0x500
+#endif /* CONFIG_COMPAT */
 
+STUB_UNLESS(CONFIG_COMPAT, return -ENOSYS,
 int compat_setup_frame(int usig, struct ksignal *ksig, sigset_t *set,
-		       struct pt_regs *regs);
-int compat_setup_rt_frame(int usig, struct ksignal *ksig, sigset_t *set,
-			  struct pt_regs *regs);
-
-void compat_setup_restart_syscall(struct pt_regs *regs);
-#else
+		       struct pt_regs *regs));
 
-static inline int compat_setup_frame(int usid, struct ksignal *ksig,
-				     sigset_t *set, struct pt_regs *regs)
-{
-	return -ENOSYS;
-}
-
-static inline int compat_setup_rt_frame(int usig, struct ksignal *ksig, sigset_t *set,
-					struct pt_regs *regs)
-{
-	return -ENOSYS;
-}
+STUB_UNLESS(CONFIG_COMPAT, return -ENOSYS,
+int compat_setup_rt_frame(int usig, struct ksignal *ksig, sigset_t *set,
+			  struct pt_regs *regs));
 
-static inline void compat_setup_restart_syscall(struct pt_regs *regs)
-{
-}
-#endif /* CONFIG_COMPAT */
+STUB_UNLESS(CONFIG_COMPAT,
+void compat_setup_restart_syscall(struct pt_regs *regs));
 #endif /* __KERNEL__ */
 #endif /* __ASM_SIGNAL32_H */
-- 
2.7.4

