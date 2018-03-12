Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELuhL1Z2Nmixl5XsGUtMDzpMhm1RsScWxY9H6Z0m2ra7Y1/zsnI1ijk6AgUdp2NdCpBBTlKz
ARC-Seal: i=1; a=rsa-sha256; t=1520824098; cv=none;
        d=google.com; s=arc-20160816;
        b=Apa9WKQEJ7jHDEOwhpU1VfKgN9dEqDggkhlKnL8qrtdSWu1/TJZSG/x4yOukHcMswm
         aH0K8tluGVOJjvRZUf/qWLf8aBNmPF3VcrV3jt08KCdRIKXFjC4oyBurAojiyvaFpEpI
         trBolxD2sz0LHspikzSlnDWfUb2Jo1bAQUXCJWg2eEQBdgIpZVnQPJe+HFRx428tPw2P
         P6Iu4VUIoCisTpPOh4lZ8m5Wvc/EXa/YrGdFpMSC84aReIdkAIk4KAHWJR/QtzI348SF
         hJr3nAmVU/6vsPnqwV+mXcnkGL6izHk+7biVr1hWVhQq8wm6QVoGOBsLEPLoe2vsa5Qn
         mh6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=I+xtjoG+M0CCUBSv26cWXK8X5BRhTVBatdMxw2D95JE=;
        b=JlCj+IV3QM8c2beNOEiFSz3y92jUCA9nJk/rbsPN9tLiRzFIUZ+pgDRX17dBl5vD9w
         NTBbevtDK+FkdH4L9JLSJykoEHGrpTatObDZjayzLhFacTYrXPbwmG33iMHn82gL/npw
         QSPyEBRRzVy/VC8r0P0lzVE1CNSzch5d+5ugW7p8e4YhOfJHkWrP3AmTdB6rpBJvWlHH
         MQlIjGrGN4Hy6geX27YVZt/RVagncFqgs71iBS5cPXENNbL/K9DWsE//gBaO1A4X/Jjl
         BkKEjG4z6rpLQuxTCR/7v8fezaTRJ6CyrOlxu5Swg5eXARF9gnJrljxXV/hmqVbDCFM2
         HyvA==
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
 "Andy Lutomirski" <luto@amacapital.net>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Josh Poimboeuf" <jpoimboe@redhat.com>,
 "Ingo Molnar" <mingo@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 gnomes@lxorguk.ukuu.org.uk,
 "Dave Hansen" <dave.hansen@intel.com>,
 "Kees Cook" <keescook@google.com>,
 "Jiri Kosina" <jikos@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linux-foundation.org>,
 "David Woodhouse" <dwmw@amazon.co.uk>,
 thomas.lendacky@amd.com,
 "Arjan van de Ven" <arjan@linux.intel.com>,
 "Rik van Riel" <riel@redhat.com>,
 "Andi Kleen" <ak@linux.intel.com>,
 "Paul Turner" <pjt@google.com>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Tim Chen" <tim.c.chen@linux.intel.com>
Date: Mon, 12 Mar 2018 03:06:12 +0000
Message-ID: <lsq.1520823972.814802306@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 27/76] x86/retpoline/ftrace: Convert ftrace assembler
 indirect jumps
In-Reply-To: <lsq.1520823971.5976735@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699641468699388?=
X-GMAIL-MSGID: =?utf-8?q?1594699649583055772?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.56-rc1 review patch.  If anyone has any objections, please let me know.

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
[bwh: Backported to 3.16: adjust filenames, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/x86/kernel/entry_32.S
+++ b/arch/x86/kernel/entry_32.S
@@ -1189,7 +1189,8 @@ trace:
 	movl 0x4(%ebp), %edx
 	subl $MCOUNT_INSN_SIZE, %eax
 
-	call *ftrace_trace_function
+	movl ftrace_trace_function, %ecx
+	CALL_NOSPEC %ecx
 
 	popl %edx
 	popl %ecx
@@ -1224,7 +1225,7 @@ return_to_handler:
 	movl %eax, %ecx
 	popl %edx
 	popl %eax
-	jmp *%ecx
+	JMP_NOSPEC %ecx
 #endif
 
 #ifdef CONFIG_TRACING
--- a/arch/x86/kernel/mcount_64.S
+++ b/arch/x86/kernel/mcount_64.S
@@ -7,7 +7,7 @@
 #include <linux/linkage.h>
 #include <asm/ptrace.h>
 #include <asm/ftrace.h>
-
+#include <asm/nospec-branch.h>
 
 	.code64
 	.section .entry.text, "ax"
@@ -210,8 +210,8 @@ trace:
 #endif
 	subq $MCOUNT_INSN_SIZE, %rdi
 
-	call   *ftrace_trace_function
-
+	movq ftrace_trace_function, %r8
+	CALL_NOSPEC %r8
 	MCOUNT_RESTORE_FRAME
 
 	jmp ftrace_stub
@@ -254,5 +254,5 @@ GLOBAL(return_to_handler)
 	movq 8(%rsp), %rdx
 	movq (%rsp), %rax
 	addq $24, %rsp
-	jmp *%rdi
+	JMP_NOSPEC %rdi
 #endif
