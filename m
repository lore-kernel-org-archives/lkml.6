Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753272AbeCNIri (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 04:47:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54083 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751480AbeCNIrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 04:47:36 -0400
Date: Wed, 14 Mar 2018 01:46:47 -0700
From: tip-bot for Andy Lutomirski <tipbot@zytor.com>
Message-ID: <tip-78393fdde2a456cafa414b171c90f26a3df98b20@git.kernel.org>
Cc: luto@kernel.org, jpoimboe@redhat.com, brgerst@gmail.com,
        peterz@infradead.org, bartoldeman@gmail.com, bp@alien8.de,
        hpa@zytor.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, dvlasenk@redhat.com, stsp@list.ru,
        tglx@linutronix.de
Reply-To: brgerst@gmail.com, luto@kernel.org, jpoimboe@redhat.com,
        hpa@zytor.com, bartoldeman@gmail.com, peterz@infradead.org,
        bp@alien8.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        stsp@list.ru, tglx@linutronix.de, torvalds@linux-foundation.org,
        dvlasenk@redhat.com
In-Reply-To: <a16270b5cfe7832d6d00c479d0f871066cbdb52b.1521003603.git.luto@kernel.org>
References: <a16270b5cfe7832d6d00c479d0f871066cbdb52b.1521003603.git.luto@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] selftests/x86/entry_from_vm86: Add test cases for
 POPF
Git-Commit-ID: 78393fdde2a456cafa414b171c90f26a3df98b20
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  78393fdde2a456cafa414b171c90f26a3df98b20
Gitweb:     https://git.kernel.org/tip/78393fdde2a456cafa414b171c90f26a3df98b20
Author:     Andy Lutomirski <luto@kernel.org>
AuthorDate: Tue, 13 Mar 2018 22:03:11 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 14 Mar 2018 09:21:01 +0100

selftests/x86/entry_from_vm86: Add test cases for POPF

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
---
 tools/testing/selftests/x86/entry_from_vm86.c | 30 ++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/x86/entry_from_vm86.c b/tools/testing/selftests/x86/entry_from_vm86.c
index 6e85f0d0498d..ade443a88421 100644
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
@@ -175,7 +179,7 @@ static bool do_test(struct vm86plus_struct *v86, unsigned long eip,
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
 
