Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8AB9C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 06:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65F32254B0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 06:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jIwTUTNC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65F32254B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752293AbeFYGWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 02:22:33 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37750 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751752AbeFYGWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 02:22:31 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5P6JT0q114313;
        Mon, 25 Jun 2018 06:22:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2017-10-26;
 bh=4ZcfKmmXrDfkvdjACbGYSZDpwhO9LBoVbRMvnT/tifU=;
 b=jIwTUTNCqc0D2l3kn95kSzCCgtcnWEiX9MHnoYQAgxs4cMR2MWhlK/V/TaiNk8AjPG7l
 zRd+5f5BspkjTsGw9pC0pfee22dZZ5l+LGdDaWrU+4OQg+ElM1Ls07nTU7Z79xDrWOy9
 kGvwFRTL2WVrYXz2YO/pnDUh5k6FvObT1nB0jE8zlo6q2aO6sI7a8Zo1XqkefKN4LP+J
 2YzgXowgp/EjmsnlnEO7uSqNQLd/3RchxTMwWLTf0sI2CfITE5pEh21z9BRtnvBAJBDJ
 /19LKbY9PTqCEGpzWTBXddEwItKkkew3b0TcaAFn2SkCKRMyqIHO4HgE2t2uO/A6ajZK sQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2jt7mp9bak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jun 2018 06:22:30 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5P6MTG4028634
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jun 2018 06:22:29 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5P6MTVn019884;
        Mon, 25 Jun 2018 06:22:29 GMT
Received: from will-ThinkCentre-M910s.cn.oracle.com (/10.182.70.254)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 24 Jun 2018 23:22:28 -0700
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESENT] blk-mq-debugfs: invoke queue_for_each_hw_ctx under sysfs_lock
Date:   Mon, 25 Jun 2018 14:23:35 +0800
Message-Id: <1529907815-2170-1-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8934 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806250075
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

blk_mq_run_hw_queues and blk_mq_start_stopped_hw_queues in
queue_state_write will invoke queue_for_each_hw_ctx. It will race
with blk_mq_realloc_hw_ctxs and incur NULL pointer reference. Put
them under sysfs_lock to serialize the accessing to queue_hw_ctx
and nr_hw_queues.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-mq-debugfs.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index ffa6223..2e0c444 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -151,6 +151,7 @@ static ssize_t queue_state_write(void *data, const char __user *buf,
 {
 	struct request_queue *q = data;
 	char opbuf[16] = { }, *op;
+	int res;
 
 	/*
 	 * The "state" attribute is removed after blk_cleanup_queue() has called
@@ -169,9 +170,17 @@ static ssize_t queue_state_write(void *data, const char __user *buf,
 		return -EFAULT;
 	op = strstrip(opbuf);
 	if (strcmp(op, "run") == 0) {
+		res = mutex_lock_interruptible(&q->sysfs_lock);
+		if (res)
+			goto out;
 		blk_mq_run_hw_queues(q, true);
+		mutex_unlock(&q->sysfs_lock);
 	} else if (strcmp(op, "start") == 0) {
+		res = mutex_lock_interruptible(&q->sysfs_lock);
+		if (res)
+			goto out;
 		blk_mq_start_stopped_hw_queues(q, true);
+		mutex_unlock(&q->sysfs_lock);
 	} else if (strcmp(op, "kick") == 0) {
 		blk_mq_kick_requeue_list(q);
 	} else {
@@ -180,6 +189,7 @@ static ssize_t queue_state_write(void *data, const char __user *buf,
 		pr_err("%s: use 'run', 'start' or 'kick'\n", __func__);
 		return -EINVAL;
 	}
+out:
 	return count;
 }
 
-- 
2.7.4

