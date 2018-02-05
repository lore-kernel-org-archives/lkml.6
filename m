Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3155980-1517855142-2-9581347854678058852
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517855141; b=O0HvRRZs4wxySTsVIaNq3P/eaJw5U3baN5As03YuUCrScOh
    LXWUNbC4e1jDKynvem/eQGxgiGwrNWliuYVutlqyrIJw+635Nq8DFTmKk5BPp6gb
    BNd9S1QPWbr1RkPA8taCyCvGVdTieNwcy1KbltfTGlCZ42wdLMa2QQXJl1BAQ17u
    ImZXRabGnSvtgBhQhyXuzgOeQud2Rn5GXdLfdl58rxf9sFJnbsZsnqVYuF6iRYMf
    r/vcNNeeV8lKQV9lNJJqRDp1CZen/7s255cdGWCnLrTML0vY9Ma64ygNF/E2Gva2
    9mHunjt82waKnboJr05yqtCGrfEBT5XqoyWb/Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517855141; bh=7FppFZJ0XjGzFzriq9QxexfeVV
    PzJIGqsVIHc60Ygvo=; b=unX/FevXS6WsOSnvV1rBcTbWyS8+NXOv3m3GvOgxXG
    VQG5KtF5IczC1ZX5rlmB/WP55kF9+xl5kSe+lXV5Iu3r2KLzwQElEfUtF7JN/eqH
    gWZA32imWDbyaSnBWaKlfc8BF8mNBIUy87rZ/PoHmVuHXHCtLH2cTrh8HjtYJW6m
    0Y47Fe97Q40vJ40sCcpji5v/js0efwKCZHMYyATNGUtH6yyu+sdl/5v2dO8rHaUb
    a4I+5GsWXHBx+czz0NxcfET90A/5XAH9j37DsdvbuZ7avqHgrzaDcd4QFPhi/nAP
    npLHBRro3EeA403YxkoLXV8A/hvEZ4vH1BM3FaLN8teQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753479AbeBESZi (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Feb 2018 13:25:38 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:52602 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753741AbeBESZW (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Feb 2018 13:25:22 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: [PATCH 4.15 30/60] x86/entry/64: Push extra regs right away
Date: Mon,  5 Feb 2018 10:23:03 -0800
Message-Id: <20180205182215.184295718@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182213.902626065@linuxfoundation.org>
References: <20180205182213.902626065@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Lutomirski luto@kernel.org

commit d1f7732009e0549eedf8ea1db948dc37be77fd46

With the fast path removed there is no point in splitting the push of the
normal and the extra register set. Just push the extra regs right away.

[ tglx: Split out from 'x86/entry/64: Remove the SYSCALL64 fast path' ]

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>
Link: https://lkml.kernel.org/r/462dff8d4d64dfbfc851fbf3130641809d980ecd.1517164461.git.luto@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 arch/x86/entry/entry_64.S |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -236,13 +236,17 @@ GLOBAL(entry_SYSCALL_64_after_hwframe)
 	pushq	%r9				/* pt_regs->r9 */
 	pushq	%r10				/* pt_regs->r10 */
 	pushq	%r11				/* pt_regs->r11 */
-	sub	$(6*8), %rsp			/* pt_regs->bp, bx, r12-15 not saved */
-	UNWIND_HINT_REGS extra=0
+	pushq	%rbx				/* pt_regs->rbx */
+	pushq	%rbp				/* pt_regs->rbp */
+	pushq	%r12				/* pt_regs->r12 */
+	pushq	%r13				/* pt_regs->r13 */
+	pushq	%r14				/* pt_regs->r14 */
+	pushq	%r15				/* pt_regs->r15 */
+	UNWIND_HINT_REGS
 
 	TRACE_IRQS_OFF
 
 	/* IRQs are off. */
-	SAVE_EXTRA_REGS
 	movq	%rsp, %rdi
 	call	do_syscall_64		/* returns with IRQs disabled */
 
