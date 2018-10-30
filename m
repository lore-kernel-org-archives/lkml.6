Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93579C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5981F20838
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0coB6ajb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5981F20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbeJ3WVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:21:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:52284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728009AbeJ3WVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 18:21:21 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 411DF2080A;
        Tue, 30 Oct 2018 13:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540906073;
        bh=jxgTYG7WaiZHvcg2kgMfMRyxJXxxn7ziM0Oy4EaRyJc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0coB6ajbXAzCg06r4qWNIN1ORipxVvqo0aA5r1CqBABECKOh9atyF8nn+KJsrqKYi
         wJt4e7YqBXcQUygU4F4/6WTAZA0ZSJDM90P5y+RkfCGtn6u+my71OZ9IR1cHu7M5nW
         NAGM/a2MhkyoUMAc/lnPvjH90/oEUu1C96f5Lv88=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Song Muchun <smuchun@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Galbraith <efault@gmx.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 20/33] sched/fair: Fix the min_vruntime update logic in dequeue_entity()
Date:   Tue, 30 Oct 2018 09:26:44 -0400
Message-Id: <20181030132657.217970-20-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181030132657.217970-1-sashal@kernel.org>
References: <20181030132657.217970-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Song Muchun <smuchun@gmail.com>

[ Upstream commit 9845c49cc9bbb317a0bc9e9cf78d8e09d54c9af0 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 26526fc41f0d..1c17a4a49ee0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4321,7 +4321,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 * put back on, and if we advance min_vruntime, we'll be placed back
 	 * further than we started -- ie. we'll be penalized.
 	 */
-	if ((flags & (DEQUEUE_SAVE | DEQUEUE_MOVE)) == DEQUEUE_SAVE)
+	if ((flags & (DEQUEUE_SAVE | DEQUEUE_MOVE)) != DEQUEUE_SAVE)
 		update_min_vruntime(cfs_rq);
 }
 
-- 
2.17.1

