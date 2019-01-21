Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D036CC7112F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4A7720861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbfAUL20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 06:28:26 -0500
Received: from terminus.zytor.com ([198.137.202.136]:49975 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727665AbfAUL2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 06:28:25 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0LBSFo52496127
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 21 Jan 2019 03:28:15 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0LBSFwv2496124;
        Mon, 21 Jan 2019 03:28:15 -0800
Date:   Mon, 21 Jan 2019 03:28:15 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Xie Yongji <tipbot@zytor.com>
Message-ID: <tip-e158488be27b157802753a59b336142dc0eb0380@git.kernel.org>
Cc:     hpa@zytor.com, torvalds@linux-foundation.org, mingo@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        zhangyu31@baidu.com, tglx@linutronix.de, xieyongji@baidu.com
Reply-To: mingo@kernel.org, torvalds@linux-foundation.org, hpa@zytor.com,
          peterz@infradead.org, zhangyu31@baidu.com,
          linux-kernel@vger.kernel.org, xieyongji@baidu.com,
          tglx@linutronix.de
In-Reply-To: <1543495830-2644-1-git-send-email-xieyongji@baidu.com>
References: <1543495830-2644-1-git-send-email-xieyongji@baidu.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/rwsem: Fix (possible) missed wakeup
Git-Commit-ID: e158488be27b157802753a59b336142dc0eb0380
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

Commit-ID:  e158488be27b157802753a59b336142dc0eb0380
Gitweb:     https://git.kernel.org/tip/e158488be27b157802753a59b336142dc0eb0380
Author:     Xie Yongji <xieyongji@baidu.com>
AuthorDate: Thu, 29 Nov 2018 20:50:30 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 21 Jan 2019 11:15:39 +0100

locking/rwsem: Fix (possible) missed wakeup

Because wake_q_add() can imply an immediate wakeup (cmpxchg failure
case), we must not rely on the wakeup being delayed. However, commit:

  e38513905eea ("locking/rwsem: Rework zeroing reader waiter->task")

relies on exactly that behaviour in that the wakeup must not happen
until after we clear waiter->task.

[ peterz: Added changelog. ]

Signed-off-by: Xie Yongji <xieyongji@baidu.com>
Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: e38513905eea ("locking/rwsem: Rework zeroing reader waiter->task")
Link: https://lkml.kernel.org/r/1543495830-2644-1-git-send-email-xieyongji@baidu.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/rwsem-xadd.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index 09b180063ee1..50d9af615dc4 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -198,15 +198,22 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
 		woken++;
 		tsk = waiter->task;
 
-		wake_q_add(wake_q, tsk);
+		get_task_struct(tsk);
 		list_del(&waiter->list);
 		/*
-		 * Ensure that the last operation is setting the reader
+		 * Ensure calling get_task_struct() before setting the reader
 		 * waiter to nil such that rwsem_down_read_failed() cannot
 		 * race with do_exit() by always holding a reference count
 		 * to the task to wakeup.
 		 */
 		smp_store_release(&waiter->task, NULL);
+		/*
+		 * Ensure issuing the wakeup (either by us or someone else)
+		 * after setting the reader waiter to nil.
+		 */
+		wake_q_add(wake_q, tsk);
+		/* wake_q_add() already take the task ref */
+		put_task_struct(tsk);
 	}
 
 	adjustment = woken * RWSEM_ACTIVE_READ_BIAS - adjustment;
