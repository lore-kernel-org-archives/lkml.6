Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6F7C4646D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 07:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8460215EA
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 07:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CGvnQISR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8460215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbeHOKO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 06:14:57 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36672 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727872AbeHOKO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 06:14:56 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7F7Nqhv184685;
        Wed, 15 Aug 2018 07:23:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=cqYwoarC8rcMzcKUzot61wudIilmxoi/tlYTKPCTjKI=;
 b=CGvnQISRZw0Ehs3yrQNoljx29IDZrbqecyGaAR4BaMDy+N7LYJdFz6NlRbRh8Nznstbx
 YDHxg7Ohn2YYyLPI1MwrmQN91L7uF8mcxdEliFvoXfa82pzrSDJSQAveWUnZafVjXXFc
 eBIl2IqwY/I1bNjQnBnbaW1MWUnRj1Mpep8ISni9ZgcS6U0VJ5mQjBVJ1yXrF25EgPks
 OVqHFvbhyeXEbXYI6LpWGT3h8Yn9Fr+2nq+skAlpIVy+50DzBpITbM+Gr/ytBvAFPT8/
 b7liJ1sk4g5u8Uln+U8c4huakhsrKHt7bMkKStF400jUD1JtYm6wodsF5Xu8PWntDkS5 Zg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2ksqrpbdqd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Aug 2018 07:23:52 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7F7NppH002666
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Aug 2018 07:23:51 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7F7Npqu004117;
        Wed, 15 Aug 2018 07:23:51 GMT
Received: from will-ThinkCentre-M910s.cn.oracle.com (/10.182.70.254)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 15 Aug 2018 00:23:50 -0700
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     tom.leiming@gmail.com, bart.vanassche@wdc.com,
        keith.busch@linux.intel.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] blk-mq: sync the update nr_hw_queues with part_in_flight
Date:   Wed, 15 Aug 2018 15:25:15 +0800
Message-Id: <1534317915-5041-3-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534317915-5041-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1534317915-5041-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8985 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808150081
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For blk-mq, part_in_flight/rw will invoke blk_mq_in_flight/rw to
account the inflight requests. It will access the queue_hw_ctx and
nr_hw_queues w/o any protection. When updating nr_hw_queues and
blk_mq_in_flight/rw occur concurrently, panic comes up.
To fix it, introduce mq_realloc_hw_ctxs into mark the updating
nr_hw_queues process and use rcu to ensure the mq_realloc_hw_ctxs
globally visible.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-mq.c         |  3 +++
 block/genhd.c          | 10 ++++++++--
 include/linux/blkdev.h |  1 +
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 89904cc..ff50afc 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2517,6 +2517,8 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 
 	blk_mq_sysfs_unregister(q);
 
+	WRITE_ONCE(q->mq_realloc_hw_ctxs, true);
+	synchronize_rcu();
 	/* protect against switching io scheduler  */
 	mutex_lock(&q->sysfs_lock);
 	for (i = 0; i < set->nr_hw_queues; i++) {
@@ -2564,6 +2566,7 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 	}
 	q->nr_hw_queues = i;
 	mutex_unlock(&q->sysfs_lock);
+	WRITE_ONCE(q->mq_realloc_hw_ctxs, false);
 	blk_mq_sysfs_register(q);
 }
 
diff --git a/block/genhd.c b/block/genhd.c
index 8cc719a3..f9e46aa 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -69,7 +69,10 @@ void part_in_flight(struct request_queue *q, struct hd_struct *part,
 		    unsigned int inflight[2])
 {
 	if (q->mq_ops) {
-		blk_mq_in_flight(q, part, inflight);
+		rcu_read_lock();
+		if (!q->mq_realloc_hw_ctxs)
+			blk_mq_in_flight(q, part, inflight);
+		rcu_read_unlock();
 		return;
 	}
 
@@ -86,7 +89,10 @@ void part_in_flight_rw(struct request_queue *q, struct hd_struct *part,
 		       unsigned int inflight[2])
 {
 	if (q->mq_ops) {
-		blk_mq_in_flight_rw(q, part, inflight);
+		rcu_read_lock();
+		if (!q->mq_realloc_hw_ctxs)
+			blk_mq_in_flight_rw(q, part, inflight);
+		rcu_read_unlock();
 		return;
 	}
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index ee930c4..5cb6662 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -662,6 +662,7 @@ struct request_queue {
 #endif
 
 	bool			mq_sysfs_init_done;
+	bool			mq_realloc_hw_ctxs;
 
 	size_t			cmd_size;
 	void			*rq_alloc_data;
-- 
2.7.4

