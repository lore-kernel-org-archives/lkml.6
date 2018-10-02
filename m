Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE429C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 06:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CCFD2089A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 06:30:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CCFD2089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbeJBNMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 09:12:34 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41527 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbeJBNMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 09:12:34 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w926UpEc1862921
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 1 Oct 2018 23:30:51 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w926Upjl1862918;
        Mon, 1 Oct 2018 23:30:51 -0700
Date:   Mon, 1 Oct 2018 23:30:51 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andy Lutomirski <tipbot@zytor.com>
Message-ID: <tip-715bd9d12f84d8f5cc8ad21d888f9bc304a8eb0b@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, hpa@zytor.com, luto@kernel.org,
        tglx@linutronix.de, mingo@kernel.org
Reply-To: mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com,
          linux-kernel@vger.kernel.org, luto@kernel.org
In-Reply-To: <2c0231690551989d2fafa60ed0e7b5cc8b403908.1538422295.git.luto@kernel.org>
References: <2c0231690551989d2fafa60ed0e7b5cc8b403908.1538422295.git.luto@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/vdso: Fix asm constraints on vDSO syscall
 fallbacks
Git-Commit-ID: 715bd9d12f84d8f5cc8ad21d888f9bc304a8eb0b
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

Commit-ID:  715bd9d12f84d8f5cc8ad21d888f9bc304a8eb0b
Gitweb:     https://git.kernel.org/tip/715bd9d12f84d8f5cc8ad21d888f9bc304a8eb0b
Author:     Andy Lutomirski <luto@kernel.org>
AuthorDate: Mon, 1 Oct 2018 12:52:15 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 2 Oct 2018 08:28:15 +0200

x86/vdso: Fix asm constraints on vDSO syscall fallbacks

The syscall fallbacks in the vDSO have incorrect asm constraints.
They are not marked as writing to their outputs -- instead, they are
marked as clobbering "memory", which is useless.  In particular, gcc
is smart enough to know that the timespec parameter hasn't escaped,
so a memory clobber doesn't clobber it.  And passing a pointer as an
asm *input* does not tell gcc that the pointed-to value is changed.

Add in the fact that the asm instructions weren't volatile, and gcc
was free to omit them entirely unless their sole output (the return
value) is used.  Which it is (phew!), but that stops happening with
some upcoming patches.

As a trivial example, the following code:

void test_fallback(struct timespec *ts)
{
	vdso_fallback_gettime(CLOCK_MONOTONIC, ts);
}

compiles to:

00000000000000c0 <test_fallback>:
  c0:   c3                      retq

To add insult to injury, the RCX and R11 clobbers on 64-bit
builds were missing.

The "memory" clobber is also unnecessary -- no ordering with respect to
other memory operations is needed, but that's going to be fixed in a
separate not-for-stable patch.

Fixes: 2aae950b21e4 ("x86_64: Add vDSO for x86-64 with gettimeofday/clock_gettime/getcpu")
Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/2c0231690551989d2fafa60ed0e7b5cc8b403908.1538422295.git.luto@kernel.org

---
 arch/x86/entry/vdso/vclock_gettime.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/x86/entry/vdso/vclock_gettime.c b/arch/x86/entry/vdso/vclock_gettime.c
index f19856d95c60..134e2d2e8add 100644
--- a/arch/x86/entry/vdso/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vclock_gettime.c
@@ -43,8 +43,9 @@ extern u8 hvclock_page
 notrace static long vdso_fallback_gettime(long clock, struct timespec *ts)
 {
 	long ret;
-	asm("syscall" : "=a" (ret) :
-	    "0" (__NR_clock_gettime), "D" (clock), "S" (ts) : "memory");
+	asm ("syscall" : "=a" (ret), "=m" (*ts) :
+	     "0" (__NR_clock_gettime), "D" (clock), "S" (ts) :
+	     "memory", "rcx", "r11");
 	return ret;
 }
 
@@ -52,8 +53,9 @@ notrace static long vdso_fallback_gtod(struct timeval *tv, struct timezone *tz)
 {
 	long ret;
 
-	asm("syscall" : "=a" (ret) :
-	    "0" (__NR_gettimeofday), "D" (tv), "S" (tz) : "memory");
+	asm ("syscall" : "=a" (ret), "=m" (*tv), "=m" (*tz) :
+	     "0" (__NR_gettimeofday), "D" (tv), "S" (tz) :
+	     "memory", "rcx", "r11");
 	return ret;
 }
 
@@ -64,12 +66,12 @@ notrace static long vdso_fallback_gettime(long clock, struct timespec *ts)
 {
 	long ret;
 
-	asm(
+	asm (
 		"mov %%ebx, %%edx \n"
 		"mov %2, %%ebx \n"
 		"call __kernel_vsyscall \n"
 		"mov %%edx, %%ebx \n"
-		: "=a" (ret)
+		: "=a" (ret), "=m" (*ts)
 		: "0" (__NR_clock_gettime), "g" (clock), "c" (ts)
 		: "memory", "edx");
 	return ret;
@@ -79,12 +81,12 @@ notrace static long vdso_fallback_gtod(struct timeval *tv, struct timezone *tz)
 {
 	long ret;
 
-	asm(
+	asm (
 		"mov %%ebx, %%edx \n"
 		"mov %2, %%ebx \n"
 		"call __kernel_vsyscall \n"
 		"mov %%edx, %%ebx \n"
-		: "=a" (ret)
+		: "=a" (ret), "=m" (*tv), "=m" (*tz)
 		: "0" (__NR_gettimeofday), "g" (tv), "c" (tz)
 		: "memory", "edx");
 	return ret;
