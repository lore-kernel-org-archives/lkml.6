Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE9FECE568
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 10:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AE8120C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 10:20:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AE8120C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729569AbeIRPwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 11:52:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51344 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726768AbeIRPwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 11:52:08 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4DC37307D911;
        Tue, 18 Sep 2018 10:20:13 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B75442015AC0;
        Tue, 18 Sep 2018 10:20:08 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>, Tejun Heo <tj@kernel.org>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-nvme@lists.infradead.org, Keith Busch <keith.busch@intel.com>
Subject: [PATCH 3/4] blk-mq: introduce blk_mq_unfreeze_queue_no_drain_io
Date:   Tue, 18 Sep 2018 18:19:45 +0800
Message-Id: <20180918101946.13329-4-ming.lei@redhat.com>
In-Reply-To: <20180918101946.13329-1-ming.lei@redhat.com>
References: <20180918101946.13329-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.25
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Tue, 18 Sep 2018 10:20:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces blk_mq_unfreeze_queue_no_drain_io() so that
it can be used when no necessary to check if IO is drained, such
as nvme pci resetting(nvme_reset_work).

Cc: Tejun Heo <tj@kernel.org>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Kent Overstreet <kent.overstreet@gmail.com>
Cc: linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Cc: Keith Busch <keith.busch@intel.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c         | 25 +++++++++++++++++++++++--
 include/linux/blk-mq.h |  1 +
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 85a1c1a59c72..a22f82061b93 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -191,20 +191,41 @@ void blk_mq_freeze_queue(struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(blk_mq_freeze_queue);
 
-void blk_mq_unfreeze_queue(struct request_queue *q)
+static void __blk_mq_unfreeze_queue(struct request_queue *q,
+		bool need_drop_zero)
 {
 	int freeze_depth;
 
 	freeze_depth = atomic_dec_return(&q->mq_freeze_depth);
 	WARN_ON_ONCE(freeze_depth < 0);
 	if (!freeze_depth) {
-		percpu_ref_reinit(&q->q_usage_counter);
+		if (need_drop_zero)
+			percpu_ref_reinit(&q->q_usage_counter);
+		else
+			percpu_ref_resurge(&q->q_usage_counter);
 		wake_up_all(&q->mq_freeze_wq);
 	}
 }
+
+void blk_mq_unfreeze_queue(struct request_queue *q)
+{
+	__blk_mq_unfreeze_queue(q, true);
+}
 EXPORT_SYMBOL_GPL(blk_mq_unfreeze_queue);
 
 /*
+ * Compared with blk_mq_unfreeze_queue(), the verion of _no_drain_io
+ * doesn't require the queue is really frozen, and it is useful in
+ * case of timeout handling in which IO can't be drained and has to
+ * be retried after controler is recovered.
+ */
+void blk_mq_unfreeze_queue_no_drain_io(struct request_queue *q)
+{
+	__blk_mq_unfreeze_queue(q, false);
+}
+EXPORT_SYMBOL_GPL(blk_mq_unfreeze_queue_no_drain_io);
+
+/*
  * FIXME: replace the scsi_internal_device_*block_nowait() calls in the
  * mpt3sas driver such that this function can be removed.
  */
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 1da59c16f637..5e0740ec407f 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -279,6 +279,7 @@ void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 		busy_tag_iter_fn *fn, void *priv);
 void blk_mq_freeze_queue(struct request_queue *q);
 void blk_mq_unfreeze_queue(struct request_queue *q);
+void blk_mq_unfreeze_queue_no_drain_io(struct request_queue *q);
 void blk_freeze_queue_start(struct request_queue *q);
 void blk_mq_freeze_queue_wait(struct request_queue *q);
 int blk_mq_freeze_queue_wait_timeout(struct request_queue *q,
-- 
2.9.5

