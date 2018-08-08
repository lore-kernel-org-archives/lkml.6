Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37AACC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 06:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4DEB216F7
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 06:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZSrLjQuA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4DEB216F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbeHHIlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 04:41:40 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48182 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbeHHIlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 04:41:40 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w786IPK4154891;
        Wed, 8 Aug 2018 06:23:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=w/M7HthGrZUSmnSLTb74lAfEoAtiwjZD1cIDt65N7KE=;
 b=ZSrLjQuAFsiDs6i62XvR+reTNzs085c5TjmfbbmGVbbSYpOEeOQ0S1fk2kYqJj+JZPqw
 Ti4b28j7vcxarInnC4cAq2ss57RQnJjjoldAMxsGV0Xgmpwiagw9eadu/atlW6BLEkFS
 HQjD0Pp/fsEbMWKvulrr8oRKDtj3P49ZS4q+Yp/J+qZouoEiNxgBSpNVafDKGHuUEPaL
 rgS5ZAN2S+wj+6OTvbA27VNdzaTfxA8pQW2Bbn6LH/W4Lr4Man684K5n2Q4nEniY0VYy
 p6hNxjkis5u7KM85icYRm7mPFV7RSY/S3xmpc+mGHrbMtYotaEzwjmfACOjXQmpbBBkX jw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2kn4spva73-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Aug 2018 06:23:27 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w786NQMw023627
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Aug 2018 06:23:26 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w786NPMt032388;
        Wed, 8 Aug 2018 06:23:26 GMT
Received: from will-ThinkCentre-M910s.cn.oracle.com (/10.182.70.254)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 07 Aug 2018 23:23:25 -0700
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     jejb@linux.vnet.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: use blk_mq_run_hw_queues in scsi_kick_queue
Date:   Wed,  8 Aug 2018 14:24:59 +0800
Message-Id: <1533709499-1661-1-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8978 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=900
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808080067
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't use blk-mq start/stop hw queue any more, so no reason to
use blk_mq_start_hw_queues which does clear_bit, replace it with
blk_mq_run_hw_queues.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 drivers/scsi/scsi_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 41e9ac9..7de0f26 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -371,7 +371,7 @@ void scsi_device_unbusy(struct scsi_device *sdev)
 static void scsi_kick_queue(struct request_queue *q)
 {
 	if (q->mq_ops)
-		blk_mq_start_hw_queues(q);
+		blk_mq_run_hw_queues(q, false);
 	else
 		blk_run_queue(q);
 }
-- 
2.7.4

