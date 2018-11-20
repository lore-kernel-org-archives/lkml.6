Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69AEC18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90B7A2087E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:41:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90B7A2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbeKUAKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:10:41 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:15122 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726205AbeKUAKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 19:10:41 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D54D0BDD18444;
        Tue, 20 Nov 2018 21:41:22 +0800 (CST)
Received: from localhost.localdomain (10.175.34.53) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.408.0; Tue, 20 Nov 2018 21:41:16 +0800
From:   Xue Chaojing <xuechaojing@huawei.com>
To:     <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <xuechaojing@huawei.com>,
        <netdev@vger.kernel.org>, <wulike1@huawei.com>,
        <chiqijun@huawei.com>, <fy.wang@huawei.com>, <tony.qu@huawei.com>,
        <luoshaokai@huawei.com>
Subject: [PATCH 1/4] net-next/hinic:replace multiply and division operators
Date:   Tue, 20 Nov 2018 05:47:31 +0000
Message-ID: <20181120054734.17360-1-xuechaojing@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.34.53]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To improve performance, this patch uses bit operations to replace
multiply and division operators.

Signed-off-by: Xue Chaojing <xuechaojing@huawei.com>
---
 .../net/ethernet/huawei/hinic/hinic_hw_wq.c   | 55 ++++++++++++-------
 .../net/ethernet/huawei/hinic/hinic_hw_wq.h   |  3 +-
 2 files changed, 38 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic/hinic_hw_wq.c b/drivers/net/ethernet/huawei/hinic/hinic_hw_wq.c
index f92f1bf3901a..1dfa7eb05c10 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_hw_wq.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_hw_wq.c
@@ -74,12 +74,6 @@
 			((void *)((cmdq_pages)->shadow_page_vaddr) \
 				+ (wq)->block_idx * CMDQ_BLOCK_SIZE)
 
-#define WQE_PAGE_OFF(wq, idx)   (((idx) & ((wq)->num_wqebbs_per_page - 1)) * \
-					(wq)->wqebb_size)
-
-#define WQE_PAGE_NUM(wq, idx)   (((idx) / ((wq)->num_wqebbs_per_page)) \
-					& ((wq)->num_q_pages - 1))
-
 #define WQ_PAGE_ADDR(wq, idx)           \
 			((wq)->shadow_block_vaddr[WQE_PAGE_NUM(wq, idx)])
 
@@ -93,6 +87,17 @@
 		(((unsigned long)(wqe) - (unsigned long)(wq)->shadow_wqe) \
 			/ (wq)->max_wqe_size)
 
