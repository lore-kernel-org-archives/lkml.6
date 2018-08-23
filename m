Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9322CC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57B4B2083A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:43:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57B4B2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732904AbeHWMMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:12:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50230 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727597AbeHWMMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:12:05 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 117F17F6;
        Thu, 23 Aug 2018 08:43:27 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Keith Busch <keith.busch@linux.intel.com>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 084/324] nvme-pci: move nvme_kill_queues to nvme_remove_dead_ctrl
Date:   Thu, 23 Aug 2018 09:52:30 +0200
Message-Id: <20180823075000.083251173@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jianchao Wang <jianchao.w.wang@oracle.com>

[ Upstream commit 9f9cafc14016f23f982d3ce18f9057923bd3037a ]

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
Reviewed-by: Keith Busch <keith.busch@intel.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvme/host/pci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2291,6 +2291,7 @@ static void nvme_remove_dead_ctrl(struct
 
 	nvme_get_ctrl(&dev->ctrl);
 	nvme_dev_disable(dev, false);
+	nvme_kill_queues(&dev->ctrl);
 	if (!queue_work(nvme_wq, &dev->remove_work))
 		nvme_put_ctrl(&dev->ctrl);
 }
@@ -2407,7 +2408,6 @@ static void nvme_remove_dead_ctrl_work(s
 	struct nvme_dev *dev = container_of(work, struct nvme_dev, remove_work);
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 
-	nvme_kill_queues(&dev->ctrl);
 	if (pci_get_drvdata(pdev))
 		device_release_driver(&pdev->dev);
 	nvme_put_ctrl(&dev->ctrl);


