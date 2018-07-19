Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6062FECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FE2320673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:21:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FE2320673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731103AbeGTAGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 20:06:19 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35185 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730255AbeGTAGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 20:06:19 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6JNJt9b2450918
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Jul 2018 16:19:55 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6JNJtf62450915;
        Thu, 19 Jul 2018 16:19:55 -0700
Date:   Thu, 19 Jul 2018 16:19:55 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Joerg Roedel <tipbot@zytor.com>
Message-ID: <tip-a6b744f3ce9d017dd86b28355de2d8e0d36496d4@git.kernel.org>
Cc:     peterz@infradead.org, jroedel@suse.de, luto@kernel.org,
        aarcange@redhat.com, llong@redhat.com, pavel@ucw.cz,
        dave.hansen@intel.com, mingo@kernel.org, will.deacon@arm.com,
        eduval@amazon.com, dvlasenk@redhat.com,
        linux-kernel@vger.kernel.org, David.Laight@aculab.com,
        tglx@linutronix.de, dhgutteridge@sympatico.ca, brgerst@gmail.com,
        torvalds@linux-foundation.org, jpoimboe@redhat.com,
        jgross@suse.com, jkosina@suse.cz, hpa@zytor.com,
        gregkh@linuxfoundation.org, boris.ostrovsky@oracle.com,
        bp@alien8.de
Reply-To: llong@redhat.com, aarcange@redhat.com, pavel@ucw.cz,
          mingo@kernel.org, dave.hansen@intel.com, dvlasenk@redhat.com,
          will.deacon@arm.com, eduval@amazon.com, peterz@infradead.org,
          jroedel@suse.de, luto@kernel.org, jgross@suse.com,
          jkosina@suse.cz, torvalds@linux-foundation.org,
          jpoimboe@redhat.com, bp@alien8.de, gregkh@linuxfoundation.org,
          hpa@zytor.com, boris.ostrovsky@oracle.com, tglx@linutronix.de,
          dhgutteridge@sympatico.ca, David.Laight@aculab.com,
          linux-kernel@vger.kernel.org, brgerst@gmail.com
In-Reply-To: <1531906876-13451-4-git-send-email-joro@8bytes.org>
References: <1531906876-13451-4-git-send-email-joro@8bytes.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/entry/32: Load task stack from x86_tss.sp1 in
 SYSENTER handler
Git-Commit-ID: a6b744f3ce9d017dd86b28355de2d8e0d36496d4
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

Commit-ID:  a6b744f3ce9d017dd86b28355de2d8e0d36496d4
Gitweb:     https://git.kernel.org/tip/a6b744f3ce9d017dd86b28355de2d8e0d36496d4
Author:     Joerg Roedel <jroedel@suse.de>
AuthorDate: Wed, 18 Jul 2018 11:40:40 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 20 Jul 2018 01:11:36 +0200

x86/entry/32: Load task stack from x86_tss.sp1 in SYSENTER handler

x86_tss.sp0 will be used to point to the entry stack later to use it as a
trampoline stack for other kernel entry points besides SYSENTER.

So store the real task stack pointer in x86_tss.sp1, which is otherwise
unused by the hardware, as Linux doesn't make use of Ring 1.

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
Link: https://lkml.kernel.org/r/1531906876-13451-4-git-send-email-joro@8bytes.org

---
 arch/x86/kernel/asm-offsets_32.c | 9 +++++++--
 arch/x86/kernel/process_32.c     | 2 ++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/asm-offsets_32.c b/arch/x86/kernel/asm-offsets_32.c
index 15b3f45b69cd..82826f2275cc 100644
--- a/arch/x86/kernel/asm-offsets_32.c
+++ b/arch/x86/kernel/asm-offsets_32.c
@@ -46,9 +46,14 @@ void foo(void)
 	OFFSET(saved_context_gdt_desc, saved_context, gdt_desc);
 	BLANK();
 
-	/* Offset from the entry stack to task stack stored in TSS */
+	/*
+	 * Offset from the entry stack to task stack stored in TSS. Kernel entry
+	 * happens on the per-cpu entry-stack, and the asm code switches to the
+	 * task-stack pointer stored in x86_tss.sp1, which is a copy of
+	 * task->thread.sp0 where entry code can find it.
+	 */
 	DEFINE(TSS_entry2task_stack,
-	       offsetof(struct cpu_entry_area, tss.x86_tss.sp0) -
+	       offsetof(struct cpu_entry_area, tss.x86_tss.sp1) -
 	       offsetofend(struct cpu_entry_area, entry_stack_page.stack));
 
 #ifdef CONFIG_STACKPROTECTOR
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 0ae659de21eb..ec62cc77388d 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -290,6 +290,8 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	this_cpu_write(cpu_current_top_of_stack,
 		       (unsigned long)task_stack_page(next_p) +
 		       THREAD_SIZE);
+	/* SYSENTER reads the task-stack from tss.sp1 */
+	this_cpu_write(cpu_tss_rw.x86_tss.sp1, next_p->thread.sp0);
 
 	/*
 	 * Restore %gs if needed (which is common)
