Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B33C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F6B42192B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550198417;
	bh=U4eNktDgDLUWZA4GxgdtHM+pvUcg9TM72SYwVJUk5oQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sILWMrKSffCuDHfVu8OeX7gIZbwTV8j1CkfuEPtDCkCfNGNRDR3hxUyL2FrliU8i/
	 3hJhgGJ8k4jYRMpNodRT5Nk35UH8EPovVnsGs/1NcE5BMhqOYJpzSZCa/opinCxjdQ
	 1yebKs3frdf5PE7fNhOrBEfS99AihhiXVL9wdt88=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730493AbfBOCkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:40:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:50216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389899AbfBOCKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:10:03 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D3AA206BA;
        Fri, 15 Feb 2019 02:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196603;
        bh=U4eNktDgDLUWZA4GxgdtHM+pvUcg9TM72SYwVJUk5oQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ROj70EkUeS3YweNXAdukca4H8Yhyhenrsk+K/v1OOz169wndSxFJVxMECVxGBfSbl
         VKeT/blGzOMoJKp5BSbiX5nORc/Sv8QTkAv4/a7/6HAc9BSnUcoYJFbmcKsCFiC/wn
         zEedfarCUiK7uiwROLsNmCiap9iZ+cdDVnazYzvs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 38/77] sched/wake_q: Fix wakeup ordering for wake_q
Date:   Thu, 14 Feb 2019 21:08:16 -0500
Message-Id: <20190215020855.176727-38-sashal@kernel.org>
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

[ Upstream commit 4c4e3731564c8945ac5ac90fc2a1e1f21cb79c92 ]

Notable cmpxchg() does not provide ordering when it fails, however
wake_q_add() requires ordering in this specific case too. Without this
it would be possible for the concurrent wakeup to not observe our
prior state.

Andrea Parri provided:

  C wake_up_q-wake_q_add

  {
	int next = 0;
	int y = 0;
  }

  P0(int *next, int *y)
  {
	int r0;

	/* in wake_up_q() */

	WRITE_ONCE(*next, 1);   /* node->next = NULL */
	smp_mb();               /* implied by wake_up_process() */
	r0 = READ_ONCE(*y);
  }

  P1(int *next, int *y)
  {
	int r1;

	/* in wake_q_add() */

	WRITE_ONCE(*y, 1);      /* wake_cond = true */
	smp_mb__before_atomic();
	r1 = cmpxchg_relaxed(next, 1, 2);
  }

  exists (0:r0=0 /\ 1:r1=0)

  This "exists" clause cannot be satisfied according to the LKMM:

  Test wake_up_q-wake_q_add Allowed
  States 3
  0:r0=0; 1:r1=1;
  0:r0=1; 1:r1=0;
  0:r0=1; 1:r1=1;
  No
  Witnesses
  Positive: 0 Negative: 3
  Condition exists (0:r0=0 /\ 1:r1=0)
  Observation wake_up_q-wake_q_add Never 0 3

Reported-by: Yongji Xie <elohimes@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Waiman Long <longman@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6fedf3a98581..463af32de32c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -405,10 +405,11 @@ void wake_q_add(struct wake_q_head *head, struct task_struct *task)
 	 * its already queued (either by us or someone else) and will get the
 	 * wakeup due to that.
 	 *
-	 * This cmpxchg() executes a full barrier, which pairs with the full
-	 * barrier executed by the wakeup in wake_up_q().
+	 * In order to ensure that a pending wakeup will observe our pending
+	 * state, even in the failed case, an explicit smp_mb() must be used.
 	 */
-	if (cmpxchg(&node->next, NULL, WAKE_Q_TAIL))
+	smp_mb__before_atomic();
+	if (cmpxchg_relaxed(&node->next, NULL, WAKE_Q_TAIL))
 		return;
 
 	get_task_struct(task);
-- 
2.19.1

