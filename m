Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DF3C04E88
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 16:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45B2D20A8B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 16:45:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45B2D20A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbeHWUQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 16:16:03 -0400
Received: from mga11.intel.com ([192.55.52.93]:1816 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726898AbeHWUPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 16:15:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Aug 2018 09:45:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,278,1531810800"; 
   d="scan'208";a="227129277"
Received: from chang-linux-2.sc.intel.com ([10.3.52.139])
  by orsmga004.jf.intel.com with ESMTP; 23 Aug 2018 09:45:15 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [RESEND PATCH V5 7/8] x86/vdso: Introduce helper functions for CPU and node number
Date:   Thu, 23 Aug 2018 09:44:37 -0700
Message-Id: <1535042678-31366-8-git-send-email-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535042678-31366-1-git-send-email-chang.seok.bae@intel.com>
References: <1535042678-31366-1-git-send-email-chang.seok.bae@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CPU initialization in vDSO is now a bit cleaned up by
the new helper functions. The helper functions will take
care of combining CPU and node number and reading each from
the combined value.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
---
 arch/x86/entry/vdso/vgetcpu.c  |  9 +--------
 arch/x86/entry/vdso/vma.c      | 19 +++++++------------
 arch/x86/include/asm/segment.h | 41 +++++++++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/vgtod.h   | 26 --------------------------
 4 files changed, 49 insertions(+), 46 deletions(-)

diff --git a/arch/x86/entry/vdso/vgetcpu.c b/arch/x86/entry/vdso/vgetcpu.c
index 8ec3d1f..de78fc9 100644
--- a/arch/x86/entry/vdso/vgetcpu.c
+++ b/arch/x86/entry/vdso/vgetcpu.c
@@ -13,14 +13,7 @@
 notrace long
 __vdso_getcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *unused)
 {
-	unsigned int p;
-
-	p = __getcpu();
-
-	if (cpu)
-		*cpu = p & VGETCPU_CPU_MASK;
-	if (node)
-		*node = p >> 12;
+	vdso_read_cpu_node(cpu, node);
 	return 0;
 }
 
diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 0b114aa..378732a 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -339,20 +339,15 @@ static void vgetcpu_cpu_init(void *arg)
 {
 	int cpu = smp_processor_id();
 	struct desc_struct d = { };
-	unsigned long node = 0;
-#ifdef CONFIG_NUMA
-	node = cpu_to_node(cpu);
-#endif
+	unsigned long cpudata = vdso_encode_cpu_node(cpu, cpu_to_node(cpu));
+
 	if (static_cpu_has(X86_FEATURE_RDTSCP))
-		write_rdtscp_aux((node << 12) | cpu);
+		write_rdtscp_aux(cpudata);
+
+	/* Store cpu and node number in limit */
+	d.limit0 = cpudata;
+	d.limit1 = cpudata >> 16;
 
-	/*
-	 * Store cpu number in limit so that it can be loaded
-	 * quickly in user space in vgetcpu. (12 bits for the CPU
-	 * and 8 bits for the node)
-	 */
-	d.limit0 = cpu | ((node & 0xf) << 12);
-	d.limit1 = node >> 4;
 	d.type = 5;		/* RO data, expand down, accessed */
 	d.dpl = 3;		/* Visible to user code */
 	d.s = 1;		/* Not a system segment */
diff --git a/arch/x86/include/asm/segment.h b/arch/x86/include/asm/segment.h
index e3e788ea..25a2588 100644
--- a/arch/x86/include/asm/segment.h
+++ b/arch/x86/include/asm/segment.h
@@ -224,6 +224,47 @@
 #define GDT_ENTRY_TLS_ENTRIES		3
 #define TLS_SIZE			(GDT_ENTRY_TLS_ENTRIES* 8)
 
+#ifdef CONFIG_X86_64
+
+/* Bit size and mask of CPU number stored in the per CPU data (and TSC_AUX) */
+#define VDSO_CPU_SIZE			12
+#define VDSO_CPU_MASK			0xfff
+
+#ifndef __ASSEMBLY__
+
+/* Helper functions to store/load CPU and node numbers */
+
+static inline unsigned long vdso_encode_cpu_node(int cpu, unsigned long node)
+{
+	return ((node << VDSO_CPU_SIZE) | cpu);
+}
+
+static inline void vdso_read_cpu_node(unsigned *cpu, unsigned *node)
+{
+	unsigned int p;
+
+	/*
+	 * Load CPU and node number from GDT.  LSL is faster than RDTSCP
+	 * and works on all CPUs.  This is volatile so that it orders
+	 * correctly wrt barrier() and to keep gcc from cleverly
+	 * hoisting it out of the calling function.
+	 *
+	 * If RDPID is available, use it.
+	 */
+	alternative_io ("lsl %[p],%[seg]",
+			".byte 0xf3,0x0f,0xc7,0xf8", /* RDPID %eax/rax */
+			X86_FEATURE_RDPID,
+			[p] "=a" (p), [seg] "r" (__CPU_NUMBER_SEG));
+
+	if (cpu)
+		*cpu = (p & VDSO_CPU_MASK);
+	if (node)
+		*node = (p >> VDSO_CPU_SIZE);
+}
+
+#endif /* !__ASSEMBLY__ */
+#endif /* CONFIG_X86_64 */
+
 #ifdef __KERNEL__
 
 /*
diff --git a/arch/x86/include/asm/vgtod.h b/arch/x86/include/asm/vgtod.h
index dd58a2e..056a61c 100644
--- a/arch/x86/include/asm/vgtod.h
+++ b/arch/x86/include/asm/vgtod.h
@@ -77,30 +77,4 @@ static inline void gtod_write_end(struct vsyscall_gtod_data *s)
 	++s->seq;
 }
 
-#ifdef CONFIG_X86_64
-
-#define VGETCPU_CPU_MASK 0xfff
-
-static inline unsigned int __getcpu(void)
-{
-	unsigned int p;
-
-	/*
-	 * Load CPU (and node) number from GDT.  LSL is faster than RDTSCP
-	 * and works on all CPUs.  This is volatile so that it orders
-	 * correctly wrt barrier() and to keep gcc from cleverly
-	 * hoisting it out of the calling function.
-	 *
-	 * If RDPID is available, use it.
-	 */
-	alternative_io ("lsl %[p],%[seg]",
-			".byte 0xf3,0x0f,0xc7,0xf8", /* RDPID %eax/rax */
-			X86_FEATURE_RDPID,
-			[p] "=a" (p), [seg] "r" (__CPU_NUMBER_SEG));
-
-	return p;
-}
-
-#endif /* CONFIG_X86_64 */
-
 #endif /* _ASM_X86_VGTOD_H */
-- 
2.7.4

