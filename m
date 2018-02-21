Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932813AbeBUKTX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 05:19:23 -0500
Received: from mail.skyhub.de ([5.9.137.197]:57758 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932743AbeBUKTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 05:19:21 -0500
From: Borislav Petkov <bp@alien8.de>
To: X86 ML <x86@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/8] x86/MCE: Convert mca_config bools to a bitfield
Date: Wed, 21 Feb 2018 11:18:54 +0100
Message-Id: <20180221101900.10326-3-bp@alien8.de>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20180221101900.10326-1-bp@alien8.de>
References: <20180221101900.10326-1-bp@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

... to save space when future flags are added.

No functionality change.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/mcheck/mce-internal.h | 13 ++++++++-----
 arch/x86/kernel/cpu/mcheck/mce.c          | 16 ++++++++--------
 2 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce-internal.h b/arch/x86/kernel/cpu/mcheck/mce-internal.h
index 986c8dd2d320..ceb67cd5918f 100644
--- a/arch/x86/kernel/cpu/mcheck/mce-internal.h
+++ b/arch/x86/kernel/cpu/mcheck/mce-internal.h
@@ -116,12 +116,15 @@ static inline void mce_unregister_injector_chain(struct notifier_block *nb)	{ }
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
index 75f405ac085c..9c8cb58c77f8 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -1506,7 +1506,7 @@ static int __mcheck_cpu_cap_init(void)
 		mca_cfg.rip_msr = MSR_IA32_MCG_EIP;
 
 	if (cap & MCG_SER_P)
-		mca_cfg.ser = true;
+		mca_cfg.ser = 1;
 
 	return 0;
 }
@@ -1814,12 +1814,12 @@ void mcheck_cpu_init(struct cpuinfo_x86 *c)
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
@@ -1897,11 +1897,11 @@ static int __init mcheck_enable(char *str)
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
@@ -1909,9 +1909,9 @@ static int __init mcheck_enable(char *str)
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
@@ -2376,7 +2376,7 @@ device_initcall_sync(mcheck_init_device);
  */
 static int __init mcheck_disable(char *str)
 {
-	mca_cfg.disabled = true;
+	mca_cfg.disabled = 1;
 	return 1;
 }
 __setup("nomce", mcheck_disable);
-- 
2.13.0
