Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751764AbeCLMXU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 08:23:20 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35605 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751502AbeCLMXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 08:23:18 -0400
Date: Mon, 12 Mar 2018 05:21:54 -0700
From: "tip-bot for Kirill A. Shutemov" <tipbot@zytor.com>
Message-ID: <tip-cb06d8e3d020c30fe10ae711c925a5319ab82c88@git.kernel.org>
Cc: thomas.lendacky@amd.com, kai.huang@linux.intel.com,
        kirill.shutemov@linux.intel.com, tglx@linutronix.de,
        torvalds@linux-foundation.org, hpa@zytor.com, peterz@infradead.org,
        dave.hansen@intel.com, linux-kernel@vger.kernel.org, mingo@kernel.org
Reply-To: dave.hansen@intel.com, peterz@infradead.org, hpa@zytor.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, kirill.shutemov@linux.intel.com,
        kai.huang@linux.intel.com, thomas.lendacky@amd.com
In-Reply-To: <20180305162610.37510-3-kirill.shutemov@linux.intel.com>
References: <20180305162610.37510-3-kirill.shutemov@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/tme: Detect if TME and MKTME is activated by BIOS
Git-Commit-ID: cb06d8e3d020c30fe10ae711c925a5319ab82c88
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  cb06d8e3d020c30fe10ae711c925a5319ab82c88
Gitweb:     https://git.kernel.org/tip/cb06d8e3d020c30fe10ae711c925a5319ab82c88
Author:     Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate: Mon, 5 Mar 2018 19:25:50 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 12 Mar 2018 12:10:54 +0100

x86/tme: Detect if TME and MKTME is activated by BIOS

IA32_TME_ACTIVATE MSR (0x982) can be used to check if BIOS has enabled
TME and MKTME. It includes which encryption policy/algorithm is selected
for TME or available for MKTME. For MKTME, the MSR also enumerates how
many KeyIDs are available.

We would need to exclude KeyID bits from physical address bits.
detect_tme() would adjust cpuinfo_x86::x86_phys_bits accordingly.

We have to do this even if we are not going to use KeyID bits
ourself. VM guests still have to know that these bits are not usable
for physical address.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Kai Huang <kai.huang@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-mm@kvack.org
Link: http://lkml.kernel.org/r/20180305162610.37510-3-kirill.shutemov@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/cpu/intel.c | 90 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 4aa9fd379390..b862067bb33c 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -510,6 +510,93 @@ static void detect_vmx_virtcap(struct cpuinfo_x86 *c)
 	}
 }
 
+#define MSR_IA32_TME_ACTIVATE		0x982
+
+/* Helpers to access TME_ACTIVATE MSR */
+#define TME_ACTIVATE_LOCKED(x)		(x & 0x1)
+#define TME_ACTIVATE_ENABLED(x)		(x & 0x2)
+
+#define TME_ACTIVATE_POLICY(x)		((x >> 4) & 0xf)	/* Bits 7:4 */
+#define TME_ACTIVATE_POLICY_AES_XTS_128	0
+
+#define TME_ACTIVATE_KEYID_BITS(x)	((x >> 32) & 0xf)	/* Bits 35:32 */
+
+#define TME_ACTIVATE_CRYPTO_ALGS(x)	((x >> 48) & 0xffff)	/* Bits 63:48 */
+#define TME_ACTIVATE_CRYPTO_AES_XTS_128	1
+
+/* Values for mktme_status (SW only construct) */
+#define MKTME_ENABLED			0
+#define MKTME_DISABLED			1
+#define MKTME_UNINITIALIZED		2
+static int mktme_status = MKTME_UNINITIALIZED;
+
+static void detect_tme(struct cpuinfo_x86 *c)
+{
+	u64 tme_activate, tme_policy, tme_crypto_algs;
+	int keyid_bits = 0, nr_keyids = 0;
+	static u64 tme_activate_cpu0 = 0;
+
+	rdmsrl(MSR_IA32_TME_ACTIVATE, tme_activate);
+
+	if (mktme_status != MKTME_UNINITIALIZED) {
+		if (tme_activate != tme_activate_cpu0) {
+			/* Broken BIOS? */
+			pr_err_once("x86/tme: configuation is inconsistent between CPUs\n");
+			pr_err_once("x86/tme: MKTME is not usable\n");
+			mktme_status = MKTME_DISABLED;
+
+			/* Proceed. We may need to exclude bits from x86_phys_bits. */
+		}
+	} else {
+		tme_activate_cpu0 = tme_activate;
+	}
+
+	if (!TME_ACTIVATE_LOCKED(tme_activate) || !TME_ACTIVATE_ENABLED(tme_activate)) {
+		pr_info_once("x86/tme: not enabled by BIOS\n");
+		mktme_status = MKTME_DISABLED;
+		return;
+	}
+
+	if (mktme_status != MKTME_UNINITIALIZED)
+		goto detect_keyid_bits;
+
+	pr_info("x86/tme: enabled by BIOS\n");
+
+	tme_policy = TME_ACTIVATE_POLICY(tme_activate);
+	if (tme_policy != TME_ACTIVATE_POLICY_AES_XTS_128)
+		pr_warn("x86/tme: Unknown policy is active: %#llx\n", tme_policy);
+
+	tme_crypto_algs = TME_ACTIVATE_CRYPTO_ALGS(tme_activate);
+	if (!(tme_crypto_algs & TME_ACTIVATE_CRYPTO_AES_XTS_128)) {
+		pr_err("x86/mktme: No known encryption algorithm is supported: %#llx\n",
+				tme_crypto_algs);
+		mktme_status = MKTME_DISABLED;
+	}
+detect_keyid_bits:
+	keyid_bits = TME_ACTIVATE_KEYID_BITS(tme_activate);
+	nr_keyids = (1UL << keyid_bits) - 1;
+	if (nr_keyids) {
+		pr_info_once("x86/mktme: enabled by BIOS\n");
+		pr_info_once("x86/mktme: %d KeyIDs available\n", nr_keyids);
+	} else {
+		pr_info_once("x86/mktme: disabled by BIOS\n");
+	}
+
+	if (mktme_status == MKTME_UNINITIALIZED) {
+		/* MKTME is usable */
+		mktme_status = MKTME_ENABLED;
+	}
+
+	/*
+	 * Exclude KeyID bits from physical address bits.
+	 *
+	 * We have to do this even if we are not going to use KeyID bits
+	 * ourself. VM guests still have to know that these bits are not usable
+	 * for physical address.
+	 */
+	c->x86_phys_bits -= keyid_bits;
+}
+
 static void init_intel_energy_perf(struct cpuinfo_x86 *c)
 {
 	u64 epb;
@@ -680,6 +767,9 @@ static void init_intel(struct cpuinfo_x86 *c)
 	if (cpu_has(c, X86_FEATURE_VMX))
 		detect_vmx_virtcap(c);
 
+	if (cpu_has(c, X86_FEATURE_TME))
+		detect_tme(c);
+
 	init_intel_energy_perf(c);
 
 	init_intel_misc_features(c);
