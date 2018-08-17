Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0E5C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 03:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7718220852
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 03:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Szp7B95I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7718220852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbeHQGzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 02:55:42 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:60902 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbeHQGzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 02:55:42 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7H3o4qT125143;
        Fri, 17 Aug 2018 03:52:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=qgSAWYuxmCMBq3hy7sODnLEGZXVLSlJYSc9RAbciypc=;
 b=Szp7B95IKAtXA/FIO4xLcKhafBVix17rpBveN4clGpT+OA6/Ea4qzGPTA47hngyO3p+h
 FkAjpxvClS8riNnXSzroYE4vC6dNpT13HMOTEKe6M8M+QbYNmYjZ4rvGIo9peAHHAmfY
 8L7qx3hFQAdfZLBAqyBS5caR4Wupl5besDnVV3yqLz9zJOoMJS2EH/PGc6mUXFV2EQ2e
 P+uleM5kwpTp8h4d7T9lX9+NIfBGFOu5tmszVFa0q6Fx5oMRoFomVtXhpytlGslL27Hs
 U76UxkUPJjQns6hHL8SDkkHxZrDSIEpN+WmFPzuo/boiHiCjfqoCBHd6dKCWytbg0dJV MQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2ksnaddnm5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Aug 2018 03:52:53 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7H3qqQu015014
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Aug 2018 03:52:52 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7H3qpAv019341;
        Fri, 17 Aug 2018 03:52:51 GMT
Received: from will-ThinkCentre-M910s.cn.oracle.com (/10.182.70.254)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 16 Aug 2018 20:52:51 -0700
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     tom.leiming@gmail.com, bart.vanassche@wdc.com,
        keith.busch@linux.intel.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 2/2] blk-mq: sync the update nr_hw_queues with part_in_flight
Date:   Fri, 17 Aug 2018 11:54:03 +0800
Message-Id: <1534478043-7170-3-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534478043-7170-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1534478043-7170-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8987 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=956
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808170040
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
so that we will not miss any in-flight request. And also both the
check and blk_mq_queue_tag_busy_iter are under rcu critical section,
then __blk_mq_update_nr_hw_queues could ensure the zeroed q_usage_counter
to be globally visible.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-mq.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index de7027f..9ec98bd 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -112,7 +112,22 @@ void blk_mq_in_flight(struct request_queue *q, struct hd_struct *part,
 	struct mq_inflight mi = { .part = part, .inflight = inflight, };
 
 	inflight[0] = inflight[1] = 0;
+
+	/*
+	 * __blk_mq_update_nr_hw_queues will update the nr_hw_queues and
+	 * queue_hw_ctx after freeze the queue. So we could use q_usage_counter
+	 * to avoid race with it. __blk_mq_update_nr_hw_queues will use
+	 * synchronize_rcu to ensure all of the users of blk_mq_in_flight
+	 * go out of the critical section and see zeroed q_usage_counter.
+	 */
+	rcu_read_lock();
+	if (percpu_ref_is_zero(&q->q_usage_counter)) {
+		rcu_read_unlock();
+		return;
+	}
+
 	blk_mq_queue_tag_busy_iter(q, blk_mq_check_inflight, &mi);
+	rcu_read_unlock();
 }
 
 static void blk_mq_check_inflight_rw(struct blk_mq_hw_ctx *hctx,
@@ -131,7 +146,18 @@ void blk_mq_in_flight_rw(struct request_queue *q, struct hd_struct *part,
 	struct mq_inflight mi = { .part = part, .inflight = inflight, };
 
 	inflight[0] = inflight[1] = 0;
+
+	/*
+	 * See comment of blk_mq_in_flight.
+	 */
+	rcu_read_lock();
+	if (percpu_ref_is_zero(&q->q_usage_counter)) {
+		rcu_read_unlock();
+		return;
+	}
+
 	blk_mq_queue_tag_busy_iter(q, blk_mq_check_inflight_rw, &mi);
+	rcu_read_unlock();
 }
 
 void blk_freeze_queue_start(struct request_queue *q)
@@ -2905,7 +2931,10 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 
 	list_for_each_entry(q, &set->tag_list, tag_set_list)
 		blk_mq_freeze_queue(q);
-
+	/*
+	 * Sync with blk_mq_in_flight and blk_mq_in_flight_rw
+	 */
+	synchronize_rcu();
 	/*
 	 * switch io scheduler to NULL to clean up the data in it.
 	 * will get it back after update mapping between cpu and hw queues.
-- 
2.7.4

