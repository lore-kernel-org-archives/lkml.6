Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93746C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 507B220871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="U9kRm3XU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 507B220871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388397AbeKLJ12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:27:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:42882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388184AbeKLIT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:19:57 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96DAE223D8;
        Sun, 11 Nov 2018 22:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975400;
        bh=xB4Z7kSPSx+B9BtkEGMk09T2QId0zJbXPLjp9d5yKDs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U9kRm3XUme/pi1+ASR/giKch93aECGJi+rAkbO8pj90xDB4FhEsXBde9Wt9BBLFoF
         hp319Ixkw+bSyJGRYpWQ+fjgSOO784MUIgxuVln3UwQES1NrO8QaI1gu9NcwDrRRqY
         YJM88j9BmPefSQCB0Qz2dK6Nw65S7RTm5JPo+1Eg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        Steve McIntyre <steve.mcintyre@arm.com>,
        Steve McIntyre <93sam@debian.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 097/350] signal: Introduce COMPAT_SIGMINSTKSZ for use in compat_sys_sigaltstack
Date:   Sun, 11 Nov 2018 14:19:21 -0800
Message-Id: <20181111221711.159296662@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>

[ Upstream commit 22839869f21ab3850fbbac9b425ccc4c0023926f ]

The sigaltstack(2) system call fails with -ENOMEM if the new alternative
signal stack is found to be smaller than SIGMINSTKSZ. On architectures
such as arm64, where the native value for SIGMINSTKSZ is larger than
the compat value, this can result in an unexpected error being reported
to a compat task. See, for example:

  https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=904385

This patch fixes the problem by extending do_sigaltstack to take the
minimum signal stack size as an additional parameter, allowing the
native and compat system call entry code to pass in their respective
values. COMPAT_SIGMINSTKSZ is just defined as SIGMINSTKSZ if it has not
been defined by the architecture.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Oleg Nesterov <oleg@redhat.com>
Reported-by: Steve McIntyre <steve.mcintyre@arm.com>
Tested-by: Steve McIntyre <93sam@debian.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/compat.h |    3 +++
 kernel/signal.c        |   14 +++++++++-----
 2 files changed, 12 insertions(+), 5 deletions(-)

--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -103,6 +103,9 @@ typedef struct compat_sigaltstack {
 	compat_size_t			ss_size;
 } compat_stack_t;
 #endif
+#ifndef COMPAT_MINSIGSTKSZ
+#define COMPAT_MINSIGSTKSZ	MINSIGSTKSZ
+#endif
 
 #define compat_jiffies_to_clock_t(x)	\
 		(((unsigned long)(x) * COMPAT_USER_HZ) / HZ)
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3417,7 +3417,8 @@ int do_sigaction(int sig, struct k_sigac
 }
 
 static int
-do_sigaltstack (const stack_t *ss, stack_t *oss, unsigned long sp)
+do_sigaltstack (const stack_t *ss, stack_t *oss, unsigned long sp,
+		size_t min_ss_size)
 {
 	struct task_struct *t = current;
 
@@ -3447,7 +3448,7 @@ do_sigaltstack (const stack_t *ss, stack
 			ss_size = 0;
 			ss_sp = NULL;
 		} else {
-			if (unlikely(ss_size < MINSIGSTKSZ))
+			if (unlikely(ss_size < min_ss_size))
 				return -ENOMEM;
 		}
 
@@ -3465,7 +3466,8 @@ SYSCALL_DEFINE2(sigaltstack,const stack_
 	if (uss && copy_from_user(&new, uss, sizeof(stack_t)))
 		return -EFAULT;
 	err = do_sigaltstack(uss ? &new : NULL, uoss ? &old : NULL,
-			      current_user_stack_pointer());
+			      current_user_stack_pointer(),
+			      MINSIGSTKSZ);
 	if (!err && uoss && copy_to_user(uoss, &old, sizeof(stack_t)))
 		err = -EFAULT;
 	return err;
@@ -3476,7 +3478,8 @@ int restore_altstack(const stack_t __use
 	stack_t new;
 	if (copy_from_user(&new, uss, sizeof(stack_t)))
 		return -EFAULT;
-	(void)do_sigaltstack(&new, NULL, current_user_stack_pointer());
+	(void)do_sigaltstack(&new, NULL, current_user_stack_pointer(),
+			     MINSIGSTKSZ);
 	/* squash all but EFAULT for now */
 	return 0;
 }
@@ -3510,7 +3513,8 @@ static int do_compat_sigaltstack(const c
 		uss.ss_size = uss32.ss_size;
 	}
 	ret = do_sigaltstack(uss_ptr ? &uss : NULL, &uoss,
-			     compat_user_stack_pointer());
+			     compat_user_stack_pointer(),
+			     COMPAT_MINSIGSTKSZ);
 	if (ret >= 0 && uoss_ptr)  {
 		compat_stack_t old;
 		memset(&old, 0, sizeof(old));


