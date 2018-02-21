Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938906AbeBUR6q (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 12:58:46 -0500
Received: from terminus.zytor.com ([198.137.202.136]:55455 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933574AbeBUR6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 12:58:44 -0500
Date: Wed, 21 Feb 2018 09:58:13 -0800
From: tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-a189c03235639a31343215f82b83b49985c55336@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        torvalds@linux-foundation.org, tony.luck@intel.com,
        peterz@infradead.org, bp@suse.de, hpa@zytor.com, bp@alien8.de,
        tglx@linutronix.de, mingo@kernel.org
Reply-To: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        hpa@zytor.com, peterz@infradead.org, bp@suse.de, tony.luck@intel.com,
        torvalds@linux-foundation.org, tglx@linutronix.de, bp@alien8.de,
        mingo@kernel.org
In-Reply-To: <20180221101900.10326-2-bp@alien8.de>
References: <20180221101900.10326-2-bp@alien8.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:ras/core] x86/mce: Put private structures and definitions into
 the internal header
Git-Commit-ID: a189c03235639a31343215f82b83b49985c55336
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

Commit-ID:  a189c03235639a31343215f82b83b49985c55336
Gitweb:     https://git.kernel.org/tip/a189c03235639a31343215f82b83b49985c55336
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Wed, 21 Feb 2018 11:18:53 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 21 Feb 2018 17:00:53 +0100

x86/mce: Put private structures and definitions into the internal header

... because they don't need to be exported outside of MCE.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
Link: http://lkml.kernel.org/r/20180221101900.10326-2-bp@alien8.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/mce.h                | 52 ----------------------------
 arch/x86/kernel/cpu/mcheck/mce-internal.h | 56 +++++++++++++++++++++++++++++--
 2 files changed, 54 insertions(+), 54 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 96ea4b5..c3fb9a7 100644
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
index e956eb2..ed3c5ae 100644
--- a/arch/x86/kernel/cpu/mcheck/mce-internal.h
+++ b/arch/x86/kernel/cpu/mcheck/mce-internal.h
@@ -113,8 +113,6 @@ static inline void mce_register_injector_chain(struct notifier_block *nb)	{ }
 static inline void mce_unregister_injector_chain(struct notifier_block *nb)	{ }
 #endif
 
-extern struct mca_config mca_cfg;
-
 #ifndef CONFIG_X86_64
 /*
  * On 32-bit systems it would be difficult to safely unmap a poison page
@@ -130,4 +128,58 @@ static inline void mce_unmap_kpfn(unsigned long pfn) {}
 #define mce_unmap_kpfn mce_unmap_kpfn
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
+extern struct mca_config mca_cfg;
+
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
