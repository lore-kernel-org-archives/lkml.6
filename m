Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF86ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57E262064C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xek6CXhM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57E262064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbeKAIGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:06:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:53400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728043AbeKAIGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:06:30 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E7D820830;
        Wed, 31 Oct 2018 23:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027180;
        bh=d3jqBbn/9Poqv+I1jgwvudd2LkeSuMY+WqtBmXR3PZo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xek6CXhMUK8Oq2vs+bkrspkfKWceaDsE818ldUN7IAo8RB20nmODw6ivbJQPDgjfz
         24vT0XjMjYwlAtDoJ4nmzB/UD6E5RFCy0q5V59U20stQ36B9ifQF7rHfEEj948OQb4
         3WZCHRscBCOK0F4TIECMd6/MMhN8GmjiYD/sLQVE=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 042/146] signal: Introduce COMPAT_SIGMINSTKSZ for use in compat_sys_sigaltstack
Date:   Wed, 31 Oct 2018 19:03:57 -0400
Message-Id: <20181031230541.28822-42-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230541.28822-1-sashal@kernel.org>
References: <20181031230541.28822-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 include/linux/compat.h |  3 +++
 kernel/signal.c        | 14 +++++++++-----
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/include/linux/compat.h b/include/linux/compat.h
index 1a3c4f37e908..de0c13bdcd2c 100644
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
diff --git a/kernel/signal.c b/kernel/signal.c
index 5843c541fda9..e4aad0e90882 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3460,7 +3460,8 @@ int do_sigaction(int sig, struct k_sigaction *act, struct k_sigaction *oact)
 }
 
 static int
-do_sigaltstack (const stack_t *ss, stack_t *oss, unsigned long sp)
+do_sigaltstack (const stack_t *ss, stack_t *oss, unsigned long sp,
+		size_t min_ss_size)
 {
 	struct task_struct *t = current;
 
@@ -3490,7 +3491,7 @@ do_sigaltstack (const stack_t *ss, stack_t *oss, unsigned long sp)
 			ss_size = 0;
 			ss_sp = NULL;
 		} else {
-			if (unlikely(ss_size < MINSIGSTKSZ))
+			if (unlikely(ss_size < min_ss_size))
 				return -ENOMEM;
 		}
 
@@ -3508,7 +3509,8 @@ SYSCALL_DEFINE2(sigaltstack,const stack_t __user *,uss, stack_t __user *,uoss)
 	if (uss && copy_from_user(&new, uss, sizeof(stack_t)))
 		return -EFAULT;
 	err = do_sigaltstack(uss ? &new : NULL, uoss ? &old : NULL,
-			      current_user_stack_pointer());
+			      current_user_stack_pointer(),
+			      MINSIGSTKSZ);
 	if (!err && uoss && copy_to_user(uoss, &old, sizeof(stack_t)))
 		err = -EFAULT;
 	return err;
@@ -3519,7 +3521,8 @@ int restore_altstack(const stack_t __user *uss)
 	stack_t new;
 	if (copy_from_user(&new, uss, sizeof(stack_t)))
 		return -EFAULT;
-	(void)do_sigaltstack(&new, NULL, current_user_stack_pointer());
+	(void)do_sigaltstack(&new, NULL, current_user_stack_pointer(),
+			     MINSIGSTKSZ);
 	/* squash all but EFAULT for now */
 	return 0;
 }
@@ -3553,7 +3556,8 @@ static int do_compat_sigaltstack(const compat_stack_t __user *uss_ptr,
 		uss.ss_size = uss32.ss_size;
 	}
 	ret = do_sigaltstack(uss_ptr ? &uss : NULL, &uoss,
-			     compat_user_stack_pointer());
+			     compat_user_stack_pointer(),
+			     COMPAT_MINSIGSTKSZ);
 	if (ret >= 0 && uoss_ptr)  {
 		compat_stack_t old;
 		memset(&old, 0, sizeof(old));
-- 
2.17.1

