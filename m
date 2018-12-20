Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2302EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3039217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298990;
	bh=UeQvl/Sk60kNA7HShlvUIMcoTodC29SWPXikt+pbdjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tkB4RvNscJ6FB2uhG3qYgFj7S8tLx88uDTM0Y5RoPdX+tuCQ7r4TXkizk3LEBO/Qe
	 wtmOA/NsU/GmmU3epOuP1gVJusMhcsVpPP0jwglw47rBXfXuETKzQH6yP99ixIcEbT
	 i6wTXEB4oJqmPTEVFaMWk2PAASvXHHV+Klt/sUdA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731423AbeLTJWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:22:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:47174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731409AbeLTJWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:22:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB83B20449;
        Thu, 20 Dec 2018 09:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297766;
        bh=UeQvl/Sk60kNA7HShlvUIMcoTodC29SWPXikt+pbdjo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mgD4YCu1jEPckN80J0knw3Ght+dIuuY9hiwBTznxX/abVcpOhkeN5Pzb3Za1t0wZg
         t9WT60C2uLBDN6IE/hspk2i22P53q+AfnjWCQ2KoB1P8gOELRJmsiw94X9LzVF//GG
         X3FGfJuN+CGdmmAYHGDXXCcfckygWwD1JL4ZeZZM=
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
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 4.9 01/61] signal: Introduce COMPAT_SIGMINSTKSZ for use in compat_sys_sigaltstack
Date:   Thu, 20 Dec 2018 10:18:01 +0100
Message-Id: <20181220085843.804223151@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085843.743900603@linuxfoundation.org>
References: <20181220085843.743900603@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>

commit 22839869f21ab3850fbbac9b425ccc4c0023926f upstream.

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
[signal: Fix up cherry-pick conflicts for 22839869f21a]
Signed-off-by: Steve McIntyre <93sam@debian.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/compat.h |    3 +++
 kernel/signal.c        |   17 ++++++++++-------
 2 files changed, 13 insertions(+), 7 deletions(-)

--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -67,6 +67,9 @@ typedef struct compat_sigaltstack {
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
@@ -3116,7 +3116,8 @@ int do_sigaction(int sig, struct k_sigac
 }
 
 static int
-do_sigaltstack (const stack_t __user *uss, stack_t __user *uoss, unsigned long sp)
+do_sigaltstack (const stack_t __user *uss, stack_t __user *uoss, unsigned long sp,
+		size_t min_ss_size)
 {
 	stack_t oss;
 	int error;
@@ -3155,9 +3156,8 @@ do_sigaltstack (const stack_t __user *us
 			ss_size = 0;
 			ss_sp = NULL;
 		} else {
-			error = -ENOMEM;
-			if (ss_size < MINSIGSTKSZ)
-				goto out;
+			if (unlikely(ss_size < min_ss_size))
+				return -ENOMEM;
 		}
 
 		current->sas_ss_sp = (unsigned long) ss_sp;
@@ -3180,12 +3180,14 @@ out:
 }
 SYSCALL_DEFINE2(sigaltstack,const stack_t __user *,uss, stack_t __user *,uoss)
 {
-	return do_sigaltstack(uss, uoss, current_user_stack_pointer());
+	return do_sigaltstack(uss, uoss, current_user_stack_pointer(),
+			      MINSIGSTKSZ);
 }
 
 int restore_altstack(const stack_t __user *uss)
 {
-	int err = do_sigaltstack(uss, NULL, current_user_stack_pointer());
+	int err = do_sigaltstack(uss, NULL, current_user_stack_pointer(),
+			      		MINSIGSTKSZ);
 	/* squash all but EFAULT for now */
 	return err == -EFAULT ? err : 0;
 }
@@ -3226,7 +3228,8 @@ COMPAT_SYSCALL_DEFINE2(sigaltstack,
 	set_fs(KERNEL_DS);
 	ret = do_sigaltstack((stack_t __force __user *) (uss_ptr ? &uss : NULL),
 			     (stack_t __force __user *) &uoss,
-			     compat_user_stack_pointer());
+			     compat_user_stack_pointer(),
+			     COMPAT_MINSIGSTKSZ);
 	set_fs(seg);
 	if (ret >= 0 && uoss_ptr)  {
 		if (!access_ok(VERIFY_WRITE, uoss_ptr, sizeof(compat_stack_t)) ||


