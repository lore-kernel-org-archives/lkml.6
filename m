Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6E6C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E161720872
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aR5HcMJd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E161720872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932099AbeFTNW0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 09:22:26 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40714 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754027AbeFTNWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 09:22:19 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5KDELqC041392;
        Wed, 20 Jun 2018 13:22:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2017-10-26;
 bh=pIwB0t7rS4T4pJFof0jICznvmsA6QgkUdVH4PilCV78=;
 b=aR5HcMJd5EFCzXrDLLJKUrYHyYNYnpGKSi56TLlcwwHR5/iYMn22Ix3H5SHzff7AGuYG
 kTK+MAzWjFAvzkQWoXueOfWo7tbFFi6lCQ06G8apgtsc1d8KLpmSx+FY5yCtXxxVEl3X
 lsNg8wTwAFKEo80faYDw4oY/DfDHBhmUcZcQQ5WPRc937nm0CufaH2VfqeEjw4PPc+oz
 RE419o6y6jdujCVH6yWN0+/Ya3Q1VIDu0Cs4M1gyRvluxmPdctJBDB09RUv+0Vv501UR
 YJAT++hnvJ2j+C1orFc3jxu/DMaszbB8pAnAApMRAuSmF7dFZwbgL3FTdPkN/XvhoBBE wA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2jmt01mg2c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jun 2018 13:22:11 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5KDMA6J032459
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jun 2018 13:22:11 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5KDMAxh029797;
        Wed, 20 Jun 2018 13:22:10 GMT
Received: from will-ThinkCentre-M910s.cn.oracle.com (/10.182.70.254)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Jun 2018 06:22:09 -0700
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
        keith.busch@intel.com, josef@toxicpanda.com, ulf.hansson@linaro.org
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] null_blk: use __blk_mq_complete_request in timeout path
Date:   Wed, 20 Jun 2018 21:22:42 +0800
Message-Id: <1529500964-28429-4-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529500964-28429-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1529500964-28429-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8929 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806200150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To regain the capability to prevent normal completion path from
entering a timeout request, blk_mq_mark_rq_complete is introduced
in blk_mq_complete_request. Have to use __blk_mq_complete_request
in timeout path to complete a timeout request.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 drivers/block/null_blk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/null_blk.c b/drivers/block/null_blk.c
index 7948049..d756539 100644
--- a/drivers/block/null_blk.c
+++ b/drivers/block/null_blk.c
@@ -1428,7 +1428,7 @@ static void null_request_fn(struct request_queue *q)
 static enum blk_eh_timer_return null_timeout_rq(struct request *rq, bool res)
 {
 	pr_info("null: rq %p timed out\n", rq);
-	blk_mq_complete_request(rq);
+	__blk_mq_complete_request(rq);
 	return BLK_EH_DONE;
 }
 
-- 
2.7.4

