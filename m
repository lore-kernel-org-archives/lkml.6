Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971770AbeCSU40 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 16:56:26 -0400
Received: from mga14.intel.com ([192.55.52.115]:62509 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968528AbeCSSIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 14:08:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,331,1517904000";
   d="scan'208";a="39330586"
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: x86@kernel.org
Cc: luto@kernel.org, ak@linux.intel.com, hpa@zytor.com,
        markus.t.metzger@intel.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH 09/15] x86/fsgsbase/64: Add intrinsics/macros for FSGSBASE instructions
Date: Mon, 19 Mar 2018 10:49:21 -0700
Message-Id: <1521481767-22113-10-git-send-email-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521481767-22113-1-git-send-email-chang.seok.bae@intel.com>
References: <1521481767-22113-1-git-send-email-chang.seok.bae@intel.com>
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
 renaming]
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
---
 arch/x86/include/asm/fsgsbase.h | 102 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/arch/x86/include/asm/fsgsbase.h b/arch/x86/include/asm/fsgsbase.h
index 29249f6..cad2831 100644
--- a/arch/x86/include/asm/fsgsbase.h
+++ b/arch/x86/include/asm/fsgsbase.h
@@ -18,6 +18,44 @@ int write_task_fsbase(struct task_struct *task, unsigned long fsbase);
 int write_task_gsbase(struct task_struct *task, unsigned long gsbase);
 
 /*
+ * Must be protected by X86_FEATURE_FSGSBASE check.
+ */
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
+/*
  * Helper functions for reading/writing FS/GS base
  */
 
@@ -43,6 +81,70 @@ void  write_shadow_gsbase(unsigned long gsbase);
 
 #endif /* CONFIG_X86_64 */
 
+#else /* __ASSEMBLY__ */
+
+#ifdef CONFIG_X86_64
+
+#include <asm/inst.h>
+
+.macro RDFSBASE opd
+	REG_TYPE rdfsbase_opd_type \opd
+	.if rdfsbase_opd_type == REG_TYPE_R64
+	R64_NUM rdfsbase_opd \opd
+	.byte 0xf3
+	PFX_REX rdfsbase_opd 0 W = 1
+	.else
+	R32_NUM rdfsbase_opd \opd
+	.byte 0xf3
+	.endif
+	.byte 0xf, 0xae
+	MODRM 0xc0 rdfsbase_opd 0
+.endm
+
+.macro WRFSBASE opd
+	REG_TYPE wrfsbase_opd_type \opd
+	.if wrfsbase_opd_type == REG_TYPE_R64
+	R64_NUM wrfsbase_opd \opd
+	.byte 0xf3
+	PFX_REX wrfsbase_opd 0 W = 1
+	.else
+	R32_NUM wrfsbase_opd \opd
+	.byte 0xf3
+	.endif
+	.byte 0xf, 0xae
+	MODRM 0xd0 wrfsbase_opd 0
+.endm
+
+.macro RDGSBASE opd
+	REG_TYPE rdgsbase_opd_type \opd
+	.if rdgsbase_opd_type == REG_TYPE_R64
+	R64_NUM rdgsbase_opd \opd
+	.byte 0xf3
+	PFX_REX rdgsbase_opd 0 W = 1
+	.else
+	R32_NUM rdgsbase_opd \opd
+	.byte 0xf3
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
+	R32_NUM wrgsbase_opd \opd
+	.byte 0xf3
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
