Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A7E1C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B6972543A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:46:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B6972543A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032555AbeGAQqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:46:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38488 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753780AbeGAQqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:46:38 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4D31CACD;
        Sun,  1 Jul 2018 16:46:37 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, zhijianx.li@intel.com,
        Andy Lutomirski <luto@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.17 216/220] x86/entry/64/compat: Fix "x86/entry/64/compat: Preserve r8-r11 in int $0x80"
Date:   Sun,  1 Jul 2018 18:24:00 +0200
Message-Id: <20180701160917.167286801@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160908.272447118@linuxfoundation.org>
References: <20180701160908.272447118@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Lutomirski <luto@kernel.org>

commit 22cd978e598618e82c3c3348d2069184f6884182 upstream.

Commit:

  8bb2610bc496 ("x86/entry/64/compat: Preserve r8-r11 in int $0x80")

was busted: my original patch had a minor conflict with
some of the nospec changes, but "git apply" is very clever
and silently accepted the patch by making the same changes
to a different function in the same file.  There was obviously
a huge offset, but "git apply" for some reason doesn't feel
any need to say so.

Move the changes to the correct function.  Now the
test_syscall_vdso_32 selftests passes.

If anyone cares to observe the original problem, try applying the
patch at:

  https://lore.kernel.org/lkml/d4c4d9985fbe64f8c9e19291886453914b48caee.1523975710.git.luto@kernel.org/raw

to the kernel at 316d097c4cd4e7f2ef50c40cff2db266593c4ec4:

 - "git am" and "git apply" accept the patch without any complaints at all
 - "patch -p1" at least prints out a message about the huge offset.

Reported-by: zhijianx.li@intel.com
Signed-off-by: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org #v4.17+
Fixes: 8bb2610bc496 ("x86/entry/64/compat: Preserve r8-r11 in int $0x80")
Link: http://lkml.kernel.org/r/6012b922485401bc42676e804171ded262fc2ef2.1530078306.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/entry/entry_64_compat.S |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -84,13 +84,13 @@ ENTRY(entry_SYSENTER_compat)
 	pushq	%rdx			/* pt_regs->dx */
 	pushq	%rcx			/* pt_regs->cx */
 	pushq	$-ENOSYS		/* pt_regs->ax */
-	pushq   %r8			/* pt_regs->r8 */
+	pushq   $0			/* pt_regs->r8  = 0 */
 	xorl	%r8d, %r8d		/* nospec   r8 */
-	pushq   %r9			/* pt_regs->r9 */
+	pushq   $0			/* pt_regs->r9  = 0 */
 	xorl	%r9d, %r9d		/* nospec   r9 */
-	pushq   %r10			/* pt_regs->r10 */
+	pushq   $0			/* pt_regs->r10 = 0 */
 	xorl	%r10d, %r10d		/* nospec   r10 */
-	pushq   %r11			/* pt_regs->r11 */
+	pushq   $0			/* pt_regs->r11 = 0 */
 	xorl	%r11d, %r11d		/* nospec   r11 */
 	pushq   %rbx                    /* pt_regs->rbx */
 	xorl	%ebx, %ebx		/* nospec   rbx */
@@ -374,13 +374,13 @@ ENTRY(entry_INT80_compat)
 	pushq	%rcx			/* pt_regs->cx */
 	xorl	%ecx, %ecx		/* nospec   cx */
 	pushq	$-ENOSYS		/* pt_regs->ax */
-	pushq   $0			/* pt_regs->r8  = 0 */
+	pushq   %r8			/* pt_regs->r8 */
 	xorl	%r8d, %r8d		/* nospec   r8 */
-	pushq   $0			/* pt_regs->r9  = 0 */
+	pushq   %r9			/* pt_regs->r9 */
 	xorl	%r9d, %r9d		/* nospec   r9 */
-	pushq   $0			/* pt_regs->r10 = 0 */
+	pushq   %r10			/* pt_regs->r10*/
 	xorl	%r10d, %r10d		/* nospec   r10 */
-	pushq   $0			/* pt_regs->r11 = 0 */
+	pushq   %r11			/* pt_regs->r11 */
 	xorl	%r11d, %r11d		/* nospec   r11 */
 	pushq   %rbx                    /* pt_regs->rbx */
 	xorl	%ebx, %ebx		/* nospec   rbx */


