Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A22C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 304A7208AC
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:02:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 304A7208AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729899AbeGaHlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 03:41:31 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44937 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbeGaHlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 03:41:31 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6V62eoL2594350
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 30 Jul 2018 23:02:40 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6V62eNi2594347;
        Mon, 30 Jul 2018 23:02:40 -0700
Date:   Mon, 30 Jul 2018 23:02:40 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-igdpciheradk3gb3qqal52d0@git.kernel.org>
Cc:     dan.j.williams@intel.com, hpa@zytor.com, tglx@linutronix.de,
        mika.penttila@nextfour.com, wangnan0@huawei.com, mingo@kernel.org,
        tony.luck@intel.com, dsahern@gmail.com, jolsa@kernel.org,
        namhyung@kernel.org, adrian.hunter@intel.com, acme@redhat.com,
        linux-kernel@vger.kernel.org
Reply-To: dan.j.williams@intel.com, hpa@zytor.com,
          mika.penttila@nextfour.com, tglx@linutronix.de,
          dsahern@gmail.com, tony.luck@intel.com, wangnan0@huawei.com,
          mingo@kernel.org, acme@redhat.com, linux-kernel@vger.kernel.org,
          jolsa@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools arch: Update arch/x86/lib/memcpy_64.S copy
 used in 'perf bench mem memcpy'
Git-Commit-ID: 1f27a050fc679d16e68a40e0bb575364a89fad66
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  1f27a050fc679d16e68a40e0bb575364a89fad66
Gitweb:     https://git.kernel.org/tip/1f27a050fc679d16e68a40e0bb575364a89fad66
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 30 Jul 2018 12:26:54 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 30 Jul 2018 12:36:51 -0300

tools arch: Update arch/x86/lib/memcpy_64.S copy used in 'perf bench mem memcpy'

To cope with the changes in:

  12c89130a56a ("x86/asm/memcpy_mcsafe: Add write-protection-fault handling")
  60622d68227d ("x86/asm/memcpy_mcsafe: Return bytes remaining")
  bd131544aa7e ("x86/asm/memcpy_mcsafe: Add labels for __memcpy_mcsafe() write fault handling")
  da7bc9c57eb0 ("x86/asm/memcpy_mcsafe: Remove loop unrolling")

This needed introducing a file with a copy of the mcsafe_handle_tail()
function, that is used in the new memcpy_64.S file, as well as a dummy
mcsafe_test.h header.

Testing it:

  $ nm ~/bin/perf | grep mcsafe
  0000000000484130 T mcsafe_handle_tail
  0000000000484300 T __memcpy_mcsafe
  $
  $ perf bench mem memcpy
  # Running 'mem/memcpy' benchmark:
  # function 'default' (Default memcpy() provided by glibc)
  # Copying 1MB bytes ...

      44.389205 GB/sec
  # function 'x86-64-unrolled' (unrolled memcpy() in arch/x86/lib/memcpy_64.S)
  # Copying 1MB bytes ...

      22.710756 GB/sec
  # function 'x86-64-movsq' (movsq-based memcpy() in arch/x86/lib/memcpy_64.S)
  # Copying 1MB bytes ...

      42.459239 GB/sec
  # function 'x86-64-movsb' (movsb-based memcpy() in arch/x86/lib/memcpy_64.S)
  # Copying 1MB bytes ...

      42.459239 GB/sec
  $

This silences this perf tools build warning:

  Warning: Kernel ABI header at 'tools/arch/x86/lib/memcpy_64.S' differs from latest version at 'arch/x86/lib/memcpy_64.S'

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mika Penttilä <mika.penttila@nextfour.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-igdpciheradk3gb3qqal52d0@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/asm/mcsafe_test.h |  13 ++++
 tools/arch/x86/lib/memcpy_64.S           | 112 +++++++++++++++----------------
 tools/perf/bench/Build                   |   1 +
 tools/perf/bench/mem-memcpy-x86-64-asm.S |   1 +
 tools/perf/bench/mem-memcpy-x86-64-lib.c |  24 +++++++
 5 files changed, 93 insertions(+), 58 deletions(-)

