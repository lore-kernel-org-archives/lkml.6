Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AB3C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 07:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C72320BED
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 07:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bM18WWme"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C72320BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbeHTKdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 06:33:10 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:38104 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbeHTKdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 06:33:09 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7K7EbNC134525;
        Mon, 20 Aug 2018 07:18:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=/erQVj2OuLQaiOvECruaHMrCKELSOd6x2WCnj8nma8c=;
 b=bM18WWmegryqhHVbc4OJ+rBrpFKyLfsTjp3L2/PwNKn+cZqx6Nk9umGXXqLDj8kjWn3Q
 1qI12r8s/1fhRPJY1DfdD3SgyXgc5olcrsesOnZ7WIj+Qop8L+l0eZRI8Q+lxcLIR6bj
 //HQ+IVzQ7IhJ44391hnqtJmtvztfihL23hODBMel8cZULLbB4D0PRIAL3W5MyJqE8wm
 Wi37NVFeRZbTMyQgR5QgeEbghAvGL1SrZiZRFfn2AQbTamVfdFgPacXlqpKRI3KINj9e
 60OONzotDSdHTY9/9BrOYedrSN65GbIjgfqv2VijnrKA/fHwFNaDbLF1W4Sf1ARST+U+ hw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2kxbdpmm4u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Aug 2018 07:18:36 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w7K7IZ15027440
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Aug 2018 07:18:35 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7K7IYVF014639;
        Mon, 20 Aug 2018 07:18:34 GMT
Received: from will-ThinkCentre-M910s.cn.oracle.com (/10.182.70.254)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 20 Aug 2018 00:18:34 -0700
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     tom.leiming@gmail.com, bart.vanassche@wdc.com,
        keith.busch@linux.intel.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 2/2] blk-mq: sync the update nr_hw_queues with blk_mq_queue_tag_busy_iter
Date:   Mon, 20 Aug 2018 15:20:06 +0800
Message-Id: <1534749606-7311-3-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534749606-7311-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1534749606-7311-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8990 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808200079
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For blk-mq, part_in_flight/rw will invoke blk_mq_in_flight/rw to
account the inflight requests. It will access the queue_hw_ctx and
nr_hw_queues w/o any protection. When updating nr_hw_queues and
blk_mq_in_flight/rw occur concurrently, panic comes up.

Before update nr_hw_queues, the q will be frozen. So we could use
q_usage_counter to avoid the race. percpu_ref_is_zero is used here
so that we will not miss any in-flight request. The access to
nr_hw_queues and queue_hw_ctx in blk_mq_queue_tag_busy_iter are
under rcu critical section, __blk_mq_update_nr_hw_queues could use
synchronize_rcu to ensure the zeroed q_usage_counter to be globally
visible.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-mq-tag.c | 14 +++++++++++++-
 block/blk-mq.c     |  5 ++++-
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index c0c4e63..8c5cc11 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -320,6 +320,18 @@ void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
 	struct blk_mq_hw_ctx *hctx;
 	int i;
 
+	/*
+	 * __blk_mq_update_nr_hw_queues will update the nr_hw_queues and
+	 * queue_hw_ctx after freeze the queue. So we could use q_usage_counter
+	 * to avoid race with it. __blk_mq_update_nr_hw_queues will users
+	 * synchronize_rcu to ensure all of the users go out of the critical
+	 * section below and see zeroed q_usage_counter.
+	 */
+	rcu_read_lock();
+	if (percpu_ref_is_zero(&q->q_usage_counter)) {
+		rcu_read_unlock();
+		return;
+	}
 
 	queue_for_each_hw_ctx(q, hctx, i) {
 		struct blk_mq_tags *tags = hctx->tags;
@@ -335,7 +347,7 @@ void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
 			bt_for_each(hctx, &tags->breserved_tags, fn, priv, true);
 		bt_for_each(hctx, &tags->bitmap_tags, fn, priv, false);
 	}
-
+	rcu_read_unlock();
 }
 
 static int bt_alloc(struct sbitmap_queue *bt, unsigned int depth,
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 7b99477..fb56bae 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2905,7 +2905,10 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 
 	list_for_each_entry(q, &set->tag_list, tag_set_list)
 		blk_mq_freeze_queue(q);
-
+	/*
+	 * Sync with blk_mq_in_flight and blk_mq_queue_tag_busy_iter.
+	 */
+	synchronize_rcu();
 	/*
 	 * switch io scheduler to NULL to clean up the data in it.
 	 * will get it back after update mapping between cpu and hw queues.
-- 
2.7.4

