Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B225C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 19:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C576A21471
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 19:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1Gy1/9q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C576A21471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbeJBCbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 22:31:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:46270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbeJBCbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 22:31:41 -0400
Received: from localhost (c-71-202-137-17.hsd1.ca.comcast.net [71.202.137.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AC7521471;
        Mon,  1 Oct 2018 19:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538423538;
        bh=XW7kT2VwQtCb8K+OqCs6jygiKYYs388jeRWGzimH8Xg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=i1Gy1/9qRwj9FfVMuA1kEJTZQPtlOYHAZwWChJz6npLZxuY89KKXH0cKnJarfjQH8
         wHO1pAMtHAc0sLDO/X3rHX5pR61haw67rNx5pK/HM4WvCUXcX78gOqaEVT6LwMQY0R
         bIPHiX7K9zBDmXPofhZ+YfVyF0n1r7BiDSzYtgHg=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>, stable@vger.kernel.org
Subject: [PATCH 1/2] x86/vdso: Fix asm constraints on vDSO syscall fallbacks
Date:   Mon,  1 Oct 2018 12:52:15 -0700
Message-Id: <2c0231690551989d2fafa60ed0e7b5cc8b403908.1538422295.git.luto@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1538422295.git.luto@kernel.org>
References: <cover.1538422295.git.luto@kernel.org>
In-Reply-To: <cover.1538422295.git.luto@kernel.org>
References: <cover.1538422295.git.luto@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

The "memory" clobber is also unnecessary -- no ordering with respect
to other memory operations is needed, but I'll fix that in a
separate not-for-stable patch.

Cc: stable@vger.kernel.org
Fixes: 2aae950b21e4 ("x86_64: Add vDSO for x86-64 with gettimeofday/clock_gettime/getcpu")
Signed-off-by: Andy Lutomirski <luto@kernel.org>
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
-- 
2.17.1

