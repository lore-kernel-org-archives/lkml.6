Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A4FC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BA6720652
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:28:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BA6720652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbeJEP0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 11:26:01 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42203 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbeJEP0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 11:26:01 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w958RvEa3071662
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 5 Oct 2018 01:27:57 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w958Rvhj3071659;
        Fri, 5 Oct 2018 01:27:57 -0700
Date:   Fri, 5 Oct 2018 01:27:57 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andy Lutomirski <tipbot@zytor.com>
Message-ID: <tip-89fe0a1f1c694a3b0b3cfa8c0952d603753f36df@git.kernel.org>
Cc:     mingo@kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
        luto@kernel.org, peterz@infradead.org
Reply-To: peterz@infradead.org, luto@kernel.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org,
          torvalds@linux-foundation.org
In-Reply-To: <3a7438f5fb2422ed881683d2ccffd7f987b2dc44.1538689401.git.luto@kernel.org>
References: <3a7438f5fb2422ed881683d2ccffd7f987b2dc44.1538689401.git.luto@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/vdso] x86/vdso: Remove "memory" clobbers in the vDSO
 syscall fallbacks
Git-Commit-ID: 89fe0a1f1c694a3b0b3cfa8c0952d603753f36df
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

Commit-ID:  89fe0a1f1c694a3b0b3cfa8c0952d603753f36df
Gitweb:     https://git.kernel.org/tip/89fe0a1f1c694a3b0b3cfa8c0952d603753f36df
Author:     Andy Lutomirski <luto@kernel.org>
AuthorDate: Thu, 4 Oct 2018 14:44:43 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 5 Oct 2018 10:12:18 +0200

x86/vdso: Remove "memory" clobbers in the vDSO syscall fallbacks

When a vDSO clock function falls back to the syscall, no special
barriers or ordering is needed, and the syscall fallbacks don't
clobber any memory that is not explicitly listed in the asm
constraints.  Remove the "memory" clobber.

This causes minor changes to the generated code, but otherwise has
no obvious performance impact.  I think it's nice to have, though,
since it may help the optimizer in the future.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/3a7438f5fb2422ed881683d2ccffd7f987b2dc44.1538689401.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/entry/vdso/vclock_gettime.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/vdso/vclock_gettime.c b/arch/x86/entry/vdso/vclock_gettime.c
index b7ccbff26a3f..18c8a78d1ec9 100644
--- a/arch/x86/entry/vdso/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vclock_gettime.c
@@ -45,7 +45,7 @@ notrace static long vdso_fallback_gettime(long clock, struct timespec *ts)
 	long ret;
 	asm ("syscall" : "=a" (ret), "=m" (*ts) :
 	     "0" (__NR_clock_gettime), "D" (clock), "S" (ts) :
-	     "memory", "rcx", "r11");
+	     "rcx", "r11");
 	return ret;
 }
 
@@ -62,7 +62,7 @@ notrace static long vdso_fallback_gettime(long clock, struct timespec *ts)
 		"mov %%edx, %%ebx \n"
 		: "=a" (ret), "=m" (*ts)
 		: "0" (__NR_clock_gettime), [clock] "g" (clock), "c" (ts)
-		: "memory", "edx");
+		: "edx");
 	return ret;
 }
 
