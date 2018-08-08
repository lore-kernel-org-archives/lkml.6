Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59576C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDFC3219C9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:33:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDFC3219C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbeHHQxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 12:53:04 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10682 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726875AbeHHQxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 12:53:04 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id ACFC53C25651D;
        Wed,  8 Aug 2018 22:33:02 +0800 (CST)
Received: from localhost.localdomain (10.175.34.53) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.399.0; Wed, 8 Aug 2018 22:32:57 +0800
From:   Zhao Chen <zhaochen6@huawei.com>
To:     <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <zhaochen6@huawei.com>, <tony.qu@huawei.com>,
        <yin.yinshi@huawei.com>, <luoshaokai@huawei.com>,
        <fy.wang@huawei.com>, <luoxianjun@huawei.com>,
        <wangzhou1@hisilicon.com>
Subject: [PATCH 1/1] net-next: hinic: fix a problem in free_tx_poll()
Date:   Wed, 8 Aug 2018 06:37:30 +0000
Message-ID: <20180808063730.12198-1-zhaochen6@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.34.53]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the problem below. The problem can be reproduced by the
following steps:
1) Connecting all HiNIC interfaces
2) On server side
    # sudo ifconfig eth0 192.168.100.1 up #Using MLX CX4 card
    # iperf -s
3) On client side
    # sudo ifconfig eth0 192.168.100.2 up #Using our HiNIC card
    # iperf -c 192.168.101.1 -P 10 -t 100000

after hours of testing, we will see errors:

    hinic 0000:05:00.0: No MGMT msg handler, mod = 0
    hinic 0000:05:00.0: No MGMT msg handler, mod = 0
    hinic 0000:05:00.0: No MGMT msg handler, mod = 0
    hinic 0000:05:00.0: No MGMT msg handler, mod = 0

The errors are caused by the following problem.
1) The hinic_get_wqe() checks the "wq->delta" to allocate new WQEs:

	if (atomic_sub_return(num_wqebbs, &wq->delta) <= 0) {
		atomic_add(num_wqebbs, &wq->delta);
		return ERR_PTR(-EBUSY);
	}

If the WQE occupies multiple pages, the shadow WQE will be used. Then the
hinic_xmit_frame() fills the WQE.

2) While in parallel with 1), the free_tx_poll() checks the "wq->delta"
to free old WQEs:

	if ((atomic_read(&wq->delta) + num_wqebbs) > wq->q_depth)
		return ERR_PTR(-EBUSY);

There is a probability that the shadow WQE which hinic_xmit_frame() is
using will be damaged by copy_wqe_to_shadow():

	if (curr_pg != end_pg) {
		void *shadow_addr = &wq->shadow_wqe[curr_pg * wq->max_wqe_size];

		copy_wqe_to_shadow(wq, shadow_addr, num_wqebbs, *cons_idx);
		return shadow_addr;
	}

This can cause WQE data error and you will see the above error messages.
This patch fixes the problem.

Signed-off-by: Zhao Chen <zhaochen6@huawei.com>
---
 .../net/ethernet/huawei/hinic/hinic_hw_qp.c   | 36 ++++++++++++++-----
 .../net/ethernet/huawei/hinic/hinic_hw_qp.h   |  6 +++-
 drivers/net/ethernet/huawei/hinic/hinic_tx.c  | 18 ++++++++--
 3 files changed, 49 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic/hinic_hw_qp.c b/drivers/net/ethernet/huawei/hinic/hinic_hw_qp.c
index b9db6d649743..cb239627770f 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_hw_qp.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_hw_qp.c
@@ -635,17 +635,18 @@ void hinic_sq_write_wqe(struct hinic_sq *sq, u16 prod_idx,
 }
 
 /**
- * hinic_sq_read_wqe - read wqe ptr in the current ci and update the ci
+ * hinic_sq_read_wqebb - read wqe ptr in the current ci and update the ci, the
+ * wqe only have one wqebb
  * @sq: send queue
  * @skb: return skb that was saved
- * @wqe_size: the size of the wqe
+ * @wqe_size: the wqe size ptr
  * @cons_idx: consumer index of the wqe
  *
  * Return wqe in ci position
  **/
