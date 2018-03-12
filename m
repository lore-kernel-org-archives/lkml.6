Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752306AbeCLJae (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 05:30:34 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37385 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751255AbeCLJac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 05:30:32 -0400
Date: Mon, 12 Mar 2018 02:30:02 -0700
From: "tip-bot for Kirill A. Shutemov" <tipbot@zytor.com>
Message-ID: <tip-e9d0e6330eb81ca49bdd8849cc52b3b0f70ed5cb@git.kernel.org>
Cc: gorcunov@openvz.org, ebiederm@xmission.com, peterz@infradead.org,
        mingo@kernel.org, jgross@suse.com, tglx@linutronix.de, hpa@zytor.com,
        willy@infradead.org, torvalds@linux-foundation.org,
        keescook@chromium.org, kirill.shutemov@linux.intel.com,
        linux-kernel@vger.kernel.org, bp@suse.de, luto@amacapital.net,
        andy.shevchenko@gmail.com
Reply-To: peterz@infradead.org, ebiederm@xmission.com, gorcunov@openvz.org,
        willy@infradead.org, mingo@kernel.org, jgross@suse.com,
        tglx@linutronix.de, hpa@zytor.com, keescook@chromium.org,
        torvalds@linux-foundation.org, bp@suse.de, luto@amacapital.net,
        andy.shevchenko@gmail.com, linux-kernel@vger.kernel.org,
        kirill.shutemov@linux.intel.com
In-Reply-To: <20180226180451.86788-6-kirill.shutemov@linux.intel.com>
References: <20180226180451.86788-6-kirill.shutemov@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/boot/compressed/64: Prepare new top-level page
 table for trampoline
Git-Commit-ID: e9d0e6330eb81ca49bdd8849cc52b3b0f70ed5cb
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

Commit-ID:  e9d0e6330eb81ca49bdd8849cc52b3b0f70ed5cb
Gitweb:     https://git.kernel.org/tip/e9d0e6330eb81ca49bdd8849cc52b3b0f70ed5cb
Author:     Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate: Mon, 26 Feb 2018 21:04:51 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 12 Mar 2018 09:37:26 +0100

x86/boot/compressed/64: Prepare new top-level page table for trampoline

If trampoline code would need to switch between 4- and 5-level paging
modes, we have to use a page table in trampoline memory.

Having it in trampoline memory guarantees that it's below 4G and we can
point CR3 to it from 32-bit trampoline code.

We only use the page table if the desired paging mode doesn't match the
mode we are in. Otherwise the page table is unused and trampoline code
wouldn't touch CR3.

For 4- to 5-level paging transition, we set up current (4-level paging)
CR3 as the first and the only entry in a new top-level page table.

For 5- to 4-level paging transition, copy page table pointed by first
entry in the current top-level page table as our new top-level page
table.

If the page table is used by trampoline we would need to copy it to new
page table outside trampoline and update CR3 before restoring trampoline
memory.

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
Link: http://lkml.kernel.org/r/20180226180451.86788-6-kirill.shutemov@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/boot/compressed/pgtable_64.c | 61 +++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index 810c2c32d98e..32af1cbcd903 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -22,6 +22,14 @@ struct paging_config {
 /* Buffer to preserve trampoline memory */
 static char trampoline_save[TRAMPOLINE_32BIT_SIZE];
 
+/*
+ * The page table is going to be used instead of page table in the trampoline
+ * memory.
+ *
+ * It must not be in BSS as BSS is cleared after cleanup_trampoline().
+ */
+static char top_pgtable[PAGE_SIZE] __aligned(PAGE_SIZE) __section(.data);
+
 /*
  * Trampoline address will be printed by extract_kernel() for debugging
  * purposes.
@@ -83,11 +91,64 @@ struct paging_config paging_prepare(void)
 	memcpy(trampoline_32bit + TRAMPOLINE_32BIT_CODE_OFFSET / sizeof(unsigned long),
 			&trampoline_32bit_src, TRAMPOLINE_32BIT_CODE_SIZE);
 
+	/*
+	 * The code below prepares page table in trampoline memory.
+	 *
+	 * The new page table will be used by trampoline code for switching
+	 * from 4- to 5-level paging or vice versa.
+	 *
+	 * If switching is not required, the page table is unused: trampoline
+	 * code wouldn't touch CR3.
+	 */
+
+	/*
+	 * We are not going to use the page table in trampoline memory if we
+	 * are already in the desired paging mode.
+	 */
+	if (paging_config.l5_required == !!(native_read_cr4() & X86_CR4_LA57))
+		goto out;
+
+	if (paging_config.l5_required) {
+		/*
+		 * For 4- to 5-level paging transition, set up current CR3 as
+		 * the first and the only entry in a new top-level page table.
+		 */
+		trampoline_32bit[TRAMPOLINE_32BIT_PGTABLE_OFFSET] = __native_read_cr3() | _PAGE_TABLE_NOENC;
+	} else {
+		unsigned long src;
+
+		/*
+		 * For 5- to 4-level paging transition, copy page table pointed
+		 * by first entry in the current top-level page table as our
+		 * new top-level page table.
+		 *
+		 * We cannot just point to the page table from trampoline as it
+		 * may be above 4G.
+		 */
+		src = *(unsigned long *)__native_read_cr3() & PAGE_MASK;
+		memcpy(trampoline_32bit + TRAMPOLINE_32BIT_PGTABLE_OFFSET / sizeof(unsigned long),
+		       (void *)src, PAGE_SIZE);
+	}
+
+out:
 	return paging_config;
 }
 
 void cleanup_trampoline(void)
 {
+	void *trampoline_pgtable;
+
+	trampoline_pgtable = trampoline_32bit + TRAMPOLINE_32BIT_PGTABLE_OFFSET;
+
+	/*
+	 * Move the top level page table out of trampoline memory,
+	 * if it's there.
+	 */
+	if ((void *)__native_read_cr3() == trampoline_pgtable) {
+		memcpy(top_pgtable, trampoline_pgtable, PAGE_SIZE);
+		native_write_cr3((unsigned long)top_pgtable);
+	}
+
 	/* Restore trampoline memory */
 	memcpy(trampoline_32bit, trampoline_save, TRAMPOLINE_32BIT_SIZE);
 }
