Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392EBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEDBA222DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550196743;
	bh=soZlLbgL6tbq6lNd2cnZAdOntkC3kZXkGgyxvSHXt20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Bac0GYmchwqkNPTCbRXOmpqeeIoQW9fL1CGVy+s3BrDcWQUgA011u6/EovTV2eflv
	 vDq/BY6Txr/lklWNZilMh7/GvNzKO/44yu8FoXxbG2eJaNpF/lQAmT+ewZmKCh6CnC
	 sWJcYPUUdi2GL+H8l1MfDHMu340HslLmsfz/CI5Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404224AbfBOCMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:12:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:52318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404189AbfBOCMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:12:17 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7165D21B68;
        Fri, 15 Feb 2019 02:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196736;
        bh=soZlLbgL6tbq6lNd2cnZAdOntkC3kZXkGgyxvSHXt20=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xuh/+CCm+DaZyAcwSQjHq7CG01UWgmlfKYw4TEBQXV1uvi7dP2TENLRLTQyYcAUwK
         1CCsZa/BYx9KvhDW1+jM7kKRF+2aIg7JkmNouihDTpX005Ga/z+390b2KRI7gW+aG7
         XsOFrohxGiauZUTktG0z8KttwFYv69oA1sgI7pLI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xie Yongji <xieyongji@baidu.com>, Zhang Yu <zhangyu31@baidu.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 33/65] locking/rwsem: Fix (possible) missed wakeup
Date:   Thu, 14 Feb 2019 21:10:49 -0500
Message-Id: <20190215021121.177674-33-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215021121.177674-1-sashal@kernel.org>
References: <20190215021121.177674-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xie Yongji <xieyongji@baidu.com>

[ Upstream commit e158488be27b157802753a59b336142dc0eb0380 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/locking/rwsem-xadd.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index 3064c50e181e..ef909357b84e 100644
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
-- 
2.19.1

