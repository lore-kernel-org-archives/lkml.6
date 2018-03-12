Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751362AbeCLMT3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 08:19:29 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58723 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750995AbeCLMT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 08:19:27 -0400
Date: Mon, 12 Mar 2018 05:18:43 -0700
From: "tip-bot for Kirill A. Shutemov" <tipbot@zytor.com>
Message-ID: <tip-7beebaccd5083d61e975acb581bd528b9326e7c4@git.kernel.org>
Cc: kirill.shutemov@linux.intel.com, bp@suse.de, tglx@linutronix.de,
        brgerst@gmail.com, gorcunov@openvz.org, mingo@kernel.org,
        luto@kernel.org, jpoimboe@redhat.com, bp@alien8.de,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        willy@infradead.org, luto@amacapital.net, peterz@infradead.org,
        hpa@zytor.com, dvlasenk@redhat.com
Reply-To: torvalds@linux-foundation.org, luto@amacapital.net,
        willy@infradead.org, bp@alien8.de, linux-kernel@vger.kernel.org,
        hpa@zytor.com, dvlasenk@redhat.com, peterz@infradead.org,
        brgerst@gmail.com, gorcunov@openvz.org, mingo@kernel.org,
        kirill.shutemov@linux.intel.com, bp@suse.de, tglx@linutronix.de,
        jpoimboe@redhat.com, luto@kernel.org
In-Reply-To: <20180312100246.89175-2-kirill.shutemov@linux.intel.com>
References: <20180312100246.89175-2-kirill.shutemov@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/boot/compressed/64: Make sure we have a 32-bit
 code segment
Git-Commit-ID: 7beebaccd5083d61e975acb581bd528b9326e7c4
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

Commit-ID:  7beebaccd5083d61e975acb581bd528b9326e7c4
Gitweb:     https://git.kernel.org/tip/7beebaccd5083d61e975acb581bd528b9326e7c4
Author:     Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate: Mon, 12 Mar 2018 13:02:43 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 12 Mar 2018 11:49:24 +0100

x86/boot/compressed/64: Make sure we have a 32-bit code segment

When kernel starts in 64-bit mode we inherit the GDT from the bootloader.
It may cause a problem if the GDT doesn't have a 32-bit code segment
where we expect it to be.

Load our own GDT with known segments.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Borislav Petkov <bp@suse.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Cyrill Gorcunov <gorcunov@openvz.org>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org
Link: http://lkml.kernel.org/r/20180312100246.89175-2-kirill.shutemov@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/boot/compressed/head_64.S | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index c813cb004056..f0c3a2f7e528 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -313,6 +313,11 @@ ENTRY(startup_64)
 	 * first.
 	 */
 
+	/* Make sure we have GDT with 32-bit code segment */
+	leaq	gdt(%rip), %rax
+	movq	%rax, gdt64+2(%rip)
+	lgdt	gdt64(%rip)
+
 	/*
 	 * paging_prepare() sets up the trampoline and checks if we need to
 	 * enable 5-level paging.
@@ -547,6 +552,11 @@ no_longmode:
 #include "../../kernel/verify_cpu.S"
 
 	.data
+gdt64:
+	.word	gdt_end - gdt
+	.long	0
+	.word	0
+	.quad   0
 gdt:
 	.word	gdt_end - gdt
 	.long	gdt
