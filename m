Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id rHuGD5RlGVvrCQAAmS7hNA
	; Thu, 07 Jun 2018 17:07:01 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B67F4606DD; Thu,  7 Jun 2018 17:07:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 8013C60115;
	Thu,  7 Jun 2018 17:07:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8013C60115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934853AbeFGRGa (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 13:06:30 -0400
Received: from mga12.intel.com ([192.55.52.136]:32205 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934578AbeFGRGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 13:06:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2018 10:06:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,487,1520924400";
   d="scan'208";a="206183228"
Received: from chang-linux-2.sc.intel.com ([10.3.52.139])
  by orsmga004.jf.intel.com with ESMTP; 07 Jun 2018 10:06:23 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: Andy Lutomirski <luto@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 6/7] x86/vdso: Introduce CPU number helper functions
Date: Thu,  7 Jun 2018 10:06:07 -0700
Message-Id: <1528391168-22224-7-git-send-email-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528391168-22224-1-git-send-email-chang.seok.bae@intel.com>
References: <1528391168-22224-1-git-send-email-chang.seok.bae@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPU number initialization in vDSO is now a bit cleaned up by
the new helper functions. The helper functions will take
care of combing CPU and node number and reading each from
the combined value.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/entry/vdso/vgetcpu.c  |  4 ++--
 arch/x86/entry/vdso/vma.c      | 16 ++++++++--------
 arch/x86/include/asm/segment.h | 28 ++++++++++++++++++++++++++++
 arch/x86/include/asm/vgtod.h   |  2 --
 4 files changed, 38 insertions(+), 12 deletions(-)

diff --git a/arch/x86/entry/vdso/vgetcpu.c b/arch/x86/entry/vdso/vgetcpu.c
index 8ec3d1f..3284069 100644
--- a/arch/x86/entry/vdso/vgetcpu.c
+++ b/arch/x86/entry/vdso/vgetcpu.c
@@ -18,9 +18,9 @@ __vdso_getcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *unused)
 	p = __getcpu();
 
 	if (cpu)
-		*cpu = p & VGETCPU_CPU_MASK;
+		*cpu = lsl_tscp_to_cpu(p);
 	if (node)
-		*node = p >> 12;
+		*node = lsl_tscp_to_node(p);
 	return 0;
 }
 
diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 833e229..1fc93da 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -340,19 +340,19 @@ static void vgetcpu_cpu_init(void *arg)
 	int cpu = smp_processor_id();
 	struct desc_struct d = { };
 	unsigned long node = 0;
+	unsigned long cpu_number = 0;
 #ifdef CONFIG_NUMA
 	node = cpu_to_node(cpu);
 #endif
+	cpu_number = make_lsl_tscp(cpu, node);
+
 	if (static_cpu_has(X86_FEATURE_RDTSCP))
-		write_rdtscp_aux((node << 12) | cpu);
+		write_rdtscp_aux(cpu_number);
+
+	/* Store cpu number in limit */
+	d.limit0 = cpu_number;
+	d.limit1 = cpu_number >> 16;
 
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
index 492e3d1..2169a24 100644
--- a/arch/x86/include/asm/segment.h
+++ b/arch/x86/include/asm/segment.h
@@ -224,6 +224,34 @@
 #define GDT_ENTRY_TLS_ENTRIES		3
 #define TLS_SIZE			(GDT_ENTRY_TLS_ENTRIES* 8)
 
+#ifdef CONFIG_X86_64
+
+/* Bit size and mask of CPU number stored in the per CPU data (and TSC_AUX) */
+#define LSL_TSCP_CPU_SIZE		12
+#define LSL_TSCP_CPU_MASK		0xfff
+
+#ifndef __ASSEMBLY__
+
+/* Helper functions to store/load CPU and node numbers */
+
+static inline unsigned long make_lsl_tscp(int cpu, unsigned long node)
+{
+	return ((node << LSL_TSCP_CPU_SIZE) | cpu);
+}
+
+static inline unsigned int lsl_tscp_to_cpu(unsigned long x)
+{
+	return (x & LSL_TSCP_CPU_MASK);
+}
+
+static inline unsigned int lsl_tscp_to_node(unsigned long x)
+{
+	return (x >> LSL_TSCP_CPU_SIZE);
+}
+
+#endif /* !__ASSEMBLY__ */
+#endif /* CONFIG_X86_64 */
+
 #ifdef __KERNEL__
 
 /*
diff --git a/arch/x86/include/asm/vgtod.h b/arch/x86/include/asm/vgtod.h
index 9cd9036..24e69b3 100644
--- a/arch/x86/include/asm/vgtod.h
+++ b/arch/x86/include/asm/vgtod.h
@@ -79,8 +79,6 @@ static inline void gtod_write_end(struct vsyscall_gtod_data *s)
 
 #ifdef CONFIG_X86_64
 
-#define VGETCPU_CPU_MASK 0xfff
-
 static inline unsigned int __getcpu(void)
 {
 	unsigned int p;
-- 
2.7.4
