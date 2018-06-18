Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8F1C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BFCB20852
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:04:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BFCB20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967348AbeFRJEm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:04:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34308 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966639AbeFRIcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:32:12 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E5EC7C3C;
        Mon, 18 Jun 2018 08:32:11 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 069/189] blk-mq: fix sysfs inflight counter
Date:   Mon, 18 Jun 2018 10:12:45 +0200
Message-Id: <20180618081212.068747933@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618081209.254234434@linuxfoundation.org>
References: <20180618081209.254234434@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Omar Sandoval <osandov@fb.com>

[ Upstream commit bf0ddaba65ddbb2715af97041da8e7a45b2d8628 ]

When the blk-mq inflight implementation was added, /proc/diskstats was
converted to use it, but /sys/block/$dev/inflight was not. Fix it by
adding another helper to count in-flight requests by data direction.

Fixes: f299b7c7a9de ("blk-mq: provide internal in-flight variant")
Signed-off-by: Omar Sandoval <osandov@fb.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/blk-mq.c            |   19 +++++++++++++++++++
 block/blk-mq.h            |    4 +++-
 block/genhd.c             |   12 ++++++++++++
 block/partition-generic.c |   10 ++++++----
 include/linux/genhd.h     |    4 +++-
 5 files changed, 43 insertions(+), 6 deletions(-)

--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -118,6 +118,25 @@ void blk_mq_in_flight(struct request_que
 	blk_mq_queue_tag_busy_iter(q, blk_mq_check_inflight, &mi);
 }
 
+static void blk_mq_check_inflight_rw(struct blk_mq_hw_ctx *hctx,
+				     struct request *rq, void *priv,
+				     bool reserved)
+{
+	struct mq_inflight *mi = priv;
+
+	if (rq->part == mi->part)
+		mi->inflight[rq_data_dir(rq)]++;
+}
+
+void blk_mq_in_flight_rw(struct request_queue *q, struct hd_struct *part,
+			 unsigned int inflight[2])
+{
+	struct mq_inflight mi = { .part = part, .inflight = inflight, };
+
+	inflight[0] = inflight[1] = 0;
+	blk_mq_queue_tag_busy_iter(q, blk_mq_check_inflight_rw, &mi);
+}
+
 void blk_freeze_queue_start(struct request_queue *q)
 {
 	int freeze_depth;
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -136,6 +136,8 @@ static inline bool blk_mq_hw_queue_mappe
 }
 
 void blk_mq_in_flight(struct request_queue *q, struct hd_struct *part,
-			unsigned int inflight[2]);
+		      unsigned int inflight[2]);
+void blk_mq_in_flight_rw(struct request_queue *q, struct hd_struct *part,
+			 unsigned int inflight[2]);
 
 #endif
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -82,6 +82,18 @@ void part_in_flight(struct request_queue
 	}
 }
 
+void part_in_flight_rw(struct request_queue *q, struct hd_struct *part,
+		       unsigned int inflight[2])
+{
+	if (q->mq_ops) {
+		blk_mq_in_flight_rw(q, part, inflight);
+		return;
+	}
+
+	inflight[0] = atomic_read(&part->in_flight[0]);
+	inflight[1] = atomic_read(&part->in_flight[1]);
+}
+
 struct hd_struct *__disk_get_part(struct gendisk *disk, int partno)
 {
 	struct disk_part_tbl *ptbl = rcu_dereference(disk->part_tbl);
--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -145,13 +145,15 @@ ssize_t part_stat_show(struct device *de
 		jiffies_to_msecs(part_stat_read(p, time_in_queue)));
 }
 
-ssize_t part_inflight_show(struct device *dev,
-			struct device_attribute *attr, char *buf)
+ssize_t part_inflight_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
 {
 	struct hd_struct *p = dev_to_part(dev);
+	struct request_queue *q = part_to_disk(p)->queue;
+	unsigned int inflight[2];
 
-	return sprintf(buf, "%8u %8u\n", atomic_read(&p->in_flight[0]),
-		atomic_read(&p->in_flight[1]));
+	part_in_flight_rw(q, p, inflight);
+	return sprintf(buf, "%8u %8u\n", inflight[0], inflight[1]);
 }
 
 #ifdef CONFIG_FAIL_MAKE_REQUEST
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -365,7 +365,9 @@ static inline void free_part_stats(struc
 	part_stat_add(cpu, gendiskp, field, -subnd)
 
 void part_in_flight(struct request_queue *q, struct hd_struct *part,
-			unsigned int inflight[2]);
+		    unsigned int inflight[2]);
+void part_in_flight_rw(struct request_queue *q, struct hd_struct *part,
+		       unsigned int inflight[2]);
 void part_dec_in_flight(struct request_queue *q, struct hd_struct *part,
 			int rw);
 void part_inc_in_flight(struct request_queue *q, struct hd_struct *part,


