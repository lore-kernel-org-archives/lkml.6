Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A5DC004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 07:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 796112054F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 07:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mAoLn8nK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 796112054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbeJXPsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 11:48:39 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34866 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbeJXPsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 11:48:39 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9O7ImfD083396;
        Wed, 24 Oct 2018 07:21:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=FaEYic3nmykB5rYC9r5ox+y7RiwQW1cjbL0df/ZtlqI=;
 b=mAoLn8nKXeS+As41x4ma8zwwR/ndCkyKOZSOkbKQSi5uncS/wtIOxqrIDJSpIIvMnsXK
 0QlmQmlrB7oL+wtuHSO6BUu2evTai7g5/0u8uL5rPCkg1BLoxRQJNrvwodFf9soU2k+s
 MUhrZtHWo7mmOTYEsQWepkCtKE1AIHUrgm5SJuDz8yVMrdIqRv9jmD/SbuVfKUQSlgl7
 Jf/jhy1Gj/irvKWesZBQF+q5XzxjxJJesxJhA/Rn6aKt1uEDAUKpgetCNl7xYD0MHIsp
 hftFgHS49D6xUJ0rC4oHVhKb8uHQZA/sA7vYQTehUnwlJRpYjmfjyjrxOhbNDvPGKliN jw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2n7w0qsm3g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Oct 2018 07:21:47 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9O7LgNZ003993
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Oct 2018 07:21:42 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9O7Lf1w013794;
        Wed, 24 Oct 2018 07:21:41 GMT
Received: from will-ThinkCentre-M93p.cn.oracle.com (/10.182.70.234)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 24 Oct 2018 00:21:41 -0700
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] blk-mq: ensure hctx to be ran on mapped cpu when issue directly
Date:   Wed, 24 Oct 2018 23:20:07 +0800
Message-Id: <1540394407-20769-1-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9055 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810240067
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When issue request directly and the task is migrated out of the
original cpu where it allocates request, hctx could be ran on
the cpu where it is not mapped. To fix this, insert the request
if BLK_MQ_F_BLOCKING is set, check whether the current is mapped
to the hctx and invoke __blk_mq_issue_directly under preemption
disabled.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-mq.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index e3c39ea..0cdc306 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1717,6 +1717,12 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 {
 	struct request_queue *q = rq->q;
 	bool run_queue = true;
+	blk_status_t ret;
+
+	if (hctx->flags & BLK_MQ_F_BLOCKING) {
+		bypass_insert = false;
+		goto insert;
+	}
 
 	/*
 	 * RCU or SRCU read lock is needed before checking quiesced flag.
@@ -1734,6 +1740,11 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 	if (q->elevator && !bypass_insert)
 		goto insert;
 
+	if (!cpumask_test_cpu(get_cpu(), hctx->cpumask)) {
+		bypass_insert = false;
+		goto insert;
+	}
+
 	if (!blk_mq_get_dispatch_budget(hctx))
 		goto insert;
 
@@ -1742,8 +1753,12 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 		goto insert;
 	}
 
-	return __blk_mq_issue_directly(hctx, rq, cookie);
+	ret = __blk_mq_issue_directly(hctx, rq, cookie);
+	put_cpu();
+	return ret;
+
 insert:
+	put_cpu();
 	if (bypass_insert)
 		return BLK_STS_RESOURCE;
 
-- 
2.7.4

