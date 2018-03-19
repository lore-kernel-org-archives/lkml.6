Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuRXfwIdvf0rJuuMb0e6bQJhizMfHPZ2Y2rmtLpjiVE8vFChD64V4P2KAl0PR4KnUMRKCZa
ARC-Seal: i=1; a=rsa-sha256; t=1521484317; cv=none;
        d=google.com; s=arc-20160816;
        b=CV5NvYlkrylf3VSNNk5+EzrdpI7D/25j0gKMF0Q89HAJ4z8lgl9qVCaEozoysbGtqR
         BH7GW3bhw8mD5V/rt+8nAhKeO5o0IMDe8ag0ywmiaZ2Be9h8ZtQ0Q9A+GujB1sUlrFVv
         xuSLjpEODGLEi/++I186QlLqyu8uqsiAT7wty+umqsZwtCx/UBbSORiGjTpsPXiAr4ax
         GJLOHC5j+KKNCzClGMvCNpUEbrJsC+syFB+nkiV1JFWV+CKv/E3Z9YMdnRMVT8LenCPJ
         6kZYLUh7mwqtmio18sAdVnLuhyXW76YXzCELBffWzdhcVOgIDUyW2xRw8D88JyTAdES1
         CF0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+OVjtNFtOYWfLGHogYGQXF7S5Vj+SK444heYdbEhAJE=;
        b=uk8Us67JS1RzPWaQJnZVaLeyYKtHReDs0c0SjhJqFWG378G/yI2Y22HeOXF3eFlBTS
         qfdBjns5WqesjxOvHN36zvnTRK8wB8FCURsTpxTSgIrYrjWg9fGDo4XfCrRvCbOnak41
         TqFfgvCX4H/LK+bTGm7McYf+kzAoxS8k6VGqrzLJdc/JRB06TK9ScaRgPF55kQD30Z1M
         Hw5u8odz2rqGOX+XJaq7krbCepWf+49+gz+WZBrssMEK26GK9birXL9yF2GSsr1HAsvx
         iS3ud0JgFhKgYxZsl2IkflPcus8VbxuzMyPl1p8z/LwJL16RGZgG4KUHJIwODAiF6fjx
         STKA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Bart Oldeman <bartoldeman@gmail.com>,
	Andy Lutomirski <luto@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Brian Gerst <brgerst@gmail.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Stas Sergeev <stsp@list.ru>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.15 04/52] selftests/x86/entry_from_vm86: Add test cases for POPF
Date: Mon, 19 Mar 2018 19:08:02 +0100
Message-Id: <20180319180735.259095372@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180734.976730813@linuxfoundation.org>
References: <20180319180734.976730813@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391056075291570?=
X-GMAIL-MSGID: =?utf-8?q?1595391939891264597?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Lutomirski <luto@kernel.org>

commit 78393fdde2a456cafa414b171c90f26a3df98b20 upstream.

POPF is currently broken -- add tests to catch the error.  This
results in:

   [RUN]	POPF with VIP set and IF clear from vm86 mode
   [INFO]	Exited vm86 mode due to STI
   [FAIL]	Incorrect return reason (started at eip = 0xd, ended at eip = 0xf)

because POPF currently fails to check IF before reporting a pending
interrupt.

This patch also makes the FAIL message a bit more informative.

Reported-by: Bart Oldeman <bartoldeman@gmail.com>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stas Sergeev <stsp@list.ru>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/a16270b5cfe7832d6d00c479d0f871066cbdb52b.1521003603.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/testing/selftests/x86/entry_from_vm86.c |   30 +++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

--- a/tools/testing/selftests/x86/entry_from_vm86.c
+++ b/tools/testing/selftests/x86/entry_from_vm86.c
@@ -95,6 +95,10 @@ asm (
 	"int3\n\t"
 	"vmcode_int80:\n\t"
 	"int $0x80\n\t"
+	"vmcode_popf_hlt:\n\t"
+	"push %ax\n\t"
+	"popf\n\t"
+	"hlt\n\t"
 	"vmcode_umip:\n\t"
 	/* addressing via displacements */
 	"smsw (2052)\n\t"
@@ -124,8 +128,8 @@ asm (
 
 extern unsigned char vmcode[], end_vmcode[];
 extern unsigned char vmcode_bound[], vmcode_sysenter[], vmcode_syscall[],
-	vmcode_sti[], vmcode_int3[], vmcode_int80[], vmcode_umip[],
-	vmcode_umip_str[], vmcode_umip_sldt[];
+	vmcode_sti[], vmcode_int3[], vmcode_int80[], vmcode_popf_hlt[],
+	vmcode_umip[], vmcode_umip_str[], vmcode_umip_sldt[];
 
 /* Returns false if the test was skipped. */
 static bool do_test(struct vm86plus_struct *v86, unsigned long eip,
@@ -175,7 +179,7 @@ static bool do_test(struct vm86plus_stru
 	    (VM86_TYPE(ret) == rettype && VM86_ARG(ret) == retarg)) {
 		printf("[OK]\tReturned correctly\n");
 	} else {
-		printf("[FAIL]\tIncorrect return reason\n");
+		printf("[FAIL]\tIncorrect return reason (started at eip = 0x%lx, ended at eip = 0x%lx)\n", eip, v86->regs.eip);
 		nerrs++;
 	}
 
@@ -264,6 +268,9 @@ int main(void)
 	v86.regs.ds = load_addr / 16;
 	v86.regs.es = load_addr / 16;
 
+	/* Use the end of the page as our stack. */
+	v86.regs.esp = 4096;
+
 	assert((v86.regs.cs & 3) == 0);	/* Looks like RPL = 0 */
 
 	/* #BR -- should deliver SIG??? */
@@ -295,6 +302,23 @@ int main(void)
 	v86.regs.eflags &= ~X86_EFLAGS_IF;
 	do_test(&v86, vmcode_sti - vmcode, VM86_STI, 0, "STI with VIP set");
 
+	/* POPF with VIP set but IF clear: should not trap */
+	v86.regs.eflags = X86_EFLAGS_VIP;
+	v86.regs.eax = 0;
+	do_test(&v86, vmcode_popf_hlt - vmcode, VM86_UNKNOWN, 0, "POPF with VIP set and IF clear");
+
+	/* POPF with VIP set and IF set: should trap */
+	v86.regs.eflags = X86_EFLAGS_VIP;
+	v86.regs.eax = X86_EFLAGS_IF;
+	do_test(&v86, vmcode_popf_hlt - vmcode, VM86_STI, 0, "POPF with VIP and IF set");
+
+	/* POPF with VIP clear and IF set: should not trap */
+	v86.regs.eflags = 0;
+	v86.regs.eax = X86_EFLAGS_IF;
+	do_test(&v86, vmcode_popf_hlt - vmcode, VM86_UNKNOWN, 0, "POPF with VIP clear and IF set");
+
+	v86.regs.eflags = 0;
+
 	/* INT3 -- should cause #BP */
 	do_test(&v86, vmcode_int3 - vmcode, VM86_TRAP, 3, "INT3");
 
