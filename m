Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01BFC43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 257F2208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:16:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 257F2208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbeKTSop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 13:44:45 -0500
Received: from terminus.zytor.com ([198.137.202.136]:56509 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbeKTSop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 13:44:45 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAK8GHGV2908894
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 20 Nov 2018 00:16:17 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAK8GH7t2908891;
        Tue, 20 Nov 2018 00:16:17 -0800
Date:   Tue, 20 Nov 2018 00:16:17 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andy Lutomirski <tipbot@zytor.com>
Message-ID: <tip-e50928d7213e72ee95507221a89ed07d2bb6517b@git.kernel.org>
Cc:     riel@surriel.com, brgerst@gmail.com, peterz@infradead.org,
        hpa@zytor.com, bp@alien8.de, yu-cheng.yu@intel.com,
        linux-kernel@vger.kernel.org, luto@amacapital.net,
        dave.hansen@linux.intel.com, dvlasenk@redhat.com,
        torvalds@linux-foundation.org, luto@kernel.org, tglx@linutronix.de,
        mingo@kernel.org
Reply-To: riel@surriel.com, hpa@zytor.com, peterz@infradead.org,
          brgerst@gmail.com, bp@alien8.de, yu-cheng.yu@intel.com,
          dvlasenk@redhat.com, dave.hansen@linux.intel.com,
          linux-kernel@vger.kernel.org, luto@amacapital.net,
          tglx@linutronix.de, mingo@kernel.org, luto@kernel.org,
          torvalds@linux-foundation.org
In-Reply-To: <d1d1b2e66ef31f884dba172084486ea9423ddcdb.1542667307.git.luto@kernel.org>
References: <d1d1b2e66ef31f884dba172084486ea9423ddcdb.1542667307.git.luto@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/fault: Fix SMAP #PF handling buglet for implicit
 supervisor accesses
Git-Commit-ID: e50928d7213e72ee95507221a89ed07d2bb6517b
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

Commit-ID:  e50928d7213e72ee95507221a89ed07d2bb6517b
Gitweb:     https://git.kernel.org/tip/e50928d7213e72ee95507221a89ed07d2bb6517b
Author:     Andy Lutomirski <luto@kernel.org>
AuthorDate: Mon, 19 Nov 2018 14:45:29 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 20 Nov 2018 08:44:29 +0100

x86/fault: Fix SMAP #PF handling buglet for implicit supervisor accesses

Currently, if a user program somehow triggers an implicit supervisor
access to a user address (e.g. if the kernel somehow sets LDTR to a
user address), it will be incorrectly detected as a SMAP violation
if AC is clear and SMAP is enabled.  This is incorrect -- the error
has nothing to do with SMAP.  Fix the condition so that only
accesses with the hardware USER bit set are diagnosed as SMAP
violations.

With the logic fixed, an implicit supervisor access to a user address
will hit the code lower in the function that is intended to handle it
even if SMAP is enabled.  That logic is still a bit buggy, and later
patches will clean it up.

I *think* this code is still correct for WRUSS, and I've added a
comment to that effect.

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
Link: http://lkml.kernel.org/r/d1d1b2e66ef31f884dba172084486ea9423ddcdb.1542667307.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/fault.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 9d092ab74f18..7a69b66cf071 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1235,12 +1235,15 @@ void do_user_addr_fault(struct pt_regs *regs,
 		pgtable_bad(regs, hw_error_code, address);
 
 	/*
-	 * If SMAP is on, check for invalid kernel (supervisor)
-	 * access to user pages in the user address space.
+	 * If SMAP is on, check for invalid kernel (supervisor) access to user
+	 * pages in the user address space.  The odd case here is WRUSS,
+	 * which, according to the preliminary documentation, does not respect
+	 * SMAP and will have the USER bit set so, in all cases, SMAP
+	 * enforcement appears to be consistent with the USER bit.
 	 */
 	if (unlikely(cpu_feature_enabled(X86_FEATURE_SMAP) &&
 		     !(hw_error_code & X86_PF_USER) &&
-		     (user_mode(regs) || !(regs->flags & X86_EFLAGS_AC))))
+		     !(regs->flags & X86_EFLAGS_AC)))
 	{
 		bad_area_nosemaphore(regs, hw_error_code, address);
 		return;
