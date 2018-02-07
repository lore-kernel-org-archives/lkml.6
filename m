Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754512AbeBGO7c (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 09:59:32 -0500
Received: from mga03.intel.com ([134.134.136.65]:6211 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754151AbeBGO72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 09:59:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,473,1511856000";
   d="scan'208";a="28890326"
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc: Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [RFC 3/3] x86/mm/encrypt: Convert sme_me_mask to patchable constant
Date: Wed,  7 Feb 2018 17:59:13 +0300
Message-Id: <20180207145913.2703-4-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180207145913.2703-1-kirill.shutemov@linux.intel.com>
References: <20180207145913.2703-1-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We only change sme_me_mask very early in boot. It may be a candidate for
conversion to patchable constant.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/mem_encrypt.h |  5 ++++-
 arch/x86/kernel/patchable_const.c  |  2 ++
 arch/x86/mm/mem_encrypt.c          | 15 ++++-----------
 3 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index 22c5f3e6f820..4131ddf262f3 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -18,10 +18,13 @@
 #include <linux/init.h>
 
 #include <asm/bootparam.h>
+#include <asm/patchable_const.h>
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 
-extern u64 sme_me_mask;
+#define sme_me_mask_DEFAULT 0
+DECLARE_PATCHABLE_CONST_U64(sme_me_mask);
+#define sme_me_mask sme_me_mask_READ()
 
 void sme_encrypt_execute(unsigned long encrypted_kernel_vaddr,
 			 unsigned long decrypted_kernel_vaddr,
diff --git a/arch/x86/kernel/patchable_const.c b/arch/x86/kernel/patchable_const.c
index 8d48c4c101ca..1bf2980d91b4 100644
--- a/arch/x86/kernel/patchable_const.c
+++ b/arch/x86/kernel/patchable_const.c
@@ -90,11 +90,13 @@ int patch_const_u64(unsigned long **start, unsigned long **stop,
 }
 
 PATCHABLE_CONST_U64(__PHYSICAL_MASK);
+PATCHABLE_CONST_U64(sme_me_mask);
 
 #ifdef CONFIG_MODULES
 /* Add an entry for a constant here if it expected to be seen in the modules */
 static const struct const_u64_table const_u64_table[] = {
 	{"__PHYSICAL_MASK", __PHYSICAL_MASK_DEFAULT, &__PHYSICAL_MASK_CURRENT},
+	{"sme_me_mask", sme_me_mask_DEFAULT, &sme_me_mask_CURRENT},
 };
 
 __init_or_module __nostackprotector
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 5135b59ce6a5..c93b5c5eeccf 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -36,13 +36,6 @@ static char sme_cmdline_arg[] __initdata = "mem_encrypt";
 static char sme_cmdline_on[]  __initdata = "on";
 static char sme_cmdline_off[] __initdata = "off";
 
-/*
- * Since SME related variables are set early in the boot process they must
- * reside in the .data section so as not to be zeroed out when the .bss
- * section is later cleared.
- */
-u64 sme_me_mask __section(.data) = 0;
-EXPORT_SYMBOL(sme_me_mask);
 DEFINE_STATIC_KEY_FALSE(sev_enable_key);
 EXPORT_SYMBOL_GPL(sev_enable_key);
 
@@ -997,7 +990,7 @@ void __init __nostackprotector sme_enable(struct boot_params *bp)
 			return;
 
 		/* SEV state cannot be controlled by a command line option */
-		sme_me_mask = me_mask;
+		sme_me_mask_SET(me_mask);
 		sev_enabled = true;
 		return;
 	}
@@ -1028,11 +1021,11 @@ void __init __nostackprotector sme_enable(struct boot_params *bp)
 	cmdline_find_option(cmdline_ptr, cmdline_arg, buffer, sizeof(buffer));
 
 	if (!strncmp(buffer, cmdline_on, sizeof(buffer)))
-		sme_me_mask = me_mask;
+		sme_me_mask_SET(me_mask);
 	else if (!strncmp(buffer, cmdline_off, sizeof(buffer)))
-		sme_me_mask = 0;
+		sme_me_mask_SET(0);
 	else
-		sme_me_mask = active_by_default ? me_mask : 0;
+		sme_me_mask_SET(active_by_default ? me_mask : 0);
 
 	if (__PHYSICAL_MASK_SET(__PHYSICAL_MASK & ~sme_me_mask)) {
 		/* Can we handle it? */
-- 
2.15.1
