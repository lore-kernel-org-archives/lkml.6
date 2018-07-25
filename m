Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061B2C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 13:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B106520852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 13:45:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B106520852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbeGYO5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 10:57:02 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39038 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729318AbeGYO5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 10:57:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 906EA15B2;
        Wed, 25 Jul 2018 06:45:17 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 628EB3F7C7;
        Wed, 25 Jul 2018 06:45:17 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 52A201AE0784; Wed, 25 Jul 2018 14:45:17 +0100 (BST)
From:   Will Deacon <will.deacon@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
        linux@dominikbrodowski.net, ebiederm@xmission.com,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        oleg@redhat.com, steve.mcintyre@arm.com, dave.martin@arm.com,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 1/2] signal: Introduce COMPAT_SIGMINSTKSZ for use in compat_sys_sigaltstack
Date:   Wed, 25 Jul 2018 14:45:11 +0100
Message-Id: <1532526312-26993-2-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1532526312-26993-1-git-send-email-will.deacon@arm.com>
References: <1532526312-26993-1-git-send-email-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 include/linux/compat.h |  3 +++
 kernel/signal.c        | 14 +++++++++-----
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/include/linux/compat.h b/include/linux/compat.h
index c68acc47da57..47041c7fed28 100644
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
index 8d8a940422a8..41a5dd2df27d 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3417,7 +3417,8 @@ int do_sigaction(int sig, struct k_sigaction *act, struct k_sigaction *oact)
 }
 
 static int
-do_sigaltstack (const stack_t *ss, stack_t *oss, unsigned long sp)
+do_sigaltstack (const stack_t *ss, stack_t *oss, unsigned long sp,
+		size_t min_ss_size)
 {
 	struct task_struct *t = current;
 
@@ -3447,7 +3448,7 @@ do_sigaltstack (const stack_t *ss, stack_t *oss, unsigned long sp)
 			ss_size = 0;
 			ss_sp = NULL;
 		} else {
-			if (unlikely(ss_size < MINSIGSTKSZ))
+			if (unlikely(ss_size < min_ss_size))
 				return -ENOMEM;
 		}
 
@@ -3465,7 +3466,8 @@ SYSCALL_DEFINE2(sigaltstack,const stack_t __user *,uss, stack_t __user *,uoss)
 	if (uss && copy_from_user(&new, uss, sizeof(stack_t)))
 		return -EFAULT;
 	err = do_sigaltstack(uss ? &new : NULL, uoss ? &old : NULL,
-			      current_user_stack_pointer());
+			      current_user_stack_pointer(),
+			      MINSIGSTKSZ);
 	if (!err && uoss && copy_to_user(uoss, &old, sizeof(stack_t)))
 		err = -EFAULT;
 	return err;
@@ -3476,7 +3478,8 @@ int restore_altstack(const stack_t __user *uss)
 	stack_t new;
 	if (copy_from_user(&new, uss, sizeof(stack_t)))
 		return -EFAULT;
-	(void)do_sigaltstack(&new, NULL, current_user_stack_pointer());
+	(void)do_sigaltstack(&new, NULL, current_user_stack_pointer(),
+			     MINSIGSTKSZ);
 	/* squash all but EFAULT for now */
 	return 0;
 }
@@ -3510,7 +3513,8 @@ static int do_compat_sigaltstack(const compat_stack_t __user *uss_ptr,
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
2.1.4

