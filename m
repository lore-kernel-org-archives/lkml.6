Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELs8q/q4fQEQKiAdaYJ0tRv+pnZ4Jfp6s/uL0PclgikO0L/Jx85bqv+snAbgM9YQvJk22HNR
ARC-Seal: i=1; a=rsa-sha256; t=1520824095; cv=none;
        d=google.com; s=arc-20160816;
        b=PYTzo4BCg1XjQwKJ89btEVqPGIiO/FIBr0s2Ue1o0jNunFqywQvt+b8uSO4dMTqHqd
         tU92VOtaNg3PYdE9n5iNJXTOHnwYE0SvHcCrQ7zsX8s2ikvEzN0KJZDOicWAe/GejOFW
         M0gXQKfnXnnlJmgOMjRpR1pi8bU+2N/kLoYpC/aw23QS9pMmR2c9EW35sMi6F4EF2ZuJ
         ZJ/775m2ZDDAnlusKV+BjIqmEvHZ+FW/wAH0tB4mDamlOzb90o4c01NqiIQy3o58ko54
         ncnDz8tZxqh4m35y+muPHjaohdjdx0x/43zGwVtdjWeC2tN+f9u/4Q82PJS2xWxFlqvx
         n4og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=gOdED2q6OMsCJgWODyJWyZPnYyVDt5qpADtpNxdMXYE=;
        b=UfhxNsdjeShB6XbnINlxBn27PyE3dsP+OvV5lVxW4NYk+OalcMl++YSle+Z+LTFgsz
         ucJWY3CbrycWM2niiL2BMntSTWQP3HljmuJqHOM8y8+T8LSxQJqSINjG3QCXCsdWoNux
         BeBG3vZdIyyenMIM7hO2hGzqv3PgwerlrBf53cEYU6e89srjZmWoZmK+a8zJ90v9kjgP
         hP1WKSgDx5Tbzpe/6qHsrWRy+9VwyuCZeDHXz2KNCT+lvgnA1EQttxF9w8lCvffuzqjV
         IddBIOGIOJT0VCVxYVU1me3UwIL1VrpTpX9cd1G1rydLXgC7nq90LbNC+BIU3CaSzSCm
         q19w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
 "Arjan van de Ven" <arjan@linux.intel.com>,
 "Rik van Riel" <riel@redhat.com>,
 "Kees Cook" <keescook@google.com>,
 "Dave Hansen" <dave.hansen@intel.com>,
 "Greg Kroah-Hartman" <gregkh@linux-foundation.org>,
 "David Woodhouse" <dwmw@amazon.co.uk>,
 "Jiri Kosina" <jikos@kernel.org>,
 thomas.lendacky@amd.com,
 "Ingo Molnar" <mingo@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 gnomes@lxorguk.ukuu.org.uk,
 "Andy Lutomirski" <luto@amacapital.net>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Josh Poimboeuf" <jpoimboe@redhat.com>,
 "Tim Chen" <tim.c.chen@linux.intel.com>,
 "Paul Turner" <pjt@google.com>,
 "Andi Kleen" <ak@linux.intel.com>,
 "Linus Torvalds" <torvalds@linux-foundation.org>
Date: Mon, 12 Mar 2018 03:06:12 +0000
Message-ID: <lsq.1520823972.28219259@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 25/76] x86/retpoline/crypto: Convert crypto assembler
 indirect jumps
In-Reply-To: <lsq.1520823971.5976735@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699647411522380?=
X-GMAIL-MSGID: =?utf-8?q?1594699647411522380?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.56-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: David Woodhouse <dwmw@amazon.co.uk>

commit 9697fa39efd3fc3692f2949d4045f393ec58450b upstream.

