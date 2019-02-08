Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E763C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B9782177B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfBHMFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 07:05:10 -0500
Received: from terminus.zytor.com ([198.137.202.136]:49673 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfBHMFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 07:05:09 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x18C4mQX2158784
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 8 Feb 2019 04:04:48 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x18C4l7D2158781;
        Fri, 8 Feb 2019 04:04:48 -0800
Date:   Fri, 8 Feb 2019 04:04:48 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Davidlohr Bueso <tipbot@zytor.com>
Message-ID: <tip-6f568ebe2afefdc33a6fb06ef20a94f8b96455f1@git.kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, dave@stgolabs.net,
        dbueso@suse.de, hpa@zytor.com, peterz@infradead.org,
        tglx@linutronix.de
Reply-To: dave@stgolabs.net, dbueso@suse.de, hpa@zytor.com,
          mingo@kernel.org, linux-kernel@vger.kernel.org,
          peterz@infradead.org, tglx@linutronix.de
In-Reply-To: <20190206185602.949-1-dave@stgolabs.net>
References: <20190206185602.949-1-dave@stgolabs.net>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/urgent] futex: Fix barrier comment
Git-Commit-ID: 6f568ebe2afefdc33a6fb06ef20a94f8b96455f1
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

Commit-ID:  6f568ebe2afefdc33a6fb06ef20a94f8b96455f1
Gitweb:     https://git.kernel.org/tip/6f568ebe2afefdc33a6fb06ef20a94f8b96455f1
Author:     Davidlohr Bueso <dave@stgolabs.net>
AuthorDate: Wed, 6 Feb 2019 10:56:02 -0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 8 Feb 2019 13:00:35 +0100

futex: Fix barrier comment

The current comment for the barrier that guarantees that waiter increment
is always before taking the hb spinlock (barrier (A)) needs to be fixed as
it is misplaced.

This is obviously referring to hb_waiters_inc, which is a full barrier.

Reported-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190206185602.949-1-dave@stgolabs.net

---
 kernel/futex.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index fdd312da0992..5ec2473a3497 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -2221,11 +2221,11 @@ static inline struct futex_hash_bucket *queue_lock(struct futex_q *q)
 	 * decrement the counter at queue_unlock() when some error has
 	 * occurred and we don't end up adding the task to the list.
 	 */
-	hb_waiters_inc(hb);
+	hb_waiters_inc(hb); /* implies smp_mb(); (A) */
 
 	q->lock_ptr = &hb->lock;
 
-	spin_lock(&hb->lock); /* implies smp_mb(); (A) */
+	spin_lock(&hb->lock);
 	return hb;
 }
 
