Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2ECEECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B83920673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:22:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B83920673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731282AbeGTAHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 20:07:51 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34099 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727743AbeGTAHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 20:07:51 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6JNLULn2451213
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Jul 2018 16:21:30 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6JNLUiN2451210;
        Thu, 19 Jul 2018 16:21:30 -0700
Date:   Thu, 19 Jul 2018 16:21:30 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Joerg Roedel <tipbot@zytor.com>
Message-ID: <tip-0d2eb73b29996684d5bbb72f85c74b47b4c359f7@git.kernel.org>
Cc:     dave.hansen@intel.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, eduval@amazon.com, bp@alien8.de,
        mingo@kernel.org, tglx@linutronix.de, dvlasenk@redhat.com,
        jpoimboe@redhat.com, torvalds@linux-foundation.org, hpa@zytor.com,
        will.deacon@arm.com, aarcange@redhat.com, llong@redhat.com,
        jgross@suse.com, David.Laight@aculab.com,
        dhgutteridge@sympatico.ca, jroedel@suse.de,
        gregkh@linuxfoundation.org, brgerst@gmail.com, jkosina@suse.cz,
        luto@kernel.org, pavel@ucw.cz, boris.ostrovsky@oracle.com
Reply-To: brgerst@gmail.com, jroedel@suse.de, gregkh@linuxfoundation.org,
          luto@kernel.org, pavel@ucw.cz, boris.ostrovsky@oracle.com,
          jkosina@suse.cz, llong@redhat.com, jgross@suse.com,
          dhgutteridge@sympatico.ca, David.Laight@aculab.com,
          dvlasenk@redhat.com, mingo@kernel.org, tglx@linutronix.de,
          will.deacon@arm.com, aarcange@redhat.com,
          torvalds@linux-foundation.org, hpa@zytor.com,
          jpoimboe@redhat.com, linux-kernel@vger.kernel.org,
          peterz@infradead.org, dave.hansen@intel.com, bp@alien8.de,
          eduval@amazon.com
In-Reply-To: <1531906876-13451-7-git-send-email-joro@8bytes.org>
References: <1531906876-13451-7-git-send-email-joro@8bytes.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/entry/32: Split off return-to-kernel path
Git-Commit-ID: 0d2eb73b29996684d5bbb72f85c74b47b4c359f7
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

Commit-ID:  0d2eb73b29996684d5bbb72f85c74b47b4c359f7
Gitweb:     https://git.kernel.org/tip/0d2eb73b29996684d5bbb72f85c74b47b4c359f7
Author:     Joerg Roedel <jroedel@suse.de>
AuthorDate: Wed, 18 Jul 2018 11:40:43 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 20 Jul 2018 01:11:37 +0200

x86/entry/32: Split off return-to-kernel path

Use a separate return path when returning to the kernel.

This allows to put the PTI cr3-switch and the switch to the entry-stack
into the return-to-user path without further checking.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Pavel Machek <pavel@ucw.cz>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: linux-mm@kvack.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: David Laight <David.Laight@aculab.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: Eduardo Valentin <eduval@amazon.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: aliguori@amazon.com
Cc: daniel.gruss@iaik.tugraz.at
Cc: hughd@google.com
Cc: keescook@google.com
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Waiman Long <llong@redhat.com>
Cc: "David H . Gutteridge" <dhgutteridge@sympatico.ca>
Cc: joro@8bytes.org
Link: https://lkml.kernel.org/r/1531906876-13451-7-git-send-email-joro@8bytes.org

---
 arch/x86/entry/entry_32.S | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 43641310b6e3..7251c4f3e99e 100644
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
