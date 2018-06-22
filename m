Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E562FC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 02:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A862D23C56
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 02:25:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A862D23C56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934217AbeFVCZS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 22:25:18 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33167 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934084AbeFVCZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 22:25:17 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5M2OnLg4103900
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 21 Jun 2018 19:24:49 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5M2OneE4103897;
        Thu, 21 Jun 2018 19:24:49 -0700
Date:   Thu, 21 Jun 2018 19:24:49 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Steven Rostedt (VMware)" <tipbot@zytor.com>
Message-ID: <tip-6cc65be4f6f2a7186af8f3e09900787c7912dad2@git.kernel.org>
Cc:     tglx@linutronix.de, will.deacon@arm.com, rostedt@goodmis.org,
        akpm@linux-foundation.org, longman@redhat.com,
        linux-kernel@vger.kernel.org, boqun.feng@gmail.com,
        peterz@infradead.org, torvalds@linux-foundation.org,
        mingo@kernel.org, hpa@zytor.com
Reply-To: boqun.feng@gmail.com, linux-kernel@vger.kernel.org,
          longman@redhat.com, peterz@infradead.org, hpa@zytor.com,
          mingo@kernel.org, torvalds@linux-foundation.org,
          tglx@linutronix.de, akpm@linux-foundation.org,
          will.deacon@arm.com, rostedt@goodmis.org
In-Reply-To: <20180621203526.172ab5c4@vmware.local.home>
References: <20180621203526.172ab5c4@vmware.local.home>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/urgent] locking/qspinlock: Fix build for anonymous
 union in older GCC compilers
Git-Commit-ID: 6cc65be4f6f2a7186af8f3e09900787c7912dad2
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

Commit-ID:  6cc65be4f6f2a7186af8f3e09900787c7912dad2
Gitweb:     https://git.kernel.org/tip/6cc65be4f6f2a7186af8f3e09900787c7912dad2
Author:     Steven Rostedt (VMware) <rostedt@goodmis.org>
AuthorDate: Thu, 21 Jun 2018 20:35:26 -0400
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 22 Jun 2018 04:19:16 +0200

locking/qspinlock: Fix build for anonymous union in older GCC compilers

One of my tests compiles the kernel with gcc 4.5.3, and I hit the
following build error:

  include/linux/semaphore.h: In function 'sema_init':
  include/linux/semaphore.h:35:17: error: unknown field 'val' specified in initializer
  include/linux/semaphore.h:35:17: warning: missing braces around initializer
  include/linux/semaphore.h:35:17: warning: (near initialization for '(anonymous).raw_lock.<anonymous>.val')

I bisected it down to:

 625e88be1f41 ("locking/qspinlock: Merge 'struct __qspinlock' into 'struct qspinlock'")

... which makes qspinlock have an anonymous union, which makes initializing it special
for older compilers. By adding strategic brackets, it makes the build
happy again.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Acked-by: Waiman Long <longman@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Fixes: 625e88be1f41 ("locking/qspinlock: Merge 'struct __qspinlock' into 'struct qspinlock'")
Link: http://lkml.kernel.org/r/20180621203526.172ab5c4@vmware.local.home
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/asm-generic/qspinlock_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/qspinlock_types.h b/include/asm-generic/qspinlock_types.h
index 0763f065b975..d10f1e7d6ba8 100644
--- a/include/asm-generic/qspinlock_types.h
+++ b/include/asm-generic/qspinlock_types.h
@@ -63,7 +63,7 @@ typedef struct qspinlock {
 /*
  * Initializier
  */
-#define	__ARCH_SPIN_LOCK_UNLOCKED	{ .val = ATOMIC_INIT(0) }
+#define	__ARCH_SPIN_LOCK_UNLOCKED	{ { .val = ATOMIC_INIT(0) } }
 
 /*
  * Bitfields in the atomic value:
