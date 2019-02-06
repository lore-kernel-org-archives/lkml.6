Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5AE5C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DB4A2083B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfBFS4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:56:32 -0500
Received: from smtp.nue.novell.com ([195.135.221.5]:44713 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbfBFS4b (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Wed, 6 Feb 2019 13:56:31 -0500
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Wed, 06 Feb 2019 19:56:29 +0100
Received: from linux-r8p5.suse.de (nwb-a10-snat.microfocus.com [10.120.13.202])
        by emea4-mta.ukb.novell.com with ESMTP (TLS encrypted); Wed, 06 Feb 2019 18:56:22 +0000
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     mingo@kernel.org, tglx@linutronix.de
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        dave@stgolabs.net, Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH] kernel/futex: Fix barrier comment
Date:   Wed,  6 Feb 2019 10:56:02 -0800
Message-Id: <20190206185602.949-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current comment for the barrier that guarantees that waiter
increment is always before taking the hb spinlock (barrier (A))
needs to be fixed. We are obviously referring to hb_waiters_inc,
which is a full barrier.

Reported-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
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
 
-- 
2.16.4

