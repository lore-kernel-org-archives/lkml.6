Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653FBC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1728A20840
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:05:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1728A20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388814AbeHAKuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 06:50:12 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:33405 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387658AbeHAKuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 06:50:12 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1fkn4P-0002OU-7P; Wed, 01 Aug 2018 11:05:25 +0200
Date:   Wed, 1 Aug 2018 11:05:25 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-rt-users@vger.kernel.org
Cc:     tglx@linutronix.de, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH RT] sched: drop is_special_task_state() check from
 __set_current_state_no_track()
Message-ID: <20180801090524.7hmzfdx7r4bivekq@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The is_special_task_state() check in __set_current_state_no_track()
has been wrongly placed. __set_current_state_no_track() is used in RT
while a sleeping lock is acquired. It is used at the begin of the wait
loop with TASK_UNINTERRUPTIBLE and while leaving it and restoring the
original state. The latter part triggers the warning.

Drop the special state check. This is only used within the sleeping lock
implementation and the assignment happens while the PI lock is held.
While at it, drop set_current_state_no_track() because it has no users.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/sched.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index a0c1c0cae992..b20264e17b02 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -132,16 +132,9 @@ struct task_group;
 
 #define __set_current_state_no_track(state_value)		\
 	do {							\
-		WARN_ON_ONCE(is_special_task_state(state_value));\
 		current->state = (state_value);			\
 	} while (0)
 
-#define set_current_state_no_track(state_value)			\
-	do {							\
-		WARN_ON_ONCE(is_special_task_state(state_value));\
-		smp_store_mb(current->state, (state_value));	\
-	} while (0)
-
 #define set_special_state(state_value)					\
 	do {								\
 		unsigned long flags; /* may shadow */			\
@@ -196,7 +189,6 @@ struct task_group;
 	smp_store_mb(current->state, (state_value))
 
 #define __set_current_state_no_track(state_value)	__set_current_state(state_value)
-#define set_current_state_no_track(state_value)		set_current_state(state_value)
 
 /*
  * set_special_state() should be used for those states when the blocking task
-- 
2.18.0

