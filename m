Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099B2C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C22DF2098A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZerEjKho"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C22DF2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730729AbeJKXKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:10:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:41516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726700AbeJKXKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:10:16 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F96C21470;
        Thu, 11 Oct 2018 15:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272552;
        bh=PSV9yQiptYN0SIAxtm17WU533KGUpCCvwpRWVtH8w/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZerEjKhoGhMo588pWStmKezP7jdRG6k4VUon9JFtA04IQBrZ50McjbY4VCE1+GeHO
         Ht7BD+Q6VJD1uuPyL/Dn0n7QQIrTrYTLvwyWXL3ZW8fkR1ZmztBeVqLb7tQhHFnI+2
         uFyi+YM1jjYujFQDYkX6WjeNFSxKngEtp6yj4M/o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.4 04/27] x86/vdso: Fix vDSO syscall fallback asm constraint regression
Date:   Thu, 11 Oct 2018 17:34:51 +0200
Message-Id: <20181011152534.225856328@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152534.014964888@linuxfoundation.org>
References: <20181011152534.014964888@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

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
Cc: stable@vger.kernel.org
Fixes: 715bd9d12f84 ("x86/vdso: Fix asm constraints on vDSO syscall fallbacks")
Link: http://lkml.kernel.org/r/21bd45ab04b6d838278fa5bebfa9163eceffa13c.1538608971.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/entry/vdso/vclock_gettime.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/arch/x86/entry/vdso/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vclock_gettime.c
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


