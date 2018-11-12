Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A92C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 09:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC5C8223C8
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 09:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S7fyymAb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC5C8223C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729344AbeKLTQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 14:16:41 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:55526 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729207AbeKLTQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 14:16:40 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAC9OHti073830;
        Mon, 12 Nov 2018 09:24:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=ulM/qFH2cEoqcayqCdekMsUz7o9oGO0nIk1NSx/HxXc=;
 b=S7fyymAbead3LNgA/K5G1axBCYnGKOodG1XaLTmayduvtR4LhLqm1d7YIS3AqyyKqf6y
 ZvdTpMvkX3JKyspeZseoOzI/U4FssipVUIb29DrkyIw9MCpvpzAkGzP43mNs4MfE7nrd
 LGPswnzJgsEGLADkk9casAogy98Nov2agUETP7A5jl1VoIcUeE7bZM3nFHMrnWrbi8s9
 lHhdpzV7r0tsNQgd0HzD6qJR5ojPuCn7XR67BL5FEZzlKxKAc3az7bgWYlzw5lnfDOj6
 2pEDpnkSHiJIP/wrNl8KeCa1713R+Vg48do16Qn0fqcW16RQF1NMvcnjQmRnmH4GgM7z Zg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2nnwc0c4m2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Nov 2018 09:24:17 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wAC9OGHR027167
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Nov 2018 09:24:16 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wAC9OGdG016024;
        Mon, 12 Nov 2018 09:24:16 GMT
Received: from will-ThinkCentre-M93p.cn.oracle.com (/10.182.70.234)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 12 Nov 2018 01:24:16 -0800
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V5 6/6] blk-mq: replace and kill blk_mq_request_issue_directly
Date:   Mon, 12 Nov 2018 17:23:29 +0800
Message-Id: <1542014609-1769-7-git-send-email-jianchao.w.wang@oracle.com>
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

Replace blk_mq_request_issue_directly with blk_mq_try_issue_directly
in blk_insert_cloned_request and remove blk_mq_request_issue_directly
as nobody uses it.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-core.c | 2 +-
 block/blk-mq.c   | 7 +------
 block/blk-mq.h   | 6 ++++--
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index fdc0ad2..5cae9ef 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1436,7 +1436,7 @@ blk_status_t blk_insert_cloned_request(struct request_queue *q, struct request *
 	 * bypass a potential scheduler on the bottom device for
 	 * insert.
 	 */
-	return blk_mq_request_issue_directly(rq);
+	return blk_mq_try_issue_directly(rq->mq_hctx, rq, NULL, true);
 }
 EXPORT_SYMBOL_GPL(blk_insert_cloned_request);
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index f27d547..f016028 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1797,7 +1797,7 @@ static inline enum mq_issue_decision
 	return dec;
 }
 
-static blk_status_t blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
+blk_status_t blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 						struct request *rq,
 						blk_qc_t *cookie,
 						bool bypass)
@@ -1871,11 +1871,6 @@ static blk_status_t blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 	return BLK_STS_OK;
 }
 
-blk_status_t blk_mq_request_issue_directly(struct request *rq)
-{
-	return blk_mq_try_issue_directly(rq->mq_hctx, rq, NULL, true);
-}
-
 void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 		struct list_head *list)
 {
diff --git a/block/blk-mq.h b/block/blk-mq.h
index facb6e9..deee3a4 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -62,8 +62,10 @@ void blk_mq_request_bypass_insert(struct request *rq, bool run_queue);
 void blk_mq_insert_requests(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
 				struct list_head *list);
 
-/* Used by blk_insert_cloned_request() to issue request directly */
-blk_status_t blk_mq_request_issue_directly(struct request *rq);
+blk_status_t blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
+				       struct request *rq,
+				       blk_qc_t *cookie,
+				       bool bypass);
 void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 				    struct list_head *list);
 
-- 
2.7.4

