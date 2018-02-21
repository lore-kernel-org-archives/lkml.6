Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932987AbeBUKW2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 05:22:28 -0500
Received: from mail.skyhub.de ([5.9.137.197]:57750 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932714AbeBUKTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 05:19:20 -0500
From: Borislav Petkov <bp@alien8.de>
To: X86 ML <x86@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/8] x86/MCE: Put private structures and definitions into the internal header
Date: Wed, 21 Feb 2018 11:18:53 +0100
Message-Id: <20180221101900.10326-2-bp@alien8.de>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20180221101900.10326-1-bp@alien8.de>
References: <20180221101900.10326-1-bp@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

... because they don't need to be exported outside of MCE.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/mce.h                | 52 -------------------------------
 arch/x86/kernel/cpu/mcheck/mce-internal.h | 52 +++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 52 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 96ea4b5ba658..c3fb9a792e13 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -138,58 +138,6 @@ struct mce_log_buffer {
 	struct mce entry[MCE_LOG_LEN];
 };
 
-struct mca_config {
-	bool dont_log_ce;
-	bool cmci_disabled;
-	bool lmce_disabled;
-	bool ignore_ce;
-	bool disabled;
-	bool ser;
-	bool recovery;
-	bool bios_cmci_threshold;
-	u8 banks;
-	s8 bootlog;
-	int tolerant;
-	int monarch_timeout;
-	int panic_timeout;
-	u32 rip_msr;
-};
-
-struct mce_vendor_flags {
-	/*
-	 * Indicates that overflow conditions are not fatal, when set.
-	 */
-	__u64 overflow_recov	: 1,
-
-	/*
-	 * (AMD) SUCCOR stands for S/W UnCorrectable error COntainment and
-	 * Recovery. It indicates support for data poisoning in HW and deferred
-	 * error interrupts.
-	 */
-	      succor		: 1,
-
-	/*
-	 * (AMD) SMCA: This bit indicates support for Scalable MCA which expands
-	 * the register space for each MCA bank and also increases number of
-	 * banks. Also, to accommodate the new banks and registers, the MCA
-	 * register space is moved to a new MSR range.
-	 */
-	      smca		: 1,
-
-	      __reserved_0	: 61;
-};
-
-struct mca_msr_regs {
-	u32 (*ctl)	(int bank);
-	u32 (*status)	(int bank);
-	u32 (*addr)	(int bank);
-	u32 (*misc)	(int bank);
-};
-
-extern struct mce_vendor_flags mce_flags;
-
-extern struct mca_msr_regs msr_ops;
-
 enum mce_notifier_prios {
 	MCE_PRIO_FIRST		= INT_MAX,
 	MCE_PRIO_SRAO		= INT_MAX - 1,
diff --git a/arch/x86/kernel/cpu/mcheck/mce-internal.h b/arch/x86/kernel/cpu/mcheck/mce-internal.h
index aa0d5df9dc60..986c8dd2d320 100644
--- a/arch/x86/kernel/cpu/mcheck/mce-internal.h
+++ b/arch/x86/kernel/cpu/mcheck/mce-internal.h
@@ -113,6 +113,58 @@ static inline void mce_register_injector_chain(struct notifier_block *nb)	{ }
 static inline void mce_unregister_injector_chain(struct notifier_block *nb)	{ }
 #endif
 
+struct mca_config {
+	bool dont_log_ce;
+	bool cmci_disabled;
+	bool lmce_disabled;
+	bool ignore_ce;
+	bool disabled;
+	bool ser;
+	bool recovery;
+	bool bios_cmci_threshold;
+	u8 banks;
+	s8 bootlog;
+	int tolerant;
+	int monarch_timeout;
+	int panic_timeout;
+	u32 rip_msr;
+};
+
 extern struct mca_config mca_cfg;
 
+struct mce_vendor_flags {
+	/*
+	 * Indicates that overflow conditions are not fatal, when set.
+	 */
+	__u64 overflow_recov	: 1,
+
+	/*
+	 * (AMD) SUCCOR stands for S/W UnCorrectable error COntainment and
+	 * Recovery. It indicates support for data poisoning in HW and deferred
+	 * error interrupts.
+	 */
+	      succor		: 1,
+
+	/*
+	 * (AMD) SMCA: This bit indicates support for Scalable MCA which expands
+	 * the register space for each MCA bank and also increases number of
+	 * banks. Also, to accommodate the new banks and registers, the MCA
+	 * register space is moved to a new MSR range.
+	 */
+	      smca		: 1,
+
+	      __reserved_0	: 61;
+};
+
+extern struct mce_vendor_flags mce_flags;
+
+struct mca_msr_regs {
+	u32 (*ctl)	(int bank);
+	u32 (*status)	(int bank);
+	u32 (*addr)	(int bank);
+	u32 (*misc)	(int bank);
+};
+
+extern struct mca_msr_regs msr_ops;
+
 #endif /* __X86_MCE_INTERNAL_H__ */
-- 
2.13.0
