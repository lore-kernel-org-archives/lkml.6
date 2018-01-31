Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753319AbeAaJSI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 04:18:08 -0500
Received: from terminus.zytor.com ([65.50.211.136]:46135 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752089AbeAaJSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 04:18:04 -0500
Date: Wed, 31 Jan 2018 01:13:40 -0800
From: "tip-bot for Kirill A. Shutemov" <tipbot@zytor.com>
Message-ID: <tip-5bf30316991d5bcda046343ee77d823cf16fdd03@git.kernel.org>
Cc: bp@suse.de, hpa@zytor.com, kirill.shutemov@linux.intel.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org, bhe@redhat.com,
        tglx@linutronix.de, torvalds@linux-foundation.org, mingo@kernel.org
Reply-To: kirill.shutemov@linux.intel.com, hpa@zytor.com, bp@suse.de,
        mingo@kernel.org, torvalds@linux-foundation.org, bhe@redhat.com,
        tglx@linutronix.de, peterz@infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20180129110845.26633-1-kirill.shutemov@linux.intel.com>
References: <20180129110845.26633-1-kirill.shutemov@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/kexec: Make kexec (mostly) work in 5-level
 paging mode
Git-Commit-ID: 5bf30316991d5bcda046343ee77d823cf16fdd03
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

Commit-ID:  5bf30316991d5bcda046343ee77d823cf16fdd03
Gitweb:     https://git.kernel.org/tip/5bf30316991d5bcda046343ee77d823cf16fdd03
Author:     Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate: Mon, 29 Jan 2018 14:08:45 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 31 Jan 2018 08:39:40 +0100

x86/kexec: Make kexec (mostly) work in 5-level paging mode

Currently kexec() will crash when switching into a 5-level paging
enabled kernel.

I missed that we need to change relocate_kernel() to set CR4.LA57
flag if the kernel has 5-level paging enabled.

I avoided using #ifdef CONFIG_X86_5LEVEL here and inferred if we need to
enable 5-level paging from previous CR4 value. This way the code is
ready for boot-time switching between paging modes.

With this patch applied, in addition to kexec 4-to-4 which always worked,
we can kexec 4-to-5 and 5-to-5 - while 5-to-4 will need more work.

Reported-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Tested-by: Baoquan He <bhe@redhat.com>
Cc: <stable@vger.kernel.org> # v4.14+
Cc: Borislav Petkov <bp@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org
Fixes: 77ef56e4f0fb ("x86: Enable 5-level paging support via CONFIG_X86_5LEVEL=y")
Link: http://lkml.kernel.org/r/20180129110845.26633-1-kirill.shutemov@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/relocate_kernel_64.S | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 307d3ba..11eda21e 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -68,6 +68,9 @@ relocate_kernel:
 	movq	%cr4, %rax
 	movq	%rax, CR4(%r11)
 
+	/* Save CR4. Required to enable the right paging mode later. */
+	movq	%rax, %r13
+
 	/* zero out flags, and disable interrupts */
 	pushq $0
 	popfq
@@ -126,8 +129,13 @@ identity_mapped:
 	/*
 	 * Set cr4 to a known state:
 	 *  - physical address extension enabled
+	 *  - 5-level paging, if it was enabled before
 	 */
 	movl	$X86_CR4_PAE, %eax
+	testq	$X86_CR4_LA57, %r13
+	jz	1f
+	orl	$X86_CR4_LA57, %eax
+1:
 	movq	%rax, %cr4
 
 	jmp 1f
