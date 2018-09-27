Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D27C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 10:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9DD321571
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 10:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V1L3wL9F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9DD321571
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbeI0Q66 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 12:58:58 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40218 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbeI0Q66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 12:58:58 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8RAdLc5180047;
        Thu, 27 Sep 2018 10:41:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=5/NiHPpH6FeSskyyYSQt5odXm1q++NojKsiyvpJn4A8=;
 b=V1L3wL9F/xj0pgtRocWmSuVvSBd0PDrYiVPr1TBt8ujm0uLa1++VBXHSdk3b+cKHFAnc
 F45gO5eRiXq1yLtfxExIUuTYN3gcS0ZM9L+qmMy8VWPrDahtOjr8Z0adDwP6D/AlRvbk
 H1brA9o1xZtZ4Psmkaza05khw4wWLicEPWWvGPlYfNSsSp9E5nHaKlW1uEX//vih3CY2
 666UR9dYVgpyoVELNPwKHpTk6b6wMmBqm4/BT7cqwF/0PiVohIL90HKpef9mUG3IvCQ4
 5AbQ13hs3SRiX+dWwodI6x+fJF8HUW591hq03bHZu7a6/3TrvAXNe0uR4DZrob3BszRx Zw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2mnd5ts9vs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Sep 2018 10:41:15 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8RAfFJN023187
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Sep 2018 10:41:15 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8RAfFfO021365;
        Thu, 27 Sep 2018 10:41:15 GMT
Received: from will-ThinkCentre-M910s.cn.oracle.com (/10.182.70.254)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 27 Sep 2018 03:41:14 -0700
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     keith.busch@linux.intel.com, ming.lei@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] blk-mq: fallback to previous nr_hw_queues when updating fails
Date:   Thu, 27 Sep 2018 18:43:04 +0800
Message-Id: <1538044984-2147-3-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538044984-2147-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1538044984-2147-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9028 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809270109
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

To fix it, let blk_mq_realloc_hw_ctxs return false to
skip blk_mq_map_swqueue and fallback to previous nr_hw_queues in
case of increasing nr_hw_queues failure.

Reported-by: syzbot+83e8cbe702263932d9d4@syzkaller.appspotmail.com
Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-mq.c | 40 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 6356455..c867ede 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2503,10 +2503,10 @@ static int blk_mq_hw_ctx_size(struct blk_mq_tag_set *tag_set)
 	return hw_ctx_size;
 }
 
-static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
+static bool blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 						struct request_queue *q)
 {
-	int i, j;
+	int i, j, end;
 	struct blk_mq_hw_ctx **hctxs = q->queue_hw_ctx;
 
 	/* protect against switching io scheduler  */
@@ -2542,7 +2542,24 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 		}
 		blk_mq_hctx_kobj_init(hctxs[i]);
 	}
-	for (j = i; j < q->nr_hw_queues; j++) {
+
+	if (i != set->nr_hw_queues) {
+		/*
+		 * Increasing nr_hw_queues fails. Free the newly allocated
+		 * hctxs and keep the previous q->nr_hw_queues.
+		 */
+		j = q->nr_hw_queues;
+		end = i;
+	} else {
+		/*
+		 * If nr_hw_queues is decreased, free the redundant hctxs.
+		 */
+		j = i;
+		end = q->nr_hw_queues;
+		q->nr_hw_queues = set->nr_hw_queues;
+	}
+
+	for (; j < end; j++) {
 		struct blk_mq_hw_ctx *hctx = hctxs[j];
 
 		if (hctx) {
@@ -2554,8 +2571,9 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 
 		}
 	}
-	q->nr_hw_queues = i;
 	mutex_unlock(&q->sysfs_lock);
+
+	return (q->nr_hw_queues == set->nr_hw_queues);
 }
 
 struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
@@ -2939,6 +2957,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 {
 	struct request_queue *q;
 	LIST_HEAD(head);
+	int prev_nr_hw_queues;
 
 	lockdep_assert_held(&set->tag_list_lock);
 
@@ -2967,10 +2986,21 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 		blk_mq_sysfs_unregister(q);
 	}
 
+	prev_nr_hw_queues = set->nr_hw_queues;
 	set->nr_hw_queues = nr_hw_queues;
+again:
 	blk_mq_update_queue_map(set);
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
-		blk_mq_realloc_hw_ctxs(set, q);
+		/*
+		 * If increasing nr_hw_queues fail, fallback to previous
+		 * nr_hw_queues.
+		 */
+		if (!blk_mq_realloc_hw_ctxs(set, q)) {
+			pr_warn("updating nr_hw_queues to %d fails, fallback to %d.\n",
+					nr_hw_queues, prev_nr_hw_queues);
+			set->nr_hw_queues = prev_nr_hw_queues;
+			goto again;
+		}
 		blk_mq_map_swqueue(q);
 	}
 
-- 
2.7.4

