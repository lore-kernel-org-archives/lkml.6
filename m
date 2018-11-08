Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA27C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 05:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 885992086A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 05:52:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 885992086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbeKHP0L convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 10:26:11 -0500
Received: from out1.zte.com.cn ([202.103.147.172]:34698 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbeKHP0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 10:26:11 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id BB3701629166CD38F03A;
        Thu,  8 Nov 2018 13:52:20 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id wA85qE6H032454;
        Thu, 8 Nov 2018 13:52:14 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018110813524340-9360779 ;
          Thu, 8 Nov 2018 13:52:43 +0800 
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        zhong.weidong@zte.com.cn, Yi Wang <wang.yi59@zte.com.cn>
Subject: [PATCH] sched/fair: make some function static
Date:   Thu, 8 Nov 2018 13:54:12 +0800
Message-Id: <1541656452-3326-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-11-08 13:52:43,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-11-08 13:52:02
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-MAIL: mse01.zte.com.cn wA85qE6H032454
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make some function static as they are not used outside of fair.c.

This fixes the following warning when building with 'W=1':

kernel/sched/fair.c:2439:6: warning: no previous prototype for ‘task_numa_work’ [-Wmissing-prototypes]
kernel/sched/fair.c:2584:6: warning: no previous prototype for ‘task_tick_numa’ [-Wmissing-prototypes]
kernel/sched/fair.c:3548:6: warning: no previous prototype for ‘sync_entity_load_avg’ [-Wmissing-prototypes]
kernel/sched/fair.c:3561:6: warning: no previous prototype for ‘remove_entity_load_avg’ [-Wmissing-prototypes]

Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
---
 kernel/sched/fair.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ee271bb..615e168 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2436,7 +2436,7 @@ static void reset_ptenuma_scan(struct task_struct *p)
  * The expensive part of numa migration is done from task_work context.
  * Triggered from task_tick_numa().
  */
-void task_numa_work(struct callback_head *work)
+static void task_numa_work(struct callback_head *work)
 {
 	unsigned long migrate, next_scan, now = jiffies;
 	struct task_struct *p = current;
@@ -2581,7 +2581,7 @@ void task_numa_work(struct callback_head *work)
 /*
  * Drive the periodic memory faults..
  */
-void task_tick_numa(struct rq *rq, struct task_struct *curr)
+static void task_tick_numa(struct rq *rq, struct task_struct *curr)
 {
 	struct callback_head *work = &curr->numa_work;
 	u64 period, now;
@@ -3545,7 +3545,7 @@ static inline u64 cfs_rq_last_update_time(struct cfs_rq *cfs_rq)
  * Synchronize entity load avg of dequeued entity without locking
  * the previous rq.
  */
-void sync_entity_load_avg(struct sched_entity *se)
+static void sync_entity_load_avg(struct sched_entity *se)
 {
 	struct cfs_rq *cfs_rq = cfs_rq_of(se);
 	u64 last_update_time;
@@ -3558,7 +3558,7 @@ void sync_entity_load_avg(struct sched_entity *se)
  * Task first catches up with cfs_rq, and then subtract
  * itself from the cfs_rq (task must be off the queue now).
  */
-void remove_entity_load_avg(struct sched_entity *se)
+static void remove_entity_load_avg(struct sched_entity *se)
 {
 	struct cfs_rq *cfs_rq = cfs_rq_of(se);
 	unsigned long flags;
-- 
1.8.3.1

