Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756030AbeEaSBO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 14:01:14 -0400
Received: from mga01.intel.com ([192.55.52.88]:18555 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755948AbeEaR7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 13:59:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,463,1520924400";
   d="scan'208";a="60725523"
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: Andy Lutomirski <luto@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 08/15] x86/fsgsbase/64: Add intrinsics/macros for FSGSBASE instructions
Date: Thu, 31 May 2018 10:58:38 -0700
Message-Id: <1527789525-8857-9-git-send-email-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527789525-8857-1-git-send-email-chang.seok.bae@intel.com>
References: <1527789525-8857-1-git-send-email-chang.seok.bae@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Add C intrinsics and assembler macros for the new RD/WR FS/GS BASE
instructions.

Very straight forward. Used in followon patch.

[luto: rename the variables from fs and gs to fsbase and gsbase and
 make fsgs.h safe to include on 32-bit kernels.]

v2: Use __always_inline

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
[chang: Replace new instruction macros with GAS-compatible and
renaming. Note: if GCC supports it, we can add -mfsgsbase to
CFLAGS and use the builtins here for extra performance.]
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/fsgsbase.h | 70 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/arch/x86/include/asm/fsgsbase.h b/arch/x86/include/asm/fsgsbase.h
index 0d4fbef..ed42015 100644
--- a/arch/x86/include/asm/fsgsbase.h
+++ b/arch/x86/include/asm/fsgsbase.h
@@ -18,6 +18,42 @@ unsigned long read_task_gsbase(struct task_struct *task);
 int write_task_fsbase(struct task_struct *task, unsigned long fsbase);
 int write_task_gsbase(struct task_struct *task, unsigned long gsbase);
 
+/* Must be protected by X86_FEATURE_FSGSBASE check. */
+
+static __always_inline unsigned long rdfsbase(void)
+{
+	unsigned long fsbase;
+
+	asm volatile(".byte 0xf3, 0x48, 0x0f, 0xae, 0xc0 # rdfsbaseq %%rax"
+			: "=a" (fsbase)
+			:: "memory");
+	return fsbase;
+}
+
+static __always_inline unsigned long rdgsbase(void)
+{
+	unsigned long gsbase;
+
+	asm volatile(".byte 0xf3, 0x48, 0x0f, 0xae, 0xc8 # rdgsbaseq %%rax;"
+			: "=a" (gsbase)
+			:: "memory");
+	return gsbase;
+}
+
+static __always_inline void wrfsbase(unsigned long fsbase)
+{
+	asm volatile(".byte 0xf3, 0x48, 0x0f, 0xae, 0xd0 # wrfsbaseq %%rax"
+			:: "a" (fsbase)
+			: "memory");
+}
+
+static __always_inline void wrgsbase(unsigned long gsbase)
+{
+	asm volatile(".byte 0xf3, 0x48, 0x0f, 0xae, 0xd8 # wrgsbaseq %%rax;"
+			:: "a" (gsbase)
+			: "memory");
+}
+
 /* Helper functions for reading/writing FS/GS base */
 
 static inline unsigned long read_fsbase(void)
@@ -42,6 +78,40 @@ void  write_inactive_gsbase(unsigned long gsbase);
 
 #endif /* CONFIG_X86_64 */
 
+#else /* __ASSEMBLY__ */
+
+#ifdef CONFIG_X86_64
+
+#include <asm/inst.h>
+
+.macro RDGSBASE opd
+	REG_TYPE rdgsbase_opd_type \opd
+	.if rdgsbase_opd_type == REG_TYPE_R64
+	R64_NUM rdgsbase_opd \opd
+	.byte 0xf3
+	PFX_REX rdgsbase_opd 0 W = 1
+	.else
+	.error "RDGSBASE: only for 64-bit value"
+	.endif
+	.byte 0xf, 0xae
+	MODRM 0xc0 rdgsbase_opd 1
+.endm
+
+.macro WRGSBASE opd
+	REG_TYPE wrgsbase_opd_type \opd
+	.if wrgsbase_opd_type == REG_TYPE_R64
+	R64_NUM wrgsbase_opd \opd
+	.byte 0xf3
+	PFX_REX wrgsbase_opd 0 W = 1
+	.else
+	.error "WRGSBASE: only for 64-bit value"
+	.endif
+	.byte 0xf, 0xae
+	MODRM 0xd0 wrgsbase_opd 1
+.endm
+
+#endif /* CONFIG_X86_64 */
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_FSGSBASE_H */
-- 
2.7.4
