Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B9FC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 13:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EB6A20839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 13:20:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EB6A20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727748AbeIKSTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 14:19:55 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:37372 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726622AbeIKSTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 14:19:55 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BF07FDF48C3ED;
        Tue, 11 Sep 2018 21:20:28 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.399.0; Tue, 11 Sep 2018 21:20:28 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <davem@davemloft.net>, <claudiu.manoil@nxp.com>,
        <tariqt@mellanox.com>, <saeedm@mellanox.com>,
        <derek.chickles@caviumnetworks.com>
CC:     <leon@kernel.org>, <jdmason@kudzu.us>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] net: ethernet: Use DIV_ROUND_UP instead of reimplementing its function
Date:   Tue, 11 Sep 2018 21:08:15 +0800
Message-ID: <1536671295-14432-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DIV_ROUND_UP has implemented the code-opened function. Therefore, just
replace the implementation with DIV_ROUND_UP.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/net/ethernet/broadcom/sb1250-mac.c         | 2 +-
 drivers/net/ethernet/cavium/liquidio/octeon_droq.c | 2 +-
 drivers/net/ethernet/freescale/gianfar_ethtool.c   | 2 +-
 drivers/net/ethernet/ibm/emac/mal.h                | 2 +-
 drivers/net/ethernet/mellanox/mlx4/alloc.c         | 2 +-
 drivers/net/ethernet/mellanox/mlx4/icm.c           | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/srq.c      | 2 +-
 drivers/net/ethernet/neterion/s2io.c               | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/sb1250-mac.c b/drivers/net/ethernet/broadcom/sb1250-mac.c
index ef4a0c3..1082529 100644
--- a/drivers/net/ethernet/broadcom/sb1250-mac.c
+++ b/drivers/net/ethernet/broadcom/sb1250-mac.c
@@ -156,7 +156,7 @@ enum sbmac_state {
 			  (d)->sbdma_dscrtable : (d)->f+1)
 
 
-#define NUMCACHEBLKS(x) (((x)+SMP_CACHE_BYTES-1)/SMP_CACHE_BYTES)
+#define NUMCACHEBLKS(x) DIV_ROUND_UP(x, SMP_CACHE_BYTES)
 
 #define SBMAC_MAX_TXDESCR	256
 #define SBMAC_MAX_RXDESCR	256
diff --git a/drivers/net/ethernet/cavium/liquidio/octeon_droq.c b/drivers/net/ethernet/cavium/liquidio/octeon_droq.c
index a71dbb7..b57008d 100644
--- a/drivers/net/ethernet/cavium/liquidio/octeon_droq.c
+++ b/drivers/net/ethernet/cavium/liquidio/octeon_droq.c
@@ -530,7 +530,7 @@ void octeon_droq_check_oom(struct octeon_droq *droq)
 static inline u32
 octeon_droq_get_bufcount(u32 buf_size, u32 total_len)
 {
-	return ((total_len + buf_size - 1) / buf_size);
+	return DIV_ROUND_UP(total_len, buf_size);
 }
 
 static int
diff --git a/drivers/net/ethernet/freescale/gianfar_ethtool.c b/drivers/net/ethernet/freescale/gianfar_ethtool.c
index 395a526..b536eb0 100644
--- a/drivers/net/ethernet/freescale/gianfar_ethtool.c
+++ b/drivers/net/ethernet/freescale/gianfar_ethtool.c
@@ -230,7 +230,7 @@ static unsigned int gfar_usecs2ticks(struct gfar_private *priv,
 
 	/* Make sure we return a number greater than 0
 	 * if usecs > 0 */
-	return (usecs * 1000 + count - 1) / count;
+	return DIV_ROUND_UP(usecs * 1000, count);
 }
 
 /* Convert ethernet clock ticks to microseconds */
