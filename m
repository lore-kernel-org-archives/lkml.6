Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A6DECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F67F20880
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:52:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F67F20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389285AbeGWNrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:47:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51134 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388197AbeGWNro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:47:44 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D75F7BCF;
        Mon, 23 Jul 2018 12:45:15 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Woodhouse <dwmw@amazon.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        gnomes@lxorguk.ukuu.org.uk, ak@linux.intel.com,
        ashok.raj@intel.com, dave.hansen@intel.com, karahmed@amazon.de,
        arjan@linux.intel.com, torvalds@linux-foundation.org,
        peterz@infradead.org, bp@alien8.de, pbonzini@redhat.com,
        tim.c.chen@linux.intel.com,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        "Matt Helsley (VMware)" <matt.helsley@gmail.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Bo Gan <ganb@vmware.com>, gregkh@linux-foundation.org
Subject: [PATCH 4.4 024/107] x86/cpufeature: Blacklist SPEC_CTRL/PRED_CMD on early Spectre v2 microcodes
Date:   Mon, 23 Jul 2018 14:41:18 +0200
Message-Id: <20180723122414.061577328@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723122413.003644357@linuxfoundation.org>
References: <20180723122413.003644357@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Woodhouse <dwmw@amazon.co.uk>

(cherry picked from commit a5b2966364538a0e68c9fa29bc0a3a1651799035)

This doesn't refuse to load the affected microcodes; it just refuses to
use the Spectre v2 mitigation features if they're detected, by clearing
the appropriate feature bits.

The AMD CPUID bits are handled here too, because hypervisors *may* have
been exposing those bits even on Intel chips, for fine-grained control
of what's available.

It is non-trivial to use x86_match_cpu() for this table because that
doesn't handle steppings. And the approach taken in commit bd9240a18
almost made me lose my lunch.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: gnomes@lxorguk.ukuu.org.uk
Cc: ak@linux.intel.com
Cc: ashok.raj@intel.com
Cc: dave.hansen@intel.com
Cc: karahmed@amazon.de
Cc: arjan@linux.intel.com
Cc: torvalds@linux-foundation.org
Cc: peterz@infradead.org
Cc: bp@alien8.de
Cc: pbonzini@redhat.com
Cc: tim.c.chen@linux.intel.com
Cc: gregkh@linux-foundation.org
Link: https://lkml.kernel.org/r/1516896855-7642-7-git-send-email-dwmw@amazon.co.uk
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Srivatsa S. Bhat <srivatsa@csail.mit.edu>
Reviewed-by: Matt Helsley (VMware) <matt.helsley@gmail.com>
Reviewed-by: Alexey Makhalov <amakhalov@vmware.com>
Reviewed-by: Bo Gan <ganb@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

 arch/x86/include/asm/intel-family.h |    5 ++
 arch/x86/kernel/cpu/intel.c         |   67 ++++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+), 1 deletion(-)

--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -12,6 +12,7 @@
  */
 
 #define INTEL_FAM6_CORE_YONAH		0x0E
+
 #define INTEL_FAM6_CORE2_MEROM		0x0F
 #define INTEL_FAM6_CORE2_MEROM_L	0x16
 #define INTEL_FAM6_CORE2_PENRYN		0x17
@@ -20,6 +21,7 @@
 #define INTEL_FAM6_NEHALEM		0x1E
 #define INTEL_FAM6_NEHALEM_EP		0x1A
 #define INTEL_FAM6_NEHALEM_EX		0x2E
+
 #define INTEL_FAM6_WESTMERE		0x25
 #define INTEL_FAM6_WESTMERE2		0x1F
 #define INTEL_FAM6_WESTMERE_EP		0x2C
@@ -36,9 +38,9 @@
 #define INTEL_FAM6_HASWELL_GT3E		0x46
 
 #define INTEL_FAM6_BROADWELL_CORE	0x3D
-#define INTEL_FAM6_BROADWELL_XEON_D	0x56
 #define INTEL_FAM6_BROADWELL_GT3E	0x47
 #define INTEL_FAM6_BROADWELL_X		0x4F
+#define INTEL_FAM6_BROADWELL_XEON_D	0x56
 
 #define INTEL_FAM6_SKYLAKE_MOBILE	0x4E
 #define INTEL_FAM6_SKYLAKE_DESKTOP	0x5E
@@ -60,6 +62,7 @@
 #define INTEL_FAM6_ATOM_MERRIFIELD2	0x5A /* Annidale */
 #define INTEL_FAM6_ATOM_GOLDMONT	0x5C
 #define INTEL_FAM6_ATOM_DENVERTON	0x5F /* Goldmont Microserver */
+#define INTEL_FAM6_ATOM_GEMINI_LAKE	0x7A
 
 /* Xeon Phi */
 
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -13,6 +13,7 @@
 #include <asm/msr.h>
 #include <asm/bugs.h>
 #include <asm/cpu.h>
