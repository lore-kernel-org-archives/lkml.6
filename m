Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A1CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 01:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC375218FE
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 01:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388432AbeLUBHi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 20:07:38 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:6920 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729428AbeLUBHi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 20:07:38 -0500
Received: from DGGEMA401-HUB.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id 9B1014B76540D;
        Fri, 21 Dec 2018 09:07:34 +0800 (CST)
Received: from DGGEMA505-MBX.china.huawei.com ([169.254.1.59]) by
 DGGEMA401-HUB.china.huawei.com ([10.3.20.42]) with mapi id 14.03.0415.000;
 Fri, 21 Dec 2018 09:07:25 +0800
From:   "Lulina (A)" <lina.lulina@huawei.com>
To:     "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] nvme-pci: fix dbbuf_sq_db point to freed memory
Thread-Topic: [PATCH v2] nvme-pci: fix dbbuf_sq_db point to freed memory
Thread-Index: AdSYyKP/HgBwNf9HQj6iJjwvphYUMA==
Date:   Fri, 21 Dec 2018 01:07:25 +0000
Message-ID: <E5D59058E6941147BD3ACF9CB4AA49E3B3572EC2@DGGEMA505-MBX.china.huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.177.19.113]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The case is that nvme device support NVME_CTRL_OACS_DBBUF_SUPP, and
return failed when the driver sent nvme_admin_dbbuf. The nvmeq->dbbuf_sq_db
point to freed memory, as nvme_dbbuf_set is called after nvme_dbbuf_init.

Signed-off-by: lulina <lina.lulina@huawei.com>

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c33bb20..a477905 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -251,16 +251,25 @@ static int nvme_dbbuf_dma_alloc(struct nvme_dev *dev)
 static void nvme_dbbuf_dma_free(struct nvme_dev *dev)
 {
 	unsigned int mem_size = nvme_dbbuf_size(dev->db_stride);
+	unsigned int i;
 
 	if (dev->dbbuf_dbs) {
 		dma_free_coherent(dev->dev, mem_size,
 				  dev->dbbuf_dbs, dev->dbbuf_dbs_dma_addr);
 		dev->dbbuf_dbs = NULL;
+		for (i = dev->ctrl.queue_count - 1; i > 0; i--) {
+			dev->queues[i].dbbuf_sq_db = NULL;
+			dev->queues[i].dbbuf_cq_db = NULL;
+		}
 	}
 	if (dev->dbbuf_eis) {
 		dma_free_coherent(dev->dev, mem_size,
 				  dev->dbbuf_eis, dev->dbbuf_eis_dma_addr);
 		dev->dbbuf_eis = NULL;
+		for (i = dev->ctrl.queue_count - 1; i > 0; i--) {
+			dev->queues[i].dbbuf_sq_ei = NULL;
+			dev->queues[i].dbbuf_cq_ei = NULL;
+		}
 	}
 }
 
-- 
1.8.3.1

