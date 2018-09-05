Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C93C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 04:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 871A220869
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 04:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aggzTuBs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 871A220869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbeIEIhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 04:37:02 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:51510 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727463AbeIEIgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 04:36:55 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w854490n098524;
        Wed, 5 Sep 2018 04:08:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=0e4R5fAVDIOCtUeEMvENS7DgjIEM/YPoh2JCKca3R18=;
 b=aggzTuBsIn1WjGGpmJGsYYrBgKH2DCFTBPfcOTXozUuHrnRW9N3TtCCgk2STus1Mpgy/
 xyuukHmd0ahgCVNePaw01ZxO/0TXTUvVJz75KpsNIrEnPfLBvukmpKAmGhZx5BuqCk0N
 qbbSL9/y222DAUgN/dE41lZ5zLHzrBE/KmgvcQTijSis1rEcEytG0JiCK9Grg1T/dTDQ
 l4A3WjOAwWEOuu9S68qZxZEwD8OL1TjMNkacMuEb80ttdTtsk28FOPMhf14ZWdiJOWQx
 q0iR+QQP0xfQORfSFtisEB89nQRI/CdNlre5PcRZaWbEOOKUW8TyCM0mGkfQKtD4Asz3 fA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2m7kdqgyy1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Sep 2018 04:08:24 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8548NeD023623
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Sep 2018 04:08:23 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8548Nxi026205;
        Wed, 5 Sep 2018 04:08:23 GMT
Received: from will-ThinkCentre-M910s.cn.oracle.com (/10.182.70.254)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Sep 2018 04:08:22 +0000
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk, ming.lei@redhat.com, bart.vanassche@wdc.com,
        sagi@grimberg.me, keith.busch@intel.com, jthumshirn@suse.de,
        jsmart2021@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: [PATCH 3/3] nvme-pci: use queue close instead of queue freeze
Date:   Wed,  5 Sep 2018 12:09:46 +0800
Message-Id: <1536120586-3378-4-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536120586-3378-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1536120586-3378-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9006 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809050042
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nvme_dev_disable freezes queues to prevent new IO. nvme_reset_work
will unfreeze and wait to drain the queues. However, if IO timeout
at the moment, no body could do recovery as nvme_reset_work is
waiting. We will encounter IO hang.

To avoid this scenario, use queue close to prevent new IO which
doesn't need to drain the queues. And just use queue freeze to
try to wait for in-flight IO for shutdown case.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 drivers/nvme/host/core.c | 22 ++++++++++++++++++++++
 drivers/nvme/host/nvme.h |  3 +++
 drivers/nvme/host/pci.c  | 27 ++++++++++++++-------------
 3 files changed, 39 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index dd8ec1d..ce5b35b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3602,6 +3602,28 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_kill_queues);
 
+void nvme_close_queues(struct nvme_ctrl *ctrl)
+{
+	struct nvme_ns *ns;
+
+	down_read(&ctrl->namespaces_rwsem);
+	list_for_each_entry(ns, &ctrl->namespaces, list)
+		blk_set_queue_closed(ns->queue);
+	up_read(&ctrl->namespaces_rwsem);
+}
+EXPORT_SYMBOL_GPL(nvme_close_queues);
+
+void nvme_open_queues(struct nvme_ctrl *ctrl)
+{
+	struct nvme_ns *ns;
+
+	down_read(&ctrl->namespaces_rwsem);
+	list_for_each_entry(ns, &ctrl->namespaces, list)
+		blk_clear_queue_closed(ns->queue);
+	up_read(&ctrl->namespaces_rwsem);
+}
+EXPORT_SYMBOL_GPL(nvme_open_queues);
+
 void nvme_unfreeze(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index bb4a200..fcd44cb 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -437,6 +437,9 @@ void nvme_wait_freeze(struct nvme_ctrl *ctrl);
 void nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout);
 void nvme_start_freeze(struct nvme_ctrl *ctrl);
 
+void nvme_close_queues(struct nvme_ctrl *ctrl);
+void nvme_open_queues(struct nvme_ctrl *ctrl);
+
 #define NVME_QID_ANY -1
 struct request *nvme_alloc_request(struct request_queue *q,
 		struct nvme_command *cmd, blk_mq_req_flags_t flags, int qid);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d668682..c0ccd04 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2145,23 +2145,25 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 
 	mutex_lock(&dev->shutdown_lock);
+	nvme_close_queues(&dev->ctrl);
 	if (pci_is_enabled(pdev)) {
 		u32 csts = readl(dev->bar + NVME_REG_CSTS);
 
-		if (dev->ctrl.state == NVME_CTRL_LIVE ||
-		    dev->ctrl.state == NVME_CTRL_RESETTING)
-			nvme_start_freeze(&dev->ctrl);
 		dead = !!((csts & NVME_CSTS_CFS) || !(csts & NVME_CSTS_RDY) ||
 			pdev->error_state  != pci_channel_io_normal);
-	}
 
-	/*
-	 * Give the controller a chance to complete all entered requests if
-	 * doing a safe shutdown.
-	 */
-	if (!dead) {
-		if (shutdown)
-			nvme_wait_freeze_timeout(&dev->ctrl, NVME_IO_TIMEOUT);
+		if (dev->ctrl.state == NVME_CTRL_LIVE ||
+		    dev->ctrl.state == NVME_CTRL_RESETTING) {
+			/*
+			 * Give the controller a chance to complete all entered
+			 * requests if doing a safe shutdown.
+			 */
+			if (!dead && shutdown) {
+				nvme_start_freeze(&dev->ctrl);
+				nvme_wait_freeze_timeout(&dev->ctrl, NVME_IO_TIMEOUT);
+				nvme_unfreeze(&dev->ctrl);
+			}
+		}
 	}
 
 	nvme_stop_queues(&dev->ctrl);
@@ -2328,11 +2330,9 @@ static void nvme_reset_work(struct work_struct *work)
 		new_state = NVME_CTRL_ADMIN_ONLY;
 	} else {
 		nvme_start_queues(&dev->ctrl);
-		nvme_wait_freeze(&dev->ctrl);
 		/* hit this only when allocate tagset fails */
 		if (nvme_dev_add(dev))
 			new_state = NVME_CTRL_ADMIN_ONLY;
-		nvme_unfreeze(&dev->ctrl);
 	}
 
 	/*
@@ -2345,6 +2345,7 @@ static void nvme_reset_work(struct work_struct *work)
 		goto out;
 	}
 
+	nvme_open_queues(&dev->ctrl);
 	nvme_start_ctrl(&dev->ctrl);
 	return;
 
-- 
2.7.4

