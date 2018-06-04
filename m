Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751890AbeFDChp (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 22:37:45 -0400
Received: from ZXSHCAS1.zhaoxin.com ([203.148.12.81]:53074 "EHLO
        ZXSHCAS1.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751412AbeFDChn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 22:37:43 -0400
From: David Wang <davidwang@zhaoxin.com>
To: <bp@alien8.de>, <tony.luck@intel.com>, <mingo@redhat.com>,
        <tglx@linutronix.de>, <hpa@zytor.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
CC: <cooperyan@zhaoxin.com>, <qiyuanwang@zhaoxin.com>,
        <benjaminpan@viatech.com>, <lukelin@viacpu.com>, <timguo@zhaoxin.com>,
        "David Wang" <davidwang@zhaoxin.com>
Subject: [PATCH v2] x86/mce: add CMCI support for Centaur CPUs
Date: Mon, 4 Jun 2018 10:37:33 +0800
Message-ID: <1528079853-8101-1-git-send-email-davidwang@zhaoxin.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.29.8.54]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx3.zhaoxin.com (10.29.252.165)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New Centaur CPU support CMCI mechanism, which is compatible with INTEL CMCI.

Signed-off-by: David Wang <davidwang@zhaoxin.com>

Changes from v1 to v2:
*1, add vendor check for Centaur CPU in cmci_supported.
*2, Only call intel_init_cmci for Centaur CPU in mce_intel_feature_init function.
---
 arch/x86/Kconfig                       | 12 ++++++++++++
 arch/x86/kernel/cpu/mcheck/mce.c       |  6 ++++++
 arch/x86/kernel/cpu/mcheck/mce_intel.c | 21 ++++++++++++++++-----
 3 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index dda87a3..1adff5f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1130,6 +1130,18 @@ config X86_MCE_AMD
 	   Additional support for AMD specific MCE features such as
 	   the DRAM Error Threshold.
 
+config X86_MCE_CENTAUR
+	def_bool y
+	prompt "CENTAUR MCE features"
+	depends on CPU_SUP_CENTAUR && X86_MCE_INTEL
+	help
+	   Additional support for Centaur specific MCE features such as
+	   MCE broadcasting and CMCI support.
+	   New Centaur CPU support MCE broadcasting.
+	   New Centaur CPU support CMCI which is fully compliant with Intel CMCI.
+
+	   If unsure, say N here.
+
 config X86_ANCIENT_MCE
 	bool "Support for old Pentium 5 / WinChip machine checks"
 	depends on X86_32 && X86_MCE
diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index cd76380..2ebafc7 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -1727,6 +1727,7 @@ static void __mcheck_cpu_init_early(struct cpuinfo_x86 *c)
 	}
 }
 
+#ifdef CONFIG_X86_MCE_CENTAUR
 static void mce_centaur_feature_init(struct cpuinfo_x86 *c)
 {
 	struct mca_config *cfg = &mca_cfg;
@@ -1740,7 +1741,12 @@ static void mce_centaur_feature_init(struct cpuinfo_x86 *c)
 		if (cfg->monarch_timeout < 0)
 			cfg->monarch_timeout = USEC_PER_SEC;
 	}
+	mce_intel_feature_init(c);
+	mce_adjust_timer = cmci_intel_adjust_timer;
 }
+#else
+static inline void mce_centaur_feature_init(struct cpuinfo_x86 *c) { }
+#endif
 
 static void __mcheck_cpu_init_vendor(struct cpuinfo_x86 *c)
 {
diff --git a/arch/x86/kernel/cpu/mcheck/mce_intel.c b/arch/x86/kernel/cpu/mcheck/mce_intel.c
index d05be30..5b1b68f 100644
--- a/arch/x86/kernel/cpu/mcheck/mce_intel.c
+++ b/arch/x86/kernel/cpu/mcheck/mce_intel.c
@@ -85,7 +85,8 @@ static int cmci_supported(int *banks)
 	 * initialization is vendor keyed and this
 	 * makes sure none of the backdoors are entered otherwise.
 	 */
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
+	if ((boot_cpu_data.x86_vendor != X86_VENDOR_INTEL &&
+		boot_cpu_data.x86_vendor != X86_VENDOR_CENTAUR))
 		return 0;
 	if (!boot_cpu_has(X86_FEATURE_APIC) || lapic_get_maxlvt() < 6)
 		return 0;
@@ -506,10 +507,20 @@ static void intel_ppin_init(struct cpuinfo_x86 *c)
 
 void mce_intel_feature_init(struct cpuinfo_x86 *c)
 {
-	intel_init_thermal(c);
-	intel_init_cmci();
-	intel_init_lmce();
-	intel_ppin_init(c);
+
+	switch (c->x86_vendor) {
+	case X86_VENDOR_INTEL:
+		intel_init_thermal(c);
+		intel_init_cmci();
+		intel_init_lmce();
+		intel_ppin_init(c);
+		break;
+	case X86_VENDOR_CENTAUR:
+		intel_init_cmci();
+		break;
+	default:
+		break;
+	}
 }
 
 void mce_intel_feature_clear(struct cpuinfo_x86 *c)
-- 
1.9.1
