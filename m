Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF352C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD03D20892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544791210;
	bh=tjsQq3/e1m1dJ/G79ICOgn5EZ4qEYqRFcjPmxADcLBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mJuG6lfhG1zLDsTChQPdyIWkql8eZx+RaFJFc9RNlWVlXv6Ps+baKtiIh1BVJstNh
	 UjVtRITnBz8v0FfchLUF+OiQF3/OHnAY9xyAH0W9QpqTDs322PunX2EdAbLbwPXPNn
	 Zl0pbWwI8pJHY39/6yxE9DLeDd03m68dLTv7wZzU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD03D20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730721AbeLNMkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:40:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:49128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728415AbeLNME0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:04:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D80A621479;
        Fri, 14 Dec 2018 12:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789065;
        bh=tjsQq3/e1m1dJ/G79ICOgn5EZ4qEYqRFcjPmxADcLBM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cU0zl5jLx9Cn7DIYLFflpX+ap4Fh/JRbkp5OOSjSZIJG+QOEiKBkG0wPJxAFp0zen
         ls+oY/q79XvX60LXW9PhPKOCzH7LCqTBmFbtigy37s8GM8ekmOYK6OAym00qatAPTt
         DIMSvyi8/iwuZUp9ym7QfTEPkgQRwV973pbmraNg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yixian Liu <liuyixian@huawei.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 081/142] RDMA/hns: Bugfix pbl configuration for rereg mr
Date:   Fri, 14 Dec 2018 12:59:26 +0100
Message-Id: <20181214115750.306835397@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit ca088320a02537f36c243ac21794525d8eabb3bd ]

Current hns driver assigned the first two PBL page addresses from previous
registered MR to the hardware when reregister MR changing the memory
locations occurred. This will lead to PBL addressing error as the PBL has
already been released. This patch fixes this wrong assignment by using the
page address from new allocated PBL.

Fixes: a2c80b7b4119 ("RDMA/hns: Add rereg mr support for hip08")
Signed-off-by: Yixian Liu <liuyixian@huawei.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 128 ++++++++++-----------
 1 file changed, 60 insertions(+), 68 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 0218c0f8c2a7..a442b29e7611 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1661,10 +1661,9 @@ static int hns_roce_v2_set_mac(struct hns_roce_dev *hr_dev, u8 phy_port,
 	return hns_roce_cmq_send(hr_dev, &desc, 1);
 }
 