diff --git a/drivers/net/ethernet/ibm/emac/mal.h b/drivers/net/ethernet/ibm/emac/mal.h
index eeade2e..e4c20f0 100644
--- a/drivers/net/ethernet/ibm/emac/mal.h
+++ b/drivers/net/ethernet/ibm/emac/mal.h
@@ -136,7 +136,7 @@ static inline int mal_rx_size(int len)
 
 static inline int mal_tx_chunks(int len)
 {
-	return (len + MAL_MAX_TX_SIZE - 1) / MAL_MAX_TX_SIZE;
+	return DIV_ROUND_UP(len, MAL_MAX_TX_SIZE);
 }
 
 #define MAL_CHAN_MASK(n)	(0x80000000 >> (n))
diff --git a/drivers/net/ethernet/mellanox/mlx4/alloc.c b/drivers/net/ethernet/mellanox/mlx4/alloc.c
index 4bdf250..deef5a9 100644
--- a/drivers/net/ethernet/mellanox/mlx4/alloc.c
+++ b/drivers/net/ethernet/mellanox/mlx4/alloc.c
@@ -614,7 +614,7 @@ int mlx4_buf_alloc(struct mlx4_dev *dev, int size, int max_direct,
 		int i;
 
 		buf->direct.buf = NULL;
-		buf->nbufs	= (size + PAGE_SIZE - 1) / PAGE_SIZE;
+		buf->nbufs      = DIV_ROUND_UP(size, PAGE_SIZE);
 		buf->npages	= buf->nbufs;
 		buf->page_shift  = PAGE_SHIFT;
 		buf->page_list   = kcalloc(buf->nbufs, sizeof(*buf->page_list),
diff --git a/drivers/net/ethernet/mellanox/mlx4/icm.c b/drivers/net/ethernet/mellanox/mlx4/icm.c
index 7262c63..4b43511 100644
--- a/drivers/net/ethernet/mellanox/mlx4/icm.c
+++ b/drivers/net/ethernet/mellanox/mlx4/icm.c
@@ -406,7 +406,7 @@ int mlx4_init_icm_table(struct mlx4_dev *dev, struct mlx4_icm_table *table,
 	obj_per_chunk = MLX4_TABLE_CHUNK_SIZE / obj_size;
 	if (WARN_ON(!obj_per_chunk))
 		return -EINVAL;
-	num_icm = (nobj + obj_per_chunk - 1) / obj_per_chunk;
+	num_icm = DIV_ROUND_UP(nobj, obj_per_chunk);
 
 	table->icm      = kvcalloc(num_icm, sizeof(*table->icm), GFP_KERNEL);
 	if (!table->icm)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/srq.c b/drivers/net/ethernet/mellanox/mlx5/core/srq.c
index 23cc337..7e20666 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/srq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/srq.c
@@ -73,7 +73,7 @@ static int get_pas_size(struct mlx5_srq_attr *in)
 	u32 rq_sz	  = 1 << (log_srq_size + 4 + log_rq_stride);
 	u32 page_size	  = 1 << log_page_size;
 	u32 rq_sz_po      = rq_sz + (page_offset * po_quanta);
-	u32 rq_num_pas	  = (rq_sz_po + page_size - 1) / page_size;
+	u32 rq_num_pas    = DIV_ROUND_UP(rq_sz_po, page_size);
 
 	return rq_num_pas * sizeof(u64);
 }
diff --git a/drivers/net/ethernet/neterion/s2io.c b/drivers/net/ethernet/neterion/s2io.c
index b8983e7..f980f10 100644
--- a/drivers/net/ethernet/neterion/s2io.c
+++ b/drivers/net/ethernet/neterion/s2io.c
@@ -491,7 +491,7 @@ static void do_s2io_copy_mac_addr(struct s2io_nic *sp, int offset, u64 mac_addr)
 };
 
 /* A simplifier macro used both by init and free shared_mem Fns(). */
-#define TXD_MEM_PAGE_CNT(len, per_each) ((len+per_each - 1) / per_each)
+#define TXD_MEM_PAGE_CNT(len, per_each) DIV_ROUND_UP(len, per_each)
 
 /* netqueue manipulation helper functions */
 static inline void s2io_stop_all_tx_queue(struct s2io_nic *sp)
-- 
1.7.12.4

