Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3067EC4646D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 13:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C92AB217AE
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 13:52:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C92AB217AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbeHKQ0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 12:26:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:39986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727361AbeHKQYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 12:24:30 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F05121B34;
        Sat, 11 Aug 2018 13:50:14 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1foUHV-000677-AK; Sat, 11 Aug 2018 09:50:13 -0400
Message-Id: <20180811135013.219285446@goodmis.org>
User-Agent: quilt/0.65
Date:   Sat, 11 Aug 2018 09:49:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [for-next][PATCH 14/34] lockdep: Use this_cpu_ptr instead of get_cpu_var stats
References: <20180811134928.034373761@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

get_cpu_var disables preemption which has the potential to call into the
preemption disable trace points causing some complications. There's also
no need to disable preemption in uses of get_lock_stats anyway since
preempt is already disabled. So lets simplify the code.

Link: http://lkml.kernel.org/r/20180730222423.196630-2-joel@joelfernandes.org

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/locking/lockdep.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 5fa4d3138bf1..fbbb79d5cfa0 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -248,12 +248,7 @@ void clear_lock_stats(struct lock_class *class)
 
 static struct lock_class_stats *get_lock_stats(struct lock_class *class)
 {
-	return &get_cpu_var(cpu_lock_stats)[class - lock_classes];
-}
-
-static void put_lock_stats(struct lock_class_stats *stats)
-{
-	put_cpu_var(cpu_lock_stats);
+	return &this_cpu_ptr(cpu_lock_stats)[class - lock_classes];
 }
 
 static void lock_release_holdtime(struct held_lock *hlock)
@@ -271,7 +266,6 @@ static void lock_release_holdtime(struct held_lock *hlock)
 		lock_time_inc(&stats->read_holdtime, holdtime);
 	else
 		lock_time_inc(&stats->write_holdtime, holdtime);
-	put_lock_stats(stats);
 }
 #else
 static inline void lock_release_holdtime(struct held_lock *hlock)
@@ -4090,7 +4084,6 @@ __lock_contended(struct lockdep_map *lock, unsigned long ip)
 		stats->contending_point[contending_point]++;
 	if (lock->cpu != smp_processor_id())
 		stats->bounces[bounce_contended + !!hlock->read]++;
-	put_lock_stats(stats);
 }
 
 static void
@@ -4138,7 +4131,6 @@ __lock_acquired(struct lockdep_map *lock, unsigned long ip)
 	}
 	if (lock->cpu != cpu)
 		stats->bounces[bounce_acquired + !!hlock->read]++;
-	put_lock_stats(stats);
 
 	lock->cpu = cpu;
 	lock->ip = ip;
-- 
2.18.0


