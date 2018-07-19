Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C98ECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05FF92084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:20:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05FF92084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730926AbeGTAFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 20:05:46 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46403 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729919AbeGTAFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 20:05:46 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6JNJOtr2450892
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Jul 2018 16:19:24 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6JNJOOV2450889;
        Thu, 19 Jul 2018 16:19:24 -0700
Date:   Thu, 19 Jul 2018 16:19:24 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Joerg Roedel <tipbot@zytor.com>
Message-ID: <tip-ae2e565bc6aaee3f3db420fec5fdd39755c9813e@git.kernel.org>
Cc:     llong@redhat.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, aarcange@redhat.com,
        jpoimboe@redhat.com, dhgutteridge@sympatico.ca, eduval@amazon.com,
        pavel@ucw.cz, dvlasenk@redhat.com, mingo@kernel.org,
        David.Laight@aculab.com, brgerst@gmail.com,
        torvalds@linux-foundation.org, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, luto@kernel.org, dave.hansen@intel.com,
        jroedel@suse.de, jkosina@suse.cz, peterz@infradead.org,
        gregkh@linuxfoundation.org, jgross@suse.com,
        boris.ostrovsky@oracle.com
Reply-To: peterz@infradead.org, gregkh@linuxfoundation.org,
          boris.ostrovsky@oracle.com, jgross@suse.com, tglx@linutronix.de,
          bp@alien8.de, hpa@zytor.com, luto@kernel.org, jkosina@suse.cz,
          jroedel@suse.de, dave.hansen@intel.com,
          dhgutteridge@sympatico.ca, jpoimboe@redhat.com,
          dvlasenk@redhat.com, mingo@kernel.org, pavel@ucw.cz,
          eduval@amazon.com, torvalds@linux-foundation.org,
          David.Laight@aculab.com, brgerst@gmail.com, llong@redhat.com,
          will.deacon@arm.com, aarcange@redhat.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <1531906876-13451-3-git-send-email-joro@8bytes.org>
References: <1531906876-13451-3-git-send-email-joro@8bytes.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/entry/32: Rename TSS_sysenter_sp0 to
 TSS_entry2task_stack
Git-Commit-ID: ae2e565bc6aaee3f3db420fec5fdd39755c9813e
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

Commit-ID:  ae2e565bc6aaee3f3db420fec5fdd39755c9813e
Gitweb:     https://git.kernel.org/tip/ae2e565bc6aaee3f3db420fec5fdd39755c9813e
Author:     Joerg Roedel <jroedel@suse.de>
AuthorDate: Wed, 18 Jul 2018 11:40:39 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 20 Jul 2018 01:11:35 +0200

x86/entry/32: Rename TSS_sysenter_sp0 to TSS_entry2task_stack

The stack address doesn't need to be stored in tss.sp0 if the stack is
switched manually like on sysenter. Rename the offset so that it still
makes sense when its location is changed in later patches.

This stackk will also be used for all kernel-entry points, not just
sysenter. Reflect that and the fact that it is the offset to the task-stack
location in the name as well.

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
Link: https://lkml.kernel.org/r/1531906876-13451-3-git-send-email-joro@8bytes.org

---
 arch/x86/entry/entry_32.S        | 2 +-
 arch/x86/kernel/asm-offsets_32.c | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index c371bfee137a..39f711ad0fc9 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -412,7 +412,7 @@ ENTRY(xen_sysenter_target)
  * 0(%ebp) arg6
  */
 ENTRY(entry_SYSENTER_32)
-	movl	TSS_sysenter_sp0(%esp), %esp
+	movl	TSS_entry2task_stack(%esp), %esp
 .Lsysenter_past_esp:
 	pushl	$__USER_DS		/* pt_regs->ss */
 	pushl	%ebp			/* pt_regs->sp (stashed in bp) */
diff --git a/arch/x86/kernel/asm-offsets_32.c b/arch/x86/kernel/asm-offsets_32.c
index a4a3be399f4b..15b3f45b69cd 100644
--- a/arch/x86/kernel/asm-offsets_32.c
+++ b/arch/x86/kernel/asm-offsets_32.c
@@ -46,8 +46,9 @@ void foo(void)
 	OFFSET(saved_context_gdt_desc, saved_context, gdt_desc);
 	BLANK();
 
-	/* Offset from the sysenter stack to tss.sp0 */
-	DEFINE(TSS_sysenter_sp0, offsetof(struct cpu_entry_area, tss.x86_tss.sp0) -
+	/* Offset from the entry stack to task stack stored in TSS */
+	DEFINE(TSS_entry2task_stack,
+	       offsetof(struct cpu_entry_area, tss.x86_tss.sp0) -
 	       offsetofend(struct cpu_entry_area, entry_stack_page.stack));
 
 #ifdef CONFIG_STACKPROTECTOR
