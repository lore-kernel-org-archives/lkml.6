Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226kSBYNe4Z+aCeASeK2Y5xpVKmzZ7ulfMo0DR8WcBunNNoMDx9ReDPwFLiTUnpM8T6fyl4x
ARC-Seal: i=1; a=rsa-sha256; t=1519218027; cv=none;
        d=google.com; s=arc-20160816;
        b=vNuchjrE78WcRpnGbQtTQkXIvtni9Xw0oT8SXdjhJ5pHHqHdHduOK0x0gXAKX3l3/G
         ARKAwIE4D4HaH25NpVQmn2V5nJpiCv1e9apnaax3+u81Z/N175+MAoPhS+qWx18FD/n8
         y3+63AaEyhF91nfpAo6+eBa9fRZrbOAvXR9X0WhIcEyl2/XGwvOEfyz3nVXeJpOxrsNC
         V1PidC1FgyTJQk44CzGFqqI4tDBF8N4hofTBr7kQqecgEyR/YKPIHf/IY1mzm8Jhjnlm
         FHKh8KHmaIstfHijM/hQimk5zv4PpZhUfzAUHdsvQWbU5bhkK46ZmAIKK2UtgUXOlunu
         wJFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=UTGsppAcigaA/E8z9Q00CqDTt4s6/tgWKAMCZTa3qBs=;
        b=B/TMRmHF2it4mtXHwsAgn7v6LBvZuBomnDlQ7WbugQMOfD3ySONlte+AwatMFtpVpL
         kMm4n6/xD1KBrrxpxsLxWbPV+qG68BxB2owekF4z7C49OAvetKWmc7lkjEVPbH86//WI
         W25s3SxnomDHkFO3hpOitml7FkK7lTxSiLMEsQCEWHXSgDjvR8UK9JM6xr9zyQGm4dUg
         LCNpp3ifj5qT/K+HGsmydTGja2sNSlxSnOmc+OwieDEwm1UO8cvhr58ZoYjWLO7RtleO
         aL6SSwNm+Nyubvtyc0NGrrMwhtgFatIzh8wh6gb5TDcNL4P+Y+W57gmHeqT3yj4McrAq
         ipBg==
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
Subject: [PATCH 4.14 061/167] x86/entry/64: Introduce the PUSH_AND_CLEAN_REGS macro
Date: Wed, 21 Feb 2018 13:47:52 +0100
Message-Id: <20180221124527.840118966@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015562439488858?=
X-GMAIL-MSGID: =?utf-8?q?1593015562439488858?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dominik Brodowski <linux@dominikbrodowski.net>

commit 3f01daecd545e818098d84fd1ad43e19a508d705 upstream.

Those instances where ALLOC_PT_GPREGS_ON_STACK is called just before
SAVE_AND_CLEAR_REGS can trivially be replaced by PUSH_AND_CLEAN_REGS.
This macro uses PUSH instead of MOV and should therefore be faster, at
least on newer CPUs.

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
Link: http://lkml.kernel.org/r/20180211104949.12992-5-linux@dominikbrodowski.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/entry/calling.h  |   36 ++++++++++++++++++++++++++++++++++++
 arch/x86/entry/entry_64.S |    6 ++----
 2 files changed, 38 insertions(+), 4 deletions(-)

--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -137,6 +137,42 @@ For 32-bit we have the following convent
 	UNWIND_HINT_REGS offset=\offset
 	.endm
 
+	.macro PUSH_AND_CLEAR_REGS
+	/*
+	 * Push registers and sanitize registers of values that a
+	 * speculation attack might otherwise want to exploit. The
+	 * lower registers are likely clobbered well before they
+	 * could be put to use in a speculative execution gadget.
+	 * Interleave XOR with PUSH for better uop scheduling:
+	 */
+	pushq   %rdi		/* pt_regs->di */
+	pushq   %rsi		/* pt_regs->si */
+	pushq   %rdx		/* pt_regs->dx */
+	pushq   %rcx		/* pt_regs->cx */
+	pushq   %rax		/* pt_regs->ax */
+	pushq   %r8		/* pt_regs->r8 */
+	xorq    %r8, %r8	/* nospec   r8 */
+	pushq   %r9		/* pt_regs->r9 */
+	xorq    %r9, %r9	/* nospec   r9 */
+	pushq   %r10		/* pt_regs->r10 */
+	xorq    %r10, %r10	/* nospec   r10 */
+	pushq   %r11		/* pt_regs->r11 */
+	xorq    %r11, %r11	/* nospec   r11*/
+	pushq	%rbx		/* pt_regs->rbx */
+	xorl    %ebx, %ebx	/* nospec   rbx*/
+	pushq	%rbp		/* pt_regs->rbp */
+	xorl    %ebp, %ebp	/* nospec   rbp*/
+	pushq	%r12		/* pt_regs->r12 */
+	xorq    %r12, %r12	/* nospec   r12*/
+	pushq	%r13		/* pt_regs->r13 */
+	xorq    %r13, %r13	/* nospec   r13*/
+	pushq	%r14		/* pt_regs->r14 */
+	xorq    %r14, %r14	/* nospec   r14*/
+	pushq	%r15		/* pt_regs->r15 */
+	xorq    %r15, %r15	/* nospec   r15*/
+	UNWIND_HINT_REGS
+	.endm
+
 	.macro POP_REGS pop_rdi=1 skip_r11rcx=0
 	popq %r15
 	popq %r14
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -560,8 +560,7 @@ END(irq_entries_start)
 	call	switch_to_thread_stack
 1:
 
-	ALLOC_PT_GPREGS_ON_STACK
-	SAVE_AND_CLEAR_REGS
+	PUSH_AND_CLEAR_REGS
 	ENCODE_FRAME_POINTER
 
 	testb	$3, CS(%rsp)
@@ -1106,8 +1105,7 @@ ENTRY(xen_failsafe_callback)
 	addq	$0x30, %rsp
 	UNWIND_HINT_IRET_REGS
 	pushq	$-1 /* orig_ax = -1 => not a system call */
-	ALLOC_PT_GPREGS_ON_STACK
-	SAVE_AND_CLEAR_REGS
+	PUSH_AND_CLEAR_REGS
 	ENCODE_FRAME_POINTER
 	jmp	error_exit
 END(xen_failsafe_callback)
