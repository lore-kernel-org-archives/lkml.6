Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFB4ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 09:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85BD121470
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 09:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FPKolBfq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85BD121470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbeJSR1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 13:27:55 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54156 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbeJSR1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 13:27:55 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9J9JQ8p187685;
        Fri, 19 Oct 2018 09:22:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=elVnaE5MJgkuZBx44YoTIEIMQxUMI9tISOx6nAl3fSo=;
 b=FPKolBfqbIS2dWRDbg3KJK0Z5/GaqM3mJb6APWBvQNIeHbMAjzWeEhpoWReIyajuH1ln
 qz2VtSie4TkX1VoomT6zVPilsqPtciGx2cMzszGauxihIn7nFUOZUY/I9MYfC0AUt2Mm
 Sm1njEqth8TwsHmEryGD5xfmNrUgMVqTLCHsFF63h0UNC/kI7/CwlsmKY0zIQIi8iSQq
 nJAF2KUXpDhIwbpxPOKLprVG7F7iXFDbTDs1tTgmpFhI2oR5ZjgBEtQGSqRxhJ5R9nTN
 bl8Hm6H1+M8SApEOJ9qFgKSekhqElFxZBXy5/pmdRIXjHBPOXtgrsZL6vXE1yUXLAHuE LA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2n38nqk200-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Oct 2018 09:22:38 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9J9Mbc0015894
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Oct 2018 09:22:38 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9J9Mbch009727;
        Fri, 19 Oct 2018 09:22:37 GMT
Received: from will-ThinkCentre-M910s.cn.oracle.com (/10.182.70.254)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 19 Oct 2018 02:22:36 -0700
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] block: don't check position contiguity for DISCARD in attempt_merge
Date:   Fri, 19 Oct 2018 17:24:53 +0800
Message-Id: <1539941093-32058-1-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9050 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=937
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810190085
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Discard command supports multiple ranges of blocks, so needn't
checking position contiguity when merging. Let's do the same thing
in attempt_merge as the blk_try_merge.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-merge.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 42a4674..c94749b 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -732,9 +732,10 @@ static struct request *attempt_merge(struct request_queue *q,
 		return NULL;
 
 	/*
-	 * not contiguous
+	 * not contiguous, except for DISCARD
 	 */
-	if (blk_rq_pos(req) + blk_rq_sectors(req) != blk_rq_pos(next))
+	if ((req_op(req) != REQ_OP_DISCARD) &&
+	    (blk_rq_pos(req) + blk_rq_sectors(req) != blk_rq_pos(next)))
 		return NULL;
 
 	if (rq_data_dir(req) != rq_data_dir(next)
-- 
2.7.4