+#include <asm/intel-family.h>
 
 #ifdef CONFIG_X86_64
 #include <linux/topology.h>
@@ -25,6 +26,59 @@
 #include <asm/apic.h>
 #endif
 
+/*
+ * Early microcode releases for the Spectre v2 mitigation were broken.
+ * Information taken from;
+ * - https://newsroom.intel.com/wp-content/uploads/sites/11/2018/01/microcode-update-guidance.pdf
+ * - https://kb.vmware.com/s/article/52345
+ * - Microcode revisions observed in the wild
+ * - Release note from 20180108 microcode release
+ */
+struct sku_microcode {
+	u8 model;
+	u8 stepping;
+	u32 microcode;
+};
+static const struct sku_microcode spectre_bad_microcodes[] = {
+	{ INTEL_FAM6_KABYLAKE_DESKTOP,	0x0B,	0x84 },
+	{ INTEL_FAM6_KABYLAKE_DESKTOP,	0x0A,	0x84 },
+	{ INTEL_FAM6_KABYLAKE_DESKTOP,	0x09,	0x84 },
+	{ INTEL_FAM6_KABYLAKE_MOBILE,	0x0A,	0x84 },
+	{ INTEL_FAM6_KABYLAKE_MOBILE,	0x09,	0x84 },
+	{ INTEL_FAM6_SKYLAKE_X,		0x03,	0x0100013e },
+	{ INTEL_FAM6_SKYLAKE_X,		0x04,	0x0200003c },
+	{ INTEL_FAM6_SKYLAKE_MOBILE,	0x03,	0xc2 },
+	{ INTEL_FAM6_SKYLAKE_DESKTOP,	0x03,	0xc2 },
+	{ INTEL_FAM6_BROADWELL_CORE,	0x04,	0x28 },
+	{ INTEL_FAM6_BROADWELL_GT3E,	0x01,	0x1b },
+	{ INTEL_FAM6_BROADWELL_XEON_D,	0x02,	0x14 },
+	{ INTEL_FAM6_BROADWELL_XEON_D,	0x03,	0x07000011 },
+	{ INTEL_FAM6_BROADWELL_X,	0x01,	0x0b000025 },
+	{ INTEL_FAM6_HASWELL_ULT,	0x01,	0x21 },
+	{ INTEL_FAM6_HASWELL_GT3E,	0x01,	0x18 },
+	{ INTEL_FAM6_HASWELL_CORE,	0x03,	0x23 },
+	{ INTEL_FAM6_HASWELL_X,		0x02,	0x3b },
+	{ INTEL_FAM6_HASWELL_X,		0x04,	0x10 },
+	{ INTEL_FAM6_IVYBRIDGE_X,	0x04,	0x42a },
+	/* Updated in the 20180108 release; blacklist until we know otherwise */
+	{ INTEL_FAM6_ATOM_GEMINI_LAKE,	0x01,	0x22 },
+	/* Observed in the wild */
+	{ INTEL_FAM6_SANDYBRIDGE_X,	0x06,	0x61b },
+	{ INTEL_FAM6_SANDYBRIDGE_X,	0x07,	0x712 },
+};
+
+static bool bad_spectre_microcode(struct cpuinfo_x86 *c)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(spectre_bad_microcodes); i++) {
+		if (c->x86_model == spectre_bad_microcodes[i].model &&
+		    c->x86_mask == spectre_bad_microcodes[i].stepping)
+			return (c->microcode <= spectre_bad_microcodes[i].microcode);
+	}
+	return false;
+}
+
 static void early_init_intel(struct cpuinfo_x86 *c)
 {
 	u64 misc_enable;
@@ -51,6 +105,19 @@ static void early_init_intel(struct cpui
 		rdmsr(MSR_IA32_UCODE_REV, lower_word, c->microcode);
 	}
 
+	if ((cpu_has(c, X86_FEATURE_SPEC_CTRL) ||
+	     cpu_has(c, X86_FEATURE_STIBP) ||
+	     cpu_has(c, X86_FEATURE_AMD_SPEC_CTRL) ||
+	     cpu_has(c, X86_FEATURE_AMD_PRED_CMD) ||
+	     cpu_has(c, X86_FEATURE_AMD_STIBP)) && bad_spectre_microcode(c)) {
+		pr_warn("Intel Spectre v2 broken microcode detected; disabling SPEC_CTRL\n");
+		clear_cpu_cap(c, X86_FEATURE_SPEC_CTRL);
+		clear_cpu_cap(c, X86_FEATURE_STIBP);
+		clear_cpu_cap(c, X86_FEATURE_AMD_SPEC_CTRL);
+		clear_cpu_cap(c, X86_FEATURE_AMD_PRED_CMD);
+		clear_cpu_cap(c, X86_FEATURE_AMD_STIBP);
+	}
+
 	/*
 	 * Atom erratum AAE44/AAF40/AAG38/AAH41:
 	 *


