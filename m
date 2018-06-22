Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5597EC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 00:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F352A22BC7
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 00:35:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F352A22BC7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934078AbeFVAfb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 20:35:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:47846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933379AbeFVAfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 20:35:30 -0400
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2CA822AC6;
        Fri, 22 Jun 2018 00:35:28 +0000 (UTC)
Date:   Thu, 21 Jun 2018 20:35:26 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] locking/qspinlock: Fix build for anonymous union in older
 gcc compilers
Message-ID: <20180621203526.172ab5c4@vmware.local.home>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

One of my tests compiles the kernel with gcc 4.5.3, and I hit the
following build error:

/work/git/linux-trace.git/include/linux/semaphore.h: In function 'sema_init':
/work/git/linux-trace.git/include/linux/semaphore.h:35:17: error: unknown field 'val' specified in initializer
/work/git/linux-trace.git/include/linux/semaphore.h:35:17: warning: missing braces around initializer
/work/git/linux-trace.git/include/linux/semaphore.h:35:17: warning: (near initialization for '(anonymous).raw_lock.<anonymous>.val')
In file included from /work/git/linux-trace.git/include/linux/sched/user.h:7:0,
                 from /work/git/linux-trace.git/include/linux/cred.h:22,
                 from /work/git/linux-trace.git/include/linux/seq_file.h:12,
                 from /work/git/linux-trace.git/include/linux/cgroup.h:18,
                 from /work/git/linux-trace.git/include/linux/memcontrol.h:22,
                 from /work/git/linux-trace.git/include/linux/swap.h:9,
                 from /work/git/linux-trace.git/include/linux/suspend.h:5,
                 from /work/git/linux-trace.git/arch/x86/kernel/asm-offsets.c:13:


I bisected it down to the introduction of the commit that makes
qspinlock have an anonymous union, which makes initializing it special
for older compilers. By adding strategic brackets, it makes the build
happy again.

Fixes: 625e88be1f41 ("locking/qspinlock: Merge 'struct __qspinlock' into 'struct qspinlock'")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
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
