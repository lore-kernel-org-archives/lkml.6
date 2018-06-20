Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBE9C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27A7620874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="q40QbDh0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27A7620874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932255AbeFTNWl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 09:22:41 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40802 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753930AbeFTNWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 09:22:24 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5KDEUQP041765;
        Wed, 20 Jun 2018 13:22:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2017-10-26;
 bh=lok9rxrGj5eNm0oJy/egzKG34TYhxG6B7Xz85sq0ais=;
 b=q40QbDh0UUOFJepmVsXGROdpFDzUIFZG/ukUkDACe7ABFQ76Ppev1B2upKN7mIJQsVYe
 +xfBbZqGBjLmMbqeXVR3ZkTTGZTBE10SOzqgs4lXTQs4cAQIY1X2wL2AIPYkcHquhzEw
 kHSg1lBIV5rVFuePOLIwIyXKjJ98aLq8/nYUs2AYt42iOO+yMFd5KciqUSHACCTKqkNW
 EMUgtBaFZ3Hh09fbHPPJj1lpXSuE9t2aV8Xgd+uoBO/t2BwjLb1UhUVoG02O2wbpwlu5
 UBtzgCg6KX2xoflmokyng2pBcyo0Qhg7yxueQGDp088n/mN5X2B3atOLQcO0KLMsCDVW IQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2jmt01mg2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jun 2018 13:22:16 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5KDMG3q005207
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jun 2018 13:22:16 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5KDMF8V029741;
        Wed, 20 Jun 2018 13:22:16 GMT
Received: from will-ThinkCentre-M910s.cn.oracle.com (/10.182.70.254)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Jun 2018 06:22:15 -0700
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
        keith.busch@intel.com, josef@toxicpanda.com, ulf.hansson@linaro.org
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] nvme: use __blk_mq_complete_request in timeout path
Date:   Wed, 20 Jun 2018 21:22:44 +0800
Message-Id: <1529500964-28429-6-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529500964-28429-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1529500964-28429-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8929 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=748
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

nvme_cancel_request uses blk_mq_complete_request, it won't do
anything on the timeout request, so add __blk_mq_complete_request
before return BLK_EH_DONE.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 drivers/nvme/host/pci.c    | 8 ++++++++
 drivers/nvme/host/rdma.c   | 1 +
 drivers/nvme/target/loop.c | 1 +
 3 files changed, 10 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 73a97fc..2a161f6 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1203,6 +1203,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 		nvme_warn_reset(dev, csts);
 		nvme_dev_disable(dev, false);
 		nvme_reset_ctrl(&dev->ctrl);
+		__blk_mq_complete_request(req);
 		return BLK_EH_DONE;
 	}
 
@@ -1213,6 +1214,11 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 		dev_warn(dev->ctrl.device,
 			 "I/O %d QID %d timeout, completion polled\n",
 			 req->tag, nvmeq->qid);
+		/*
+		 * nvme_end_request will invoke blk_mq_complete_request,
+		 * it will do nothing for this timed out request.
+		 */
+		__blk_mq_complete_request(req);
 		return BLK_EH_DONE;
 	}
 
@@ -1230,6 +1236,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 			 req->tag, nvmeq->qid);
 		nvme_dev_disable(dev, false);
 		nvme_req(req)->flags |= NVME_REQ_CANCELLED;
+		__blk_mq_complete_request(req);
 		return BLK_EH_DONE;
 	default:
 		break;
@@ -1248,6 +1255,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 		nvme_reset_ctrl(&dev->ctrl);
 
 		nvme_req(req)->flags |= NVME_REQ_CANCELLED;
+		__blk_mq_complete_request(req);
 		return BLK_EH_DONE;
 	}
 
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index c9424da..287eecd 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1617,6 +1617,7 @@ nvme_rdma_timeout(struct request *rq, bool reserved)
 	/* fail with DNR on cmd timeout */
 	nvme_req(rq)->status = NVME_SC_ABORT_REQ | NVME_SC_DNR;
 
+	__blk_mq_complete_request(rq);
 	return BLK_EH_DONE;
 }
 
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index d8d91f0..627fbb0 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -148,6 +148,7 @@ nvme_loop_timeout(struct request *rq, bool reserved)
 	/* fail with DNR on admin cmd timeout */
 	nvme_req(rq)->status = NVME_SC_ABORT_REQ | NVME_SC_DNR;
 
+	__blk_mq_complete_request(rq);
 	return BLK_EH_DONE;
 }
 
-- 
2.7.4

