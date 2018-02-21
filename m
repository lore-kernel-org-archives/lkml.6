Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755087AbeBUR7R (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 12:59:17 -0500
Received: from terminus.zytor.com ([198.137.202.136]:59867 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933620AbeBUR7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 12:59:09 -0500
Date: Wed, 21 Feb 2018 09:58:42 -0800
From: tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-09933946643bcc8e0a9bd4ede192ed854e22db8f@git.kernel.org>
Cc: bp@suse.de, peterz@infradead.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        mingo@kernel.org, tglx@linutronix.de, bp@alien8.de,
        linux-edac@vger.kernel.org, tony.luck@intel.com
Reply-To: hpa@zytor.com, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, bp@suse.de, peterz@infradead.org,
        bp@alien8.de, linux-edac@vger.kernel.org, tony.luck@intel.com,
        mingo@kernel.org, tglx@linutronix.de
In-Reply-To: <20180221101900.10326-3-bp@alien8.de>
References: <20180221101900.10326-3-bp@alien8.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:ras/core] x86/mce: Convert 'struct mca_config' bools to a
 bitfield
Git-Commit-ID: 09933946643bcc8e0a9bd4ede192ed854e22db8f
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

Commit-ID:  09933946643bcc8e0a9bd4ede192ed854e22db8f
Gitweb:     https://git.kernel.org/tip/09933946643bcc8e0a9bd4ede192ed854e22db8f
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Wed, 21 Feb 2018 11:18:54 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 21 Feb 2018 17:00:53 +0100

x86/mce: Convert 'struct mca_config' bools to a bitfield

... to save space when future flags are added.

No functionality change.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
Link: http://lkml.kernel.org/r/20180221101900.10326-3-bp@alien8.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/cpu/mcheck/mce-internal.h | 13 ++++++++-----
 arch/x86/kernel/cpu/mcheck/mce.c          | 16 ++++++++--------
 2 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce-internal.h b/arch/x86/kernel/cpu/mcheck/mce-internal.h
index ed3c5ae..374d1aa 100644
--- a/arch/x86/kernel/cpu/mcheck/mce-internal.h
+++ b/arch/x86/kernel/cpu/mcheck/mce-internal.h
@@ -131,12 +131,15 @@ static inline void mce_unmap_kpfn(unsigned long pfn) {}
 struct mca_config {
 	bool dont_log_ce;
 	bool cmci_disabled;
-	bool lmce_disabled;
 	bool ignore_ce;
-	bool disabled;
-	bool ser;
-	bool recovery;
-	bool bios_cmci_threshold;
+
+	__u64 lmce_disabled		: 1,
+	      disabled			: 1,
+	      ser			: 1,
+	      recovery			: 1,
+	      bios_cmci_threshold	: 1,
+	      __reserved		: 59;
+
 	u8 banks;
 	s8 bootlog;
 	int tolerant;
diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index 8ff94d1..db5b1e4 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -1511,7 +1511,7 @@ static int __mcheck_cpu_cap_init(void)
 		mca_cfg.rip_msr = MSR_IA32_MCG_EIP;
 
 	if (cap & MCG_SER_P)
-		mca_cfg.ser = true;
+		mca_cfg.ser = 1;
 
 	return 0;
 }
@@ -1819,12 +1819,12 @@ void mcheck_cpu_init(struct cpuinfo_x86 *c)
 		return;
 
 	if (__mcheck_cpu_cap_init() < 0 || __mcheck_cpu_apply_quirks(c) < 0) {
-		mca_cfg.disabled = true;
+		mca_cfg.disabled = 1;
 		return;
 	}
 
 	if (mce_gen_pool_init()) {
-		mca_cfg.disabled = true;
+		mca_cfg.disabled = 1;
 		pr_emerg("Couldn't allocate MCE records pool!\n");
 		return;
 	}
@@ -1902,11 +1902,11 @@ static int __init mcheck_enable(char *str)
 	if (*str == '=')
 		str++;
 	if (!strcmp(str, "off"))
-		cfg->disabled = true;
+		cfg->disabled = 1;
 	else if (!strcmp(str, "no_cmci"))
 		cfg->cmci_disabled = true;
 	else if (!strcmp(str, "no_lmce"))
-		cfg->lmce_disabled = true;
+		cfg->lmce_disabled = 1;
 	else if (!strcmp(str, "dont_log_ce"))
 		cfg->dont_log_ce = true;
 	else if (!strcmp(str, "ignore_ce"))
@@ -1914,9 +1914,9 @@ static int __init mcheck_enable(char *str)
 	else if (!strcmp(str, "bootlog") || !strcmp(str, "nobootlog"))
 		cfg->bootlog = (str[0] == 'b');
 	else if (!strcmp(str, "bios_cmci_threshold"))
-		cfg->bios_cmci_threshold = true;
+		cfg->bios_cmci_threshold = 1;
 	else if (!strcmp(str, "recovery"))
-		cfg->recovery = true;
+		cfg->recovery = 1;
 	else if (isdigit(str[0])) {
 		if (get_option(&str, &cfg->tolerant) == 2)
 			get_option(&str, &(cfg->monarch_timeout));
@@ -2381,7 +2381,7 @@ device_initcall_sync(mcheck_init_device);
  */
 static int __init mcheck_disable(char *str)
 {
-	mca_cfg.disabled = true;
+	mca_cfg.disabled = 1;
 	return 1;
 }
 __setup("nomce", mcheck_disable);
