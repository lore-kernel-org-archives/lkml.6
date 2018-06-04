Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753262AbeFDNLE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 09:11:04 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8635 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753001AbeFDNLD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 09:11:03 -0400
From: YueHaibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>, <Ariel.Elior@cavium.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <everest-linux-l2@cavium.com>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] qed: use dma_zalloc_coherent instead of allocator/memset
Date: Mon, 4 Jun 2018 21:10:31 +0800
Message-ID: <20180604131031.24476-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use dma_zalloc_coherent instead of dma_alloc_coherent
followed by memset 0.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/qlogic/qed/qed_cxt.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_cxt.c b/drivers/net/ethernet/qlogic/qed/qed_cxt.c
index 820b226..1835f00 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_cxt.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_cxt.c
@@ -936,14 +936,13 @@ static int qed_cxt_src_t2_alloc(struct qed_hwfn *p_hwfn)
 		u32 size = min_t(u32, total_size, psz);
 		void **p_virt = &p_mngr->t2[i].p_virt;
 
-		*p_virt = dma_alloc_coherent(&p_hwfn->cdev->pdev->dev,
-					     size,
-					     &p_mngr->t2[i].p_phys, GFP_KERNEL);
+		*p_virt = dma_zalloc_coherent(&p_hwfn->cdev->pdev->dev,
+					      size, &p_mngr->t2[i].p_phys,
+					      GFP_KERNEL);
 		if (!p_mngr->t2[i].p_virt) {
 			rc = -ENOMEM;
 			goto t2_fail;
 		}
-		memset(*p_virt, 0, size);
 		p_mngr->t2[i].size = size;
 		total_size -= size;
 	}
-- 
2.7.0
