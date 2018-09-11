Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 243B9C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C575020854
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mdA//ik/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C575020854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbeIKOps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 10:45:48 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34674 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbeIKOps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 10:45:48 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8B9i5Kd077835;
        Tue, 11 Sep 2018 09:47:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=mN0D2N4tb5+U8m9Duu3jo1x4nw5u5Bmun3HskG8mHc4=;
 b=mdA//ik/nLZDYkAgHTZH7j/sPUNqTokUYdbe4lZ8k7tErFvteTqjWsbrtImSfTimoC2n
 olk7OQboOR9BBDvm+Wi6pxohGqLdET8sG2ifYjs0XgbXKUH17POFCOx6XX3iaQz5caQ7
 IIzb78Me+cvsjQCJiFiJCYBNZ7w4cLK26TG3LMLkmavyQCVlHmChU+tnmv+6JZstpsTV
 9yYPRrlwLOaRXHdq+MwwecYDiXpa8ixC+1r4eSsg0YPwt8cBWDHoZe9I5jjWTtx5gxaU
 LkZHwGYa1jXVSRHLI1zOrwjx3s6E7OEGDS3attCGSwVMK9DQxRPl2ubXw6KFMW73OrMg rg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2mc5utb1e8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Sep 2018 09:47:01 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8B9l1vk023165
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Sep 2018 09:47:01 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8B9l0aO031770;
        Tue, 11 Sep 2018 09:47:00 GMT
Received: from will-ThinkCentre-M910s.cn.oracle.com (/10.182.70.254)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 11 Sep 2018 02:46:59 -0700
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk, ming.lei@redhat.com, bart.vanassche@wdc.com,
        sagi@grimberg.me, keith.busch@intel.com, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: [PATCH 4/4] nvme-pci: discard the cq_vector checking in nvme_queue_rq
Date:   Tue, 11 Sep 2018 17:48:14 +0800
Message-Id: <1536659294-2321-5-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536659294-2321-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1536659294-2321-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9012 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809110102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

updating nr_hw_queue uses bios retrieving to drain queues, so we
needn't the the cq_vector checking any more.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 drivers/nvme/host/pci.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9e60edf..615192f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -813,13 +813,6 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	struct nvme_command cmnd;
 	blk_status_t ret;
 
-	/*
-	 * We should not need to do this, but we're still using this to
-	 * ensure we can drain requests on a dying queue.
-	 */
-	if (unlikely(nvmeq->cq_vector < 0))
-		return BLK_STS_IOERR;
-
 	ret = nvme_setup_cmd(ns, req, &cmnd);
 	if (ret)
 		return ret;
-- 
2.7.4

