Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B2D3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4C5920842
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550497820;
	bh=fupk+BxCDeFyix3HMIoBYnE2dgAe42V+ZLSY/IdC7WA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZD85eN/LxkHdfsNq9sRrKeeR81vRO2PdlkxuZkED5GVLA1+Q2JUd6duJ7ZIhuOZBE
	 uPP/icWTb/dXtv2wyhPM6f7mJ799+lwB0Gu2dIxjDmk1cHR3zL7eWlLg/otmdtQ6rR
	 m3yzKPmBuRAFdBbFV7QUNjzgLDhggvnPWIEpzF48=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732204AbfBRNuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:50:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:57880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731905AbfBRNuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:50:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46EDB20842;
        Mon, 18 Feb 2019 13:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497813;
        bh=fupk+BxCDeFyix3HMIoBYnE2dgAe42V+ZLSY/IdC7WA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y9fIQbfdz5t80rPsfG4npLIjvEd/+tcM+JMFrXESxHPsTOPkqPbOiWnm7B+7bPyiw
         uchfxIbWuh1f/tJRa0CR1H1NNQp6jzmuKfDepUv4W8zoSFVwCH+lgbm4xbsVjFjLPj
         YaJK1vDKN7J7dGBQSCZR37sZqnAfIWjeBj8uE5N8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julien Thierry <julien.thierry@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        "David A. Long" <dave.long@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 18/85] ARM: spectre-v2: per-CPU vtables to work around big.Little systems
Date:   Mon, 18 Feb 2019 14:42:44 +0100
Message-Id: <20190218133501.653068118@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133459.758004711@linuxfoundation.org>
References: <20190218133459.758004711@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

Commit 383fb3ee8024d596f488d2dbaf45e572897acbdb upstream.

In big.Little systems, some CPUs require the Spectre workarounds in
paths such as the context switch, but other CPUs do not.  In order
to handle these differences, we need per-CPU vtables.

We are unable to use the kernel's per-CPU variables to support this
as per-CPU is not initialised at times when we need access to the
vtables, so we have to use an array indexed by logical CPU number.

We use an array-of-pointers to avoid having function pointers in
the kernel's read/write .data section.

Reviewed-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David A. Long <dave.long@linaro.org>
Reviewed-by: Julien Thierry <julien.thierry@arm.com>
Tested-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/include/asm/proc-fns.h | 23 +++++++++++++++++++++++
 arch/arm/kernel/setup.c         |  5 +++++
 arch/arm/kernel/smp.c           | 31 +++++++++++++++++++++++++++++++
 arch/arm/mm/proc-v7-bugs.c      | 17 ++---------------
 4 files changed, 61 insertions(+), 15 deletions(-)

diff --git a/arch/arm/include/asm/proc-fns.h b/arch/arm/include/asm/proc-fns.h
index c259cc49c641..e1b6f280ab08 100644
--- a/arch/arm/include/asm/proc-fns.h
+++ b/arch/arm/include/asm/proc-fns.h
@@ -104,12 +104,35 @@ extern void cpu_do_resume(void *);
 #else
 
 extern struct processor processor;
+#if defined(CONFIG_BIG_LITTLE) && defined(CONFIG_HARDEN_BRANCH_PREDICTOR)
+#include <linux/smp.h>
+/*
+ * This can't be a per-cpu variable because we need to access it before
+ * per-cpu has been initialised.  We have a couple of functions that are
+ * called in a pre-emptible context, and so can't use smp_processor_id()
+ * there, hence PROC_TABLE().  We insist in init_proc_vtable() that the
+ * function pointers for these are identical across all CPUs.
+ */
+extern struct processor *cpu_vtable[];
+#define PROC_VTABLE(f)			cpu_vtable[smp_processor_id()]->f
+#define PROC_TABLE(f)			cpu_vtable[0]->f
+static inline void init_proc_vtable(const struct processor *p)
+{
+	unsigned int cpu = smp_processor_id();
+	*cpu_vtable[cpu] = *p;
+	WARN_ON_ONCE(cpu_vtable[cpu]->dcache_clean_area !=
+		     cpu_vtable[0]->dcache_clean_area);
+	WARN_ON_ONCE(cpu_vtable[cpu]->set_pte_ext !=
+		     cpu_vtable[0]->set_pte_ext);
+}
+#else
 #define PROC_VTABLE(f)			processor.f
 #define PROC_TABLE(f)			processor.f
 static inline void init_proc_vtable(const struct processor *p)
 {
 	processor = *p;
 }
+#endif
 
 #define cpu_proc_init			PROC_VTABLE(_proc_init)
 #define cpu_check_bugs			PROC_VTABLE(check_bugs)
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index f269f4440496..7bbaa293a38c 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -115,6 +115,11 @@ EXPORT_SYMBOL(elf_hwcap2);
 
 #ifdef MULTI_CPU
 struct processor processor __ro_after_init;
