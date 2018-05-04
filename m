Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751344AbeEDAQM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 20:16:12 -0400
Received: from mga17.intel.com ([192.55.52.151]:32700 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751116AbeEDAQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 20:16:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,360,1520924400";
   d="scan'208";a="53038485"
Subject: [PATCH v3 1/9] x86, memcpy_mcsafe: remove loop unrolling
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, hch@lst.de,
        linux-kernel@vger.kernel.org, tony.luck@intel.com,
        linux-fsdevel@vger.kernel.org
Date: Thu, 03 May 2018 17:06:11 -0700
Message-ID: <152539237092.31796.9115692316555638048.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <152539236455.31796.7516599166555186700.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <152539236455.31796.7516599166555186700.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for teaching memcpy_mcsafe() to return 'bytes remaining'
rather than pass / fail, simplify the implementation to remove loop
unrolling. The unrolling complicates the fault handling for negligible
benefit given modern CPUs perform loop stream detection.

Cc: <x86@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/include/asm/string_64.h |    4 +--
 arch/x86/lib/memcpy_64.S         |   59 ++++++--------------------------------
 2 files changed, 12 insertions(+), 51 deletions(-)

diff --git a/arch/x86/include/asm/string_64.h b/arch/x86/include/asm/string_64.h
index 533f74c300c2..4752f8984923 100644
--- a/arch/x86/include/asm/string_64.h
+++ b/arch/x86/include/asm/string_64.h
@@ -116,7 +116,7 @@ int strcmp(const char *cs, const char *ct);
 #endif
 
 #define __HAVE_ARCH_MEMCPY_MCSAFE 1
-__must_check int memcpy_mcsafe_unrolled(void *dst, const void *src, size_t cnt);
+__must_check int __memcpy_mcsafe(void *dst, const void *src, size_t cnt);
 DECLARE_STATIC_KEY_FALSE(mcsafe_key);
 
 /**
@@ -138,7 +138,7 @@ memcpy_mcsafe(void *dst, const void *src, size_t cnt)
 {
 #ifdef CONFIG_X86_MCE
 	if (static_branch_unlikely(&mcsafe_key))
-		return memcpy_mcsafe_unrolled(dst, src, cnt);
+		return __memcpy_mcsafe(dst, src, cnt);
 	else
 #endif
 		memcpy(dst, src, cnt);
diff --git a/arch/x86/lib/memcpy_64.S b/arch/x86/lib/memcpy_64.S
index 9a53a06e5a3e..54c971892db5 100644
--- a/arch/x86/lib/memcpy_64.S
+++ b/arch/x86/lib/memcpy_64.S
@@ -184,11 +184,11 @@ ENDPROC(memcpy_orig)
 
 #ifndef CONFIG_UML
 /*
- * memcpy_mcsafe_unrolled - memory copy with machine check exception handling
+ * __memcpy_mcsafe - memory copy with machine check exception handling
  * Note that we only catch machine checks when reading the source addresses.
  * Writes to target are posted and don't generate machine checks.
  */
-ENTRY(memcpy_mcsafe_unrolled)
+ENTRY(__memcpy_mcsafe)
 	cmpl $8, %edx
 	/* Less than 8 bytes? Go to byte copy loop */
 	jb .L_no_whole_words
@@ -213,49 +213,18 @@ ENTRY(memcpy_mcsafe_unrolled)
 	jnz .L_copy_leading_bytes
 
 .L_8byte_aligned:
-	/* Figure out how many whole cache lines (64-bytes) to copy */
-	movl %edx, %ecx
-	andl $63, %edx
-	shrl $6, %ecx
-	jz .L_no_whole_cache_lines
-
-	/* Loop copying whole cache lines */
-.L_cache_w0: movq (%rsi), %r8
-.L_cache_w1: movq 1*8(%rsi), %r9
-.L_cache_w2: movq 2*8(%rsi), %r10
-.L_cache_w3: movq 3*8(%rsi), %r11
-	movq %r8, (%rdi)
-	movq %r9, 1*8(%rdi)
-	movq %r10, 2*8(%rdi)
-	movq %r11, 3*8(%rdi)
-.L_cache_w4: movq 4*8(%rsi), %r8
-.L_cache_w5: movq 5*8(%rsi), %r9
-.L_cache_w6: movq 6*8(%rsi), %r10
-.L_cache_w7: movq 7*8(%rsi), %r11
-	movq %r8, 4*8(%rdi)
-	movq %r9, 5*8(%rdi)
-	movq %r10, 6*8(%rdi)
-	movq %r11, 7*8(%rdi)
-	leaq 64(%rsi), %rsi
-	leaq 64(%rdi), %rdi
-	decl %ecx
-	jnz .L_cache_w0
-
-	/* Are there any trailing 8-byte words? */
-.L_no_whole_cache_lines:
 	movl %edx, %ecx
 	andl $7, %edx
 	shrl $3, %ecx
 	jz .L_no_whole_words
 
-	/* Copy trailing words */
-.L_copy_trailing_words:
+.L_copy_words:
 	movq (%rsi), %r8
-	mov %r8, (%rdi)
-	leaq 8(%rsi), %rsi
-	leaq 8(%rdi), %rdi
+	movq %r8, (%rdi)
+	addq $8, %rsi
+	addq $8, %rdi
 	decl %ecx
-	jnz .L_copy_trailing_words
+	jnz .L_copy_words
 
 	/* Any trailing bytes? */
 .L_no_whole_words:
@@ -276,8 +245,8 @@ ENTRY(memcpy_mcsafe_unrolled)
 .L_done_memcpy_trap:
 	xorq %rax, %rax
 	ret
-ENDPROC(memcpy_mcsafe_unrolled)
-EXPORT_SYMBOL_GPL(memcpy_mcsafe_unrolled)
+ENDPROC(__memcpy_mcsafe)
+EXPORT_SYMBOL_GPL(__memcpy_mcsafe)
 
 	.section .fixup, "ax"
 	/* Return -EFAULT for any failure */
@@ -288,14 +257,6 @@ EXPORT_SYMBOL_GPL(memcpy_mcsafe_unrolled)
 	.previous
 
 	_ASM_EXTABLE_FAULT(.L_copy_leading_bytes, .L_memcpy_mcsafe_fail)
-	_ASM_EXTABLE_FAULT(.L_cache_w0, .L_memcpy_mcsafe_fail)
-	_ASM_EXTABLE_FAULT(.L_cache_w1, .L_memcpy_mcsafe_fail)
-	_ASM_EXTABLE_FAULT(.L_cache_w2, .L_memcpy_mcsafe_fail)
-	_ASM_EXTABLE_FAULT(.L_cache_w3, .L_memcpy_mcsafe_fail)
-	_ASM_EXTABLE_FAULT(.L_cache_w4, .L_memcpy_mcsafe_fail)
-	_ASM_EXTABLE_FAULT(.L_cache_w5, .L_memcpy_mcsafe_fail)
-	_ASM_EXTABLE_FAULT(.L_cache_w6, .L_memcpy_mcsafe_fail)
-	_ASM_EXTABLE_FAULT(.L_cache_w7, .L_memcpy_mcsafe_fail)
-	_ASM_EXTABLE_FAULT(.L_copy_trailing_words, .L_memcpy_mcsafe_fail)
+	_ASM_EXTABLE_FAULT(.L_copy_words, .L_memcpy_mcsafe_fail)
 	_ASM_EXTABLE_FAULT(.L_copy_trailing_bytes, .L_memcpy_mcsafe_fail)
 #endif
