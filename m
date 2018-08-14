Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A41C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6681121728
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:24:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6681121728
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387832AbeHNUMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:12:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51218 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387747AbeHNUMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:12:12 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 158DAC5C;
        Tue, 14 Aug 2018 17:24:05 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nadav Amit <namit@vmware.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH 4.18 01/79] x86/paravirt: Fix spectre-v2 mitigations for paravirt guests
Date:   Tue, 14 Aug 2018 19:16:20 +0200
Message-Id: <20180814171336.852079487@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171336.799314117@linuxfoundation.org>
References: <20180814171336.799314117@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

commit 5800dc5c19f34e6e03b5adab1282535cb102fafd upstream.

Nadav reported that on guests we're failing to rewrite the indirect
calls to CALLEE_SAVE paravirt functions. In particular the
pv_queued_spin_unlock() call is left unpatched and that is all over the
place. This obviously wrecks Spectre-v2 mitigation (for paravirt
guests) which relies on not actually having indirect calls around.

The reason is an incorrect clobber test in paravirt_patch_call(); this
function rewrites an indirect call with a direct call to the _SAME_
function, there is no possible way the clobbers can be different
because of this.

Therefore remove this clobber check. Also put WARNs on the other patch
failure case (not enough room for the instruction) which I've not seen
trigger in my (limited) testing.

Three live kernel image disassemblies for lock_sock_nested (as a small
function that illustrates the problem nicely). PRE is the current
situation for guests, POST is with this patch applied and NATIVE is with
or without the patch for !guests.

PRE:

(gdb) disassemble lock_sock_nested
Dump of assembler code for function lock_sock_nested:
   0xffffffff817be970 <+0>:     push   %rbp
   0xffffffff817be971 <+1>:     mov    %rdi,%rbp
   0xffffffff817be974 <+4>:     push   %rbx
   0xffffffff817be975 <+5>:     lea    0x88(%rbp),%rbx
   0xffffffff817be97c <+12>:    callq  0xffffffff819f7160 <_cond_resched>
   0xffffffff817be981 <+17>:    mov    %rbx,%rdi
   0xffffffff817be984 <+20>:    callq  0xffffffff819fbb00 <_raw_spin_lock_bh>
   0xffffffff817be989 <+25>:    mov    0x8c(%rbp),%eax
   0xffffffff817be98f <+31>:    test   %eax,%eax
   0xffffffff817be991 <+33>:    jne    0xffffffff817be9ba <lock_sock_nested+74>
   0xffffffff817be993 <+35>:    movl   $0x1,0x8c(%rbp)
   0xffffffff817be99d <+45>:    mov    %rbx,%rdi
   0xffffffff817be9a0 <+48>:    callq  *0xffffffff822299e8
   0xffffffff817be9a7 <+55>:    pop    %rbx
   0xffffffff817be9a8 <+56>:    pop    %rbp
   0xffffffff817be9a9 <+57>:    mov    $0x200,%esi
   0xffffffff817be9ae <+62>:    mov    $0xffffffff817be993,%rdi
   0xffffffff817be9b5 <+69>:    jmpq   0xffffffff81063ae0 <__local_bh_enable_ip>
   0xffffffff817be9ba <+74>:    mov    %rbp,%rdi
   0xffffffff817be9bd <+77>:    callq  0xffffffff817be8c0 <__lock_sock>
   0xffffffff817be9c2 <+82>:    jmp    0xffffffff817be993 <lock_sock_nested+35>
End of assembler dump.

POST:

(gdb) disassemble lock_sock_nested
Dump of assembler code for function lock_sock_nested:
   0xffffffff817be970 <+0>:     push   %rbp
   0xffffffff817be971 <+1>:     mov    %rdi,%rbp
   0xffffffff817be974 <+4>:     push   %rbx
   0xffffffff817be975 <+5>:     lea    0x88(%rbp),%rbx
   0xffffffff817be97c <+12>:    callq  0xffffffff819f7160 <_cond_resched>
   0xffffffff817be981 <+17>:    mov    %rbx,%rdi
   0xffffffff817be984 <+20>:    callq  0xffffffff819fbb00 <_raw_spin_lock_bh>
   0xffffffff817be989 <+25>:    mov    0x8c(%rbp),%eax
   0xffffffff817be98f <+31>:    test   %eax,%eax
   0xffffffff817be991 <+33>:    jne    0xffffffff817be9ba <lock_sock_nested+74>
   0xffffffff817be993 <+35>:    movl   $0x1,0x8c(%rbp)
   0xffffffff817be99d <+45>:    mov    %rbx,%rdi
   0xffffffff817be9a0 <+48>:    callq  0xffffffff810a0c20 <__raw_callee_save___pv_queued_spin_unlock>
   0xffffffff817be9a5 <+53>:    xchg   %ax,%ax
   0xffffffff817be9a7 <+55>:    pop    %rbx
   0xffffffff817be9a8 <+56>:    pop    %rbp
   0xffffffff817be9a9 <+57>:    mov    $0x200,%esi
   0xffffffff817be9ae <+62>:    mov    $0xffffffff817be993,%rdi
   0xffffffff817be9b5 <+69>:    jmpq   0xffffffff81063aa0 <__local_bh_enable_ip>
   0xffffffff817be9ba <+74>:    mov    %rbp,%rdi
   0xffffffff817be9bd <+77>:    callq  0xffffffff817be8c0 <__lock_sock>
   0xffffffff817be9c2 <+82>:    jmp    0xffffffff817be993 <lock_sock_nested+35>
