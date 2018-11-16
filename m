Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FC7C43610
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 00:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2B362146D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 00:27:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2B362146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389256AbeKPKhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 05:37:42 -0500
Received: from smtp2.provo.novell.com ([137.65.250.81]:39791 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbeKPKhk (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Fri, 16 Nov 2018 05:37:40 -0500
Received: from linux-r8p5.psav.com (prv-ext-foundry1int.gns.novell.com [137.65.251.240])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Thu, 15 Nov 2018 17:27:22 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     akpm@linux-foundation.org
Cc:     dave@stgolabs.net, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@kernel.org
Subject: [PATCH 2/6] kernel/sched: Remove caller signal_pending branch predictions
Date:   Thu, 15 Nov 2018 16:27:09 -0800
Message-Id: <20181116002713.8474-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181116002713.8474-1-dave@stgolabs.net>
References: <20181116002713.8474-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is already done for us internally by the signal machinery.

Cc: peterz@infradead.org
Cc: mingo@kernel.org
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 kernel/sched/core.c  | 2 +-
 kernel/sched/swait.c | 2 +-
 kernel/sched/wait.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f12225f26b70..1972b4c63a1f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3416,7 +3416,7 @@ static void __sched notrace __schedule(bool preempt)
 
 	switch_count = &prev->nivcsw;
 	if (!preempt && prev->state) {
-		if (unlikely(signal_pending_state(prev->state, prev))) {
+		if (signal_pending_state(prev->state, prev)) {
 			prev->state = TASK_RUNNING;
 		} else {
 			deactivate_task(rq, prev, DEQUEUE_SLEEP | DEQUEUE_NOCLOCK);
diff --git a/kernel/sched/swait.c b/kernel/sched/swait.c
index 66b59ac77c22..e83a3f8449f6 100644
--- a/kernel/sched/swait.c
+++ b/kernel/sched/swait.c
@@ -93,7 +93,7 @@ long prepare_to_swait_event(struct swait_queue_head *q, struct swait_queue *wait
 	long ret = 0;
 
 	raw_spin_lock_irqsave(&q->lock, flags);
-	if (unlikely(signal_pending_state(state, current))) {
+	if (signal_pending_state(state, current)) {
 		/*
 		 * See prepare_to_wait_event(). TL;DR, subsequent swake_up_one()
 		 * must not see us.
diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
index 5dd47f1103d1..6eb1f8efd221 100644
--- a/kernel/sched/wait.c
+++ b/kernel/sched/wait.c
@@ -264,7 +264,7 @@ long prepare_to_wait_event(struct wait_queue_head *wq_head, struct wait_queue_en
 	long ret = 0;
 
 	spin_lock_irqsave(&wq_head->lock, flags);
-	if (unlikely(signal_pending_state(state, current))) {
+	if (signal_pending_state(state, current)) {
 		/*
 		 * Exclusive waiter must not fail if it was selected by wakeup,
 		 * it should "consume" the condition we were waiting for.
-- 
2.16.4

