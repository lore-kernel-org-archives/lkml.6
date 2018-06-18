Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9215EC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 579DC208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:19:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 579DC208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935466AbeFRIT2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:19:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54848 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935431AbeFRITT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:19:19 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 26118C7A;
        Mon, 18 Jun 2018 08:19:18 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiang Biao <jiang.biao2@zte.com.cn>,
        Wen Yang <wen.yang99@zte.com.cn>, Tejun Heo <tj@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 060/279] blkcg: init root blkcg_gq under lock
Date:   Mon, 18 Jun 2018 10:10:45 +0200
Message-Id: <20180618080611.318715435@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiang Biao <jiang.biao2@zte.com.cn>

[ Upstream commit 901932a3f9b2b80352896be946c6d577c0a9652c ]

The initializing of q->root_blkg is currently outside of queue lock
and rcu, so the blkg may be destroied before the initializing, which
may cause dangling/null references. On the other side, the destroys
of blkg are protected by queue lock or rcu. Put the initializing
inside the queue lock and rcu to make it safer.

Signed-off-by: Jiang Biao <jiang.biao2@zte.com.cn>
Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
CC: Tejun Heo <tj@kernel.org>
CC: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/blk-cgroup.c |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1142,18 +1142,16 @@ int blkcg_init_queue(struct request_queu
 	rcu_read_lock();
 	spin_lock_irq(q->queue_lock);
 	blkg = blkg_create(&blkcg_root, q, new_blkg);
+	if (IS_ERR(blkg))
+		goto err_unlock;
+	q->root_blkg = blkg;
+	q->root_rl.blkg = blkg;
 	spin_unlock_irq(q->queue_lock);
 	rcu_read_unlock();
 
 	if (preloaded)
 		radix_tree_preload_end();
 
-	if (IS_ERR(blkg))
-		return PTR_ERR(blkg);
-
-	q->root_blkg = blkg;
-	q->root_rl.blkg = blkg;
-
 	ret = blk_throtl_init(q);
 	if (ret) {
 		spin_lock_irq(q->queue_lock);
@@ -1161,6 +1159,13 @@ int blkcg_init_queue(struct request_queu
 		spin_unlock_irq(q->queue_lock);
 	}
 	return ret;
+
+err_unlock:
+	spin_unlock_irq(q->queue_lock);
+	rcu_read_unlock();
+	if (preloaded)
+		radix_tree_preload_end();
+	return PTR_ERR(blkg);
 }
 
 /**


