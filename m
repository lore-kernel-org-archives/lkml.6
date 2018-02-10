Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753196AbeBJXlV (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 18:41:21 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:60670 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752926AbeBJXjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 18:39:48 -0500
X-IronPort-AV: E=Sophos;i="5.46,492,1511827200";
   d="scan'208";a="719069391"
From: David Woodhouse <dwmw@amazon.co.uk>
To: tglx@linutronix.de, karahmed@amazon.de, sironi@amazon.de,
        x86@kernel.org, kvm@vger.kernel.org, torvalds@linux-foundation.org,
        pbonzini@redhat.com, linux-kernel@vger.kernel.org, bp@alien8.de,
        peterz@infradead.org, jmattson@google.com, rkrcmar@redhat.com,
        arjan.van.de.ven@intel.com, dave.hansen@intel.com
Subject: [PATCH v2 2/6] Revert "x86/speculation: Simplify indirect_branch_prediction_barrier()"
Date: Sat, 10 Feb 2018 23:39:23 +0000
Message-Id: <1518305967-31356-3-git-send-email-dwmw@amazon.co.uk>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518305967-31356-1-git-send-email-dwmw@amazon.co.uk>
References: <1518305967-31356-1-git-send-email-dwmw@amazon.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 64e16720ea0879f8ab4547e3b9758936d483909b.

We cannot call C functions like that, without marking all the
call-clobbered registers as, well, clobbered. We might have got away
with it for now because the __ibp_barrier() function was *fairly*
unlikely to actually use any other registers. But no. Just no.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/include/asm/nospec-branch.h | 13 +++++++++----
 arch/x86/include/asm/processor.h     |  3 ---
 arch/x86/kernel/cpu/bugs.c           |  6 ------
 3 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 4d57894..300cc15 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -164,10 +164,15 @@ static inline void vmexit_fill_RSB(void)
 
 static inline void indirect_branch_prediction_barrier(void)
 {
-	alternative_input("",
-			  "call __ibp_barrier",
-			  X86_FEATURE_USE_IBPB,
-			  ASM_NO_INPUT_CLOBBER("eax", "ecx", "edx", "memory"));
+	asm volatile(ALTERNATIVE("",
+				 "movl %[msr], %%ecx\n\t"
+				 "movl %[val], %%eax\n\t"
+				 "movl $0, %%edx\n\t"
+				 "wrmsr",
+				 X86_FEATURE_USE_IBPB)
+		     : : [msr] "i" (MSR_IA32_PRED_CMD),
+			 [val] "i" (PRED_CMD_IBPB)
+		     : "eax", "ecx", "edx", "memory");
 }
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 513f960..99799fb 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -969,7 +969,4 @@ bool xen_set_default_idle(void);
 
 void stop_this_cpu(void *dummy);
 void df_debug(struct pt_regs *regs, long error_code);
-
-void __ibp_barrier(void);
-
 #endif /* _ASM_X86_PROCESSOR_H */
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 71949bf..61152aa 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -337,9 +337,3 @@ ssize_t cpu_show_spectre_v2(struct device *dev,
 		       spectre_v2_module_string());
 }
 #endif
-
-void __ibp_barrier(void)
-{
-	__wrmsr(MSR_IA32_PRED_CMD, PRED_CMD_IBPB, 0);
-}
-EXPORT_SYMBOL_GPL(__ibp_barrier);
-- 
2.7.4
