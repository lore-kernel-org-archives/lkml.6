Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4006443-1519424146-2-16197105125207101555
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519424145; b=WG4Tf6eq+2bjutnCCHthv6phZSEkM/64QG9CaARQkQb6II3
    5lXHwFBHJzH68f2SuGPUGSr8TMk5UjnjwWNU3GnRZICnwDC4Dl3jkJsE1A9Uxbpy
    EN7uYhxZDgkR4RPvPzqOe7S2COqqt4HeGW8HbBc6udVxQCfRkqLQsfswNIE6Acts
    s7rZs26IIaCHsZxMbKxqDp/seeyY2T6yEv8Md8R8ALePQBE0flX9PGdeZkZxnThm
    SfS6cmrcfckLds1uFNFkP/3rpS9V0IvIStRlX9+ZZf+lQYffdHcSuTvFMAl4/Pir
    fbkAvsnnneEL4mh5F8vIujgwbtzjou2mkRTUXFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519424145; bh=eRK+6nFfzqtaoQ1Pd0jsxQ+J54fYfbx/kc7KpODGy2E=; b=v
    1tH5OQxsc2V95iQSjGkZ6OypJYXf8riX4Ui4GxWPh4XcnenxDnBJ9TVOUoTowaK9
    WaokmV24UPuRaqZ7VsUVxmL4Y3I0boKIwNgAUpcWg+cYH4d25W90GwS57RF9YiLg
    Gf+NyGUwAVBDnvbf0R4PXqviTxlWU1NBA8C6Lp+oJBWTVyRUXXjdX5zGIX5e/TEQ
    znMfzSatVrLM3aq2Q3M3nR4DMFHEAGn/SCXihyh/1Ke5TJGd/OQUyAkCA1dXl8d8
    tpDX2xsmfDMhBXBgHQfAzhu04SeQmjEh/fdNzN9Ufyk1Wu+frJtplGgysDmJvnDx
    xprGajrTKbAS4ZJZ5OHtg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752339AbeBWWPa (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 17:15:30 -0500
Received: from mga02.intel.com ([134.134.136.20]:55156 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752031AbeBWWP1 (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 23 Feb 2018 17:15:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,383,1515484800";
   d="scan'208";a="22639940"
Subject: [4.9-stable PATCH 11/11] x86/entry/64: Clear extra registers beyond
 syscall arguments, to reduce speculation attack surface
From: Dan Williams <dan.j.williams@intel.com>
To: gregkh@linuxfoundation.org
Cc: Andi Kleen <ak@linux.intel.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Brian Gerst <brgerst@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>
Date: Fri, 23 Feb 2018 14:06:21 -0800
Message-ID: <151942358116.21775.14209781084277174517.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <151942352167.21775.16852023419062929165.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151942352167.21775.16852023419062929165.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.17.1-9-g687f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

commit 8e1eb3fa009aa7c0b944b3c8b26b07de0efb3200 upstream.

At entry userspace may have (maliciously) populated the extra registers
outside the syscall calling convention with arbitrary values that could
be useful in a speculative execution (Spectre style) attack.

Clear these registers to minimize the kernel's attack surface.

Note, this only clears the extra registers and not the unused
registers for syscalls less than 6 arguments, since those registers are
likely to be clobbered well before their values could be put to use
under speculation.

Note, Linus found that the XOR instructions can be executed with
minimized cost if interleaved with the PUSH instructions, and Ingo's
analysis found that R10 and R11 should be included in the register
clearing beyond the typical 'extra' syscall calling convention
registers.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Reported-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Cc: <stable@vger.kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/151787988577.7847.16733592218894189003.stgit@dwillia2-desk3.amr.corp.intel.com
[ Made small improvements to the changelog and the code comments. ]
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/entry/entry_64.S |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index db5009ce065a..8d7e4d48db0d 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -176,13 +176,26 @@ GLOBAL(entry_SYSCALL_64_after_swapgs)
 	pushq	%r8				/* pt_regs->r8 */
 	pushq	%r9				/* pt_regs->r9 */
 	pushq	%r10				/* pt_regs->r10 */
+	/*
+	 * Clear extra registers that a speculation attack might
+	 * otherwise want to exploit. Interleave XOR with PUSH
+	 * for better uop scheduling:
+	 */
+	xorq	%r10, %r10			/* nospec   r10 */
 	pushq	%r11				/* pt_regs->r11 */
+	xorq	%r11, %r11			/* nospec   r11 */
 	pushq	%rbx				/* pt_regs->rbx */
+	xorl	%ebx, %ebx			/* nospec   rbx */
 	pushq	%rbp				/* pt_regs->rbp */
+	xorl	%ebp, %ebp			/* nospec   rbp */
 	pushq	%r12				/* pt_regs->r12 */
+	xorq	%r12, %r12			/* nospec   r12 */
 	pushq	%r13				/* pt_regs->r13 */
+	xorq	%r13, %r13			/* nospec   r13 */
 	pushq	%r14				/* pt_regs->r14 */
+	xorq	%r14, %r14			/* nospec   r14 */
 	pushq	%r15				/* pt_regs->r15 */
+	xorq	%r15, %r15			/* nospec   r15 */
 
 	/* IRQs are off. */
 	movq	%rsp, %rdi
