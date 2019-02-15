Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09027C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C486A21A80
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550198384;
	bh=9Sh6dAlQb5uVkUZprZC23zzTcgJQr9jYvWnjPa51V8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2VXg4pi/pV7VMZSNj4+DDiry8kEQmR8bBXdyp3ug1nO3ckwQTG0UfMCu9nTSi6kD9
	 Hdl8mG0iLMeYcPXMS4zgcJkgoFOKeiE6/NsxJt1kFNagVtFA1/+Rx451enWy8JBhbz
	 5y9tXUFchYjOtzuKGSQa+e87f5noreXKnzRFZIMM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390103AbfBOCKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:10:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:50246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389959AbfBOCKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:10:04 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89340222C9;
        Fri, 15 Feb 2019 02:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196604;
        bh=9Sh6dAlQb5uVkUZprZC23zzTcgJQr9jYvWnjPa51V8E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1hXcgvnWm1v4soXLREI+b21mxAdF5euKW6pt4H5bAihMYTuBPt3EFcGKLVmZStdNu
         HBO4iPtbBy0l8i3R0iM/dQ07nHqdsPUkALzt6GEccqPjNPr9lK6o7O3CeS87rqUzSV
         0hyPfFsv2rfHBWxkE5oXFQBrAp4zatntPAOL0Lak=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 39/77] futex: Fix (possible) missed wakeup
Date:   Thu, 14 Feb 2019 21:08:17 -0500
Message-Id: <20190215020855.176727-39-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215020855.176727-1-sashal@kernel.org>
References: <20190215020855.176727-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit b061c38bef43406df8e73c5be06cbfacad5ee6ad ]

We must not rely on wake_q_add() to delay the wakeup; in particular
commit:

  1d0dcb3ad9d3 ("futex: Implement lockless wakeups")

moved wake_q_add() before smp_store_release(&q->lock_ptr, NULL), which
could result in futex_wait() waking before observing ->lock_ptr ==
NULL and going back to sleep again.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: 1d0dcb3ad9d3 ("futex: Implement lockless wakeups")
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/futex.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index 5cc8083a4c89..6189292244a3 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1444,11 +1444,7 @@ static void mark_wake_futex(struct wake_q_head *wake_q, struct futex_q *q)
 	if (WARN(q->pi_state || q->rt_waiter, "refusing to wake PI futex\n"))
 		return;
 
-	/*
-	 * Queue the task for later wakeup for after we've released
-	 * the hb->lock. wake_q_add() grabs reference to p.
-	 */
-	wake_q_add(wake_q, p);
+	get_task_struct(p);
 	__unqueue_futex(q);
 	/*
 	 * The waiting task can free the futex_q as soon as q->lock_ptr = NULL
@@ -1458,6 +1454,13 @@ static void mark_wake_futex(struct wake_q_head *wake_q, struct futex_q *q)
 	 * plist_del in __unqueue_futex().
 	 */
 	smp_store_release(&q->lock_ptr, NULL);
+
+	/*
+	 * Queue the task for later wakeup for after we've released
+	 * the hb->lock. wake_q_add() grabs reference to p.
+	 */
+	wake_q_add(wake_q, p);
+	put_task_struct(p);
 }
 
 /*
-- 
2.19.1

