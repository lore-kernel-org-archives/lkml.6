Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3AF9C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 09:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A7DF223C8
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 09:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="0vup22aN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A7DF223C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbeKLTQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 14:16:38 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:35054 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729207AbeKLTQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 14:16:37 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAC9ODtA117760;
        Mon, 12 Nov 2018 09:24:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=riF4icgWSIfL3CSx+Xl328RdTdUSRaKnLLnQa6+wycc=;
 b=0vup22aNzy8i8YH0AMyWWoguk25qP3Rjb/+JIrHbvRmtxk/qchwH7C0aIRr0Ffm/1X1O
 2b43OxZuxKPKRSG3upkAyw76yhJf5WR2WvnTLhFkI5FowwIZp0Y2+MSwLsS9xckuoGVi
 yWSpswvZu4b2PsdyXB8bGnICGLbpfDrQN/FXzT7w92KIQapaqeZCiMGxIlLBdgaRbBTZ
 HOd4sX7paBbVqJP9D+8Xk0vPeSLfjuxv3fooFUBSK/JlhmRH8jm7T1gzIS8T9Epnw3vW
 IfZ4PgNTTfNnY0Km75CKZs5/E9hn8XsKRpRFp7RLwToJQ3sYJDHn6LY5/+87KwA5mU04 5Q== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2nnwg144np-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Nov 2018 09:24:13 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wAC9ODBU009851
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Nov 2018 09:24:13 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wAC9OC4v015959;
        Mon, 12 Nov 2018 09:24:13 GMT
Received: from will-ThinkCentre-M93p.cn.oracle.com (/10.182.70.234)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 12 Nov 2018 01:24:12 -0800
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V5 4/6] blk-mq: ensure hctx to be ran on mapped cpu when issue directly
Date:   Mon, 12 Nov 2018 17:23:27 +0800
Message-Id: <1542014609-1769-5-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542014609-1769-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1542014609-1769-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9074 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811120086
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When issue request directly and the task is migrated out of the
original cpu where it allocates request, hctx could be ran on
the cpu where it is not mapped.
To fix this,
 - insert the request forcibly if BLK_MQ_F_BLOCKING is set.
 - check whether the current is mapped to the hctx, if not, insert
   forcibly.
 - invoke __blk_mq_issue_directly under preemption disabled.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-mq.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f54c092..7915f44 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1808,6 +1808,17 @@ static blk_status_t blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 	enum mq_issue_decision dec;
 	int srcu_idx;
 
+	if (hctx->flags & BLK_MQ_F_BLOCKING) {
+		force = true;
+		goto out;
+	}
+
+	if (!cpumask_test_cpu(get_cpu(), hctx->cpumask)) {
+		put_cpu();
+		force = true;
+		goto out;
+	}
+
 	hctx_lock(hctx, &srcu_idx);
 	/*
 	 * hctx_lock is needed before checking quiesced flag.
@@ -1840,7 +1851,8 @@ static blk_status_t blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 
 out_unlock:
 	hctx_unlock(hctx, srcu_idx);
-
+	put_cpu();
+out:
 	dec = blk_mq_make_dicision(ret, bypass, force);
 	switch(dec) {
 	case MQ_ISSUE_INSERT_QUEUE:
-- 
2.7.4

