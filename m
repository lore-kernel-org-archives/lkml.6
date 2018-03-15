Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752551AbeCONtR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 09:49:17 -0400
Received: from mga01.intel.com ([192.55.52.88]:25962 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752369AbeCONtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 09:49:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,310,1517904000";
   d="scan'208";a="24308072"
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Cc: Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 2/2] x86/mm: Do not lose cpuinfo_x86:x86_phys_bits adjustment
Date: Thu, 15 Mar 2018 16:49:07 +0300
Message-Id: <20180315134907.9311-3-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180315134907.9311-1-kirill.shutemov@linux.intel.com>
References: <20180315134907.9311-1-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some features (Intel MKTME, AMD SME) may reduce number of effectively
available physical address bits. We adjust x86_phys_bits accordingly.

But if get_cpu_cap() got called more than one time we may lose this
information.

That's exactly what happens in setup_pku(): it gets called after
detect_tme() and x86_phys_bits gets overwritten.

Add x86_phys_bits_adj which stores by how many bits we should reduce
x86_phys_bits comparing to what CPUID returns.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reported-by: Kai Huang <kai.huang@linux.intel.com>
Fixes: cb06d8e3d020 ("x86/tme: Detect if TME and MKTME is activated by BIOS")
---
 arch/x86/include/asm/processor.h |  1 +
 arch/x86/kernel/cpu/amd.c        |  3 ++-
 arch/x86/kernel/cpu/common.c     | 14 ++++++++++++++
 arch/x86/kernel/cpu/intel.c      |  1 +
 4 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index b0ccd4847a58..1250547c8eb7 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -98,6 +98,7 @@ struct cpuinfo_x86 {
 #endif
 	__u8			x86_virt_bits;
 	__u8			x86_phys_bits;
+	__u8			x86_phys_bits_adj;
 	/* CPUID returned core id bits: */
 	__u8			x86_coreid_bits;
 	__u8			cu_id;
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 12bc0a1139da..4d0ec075f99e 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -583,7 +583,8 @@ static void early_detect_mem_encrypt(struct cpuinfo_x86 *c)
 		 * will be a value above 32-bits this is still done for
 		 * CONFIG_X86_32 so that accurate values are reported.
 		 */
-		c->x86_phys_bits -= (cpuid_ebx(0x8000001f) >> 6) & 0x3f;
+		c->x86_phys_bits_adj = (cpuid_ebx(0x8000001f) >> 6) & 0x3f;
+		c->x86_phys_bits -= c->x86_phys_bits_adj;
 
 		if (IS_ENABLED(CONFIG_X86_32))
 			goto clear_all;
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 348cf4821240..d2e3dd827691 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -854,6 +854,20 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
 		c->x86_virt_bits = (eax >> 8) & 0xff;
 		c->x86_phys_bits = eax & 0xff;
 		c->x86_capability[CPUID_8000_0008_EBX] = ebx;
+
+		/*
+		 * Some features (Intel MKTME, AMD SME) may reduce number
+		 * of effectively available physical address bits.
+		 *
+		 * We adjust x86_phys_bits accordingly.
+		 *
+		 * But if get_cpu_cap() got called more than one time we
+		 * may lose this information.
+		 *
+		 * x86_phys_bits_adj stores by how many bits we should
+		 * reduce x86_phys_bits comparing to what CPUID returns.
+		 */
+		c->x86_phys_bits -= c->x86_phys_bits_adj;
 	}
 #ifdef CONFIG_X86_32
 	else if (cpu_has(c, X86_FEATURE_PAE) || cpu_has(c, X86_FEATURE_PSE36))
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index fd379358c58d..801c2e42b87d 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -623,6 +623,7 @@ static void detect_tme(struct cpuinfo_x86 *c)
 	 * Let's update cpuinfo_x86::x86_phys_bits to reflect the fact.
 	 */
 	c->x86_phys_bits -= keyid_bits;
+	c->x86_phys_bits_adj = keyid_bits;
 }
 
 static void init_intel_energy_perf(struct cpuinfo_x86 *c)
-- 
2.16.1
