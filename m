Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86266C4161D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DEA720851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:18:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DEA720851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbeKTSq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 13:46:29 -0500
Received: from terminus.zytor.com ([198.137.202.136]:37799 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbeKTSq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 13:46:29 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAK8HwSN2909067
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 20 Nov 2018 00:17:58 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAK8Hwvc2909064;
        Tue, 20 Nov 2018 00:17:58 -0800
Date:   Tue, 20 Nov 2018 00:17:58 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andy Lutomirski <tipbot@zytor.com>
Message-ID: <tip-1ad33f5aec20f53785dbad44c6fb3b204aefd921@git.kernel.org>
Cc:     mingo@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
        brgerst@gmail.com, bp@alien8.de, yu-cheng.yu@intel.com,
        riel@surriel.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        dvlasenk@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        luto@amacapital.net
Reply-To: bp@alien8.de, riel@surriel.com, yu-cheng.yu@intel.com,
          brgerst@gmail.com, luto@kernel.org, dave.hansen@linux.intel.com,
          mingo@kernel.org, luto@amacapital.net, hpa@zytor.com,
          tglx@linutronix.de, dvlasenk@redhat.com,
          torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
          peterz@infradead.org
In-Reply-To: <d418022aa0fad9cb40467aa7acaf4e95be50ee96.1542667307.git.luto@kernel.org>
References: <d418022aa0fad9cb40467aa7acaf4e95be50ee96.1542667307.git.luto@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/fault: Don't set thread.cr2, etc before OOPSing
Git-Commit-ID: 1ad33f5aec20f53785dbad44c6fb3b204aefd921
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

Commit-ID:  1ad33f5aec20f53785dbad44c6fb3b204aefd921
Gitweb:     https://git.kernel.org/tip/1ad33f5aec20f53785dbad44c6fb3b204aefd921
Author:     Andy Lutomirski <luto@kernel.org>
AuthorDate: Mon, 19 Nov 2018 14:45:32 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 20 Nov 2018 08:44:30 +0100

x86/fault: Don't set thread.cr2, etc before OOPSing

The fault handling code sets the cr2, trap_nr, and error_code fields
in thread_struct before OOPSing.  No one reads those fields during
an OOPS, so remove the code to set them.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>
Link: http://lkml.kernel.org/r/d418022aa0fad9cb40467aa7acaf4e95be50ee96.1542667307.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/fault.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index b5ec1ca2f4a0..b898a38093a3 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -621,10 +621,6 @@ pgtable_bad(struct pt_regs *regs, unsigned long error_code,
 	       tsk->comm, address);
 	dump_pagetable(address);
 
-	tsk->thread.cr2		= address;
-	tsk->thread.trap_nr	= X86_TRAP_PF;
-	tsk->thread.error_code	= error_code;
-
 	if (__die("Bad pagetable", regs, error_code))
 		sig = 0;
 
@@ -753,10 +749,6 @@ no_context(struct pt_regs *regs, unsigned long error_code,
 	if (task_stack_end_corrupted(tsk))
 		printk(KERN_EMERG "Thread overran stack, or stack corrupted\n");
 
-	tsk->thread.cr2		= address;
-	tsk->thread.trap_nr	= X86_TRAP_PF;
-	tsk->thread.error_code	= error_code;
-
 	sig = SIGKILL;
 	if (__die("Oops", regs, error_code))
 		sig = 0;
