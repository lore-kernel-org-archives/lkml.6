Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7077C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 16:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 656022075E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 16:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XtjnRpUH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 656022075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbeIFVUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 17:20:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37056 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbeIFVUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 17:20:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FVJkbDPHEtEdaJbQjoGO4JdLYzzLJEfEzq2lBgh8iTM=; b=XtjnRpUHEgswL0xegfjHZfj2x
        9Sis/6mKvQxilCMZE2kp9+JtSK/MwrmNNVDPJFaRzeDZ6MJ17a/TS+7h+D7cJqjAKHpzQfG+78Fo/
        9uZbz/dx0FXbc4nGg2SAjhpdXZKGVNCOjCrmeXJ/ggMb+YAd4dsSAFzvVtHopJegWM1M+At83duwz
        qbqyZLwDCBvoW1MumHxdT9lK9pDdFoT9hMZbZmm3IR5COyV65aQWDNKHhaW4ZRHQIVDEZGS9vIjwm
        fhOZw/A3wgcN89xXlbVh/eMMz79TK2s1640LVpu8D6ppRVQ+8JlEWAr5gjPqwcGbk3ili6+XFwzKo
        yPlUFcyZw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fxxNp-0000Su-AK; Thu, 06 Sep 2018 16:43:53 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0C9EC2058B2E3; Thu,  6 Sep 2018 18:43:51 +0200 (CEST)
Date:   Thu, 6 Sep 2018 18:43:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH] lockdep: Have assert functions test for actual
 interrupts disabled
Message-ID: <20180906164350.GI24106@hirez.programming.kicks-ass.net>
References: <20180806214107.110626d0@gandalf.local.home>
 <20180905112031.540aa81b@gandalf.local.home>
 <20180906135258.GE24106@hirez.programming.kicks-ass.net>
 <20180906101701.3ffcba07@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906101701.3ffcba07@gandalf.local.home>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 10:17:01AM -0400, Steven Rostedt wrote:
> I still think checking if IRQS are really disabled or not when lockdep
> thinks it is (or not) is valuable and doesn't cause any other problems.

Since check_flags() is a relatively cheap thing I would rather do
something like so..

---
 include/linux/lockdep.h  |  6 ++++--
 kernel/locking/lockdep.c | 36 +++++++++++++++++++++++-------------
 2 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index b0d0b51c4d85..24ff6302c04b 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -596,15 +596,17 @@ do {									\
 	lock_release(&(lock)->dep_map, 0, _THIS_IP_);			\
 } while (0)
 
