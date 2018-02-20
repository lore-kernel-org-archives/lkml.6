Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751446AbeBTWA6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 17:00:58 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:36949 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751270AbeBTWAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 17:00:21 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Nicolas Pitre <nico@linaro.org>
Cc: Andi Kleen <ak@linux.intel.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 6/7] ARM: mark assembler-referenced symbols as __visible
Date: Tue, 20 Feb 2018 22:59:53 +0100
Message-Id: <20180220215954.4092811-7-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180220215954.4092811-1-arnd@arndb.de>
References: <20180220215954.4092811-1-arnd@arndb.de>
X-Provags-ID: V03:K0:98fF4dxuPuMH2iQr/JTc4GFqhtRk99Rc8Kf/Dz1RT9gj9rzXhgD
 JTQRSOuIqhB06srRjQi6+BEOMpkAn4RO2obJP/bs1fe1bFHjHMmk3fUW0RGcMMVEbX0IgLI
 Rt1gbtzzmyJ33cyu8l+ZP/1XiJRXO/9kxUGJEr5b879sBWVvPfjcBJHklJltuzwKbHb93Go
 cdPm7/uN7/yzicqyyz2vA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MVVCzsqSKDg=:5UsfVQ+yXs8AhnWiEpcSEL
 avtpcnXG+iCd37xfDLnMrwEPzBLrn4BoLVFKBNh+BrhV1tcYBn/MZqh+N9gFnR2HfYeg3pfZv
 Ktof/Z0x+5BEC7MpxFwAlav48uSFnBXVIOB8z7G3eUuMJTuPsV8cG0Bu2Mw1y0Oxz1a3TdTGJ
 TsmrgjHDGafdUmytHQAspuVGp8jVSBL2ioyXc65T2XMq3S6a1UHPjePkrJt6q83riohQkadxf
 wi4utViMIpLmfjyA4pCBNGhc4gUyheJaDkTNXZSldm9EWnGV9CwbH6oY/yAAHIdtGRmnQ1pZi
 63kT/nUL8h6QEGbTRt5qn0ejQVLRBwr8Qa2keeBqnOKo8WNnY6nf15xNfAfo+Y9FpD+Y5RYQJ
 9Hwdh5RaEfot0dYKJ0m+Py0ciLxxejcNH2i0rx9VqiiTV5aQxVqoBZW/8phOiNxLRH9RLPak8
 A0kvbWa8UHyBKSwK/fLI1HKZiubpnVmuFOj+gm0DL5CZrJCrt+IkeWeofpNoKL9slLKvLWgSF
 a+8HFEFbfyZB7pmJuL/ss3S9ewM1hnXivpC+Ysutb4KCEztX7YszJyN76Btwlg+dZvGyywYxM
 jNcufS925A3V7fVxms32EDlVyjwGs9LZcPhPm5UooRBlqoBqBASFryQtySxgOmNxY0kvffN3B
 X/sPKm9e/jJytnStcisAq/ijbledycsCWlacXUCfK/oxFPUxQ/q1VdRmMdlvvOezfmjgg5JS1
 1ZK+nJkteZujy1cETwq5T0VsJZSKgGPR3CkDFA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I got link errors for references to local symbols from
inline assembler, and also for referencing local symbols
inside of inline assembler fragments from C.

In both cases, making the symbols globally visible fixes
the link process, but this seems a bit ugly, so I hope there
is a better way to do this.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/kernel/process.c           |  2 +-
 arch/arm/kernel/suspend.c           |  2 ++
 arch/arm/kernel/unwind.c            |  1 +
 arch/arm/probes/kprobes/core.c      |  2 +-
 arch/arm/probes/kprobes/test-core.c | 11 ++++++-----
 arch/arm/vdso/vgettimeofday.c       |  2 ++
 drivers/bus/arm-cci.c               |  6 +++---
 drivers/soc/bcm/brcmstb/pm/pm-arm.c |  2 +-
 lib/clz_ctz.c                       | 20 ++++++++++----------
 9 files changed, 27 insertions(+), 21 deletions(-)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 1523cb18b109..38969cb279df 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -41,7 +41,7 @@
 
 #ifdef CONFIG_CC_STACKPROTECTOR
 #include <linux/stackprotector.h>
-unsigned long __stack_chk_guard __read_mostly;
+unsigned long __stack_chk_guard __read_mostly __visible;
 EXPORT_SYMBOL(__stack_chk_guard);
 #endif
 
