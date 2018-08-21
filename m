Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF09C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 07:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65D2E213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 07:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bJ5wC+CP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65D2E213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbeHUKda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 06:33:30 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45968 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbeHUKda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 06:33:30 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7L78xel056050;
        Tue, 21 Aug 2018 07:13:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=znaTFbEDOmUEg8O+aRKk96aenhOx02Xvk1T4VRvWen4=;
 b=bJ5wC+CPPvArS3RBMTMh8iTiF0U6RpciJw9yd+mWWxi9wxIdyC/UIxoYDDZW97IZaw5/
 W2AkX9NL3BRy2wfEZIy39GtTlbSQ/chsiPOTpn5D02r18hwXG55ku6dOTgOcqpb8VljJ
 9bCfIGVoUWkYdmdn/8AtcU2Iywp0JS1twv6nmEglMeDlIsMxQ0MICC4kMRiWw/SkLRU2
 DqsebSbqbTLcYnyB+rr8X4WL/keRczlNHxHz5KALTrkUIx3zG/q5D8MdASj4LH4sYDxw
 tOb3PYVs8OcPbZa2QnY/XNtpv6VF3iuupgw8D3a9LtAmwLYhQbP18dzn1ag+Z4C4cx9q xQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2kxc3qjfu3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Aug 2018 07:13:29 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7L7DSqY010418
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Aug 2018 07:13:29 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7L7DS3N021343;
        Tue, 21 Aug 2018 07:13:28 GMT
Received: from will-ThinkCentre-M910s.cn.oracle.com (/10.182.70.254)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 21 Aug 2018 00:13:28 -0700
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     tom.leiming@gmail.com, bart.vanassche@wdc.com,
        keith.busch@linux.intel.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 2/2] blk-mq: sync the update nr_hw_queues with blk_mq_queue_tag_busy_iter
Date:   Tue, 21 Aug 2018 15:15:04 +0800
Message-Id: <1534835704-3607-3-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534835704-3607-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1534835704-3607-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8991 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808210076
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
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-tag.c | 14 +++++++++++++-
 block/blk-mq.c     |  4 ++++
 2 files changed, 17 insertions(+), 1 deletion(-)

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
index 9c8c8c7..81cb84b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2977,6 +2977,10 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 	list_for_each_entry(q, &set->tag_list, tag_set_list)
 		blk_mq_freeze_queue(q);
 	/*
+	 * Sync with blk_mq_queue_tag_busy_iter.
+	 */
+	synchronize_rcu();
+	/*
 	 * Switch IO scheduler to 'none', cleaning up the data associated
 	 * with the previous scheduler. We will switch back once we are done
 	 * updating the new sw to hw queue mappings.
-- 
2.7.4

