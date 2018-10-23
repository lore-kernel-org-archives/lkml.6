Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729D2C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 450F920665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:44:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 450F920665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbeJXDIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 23:08:53 -0400
Received: from mga05.intel.com ([192.55.52.43]:55078 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728355AbeJXDIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 23:08:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2018 11:43:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,417,1534834800"; 
   d="scan'208";a="243726572"
Received: from chang-linux-2.sc.intel.com ([10.3.52.139])
  by orsmga004.jf.intel.com with ESMTP; 23 Oct 2018 11:43:25 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [v3 03/12] x86/fsgsbase/64: Add intrinsics/macros for FSGSBASE instructions
Date:   Tue, 23 Oct 2018 11:42:25 -0700
Message-Id: <20181023184234.14025-4-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181023184234.14025-1-chang.seok.bae@intel.com>
References: <20181023184234.14025-1-chang.seok.bae@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Add C intrinsics and assembler macros for the new FSBASE and GSBASE
instructions.

Very straight forward. Used in followon patches.

[ luto: Rename the variables from FS and GS to FSBASE and GSBASE and
  make <asm/fsgsbase.h> safe to include on 32-bit kernels. ]

v2: Use __always_inline

[ chang: Revise the changelog. Place them in <asm/fsgsbase.h>. Replace
  the macros with GAS-compatible ones. ]

If GCC supports it, we can add -mfsgsbase to CFLAGS and use the builtins
here for extra performance.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
---
 arch/x86/include/asm/fsgsbase.h | 72 +++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/arch/x86/include/asm/fsgsbase.h b/arch/x86/include/asm/fsgsbase.h
index eb377b6e9eed..b4d4509b786c 100644
--- a/arch/x86/include/asm/fsgsbase.h
+++ b/arch/x86/include/asm/fsgsbase.h
@@ -19,6 +19,44 @@ extern unsigned long x86_gsbase_read_task(struct task_struct *task);
 extern int x86_fsbase_write_task(struct task_struct *task, unsigned long fsbase);
 extern int x86_gsbase_write_task(struct task_struct *task, unsigned long gsbase);
 
+/* Must be protected by X86_FEATURE_FSGSBASE check. */
+
+static __always_inline unsigned long rdfsbase(void)
+{
+	unsigned long fsbase;
+
+	asm volatile(".byte 0xf3, 0x48, 0x0f, 0xae, 0xc0 # rdfsbaseq %%rax"
+			: "=a" (fsbase)
+			:: "memory");
+
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
+
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
 
 static inline unsigned long x86_fsbase_read_cpu(void)
@@ -44,6 +82,40 @@ extern void x86_gsbase_write_cpu_inactive(unsigned long gsbase);
 
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
2.19.1