diff --git a/arch/arm/kernel/suspend.c b/arch/arm/kernel/suspend.c
index a40ebb7c0896..6679ffa0a3ef 100644
--- a/arch/arm/kernel/suspend.c
+++ b/arch/arm/kernel/suspend.c
@@ -16,6 +16,7 @@ extern int __cpu_suspend(unsigned long, int (*)(unsigned long), u32 cpuid);
 extern void cpu_resume_mmu(void);
 
 #ifdef CONFIG_MMU
+__visible
 int cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
 {
 	struct mm_struct *mm = current->active_mm;
@@ -41,6 +42,7 @@ int cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
 	return ret;
 }
 #else
+__visible
 int cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
 {
 	u32 __mpidr = cpu_logical_map(smp_processor_id());
diff --git a/arch/arm/kernel/unwind.c b/arch/arm/kernel/unwind.c
index 0bee233fef9a..e3bc44b35028 100644
--- a/arch/arm/kernel/unwind.c
+++ b/arch/arm/kernel/unwind.c
@@ -55,6 +55,7 @@ void __aeabi_unwind_cpp_pr0(void)
 };
 EXPORT_SYMBOL(__aeabi_unwind_cpp_pr0);
 
+__visible
 void __aeabi_unwind_cpp_pr1(void)
 {
 };
diff --git a/arch/arm/probes/kprobes/core.c b/arch/arm/probes/kprobes/core.c
index e90cc8a08186..70ce40b5aa40 100644
--- a/arch/arm/probes/kprobes/core.c
+++ b/arch/arm/probes/kprobes/core.c
@@ -242,7 +242,7 @@ singlestep(struct kprobe *p, struct pt_regs *regs, struct kprobe_ctlblk *kcb)
  * kprobe, and that level is reserved for user kprobe handlers, so we can't
  * risk encountering a new kprobe in an interrupt handler.
  */