-struct hinic_sq_wqe *hinic_sq_read_wqe(struct hinic_sq *sq,
-				       struct sk_buff **skb,
-				       unsigned int *wqe_size, u16 *cons_idx)
+struct hinic_sq_wqe *hinic_sq_read_wqebb(struct hinic_sq *sq,
+					 struct sk_buff **skb,
+					 unsigned int *wqe_size, u16 *cons_idx)
 {
 	struct hinic_hw_wqe *hw_wqe;
 	struct hinic_sq_wqe *sq_wqe;
@@ -658,6 +659,8 @@ struct hinic_sq_wqe *hinic_sq_read_wqe(struct hinic_sq *sq,
 	if (IS_ERR(hw_wqe))
 		return NULL;
 
+	*skb = sq->saved_skb[*cons_idx];
+
 	sq_wqe = &hw_wqe->sq_wqe;
 	ctrl = &sq_wqe->ctrl;
 	ctrl_info = be32_to_cpu(ctrl->ctrl_info);
@@ -665,11 +668,28 @@ struct hinic_sq_wqe *hinic_sq_read_wqe(struct hinic_sq *sq,
 
 	*wqe_size = sizeof(*ctrl) + sizeof(sq_wqe->task);
 	*wqe_size += SECT_SIZE_FROM_8BYTES(buf_sect_len);
+	*wqe_size = ALIGN(*wqe_size, sq->wq->wqebb_size);
 
-	*skb = sq->saved_skb[*cons_idx];
+	return &hw_wqe->sq_wqe;
+}
+
+/**
+ * hinic_sq_read_wqe - read wqe ptr in the current ci and update the ci
+ * @sq: send queue
+ * @skb: return skb that was saved
+ * @wqe_size: the size of the wqe
+ * @cons_idx: consumer index of the wqe
+ *
+ * Return wqe in ci position
+ **/
+struct hinic_sq_wqe *hinic_sq_read_wqe(struct hinic_sq *sq,
+				       struct sk_buff **skb,
+				       unsigned int wqe_size, u16 *cons_idx)
+{
+	struct hinic_hw_wqe *hw_wqe;
 
-	/* using the real wqe size to read wqe again */
-	hw_wqe = hinic_read_wqe(sq->wq, *wqe_size, cons_idx);
+	hw_wqe = hinic_read_wqe(sq->wq, wqe_size, cons_idx);
+	*skb = sq->saved_skb[*cons_idx];
 
 	return &hw_wqe->sq_wqe;
 }
diff --git a/drivers/net/ethernet/huawei/hinic/hinic_hw_qp.h b/drivers/net/ethernet/huawei/hinic/hinic_hw_qp.h
index df729a1587e9..6c84f83ec283 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_hw_qp.h
+++ b/drivers/net/ethernet/huawei/hinic/hinic_hw_qp.h
@@ -165,7 +165,11 @@ void hinic_sq_write_wqe(struct hinic_sq *sq, u16 prod_idx,
 
 struct hinic_sq_wqe *hinic_sq_read_wqe(struct hinic_sq *sq,
 				       struct sk_buff **skb,
-				       unsigned int *wqe_size, u16 *cons_idx);
+				       unsigned int wqe_size, u16 *cons_idx);
+
+struct hinic_sq_wqe *hinic_sq_read_wqebb(struct hinic_sq *sq,
+					 struct sk_buff **skb,
+					 unsigned int *wqe_size, u16 *cons_idx);
 
 void hinic_sq_put_wqe(struct hinic_sq *sq, unsigned int wqe_size);
 
diff --git a/drivers/net/ethernet/huawei/hinic/hinic_tx.c b/drivers/net/ethernet/huawei/hinic/hinic_tx.c
index 2353ec829c04..c5fca0356c9c 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_tx.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_tx.c
@@ -283,7 +283,11 @@ static void free_all_tx_skbs(struct hinic_txq *txq)
 	int nr_sges;
 	u16 ci;
 
-	while ((sq_wqe = hinic_sq_read_wqe(sq, &skb, &wqe_size, &ci))) {
+	while ((sq_wqe = hinic_sq_read_wqebb(sq, &skb, &wqe_size, &ci))) {
+		sq_wqe = hinic_sq_read_wqe(sq, &skb, wqe_size, &ci);
+		if (!sq_wqe)
+			break;
+
 		nr_sges = skb_shinfo(skb)->nr_frags + 1;
 
 		hinic_sq_get_sges(sq_wqe, txq->free_sges, nr_sges);
@@ -319,11 +323,21 @@ static int free_tx_poll(struct napi_struct *napi, int budget)
 	do {
 		hw_ci = HW_CONS_IDX(sq) & wq->mask;
 
-		sq_wqe = hinic_sq_read_wqe(sq, &skb, &wqe_size, &sw_ci);
+		/* Reading a WQEBB to get real WQE size and consumer index. */
+		sq_wqe = hinic_sq_read_wqebb(sq, &skb, &wqe_size, &sw_ci);
 		if ((!sq_wqe) ||
 		    (((hw_ci - sw_ci) & wq->mask) * wq->wqebb_size < wqe_size))
 			break;
 
+		/* If this WQE have multiple WQEBBs, we will read again to get
+		 * full size WQE.
+		 */
+		if (wqe_size > wq->wqebb_size) {
+			sq_wqe = hinic_sq_read_wqe(sq, &skb, wqe_size, &sw_ci);
+			if (unlikely(!sq_wqe))
+				break;
+		}
+
 		tx_bytes += skb->len;
 		pkts++;
 
-- 
2.17.1

