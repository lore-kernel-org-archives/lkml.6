Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A19C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 13:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 944652098A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 13:12:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 944652098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729245AbeIYTUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 15:20:00 -0400
Received: from mga14.intel.com ([192.55.52.115]:53075 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729112AbeIYTTs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 15:19:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Sep 2018 06:12:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,302,1534834800"; 
   d="scan'208";a="93546703"
Received: from thomasvo-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.53.212])
  by orsmga001.jf.intel.com with ESMTP; 25 Sep 2018 06:09:58 -0700
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     x86@kernel.org, platform-driver-x86@vger.kernel.org
Cc:     dave.hansen@intel.com, sean.j.christopherson@intel.com,
        nhorman@redhat.com, npmccallum@redhat.com, serge.ayoun@intel.com,
        shay.katz-zamir@intel.com, linux-sgx@vger.kernel.org,
        andriy.shevchenko@linux.intel.com,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        David Wang <davidwang@zhaoxin.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>,
        Jia Zhang <qianyue.zj@alibaba-inc.com>,
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT))
Subject: [PATCH v14 04/19] x86/cpufeatures: Add SGX feature bits
Date:   Tue, 25 Sep 2018 16:06:41 +0300
Message-Id: <20180925130845.9962-5-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180925130845.9962-1-jarkko.sakkinen@linux.intel.com>
References: <20180925130845.9962-1-jarkko.sakkinen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

Add SGX feature bits as part of the Linux defined leaf 8, which
currently contains virtualization flags.  There are currently four
documented SGX feature bits, with more expected in the not-too-distant
future.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Co-developed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 arch/x86/include/asm/cpufeatures.h |  8 +++++-
 arch/x86/kernel/cpu/intel.c        | 40 ++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 7bb647f57d42..d6f4abe6d0b0 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -233,6 +233,12 @@
 #define X86_FEATURE_XENPV		( 8*32+16) /* "" Xen paravirtual guest */
 #define X86_FEATURE_EPT_AD		( 8*32+17) /* Intel Extended Page Table access-dirty bit */
 
+/* SGX flags: Linux defined, word 8 */
+#define X86_FEATURE_SGX1		( 8*32+24) /* SGX1 leaf functions */
+#define X86_FEATURE_SGX2		( 8*32+25) /* SGX2 leaf functions */
+#define X86_FEATURE_SGX_ENCLV		( 8*32+26) /* SGX ENCLV instruction, leafs E[INC|DEC]VIRTCHILD, ESETCONTEXT */
+#define X86_FEATURE_SGX_ENCLS_C		( 8*32+27) /* SGX ENCLS leafs ERDINFO, ETRACK, ELDBC and ELDUC */
+
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (EBX), word 9 */
 #define X86_FEATURE_FSGSBASE		( 9*32+ 0) /* RDFSBASE, WRFSBASE, RDGSBASE, WRGSBASE instructions*/
 #define X86_FEATURE_TSC_ADJUST		( 9*32+ 1) /* TSC adjustment MSR 0x3B */
@@ -332,7 +338,7 @@
 #define X86_FEATURE_LA57		(16*32+16) /* 5-level page tables */
 #define X86_FEATURE_RDPID		(16*32+22) /* RDPID instruction */
 #define X86_FEATURE_CLDEMOTE		(16*32+25) /* CLDEMOTE instruction */
-#define X86_FEATURE_SGX_LC		(16*32+30) /* supports SGX launch configuration */
+#define X86_FEATURE_SGX_LC		(16*32+30) /* supports SGX launch control */
 
 /* AMD-defined CPU features, CPUID level 0x80000007 (EBX), word 17 */
 #define X86_FEATURE_OVERFLOW_RECOV	(17*32+ 0) /* MCA overflow recovery support */
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index fc3c07fe7df5..fcf188d5f9df 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -19,6 +19,7 @@
 #include <asm/microcode_intel.h>
 #include <asm/hwcap2.h>
 #include <asm/elf.h>
+#include <asm/sgx_arch.h>
 
 #ifdef CONFIG_X86_64
 #include <linux/topology.h>
@@ -512,6 +513,42 @@ static void detect_vmx_virtcap(struct cpuinfo_x86 *c)
 	}
 }
 
+static void detect_sgx(struct cpuinfo_x86 *c)
+{
+#define _X86_FEATURE_SGX1		BIT(0)
+#define _X86_FEATURE_SGX2		BIT(1)
+#define _X86_FEATURE_SGX_ENCLV		BIT(5)
+#define _X86_FEATURE_SGX_ENCLS_C	BIT(6)
+
+	unsigned int eax;
+
+	clear_cpu_cap(c, X86_FEATURE_SGX1);
+	clear_cpu_cap(c, X86_FEATURE_SGX2);
+	clear_cpu_cap(c, X86_FEATURE_SGX_ENCLV);
+	clear_cpu_cap(c, X86_FEATURE_SGX_ENCLS_C);
+
+	if (c->cpuid_level < SGX_CPUID) {
+		pr_err_once("x86/sgx: cannot enumerate CPUID leaf (0x%x)\n",
+			    SGX_CPUID);
+		clear_cpu_cap(c, X86_FEATURE_SGX);
+		return;
+	}
+
+	eax = cpuid_eax(SGX_CPUID);
+
+	if (eax & _X86_FEATURE_SGX1)
+		set_cpu_cap(c, X86_FEATURE_SGX1);
+
+	if (eax & _X86_FEATURE_SGX2)
+		set_cpu_cap(c, X86_FEATURE_SGX2);
+
+	if (eax & _X86_FEATURE_SGX_ENCLV)
+		set_cpu_cap(c, X86_FEATURE_SGX_ENCLV);
+
+	if (eax & _X86_FEATURE_SGX_ENCLS_C)
+		set_cpu_cap(c, X86_FEATURE_SGX_ENCLS_C);
+}
+
 #define MSR_IA32_TME_ACTIVATE		0x982
 
 /* Helpers to access TME_ACTIVATE MSR */
@@ -760,6 +797,9 @@ static void init_intel(struct cpuinfo_x86 *c)
 	if (cpu_has(c, X86_FEATURE_VMX))
 		detect_vmx_virtcap(c);
 
+	if (cpu_has(c, X86_FEATURE_SGX))
+		detect_sgx(c);
+
 	if (cpu_has(c, X86_FEATURE_TME))
 		detect_tme(c);
 
-- 
2.17.1

