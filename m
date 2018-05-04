Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751392AbeEDAQQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 20:16:16 -0400
Received: from mga07.intel.com ([134.134.136.100]:21718 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751346AbeEDAQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 20:16:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,360,1520924400";
   d="scan'208";a="221489243"
Subject: [PATCH v3 2/9] x86,
 memcpy_mcsafe: add labels for write fault handling
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>, hch@lst.de,
        linux-kernel@vger.kernel.org, tony.luck@intel.com,
        linux-fsdevel@vger.kernel.org
Date: Thu, 03 May 2018 17:06:16 -0700
Message-ID: <152539237606.31796.6719743548991782264.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <152539236455.31796.7516599166555186700.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <152539236455.31796.7516599166555186700.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The memcpy_mcsafe() implementation handles CPU exceptions when reading
from the source address. Before it can be used for user copies it needs
to grow support for handling write faults. In preparation for adding
that exception handling update the labels for the read cache word X case
(.L_cache_rX) and write cache word X case (.L_cache_wX).

Cc: <x86@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Reported-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/lib/memcpy_64.S |   21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/x86/lib/memcpy_64.S b/arch/x86/lib/memcpy_64.S
index 54c971892db5..5709f3ec22a4 100644
--- a/arch/x86/lib/memcpy_64.S
+++ b/arch/x86/lib/memcpy_64.S
@@ -204,13 +204,14 @@ ENTRY(__memcpy_mcsafe)
 	subl $8, %ecx
 	negl %ecx
 	subl %ecx, %edx
-.L_copy_leading_bytes:
+.L_read_leading_bytes:
 	movb (%rsi), %al
+.L_write_leading_bytes:
 	movb %al, (%rdi)
 	incq %rsi
 	incq %rdi
 	decl %ecx
-	jnz .L_copy_leading_bytes
+	jnz .L_read_leading_bytes
 
 .L_8byte_aligned:
 	movl %edx, %ecx
@@ -218,13 +219,14 @@ ENTRY(__memcpy_mcsafe)
 	shrl $3, %ecx
 	jz .L_no_whole_words
 
-.L_copy_words:
+.L_read_words:
 	movq (%rsi), %r8
+.L_write_words:
 	movq %r8, (%rdi)
 	addq $8, %rsi
 	addq $8, %rdi
 	decl %ecx
-	jnz .L_copy_words
+	jnz .L_read_words
 
 	/* Any trailing bytes? */
 .L_no_whole_words:
@@ -233,13 +235,14 @@ ENTRY(__memcpy_mcsafe)
 
 	/* Copy trailing bytes */
 	movl %edx, %ecx
-.L_copy_trailing_bytes:
+.L_read_trailing_bytes:
 	movb (%rsi), %al
+.L_write_trailing_bytes:
 	movb %al, (%rdi)
 	incq %rsi
 	incq %rdi
 	decl %ecx
-	jnz .L_copy_trailing_bytes
+	jnz .L_read_trailing_bytes
 
 	/* Copy successful. Return zero */
 .L_done_memcpy_trap:
@@ -256,7 +259,7 @@ EXPORT_SYMBOL_GPL(__memcpy_mcsafe)
 
 	.previous
 
-	_ASM_EXTABLE_FAULT(.L_copy_leading_bytes, .L_memcpy_mcsafe_fail)
-	_ASM_EXTABLE_FAULT(.L_copy_words, .L_memcpy_mcsafe_fail)
-	_ASM_EXTABLE_FAULT(.L_copy_trailing_bytes, .L_memcpy_mcsafe_fail)
+	_ASM_EXTABLE_FAULT(.L_read_leading_bytes, .L_memcpy_mcsafe_fail)
+	_ASM_EXTABLE_FAULT(.L_read_words, .L_memcpy_mcsafe_fail)
+	_ASM_EXTABLE_FAULT(.L_read_trailing_bytes, .L_memcpy_mcsafe_fail)
 #endif