diff --git a/tools/arch/x86/include/asm/mcsafe_test.h b/tools/arch/x86/include/asm/mcsafe_test.h
new file mode 100644
index 000000000000..2ccd588fbad4
--- /dev/null
+++ b/tools/arch/x86/include/asm/mcsafe_test.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _MCSAFE_TEST_H_
+#define _MCSAFE_TEST_H_
+
+.macro MCSAFE_TEST_CTL
+.endm
+
+.macro MCSAFE_TEST_SRC reg count target
+.endm
+
+.macro MCSAFE_TEST_DST reg count target
+.endm
+#endif /* _MCSAFE_TEST_H_ */
diff --git a/tools/arch/x86/lib/memcpy_64.S b/tools/arch/x86/lib/memcpy_64.S
index 9a53a06e5a3e..298ef1479240 100644
--- a/tools/arch/x86/lib/memcpy_64.S
+++ b/tools/arch/x86/lib/memcpy_64.S
@@ -3,6 +3,7 @@
 #include <linux/linkage.h>
 #include <asm/errno.h>
 #include <asm/cpufeatures.h>
+#include <asm/mcsafe_test.h>
 #include <asm/alternative-asm.h>
 #include <asm/export.h>
 
@@ -183,12 +184,15 @@ ENTRY(memcpy_orig)
 ENDPROC(memcpy_orig)
 
 #ifndef CONFIG_UML
+
+MCSAFE_TEST_CTL
+
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
@@ -204,58 +208,33 @@ ENTRY(memcpy_mcsafe_unrolled)
 	subl $8, %ecx
 	negl %ecx
 	subl %ecx, %edx
-.L_copy_leading_bytes:
+.L_read_leading_bytes:
 	movb (%rsi), %al
+	MCSAFE_TEST_SRC %rsi 1 .E_leading_bytes
+	MCSAFE_TEST_DST %rdi 1 .E_leading_bytes
+.L_write_leading_bytes:
 	movb %al, (%rdi)
 	incq %rsi
 	incq %rdi
 	decl %ecx
-	jnz .L_copy_leading_bytes
+	jnz .L_read_leading_bytes
 
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
+.L_read_words:
 	movq (%rsi), %r8
-	mov %r8, (%rdi)
-	leaq 8(%rsi), %rsi
-	leaq 8(%rdi), %rdi
+	MCSAFE_TEST_SRC %rsi 8 .E_read_words
+	MCSAFE_TEST_DST %rdi 8 .E_write_words
+.L_write_words:
+	movq %r8, (%rdi)
+	addq $8, %rsi
+	addq $8, %rdi
 	decl %ecx
-	jnz .L_copy_trailing_words
+	jnz .L_read_words
 
 	/* Any trailing bytes? */
 .L_no_whole_words:
@@ -264,38 +243,55 @@ ENTRY(memcpy_mcsafe_unrolled)
 
 	/* Copy trailing bytes */
 	movl %edx, %ecx
-.L_copy_trailing_bytes:
+.L_read_trailing_bytes:
 	movb (%rsi), %al
+	MCSAFE_TEST_SRC %rsi 1 .E_trailing_bytes
+	MCSAFE_TEST_DST %rdi 1 .E_trailing_bytes
+.L_write_trailing_bytes:
 	movb %al, (%rdi)
 	incq %rsi
 	incq %rdi
 	decl %ecx
-	jnz .L_copy_trailing_bytes
+	jnz .L_read_trailing_bytes
 
 	/* Copy successful. Return zero */
 .L_done_memcpy_trap:
 	xorq %rax, %rax
 	ret
-ENDPROC(memcpy_mcsafe_unrolled)
-EXPORT_SYMBOL_GPL(memcpy_mcsafe_unrolled)
+ENDPROC(__memcpy_mcsafe)
+EXPORT_SYMBOL_GPL(__memcpy_mcsafe)
 
 	.section .fixup, "ax"
-	/* Return -EFAULT for any failure */
-.L_memcpy_mcsafe_fail:
-	mov	$-EFAULT, %rax
+	/*
+	 * Return number of bytes not copied for any failure. Note that
+	 * there is no "tail" handling since the source buffer is 8-byte
+	 * aligned and poison is cacheline aligned.
+	 */
+.E_read_words:
+	shll	$3, %ecx
+.E_leading_bytes:
+	addl	%edx, %ecx
+.E_trailing_bytes:
+	mov	%ecx, %eax
 	ret
 
+	/*
+	 * For write fault handling, given the destination is unaligned,
+	 * we handle faults on multi-byte writes with a byte-by-byte
+	 * copy up to the write-protected page.
+	 */
+.E_write_words:
+	shll	$3, %ecx
+	addl	%edx, %ecx
+	movl	%ecx, %edx
+	jmp mcsafe_handle_tail
+
 	.previous
 
