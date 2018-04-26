Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752171AbeDZEum (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 00:50:42 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:58095 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751895AbeDZEui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 00:50:38 -0400
From: YueHaibing <yuehaibing@huawei.com>
To: <will.deacon@arm.com>, <robin.murphy@arm.com>, <joro@8bytes.org>
CC: <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] iommu/io-pgtable-arm: Use for_each_set_bit to simplify code
Date: Thu, 26 Apr 2018 12:49:29 +0800
Message-ID: <20180426044929.16896-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can use for_each_set_bit() to simplify code slightly in the
ARM io-pgtable self tests while unmapping.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/iommu/io-pgtable-arm-v7s.c | 5 +----
 drivers/iommu/io-pgtable-arm.c     | 5 +----
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index 10e4a3d..50e3a9f 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -898,8 +898,7 @@ static int __init arm_v7s_do_selftests(void)
 
 	/* Full unmap */
 	iova = 0;
-	i = find_first_bit(&cfg.pgsize_bitmap, BITS_PER_LONG);
-	while (i != BITS_PER_LONG) {
+	for_each_set_bit(i, &cfg.pgsize_bitmap, BITS_PER_LONG) {
 		size = 1UL << i;
 
 		if (ops->unmap(ops, iova, size) != size)
@@ -916,8 +915,6 @@ static int __init arm_v7s_do_selftests(void)
 			return __FAIL(ops);
 
 		iova += SZ_16M;
-		i++;
-		i = find_next_bit(&cfg.pgsize_bitmap, BITS_PER_LONG, i);
 	}
 
 	free_io_pgtable_ops(ops);
diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 39c2a05..4ffdd88 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -1120,8 +1120,7 @@ static int __init arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
 
 		/* Full unmap */
 		iova = 0;
-		j = find_first_bit(&cfg->pgsize_bitmap, BITS_PER_LONG);
-		while (j != BITS_PER_LONG) {
+		for_each_set_bit(j, &cfg->pgsize_bitmap, BITS_PER_LONG) {
 			size = 1UL << j;
 
 			if (ops->unmap(ops, iova, size) != size)
@@ -1138,8 +1137,6 @@ static int __init arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
 				return __FAIL(ops, i);
 
 			iova += SZ_1G;
-			j++;
-			j = find_next_bit(&cfg->pgsize_bitmap, BITS_PER_LONG, j);
 		}
 
 		free_io_pgtable_ops(ops);
-- 
2.7.0
