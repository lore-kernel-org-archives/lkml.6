Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2273/gfn0WZ/3Tbi6ax9TkRozWhhJ2410CM2IhADY+oLo5lP8/+kQhV79oJrAhzH/7sLsVux
ARC-Seal: i=1; a=rsa-sha256; t=1519218017; cv=none;
        d=google.com; s=arc-20160816;
        b=PSvkFclFP0J+7WOaZcHCp21QpUFL4IA2K1HXV0wJ9eXPt3swEGty8O3Yr3ObY8Fyne
         aimBMyUI1WF0MfygMcqSmYNuiEgCFFDyTHZT++CNOECScjBFW1JU9a/L30AZ5h6GJZ/6
         Sj+bSn+NTRbobw22eUxdoBVRMrnKM/2hjyk4Tzm+yW3KMDTwGVSz7o49Ew+MM1xB2WD9
         ZOw0N/FuGMEj6G4+G3mP66Cm2ERj7L/xpK9LEzZ3EIvFZFwcpdCFetFfHC2ptNzfY/Xd
         dMS7MOzt/q65elG7fMWqg2SfHYcQhadMJLGR7RVNUR7iQOEd0/+15G0hhTU02RJXA04r
         BZ1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=qag8lkk8ph2sbAiZQXz9/UoYxV07hJeGUHZrJGFu5OQ=;
        b=Tp+T1v9ST14u1RuQMJXasQZajiyfedg/64IqLUHR5rTYIZ5vJQgaBY2eynH5lCLXCK
         Wn8ITkCigoOG9pycbEsr5WLIhuw205ApcGwf+QL7WutTr7H93LPzLkHtVT41SG9hiBFt
         U51bvLjtGhd3sp0ZWmMxDoIjYpoxFFl8YgH9LXU9tkEyh4d2TwB5ck5/IxRcdxWZae4w
         im4N5z8nFq340TBWMFDloFTHE5Hb04qRVXs8y23Nv1hTL41GlFB0fvSCm/SdCpBxKI6M
         ktDHi5LP1riHV9rgOYz+agL6tWcbmJi+Qjh41fln4Z2sIcOBJhMYym0vGlSCB/JZb7p6
         ajMg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Andy Lutomirski <luto@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Brian Gerst <brgerst@gmail.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	dan.j.williams@intel.com,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 058/167] x86/entry/64: Merge SAVE_C_REGS and SAVE_EXTRA_REGS, remove unused extensions
Date: Wed, 21 Feb 2018 13:47:49 +0100
Message-Id: <20180221124527.700360373@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015551426490024?=
X-GMAIL-MSGID: =?utf-8?q?1593015551426490024?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dominik Brodowski <linux@dominikbrodowski.net>

commit 2e3f0098bc45f710a2f4cbcc94b80a1fae7a99a1 upstream.

All current code paths call SAVE_C_REGS and then immediately
SAVE_EXTRA_REGS. Therefore, merge these two macros and order the MOV
sequeneces properly.

While at it, remove the macros to save all except specific registers,
as these macros have been unused for a long time.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: dan.j.williams@intel.com
Link: http://lkml.kernel.org/r/20180211104949.12992-2-linux@dominikbrodowski.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/entry/calling.h  |   57 ++++++++++++----------------------------------
 arch/x86/entry/entry_64.S |   12 +++------
 2 files changed, 19 insertions(+), 50 deletions(-)

--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -101,49 +101,22 @@ For 32-bit we have the following convent
 	addq	$-(15*8), %rsp
 	.endm
 
-	.macro SAVE_C_REGS_HELPER offset=0 rax=1 rcx=1 r8910=1 r11=1
-	.if \r11
-	movq %r11, 6*8+\offset(%rsp)
-	.endif
-	.if \r8910
-	movq %r10, 7*8+\offset(%rsp)
-	movq %r9,  8*8+\offset(%rsp)
-	movq %r8,  9*8+\offset(%rsp)
-	.endif
-	.if \rax
-	movq %rax, 10*8+\offset(%rsp)
-	.endif
-	.if \rcx
-	movq %rcx, 11*8+\offset(%rsp)
-	.endif
-	movq %rdx, 12*8+\offset(%rsp)
-	movq %rsi, 13*8+\offset(%rsp)
+	.macro SAVE_REGS offset=0
 	movq %rdi, 14*8+\offset(%rsp)
