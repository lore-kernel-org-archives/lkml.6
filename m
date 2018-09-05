Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0A4C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 04:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7271820869
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 04:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FrHRU3Uv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7271820869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbeIEIg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 04:36:56 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:51498 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727462AbeIEIgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 04:36:55 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8543rrd098209;
        Wed, 5 Sep 2018 04:08:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=ZZGWplWggGJJdNVAZEyFTAY0lLunXe191YVe7YvEIWo=;
 b=FrHRU3UvpRhm7cMD3wRbFMKEDAKQfazqMb8DWj6OUo7xreHYkTlEhzcoSzLCCEsTWa5G
 9CE5CEX4AQWV2OxqqoqxYBWUg6DwDvhbPhNY9tTpbkkvlz043Vr6faNPj7pE8Zils2Qf
 mwuFfc9FgKgZuTet3qyjPrVAFSi2fJxaEwtANK0/tI4tMxXAXh8PTCmDI02uKHb/91Or
 GeIk+YN3DXI7DlNYjBJzKpgPPWOqkoPN1oSnVmydNHv8mJfsUSiX40v9i57a2UDQBjcF
 ZD1GkabIOnC5qWfXhkGMARkxAhynmiVdSa02buF2hlxhApT/BexjiDxy0MSiyUkKiRV6 Fg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2m7kdqgyxq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Sep 2018 04:08:21 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8548Lb6022776
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Sep 2018 04:08:21 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8548KNi026190;
        Wed, 5 Sep 2018 04:08:20 GMT
Received: from will-ThinkCentre-M910s.cn.oracle.com (/10.182.70.254)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Sep 2018 04:08:19 +0000
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk, ming.lei@redhat.com, bart.vanassche@wdc.com,
        sagi@grimberg.me, keith.busch@intel.com, jthumshirn@suse.de,
        jsmart2021@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: [PATCH 2/3] blk-core: introduce queue close feature
Date:   Wed,  5 Sep 2018 12:09:45 +0800
Message-Id: <1536120586-3378-3-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536120586-3378-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1536120586-3378-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9006 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809050042
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

blk queue freeze is often used to prevent new IO from entering
request queue. However, becuase we kill the percpu-ref
q_usage_counter when freeze queue, we have to drain the request
queue when unfreeze. This is unnecessary for just preventing new
IO. In addition, If there is IO timeout or other issue when unfreeze
the queue, the scenario could be very tricky.

So we introduce BLK_QUEUE_GATE_CLOSED to implement a light-weight
queue close feature base on the queue_gate to prevent new IO from
comming in queue which will not need to drain the queue any more.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-core.c       | 17 +++++++++++++++++
 block/blk.h            |  1 +
 include/linux/blkdev.h |  3 +++
 3 files changed, 21 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index d1bdded..b073c68 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -449,6 +449,23 @@ void blk_clear_preempt_only(struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(blk_clear_preempt_only);
 
+int blk_set_queue_closed(struct request_queue *q)
+{
+	if (test_and_set_bit(BLK_QUEUE_GATE_CLOSED, &q->queue_gate))
+		return 1;
+
+	synchronize_rcu();
+	return 0;
+}
+EXPORT_SYMBOL_GPL(blk_set_queue_closed);
+
+void blk_clear_queue_closed(struct request_queue *q)
+{
+	clear_bit(BLK_QUEUE_GATE_CLOSED, &q->queue_gate);
+	wake_up_all(&q->mq_freeze_wq);
+}
+EXPORT_SYMBOL_GPL(blk_clear_queue_closed);
+
 /**
  * __blk_run_queue_uncond - run a queue whether or not it has been stopped
  * @q:	The queue to run
diff --git a/block/blk.h b/block/blk.h
index cdef4c1..90ff6bb 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -21,6 +21,7 @@ extern struct dentry *blk_debugfs_root;
 
 enum blk_queue_gate_flag_t {
 	BLK_QUEUE_GATE_PREEMPT_ONLY,
+	BLK_QUEUE_GATE_CLOSED,
 };
 
 struct blk_flush_queue {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 4a33814..a7f77da 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -741,6 +741,9 @@ bool blk_queue_flag_test_and_clear(unsigned int flag, struct request_queue *q);
 extern int blk_set_preempt_only(struct request_queue *q);
 extern void blk_clear_preempt_only(struct request_queue *q);
 
+extern int blk_set_queue_closed(struct request_queue *q);
+extern void blk_clear_queue_closed(struct request_queue *q);
+
 static inline int queue_in_flight(struct request_queue *q)
 {
 	return q->in_flight[0] + q->in_flight[1];
-- 
2.7.4

