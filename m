Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93908C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B770206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387829AbfAPWt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 17:49:57 -0500
Received: from mga02.intel.com ([134.134.136.20]:57469 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387588AbfAPWtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 17:49:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jan 2019 14:49:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,487,1539673200"; 
   d="scan'208";a="117288396"
Received: from chang-linux-2.sc.intel.com ([10.3.52.165])
  by fmsmga008.fm.intel.com with ESMTP; 16 Jan 2019 14:49:08 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 08/13] x86/fsgsbase/64: Introduce the FIND_PERCPU_BASE macro
Date:   Wed, 16 Jan 2019 14:48:44 -0800
Message-Id: <20190116224849.8617-9-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190116224849.8617-1-chang.seok.bae@intel.com>
References: <20190116224849.8617-1-chang.seok.bae@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GSBASE is used to find per-CPU data in the kernel. But when it is unknown,
the per-CPU base can be found from the per_cpu_offset table with a CPU NR.
The CPU NR is extracted from the limit field of the CPUNODE entry in GDT,
or by the RDPID instruction.

Also, add the GAS-compatible RDPID macro.

The new macro will be used on a following patch.

Suggested-by: H. Peter Anvin <hpa@zytor.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
---
 arch/x86/include/asm/fsgsbase.h | 38 +++++++++++++++++++++++++++++++++
 arch/x86/include/asm/inst.h     | 15 +++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/arch/x86/include/asm/fsgsbase.h b/arch/x86/include/asm/fsgsbase.h
index 3611bd781088..a67531ebac35 100644
--- a/arch/x86/include/asm/fsgsbase.h
+++ b/arch/x86/include/asm/fsgsbase.h
@@ -110,6 +110,44 @@ extern void x86_gsbase_write_cpu_inactive(unsigned long gsbase);
 	MODRM 0xd0 wrgsbase_opd 1
 .endm
 
+#if CONFIG_SMP
+
+/*
+ * CPU/node NR is loaded from the limit (size) field of a special segment
+ * descriptor entry in GDT.
+ */
+.macro LOAD_CPU_AND_NODE_SEG_LIMIT reg:req
+	movq	$__CPUNODE_SEG, \reg
+	lsl	\reg, \reg
+.endm
+
+/*
+ * Fetch the per-CPU GSBASE value for this processor and put it in @reg.
+ * We normally use %gs for accessing per-CPU data, but we are setting up
+ * %gs here and obviously can not use %gs itself to access per-CPU data.
+ */
+.macro FIND_PERCPU_BASE reg:req
+	/*
+	 * The CPU/node NR is initialized earlier, directly in cpu_init().
+	 * The CPU NR is extracted from it.
+	 */
+	ALTERNATIVE \
+		"LOAD_CPU_AND_NODE_SEG_LIMIT \reg", \
+		"RDPID	\reg", \
+		X86_FEATURE_RDPID
+	andq	$VDSO_CPUNODE_MASK, \reg
+	movq	__per_cpu_offset(, \reg, 8), \reg
+.endm
+
+#else
+
+.macro FIND_PERCPU_BASE reg:req
+	/* Tracking the base offset value */
+	movq	pcpu_unit_offsets(%rip), \reg
+.endm
+
+#endif /* CONFIG_SMP */
+
 #endif /* CONFIG_X86_64 */
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/x86/include/asm/inst.h b/arch/x86/include/asm/inst.h
index f5a796da07f8..d063841a17e3 100644
--- a/arch/x86/include/asm/inst.h
+++ b/arch/x86/include/asm/inst.h
@@ -306,6 +306,21 @@
 	.endif
 	MODRM 0xc0 movq_r64_xmm_opd1 movq_r64_xmm_opd2
 	.endm
+
+.macro RDPID opd
+	REG_TYPE rdpid_opd_type \opd
+	.if rdpid_opd_type == REG_TYPE_R64
+	R64_NUM rdpid_opd \opd
+	.else
+	R32_NUM rdpid_opd \opd
+	.endif
+	.byte 0xf3
+	.if rdpid_opd > 7
+	PFX_REX rdpid_opd 0
+	.endif
+	.byte 0x0f, 0xc7
+	MODRM 0xc0 rdpid_opd 0x7
+.endm
 #endif
 
 #endif
-- 
2.19.1

