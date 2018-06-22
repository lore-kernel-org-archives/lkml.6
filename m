Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD68C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9959B23E0F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q1rUZKK+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9959B23E0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751153AbeFVHLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 03:11:04 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:43356 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751042AbeFVHKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 03:10:32 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5M79sl8088955;
        Fri, 22 Jun 2018 07:10:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2017-10-26;
 bh=biIvYEsP90Ub462EJTMLvkNeQJbh2Q8A6aYAlXFhsDs=;
 b=Q1rUZKK+PVXXZhsWypdKA5LjqvPFyQcHfkSHHVKM8ljdHJm6BPjFDcjUktmHOaMqzktL
 GfeQ98elp9ezaMCAjJMj4gFg6AbHMDedVGzB3vZfS+d8pS9UcnQSXq5JNaJtF/PyuoaX
 vLNJnAuIf9qzYpUB2MyPpS58NYnFSSHFVCS4/BvUdaTitWTFAAkyYbC4IN5jiUxYRGnq
 4YOVMEqYSjBJxPHlJphHlaLSoGBxr7l9R4Z26fpwCm3AGHgMWOsMCNPJY7X14l+oF09d
 8o+IC00yIkpJZMIBsIJ4BLoVIInO+tAo2ECf5LPrDCYhRJMou3Owv+n6Q6xSoxIL+yqI XA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2jrp8hrre6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jun 2018 07:10:31 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5M7AUZS023421
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jun 2018 07:10:30 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5M7AUnZ012832;
        Fri, 22 Jun 2018 07:10:30 GMT
Received: from will-ThinkCentre-M910s.cn.oracle.com (/10.182.70.254)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 22 Jun 2018 00:10:29 -0700
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     bart.vanassche@wdc.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] blk-mq: cleanup blk_mq_register_dev
Date:   Fri, 22 Jun 2018 15:11:19 +0800
Message-Id: <1529651480-1734-3-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529651480-1734-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1529651480-1734-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8931 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=987
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806220081
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nobody invokes blk_mq_register_dev, remove it and change
__blk_mq_register_dev to blk_mq_register_dev. In addition, move
the declaration of blk_mq_register/unregister_dev to block/blk-mq.h
because they are only used by block layer.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-mq-sysfs.c   | 14 +-------------
 block/blk-mq.h         |  3 +++
 block/blk-sysfs.c      |  2 +-
 include/linux/blk-mq.h |  3 ---
 4 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index aafb442..ec26745 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -295,7 +295,7 @@ void blk_mq_sysfs_init(struct request_queue *q)
 	}
 }
 
-int __blk_mq_register_dev(struct device *dev, struct request_queue *q)
+int blk_mq_register_dev(struct device *dev, struct request_queue *q)
 {
 	struct blk_mq_hw_ctx *hctx;
 	int ret, i;
@@ -330,18 +330,6 @@ int __blk_mq_register_dev(struct device *dev, struct request_queue *q)
 	return ret;
 }
 
-int blk_mq_register_dev(struct device *dev, struct request_queue *q)
-{
-	int ret;
-
-	mutex_lock(&q->sysfs_lock);
-	ret = __blk_mq_register_dev(dev, q);
-	mutex_unlock(&q->sysfs_lock);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(blk_mq_register_dev);
-
 void blk_mq_sysfs_unregister(struct request_queue *q)
 {
 	struct blk_mq_hw_ctx *hctx;
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 89231e4..7f87e03 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -30,6 +30,9 @@ struct blk_mq_ctx {
 	struct kobject		kobj;
 } ____cacheline_aligned_in_smp;
 
+int blk_mq_register_dev(struct device *dev, struct request_queue *q);
+void blk_mq_unregister_dev(struct device *dev, struct request_queue *q);
+
 void blk_mq_freeze_queue(struct request_queue *q);
 void blk_mq_free_queue(struct request_queue *q);
 int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr);
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 159c586..96dcbb9 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -897,7 +897,7 @@ int blk_register_queue(struct gendisk *disk)
 	}
 
 	if (q->mq_ops) {
-		__blk_mq_register_dev(dev, q);
+		blk_mq_register_dev(dev, q);
 		blk_mq_debugfs_register(q);
 	}
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 0a509ae..61b3833 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -201,9 +201,6 @@ enum {
 struct request_queue *blk_mq_init_queue(struct blk_mq_tag_set *);
 struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 						  struct request_queue *q);
-int blk_mq_register_dev(struct device *, struct request_queue *);
-void blk_mq_unregister_dev(struct device *, struct request_queue *);
-
 int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set);
 void blk_mq_free_tag_set(struct blk_mq_tag_set *set);
 
-- 
2.7.4

