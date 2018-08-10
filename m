Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1C9C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 06:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 718A5223DB
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 06:09:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 718A5223DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbeHJIh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 04:37:56 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:52662 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727069AbeHJIhz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 04:37:55 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5973735AB6305;
        Fri, 10 Aug 2018 14:09:31 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.399.0; Fri, 10 Aug 2018
 14:09:24 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <jdmason@kudzu.us>, <keescook@chromium.org>,
        <colin.king@canonical.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <gustavo@embeddedor.com>, <bhelgaas@google.com>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] vxge: remove set but not used variable 'req_out','status' and 'ret'
Date:   Fri, 10 Aug 2018 14:08:37 +0800
Message-ID: <20180810060837.14756-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/net/ethernet/neterion/vxge/vxge-config.c:1097:6: warning:
 variable 'ret' set but not used [-Wunused-but-set-variable]
drivers/net/ethernet/neterion/vxge/vxge-config.c:2263:6: warning:
 variable 'req_out' set but not used [-Wunused-but-set-variable]
drivers/net/ethernet/neterion/vxge/vxge-config.c:2262:22: warning:
 variable 'status' set but not used [-Wunused-but-set-variable]
drivers/net/ethernet/neterion/vxge/vxge-config.c:2360:22: warning:
 variable 'status' set but not used [-Wunused-but-set-variable]
  enum vxge_hw_status status = VXGE_HW_OK;

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/neterion/vxge/vxge-config.c | 27 ++++++------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/neterion/vxge/vxge-config.c b/drivers/net/ethernet/neterion/vxge/vxge-config.c
index ae81498..398011c 100644
--- a/drivers/net/ethernet/neterion/vxge/vxge-config.c
+++ b/drivers/net/ethernet/neterion/vxge/vxge-config.c
@@ -1094,12 +1094,9 @@ static void __vxge_hw_blockpool_destroy(struct __vxge_hw_blockpool *blockpool)
 {
 	struct __vxge_hw_device *hldev;
 	struct list_head *p, *n;
-	u16 ret;
 
-	if (blockpool == NULL) {
-		ret = 1;
-		goto exit;
-	}
+	if (!blockpool)
+		return;
 
 	hldev = blockpool->hldev;
 
@@ -1122,8 +1119,7 @@ static void __vxge_hw_blockpool_destroy(struct __vxge_hw_blockpool *blockpool)
 		list_del(&((struct __vxge_hw_blockpool_entry *)p)->item);
 		kfree((void *)p);
 	}
-	ret = 0;
-exit:
+
 	return;
 }
 
@@ -2259,14 +2255,11 @@ static void vxge_hw_blockpool_block_add(struct __vxge_hw_device *devh,
 	struct __vxge_hw_blockpool *blockpool;
 	struct __vxge_hw_blockpool_entry *entry = NULL;
 	dma_addr_t dma_addr;
-	enum vxge_hw_status status = VXGE_HW_OK;
-	u32 req_out;
 
 	blockpool = &devh->block_pool;
 
 	if (block_addr == NULL) {
 		blockpool->req_out--;
-		status = VXGE_HW_FAIL;
 		goto exit;
 	}
 
@@ -2276,7 +2269,6 @@ static void vxge_hw_blockpool_block_add(struct __vxge_hw_device *devh,
 	if (unlikely(pci_dma_mapping_error(devh->pdev, dma_addr))) {
 		vxge_os_dma_free(devh->pdev, block_addr, &acc_handle);
 		blockpool->req_out--;
-		status = VXGE_HW_FAIL;
 		goto exit;
 	}
 
@@ -2291,7 +2283,7 @@ static void vxge_hw_blockpool_block_add(struct __vxge_hw_device *devh,
 	else
 		list_del(&entry->item);
 
-	if (entry != NULL) {
+	if (entry) {
 		entry->length = length;
 		entry->memblock = block_addr;
 		entry->dma_addr = dma_addr;
@@ -2299,13 +2291,10 @@ static void vxge_hw_blockpool_block_add(struct __vxge_hw_device *devh,
 		entry->dma_handle = dma_h;
 		list_add(&entry->item, &blockpool->free_block_list);
 		blockpool->pool_size++;
-		status = VXGE_HW_OK;
-	} else
-		status = VXGE_HW_ERR_OUT_OF_MEMORY;
+	}
 
 	blockpool->req_out--;
 
-	req_out = blockpool->req_out;
 exit:
 	return;
 }
@@ -2357,7 +2346,6 @@ static void *__vxge_hw_blockpool_malloc(struct __vxge_hw_device *devh, u32 size,
 	struct __vxge_hw_blockpool_entry *entry = NULL;
 	struct __vxge_hw_blockpool  *blockpool;
 	void *memblock = NULL;
-	enum vxge_hw_status status = VXGE_HW_OK;
 
 	blockpool = &devh->block_pool;
 
@@ -2367,10 +2355,8 @@ static void *__vxge_hw_blockpool_malloc(struct __vxge_hw_device *devh, u32 size,
 						&dma_object->handle,
 						&dma_object->acc_handle);
 
-		if (memblock == NULL) {
-			status = VXGE_HW_ERR_OUT_OF_MEMORY;
+		if (!memblock)
 			goto exit;
-		}
 
 		dma_object->addr = pci_map_single(devh->pdev, memblock, size,
 					PCI_DMA_BIDIRECTIONAL);
@@ -2379,7 +2365,6 @@ static void *__vxge_hw_blockpool_malloc(struct __vxge_hw_device *devh, u32 size,
 				dma_object->addr))) {
 			vxge_os_dma_free(devh->pdev, memblock,
 				&dma_object->acc_handle);
-			status = VXGE_HW_ERR_OUT_OF_MEMORY;
 			goto exit;
 		}
 
-- 
2.7.0