-static int hns_roce_v2_write_mtpt(void *mb_buf, struct hns_roce_mr *mr,
-				  unsigned long mtpt_idx)
+static int set_mtpt_pbl(struct hns_roce_v2_mpt_entry *mpt_entry,
+			struct hns_roce_mr *mr)
 {
-	struct hns_roce_v2_mpt_entry *mpt_entry;
 	struct scatterlist *sg;
 	u64 page_addr;
 	u64 *pages;
@@ -1672,6 +1671,53 @@ static int hns_roce_v2_write_mtpt(void *mb_buf, struct hns_roce_mr *mr,
 	int len;
 	int entry;
 
+	mpt_entry->pbl_size = cpu_to_le32(mr->pbl_size);
+	mpt_entry->pbl_ba_l = cpu_to_le32(lower_32_bits(mr->pbl_ba >> 3));
+	roce_set_field(mpt_entry->byte_48_mode_ba,
+		       V2_MPT_BYTE_48_PBL_BA_H_M, V2_MPT_BYTE_48_PBL_BA_H_S,
+		       upper_32_bits(mr->pbl_ba >> 3));
+
+	pages = (u64 *)__get_free_page(GFP_KERNEL);
+	if (!pages)
+		return -ENOMEM;
+
+	i = 0;
+	for_each_sg(mr->umem->sg_head.sgl, sg, mr->umem->nmap, entry) {
+		len = sg_dma_len(sg) >> PAGE_SHIFT;
+		for (j = 0; j < len; ++j) {
+			page_addr = sg_dma_address(sg) +
+				(j << mr->umem->page_shift);
+			pages[i] = page_addr >> 6;
+			/* Record the first 2 entry directly to MTPT table */
+			if (i >= HNS_ROCE_V2_MAX_INNER_MTPT_NUM - 1)
+				goto found;
+			i++;
+		}
+	}
+found:
+	mpt_entry->pa0_l = cpu_to_le32(lower_32_bits(pages[0]));
+	roce_set_field(mpt_entry->byte_56_pa0_h, V2_MPT_BYTE_56_PA0_H_M,
+		       V2_MPT_BYTE_56_PA0_H_S, upper_32_bits(pages[0]));
+
+	mpt_entry->pa1_l = cpu_to_le32(lower_32_bits(pages[1]));
+	roce_set_field(mpt_entry->byte_64_buf_pa1, V2_MPT_BYTE_64_PA1_H_M,
+		       V2_MPT_BYTE_64_PA1_H_S, upper_32_bits(pages[1]));
+	roce_set_field(mpt_entry->byte_64_buf_pa1,
+		       V2_MPT_BYTE_64_PBL_BUF_PG_SZ_M,
+		       V2_MPT_BYTE_64_PBL_BUF_PG_SZ_S,
+		       mr->pbl_buf_pg_sz + PG_SHIFT_OFFSET);
+
+	free_page((unsigned long)pages);
+
+	return 0;
+}
+
+static int hns_roce_v2_write_mtpt(void *mb_buf, struct hns_roce_mr *mr,
+				  unsigned long mtpt_idx)
+{
+	struct hns_roce_v2_mpt_entry *mpt_entry;
+	int ret;
+
 	mpt_entry = mb_buf;
 	memset(mpt_entry, 0, sizeof(*mpt_entry));
 
@@ -1686,7 +1732,6 @@ static int hns_roce_v2_write_mtpt(void *mb_buf, struct hns_roce_mr *mr,
 		       mr->pbl_ba_pg_sz + PG_SHIFT_OFFSET);
 	roce_set_field(mpt_entry->byte_4_pd_hop_st, V2_MPT_BYTE_4_PD_M,
 		       V2_MPT_BYTE_4_PD_S, mr->pd);
-	mpt_entry->byte_4_pd_hop_st = cpu_to_le32(mpt_entry->byte_4_pd_hop_st);
 
 	roce_set_bit(mpt_entry->byte_8_mw_cnt_en, V2_MPT_BYTE_8_RA_EN_S, 0);
 	roce_set_bit(mpt_entry->byte_8_mw_cnt_en, V2_MPT_BYTE_8_R_INV_EN_S, 1);
@@ -1700,13 +1745,11 @@ static int hns_roce_v2_write_mtpt(void *mb_buf, struct hns_roce_mr *mr,
 		     (mr->access & IB_ACCESS_REMOTE_WRITE ? 1 : 0));
 	roce_set_bit(mpt_entry->byte_8_mw_cnt_en, V2_MPT_BYTE_8_LW_EN_S,
 		     (mr->access & IB_ACCESS_LOCAL_WRITE ? 1 : 0));
-	mpt_entry->byte_8_mw_cnt_en = cpu_to_le32(mpt_entry->byte_8_mw_cnt_en);
 
 	roce_set_bit(mpt_entry->byte_12_mw_pa, V2_MPT_BYTE_12_PA_S,
 		     mr->type == MR_TYPE_MR ? 0 : 1);
 	roce_set_bit(mpt_entry->byte_12_mw_pa, V2_MPT_BYTE_12_INNER_PA_VLD_S,
 		     1);
-	mpt_entry->byte_12_mw_pa = cpu_to_le32(mpt_entry->byte_12_mw_pa);
 
 	mpt_entry->len_l = cpu_to_le32(lower_32_bits(mr->size));
 	mpt_entry->len_h = cpu_to_le32(upper_32_bits(mr->size));
@@ -1717,53 +1760,9 @@ static int hns_roce_v2_write_mtpt(void *mb_buf, struct hns_roce_mr *mr,
 	if (mr->type == MR_TYPE_DMA)
 		return 0;
 
-	mpt_entry->pbl_size = cpu_to_le32(mr->pbl_size);
-
-	mpt_entry->pbl_ba_l = cpu_to_le32(lower_32_bits(mr->pbl_ba >> 3));
-	roce_set_field(mpt_entry->byte_48_mode_ba, V2_MPT_BYTE_48_PBL_BA_H_M,
-		       V2_MPT_BYTE_48_PBL_BA_H_S,
-		       upper_32_bits(mr->pbl_ba >> 3));
-	mpt_entry->byte_48_mode_ba = cpu_to_le32(mpt_entry->byte_48_mode_ba);
-
-	pages = (u64 *)__get_free_page(GFP_KERNEL);
-	if (!pages)
-		return -ENOMEM;
-
-	i = 0;
-	for_each_sg(mr->umem->sg_head.sgl, sg, mr->umem->nmap, entry) {
-		len = sg_dma_len(sg) >> PAGE_SHIFT;
-		for (j = 0; j < len; ++j) {
-			page_addr = sg_dma_address(sg) +
-				    (j << mr->umem->page_shift);
-			pages[i] = page_addr >> 6;
-
-			/* Record the first 2 entry directly to MTPT table */
-			if (i >= HNS_ROCE_V2_MAX_INNER_MTPT_NUM - 1)
-				goto found;
-			i++;
-		}
-	}
+	ret = set_mtpt_pbl(mpt_entry, mr);
 
-found:
-	mpt_entry->pa0_l = cpu_to_le32(lower_32_bits(pages[0]));
-	roce_set_field(mpt_entry->byte_56_pa0_h, V2_MPT_BYTE_56_PA0_H_M,
-		       V2_MPT_BYTE_56_PA0_H_S,
-		       upper_32_bits(pages[0]));
-	mpt_entry->byte_56_pa0_h = cpu_to_le32(mpt_entry->byte_56_pa0_h);
-
-	mpt_entry->pa1_l = cpu_to_le32(lower_32_bits(pages[1]));
-	roce_set_field(mpt_entry->byte_64_buf_pa1, V2_MPT_BYTE_64_PA1_H_M,
-		       V2_MPT_BYTE_64_PA1_H_S, upper_32_bits(pages[1]));
-
-	free_page((unsigned long)pages);
-
-	roce_set_field(mpt_entry->byte_64_buf_pa1,
-		       V2_MPT_BYTE_64_PBL_BUF_PG_SZ_M,
-		       V2_MPT_BYTE_64_PBL_BUF_PG_SZ_S,
-		       mr->pbl_buf_pg_sz + PG_SHIFT_OFFSET);
-	mpt_entry->byte_64_buf_pa1 = cpu_to_le32(mpt_entry->byte_64_buf_pa1);
-
-	return 0;
+	return ret;
 }
 
 static int hns_roce_v2_rereg_write_mtpt(struct hns_roce_dev *hr_dev,
@@ -1772,6 +1771,7 @@ static int hns_roce_v2_rereg_write_mtpt(struct hns_roce_dev *hr_dev,
 					u64 size, void *mb_buf)
 {
 	struct hns_roce_v2_mpt_entry *mpt_entry = mb_buf;
+	int ret = 0;
 
 	if (flags & IB_MR_REREG_PD) {
 		roce_set_field(mpt_entry->byte_4_pd_hop_st, V2_MPT_BYTE_4_PD_M,
@@ -1784,14 +1784,14 @@ static int hns_roce_v2_rereg_write_mtpt(struct hns_roce_dev *hr_dev,
 			     V2_MPT_BYTE_8_BIND_EN_S,
 			     (mr_access_flags & IB_ACCESS_MW_BIND ? 1 : 0));
 		roce_set_bit(mpt_entry->byte_8_mw_cnt_en,
-			   V2_MPT_BYTE_8_ATOMIC_EN_S,
-			   (mr_access_flags & IB_ACCESS_REMOTE_ATOMIC ? 1 : 0));
+			     V2_MPT_BYTE_8_ATOMIC_EN_S,
+			     mr_access_flags & IB_ACCESS_REMOTE_ATOMIC ? 1 : 0);
 		roce_set_bit(mpt_entry->byte_8_mw_cnt_en, V2_MPT_BYTE_8_RR_EN_S,
-			     (mr_access_flags & IB_ACCESS_REMOTE_READ ? 1 : 0));
+			     mr_access_flags & IB_ACCESS_REMOTE_READ ? 1 : 0);
 		roce_set_bit(mpt_entry->byte_8_mw_cnt_en, V2_MPT_BYTE_8_RW_EN_S,
-			    (mr_access_flags & IB_ACCESS_REMOTE_WRITE ? 1 : 0));
+			     mr_access_flags & IB_ACCESS_REMOTE_WRITE ? 1 : 0);
 		roce_set_bit(mpt_entry->byte_8_mw_cnt_en, V2_MPT_BYTE_8_LW_EN_S,
-			     (mr_access_flags & IB_ACCESS_LOCAL_WRITE ? 1 : 0));
+			     mr_access_flags & IB_ACCESS_LOCAL_WRITE ? 1 : 0);
 	}
 
 	if (flags & IB_MR_REREG_TRANS) {
@@ -1800,21 +1800,13 @@ static int hns_roce_v2_rereg_write_mtpt(struct hns_roce_dev *hr_dev,
 		mpt_entry->len_l = cpu_to_le32(lower_32_bits(size));
 		mpt_entry->len_h = cpu_to_le32(upper_32_bits(size));
 
-		mpt_entry->pbl_size = cpu_to_le32(mr->pbl_size);
-		mpt_entry->pbl_ba_l =
-				cpu_to_le32(lower_32_bits(mr->pbl_ba >> 3));
-		roce_set_field(mpt_entry->byte_48_mode_ba,
-			       V2_MPT_BYTE_48_PBL_BA_H_M,
-			       V2_MPT_BYTE_48_PBL_BA_H_S,
-			       upper_32_bits(mr->pbl_ba >> 3));
-		mpt_entry->byte_48_mode_ba =
-				cpu_to_le32(mpt_entry->byte_48_mode_ba);
-
 		mr->iova = iova;
 		mr->size = size;
+
+		ret = set_mtpt_pbl(mpt_entry, mr);
 	}
 
-	return 0;
+	return ret;
 }
 
 static void *get_cqe_v2(struct hns_roce_cq *hr_cq, int n)
-- 
2.19.1



