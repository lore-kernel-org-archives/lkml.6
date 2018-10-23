Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BC7C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4762C20665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:44:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4762C20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbeJXDId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 23:08:33 -0400
Received: from mga05.intel.com ([192.55.52.43]:55088 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728876AbeJXDIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 23:08:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2018 11:43:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,417,1534834800"; 
   d="scan'208";a="243726587"
Received: from chang-linux-2.sc.intel.com ([10.3.52.139])
  by orsmga004.jf.intel.com with ESMTP; 23 Oct 2018 11:43:27 -0700
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
Subject: [v3 07/12] x86/fsgsbase/64: Introduce the new FIND_PERCPU_BASE macro
Date:   Tue, 23 Oct 2018 11:42:29 -0700
Message-Id: <20181023184234.14025-8-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181023184234.14025-1-chang.seok.bae@intel.com>
References: <20181023184234.14025-1-chang.seok.bae@intel.com>
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
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/fsgsbase.h | 52 +++++++++++++++++++++++++++++++++
 arch/x86/include/asm/inst.h     | 15 ++++++++++
 2 files changed, 67 insertions(+)

diff --git a/arch/x86/include/asm/fsgsbase.h b/arch/x86/include/asm/fsgsbase.h
index e500d771155f..0c2d7d8a8c01 100644
--- a/arch/x86/include/asm/fsgsbase.h
+++ b/arch/x86/include/asm/fsgsbase.h
@@ -111,6 +111,58 @@ extern void x86_gsbase_write_cpu_inactive(unsigned long gsbase);
 	MODRM 0xd0 wrgsbase_opd 1
 .endm
 
+#if CONFIG_SMP
+
+/*
+ * Fetch the per-CPU GSBASE value for this processor and put it in @reg.
+ * We normally use %gs for accessing per-CPU data, but we are setting up
+ * %gs here and obviously can not use %gs itself to access per-CPU data.
+ */
+.macro FIND_PERCPU_BASE_RDPID reg:req
+	/*
+	 * The CPU/node NR is initialized earlier, directly in cpu_init().
+	 * The CPU NR is extracted from it.
+	 */
+	RDPID	\reg
+	andq	$VDSO_CPUNODE_MASK, \reg
+
+	/*
+	 * The kernel GSBASE value is found from the __per_cpu_offset table
+	 * with the CPU NR.
+	 */
+	movq	__per_cpu_offset(, \reg, 8), \reg
+.endm
+
+/*
+ * Same as above FIND_PERCPU_BASERDPID, except that CPU/node NR is loaded
+ * from the limit (size) field of a special segment descriptor entry in
+ * GDT.
+ */
+.macro FIND_PERCPU_BASE_SEG_LIMIT reg:req
+	/* Read CPU NR */
+	movq	$__CPUNODE_SEG, \reg
+	lsl	\reg, \reg
+	andq	$VDSO_CPUNODE_MASK, \reg
+
+	movq	__per_cpu_offset(, \reg, 8), \reg
+.endm
+
+.macro FIND_PERCPU_BASE reg:req
+	ALTERNATIVE \
+		"FIND_PERCPU_BASE_SEG_LIMIT \reg", \
+		"FIND_PERCPU_BASE_RDPID \reg", \
+		X86_FEATURE_RDPID
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

