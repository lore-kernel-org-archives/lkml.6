Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C3D4C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 13:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B6422075E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 13:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="4RHG4iOl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B6422075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730378AbeHWQho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 12:37:44 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43476 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729666AbeHWQhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 12:37:43 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7ND46qX108517;
        Thu, 23 Aug 2018 13:08:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=b9P4qMPnN5+PTRBuHANPAW1odLAUitAbtUj9IoJJJ9s=;
 b=4RHG4iOl5fYqMrJD8q1LCAfN1arXc8BAYJ5+oPslv+T+VbXZlQoKcp1NOflKqWs0yhRf
 hULU6JerDUejpUqyff8ftM+X+2C0oBSLVB8wxNATCQz1aYy2x0Q9U5GT2tzz6AHoDYd8
 TTFB2tGjHEoee33P2DA31lxIi5tDGo4l8X+UYXwXZ8NdkfYyPz/OyigMO57ZcNM6uZJ4
 PGwG0G6XOtCYAqTF+8AEMa08cFFISKjVRFPl7+l3aa7l4OlMdh9LhIZ+SqwkUOx/BxSo
 bsamPFnMKuJr6UQzAuIJvLGSH7f0k8ehDmWQQ1YruhijaEw91p9mSWmFds2MvvSbktRi 1Q== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2kxc3r1913-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Aug 2018 13:08:03 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w7ND82nG016415
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Aug 2018 13:08:02 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7ND82Ds004129;
        Thu, 23 Aug 2018 13:08:02 GMT
Received: from will-ThinkPad-L470.jp.oracle.com (/10.191.28.107)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 23 Aug 2018 06:08:01 -0700
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] blk-wbt: get back the missed wakeup from __wbt_done
Date:   Thu, 23 Aug 2018 21:08:38 +0800
Message-Id: <1535029718-17259-1-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8993 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808230139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2887e41 (blk-wbt: Avoid lock contention and thundering herd
issue in wbt_wait) introduces two cases that could miss wakeup:
 - __wbt_done only wakes up one waiter one time. There could be
   multiple waiters and (limit - inflight) > 1 at the moment.

 - When the waiter is waked up, it is still on wait queue and set
   to TASK_UNINTERRUPTIBLE immediately, so this waiter could be
   waked up one more time. If a __wbt_done comes and wakes up
   again, the prevous waiter may waste a wakeup.

To fix them and avoid to introduce too much lock contention, we
introduce our own wake up func wbt_wake_function in __wbt_wait and
use wake_up_all in __wbt_done. wbt_wake_function will try to get
wbt budget firstly, if sucesses, wake up the process, otherwise,
return -1 to interrupt the wake up loop.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
Fixes: 2887e41 (blk-wbt: Avoid lock contention and thundering herd issue in wbt_wait)
Cc: Anchal Agarwal <anchalag@amazon.com>
Cc: Frank van der Linden <fllinden@amazon.com>
---
 block/blk-wbt.c | 78 +++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 54 insertions(+), 24 deletions(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index c9358f1..2667590 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -166,7 +166,7 @@ static void __wbt_done(struct rq_qos *rqos, enum wbt_flags wb_acct)
 		int diff = limit - inflight;
 
 		if (!inflight || diff >= rwb->wb_background / 2)
-			wake_up(&rqw->wait);
+			wake_up_all(&rqw->wait);
 	}
 }
 
@@ -481,6 +481,40 @@ static inline unsigned int get_limit(struct rq_wb *rwb, unsigned long rw)
 	return limit;
 }
 
+struct wbt_wait_data {
+	struct task_struct *curr;
+	struct rq_wb *rwb;
+	struct rq_wait *rqw;
+	unsigned long rw;
+};
+
+static int wbt_wake_function(wait_queue_entry_t *curr, unsigned int mode,
+		int wake_flags, void *key)
+{
+	struct wbt_wait_data *data = curr->private;
+
+	/*
+	 * If fail to get budget, return -1 to interrupt the wake up
+	 * loop in __wake_up_common.
+	 */
+	if (!rq_wait_inc_below(data->rqw, get_limit(data->rwb, data->rw)))
+		return -1;
+
+	wake_up_process(data->curr);
+
+	list_del_init(&curr->entry);
+	return 1;
+}
+
+static inline void wbt_init_wait(struct wait_queue_entry *wait,
+		struct wbt_wait_data *data)
+{
+	INIT_LIST_HEAD(&wait->entry);
+	wait->flags = 0;
+	wait->func = wbt_wake_function;
+	wait->private = data;
+}
+
 /*
  * Block if we will exceed our limit, or if we are currently waiting for
  * the timer to kick off queuing again.
@@ -491,31 +525,27 @@ static void __wbt_wait(struct rq_wb *rwb, enum wbt_flags wb_acct,
 	__acquires(lock)
 {
 	struct rq_wait *rqw = get_rq_wait(rwb, wb_acct);
-	DECLARE_WAITQUEUE(wait, current);
-	bool has_sleeper;
-
-	has_sleeper = wq_has_sleeper(&rqw->wait);
-	if (!has_sleeper && rq_wait_inc_below(rqw, get_limit(rwb, rw)))
+	struct wait_queue_entry wait;
+	struct wbt_wait_data data = {
+		.curr = current,
+		.rwb = rwb,
+		.rqw = rqw,
+		.rw = rw,
+	};
+
+	if (!wq_has_sleeper(&rqw->wait) &&
+			rq_wait_inc_below(rqw, get_limit(rwb, rw)))
 		return;
 
-	add_wait_queue_exclusive(&rqw->wait, &wait);
-	do {
-		set_current_state(TASK_UNINTERRUPTIBLE);
-
-		if (!has_sleeper && rq_wait_inc_below(rqw, get_limit(rwb, rw)))
-			break;
-
-		if (lock) {
-			spin_unlock_irq(lock);
-			io_schedule();
-			spin_lock_irq(lock);
-		} else
-			io_schedule();
-		has_sleeper = false;
-	} while (1);
-
-	__set_current_state(TASK_RUNNING);
-	remove_wait_queue(&rqw->wait, &wait);
+	wbt_init_wait(&wait, &data);
+	prepare_to_wait_exclusive(&rqw->wait, &wait,
+			TASK_UNINTERRUPTIBLE);
+	if (lock) {
+		spin_unlock_irq(lock);
+		io_schedule();
+		spin_lock_irq(lock);
+	} else
+		io_schedule();
 }
 
 static inline bool wbt_should_throttle(struct rq_wb *rwb, struct bio *bio)
-- 
2.7.4

