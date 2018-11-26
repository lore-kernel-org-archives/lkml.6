Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05AC4C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0D892146F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cB+kOESq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0D892146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729726AbeKZVxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:53:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:35568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729664AbeKZVxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:53:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FFED2089F;
        Mon, 26 Nov 2018 11:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543230000;
        bh=xUnMKUvxxufOATXeAM6or8x9ziXsdrMXIFOSE/dI4o0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cB+kOESqAPAJLSY4c+dICHUXfV0B3QR+zXTK8e2O1blmmarwSuyhKkg//3jwCDzG+
         uhX4Ulaq6ANHg9LfyPLD8TAiNMwPYTqyBbsR6JpqwjGGOeF0GFXTlTVkqd2eb/zHCm
         fH1ggQ2pR0fq/CDdjaIN4XauZogcuyiSmHWnWMWM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 04/62] nvme-pci: fix conflicting p2p resource adds
Date:   Mon, 26 Nov 2018 11:50:45 +0100
Message-Id: <20181126105051.313061674@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105050.592727680@linuxfoundation.org>
References: <20181126105050.592727680@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
 drivers/nvme/host/pci.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1546,6 +1546,9 @@ static void __iomem *nvme_map_cmb(struct
 	void __iomem *cmb;
 	int bar;
 
+	if (dev->cmb_size)
+		return NULL;
+
 	dev->cmbsz = readl(dev->bar + NVME_REG_CMBSZ);
 	if (!(NVME_CMB_SZ(dev->cmbsz)))
 		return NULL;
@@ -2032,7 +2035,6 @@ static void nvme_pci_disable(struct nvme
 {
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 
-	nvme_release_cmb(dev);
 	pci_free_irq_vectors(pdev);
 
 	if (pci_is_enabled(pdev)) {
@@ -2432,6 +2434,7 @@ static void nvme_remove(struct pci_dev *
 	nvme_stop_ctrl(&dev->ctrl);
 	nvme_remove_namespaces(&dev->ctrl);
 	nvme_dev_disable(dev, true);
+	nvme_release_cmb(dev);
 	nvme_free_host_mem(dev);
 	nvme_dev_remove_admin(dev);
 	nvme_free_queues(dev, 0);


