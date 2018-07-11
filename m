Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46CD4C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E44BD208FA
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="TyzSjYqU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E44BD208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732879AbeGKLeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 07:34:03 -0400
Received: from 8bytes.org ([81.169.241.247]:37618 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732847AbeGKLeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 07:34:02 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 25FA57B4; Wed, 11 Jul 2018 13:30:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1531308601; bh=oDMxF3o058bjpJa4HrDdMIfZpi53bUCauxD68r1Y9K4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TyzSjYqUxtz81dSIk8lAWsCYRvAaSzZ8BBCnXcvJ2ETfpak3XlRdLUzWIRjhl/4Gy
         SAQyhYHDsAcpxtEMDiut94nSwJvogRNwL2fbucrljHxQOo2cHMc29Un9qBDrxsRlD6
         wyX6Mqj0cO/J/FLIV4quWWGPOHPm9Db8gyt2gygwplS+4vXs40Sl+eWgnTu7S5iePF
         S5rfw3f/BwS69/Rd+Is56FHKD+LUZLYLFEKilefVFSle8RLgrKJPIrnzd+o9ciVvcx
         MyvQb9G5FOjp1+yih/NFPm8ID2fRsc9K7WDEAtiQvpAVMisldIMALOEq7wahV5YJcv
         p65fbIjTEnpvg==
From:   Joerg Roedel <joro@8bytes.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Brian Gerst <brgerst@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Eduardo Valentin <eduval@amazon.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>, aliguori@amazon.com,
        daniel.gruss@iaik.tugraz.at, hughd@google.com, keescook@google.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "David H . Gutteridge" <dhgutteridge@sympatico.ca>,
        jroedel@suse.de, joro@8bytes.org
Subject: [PATCH 06/39] x86/entry/32: Split off return-to-kernel path
Date:   Wed, 11 Jul 2018 13:29:13 +0200
Message-Id: <1531308586-29340-7-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531308586-29340-1-git-send-email-joro@8bytes.org>
References: <1531308586-29340-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Use a separate return path when we know we are returning to
the kernel. This allows us to put the PTI cr3-switch and the
switch to the entry-stack into the return-to-user path
without further checking.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/entry/entry_32.S | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 571209e..61303fa 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -65,7 +65,7 @@
 # define preempt_stop(clobbers)	DISABLE_INTERRUPTS(clobbers); TRACE_IRQS_OFF
 #else
 # define preempt_stop(clobbers)
-# define resume_kernel		restore_all
+# define resume_kernel		restore_all_kernel
 #endif
 
 .macro TRACE_IRQS_IRET
@@ -399,9 +399,9 @@ ENTRY(resume_kernel)
 	DISABLE_INTERRUPTS(CLBR_ANY)
 .Lneed_resched:
 	cmpl	$0, PER_CPU_VAR(__preempt_count)
-	jnz	restore_all
+	jnz	restore_all_kernel
 	testl	$X86_EFLAGS_IF, PT_EFLAGS(%esp)	# interrupts off (exception path) ?
-	jz	restore_all
+	jz	restore_all_kernel
 	call	preempt_schedule_irq
 	jmp	.Lneed_resched
 END(resume_kernel)
@@ -606,6 +606,11 @@ restore_all:
 	 */
 	INTERRUPT_RETURN
 
+restore_all_kernel:
+	TRACE_IRQS_IRET
+	RESTORE_REGS 4
+	jmp	.Lirq_return
+
 .section .fixup, "ax"
 ENTRY(iret_exc	)
 	pushl	$0				# no error code
-- 
2.7.4

