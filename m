Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6B0C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BFEA2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:16:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BFEA2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbeJPRFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 13:05:46 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57765 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbeJPRFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 13:05:46 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9G9FpXW4032579
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 16 Oct 2018 02:15:51 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9G9Fop34032569;
        Tue, 16 Oct 2018 02:15:50 -0700
Date:   Tue, 16 Oct 2018 02:15:50 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Song Muchun <tipbot@zytor.com>
Message-ID: <tip-9845c49cc9bbb317a0bc9e9cf78d8e09d54c9af0@git.kernel.org>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        smuchun@gmail.com, mingo@kernel.org, efault@gmx.de
Reply-To: torvalds@linux-foundation.org, tglx@linutronix.de,
          smuchun@gmail.com, hpa@zytor.com, mingo@kernel.org,
          efault@gmx.de, peterz@infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20181014112612.2614-1-smuchun@gmail.com>
References: <20181014112612.2614-1-smuchun@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/urgent] sched/fair: Fix the min_vruntime update logic in
 dequeue_entity()
Git-Commit-ID: 9845c49cc9bbb317a0bc9e9cf78d8e09d54c9af0
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

Commit-ID:  9845c49cc9bbb317a0bc9e9cf78d8e09d54c9af0
Gitweb:     https://git.kernel.org/tip/9845c49cc9bbb317a0bc9e9cf78d8e09d54c9af0
Author:     Song Muchun <smuchun@gmail.com>
AuthorDate: Sun, 14 Oct 2018 19:26:12 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 16 Oct 2018 09:36:01 +0200

sched/fair: Fix the min_vruntime update logic in dequeue_entity()

The comment and the code around the update_min_vruntime() call in
dequeue_entity() are not in agreement.

From commit:

  b60205c7c558 ("sched/fair: Fix min_vruntime tracking")

I think that we want to update min_vruntime when a task is sleeping/migrating.
So, the check is inverted there - fix it.

Signed-off-by: Song Muchun <smuchun@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: b60205c7c558 ("sched/fair: Fix min_vruntime tracking")
Link: http://lkml.kernel.org/r/20181014112612.2614-1-smuchun@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f88e00705b55..908c9cdae2f0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4001,7 +4001,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 * put back on, and if we advance min_vruntime, we'll be placed back
 	 * further than we started -- ie. we'll be penalized.
 	 */
-	if ((flags & (DEQUEUE_SAVE | DEQUEUE_MOVE)) == DEQUEUE_SAVE)
+	if ((flags & (DEQUEUE_SAVE | DEQUEUE_MOVE)) != DEQUEUE_SAVE)
 		update_min_vruntime(cfs_rq);
 }
 
