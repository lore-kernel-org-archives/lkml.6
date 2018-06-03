Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751387AbeFCCkp (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 22:40:45 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8628 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750871AbeFCCkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 22:40:43 -0400
From: YueHaibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>, <santosh@chelsio.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ganeshgr@chelsio.com>, <leedom@chelsio.com>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] net: chelsio: Use zeroing memory allocator instead of allocator/memset
Date: Sun, 3 Jun 2018 10:40:15 +0800
Message-ID: <20180603024015.12744-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use dma_zalloc_coherent for allocating zeroed
memory and remove unnecessary memset function.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/chelsio/cxgb3/sge.c   | 3 +--
 drivers/net/ethernet/chelsio/cxgb4/sge.c   | 3 +--
 drivers/net/ethernet/chelsio/cxgb4vf/sge.c | 7 +------
 3 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb3/sge.c b/drivers/net/ethernet/chelsio/cxgb3/sge.c
index e988caa..20b6e1b 100644
--- a/drivers/net/ethernet/chelsio/cxgb3/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb3/sge.c
@@ -620,7 +620,7 @@ static void *alloc_ring(struct pci_dev *pdev, size_t nelem, size_t elem_size,
 {
 	size_t len = nelem * elem_size;
 	void *s = NULL;
-	void *p = dma_alloc_coherent(&pdev->dev, len, phys, GFP_KERNEL);
+	void *p = dma_zalloc_coherent(&pdev->dev, len, phys, GFP_KERNEL);
 
 	if (!p)
 		return NULL;
@@ -633,7 +633,6 @@ static void *alloc_ring(struct pci_dev *pdev, size_t nelem, size_t elem_size,
 		}
 		*(void **)metadata = s;
 	}
-	memset(p, 0, len);
 	return p;
 }
 
diff --git a/drivers/net/ethernet/chelsio/cxgb4/sge.c b/drivers/net/ethernet/chelsio/cxgb4/sge.c
index 276f223..7a271fe 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/sge.c
@@ -694,7 +694,7 @@ static void *alloc_ring(struct device *dev, size_t nelem, size_t elem_size,
 {
 	size_t len = nelem * elem_size + stat_size;
 	void *s = NULL;
-	void *p = dma_alloc_coherent(dev, len, phys, GFP_KERNEL);
+	void *p = dma_zalloc_coherent(dev, len, phys, GFP_KERNEL);
 
 	if (!p)
 		return NULL;
@@ -708,7 +708,6 @@ static void *alloc_ring(struct device *dev, size_t nelem, size_t elem_size,
 	}
 	if (metadata)
 		*(void **)metadata = s;
-	memset(p, 0, len);
 	return p;
 }
 
diff --git a/drivers/net/ethernet/chelsio/cxgb4vf/sge.c b/drivers/net/ethernet/chelsio/cxgb4vf/sge.c
index dfce5df..3007e1a 100644
--- a/drivers/net/ethernet/chelsio/cxgb4vf/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb4vf/sge.c
@@ -756,7 +756,7 @@ static void *alloc_ring(struct device *dev, size_t nelem, size_t hwsize,
 	 * Allocate the hardware ring and PCI DMA bus address space for said.
 	 */
 	size_t hwlen = nelem * hwsize + stat_size;
-	void *hwring = dma_alloc_coherent(dev, hwlen, busaddrp, GFP_KERNEL);
+	void *hwring = dma_zalloc_coherent(dev, hwlen, busaddrp, GFP_KERNEL);
 
 	if (!hwring)
 		return NULL;
@@ -776,11 +776,6 @@ static void *alloc_ring(struct device *dev, size_t nelem, size_t hwsize,
 		*(void **)swringp = swring;
 	}
 
-	/*
-	 * Zero out the hardware ring and return its address as our function
-	 * value.
-	 */
-	memset(hwring, 0, hwlen);
 	return hwring;
 }
 
-- 
2.7.0
