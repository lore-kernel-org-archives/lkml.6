Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC5A4C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 07:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAE3C21720
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 07:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729564AbeLTHIG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 02:08:06 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:59376 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725783AbeLTHIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 02:08:06 -0500
Received: from DGGEMA406-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id DF6E0EA112F7E;
        Thu, 20 Dec 2018 15:08:00 +0800 (CST)
Received: from DGGEMA421-HUB.china.huawei.com (10.1.198.154) by
 DGGEMA406-HUB.china.huawei.com (10.3.20.47) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 20 Dec 2018 15:08:01 +0800
Received: from DGGEMA505-MBX.china.huawei.com ([169.254.1.59]) by
 dggema421-hub.china.huawei.com ([10.1.198.154]) with mapi id 14.03.0415.000;
 Thu, 20 Dec 2018 15:07:51 +0800
From:   "Lulina (A)" <lina.lulina@huawei.com>
To:     "willy@linux.intel.com" <willy@linux.intel.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Lulina (A)" <lina.lulina@huawei.com>
Subject: [PATCH] nvme-pci: fix dbbuf_sq_db point to freed memory
Thread-Topic: [PATCH] nvme-pci: fix dbbuf_sq_db point to freed memory
Thread-Index: AdSYMlzxQ4Zzl67NQpqPXXBFcLgB3A==
Date:   Thu, 20 Dec 2018 07:07:51 +0000
Message-ID: <E5D59058E6941147BD3ACF9CB4AA49E3B3572D68@DGGEMA505-MBX.china.huawei.com>
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
point to freed memory, as nvme_dbbuf_set is called behind nvme_dbbuf_init.

Change-Id: Ief2a5877cb008d3c29cf99053f80fecc9b8db1db
Signed-off-by: lulina <lina.lulina@huawei.com>

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index da39729..2e11980 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -240,16 +240,25 @@ static int nvme_dbbuf_dma_alloc(struct nvme_dev *dev)
 static void nvme_dbbuf_dma_free(struct nvme_dev *dev)
 {
 	unsigned int mem_size = nvme_dbbuf_size(dev->db_stride);
+	unsigned int i;
 
 	if (dev->dbbuf_dbs) {
 		dma_free_coherent(dev->dev, mem_size,
 				  dev->dbbuf_dbs, dev->dbbuf_dbs_dma_addr);
 		dev->dbbuf_dbs = NULL;
+		for (i = dev->ctrl.queue_count - 1; i > 0; i--) {
+			dev->queues[i]->dbbuf_sq_db = NULL;
+			dev->queues[i]->dbbuf_cq_db = NULL;
+		}
 	}
 	if (dev->dbbuf_eis) {
 		dma_free_coherent(dev->dev, mem_size,
 				  dev->dbbuf_eis, dev->dbbuf_eis_dma_addr);
 		dev->dbbuf_eis = NULL;
+		for (i = dev->ctrl.queue_count - 1; i > 0; i--) {
+			dev->queues[i]->dbbuf_sq_ei = NULL;
+			dev->queues[i]->dbbuf_cq_ei = NULL;
+		}
 	}
 }
 
-- 
1.8.3.1

