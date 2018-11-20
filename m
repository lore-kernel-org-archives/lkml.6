Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F351C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A716D20831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:17:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A716D20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbeKTSpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 13:45:22 -0500
Received: from terminus.zytor.com ([198.137.202.136]:48137 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbeKTSpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 13:45:21 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAK8Gpmv2908947
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 20 Nov 2018 00:16:51 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAK8Gpio2908944;
        Tue, 20 Nov 2018 00:16:51 -0800
Date:   Tue, 20 Nov 2018 00:16:51 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andy Lutomirski <tipbot@zytor.com>
Message-ID: <tip-6ea59b074f15e7ef4b042a108950861b383e7b02@git.kernel.org>
Cc:     yu-cheng.yu@intel.com, dave.hansen@linux.intel.com,
        brgerst@gmail.com, torvalds@linux-foundation.org, mingo@kernel.org,
        peterz@infradead.org, bp@alien8.de, tglx@linutronix.de,
        luto@amacapital.net, dvlasenk@redhat.com, luto@kernel.org,
        riel@surriel.com, linux-kernel@vger.kernel.org, hpa@zytor.com
Reply-To: peterz@infradead.org, mingo@kernel.org, brgerst@gmail.com,
          torvalds@linux-foundation.org, yu-cheng.yu@intel.com,
          dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org,
          hpa@zytor.com, riel@surriel.com, luto@kernel.org,
          tglx@linutronix.de, dvlasenk@redhat.com, luto@amacapital.net,
          bp@alien8.de
In-Reply-To: <10e509c43893170e262e82027ea399130ae81159.1542667307.git.luto@kernel.org>
References: <10e509c43893170e262e82027ea399130ae81159.1542667307.git.luto@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/fault: Improve the condition for signalling vs
 OOPSing
Git-Commit-ID: 6ea59b074f15e7ef4b042a108950861b383e7b02
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

Commit-ID:  6ea59b074f15e7ef4b042a108950861b383e7b02
Gitweb:     https://git.kernel.org/tip/6ea59b074f15e7ef4b042a108950861b383e7b02
Author:     Andy Lutomirski <luto@kernel.org>
AuthorDate: Mon, 19 Nov 2018 14:45:30 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 20 Nov 2018 08:44:29 +0100

x86/fault: Improve the condition for signalling vs OOPSing

__bad_area_nosemaphore() currently checks the X86_PF_USER bit in the
error code to decide whether to send a signal or to treat the fault
as a kernel error.  This can cause somewhat erratic behavior.  The
straightforward cases where the CPL agrees with the hardware USER
bit are all correct, but the other cases are confusing.

 - A user instruction accessing a kernel address with supervisor
   privilege (e.g. a descriptor table access failed).  The USER bit
   will be clear, and we OOPS.  This is correct, because it indicates
   a kernel bug, not a user error.

 - A user instruction accessing a user address with supervisor
   privilege (e.g. a descriptor table was incorrectly pointing at
   user memory).  __bad_area_nosemaphore() will be passed a modified
   error code with the user bit set, and we will send a signal.
   Sending the signal will work (because the regs and the entry
   frame genuinely come from user mode), but we really ought to
   OOPS, as this event indicates a severe kernel bug.

 - A kernel instruction with user privilege (i.e. WRUSS).  This
   should OOPS or get fixed up.  The current code would instead try
   send a signal and malfunction.

Change the logic: a signal should be sent if the faulting context is
user mode *and* the access has user privilege.  Otherwise it's
either a kernel mode fault or a failed implicit access, either of
which should end up in no_context().

Note to -stable maintainers: don't backport this unless you backport
CET.  The bug it fixes is unobservable in current kernels unless
something is extremely wrong.

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
Link: http://lkml.kernel.org/r/10e509c43893170e262e82027ea399130ae81159.1542667307.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/fault.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 7a69b66cf071..3c9aed03d18e 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -794,7 +794,7 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
 	struct task_struct *tsk = current;
 
 	/* User mode accesses just cause a SIGSEGV */
-	if (error_code & X86_PF_USER) {
+	if (user_mode(regs) && (error_code & X86_PF_USER)) {
 		/*
 		 * It's possible to have interrupts off here:
 		 */
