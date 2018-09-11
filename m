Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2867C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 06:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92126206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 06:23:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92126206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbeIKLVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 07:21:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37903 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbeIKLVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 07:21:03 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8B6MtoF2135929
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 10 Sep 2018 23:22:55 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8B6Msaj2135925;
        Mon, 10 Sep 2018 23:22:54 -0700
Date:   Mon, 10 Sep 2018 23:22:54 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Steven Rostedt (VMware)" <tipbot@zytor.com>
Message-ID: <tip-84818af26350c245c8e1994493b7459c0822be5b@git.kernel.org>
Cc:     peda@axentia.se, torvalds@linux-foundation.org,
        peterz@infradead.org, hpa@zytor.com, mingo@kernel.org,
        tglx@linutronix.de, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org
Reply-To: peterz@infradead.org, hpa@zytor.com,
          torvalds@linux-foundation.org, peda@axentia.se,
          linux-kernel@vger.kernel.org, rostedt@goodmis.org,
          mingo@kernel.org, tglx@linutronix.de
In-Reply-To: <20180910214638.55926030@vmware.local.home>
References: <20180910214638.55926030@vmware.local.home>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/rtmutex: Fix the preprocessor logic with
 normal #ifdef #else #endif
Git-Commit-ID: 84818af26350c245c8e1994493b7459c0822be5b
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

Commit-ID:  84818af26350c245c8e1994493b7459c0822be5b
Gitweb:     https://git.kernel.org/tip/84818af26350c245c8e1994493b7459c0822be5b
Author:     Steven Rostedt (VMware) <rostedt@goodmis.org>
AuthorDate: Mon, 10 Sep 2018 21:46:38 -0400
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 11 Sep 2018 08:12:00 +0200

locking/rtmutex: Fix the preprocessor logic with normal #ifdef #else #endif

Merging v4.14.68 into v4.14-rt I tripped over a conflict in the
rtmutex.c code. There I found that we had:

 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 [..]
 #endif

 #ifndef CONFIG_DEBUG_LOCK_ALLOC
 [..]
 #endif

Really this should be:

 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 [..]
 #else
 [..]
 #endif

This cleans up that logic.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Rosin <peda@axentia.se>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180910214638.55926030@vmware.local.home
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/rtmutex.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 2823d4163a37..581edcc63c26 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1485,9 +1485,9 @@ void __sched rt_mutex_lock_nested(struct rt_mutex *lock, unsigned int subclass)
 	__rt_mutex_lock(lock, subclass);
 }
 EXPORT_SYMBOL_GPL(rt_mutex_lock_nested);
-#endif
 
-#ifndef CONFIG_DEBUG_LOCK_ALLOC
+#else /* !CONFIG_DEBUG_LOCK_ALLOC */
+
 /**
  * rt_mutex_lock - lock a rt_mutex
  *
