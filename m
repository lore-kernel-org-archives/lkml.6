Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A6FC7112F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC30320663
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbfAUL3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 06:29:24 -0500
Received: from terminus.zytor.com ([198.137.202.136]:50953 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727665AbfAUL3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 06:29:21 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0LBSrJB2496189
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 21 Jan 2019 03:28:53 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0LBSri52496186;
        Mon, 21 Jan 2019 03:28:53 -0800
Date:   Mon, 21 Jan 2019 03:28:53 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Davidlohr Bueso <tipbot@zytor.com>
Message-ID: <tip-87ff19cb2f1aa55a5d8b691e6690cc059a59d2ec@git.kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, longman@redhat.com,
        akpm@linux-foundation.org, dave@stgolabs.net, peterz@infradead.org,
        tglx@linutronix.de, will.deacon@arm.com, elohimes@gmail.com,
        dbueso@suse.de, hpa@zytor.com, paulmck@linux.vnet.ibm.com,
        torvalds@linux-foundation.org
Reply-To: peterz@infradead.org, tglx@linutronix.de,
          akpm@linux-foundation.org, dave@stgolabs.net, mingo@kernel.org,
          linux-kernel@vger.kernel.org, longman@redhat.com,
          torvalds@linux-foundation.org, elohimes@gmail.com,
          will.deacon@arm.com, dbueso@suse.de, paulmck@linux.vnet.ibm.com,
          hpa@zytor.com
In-Reply-To: <20181203053130.gwkw6kg72azt2npb@linux-r8p5>
References: <20181203053130.gwkw6kg72azt2npb@linux-r8p5>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] sched/wake_q: Add branch prediction hint to
 wake_q_add() cmpxchg
Git-Commit-ID: 87ff19cb2f1aa55a5d8b691e6690cc059a59d2ec
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

Commit-ID:  87ff19cb2f1aa55a5d8b691e6690cc059a59d2ec
Gitweb:     https://git.kernel.org/tip/87ff19cb2f1aa55a5d8b691e6690cc059a59d2ec
Author:     Davidlohr Bueso <dave@stgolabs.net>
AuthorDate: Sun, 2 Dec 2018 21:31:30 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 21 Jan 2019 11:18:50 +0100

sched/wake_q: Add branch prediction hint to wake_q_add() cmpxchg

The cmpxchg() will fail when the task is already in the process
of waking up, and as such is an extremely rare occurrence.
Micro-optimize the call and put an unlikely() around it.

To no surprise, when using CONFIG_PROFILE_ANNOTATED_BRANCHES
under a number of workloads the incorrect rate was a mere 1-2%.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Waiman Long <longman@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Yongji Xie <elohimes@gmail.com>
Cc: andrea.parri@amarulasolutions.com
Cc: lilin24@baidu.com
Cc: liuqi16@baidu.com
Cc: nixun@baidu.com
Cc: xieyongji@baidu.com
Cc: yuanlinsi01@baidu.com
Cc: zhangyu31@baidu.com
Link: https://lkml.kernel.org/r/20181203053130.gwkw6kg72azt2npb@linux-r8p5
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d8d76a65cfdd..b05eef7d7a1f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -421,7 +421,7 @@ void wake_q_add(struct wake_q_head *head, struct task_struct *task)
 	 * state, even in the failed case, an explicit smp_mb() must be used.
 	 */
 	smp_mb__before_atomic();
-	if (cmpxchg_relaxed(&node->next, NULL, WAKE_Q_TAIL))
+	if (unlikely(cmpxchg_relaxed(&node->next, NULL, WAKE_Q_TAIL)))
 		return;
 
 	get_task_struct(task);
