Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBBAECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 20:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10C69206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 20:35:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10C69206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbeKIGMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 01:12:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40192 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727287AbeKIGMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 01:12:39 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E241E30024A1;
        Thu,  8 Nov 2018 20:35:30 +0000 (UTC)
Received: from llong.com (dhcp-17-55.bos.redhat.com [10.18.17.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 900461001F4A;
        Thu,  8 Nov 2018 20:35:29 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Waiman Long <longman@redhat.com>
Subject: [RFC PATCH 03/12] locking/lockdep: Add DEFINE_TERMINAL_SPINLOCK() and related macros
Date:   Thu,  8 Nov 2018 15:34:19 -0500
Message-Id: <1541709268-3766-4-git-send-email-longman@redhat.com>
In-Reply-To: <1541709268-3766-1-git-send-email-longman@redhat.com>
References: <1541709268-3766-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Thu, 08 Nov 2018 20:35:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new DEFINE_RAW_TERMINAL_SPINLOCK() and DEFINE_TERMINAL_SPINLOCK()
macro to define a raw terminal spinlock and a terminal spinlock.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/spinlock_types.h | 34 +++++++++++++++++++++++-----------
 kernel/printk/printk_safe.c    |  2 +-
 2 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/include/linux/spinlock_types.h b/include/linux/spinlock_types.h
index 24b4e6f..6a8086e 100644
--- a/include/linux/spinlock_types.h
+++ b/include/linux/spinlock_types.h
@@ -33,9 +33,10 @@
 #define SPINLOCK_OWNER_INIT	((void *)-1L)
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
-# define SPIN_DEP_MAP_INIT(lockname)	.dep_map = { .name = #lockname }
+# define SPIN_DEP_MAP_INIT(lockname, f) .dep_map = { .name = #lockname, \
+						     .flags = f }
 #else
-# define SPIN_DEP_MAP_INIT(lockname)
+# define SPIN_DEP_MAP_INIT(lockname, f)
 #endif
 
 #ifdef CONFIG_DEBUG_SPINLOCK
@@ -47,16 +48,22 @@
 # define SPIN_DEBUG_INIT(lockname)
 #endif
 
-#define __RAW_SPIN_LOCK_INITIALIZER(lockname)	\
-	{					\
-	.raw_lock = __ARCH_SPIN_LOCK_UNLOCKED,	\
-	SPIN_DEBUG_INIT(lockname)		\
-	SPIN_DEP_MAP_INIT(lockname) }
+#define __RAW_SPIN_LOCK_INITIALIZER(lockname, f)	\
+	{						\
+	.raw_lock = __ARCH_SPIN_LOCK_UNLOCKED,		\
+	SPIN_DEBUG_INIT(lockname)			\
+	SPIN_DEP_MAP_INIT(lockname, f) }
 
 #define __RAW_SPIN_LOCK_UNLOCKED(lockname)	\
-	(raw_spinlock_t) __RAW_SPIN_LOCK_INITIALIZER(lockname)
+	(raw_spinlock_t) __RAW_SPIN_LOCK_INITIALIZER(lockname, 0)
+
+#define __RAW_TERMINAL_SPIN_LOCK_UNLOCKED(lockname)	\
+	(raw_spinlock_t) __RAW_SPIN_LOCK_INITIALIZER(lockname, \
+						     LOCKDEP_FLAG_TERMINAL)
 
 #define DEFINE_RAW_SPINLOCK(x)	raw_spinlock_t x = __RAW_SPIN_LOCK_UNLOCKED(x)
+#define DEFINE_RAW_TERMINAL_SPINLOCK(x)	\
+		raw_spinlock_t x = __RAW_TERMINAL_SPIN_LOCK_UNLOCKED(x)
 
 typedef struct spinlock {
 	union {
@@ -72,13 +79,18 @@
 	};
 } spinlock_t;
 
-#define __SPIN_LOCK_INITIALIZER(lockname) \
-	{ { .rlock = __RAW_SPIN_LOCK_INITIALIZER(lockname) } }
+#define __SPIN_LOCK_INITIALIZER(lockname, f) \
+	{ { .rlock = __RAW_SPIN_LOCK_INITIALIZER(lockname, f) } }
 
 #define __SPIN_LOCK_UNLOCKED(lockname) \
-	(spinlock_t ) __SPIN_LOCK_INITIALIZER(lockname)
+	(spinlock_t) __SPIN_LOCK_INITIALIZER(lockname, 0)
+
+#define __TERMINAL_SPIN_LOCK_UNLOCKED(lockname) \
+	(spinlock_t) __SPIN_LOCK_INITIALIZER(lockname, LOCKDEP_FLAG_TERMINAL)
 
 #define DEFINE_SPINLOCK(x)	spinlock_t x = __SPIN_LOCK_UNLOCKED(x)
+#define DEFINE_TERMINAL_SPINLOCK(x) \
+				spinlock_t x = __TERMINAL_SPIN_LOCK_UNLOCKED(x)
 
 #include <linux/rwlock_types.h>
 
diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
index 0913b4d..8ff1033 100644
--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -192,7 +192,7 @@ static void report_message_lost(struct printk_safe_seq_buf *s)
 static void __printk_safe_flush(struct irq_work *work)
 {
 	static raw_spinlock_t read_lock =
-		__RAW_SPIN_LOCK_INITIALIZER(read_lock);
+		__RAW_SPIN_LOCK_UNLOCKED(read_lock);
 	struct printk_safe_seq_buf *s =
 		container_of(work, struct printk_safe_seq_buf, work);
 	unsigned long flags;
-- 
1.8.3.1

