Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932433AbeCLKDs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 06:03:48 -0400
Received: from mga18.intel.com ([134.134.136.126]:10663 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751252AbeCLKC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 06:02:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,460,1515484800";
   d="scan'208";a="37996177"
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Cyrill Gorcunov <gorcunov@openvz.org>, Borislav Petkov <bp@suse.de>,
        Andi Kleen <ak@linux.intel.com>, Matthew Wilcox <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 1/4] x86/boot/compressed/64: Make sure we have 32-bit code segment
Date: Mon, 12 Mar 2018 13:02:43 +0300
Message-Id: <20180312100246.89175-2-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180312100246.89175-1-kirill.shutemov@linux.intel.com>
References: <20180312100246.89175-1-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When kernel starts in 64-bit mode we inherit GDT from a bootloader.
It may cause a problem if the GDT doesn't have 32-bit code segment
where we expect it to be.

Load our own GDT with known segments.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
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
-- 
2.16.1
