Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F0AC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C53126721
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:08:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C53126721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934003AbeF0JIY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 05:08:24 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47197 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932187AbeF0JIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 05:08:19 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5R972uJ2025668
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 27 Jun 2018 02:07:02 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5R972MS2025665;
        Wed, 27 Jun 2018 02:07:02 -0700
Date:   Wed, 27 Jun 2018 02:07:02 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andy Lutomirski <tipbot@zytor.com>
Message-ID: <tip-22cd978e598618e82c3c3348d2069184f6884182@git.kernel.org>
Cc:     tglx@linutronix.de, luto@kernel.org, torvalds@linux-foundation.org,
        jpoimboe@redhat.com, peterz@infradead.org, hpa@zytor.com,
        gregkh@linuxfoundation.org, dwmw2@infradead.org,
        dan.j.williams@intel.com, bp@alien8.de,
        dave.hansen@linux.intel.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, arjan@linux.intel.com
Reply-To: linux-kernel@vger.kernel.org, arjan@linux.intel.com,
          bp@alien8.de, mingo@kernel.org, dave.hansen@linux.intel.com,
          hpa@zytor.com, peterz@infradead.org, gregkh@linuxfoundation.org,
          dan.j.williams@intel.com, dwmw2@infradead.org, luto@kernel.org,
          tglx@linutronix.de, torvalds@linux-foundation.org,
          jpoimboe@redhat.com
In-Reply-To: <6012b922485401bc42676e804171ded262fc2ef2.1530078306.git.luto@kernel.org>
References: <6012b922485401bc42676e804171ded262fc2ef2.1530078306.git.luto@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/entry/64/compat: Fix "x86/entry/64/compat:
 Preserve r8-r11 in int $0x80"
Git-Commit-ID: 22cd978e598618e82c3c3348d2069184f6884182
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  22cd978e598618e82c3c3348d2069184f6884182
Gitweb:     https://git.kernel.org/tip/22cd978e598618e82c3c3348d2069184f6884182
Author:     Andy Lutomirski <luto@kernel.org>
AuthorDate: Tue, 26 Jun 2018 22:45:52 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 27 Jun 2018 09:35:40 +0200

x86/entry/64/compat: Fix "x86/entry/64/compat: Preserve r8-r11 in int $0x80"

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
---
 arch/x86/entry/entry_64_compat.S | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index 9de7f1e1dede..7d0df78db727 100644
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
