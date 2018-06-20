Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4AEC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 05:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A93820871
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 05:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Tc++gDfP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A93820871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752792AbeFTFlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 01:41:40 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:36136 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751166AbeFTFli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 01:41:38 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5K5cr8C051069;
        Wed, 20 Jun 2018 05:41:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2017-10-26;
 bh=UNqXwXf8pQUK/Gal0nYvApXqMLxVs0VF6/kANC2bd0Y=;
 b=Tc++gDfPwhxMz7iVLzjqWo7BfgRHG/uLZ78/apdxGSYDeBt4webRIqv2Oqj7NtzwuX36
 NMG6k2NZDHNPEJdGbgOih7kSD0SWzgeZxVTi9kYxpK3f6RNflZHa6NirFNCPy8uM0vFi
 CqMpVs8aXdTkE6CV9i2uEyxE1cDAsli1J9/YJvv7ukw3DAOy5AS75gvaJTFks3xVQusE
 5RPZqiIwOXgnUylQzVSeyCrkbqCmw9/r4QMuIy2dWew6JLdS0ovhqTweVF8xplJ33x8/
 I4OlVvGfZElNwfgN0RIrfxELBGl1ZLjwePf9kmeToLL0NIg25Zr3lyCI5tI9vzSUMXAS gA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2jmr2mk172-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jun 2018 05:41:15 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5K5fDa6027405
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jun 2018 05:41:14 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5K5fD1t013762;
        Wed, 20 Jun 2018 05:41:13 GMT
Received: from will-ThinkCentre-M910s.cn.oracle.com (/10.182.70.254)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Jun 2018 22:41:12 -0700
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     keith.busch@intel.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2] nvme-pci: move nvme_kill_queues to nvme_remove_dead_ctrl
Date:   Wed, 20 Jun 2018 13:42:22 +0800
Message-Id: <1529473342-1886-1-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8929 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806200064
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is race between nvme_remove and nvme_reset_work that can
lead to io hang.

nvme_remove                    nvme_reset_work
                               -> nvme_remove_dead_ctrl
                                 -> nvme_dev_disable
                                   -> quiesce request_queue
                                 -> queue remove_work
-> cancel_work_sync reset_work
-> nvme_remove_namespaces
  -> splice ctrl->namespaces
                               nvme_remove_dead_ctrl_work
                               -> nvme_kill_queues
  -> nvme_ns_remove               do nothing
    -> blk_cleanup_queue
      -> blk_freeze_queue

Finally, the request_queue is quiesced state when wait freeze,
we will get io hang here. To fix it, move the nvme_kill_queues
from nvme_remove_dead_ctrl_work to nvme_remove_dead_ctrl.

Suggested-by: Keith Busch <keith.busch@linux.intel.com>
Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---

V2:
 - Just not invoke nvme_remove_dead_ctrl cannot fix the hole completely.
   Move the nvme_kill_queues to nvme_remove_dead_ctrl based on Keith's
   suggestion
 - Patch comment changes

 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index fc33804..73a97fc 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2289,6 +2289,7 @@ static void nvme_remove_dead_ctrl(struct nvme_dev *dev, int status)
 
 	nvme_get_ctrl(&dev->ctrl);
 	nvme_dev_disable(dev, false);
+	nvme_kill_queues(&dev->ctrl);
 	if (!queue_work(nvme_wq, &dev->remove_work))
 		nvme_put_ctrl(&dev->ctrl);
 }
@@ -2405,7 +2406,6 @@ static void nvme_remove_dead_ctrl_work(struct work_struct *work)
 	struct nvme_dev *dev = container_of(work, struct nvme_dev, remove_work);
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 
-	nvme_kill_queues(&dev->ctrl);
 	if (pci_get_drvdata(pdev))
 		device_release_driver(&pdev->dev);
 	nvme_put_ctrl(&dev->ctrl);
-- 
2.7.4

