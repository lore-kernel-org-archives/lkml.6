Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AH8x225/KVUt15gJDL0ONWVOB9Q31CwVyxMY+/zvM0D4tsldBzbZvhcjj5OlTnGW+seB/v4APewf
ARC-Seal: i=1; a=rsa-sha256; t=1518168358; cv=none;
        d=google.com; s=arc-20160816;
        b=xLKyLsWDR5KnNEkubvyqYtJMyOqlvslv4g9IHS0YoRugMcdnXS/oTpC6TjaTjtSLZg
         C4eZtpCHmlNfxYUdtYmgDa329Qt1HJFrPq02pkEzsBFV5M1BhcJ5su1BgwlGvfDqJ+OJ
         IlU8Ty1mHzP2h0XWs3IiC47sOjI4RHXNJKZb2S7j+WTDSxp7FgDkWuDM8kAmpJCeWgEP
         CFohkeHrMKu1PpvlmWJFzGyIrtQ0tarrSeEIa16fWbgDOjmQay/QteIe2q8LUlsgC5n1
         YZzVJNj2AktrrraJ0orV352gueSg92rGzQvw/M+EcMcRq5KabXdBmzfudLkoFTavxkxD
         RQrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=FsHr9cyDtWkPGmYU2PDo95OfsWWzAjreN/HkHHuHYlM=;
        b=MiTklFpSksmfxGtLQtYz6cuDzWMLiCLmgG4yn0GF3GX4dFFNzYc+vKz72FzktQOHTL
         gli+X2ab4fHTe5mVdnZ2xUxR6iS/bqszTW8P+Yk4eAA1T0r8iRlNfU+SvaBSNnPxZQyf
         liSbfLWsLJ405QgCCRq3mJHI9Mfqjb+uEXQu1bI/BHJT7dbEYpw8nQesCwvcdQjavNl1
         OC4vov2N+9yogQShDC6Z4Dmpk3SBHnyNEauy9oKcZNNd4wVuVUB3PpdzAkYU2MQ5h40C
         Gv5gbX+M8hIKls49yPA0hetbNWOQDLn1e9OXegRzHdJKEzdyY0uKIezdCZrLYL9gwueU
         yKmA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=elXEVgVH;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=elXEVgVH;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
From: Joerg Roedel <joro@8bytes.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Dave Hansen <dave.hansen@intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>,
	Jiri Kosina <jkosina@suse.cz>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Brian Gerst <brgerst@gmail.com>,
	David Laight <David.Laight@aculab.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	Eduardo Valentin <eduval@amazon.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Will Deacon <will.deacon@arm.com>,
	aliguori@amazon.com,
	daniel.gruss@iaik.tugraz.at,
	hughd@google.com,
	keescook@google.com,
	Andrea Arcangeli <aarcange@redhat.com>,
	Waiman Long <llong@redhat.com>,
	Pavel Machek <pavel@ucw.cz>,
	jroedel@suse.de,
	joro@8bytes.org
Subject: [PATCH 07/31] x86/entry/32: Restore segments before int registers
Date: Fri,  9 Feb 2018 10:25:16 +0100
Message-Id: <1518168340-9392-8-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518168340-9392-1-git-send-email-joro@8bytes.org>
References: <1518168340-9392-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914904268770431?=
X-GMAIL-MSGID: =?utf-8?q?1591914904268770431?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Joerg Roedel <jroedel@suse.de>

Restoring the segments can cause exceptions that need to be
handled. With PTI enabled, we still need to be on kernel cr3
when the exception happens. For the cr3-switch we need
at least one integer scratch register, so we can't switch
with the user integer registers already loaded.

Avoid a push/pop cycle to free a register for the cr3 switch
by restoring the segments first. That way the integer
registers are not live yet and we can use them for the cr3
switch.

This also helps in the NMI path, where we need to leave with
the same cr3 as we entered. There we still have the
callee-saved registers live when switching cr3s.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/entry/entry_32.S | 50 ++++++++++++++++++++---------------------------
 1 file changed, 21 insertions(+), 29 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 9bd7718..b39c5e2 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -92,11 +92,6 @@
 .macro PUSH_GS
 	pushl	$0
 .endm
-.macro POP_GS pop=0
-	addl	$(4 + \pop), %esp
-.endm
-.macro POP_GS_EX
-.endm
 
  /* all the rest are no-op */
 .macro PTGS_TO_GS
@@ -116,20 +111,6 @@
 	pushl	%gs
 .endm
 
-.macro POP_GS pop=0
-98:	popl	%gs
-  .if \pop <> 0
-	add	$\pop, %esp
-  .endif
-.endm
-.macro POP_GS_EX
-.pushsection .fixup, "ax"
-99:	movl	$0, (%esp)
-	jmp	98b
-.popsection
-	_ASM_EXTABLE(98b, 99b)
-.endm
-
 .macro PTGS_TO_GS
 98:	mov	PT_GS(%esp), %gs
 .endm
@@ -201,24 +182,35 @@
 	popl	%eax
 .endm
 
-.macro RESTORE_REGS pop=0
-	RESTORE_INT_REGS
-1:	popl	%ds
-2:	popl	%es
-3:	popl	%fs
-	POP_GS \pop
+.macro RESTORE_SEGMENTS
+1:	mov	PT_DS(%esp), %ds
+2:	mov	PT_ES(%esp), %es
+3:	mov	PT_FS(%esp), %fs
+	PTGS_TO_GS
 .pushsection .fixup, "ax"
-4:	movl	$0, (%esp)
+4:	movl	$0, PT_DS(%esp)
 	jmp	1b
-5:	movl	$0, (%esp)
+5:	movl	$0, PT_ES(%esp)
 	jmp	2b
-6:	movl	$0, (%esp)
+6:	movl	$0, PT_FS(%esp)
 	jmp	3b
 .popsection
 	_ASM_EXTABLE(1b, 4b)
 	_ASM_EXTABLE(2b, 5b)
 	_ASM_EXTABLE(3b, 6b)
-	POP_GS_EX
+	PTGS_TO_GS_EX
+.endm
+
+.macro RESTORE_SKIP_SEGMENTS pop=0
+	/* Jump over the segments stored on stack */
+	addl	$((4 * 4) + \pop), %esp
+.endm
+
+.macro RESTORE_REGS pop=0
+	RESTORE_SEGMENTS
+	RESTORE_INT_REGS
+	/* Skip over already restored segment registers */
+	RESTORE_SKIP_SEGMENTS \pop
 .endm
 
 .macro CHECK_AND_APPLY_ESPFIX
-- 
2.7.4