-	UNWIND_HINT_REGS offset=\offset extra=0
-	.endm
-	.macro SAVE_C_REGS offset=0
-	SAVE_C_REGS_HELPER \offset, 1, 1, 1, 1
-	.endm
-	.macro SAVE_C_REGS_EXCEPT_RAX_RCX offset=0
-	SAVE_C_REGS_HELPER \offset, 0, 0, 1, 1
-	.endm
-	.macro SAVE_C_REGS_EXCEPT_R891011
-	SAVE_C_REGS_HELPER 0, 1, 1, 0, 0
-	.endm
-	.macro SAVE_C_REGS_EXCEPT_RCX_R891011
-	SAVE_C_REGS_HELPER 0, 1, 0, 0, 0
-	.endm
-	.macro SAVE_C_REGS_EXCEPT_RAX_RCX_R11
-	SAVE_C_REGS_HELPER 0, 0, 0, 1, 0
-	.endm
-
-	.macro SAVE_EXTRA_REGS offset=0
-	movq %r15, 0*8+\offset(%rsp)
-	movq %r14, 1*8+\offset(%rsp)
-	movq %r13, 2*8+\offset(%rsp)
-	movq %r12, 3*8+\offset(%rsp)
-	movq %rbp, 4*8+\offset(%rsp)
+	movq %rsi, 13*8+\offset(%rsp)
+	movq %rdx, 12*8+\offset(%rsp)
+	movq %rcx, 11*8+\offset(%rsp)
+	movq %rax, 10*8+\offset(%rsp)
+	movq %r8,  9*8+\offset(%rsp)
+	movq %r9,  8*8+\offset(%rsp)
+	movq %r10, 7*8+\offset(%rsp)
+	movq %r11, 6*8+\offset(%rsp)
 	movq %rbx, 5*8+\offset(%rsp)
+	movq %rbp, 4*8+\offset(%rsp)
+	movq %r12, 3*8+\offset(%rsp)
+	movq %r13, 2*8+\offset(%rsp)
+	movq %r14, 1*8+\offset(%rsp)
+	movq %r15, 0*8+\offset(%rsp)
 	UNWIND_HINT_REGS offset=\offset
 	.endm
 
@@ -197,7 +170,7 @@ For 32-bit we have the following convent
  * is just setting the LSB, which makes it an invalid stack address and is also
  * a signal to the unwinder that it's a pt_regs pointer in disguise.
  *
- * NOTE: This macro must be used *after* SAVE_EXTRA_REGS because it corrupts
+ * NOTE: This macro must be used *after* SAVE_REGS because it corrupts
  * the original rbp.
  */
 .macro ENCODE_FRAME_POINTER ptregs_offset=0
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -569,8 +569,7 @@ END(irq_entries_start)
 1:
 
 	ALLOC_PT_GPREGS_ON_STACK
-	SAVE_C_REGS
-	SAVE_EXTRA_REGS
+	SAVE_REGS
 	CLEAR_REGS_NOSPEC
 	ENCODE_FRAME_POINTER
 
@@ -1126,8 +1125,7 @@ ENTRY(xen_failsafe_callback)
 	UNWIND_HINT_IRET_REGS
 	pushq	$-1 /* orig_ax = -1 => not a system call */
 	ALLOC_PT_GPREGS_ON_STACK
-	SAVE_C_REGS
-	SAVE_EXTRA_REGS
+	SAVE_REGS
 	CLEAR_REGS_NOSPEC
 	ENCODE_FRAME_POINTER
 	jmp	error_exit
@@ -1172,8 +1170,7 @@ idtentry machine_check		do_mce			has_err
 ENTRY(paranoid_entry)
 	UNWIND_HINT_FUNC
 	cld
-	SAVE_C_REGS 8
-	SAVE_EXTRA_REGS 8
+	SAVE_REGS 8
 	CLEAR_REGS_NOSPEC
 	ENCODE_FRAME_POINTER 8
 	movl	$1, %ebx
@@ -1225,8 +1222,7 @@ END(paranoid_exit)
 ENTRY(error_entry)
 	UNWIND_HINT_FUNC
 	cld
-	SAVE_C_REGS 8
-	SAVE_EXTRA_REGS 8
+	SAVE_REGS 8
 	CLEAR_REGS_NOSPEC
 	ENCODE_FRAME_POINTER 8
 	testb	$3, CS+8(%rsp)
