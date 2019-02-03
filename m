Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932F9C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BA9120815
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729706AbfBCODA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:03:00 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:54794 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728051AbfBCOC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:02:57 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIEO-0003th-Lb; Sun, 03 Feb 2019 13:54:44 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIEL-0000BQ-AM; Sun, 03 Feb 2019 14:54:41 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Matthew Whitehead" <tedheadster@gmail.com>,
        "Ingo Molnar" <mingo@kernel.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.534561743@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 305/305] x86/vdso: Fix vDSO syscall fallback asm
 constraint regression
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Lutomirski <luto@kernel.org>

commit 02e425668f5c9deb42787d10001a3b605993ad15 upstream.

When I added the missing memory outputs, I failed to update the
index of the first argument (ebx) on 32-bit builds, which broke the
fallbacks.  Somehow I must have screwed up my testing or gotten
lucky.

Add another test to cover gettimeofday() as well.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: 715bd9d12f84 ("x86/vdso: Fix asm constraints on vDSO syscall fallbacks")
Link: http://lkml.kernel.org/r/21bd45ab04b6d838278fa5bebfa9163eceffa13c.1538608971.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
[bwh: Backported to 3.16:
 - Drop selftest changes
 - Adjust filename]
Tested-by: Matthew Whitehead <tedheadster@gmail.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/vdso/vclock_gettime.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/arch/x86/vdso/vclock_gettime.c
+++ b/arch/x86/vdso/vclock_gettime.c
@@ -147,11 +147,11 @@ notrace static long vdso_fallback_gettim
 
 	asm (
 		"mov %%ebx, %%edx \n"
-		"mov %2, %%ebx \n"
+		"mov %[clock], %%ebx \n"
 		"call __kernel_vsyscall \n"
 		"mov %%edx, %%ebx \n"
 		: "=a" (ret), "=m" (*ts)
-		: "0" (__NR_clock_gettime), "g" (clock), "c" (ts)
+		: "0" (__NR_clock_gettime), [clock] "g" (clock), "c" (ts)
 		: "memory", "edx");
 	return ret;
 }
@@ -162,11 +162,11 @@ notrace static long vdso_fallback_gtod(s
 
 	asm (
 		"mov %%ebx, %%edx \n"
-		"mov %2, %%ebx \n"
+		"mov %[tv], %%ebx \n"
 		"call __kernel_vsyscall \n"
 		"mov %%edx, %%ebx \n"
 		: "=a" (ret), "=m" (*tv), "=m" (*tz)
-		: "0" (__NR_gettimeofday), "g" (tv), "c" (tz)
+		: "0" (__NR_gettimeofday), [tv] "g" (tv), "c" (tz)
 		: "memory", "edx");
 	return ret;
 }

