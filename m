Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752541AbeCLJbC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 05:31:02 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36171 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752415AbeCLJbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 05:31:00 -0400
Date: Mon, 12 Mar 2018 02:29:32 -0700
From: "tip-bot for Kirill A. Shutemov" <tipbot@zytor.com>
Message-ID: <tip-32fcefa2bfc8961987e91d1daeb00624b4176d2e@git.kernel.org>
Cc: peterz@infradead.org, torvalds@linux-foundation.org,
        willy@infradead.org, jgross@suse.com, hpa@zytor.com,
        keescook@chromium.org, ebiederm@xmission.com,
        andy.shevchenko@gmail.com, bp@suse.de, luto@amacapital.net,
        mingo@kernel.org, gorcunov@openvz.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com
Reply-To: gorcunov@openvz.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        peterz@infradead.org, torvalds@linux-foundation.org, jgross@suse.com,
        willy@infradead.org, hpa@zytor.com, keescook@chromium.org,
        andy.shevchenko@gmail.com, bp@suse.de, ebiederm@xmission.com,
        luto@amacapital.net, mingo@kernel.org
In-Reply-To: <20180226180451.86788-5-kirill.shutemov@linux.intel.com>
References: <20180226180451.86788-5-kirill.shutemov@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/boot/compressed/64: Set up trampoline memory
Git-Commit-ID: 32fcefa2bfc8961987e91d1daeb00624b4176d2e
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

Commit-ID:  32fcefa2bfc8961987e91d1daeb00624b4176d2e
Gitweb:     https://git.kernel.org/tip/32fcefa2bfc8961987e91d1daeb00624b4176d2e
Author:     Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate: Mon, 26 Feb 2018 21:04:50 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 12 Mar 2018 09:37:25 +0100

x86/boot/compressed/64: Set up trampoline memory

This patch clears up trampoline memory and copies trampoline code in
place. It's not yet used though.

Tested-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Cyrill Gorcunov <gorcunov@openvz.org>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org
Link: http://lkml.kernel.org/r/20180226180451.86788-5-kirill.shutemov@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
index 57722a2fe2a0..91f75638f6e6 100644
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
 #ifndef __ASSEMBLER__
 
 extern unsigned long *trampoline_32bit;
 
+extern void trampoline_32bit_src(void *return_ptr);
+
 #endif /* __ASSEMBLER__ */
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
 
