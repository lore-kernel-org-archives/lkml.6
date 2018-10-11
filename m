Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484B8C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 000E2213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="a5bp9Lre"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 000E2213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731261AbeJKXM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:12:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:45252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729994AbeJKXMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:12:55 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8681121470;
        Thu, 11 Oct 2018 15:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272710;
        bh=im0MgOQJgNbGAVqm5McwCrLaoSojpYi3j6Yi3Xd80wE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a5bp9Lrexpu+T7xJ4H7EVyeLtGRS6HTMpXVbDQsYnKHxMapiCFb4aHlE9c/hh4hwh
         B+rzrUEeUxLVrL7JdjzvGj6YZrRjUay5Xcwvstnr+4qXcr+8TfRK1QMgfc6baO9Q6H
         azXLWPPo8HABSCl3U/PqhrslmTwVPRE0CiqUqvC4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.14 12/45] x86/vdso: Fix asm constraints on vDSO syscall fallbacks
Date:   Thu, 11 Oct 2018 17:39:39 +0200
Message-Id: <20181011152509.371371812@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152508.885515042@linuxfoundation.org>
References: <20181011152508.885515042@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Lutomirski <luto@kernel.org>

commit 715bd9d12f84d8f5cc8ad21d888f9bc304a8eb0b upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/entry/vdso/vclock_gettime.c |   18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

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
 
@@ -52,8 +53,9 @@ notrace static long vdso_fallback_gtod(s
 {
 	long ret;
 
-	asm("syscall" : "=a" (ret) :
-	    "0" (__NR_gettimeofday), "D" (tv), "S" (tz) : "memory");
+	asm ("syscall" : "=a" (ret), "=m" (*tv), "=m" (*tz) :
+	     "0" (__NR_gettimeofday), "D" (tv), "S" (tz) :
+	     "memory", "rcx", "r11");
 	return ret;
 }
 
@@ -64,12 +66,12 @@ notrace static long vdso_fallback_gettim
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
@@ -79,12 +81,12 @@ notrace static long vdso_fallback_gtod(s
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


