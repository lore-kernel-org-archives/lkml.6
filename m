Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqShcCS/k30U89x3NrVoKc2RiSysfCVuY4MFV9oCevi6X5e2yGFi0MVBgLYPe06rKejn+kp
ARC-Seal: i=1; a=rsa-sha256; t=1527155658; cv=none;
        d=google.com; s=arc-20160816;
        b=UOhs8A31/uwb9jOij37QzWqUFujR6QJLVjIi3NHmRdCKYRlfL0RBhGieU2Bcx5ulEJ
         wvkJ6u7gpW1eYeADpu+YSagAFRaONuR1Ysx3M+OpugLI5K0vwbj9mnibPN5hbwA5efud
         OIn+y0Q3ibSaZuqwcYlobipDyFl+y85hsulhPDRV/XQ80gi2Hr+qIC/P2YJNtF8w6kY3
         xMkZizMmyAn8L6D2bJlN+h3fHLf8bAzfc6rhA1hUqULCRGQR4WfnlzbfvDRxHUo1gUVf
         lfCENK1TgbSgA3r8RQUMT2Jx5U8ybBia0Hd5ViiTwgqqjqIXwicMUnv0AzfS1HMZxqHO
         WzJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=lOU9wVjLWX4wn7ZCE60AG3qxz1kgPT4dG8rRSXL40RM=;
        b=Rxh9gJG3HtLnhEyp8TOxU+i803Lw+y65MKM+fEKaHq/8vMUVTHColh05dqmVGK98kN
         wK71ZZTuIrMoa6AL82qWp8FYxXSRH+TLxxPyK1rrvjen3/T8e6/MJCGV9mCgvWDfM/kC
         PWkJGr/J6qU9U+KzhrPoJQjCyR+EZ3qOcvugb5uqPQUPLC1/a3MVFTCQHL7FMHBXJWMl
         26noS8W3yNbGmIo8uG1+CNpa93fSmBhM2ugrOSGKlc7nOvhlBEjDVOTFG3b8ukrBfveg
         fJETlwHrjnXmwuUrdJRqXiqCNhq5zxnyZ23gJffDEVFInYxIbfNYKRVfTL3aDxQhBkWK
         YjKg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=VzlGI9AM;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=VzlGI9AM;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: [PATCH 4.14 042/165] s390/kernel: use expoline for indirect branches
Date: Thu, 24 May 2018 11:37:28 +0200
Message-Id: <20180524093623.711906740@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338293579326089?=
X-GMAIL-MSGID: =?utf-8?q?1601338771851732440?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[ Upstream commit c50c84c3ac4d5db683904bdb3257798b6ef980ae ]

The assember code in arch/s390/kernel uses a few more indirect branches
which need to be done with execute trampolines for CONFIG_EXPOLINE=y.

Cc: stable@vger.kernel.org # 4.16
Fixes: f19fbd5ed6 ("s390: introduce execute-trampolines for branches")
Reviewed-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/kernel/base.S   |   24 ++++++++++++++----------
 arch/s390/kernel/reipl.S  |    7 +++++--
 arch/s390/kernel/swsusp.S |   10 ++++++----
 3 files changed, 25 insertions(+), 16 deletions(-)

--- a/arch/s390/kernel/base.S
+++ b/arch/s390/kernel/base.S
@@ -9,18 +9,22 @@
 
 #include <linux/linkage.h>
 #include <asm/asm-offsets.h>
+#include <asm/nospec-insn.h>
 #include <asm/ptrace.h>
 #include <asm/sigp.h>
 
+	GEN_BR_THUNK %r9
+	GEN_BR_THUNK %r14
+
 ENTRY(s390_base_mcck_handler)
 	basr	%r13,0
 0:	lg	%r15,__LC_PANIC_STACK	# load panic stack
 	aghi	%r15,-STACK_FRAME_OVERHEAD
 	larl	%r1,s390_base_mcck_handler_fn
-	lg	%r1,0(%r1)
-	ltgr	%r1,%r1
+	lg	%r9,0(%r1)
+	ltgr	%r9,%r9
 	jz	1f
-	basr	%r14,%r1
+	BASR_EX	%r14,%r9
 1:	la	%r1,4095
 	lmg	%r0,%r15,__LC_GPREGS_SAVE_AREA-4095(%r1)
 	lpswe	__LC_MCK_OLD_PSW
@@ -37,10 +41,10 @@ ENTRY(s390_base_ext_handler)
 	basr	%r13,0
 0:	aghi	%r15,-STACK_FRAME_OVERHEAD
 	larl	%r1,s390_base_ext_handler_fn
