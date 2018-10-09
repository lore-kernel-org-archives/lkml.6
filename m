Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958EAC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 665EE20835
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:22:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 665EE20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbeJISim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:38:42 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37733 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbeJISim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:38:42 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w99BLnjg1014300
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 9 Oct 2018 04:21:49 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w99BLmIV1014297;
        Tue, 9 Oct 2018 04:21:48 -0700
Date:   Tue, 9 Oct 2018 04:21:48 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Lance Roy <tipbot@zytor.com>
Message-ID: <tip-4de1a293a08bdf8ec1530e02163930ac86f80ea2@git.kernel.org>
Cc:     paulmck@linux.ibm.com, ldr709@gmail.com, dvhart@infradead.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, mingo@kernel.org,
        hpa@zytor.com, peterz@infradead.org
Reply-To: ldr709@gmail.com, dvhart@infradead.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com,
          peterz@infradead.org, paulmck@linux.ibm.com
In-Reply-To: <20181003053902.6910-12-ldr709@gmail.com>
References: <20181003053902.6910-12-ldr709@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] futex: Replace spin_is_locked() with lockdep
Git-Commit-ID: 4de1a293a08bdf8ec1530e02163930ac86f80ea2
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

Commit-ID:  4de1a293a08bdf8ec1530e02163930ac86f80ea2
Gitweb:     https://git.kernel.org/tip/4de1a293a08bdf8ec1530e02163930ac86f80ea2
Author:     Lance Roy <ldr709@gmail.com>
AuthorDate: Tue, 2 Oct 2018 22:38:57 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 9 Oct 2018 13:19:28 +0200

futex: Replace spin_is_locked() with lockdep

lockdep_assert_held() is better suited for checking locking requirements,
since it won't get confused when the lock is held by some other task. This
is also a step towards possibly removing spin_is_locked().

Signed-off-by: Lance Roy <ldr709@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Darren Hart <dvhart@infradead.org>
Link: https://lkml.kernel.org/r/20181003053902.6910-12-ldr709@gmail.com

---
 kernel/futex.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index 11fc3bb456d6..3e2de8fc1891 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1365,9 +1365,9 @@ static void __unqueue_futex(struct futex_q *q)
 {
 	struct futex_hash_bucket *hb;
 
-	if (WARN_ON_SMP(!q->lock_ptr || !spin_is_locked(q->lock_ptr))
-	    || WARN_ON(plist_node_empty(&q->list)))
+	if (WARN_ON_SMP(!q->lock_ptr) || WARN_ON(plist_node_empty(&q->list)))
 		return;
+	lockdep_assert_held(q->lock_ptr);
 
 	hb = container_of(q->lock_ptr, struct futex_hash_bucket, lock);
 	plist_del(&q->list, &hb->chain);
