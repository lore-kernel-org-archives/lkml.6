Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BEB2C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01CE32086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EXhn4ZwT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01CE32086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbeJLRhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 13:37:16 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33328 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728151AbeJLRhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 13:37:16 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9CA4L86011762;
        Fri, 12 Oct 2018 10:05:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=vN7PK2lAoJpD3Cyz91jtauhT5WQYU6XRTXSy5Z3vhf4=;
 b=EXhn4ZwTMnmyUN8buVHsRCJ+Etn3OwN5ofrFTSo1zTXNnv4o2SVVgvwxN6PQN+R52S1/
 MwFO2pvf7GFuuadl/occh3c72RahPHrnRuIdQr2k2tW/M3rs/uIIdLclK7PT+S3XTTTJ
 27xIqjytvOFvNCbNi3UvjXs1dWwiTfRwKw42TaainVxv0uH1NgdL17nrj4AzNpd85h5c
 ASXFJz5ygFIL2ONwVVCpagNwFhoSm+8jOJnyD3MzePArFZIoNh580VTRvajTdSWEk2BT
 0sn6HF9hBFGYWa0i6tP5srl0SHrR2P9B1SYoaMeGlLqujS9CzfjtA3OMNtK6+lFVzmkN kg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2mxn0qhqqd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Oct 2018 10:05:33 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9CA5WRI014919
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Oct 2018 10:05:32 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9CA5W4D016623;
        Fri, 12 Oct 2018 10:05:32 GMT
Received: from will-ThinkCentre-M910s.cn.oracle.com (/10.182.70.254)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 12 Oct 2018 10:05:32 +0000
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     keith.busch@linux.intel.com, ming.lei@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 4/4] blk-mq: fallback to previous nr_hw_queues when updating fails
Date:   Fri, 12 Oct 2018 18:07:28 +0800
Message-Id: <1539338848-1789-5-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539338848-1789-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1539338848-1789-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9043 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=824
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810120101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we try to increate the nr_hw_queues, we may fail due to
shortage of memory or other reason, then blk_mq_realloc_hw_ctxs stops
and some entries in q->queue_hw_ctx are left with NULL. However,
because queue map has been updated with new nr_hw_queues, some cpus
have been mapped to hw queue which just encounters allocation failure,
thus blk_mq_map_queue could return NULL. This will cause panic in
following blk_mq_map_swqueue.

To fix it, when increase nr_hw_queues fails, fallback to previous
nr_hw_queues and post warning. At the same time, driver's .map_queues
usually use completion irq affinity to map hw and cpu, fallback
nr_hw_queues will cause lack of some cpu's map to hw, so use default
blk_mq_map_queues to do that.

Reported-by: syzbot+83e8cbe702263932d9d4@syzkaller.appspotmail.com
Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-mq.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 34f3973..d2ce67a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2540,7 +2540,7 @@ static struct blk_mq_hw_ctx *blk_mq_alloc_and_init_hctx(
 static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 						struct request_queue *q)
 {
-	int i, j;
+	int i, j, end;
 	struct blk_mq_hw_ctx **hctxs = q->queue_hw_ctx;
 
 	/* protect against switching io scheduler  */
@@ -2574,8 +2574,20 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 				break;
 		}
 	}
+	/*
+	 * Increasing nr_hw_queues fails. Free the newly allocated
+	 * hctxs and keep the previous q->nr_hw_queues.
+	 */
+	if (i != set->nr_hw_queues) {
+		j = q->nr_hw_queues;
+		end = i;
+	} else {
+		j = i;
+		end = q->nr_hw_queues;
+		q->nr_hw_queues = set->nr_hw_queues;
+	}
 
-	for (j = i; j < q->nr_hw_queues; j++) {
+	for (; j < end; j++) {
 		struct blk_mq_hw_ctx *hctx = hctxs[j];
 
 		if (hctx) {
@@ -2587,7 +2599,6 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 
 		}
 	}
-	q->nr_hw_queues = i;
 	mutex_unlock(&q->sysfs_lock);
 }
 
@@ -2972,6 +2983,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 {
 	struct request_queue *q;
 	LIST_HEAD(head);
+	int prev_nr_hw_queues;
 
 	lockdep_assert_held(&set->tag_list_lock);
 
@@ -3000,10 +3012,19 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 		blk_mq_sysfs_unregister(q);
 	}
 
+	prev_nr_hw_queues = set->nr_hw_queues;
 	set->nr_hw_queues = nr_hw_queues;
 	blk_mq_update_queue_map(set);
+fallback:
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
 		blk_mq_realloc_hw_ctxs(set, q);
+		if (q->nr_hw_queues != set->nr_hw_queues) {
+			pr_warn("Increasing nr_hw_queues to %d fails, fallback to %d\n",
+					nr_hw_queues, prev_nr_hw_queues);
+			set->nr_hw_queues = prev_nr_hw_queues;
+			blk_mq_map_queues(set);
+			goto fallback;
+		}
 		blk_mq_map_swqueue(q);
 	}
 
-- 
2.7.4

