Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD55C43143
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 01:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 038CF20645
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 01:48:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 038CF20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbeIKGn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 02:43:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:48516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726156AbeIKGn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 02:43:29 -0400
Received: from vmware.local.home (unknown [208.91.3.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B604020645;
        Tue, 11 Sep 2018 01:46:40 +0000 (UTC)
Date:   Mon, 10 Sep 2018 21:46:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Peter Rosin <peda@axentia.se>
Subject: [PATCH] rtmutex: Fix the preprocessor logic with normal #ifdef
 #else #endif
Message-ID: <20180910214638.55926030@vmware.local.home>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Steven Rostedt (VMware) <rostedt@goodmis.org>

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
---
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