-void __kprobes kprobe_handler(struct pt_regs *regs)
+void __kprobes __visible __used kprobe_handler(struct pt_regs *regs)
 {
 	struct kprobe *p, *cur;
 	struct kprobe_ctlblk *kcb;
diff --git a/arch/arm/probes/kprobes/test-core.c b/arch/arm/probes/kprobes/test-core.c
index 9ed0129bed3c..bc40eededab9 100644
--- a/arch/arm/probes/kprobes/test-core.c
+++ b/arch/arm/probes/kprobes/test-core.c
@@ -245,6 +245,7 @@ static void __used __naked __arm_kprobes_test_func(void)
 	__asm__ __volatile__ (
 		".arm					\n\t"
 		".type arm_func, %%function		\n\t"
+		".globl arm_func			\n\t"
 		"arm_func:				\n\t"
 		"adds	r0, r0, r1			\n\t"
 		"mov	pc, lr				\n\t"
@@ -917,7 +918,7 @@ static void coverage_end(void)
  * Framework for instruction set test cases
  */
 
-void __naked __kprobes_test_case_start(void)
+void __naked __used __visible __kprobes_test_case_start(void)
 {
 	__asm__ __volatile__ (
 		"mov	r2, sp					\n\t"
@@ -934,7 +935,7 @@ void __naked __kprobes_test_case_start(void)
 
 #ifndef CONFIG_THUMB2_KERNEL
 
-void __naked __kprobes_test_case_end_32(void)
+void __naked __used __visible __kprobes_test_case_end_32(void)
 {
 	__asm__ __volatile__ (
 		"mov	r4, lr					\n\t"
@@ -951,7 +952,7 @@ void __naked __kprobes_test_case_end_32(void)
 
 #else /* CONFIG_THUMB2_KERNEL */
 
-void __naked __kprobes_test_case_end_16(void)
+void __naked __used __visible __kprobes_test_case_end_16(void)
 {
 	__asm__ __volatile__ (
 		"mov	r4, lr					\n\t"
@@ -966,7 +967,7 @@ void __naked __kprobes_test_case_end_16(void)
 	);
 }
 
-void __naked __kprobes_test_case_end_32(void)
+void __naked __used __visible __kprobes_test_case_end_32(void)
 {
 	__asm__ __volatile__ (
 		".arm						\n\t"
@@ -1315,7 +1316,7 @@ static unsigned long next_instruction(unsigned long pc)
 	return pc + 4;
 }
 
-static uintptr_t __used kprobes_test_case_start(const char **title, void *stack)
+uintptr_t __used __visible kprobes_test_case_start(const char **title, void *stack)
 {
 	struct test_arg *args;
 	struct test_arg_end *end_arg;
diff --git a/arch/arm/vdso/vgettimeofday.c b/arch/arm/vdso/vgettimeofday.c
index b79dc05b0b4d..df7e4b4d8719 100644
--- a/arch/arm/vdso/vgettimeofday.c
+++ b/arch/arm/vdso/vgettimeofday.c
@@ -273,6 +273,8 @@ void __aeabi_unwind_cpp_pr0(void)
 {
 }
 
+__visible
+void __aeabi_unwind_cpp_pr1(void);
 void __aeabi_unwind_cpp_pr1(void)
 {
 }
diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index 5426c04fe24b..e149590bce50 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -1842,7 +1842,7 @@ struct cci_ace_port {
 	struct device_node *dn;
 };
 
-static struct cci_ace_port *ports;
+struct cci_ace_port *ports;
 static unsigned int nb_cci_ports;
 
 struct cpu_port {
@@ -1877,7 +1877,7 @@ static inline bool cpu_port_match(struct cpu_port *port, u64 mpidr)
 	return port->mpidr == (mpidr & MPIDR_HWID_BITMASK);
 }
 
-static struct cpu_port cpu_port[NR_CPUS];
+struct cpu_port cpu_port[NR_CPUS];
 
 /**
  * __cci_ace_get_port - Function to retrieve the port index connected to
@@ -2027,7 +2027,7 @@ EXPORT_SYMBOL_GPL(cci_disable_port_by_cpu);
  * any failure this never returns as the inability to enable the CCI is
  * fatal and there is no possible recovery at this stage.
  */
-asmlinkage void __naked cci_enable_port_for_self(void)
+asmlinkage void __naked __visible cci_enable_port_for_self(void)
 {
 	asm volatile ("\n"
 "	.arch armv7-a\n"
diff --git a/drivers/soc/bcm/brcmstb/pm/pm-arm.c b/drivers/soc/bcm/brcmstb/pm/pm-arm.c
index dcf8c8065508..863f3a6b2279 100644
--- a/drivers/soc/bcm/brcmstb/pm/pm-arm.c
+++ b/drivers/soc/bcm/brcmstb/pm/pm-arm.c
@@ -400,7 +400,7 @@ static int brcmstb_pm_s2(void)
  * generate stack references on the old stack). It cannot be made static because
  * it is referenced from brcmstb_pm_s3()
  */
-noinline int brcmstb_pm_s3_finish(void)
+__visible noinline int brcmstb_pm_s3_finish(void)
 {
 	struct brcmstb_s3_params *params = ctrl.s3_params;
 	dma_addr_t params_pa = ctrl.s3_params_pa;
diff --git a/lib/clz_ctz.c b/lib/clz_ctz.c
index 2e11e48446ab..516751d12217 100644
--- a/lib/clz_ctz.c
+++ b/lib/clz_ctz.c
@@ -16,31 +16,31 @@
 #include <linux/export.h>
 #include <linux/kernel.h>
 
-int __weak __ctzsi2(int val);
-int __weak __ctzsi2(int val)
+int __visible __ctzsi2(int val);
+int __visible __ctzsi2(int val)
 {
 	return __ffs(val);
 }
 EXPORT_SYMBOL(__ctzsi2);
 
-int __weak __clzsi2(int val);
-int __weak __clzsi2(int val)
+int __visible __clzsi2(int val);
+int __visible __clzsi2(int val)
 {
 	return 32 - fls(val);
 }
 EXPORT_SYMBOL(__clzsi2);
 
-int __weak __clzdi2(long val);
-int __weak __ctzdi2(long val);
+int __visible __clzdi2(long val);
+int __visible __ctzdi2(long val);
 #if BITS_PER_LONG == 32
 
-int __weak __clzdi2(long val)
+int __visible __clzdi2(long val)
 {
 	return 32 - fls((int)val);
 }
 EXPORT_SYMBOL(__clzdi2);
 
-int __weak __ctzdi2(long val)
+int __visible __ctzdi2(long val)
 {
 	return __ffs((u32)val);
 }
@@ -48,13 +48,13 @@ EXPORT_SYMBOL(__ctzdi2);
 
 #elif BITS_PER_LONG == 64
 
-int __weak __clzdi2(long val)
+int __visible __clzdi2(long val)
 {
 	return 64 - fls64((u64)val);
 }
 EXPORT_SYMBOL(__clzdi2);
 
-int __weak __ctzdi2(long val)
+int __visible __ctzdi2(long val)
 {
 	return __ffs64((u64)val);
 }
-- 
2.9.0
