Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773ABC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3153420661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XJPrtJvk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3153420661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756001AbeFSHCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 03:02:13 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50206 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750736AbeFSHCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 03:02:11 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5J6x4Vi188878;
        Tue, 19 Jun 2018 07:02:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2017-10-26;
 bh=tAJbmg5iQtpFOXg4vuQz3a7Z0BLe1ZO/r9cj4495nm0=;
 b=XJPrtJvkonhcvw34qzghtzVMDIuI/AwAhFThOeEOknKlc3GSZS4dogea4BXWUTpAk2ik
 J5VwoKxdbWrM4J434A0gz9epPdON6GyPi6FzPDcozNAHcyFC8pm1J+Yxes5HBuFfeTX6
 y0Q/UHKZBOZcKo7zEe90DcAJYUrvNPVkFYtzYfpsaLs3s87SQ7noCvSNFW6MYMD3snHc
 mfPMSTwFGlwf4DIwbb5cXIaf+2hCRyHz5NhAQkmVqAofvpe6MLWK9KNrCEM6wOjX2x0c
 V2amz5VYxWhODPkFO4Q/HM6R5feap8TS+S3cF0cWs5n2ueWWZ2oC3CuziRYKt0zzMBPx MQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2jmt01eu9s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jun 2018 07:02:10 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5J7292S030405
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jun 2018 07:02:09 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5J728IT003338;
        Tue, 19 Jun 2018 07:02:09 GMT
Received: from will-ThinkCentre-M910s.cn.oracle.com (/10.182.70.254)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Jun 2018 00:02:08 -0700
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESENT] blk-mq: use blk_rq_timeout to limit the max timeout
Date:   Tue, 19 Jun 2018 15:03:16 +0800
Message-Id: <1529391796-1819-1-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8928 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=875
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806190081
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

blk_rq_timeout is needed to limit the max timeout value, otherwise,
a idle hctx cannot be deactivated timely in shared-tag case.

Fixes: 12f5b931 (blk-mq: Remove generation seqeunce)
Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 70c65bb..ccebe7b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -868,7 +868,7 @@ static void blk_mq_timeout_work(struct work_struct *work)
 	blk_mq_queue_tag_busy_iter(q, blk_mq_check_expired, &next);
 
 	if (next != 0) {
-		mod_timer(&q->timeout, next);
+		mod_timer(&q->timeout, blk_rq_timeout(round_jiffies_up(next)));
 	} else {
 		/*
 		 * Request timeouts are handled as a forward rolling timer. If
-- 
2.7.4