-	_ASM_EXTABLE_FAULT(.L_copy_leading_bytes, .L_memcpy_mcsafe_fail)
-	_ASM_EXTABLE_FAULT(.L_cache_w0, .L_memcpy_mcsafe_fail)
-	_ASM_EXTABLE_FAULT(.L_cache_w1, .L_memcpy_mcsafe_fail)
-	_ASM_EXTABLE_FAULT(.L_cache_w2, .L_memcpy_mcsafe_fail)
-	_ASM_EXTABLE_FAULT(.L_cache_w3, .L_memcpy_mcsafe_fail)
-	_ASM_EXTABLE_FAULT(.L_cache_w4, .L_memcpy_mcsafe_fail)
-	_ASM_EXTABLE_FAULT(.L_cache_w5, .L_memcpy_mcsafe_fail)
-	_ASM_EXTABLE_FAULT(.L_cache_w6, .L_memcpy_mcsafe_fail)
-	_ASM_EXTABLE_FAULT(.L_cache_w7, .L_memcpy_mcsafe_fail)
-	_ASM_EXTABLE_FAULT(.L_copy_trailing_words, .L_memcpy_mcsafe_fail)
-	_ASM_EXTABLE_FAULT(.L_copy_trailing_bytes, .L_memcpy_mcsafe_fail)
+	_ASM_EXTABLE_FAULT(.L_read_leading_bytes, .E_leading_bytes)
+	_ASM_EXTABLE_FAULT(.L_read_words, .E_read_words)
+	_ASM_EXTABLE_FAULT(.L_read_trailing_bytes, .E_trailing_bytes)
+	_ASM_EXTABLE(.L_write_leading_bytes, .E_leading_bytes)
+	_ASM_EXTABLE(.L_write_words, .E_write_words)
+	_ASM_EXTABLE(.L_write_trailing_bytes, .E_trailing_bytes)
 #endif
diff --git a/tools/perf/bench/Build b/tools/perf/bench/Build
index 60bf11943047..eafce1a130a1 100644
--- a/tools/perf/bench/Build
+++ b/tools/perf/bench/Build
@@ -7,6 +7,7 @@ perf-y += futex-wake-parallel.o
 perf-y += futex-requeue.o
 perf-y += futex-lock-pi.o
 
+perf-$(CONFIG_X86_64) += mem-memcpy-x86-64-lib.o
 perf-$(CONFIG_X86_64) += mem-memcpy-x86-64-asm.o
 perf-$(CONFIG_X86_64) += mem-memset-x86-64-asm.o
 
diff --git a/tools/perf/bench/mem-memcpy-x86-64-asm.S b/tools/perf/bench/mem-memcpy-x86-64-asm.S
index b43f8d2a34ec..9ad015a1e202 100644
--- a/tools/perf/bench/mem-memcpy-x86-64-asm.S
+++ b/tools/perf/bench/mem-memcpy-x86-64-asm.S
@@ -6,6 +6,7 @@
 #define altinstr_replacement text
 #define globl p2align 4; .globl
 #define _ASM_EXTABLE_FAULT(x, y)
+#define _ASM_EXTABLE(x, y)
 
 #include "../../arch/x86/lib/memcpy_64.S"
 /*
diff --git a/tools/perf/bench/mem-memcpy-x86-64-lib.c b/tools/perf/bench/mem-memcpy-x86-64-lib.c
new file mode 100644
index 000000000000..4130734dde84
--- /dev/null
+++ b/tools/perf/bench/mem-memcpy-x86-64-lib.c
@@ -0,0 +1,24 @@
+/*
+ * From code in arch/x86/lib/usercopy_64.c, copied to keep tools/ copy
+ * of the kernel's arch/x86/lib/memcpy_64.s used in 'perf bench mem memcpy'
+ * happy.
+ */
+#include <linux/types.h>
+
+unsigned long __memcpy_mcsafe(void *dst, const void *src, size_t cnt);
+unsigned long mcsafe_handle_tail(char *to, char *from, unsigned len);
+
+unsigned long mcsafe_handle_tail(char *to, char *from, unsigned len)
+{
+	for (; len; --len, to++, from++) {
+		/*
+		 * Call the assembly routine back directly since
+		 * memcpy_mcsafe() may silently fallback to memcpy.
+		 */
+		unsigned long rem = __memcpy_mcsafe(to, from, 1);
+
+		if (rem)
+			break;
+	}
+	return len;
+}
