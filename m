Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B10C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 12:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AA7020834
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 12:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GiHZmoCe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AA7020834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbeK2Xzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 18:55:50 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35564 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbeK2Xzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 18:55:49 -0500
Received: by mail-pf1-f196.google.com with SMTP id z9so977645pfi.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 04:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ND9ZMiFSs7gvb+oNn4AdICkUx/3oAt1Y/vutGLYwcH4=;
        b=GiHZmoCeUOvh+Ct/FMVj+KG2u4GTk6Mn6spQbmiuO6aQpiTZkM5n+M+/MKzgLSHpyw
         NauwfrpiS9V3tFLnZIFOPY+GkBratWag8FChqpsdPEE/hBl6ZKTDOTp/n2W0YsKo9p5t
         vAfC6rIbn/Gw1Yywll8P32WPGqdC+wSD/CyjJbSoIEKY7Inj4CgtPp5QVqYxxkh3slJR
         PwKwa8cKMGFD1zJxuQXGu2/+2D4KbVULJvIkaGZcx5ffoTMhZYEAjW3aHEDTR0vJZrAJ
         MA267UuQgWy5Waq4Bzl7wgDQhnHt3+JG1d/RmoG8tx19CwHCZF1YjUSvV+iecQOOyk46
         V7zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ND9ZMiFSs7gvb+oNn4AdICkUx/3oAt1Y/vutGLYwcH4=;
        b=a0Rs5/PhqZVdNqWUQHWV1cfcWgjTpf72u0uTR1nQPX/g1J5p9yUnJCQLQwnQiTy1Z3
         /p62k6j8nqPrxLEkWZ2SHC9UNzKV79Lny4kLw/DEeaB2TuXNVNAx8CTFL19SqfCaPdU/
         vhLk7cl+qX+yX9H8JbrNZsZd1Mc8T7wt3SVIZdI+uVs07tRSTQaqtZA5GD1KyayDdcO7
         XG18W5RXGN6dIJO6wcDBrCtgqe9xzwnjlHfEwTS81eno9jlre/HfW4fKen3AQt/UUdj4
         rhpr9P1un5YkaJAf08O23ArDorTcLrkOz0lKItrklN2lowCJ0Ji+stZCU/vQUc+wSzsz
         CsxQ==
X-Gm-Message-State: AA+aEWaGEhwOJaYeN0OlTFkQQB9KpHszxlC2fXj2yi54AuJ5waAEUeoq
        a4jIjYgr05YsZurnYSxx6SQ=
X-Google-Smtp-Source: AFSGD/UHkUP+zw7ZHo4Nr1L3aq/IfE03IP3vAkb0BOkF1JzTiju9rNtXSYM2bee2Kyfv2Mo67Eaarg==
X-Received: by 2002:a63:d818:: with SMTP id b24mr1116272pgh.174.1543495833760;
        Thu, 29 Nov 2018 04:50:33 -0800 (PST)
Received: from localhost ([101.93.171.187])
        by smtp.gmail.com with ESMTPSA id n186sm5287399pfn.137.2018.11.29.04.50.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 29 Nov 2018 04:50:33 -0800 (PST)
From:   Yongji Xie <elohimes@gmail.com>
X-Google-Original-From: Yongji Xie <xieyongji@baidu.com>
To:     peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com
Cc:     linux-kernel@vger.kernel.org, xieyongji@baidu.com,
        zhangyu31@baidu.com, liuqi16@baidu.com, yuanlinsi01@baidu.com,
        nixun@baidu.com, lilin24@baidu.com
Subject: [RFC] locking/rwsem: Avoid issuing wakeup before setting the reader waiter to nil
Date:   Thu, 29 Nov 2018 20:50:30 +0800
Message-Id: <1543495830-2644-1-git-send-email-xieyongji@baidu.com>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xie Yongji <xieyongji@baidu.com>

Our system encountered a problem recently, the khungtaskd detected
some process hang on mmap_sem. But the odd thing was that one task which
is not on mmap_sem.wait_list still sleeps in rwsem_down_read_failed().
Through code inspection, we found a potential bug can lead to this.

Imaging this:

Thread 1                                  Thread 2
                                          down_write();
rwsem_down_read_failed()
 raw_spin_lock_irq(&sem->wait_lock);
 list_add_tail(&waiter.list, &wait_list);
 raw_spin_unlock_irq(&sem->wait_lock);
                                          __up_write();
                                           rwsem_wake();
                                            __rwsem_mark_wake();
                                             wake_q_add();
                                             list_del(&waiter->list);
                                             waiter->task = NULL;
 while (true) {
  set_current_state(TASK_UNINTERRUPTIBLE);
  if (!waiter.task) // true
      break;
 }
 __set_current_state(TASK_RUNNING);

Now Thread 1 is queued in Thread 2's wake_q without sleeping. Then
Thread 1 call rwsem_down_read_failed() again because Thread 3
hold the lock, if Thread 3 tries to queue Thread 1 before Thread 2
do wakeup, it will fail and miss wakeup:

Thread 1                                  Thread 2      Thread 3
                                                        down_write();
rwsem_down_read_failed()
 raw_spin_lock_irq(&sem->wait_lock);
 list_add_tail(&waiter.list, &wait_list);
 raw_spin_unlock_irq(&sem->wait_lock);
                                                        __rwsem_mark_wake();
                                                         wake_q_add();
                                          wake_up_q();
                                                         waiter->task = NULL;
 while (true) {
  set_current_state(TASK_UNINTERRUPTIBLE);
  if (!waiter.task) // false
      break;
  schedule();
 }
                                                        wake_up_q(&wake_q);

In another word, that means we might issue the wakeup before setting the reader
waiter to nil. If so, the wakeup may do nothing when it was called before reader
set task state to TASK_UNINTERRUPTIBLE. Then we would have no chance to wake up
the reader any more, and cause other writers such as "ps" command stuck on it.

This patch is not verified because we still have no way to reproduce the problem.
But I'd like to ask for some comments from community firstly.

Signed-off-by: Xie Yongji <xieyongji@baidu.com>
Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
---
 kernel/locking/rwsem-xadd.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index 09b1800..50d9af6 100644
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
2.2.3