Convert all indirect jumps in crypto assembler code to use non-speculative
sequences when CONFIG_RETPOLINE is enabled.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Arjan van de Ven <arjan@linux.intel.com>
Acked-by: Ingo Molnar <mingo@kernel.org>
Cc: gnomes@lxorguk.ukuu.org.uk
Cc: Rik van Riel <riel@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: thomas.lendacky@amd.com
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Kees Cook <keescook@google.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linux-foundation.org>
Cc: Paul Turner <pjt@google.com>
Link: https://lkml.kernel.org/r/1515707194-20531-6-git-send-email-dwmw@amazon.co.uk
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/crypto/aesni-intel_asm.S            | 5 +++--
 arch/x86/crypto/camellia-aesni-avx-asm_64.S  | 3 ++-
 arch/x86/crypto/camellia-aesni-avx2-asm_64.S | 3 ++-
 arch/x86/crypto/crc32c-pcl-intel-asm_64.S    | 3 ++-
 4 files changed, 9 insertions(+), 5 deletions(-)

--- a/arch/x86/crypto/aesni-intel_asm.S
+++ b/arch/x86/crypto/aesni-intel_asm.S
@@ -31,6 +31,7 @@
 
 #include <linux/linkage.h>
 #include <asm/inst.h>
+#include <asm/nospec-branch.h>
 
 #ifdef __x86_64__
 .data
@@ -2703,7 +2704,7 @@ ENTRY(aesni_xts_crypt8)
 	pxor INC, STATE4
 	movdqu IV, 0x30(OUTP)
 
-	call *%r11
+	CALL_NOSPEC %r11
 
 	movdqu 0x00(OUTP), INC
 	pxor INC, STATE1
@@ -2748,7 +2749,7 @@ ENTRY(aesni_xts_crypt8)
 	_aesni_gf128mul_x_ble()
 	movups IV, (IVP)
 
-	call *%r11
+	CALL_NOSPEC %r11
 
 	movdqu 0x40(OUTP), INC
 	pxor INC, STATE1
--- a/arch/x86/crypto/camellia-aesni-avx-asm_64.S
+++ b/arch/x86/crypto/camellia-aesni-avx-asm_64.S
@@ -16,6 +16,7 @@
  */
 
 #include <linux/linkage.h>
+#include <asm/nospec-branch.h>
 
 #define CAMELLIA_TABLE_BYTE_LEN 272
 
@@ -1210,7 +1211,7 @@ camellia_xts_crypt_16way:
 	vpxor 14 * 16(%rax), %xmm15, %xmm14;
 	vpxor 15 * 16(%rax), %xmm15, %xmm15;
 
-	call *%r9;
+	CALL_NOSPEC %r9;
 
 	addq $(16 * 16), %rsp;
 
--- a/arch/x86/crypto/camellia-aesni-avx2-asm_64.S
+++ b/arch/x86/crypto/camellia-aesni-avx2-asm_64.S
@@ -11,6 +11,7 @@
  */
 
 #include <linux/linkage.h>
+#include <asm/nospec-branch.h>
 
 #define CAMELLIA_TABLE_BYTE_LEN 272
 
@@ -1323,7 +1324,7 @@ camellia_xts_crypt_32way:
 	vpxor 14 * 32(%rax), %ymm15, %ymm14;
 	vpxor 15 * 32(%rax), %ymm15, %ymm15;
 
-	call *%r9;
+	CALL_NOSPEC %r9;
 
 	addq $(16 * 32), %rsp;
 
--- a/arch/x86/crypto/crc32c-pcl-intel-asm_64.S
+++ b/arch/x86/crypto/crc32c-pcl-intel-asm_64.S
@@ -45,6 +45,7 @@
 
 #include <asm/inst.h>
 #include <linux/linkage.h>
+#include <asm/nospec-branch.h>
 
 ## ISCSI CRC 32 Implementation with crc32 and pclmulqdq Instruction
 
@@ -171,7 +172,7 @@ continue_block:
 	movzxw  (bufp, %rax, 2), len
 	offset=crc_array-jump_table
 	lea     offset(bufp, len, 1), bufp
-	jmp     *bufp
+	JMP_NOSPEC bufp
 
 	################################################################
 	## 2a) PROCESS FULL BLOCKS:
