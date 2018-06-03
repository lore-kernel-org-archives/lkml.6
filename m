Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751191AbeFCJdH (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 05:33:07 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:45144 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750810AbeFCJdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 05:33:05 -0400
From: YueHaibing <yuehaibing@huawei.com>
To: <oulijun@huawei.com>, <xavier.huwei@huawei.com>
CC: <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dledford@redhat.com>, <jgg@ziepe.ca>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] IB/hns: Use zeroing memory allocator instead of allocator/memset
Date: Sun, 3 Jun 2018 17:32:22 +0800
Message-ID: <20180603093222.24308-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use dma_zalloc_coherent for allocating zeroed memory and
remove unnecessary memset function.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_alloc.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_alloc.c b/drivers/infiniband/hw/hns/hns_roce_alloc.c
index a40ec93..46f65f9 100644
--- a/drivers/infiniband/hw/hns/hns_roce_alloc.c
+++ b/drivers/infiniband/hw/hns/hns_roce_alloc.c
@@ -197,7 +197,8 @@ int hns_roce_buf_alloc(struct hns_roce_dev *hr_dev, u32 size, u32 max_direct,
 		buf->npages = 1 << order;
 		buf->page_shift = page_shift;
 		/* MTT PA must be recorded in 4k alignment, t is 4k aligned */
-		buf->direct.buf = dma_alloc_coherent(dev, size, &t, GFP_KERNEL);
+		buf->direct.buf = dma_zalloc_coherent(dev,
+						      size, &t, GFP_KERNEL);
 		if (!buf->direct.buf)
 			return -ENOMEM;
 
@@ -207,8 +208,6 @@ int hns_roce_buf_alloc(struct hns_roce_dev *hr_dev, u32 size, u32 max_direct,
 			--buf->page_shift;
 			buf->npages *= 2;
 		}
-
-		memset(buf->direct.buf, 0, size);
 	} else {
 		buf->nbufs = (size + page_size - 1) / page_size;
 		buf->npages = buf->nbufs;
@@ -220,7 +219,7 @@ int hns_roce_buf_alloc(struct hns_roce_dev *hr_dev, u32 size, u32 max_direct,
 			return -ENOMEM;
 
 		for (i = 0; i < buf->nbufs; ++i) {
-			buf->page_list[i].buf = dma_alloc_coherent(dev,
+			buf->page_list[i].buf = dma_zalloc_coherent(dev,
 								  page_size, &t,
 								  GFP_KERNEL);
 
@@ -228,7 +227,6 @@ int hns_roce_buf_alloc(struct hns_roce_dev *hr_dev, u32 size, u32 max_direct,
 				goto err_free;
 
 			buf->page_list[i].map = t;
-			memset(buf->page_list[i].buf, 0, page_size);
 		}
 	}
 
-- 
2.7.0