+static inline int WQE_PAGE_OFF(struct hinic_wq *wq, u16 idx)
+{
+	return (((idx) & ((wq)->num_wqebbs_per_page - 1))
+		<< (wq)->wqebb_size_shift);
+}
+
+static inline int WQE_PAGE_NUM(struct hinic_wq *wq, u16 idx)
+{
+	return (((idx) >> ((wq)->wqebbs_per_page_shift))
+		& ((wq)->num_q_pages - 1));
+}
 /**
  * queue_alloc_page - allocate page for Queue
  * @hwif: HW interface for allocating DMA
@@ -513,10 +518,11 @@ int hinic_wq_allocate(struct hinic_wqs *wqs, struct hinic_wq *wq,
 	struct hinic_hwif *hwif = wqs->hwif;
 	struct pci_dev *pdev = hwif->pdev;
 	u16 num_wqebbs_per_page;
+	u16 wqebb_size_shift;
 	int err;
 
-	if (wqebb_size == 0) {
-		dev_err(&pdev->dev, "wqebb_size must be > 0\n");
+	if (!is_power_of_2(wqebb_size)) {
+		dev_err(&pdev->dev, "wqebb_size must be power of 2\n");
 		return -EINVAL;
 	}
 
@@ -530,9 +536,11 @@ int hinic_wq_allocate(struct hinic_wqs *wqs, struct hinic_wq *wq,
 		return -EINVAL;
 	}
 
-	num_wqebbs_per_page = ALIGN(wq_page_size, wqebb_size) / wqebb_size;
+	wqebb_size_shift = ilog2(wqebb_size);
+	num_wqebbs_per_page = ALIGN(wq_page_size, wqebb_size)
+				>> wqebb_size_shift;
 
-	if (num_wqebbs_per_page & (num_wqebbs_per_page - 1)) {
+	if (!is_power_of_2(num_wqebbs_per_page)) {
 		dev_err(&pdev->dev, "num wqebbs per page must be power of 2\n");
 		return -EINVAL;
 	}
@@ -550,7 +558,8 @@ int hinic_wq_allocate(struct hinic_wqs *wqs, struct hinic_wq *wq,
 	wq->q_depth = q_depth;
 	wq->max_wqe_size = max_wqe_size;
 	wq->num_wqebbs_per_page = num_wqebbs_per_page;
-
+	wq->wqebbs_per_page_shift = ilog2(num_wqebbs_per_page);
+	wq->wqebb_size_shift = wqebb_size_shift;
 	wq->block_vaddr = WQ_BASE_VADDR(wqs, wq);
 	wq->shadow_block_vaddr = WQ_BASE_ADDR(wqs, wq);
 	wq->block_paddr = WQ_BASE_PADDR(wqs, wq);
@@ -604,11 +613,13 @@ int hinic_wqs_cmdq_alloc(struct hinic_cmdq_pages *cmdq_pages,
 			 u16 q_depth, u16 max_wqe_size)
 {
 	struct pci_dev *pdev = hwif->pdev;
+	u16 num_wqebbs_per_page_shift;
 	u16 num_wqebbs_per_page;
+	u16 wqebb_size_shift;
 	int i, j, err = -ENOMEM;
 
-	if (wqebb_size == 0) {
-		dev_err(&pdev->dev, "wqebb_size must be > 0\n");
+	if (!is_power_of_2(wqebb_size)) {
+		dev_err(&pdev->dev, "wqebb_size must be power of 2\n");
 		return -EINVAL;
 	}
 
@@ -622,9 +633,11 @@ int hinic_wqs_cmdq_alloc(struct hinic_cmdq_pages *cmdq_pages,
 		return -EINVAL;
 	}
 
-	num_wqebbs_per_page = ALIGN(wq_page_size, wqebb_size) / wqebb_size;
+	wqebb_size_shift = ilog2(wqebb_size);
+	num_wqebbs_per_page = ALIGN(wq_page_size, wqebb_size)
+				>> wqebb_size_shift;
 
-	if (num_wqebbs_per_page & (num_wqebbs_per_page - 1)) {
+	if (!is_power_of_2(num_wqebbs_per_page)) {
 		dev_err(&pdev->dev, "num wqebbs per page must be power of 2\n");
 		return -EINVAL;
 	}
@@ -636,6 +649,7 @@ int hinic_wqs_cmdq_alloc(struct hinic_cmdq_pages *cmdq_pages,
 		dev_err(&pdev->dev, "Failed to allocate CMDQ page\n");
 		return err;
 	}
+	num_wqebbs_per_page_shift = ilog2(num_wqebbs_per_page);
 
 	for (i = 0; i < cmdq_blocks; i++) {
 		wq[i].hwif = hwif;
@@ -647,7 +661,8 @@ int hinic_wqs_cmdq_alloc(struct hinic_cmdq_pages *cmdq_pages,
 		wq[i].q_depth = q_depth;
 		wq[i].max_wqe_size = max_wqe_size;
 		wq[i].num_wqebbs_per_page = num_wqebbs_per_page;
-
+		wq[i].wqebbs_per_page_shift = num_wqebbs_per_page_shift;
+		wq[i].wqebb_size_shift = wqebb_size_shift;
 		wq[i].block_vaddr = CMDQ_BASE_VADDR(cmdq_pages, &wq[i]);
 		wq[i].shadow_block_vaddr = CMDQ_BASE_ADDR(cmdq_pages, &wq[i]);
 		wq[i].block_paddr = CMDQ_BASE_PADDR(cmdq_pages, &wq[i]);
@@ -741,7 +756,7 @@ struct hinic_hw_wqe *hinic_get_wqe(struct hinic_wq *wq, unsigned int wqe_size,
 
 	*prod_idx = MASKED_WQE_IDX(wq, atomic_read(&wq->prod_idx));
 
-	num_wqebbs = ALIGN(wqe_size, wq->wqebb_size) / wq->wqebb_size;
+	num_wqebbs = ALIGN(wqe_size, wq->wqebb_size) >> wq->wqebb_size_shift;
 
 	if (atomic_sub_return(num_wqebbs, &wq->delta) <= 0) {
 		atomic_add(num_wqebbs, &wq->delta);
@@ -795,7 +810,8 @@ void hinic_return_wqe(struct hinic_wq *wq, unsigned int wqe_size)
  **/
 void hinic_put_wqe(struct hinic_wq *wq, unsigned int wqe_size)
 {
-	int num_wqebbs = ALIGN(wqe_size, wq->wqebb_size) / wq->wqebb_size;
+	int num_wqebbs = ALIGN(wqe_size, wq->wqebb_size)
+			>> wq->wqebb_size_shift;
 
 	atomic_add(num_wqebbs, &wq->cons_idx);
 
@@ -813,7 +829,8 @@ void hinic_put_wqe(struct hinic_wq *wq, unsigned int wqe_size)
 struct hinic_hw_wqe *hinic_read_wqe(struct hinic_wq *wq, unsigned int wqe_size,
 				    u16 *cons_idx)
 {
-	int num_wqebbs = ALIGN(wqe_size, wq->wqebb_size) / wq->wqebb_size;
+	int num_wqebbs = ALIGN(wqe_size, wq->wqebb_size)
+			>> wq->wqebb_size_shift;
 	u16 curr_cons_idx, end_cons_idx;
 	int curr_pg, end_pg;
 
diff --git a/drivers/net/ethernet/huawei/hinic/hinic_hw_wq.h b/drivers/net/ethernet/huawei/hinic/hinic_hw_wq.h
index 9b66545ba563..0a936cd6709b 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_hw_wq.h
+++ b/drivers/net/ethernet/huawei/hinic/hinic_hw_wq.h
@@ -39,7 +39,8 @@ struct hinic_wq {
 	u16             q_depth;
 	u16             max_wqe_size;
 	u16             num_wqebbs_per_page;
-
+	u16		wqebbs_per_page_shift;
+	u16		wqebb_size_shift;
 	/* The addresses are 64 bit in the HW */
 	u64             block_paddr;
 	void            **shadow_block_vaddr;
-- 
2.17.1

