Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B6DC04EBC
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 675F02147A
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:16:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 675F02147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbeKTSoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 13:44:15 -0500
Received: from terminus.zytor.com ([198.137.202.136]:48661 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbeKTSoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 13:44:15 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAK8FhJ02908810
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 20 Nov 2018 00:15:43 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAK8Fg6L2908807;
        Tue, 20 Nov 2018 00:15:42 -0800
Date:   Tue, 20 Nov 2018 00:15:42 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andy Lutomirski <tipbot@zytor.com>
Message-ID: <tip-a15781b536293edc32bf374233f3b8ad77c3f72b@git.kernel.org>
Cc:     tglx@linutronix.de, luto@amacapital.net, bp@alien8.de,
        torvalds@linux-foundation.org, dvlasenk@redhat.com,
        riel@surriel.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        brgerst@gmail.com, luto@kernel.org, peterz@infradead.org,
        dave.hansen@linux.intel.com, hpa@zytor.com, yu-cheng.yu@intel.com
Reply-To: yu-cheng.yu@intel.com, hpa@zytor.com, peterz@infradead.org,
          dave.hansen@linux.intel.com, luto@kernel.org, mingo@kernel.org,
          brgerst@gmail.com, linux-kernel@vger.kernel.org,
          riel@surriel.com, dvlasenk@redhat.com,
          torvalds@linux-foundation.org, bp@alien8.de, luto@amacapital.net,
          tglx@linutronix.de
In-Reply-To: <806c366f6ca861152398ce2c01744d59d9aceb6d.1542667307.git.luto@kernel.org>
References: <806c366f6ca861152398ce2c01744d59d9aceb6d.1542667307.git.luto@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/fault: Fold smap_violation() into
 do_user_addr_fault()
Git-Commit-ID: a15781b536293edc32bf374233f3b8ad77c3f72b
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

Commit-ID:  a15781b536293edc32bf374233f3b8ad77c3f72b
Gitweb:     https://git.kernel.org/tip/a15781b536293edc32bf374233f3b8ad77c3f72b
Author:     Andy Lutomirski <luto@kernel.org>
AuthorDate: Mon, 19 Nov 2018 14:45:28 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 20 Nov 2018 08:44:28 +0100

x86/fault: Fold smap_violation() into do_user_addr_fault()

smap_violation() has a single caller, and the contents are a bit
nonsensical.  I'm going to fix it, but first let's fold it into its
caller for ease of comprehension.

In this particular case, the user_mode(regs) check is incorrect --
it will cause false positives in the case of a user-initiated
kernel-privileged access.

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
Link: http://lkml.kernel.org/r/806c366f6ca861152398ce2c01744d59d9aceb6d.1542667307.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/fault.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 39e39cd42097..9d092ab74f18 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1148,20 +1148,6 @@ static int fault_in_kernel_space(unsigned long address)
 	return address >= TASK_SIZE_MAX;
 }
 
-static inline bool smap_violation(int error_code, struct pt_regs *regs)
-{
-	if (!cpu_feature_enabled(X86_FEATURE_SMAP))
-		return false;
-
-	if (error_code & X86_PF_USER)
-		return false;
-
-	if (!user_mode(regs) && (regs->flags & X86_EFLAGS_AC))
-		return false;
-
-	return true;
-}
-
 /*
  * Called for all faults where 'address' is part of the kernel address
  * space.  Might get called for faults that originate from *code* that
@@ -1249,10 +1235,13 @@ void do_user_addr_fault(struct pt_regs *regs,
 		pgtable_bad(regs, hw_error_code, address);
 
 	/*
-	 * Check for invalid kernel (supervisor) access to user
-	 * pages in the user address space.
+	 * If SMAP is on, check for invalid kernel (supervisor)
+	 * access to user pages in the user address space.
 	 */
-	if (unlikely(smap_violation(hw_error_code, regs))) {
+	if (unlikely(cpu_feature_enabled(X86_FEATURE_SMAP) &&
+		     !(hw_error_code & X86_PF_USER) &&
+		     (user_mode(regs) || !(regs->flags & X86_EFLAGS_AC))))
+	{
 		bad_area_nosemaphore(regs, hw_error_code, address);
 		return;
 	}
