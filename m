Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753776AbeB0Pno (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 10:43:44 -0500
Received: from mga14.intel.com ([192.55.52.115]:63241 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753930AbeB0Pm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 10:42:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,401,1515484800";
   d="scan'208";a="20687608"
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Cyrill Gorcunov <gorcunov@openvz.org>, Borislav Petkov <bp@suse.de>,
        Andi Kleen <ak@linux.intel.com>, Matthew Wilcox <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv2 4/5] x86/boot/compressed/64: Set up trampoline memory
Date: Tue, 27 Feb 2018 18:42:16 +0300
Message-Id: <20180227154217.69347-5-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180227154217.69347-1-kirill.shutemov@linux.intel.com>
References: <20180227154217.69347-1-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch clears up trampoline memory and copies trampoline code in
place. It's not yet used though.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Tested-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/boot/compressed/head_64.S    | 3 ++-
 arch/x86/boot/compressed/pgtable.h    | 9 +++++++++
 arch/x86/boot/compressed/pgtable_64.c | 7 +++++++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 8ba0582c65d5..c813cb004056 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -501,8 +501,9 @@ relocated:
 	jmp	*%rax
 
 	.code32
+ENTRY(trampoline_32bit_src)
 compatible_mode:
-	/* Setup data and stack segments */
+	/* Set up data and stack segments */
 	movl	$__KERNEL_DS, %eax
 	movl	%eax, %ds
 	movl	%eax, %ss
diff --git a/arch/x86/boot/compressed/pgtable.h b/arch/x86/boot/compressed/pgtable.h
index 1895f345eb73..cfcb8beeac8f 100644
--- a/arch/x86/boot/compressed/pgtable.h
+++ b/arch/x86/boot/compressed/pgtable.h
@@ -3,9 +3,18 @@
 
 #define TRAMPOLINE_32BIT_SIZE		(2 * PAGE_SIZE)
 
+#define TRAMPOLINE_32BIT_PGTABLE_OFFSET	0
+
+#define TRAMPOLINE_32BIT_CODE_OFFSET	PAGE_SIZE
+#define TRAMPOLINE_32BIT_CODE_SIZE	0x60
+
+#define TRAMPOLINE_32BIT_STACK_END	TRAMPOLINE_32BIT_SIZE
+
 #ifndef __ASSEMBLY__
 
 extern unsigned long *trampoline_32bit;
 
+extern void trampoline_32bit_src(void *return_ptr);
+
 #endif /* __ASSEMBLY__ */
 #endif /* BOOT_COMPRESSED_PAGETABLE_H */
diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index 01d08d3e3e43..810c2c32d98e 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -76,6 +76,13 @@ struct paging_config paging_prepare(void)
 	/* Preserve trampoline memory */
 	memcpy(trampoline_save, trampoline_32bit, TRAMPOLINE_32BIT_SIZE);
 
+	/* Clear trampoline memory first */
+	memset(trampoline_32bit, 0, TRAMPOLINE_32BIT_SIZE);
+
+	/* Copy trampoline code in place */
+	memcpy(trampoline_32bit + TRAMPOLINE_32BIT_CODE_OFFSET / sizeof(unsigned long),
+			&trampoline_32bit_src, TRAMPOLINE_32BIT_CODE_SIZE);
+
 	return paging_config;
 }
 
-- 
2.16.1
