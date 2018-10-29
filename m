Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C29FECDE47
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 08:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3447F2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 08:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="4w3vT04h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3447F2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729523AbeJ2RhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 13:37:13 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56008 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729421AbeJ2RhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 13:37:12 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9T8nKaS180966;
        Mon, 29 Oct 2018 08:49:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=ioT/yFIjJIy+Qg/6RzlFcZD3/CAktU68agYXTE+or0o=;
 b=4w3vT04h2KK5lBnFElHos7vHtN+vwvrovHTgy6kRUO2WGkjVXOoKHhSkvuKEGMmEuYUQ
 jZBA3Km6z3GVwO1+IWK9B8upwqmv/qsdoYpLFdmyegvDWEodlHcFOU+77NtzmwZF+pSW
 ld1RYcPWUO0eCuy9EFxGJ7APSSizJSLZ8yDJ+OvvoTV+7q/uf6KxJfeYDYsEJPB0nRsi
 1TM/9tp5C1/gNnPxiqytDC6nPDXxHQ/w5AO9qk3OfR6/nSnZVas50czQDYO0sixv8SMY
 K5U1tXReDM75xqmVAvWWVquwDW+pvAwu6P+LJcrsU+o1gSMfUGKqk70nXq7llZFoAS5E JQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2ncgnqm8ws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Oct 2018 08:49:29 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9T8nRBR003828
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Oct 2018 08:49:28 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9T8nReV004562;
        Mon, 29 Oct 2018 08:49:27 GMT
Received: from will-ThinkCentre-M93p.cn.oracle.com (/10.182.70.234)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 29 Oct 2018 01:49:27 -0700
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 4/4] blk-mq: ensure hctx to be ran on mapped cpu when issue directly
Date:   Mon, 29 Oct 2018 16:49:11 +0800
Message-Id: <1540802951-5408-5-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540802951-5408-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1540802951-5408-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9060 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=947
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810290085
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
 block/blk-mq.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9c6c858..ced3346 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1770,6 +1770,17 @@ static blk_status_t blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 	blk_status_t ret = BLK_STS_RESOURCE;
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
@@ -1798,7 +1809,8 @@ static blk_status_t blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 	ret = __blk_mq_issue_directly(hctx, rq, cookie);
 out_unlock:
 	hctx_unlock(hctx, srcu_idx);
-
+	put_cpu();
+out:
 	dec = blk_mq_make_dicision(ret, bypass_insert, force);
 	switch(dec) {
 	case MQ_INSERT_DISPATCH:
-- 
2.7.4

