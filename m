Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47781C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A09AE208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:15:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A09AE208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbeKTSng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 13:43:36 -0500
Received: from terminus.zytor.com ([198.137.202.136]:44931 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbeKTSnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 13:43:35 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAK8EMO22908516
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 20 Nov 2018 00:14:22 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAK8EId52908510;
        Tue, 20 Nov 2018 00:14:18 -0800
Date:   Tue, 20 Nov 2018 00:14:18 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andy Lutomirski <tipbot@zytor.com>
Message-ID: <tip-6344be608c039f3a787f1144c46fcb04c0f76561@git.kernel.org>
Cc:     luto@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de,
        hpa@zytor.com, bp@alien8.de, luto@amacapital.net,
        yu-cheng.yu@intel.com, dvlasenk@redhat.com,
        torvalds@linux-foundation.org, dave.hansen@linux.intel.com,
        riel@surriel.com, brgerst@gmail.com
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org,
          tglx@linutronix.de, bp@alien8.de, luto@kernel.org,
          peterz@infradead.org, torvalds@linux-foundation.org,
          dave.hansen@linux.intel.com, dvlasenk@redhat.com,
          yu-cheng.yu@intel.com, luto@amacapital.net, brgerst@gmail.com,
          riel@surriel.com
In-Reply-To: <4b89b542e8ceba9bd6abde2f386afed6d99244a9.1542667307.git.luto@kernel.org>
References: <4b89b542e8ceba9bd6abde2f386afed6d99244a9.1542667307.git.luto@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/fault: Check user_mode(regs) when avoiding an
 mmap_sem deadlock
Git-Commit-ID: 6344be608c039f3a787f1144c46fcb04c0f76561
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

Commit-ID:  6344be608c039f3a787f1144c46fcb04c0f76561
Gitweb:     https://git.kernel.org/tip/6344be608c039f3a787f1144c46fcb04c0f76561
Author:     Andy Lutomirski <luto@kernel.org>
AuthorDate: Mon, 19 Nov 2018 14:45:25 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 20 Nov 2018 08:44:27 +0100

x86/fault: Check user_mode(regs) when avoiding an mmap_sem deadlock

The fault-handling code that takes mmap_sem needs to avoid a
deadlock that could occur if the kernel took a bad (OOPS-worthy)
page fault on a user address while holding mmap_sem.  This can only
happen if the faulting instruction was in the kernel
(i.e. user_mode(regs)).  Rather than checking the sw_error_code
(which will have the USER bit set if the fault was a USER-permission
access *or* if user_mode(regs)), just check user_mode(regs)
directly.

The old code would have malfunctioned if the kernel executed a bogus
WRUSS instruction while holding mmap_sem.  Fortunately, that is
extremely unlikely in current kernels, which don't use WRUSS.

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
Link: http://lkml.kernel.org/r/4b89b542e8ceba9bd6abde2f386afed6d99244a9.1542667307.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/fault.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 29525cf21100..8624cb7d8d65 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1344,13 +1344,10 @@ void do_user_addr_fault(struct pt_regs *regs,
 	 * Only do the expensive exception table search when we might be at
 	 * risk of a deadlock.  This happens if we
 	 * 1. Failed to acquire mmap_sem, and
-	 * 2. The access did not originate in userspace.  Note: either the
-	 *    hardware or earlier page fault code may set X86_PF_USER
-	 *    in sw_error_code.
+	 * 2. The access did not originate in userspace.
 	 */
 	if (unlikely(!down_read_trylock(&mm->mmap_sem))) {
-		if (!(sw_error_code & X86_PF_USER) &&
-		    !search_exception_tables(regs->ip)) {
+		if (!user_mode(regs) && !search_exception_tables(regs->ip)) {
 			/*
 			 * Fault from code in kernel from
 			 * which we do not expect faults.