+extern bool lockdep_check_flags(void);
+
 #define lockdep_assert_irqs_enabled()	do {				\
 		WARN_ONCE(debug_locks && !current->lockdep_recursion &&	\
-			  !current->hardirqs_enabled,			\
+			  !current->hardirqs_enabled && lockdep_check_flags(), \
 			  "IRQs not enabled as expected\n");		\
 	} while (0)
 
 #define lockdep_assert_irqs_disabled()	do {				\
 		WARN_ONCE(debug_locks && !current->lockdep_recursion &&	\
-			  current->hardirqs_enabled,			\
+			  current->hardirqs_enabled && lockdep_check_flags(), \
 			  "IRQs not disabled as expected\n");		\
 	} while (0)
 
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index e406c5fdb41e..6cc58a16f2fe 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3807,10 +3807,9 @@ static void __lock_unpin_lock(struct lockdep_map *lock, struct pin_cookie cookie
 /*
  * Check whether we follow the irq-flags state precisely:
  */
-static void check_flags(unsigned long flags)
+void __lockdep_check_flags(unsigned long flags)
 {
-#if defined(CONFIG_PROVE_LOCKING) && defined(CONFIG_DEBUG_LOCKDEP) && \
-    defined(CONFIG_TRACE_IRQFLAGS)
+#if defined(CONFIG_PROVE_LOCKING) && defined(CONFIG_TRACE_IRQFLAGS)
 	if (!debug_locks)
 		return;
 
@@ -3844,6 +3843,17 @@ static void check_flags(unsigned long flags)
 #endif
 }
 
+bool lockdep_check_flags(void)
+{
+	unsigned long flags;
+
+	raw_local_irq_save(flags);
+	__lockdep_check_flags(flags);
+	raw_local_irq_restore(flags);
+
+	return true;
+}
+
 void lock_set_class(struct lockdep_map *lock, const char *name,
 		    struct lock_class_key *key, unsigned int subclass,
 		    unsigned long ip)
@@ -3855,7 +3865,7 @@ void lock_set_class(struct lockdep_map *lock, const char *name,
 
 	raw_local_irq_save(flags);
 	current->lockdep_recursion = 1;
-	check_flags(flags);
+	__lockdep_check_flags(flags);
 	if (__lock_set_class(lock, name, key, subclass, ip))
 		check_chain_key(current);
 	current->lockdep_recursion = 0;
@@ -3872,7 +3882,7 @@ void lock_downgrade(struct lockdep_map *lock, unsigned long ip)
 
 	raw_local_irq_save(flags);
 	current->lockdep_recursion = 1;
-	check_flags(flags);
+	__lockdep_check_flags(flags);
 	if (__lock_downgrade(lock, ip))
 		check_chain_key(current);
 	current->lockdep_recursion = 0;
@@ -3894,7 +3904,7 @@ void lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 		return;
 
 	raw_local_irq_save(flags);
-	check_flags(flags);
+	__lockdep_check_flags(flags);
 
 	current->lockdep_recursion = 1;
 	trace_lock_acquire(lock, subclass, trylock, read, check, nest_lock, ip);
@@ -3914,7 +3924,7 @@ void lock_release(struct lockdep_map *lock, int nested,
 		return;
 
 	raw_local_irq_save(flags);
-	check_flags(flags);
+	__lockdep_check_flags(flags);
 	current->lockdep_recursion = 1;
 	trace_lock_release(lock, ip);
 	if (__lock_release(lock, nested, ip))
@@ -3933,7 +3943,7 @@ int lock_is_held_type(const struct lockdep_map *lock, int read)
 		return 1; /* avoid false negative lockdep_assert_held() */
 
 	raw_local_irq_save(flags);
-	check_flags(flags);
+	__lockdep_check_flags(flags);
 
 	current->lockdep_recursion = 1;
 	ret = __lock_is_held(lock, read);
@@ -3953,7 +3963,7 @@ struct pin_cookie lock_pin_lock(struct lockdep_map *lock)
 		return cookie;
 
 	raw_local_irq_save(flags);
-	check_flags(flags);
+	__lockdep_check_flags(flags);
 
 	current->lockdep_recursion = 1;
 	cookie = __lock_pin_lock(lock);
@@ -3972,7 +3982,7 @@ void lock_repin_lock(struct lockdep_map *lock, struct pin_cookie cookie)
 		return;
 
 	raw_local_irq_save(flags);
-	check_flags(flags);
+	__lockdep_check_flags(flags);
 
 	current->lockdep_recursion = 1;
 	__lock_repin_lock(lock, cookie);
@@ -3989,7 +3999,7 @@ void lock_unpin_lock(struct lockdep_map *lock, struct pin_cookie cookie)
 		return;
 
 	raw_local_irq_save(flags);
-	check_flags(flags);
+	__lockdep_check_flags(flags);
 
 	current->lockdep_recursion = 1;
 	__lock_unpin_lock(lock, cookie);
@@ -4130,7 +4140,7 @@ void lock_contended(struct lockdep_map *lock, unsigned long ip)
 		return;
 
 	raw_local_irq_save(flags);
-	check_flags(flags);
+	__lockdep_check_flags(flags);
 	current->lockdep_recursion = 1;
 	trace_lock_contended(lock, ip);
 	__lock_contended(lock, ip);
@@ -4150,7 +4160,7 @@ void lock_acquired(struct lockdep_map *lock, unsigned long ip)
 		return;
 
 	raw_local_irq_save(flags);
-	check_flags(flags);
+	__lockdep_check_flags(flags);
 	current->lockdep_recursion = 1;
 	__lock_acquired(lock, ip);
 	current->lockdep_recursion = 0;
