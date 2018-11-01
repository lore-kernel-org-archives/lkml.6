Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C374BC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 17:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64C9720657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 17:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="Wu5MwlM+";
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="Wu5MwlM+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64C9720657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbeKBCrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 22:47:22 -0400
Received: from forwardcorp1o.cmail.yandex.net ([37.9.109.47]:51861 "EHLO
        forwardcorp1o.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726920AbeKBCrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 22:47:22 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1o.cmail.yandex.net (Yandex) with ESMTP id 3AB7520F2A;
        Thu,  1 Nov 2018 20:43:21 +0300 (MSK)
Received: from smtpcorp1p.mail.yandex.net (smtpcorp1p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:10])
        by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id l7sU8JusKv-hLlKTlNO;
        Thu, 01 Nov 2018 20:43:21 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1541094201; bh=WJ5c48aXX0lt9gkCx3FK1rT+2cn7DCwznIcr0gN5EnA=;
        h=Subject:From:To:Date:Message-ID;
        b=Wu5MwlM+s47hsCABDHTdd1lIJJX6W25w43AxXH+cpxu7uf74jFDiRIipNGZXOyexh
         9PG4kI6OLkweLK2NG0L6AjB6ZTuAt/P2JkS5fGo5TFwosURNp0RcT9ITl+fNqTjolr
         skGqt10XyFuG1NCy8/3uhcQ08Rvm6DvRMo6jkYF8=
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:2501:1cc0:44e4:e39a])
        by smtpcorp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 4xKAVzv1Pr-hKJiFEPX;
        Thu, 01 Nov 2018 20:43:20 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1541094201; bh=WJ5c48aXX0lt9gkCx3FK1rT+2cn7DCwznIcr0gN5EnA=;
        h=Subject:From:To:Date:Message-ID;
        b=Wu5MwlM+s47hsCABDHTdd1lIJJX6W25w43AxXH+cpxu7uf74jFDiRIipNGZXOyexh
         9PG4kI6OLkweLK2NG0L6AjB6ZTuAt/P2JkS5fGo5TFwosURNp0RcT9ITl+fNqTjolr
         skGqt10XyFuG1NCy8/3uhcQ08Rvm6DvRMo6jkYF8=
Authentication-Results: smtpcorp1p.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Subject: [PATCH RFC] blk-mq: initialize default elevator after probing
 device features
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Paolo Valente <paolo.valente@linaro.org>,
        linux-kernel@vger.kernel.org
Date:   Thu, 01 Nov 2018 20:43:18 +0300
Message-ID: <154109419854.925678.9824971245018007905.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For SATA and SCSI devices features like rotational/non-rotational flag
are detected via requests to VPD pages in asynchronous probe.
During probing queue works in bypass mode without using elevator.

This patch postpones initialization of elevator to use this information
for choosing default elevator or its default configuration.

Old stack theoretically could do the same but it has some paths where
q->elevator expected to be always non-null regardless of bypass mode.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 block/blk-mq.c    |    8 --------
 block/blk-sysfs.c |   11 +++++++++++
 block/elevator.c  |   18 +++++++++---------
 3 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3f91c6e5b17a..889797b4313e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2719,14 +2719,6 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	blk_mq_add_queue_tag_set(set, q);
 	blk_mq_map_swqueue(q);
 
-	if (!(set->flags & BLK_MQ_F_NO_SCHED)) {
-		int ret;
-
-		ret = elevator_init_mq(q);
-		if (ret)
-			return ERR_PTR(ret);
-	}
-
 	return q;
 
 err_hctxs:
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 0641533597f1..201ef5b69ace 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -909,6 +909,17 @@ int blk_register_queue(struct gendisk *disk)
 	WARN_ONCE(test_bit(QUEUE_FLAG_REGISTERED, &q->queue_flags),
 		  "%s is registering an already registered queue\n",
 		  kobject_name(&dev->kobj));
+
+	/*
+	 * Initialize default elevator after probing device features.
+	 */
+	if (q->mq_ops) {
+		WARN_ON_ONCE(!blk_queue_bypass(q));
+		ret = elevator_init_mq(q);
+		if (ret)
+			return ret;
+	}
+
 	queue_flag_set_unlocked(QUEUE_FLAG_REGISTERED, q);
 
 	/*
diff --git a/block/elevator.c b/block/elevator.c
index 8fdcd64ae12e..953c8ca4f5bf 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -172,6 +172,14 @@ void __init load_default_elevator_module(void)
 
 static struct kobj_type elv_ktype;
 
+static inline bool elv_support_iosched(struct request_queue *q)
+{
+	if (q->mq_ops && q->tag_set && (q->tag_set->flags &
+				BLK_MQ_F_NO_SCHED))
+		return false;
+	return true;
+}
+
 struct elevator_queue *elevator_alloc(struct request_queue *q,
 				  struct elevator_type *e)
 {
@@ -957,7 +965,7 @@ int elevator_init_mq(struct request_queue *q)
 	struct elevator_type *e;
 	int err = 0;
 
-	if (q->nr_hw_queues != 1)
+	if (q->nr_hw_queues != 1 || !elv_support_iosched(q))
 		return 0;
 
 	/*
@@ -1089,14 +1097,6 @@ static int __elevator_change(struct request_queue *q, const char *name)
 	return elevator_switch(q, e);
 }
 
-static inline bool elv_support_iosched(struct request_queue *q)
-{
-	if (q->mq_ops && q->tag_set && (q->tag_set->flags &
-				BLK_MQ_F_NO_SCHED))
-		return false;
-	return true;
-}
-
 ssize_t elv_iosched_store(struct request_queue *q, const char *name,
 			  size_t count)
 {

