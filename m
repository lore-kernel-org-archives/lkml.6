Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELuz75gyNgWIABgbP1iIyrAtE5cKH3tiXcJ0BZzgDXrTXX2m7vezxVOa88VTAOQ684ZGU9AW
ARC-Seal: i=1; a=rsa-sha256; t=1520824090; cv=none;
        d=google.com; s=arc-20160816;
        b=XGAOKl/xIKjEr3UGsFZFxDpIvX12gnnhqMYJl3o+GXN9PsZ/8C8DtFdTOlJTGPOsff
         hqagmBbFzY5WX7pGOFOPPokVvSykk7vUOXk0xUMW6F25sjhmLdIjnMKnz1HJwHigXF/d
         A6cFwPK2zp977FtFQ/0fWQt8TbSJhxJSSeF0+iA/HJJy2cs4K3VGaenEbOxQ6GBHdLeT
         ELnrUXA5aqAIg5cx0jfBB4SiBDobshfJJe8S64T1Zr1q1mitxrUha6fMppnuJVLwNGnp
         qta+xaZZJfBddtUnzF1eG/m+Wix0BEQHxaTfc9KtmScPRC0LJXffcT90OKsM4LiVVTKP
         jnIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=vIctZk2KqC5Q099pz40zZ5L5pL6VecL0/Qd72sZY3p8=;
        b=L21Tq4A3dwJWb6u6yqBYKgvnvddpmx36figrpPEPMPrnRqTQ0Vp5PjuggPWq/ouLHf
         f0wfhYdOEHEnBV3BP6Sk85D7zYU55kOehfSk3endFUgh42YOZaNhaXmYYqLyaYzVFjem
         9d5xgodK8wO36auUn9WNkRGgarJzeSkosUHrVvfmWQ+bIs89SqnTNFTip/D6UDYxjaEv
         ZmkvgvTUkz+pRR2tuVwN6c7UNNpT9eLDHNtQ7Q7biT0ht0dGOwORfn/hREGX6Xe0vx22
         xiU3W/Nlzgjg2YvisjueVu9+PSAL8hMaXLHPSXkECMojESIrX1sVZXv/M4/atvRYZFiP
         COfA==
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
 "Kees Cook" <keescook@google.com>,
 thomas.lendacky@amd.com,
 "Andy Lutomirski" <luto@amacapital.net>,
 "Josh Poimboeuf" <jpoimboe@redhat.com>,
 "Greg Kroah-Hartman" <gregkh@linux-foundation.org>,
 "Jiri Kosina" <jikos@kernel.org>,
 "Dave Hansen" <dave.hansen@intel.com>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Rik van Riel" <riel@redhat.com>,
 "Andi Kleen" <ak@linux.intel.com>,
 "David Woodhouse" <dwmw@amazon.co.uk>,
 "Ingo Molnar" <mingo@kernel.org>,
 "Tim Chen" <tim.c.chen@linux.intel.com>,
 "Peter Zijlstra" <peterz@infradead.org>,
 gnomes@lxorguk.ukuu.org.uk,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Paul Turner" <pjt@google.com>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.580494457@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 061/104] x86/retpoline/ftrace: Convert ftrace
 assembler indirect jumps
In-Reply-To: <lsq.1520823814.606620518@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699641468699388?=
X-GMAIL-MSGID: =?utf-8?q?1594699641468699388?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.101-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: David Woodhouse <dwmw@amazon.co.uk>

commit 9351803bd803cdbeb9b5a7850b7b6f464806e3db upstream.

Convert all indirect jumps in ftrace assembler code to use non-speculative
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
Link: https://lkml.kernel.org/r/1515707194-20531-8-git-send-email-dwmw@amazon.co.uk
[bwh: Backported to 3.2: adjust filenames, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/x86/kernel/entry_32.S
+++ b/arch/x86/kernel/entry_32.S
@@ -1183,7 +1183,8 @@ trace:
 	movl 0x4(%ebp), %edx
 	subl $MCOUNT_INSN_SIZE, %eax
 
-	call *ftrace_trace_function
+	movl ftrace_trace_function, %ecx
+	CALL_NOSPEC %ecx
 
 	popl %edx
 	popl %ecx
@@ -1221,7 +1222,7 @@ return_to_handler:
 	movl %eax, %ecx
 	popl %edx
 	popl %eax
-	jmp *%ecx
+	JMP_NOSPEC %ecx
 #endif
 
 .section .rodata,"a"
--- a/arch/x86/kernel/entry_64.S
+++ b/arch/x86/kernel/entry_64.S
@@ -126,8 +126,8 @@ trace:
 	movq 8(%rbp), %rsi
 	subq $MCOUNT_INSN_SIZE, %rdi
 
-	call   *ftrace_trace_function
-
+	movq ftrace_trace_function, %r8
+	CALL_NOSPEC %r8
 	MCOUNT_RESTORE_FRAME
 
 	jmp ftrace_stub
@@ -168,7 +168,7 @@ GLOBAL(return_to_handler)
 	movq 8(%rsp), %rdx
 	movq (%rsp), %rax
 	addq $24, %rsp
-	jmp *%rdi
+	JMP_NOSPEC %rdi
 #endif
 
 