-	lg	%r1,0(%r1)
-	ltgr	%r1,%r1
+	lg	%r9,0(%r1)
+	ltgr	%r9,%r9
 	jz	1f
-	basr	%r14,%r1
+	BASR_EX	%r14,%r9
 1:	lmg	%r0,%r15,__LC_SAVE_AREA_ASYNC
 	ni	__LC_EXT_OLD_PSW+1,0xfd	# clear wait state bit
 	lpswe	__LC_EXT_OLD_PSW
@@ -57,10 +61,10 @@ ENTRY(s390_base_pgm_handler)
 	basr	%r13,0
 0:	aghi	%r15,-STACK_FRAME_OVERHEAD
 	larl	%r1,s390_base_pgm_handler_fn
-	lg	%r1,0(%r1)
-	ltgr	%r1,%r1
+	lg	%r9,0(%r1)
+	ltgr	%r9,%r9
 	jz	1f
-	basr	%r14,%r1
+	BASR_EX	%r14,%r9
 	lmg	%r0,%r15,__LC_SAVE_AREA_SYNC
 	lpswe	__LC_PGM_OLD_PSW
 1:	lpswe	disabled_wait_psw-0b(%r13)
@@ -117,7 +121,7 @@ ENTRY(diag308_reset)
 	larl	%r4,.Lcontinue_psw	# Restore PSW flags
 	lpswe	0(%r4)
 .Lcontinue:
-	br	%r14
+	BR_EX	%r14
 .align 16
 .Lrestart_psw:
 	.long	0x00080000,0x80000000 + .Lrestart_part2
--- a/arch/s390/kernel/reipl.S
+++ b/arch/s390/kernel/reipl.S
@@ -7,8 +7,11 @@
 
 #include <linux/linkage.h>
 #include <asm/asm-offsets.h>
+#include <asm/nospec-insn.h>
 #include <asm/sigp.h>
 
+	GEN_BR_THUNK %r9
+
 #
 # Issue "store status" for the current CPU to its prefix page
 # and call passed function afterwards
@@ -67,9 +70,9 @@ ENTRY(store_status)
 	st	%r4,0(%r1)
 	st	%r5,4(%r1)
 	stg	%r2,8(%r1)
-	lgr	%r1,%r2
+	lgr	%r9,%r2
 	lgr	%r2,%r3
-	br	%r1
+	BR_EX	%r9
 
 	.section .bss
 	.align	8
--- a/arch/s390/kernel/swsusp.S
+++ b/arch/s390/kernel/swsusp.S
@@ -13,6 +13,7 @@
 #include <asm/ptrace.h>
 #include <asm/thread_info.h>
 #include <asm/asm-offsets.h>
+#include <asm/nospec-insn.h>
 #include <asm/sigp.h>
 
 /*
@@ -24,6 +25,8 @@
  * (see below) in the resume process.
  * This function runs with disabled interrupts.
  */
+	GEN_BR_THUNK %r14
+
 	.section .text
 ENTRY(swsusp_arch_suspend)
 	stmg	%r6,%r15,__SF_GPRS(%r15)
@@ -103,7 +106,7 @@ ENTRY(swsusp_arch_suspend)
 	spx	0x318(%r1)
 	lmg	%r6,%r15,STACK_FRAME_OVERHEAD + __SF_GPRS(%r15)
 	lghi	%r2,0
-	br	%r14
+	BR_EX	%r14
 
 /*
  * Restore saved memory image to correct place and restore register context.
@@ -197,11 +200,10 @@ pgm_check_entry:
 	larl	%r15,init_thread_union
 	ahi	%r15,1<<(PAGE_SHIFT+THREAD_SIZE_ORDER)
 	larl	%r2,.Lpanic_string
-	larl	%r3,sclp_early_printk
 	lghi	%r1,0
 	sam31
 	sigp	%r1,%r0,SIGP_SET_ARCHITECTURE
-	basr	%r14,%r3
+	brasl	%r14,sclp_early_printk
 	larl	%r3,.Ldisabled_wait_31
 	lpsw	0(%r3)
 4:
@@ -267,7 +269,7 @@ restore_registers:
 	/* Return 0 */
 	lmg	%r6,%r15,STACK_FRAME_OVERHEAD + __SF_GPRS(%r15)
 	lghi	%r2,0
-	br	%r14
+	BR_EX	%r14
 
 	.section .data..nosave,"aw",@progbits
 	.align	8