End of assembler dump.

NATIVE:

(gdb) disassemble lock_sock_nested
Dump of assembler code for function lock_sock_nested:
   0xffffffff817be970 <+0>:     push   %rbp
   0xffffffff817be971 <+1>:     mov    %rdi,%rbp
   0xffffffff817be974 <+4>:     push   %rbx
   0xffffffff817be975 <+5>:     lea    0x88(%rbp),%rbx
   0xffffffff817be97c <+12>:    callq  0xffffffff819f7160 <_cond_resched>
   0xffffffff817be981 <+17>:    mov    %rbx,%rdi
   0xffffffff817be984 <+20>:    callq  0xffffffff819fbb00 <_raw_spin_lock_bh>
   0xffffffff817be989 <+25>:    mov    0x8c(%rbp),%eax
   0xffffffff817be98f <+31>:    test   %eax,%eax
   0xffffffff817be991 <+33>:    jne    0xffffffff817be9ba <lock_sock_nested+74>
   0xffffffff817be993 <+35>:    movl   $0x1,0x8c(%rbp)
   0xffffffff817be99d <+45>:    mov    %rbx,%rdi
   0xffffffff817be9a0 <+48>:    movb   $0x0,(%rdi)
   0xffffffff817be9a3 <+51>:    nopl   0x0(%rax)
   0xffffffff817be9a7 <+55>:    pop    %rbx
   0xffffffff817be9a8 <+56>:    pop    %rbp
   0xffffffff817be9a9 <+57>:    mov    $0x200,%esi
   0xffffffff817be9ae <+62>:    mov    $0xffffffff817be993,%rdi
   0xffffffff817be9b5 <+69>:    jmpq   0xffffffff81063ae0 <__local_bh_enable_ip>
   0xffffffff817be9ba <+74>:    mov    %rbp,%rdi
   0xffffffff817be9bd <+77>:    callq  0xffffffff817be8c0 <__lock_sock>
   0xffffffff817be9c2 <+82>:    jmp    0xffffffff817be993 <lock_sock_nested+35>
End of assembler dump.


Fixes: 63f70270ccd9 ("[PATCH] i386: PARAVIRT: add common patching machinery")
Fixes: 3010a0663fd9 ("x86/paravirt, objtool: Annotate indirect calls")
Reported-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Juergen Gross <jgross@suse.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/paravirt.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -88,10 +88,12 @@ unsigned paravirt_patch_call(void *insnb
 	struct branch *b = insnbuf;
 	unsigned long delta = (unsigned long)target - (addr+5);
 
-	if (tgt_clobbers & ~site_clobbers)
-		return len;	/* target would clobber too much for this site */
-	if (len < 5)
+	if (len < 5) {
+#ifdef CONFIG_RETPOLINE
+		WARN_ONCE("Failing to patch indirect CALL in %ps\n", (void *)addr);
+#endif
 		return len;	/* call too long for patch site */
+	}
 
 	b->opcode = 0xe8; /* call */
 	b->delta = delta;
@@ -106,8 +108,12 @@ unsigned paravirt_patch_jmp(void *insnbu
 	struct branch *b = insnbuf;
 	unsigned long delta = (unsigned long)target - (addr+5);
 
-	if (len < 5)
+	if (len < 5) {
+#ifdef CONFIG_RETPOLINE
+		WARN_ONCE("Failing to patch indirect JMP in %ps\n", (void *)addr);
+#endif
 		return len;	/* call too long for patch site */
+	}
 
 	b->opcode = 0xe9;	/* jmp */
 	b->delta = delta;