+#if defined(CONFIG_BIG_LITTLE) && defined(CONFIG_HARDEN_BRANCH_PREDICTOR)
+struct processor *cpu_vtable[NR_CPUS] = {
+	[0] = &processor,
+};
+#endif
 #endif
 #ifdef MULTI_TLB
 struct cpu_tlb_fns cpu_tlb __ro_after_init;
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index f574a5e0d589..3bf82232b1be 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -42,6 +42,7 @@
 #include <asm/mmu_context.h>
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
+#include <asm/procinfo.h>
 #include <asm/processor.h>
 #include <asm/sections.h>
 #include <asm/tlbflush.h>
@@ -102,6 +103,30 @@ static unsigned long get_arch_pgd(pgd_t *pgd)
 #endif
 }
 
+#if defined(CONFIG_BIG_LITTLE) && defined(CONFIG_HARDEN_BRANCH_PREDICTOR)
+static int secondary_biglittle_prepare(unsigned int cpu)
+{
+	if (!cpu_vtable[cpu])
+		cpu_vtable[cpu] = kzalloc(sizeof(*cpu_vtable[cpu]), GFP_KERNEL);
+
+	return cpu_vtable[cpu] ? 0 : -ENOMEM;
+}
+
+static void secondary_biglittle_init(void)
+{
+	init_proc_vtable(lookup_processor(read_cpuid_id())->proc);
+}
+#else
+static int secondary_biglittle_prepare(unsigned int cpu)
+{
+	return 0;
+}
+
+static void secondary_biglittle_init(void)
+{
+}
+#endif
+
 int __cpu_up(unsigned int cpu, struct task_struct *idle)
 {
 	int ret;
@@ -109,6 +134,10 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
 	if (!smp_ops.smp_boot_secondary)
 		return -ENOSYS;
 
+	ret = secondary_biglittle_prepare(cpu);
+	if (ret)
+		return ret;
+
 	/*
 	 * We need to tell the secondary core where to find
 	 * its stack and the page tables.
@@ -359,6 +388,8 @@ asmlinkage void secondary_start_kernel(void)
 	struct mm_struct *mm = &init_mm;
 	unsigned int cpu;
 
+	secondary_biglittle_init();
+
 	/*
 	 * The identity mapping is uncached (strongly ordered), so
 	 * switch away from it before attempting any exclusive accesses.
diff --git a/arch/arm/mm/proc-v7-bugs.c b/arch/arm/mm/proc-v7-bugs.c
index 5544b82a2e7a..9a07916af8dd 100644
--- a/arch/arm/mm/proc-v7-bugs.c
+++ b/arch/arm/mm/proc-v7-bugs.c
@@ -52,8 +52,6 @@ static void cpu_v7_spectre_init(void)
 	case ARM_CPU_PART_CORTEX_A17:
 	case ARM_CPU_PART_CORTEX_A73:
 	case ARM_CPU_PART_CORTEX_A75:
-		if (processor.switch_mm != cpu_v7_bpiall_switch_mm)
-			goto bl_error;
 		per_cpu(harden_branch_predictor_fn, cpu) =
 			harden_branch_predictor_bpiall;
 		spectre_v2_method = "BPIALL";
@@ -61,8 +59,6 @@ static void cpu_v7_spectre_init(void)
 
 	case ARM_CPU_PART_CORTEX_A15:
 	case ARM_CPU_PART_BRAHMA_B15:
-		if (processor.switch_mm != cpu_v7_iciallu_switch_mm)
-			goto bl_error;
 		per_cpu(harden_branch_predictor_fn, cpu) =
 			harden_branch_predictor_iciallu;
 		spectre_v2_method = "ICIALLU";
@@ -88,11 +84,9 @@ static void cpu_v7_spectre_init(void)
 					  ARM_SMCCC_ARCH_WORKAROUND_1, &res);
 			if ((int)res.a0 != 0)
 				break;
-			if (processor.switch_mm != cpu_v7_hvc_switch_mm && cpu)
-				goto bl_error;
 			per_cpu(harden_branch_predictor_fn, cpu) =
 				call_hvc_arch_workaround_1;
-			processor.switch_mm = cpu_v7_hvc_switch_mm;
+			cpu_do_switch_mm = cpu_v7_hvc_switch_mm;
 			spectre_v2_method = "hypervisor";
 			break;
 
@@ -101,11 +95,9 @@ static void cpu_v7_spectre_init(void)
 					  ARM_SMCCC_ARCH_WORKAROUND_1, &res);
 			if ((int)res.a0 != 0)
 				break;
-			if (processor.switch_mm != cpu_v7_smc_switch_mm && cpu)
-				goto bl_error;
 			per_cpu(harden_branch_predictor_fn, cpu) =
 				call_smc_arch_workaround_1;
-			processor.switch_mm = cpu_v7_smc_switch_mm;
+			cpu_do_switch_mm = cpu_v7_smc_switch_mm;
 			spectre_v2_method = "firmware";
 			break;
 
@@ -119,11 +111,6 @@ static void cpu_v7_spectre_init(void)
 	if (spectre_v2_method)
 		pr_info("CPU%u: Spectre v2: using %s workaround\n",
 			smp_processor_id(), spectre_v2_method);
-	return;
-
-bl_error:
-	pr_err("CPU%u: Spectre v2: incorrect context switching function, system vulnerable\n",
-		cpu);
 }
 #else
 static void cpu_v7_spectre_init(void)
-- 
2.19.1



