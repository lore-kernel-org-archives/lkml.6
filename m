Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03582C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE4AB223CB
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/a1t/Z/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE4AB223CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732529AbeKMPsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 10:48:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:34650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732511AbeKMPsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 10:48:21 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6138A22512;
        Tue, 13 Nov 2018 05:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542088313;
        bh=uQFqOHWKSuYYje5DbwjKzPyChGggrFC+GUUAgjnYUrw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n/a1t/Z/zqArLx7HcIqNMCUMq7mMOz2AdIX7EOrUxpYlIlm+bIj6F3/i3+T1Gs9H6
         gF+RurNCzaq9xM6Oa0mcU6glV6A+y0nZuSFrn1KSjycocj+GK5hOK0gAzM39gF25Cg
         oadTivptBKb1hgUEp34mmXnF6TGt5Qr49jqC3Y3M=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 4.14 05/26] nvme-pci: fix conflicting p2p resource adds
Date:   Tue, 13 Nov 2018 00:51:29 -0500
Message-Id: <20181113055150.78773-5-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181113055150.78773-1-sashal@kernel.org>
References: <20181113055150.78773-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keith Busch <keith.busch@intel.com>

[ Upstream commit 9fe5c59ff6a1e5e26a39b75489a1420e7eaaf0b1 ]

The nvme pci driver had been adding its CMB resource to the P2P DMA
subsystem everytime on on a controller reset. This results in the
following warning:

    ------------[ cut here ]------------
    nvme 0000:00:03.0: Conflicting mapping in same section
    WARNING: CPU: 7 PID: 81 at kernel/memremap.c:155 devm_memremap_pages+0xa6/0x380
    ...
    Call Trace:
     pci_p2pdma_add_resource+0x153/0x370
     nvme_reset_work+0x28c/0x17b1 [nvme]
     ? add_timer+0x107/0x1e0
     ? dequeue_entity+0x81/0x660
     ? dequeue_entity+0x3b0/0x660
     ? pick_next_task_fair+0xaf/0x610
     ? __switch_to+0xbc/0x410
     process_one_work+0x1cf/0x350
     worker_thread+0x215/0x3d0
     ? process_one_work+0x350/0x350
     kthread+0x107/0x120
     ? kthread_park+0x80/0x80
     ret_from_fork+0x1f/0x30
    ---[ end trace f7ea76ac6ee72727 ]---
    nvme nvme0: failed to register the CMB

This patch fixes this by registering the CMB with P2P only once.

Signed-off-by: Keith Busch <keith.busch@intel.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index afb99876fa9e..9eb0a2acd41f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1546,6 +1546,9 @@ static void __iomem *nvme_map_cmb(struct nvme_dev *dev)
 	void __iomem *cmb;
 	int bar;
 
+	if (dev->cmb_size)
+		return;
+
 	dev->cmbsz = readl(dev->bar + NVME_REG_CMBSZ);
 	if (!(NVME_CMB_SZ(dev->cmbsz)))
 		return NULL;
@@ -2032,7 +2035,6 @@ static void nvme_pci_disable(struct nvme_dev *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 
-	nvme_release_cmb(dev);
 	pci_free_irq_vectors(pdev);
 
 	if (pci_is_enabled(pdev)) {
@@ -2432,6 +2434,7 @@ static void nvme_remove(struct pci_dev *pdev)
 	nvme_stop_ctrl(&dev->ctrl);
 	nvme_remove_namespaces(&dev->ctrl);
 	nvme_dev_disable(dev, true);
+	nvme_release_cmb(dev);
 	nvme_free_host_mem(dev);
 	nvme_dev_remove_admin(dev);
 	nvme_free_queues(dev, 0);
-- 
2.17.1

