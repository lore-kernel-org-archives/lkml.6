Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936737AbeBUN2y (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 08:28:54 -0500
Received: from mail.skyhub.de ([5.9.137.197]:41360 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933705AbeBUN2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 08:28:51 -0500
Date: Wed, 21 Feb 2018 14:28:37 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ingo Molnar <mingo@kernel.org>
Cc: X86 ML <x86@kernel.org>, Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/8] x86/MCE: Put private structures and definitions into
 the internal header
Message-ID: <20180221132837.GB9989@pd.tnic>
References: <20180221101900.10326-1-bp@alien8.de>
 <20180221101900.10326-2-bp@alien8.de>
 <20180221113905.hwderlbfbx2dkisn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180221113905.hwderlbfbx2dkisn@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 12:39:05PM +0100, Ingo Molnar wrote:
> Hm, this doesn't apply to latest upstream anymore:
> 
>  Hunk #1 FAILED at 113.
>  1 out of 1 hunk FAILED -- saving rejects to file arch/x86/kernel/cpu/mcheck/mce-internal.h.rej
> 
> mind forward porting it?

Ah, you took Tony's patch in the meantime. Ok, here's a new version.
The others I'm not sending again as they should apply ok with a small
offset.

Thx.

---
From: Borislav Petkov <bp@suse.de>
Date: Mon, 20 Nov 2017 17:18:25 +0100
Subject: [PATCH] x86/MCE: Put private structures and definitions into the internal header

... because they don't need to be exported outside of MCE.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/mce.h                | 52 ----------------------------
 arch/x86/kernel/cpu/mcheck/mce-internal.h | 56 +++++++++++++++++++++++++++++--
 2 files changed, 54 insertions(+), 54 deletions(-)

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
index e956eb267061..ed3c5aee22cf 100644
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
-- 
2.13.0

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
