Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933316AbeD1Ego (ORCPT <rfc822;w@1wt.eu>);
        Sat, 28 Apr 2018 00:36:44 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7635 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751943AbeD1Egn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Apr 2018 00:36:43 -0400
From: YueHaibing <yuehaibing@huawei.com>
To: <ganeshgr@chelsio.com>, <johannes.berg@intel.com>,
        <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] libcxgb,cxgb4: use __skb_put_zero to simplfy code
Date: Sat, 28 Apr 2018 12:35:22 +0800
Message-ID: <20180428043522.12408-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use helper __skb_put_zero to replace the pattern of __skb_put() && memset()

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c |  3 +--
 drivers/net/ethernet/chelsio/cxgb4/srq.c          |  3 +--
 drivers/net/ethernet/chelsio/libcxgb/libcxgb_cm.h | 15 +++++----------
 3 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c
index db92f18..aae9802 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c
@@ -64,8 +64,7 @@ static int set_tcb_field(struct adapter *adap, struct filter_entry *f,
 	if (!skb)
 		return -ENOMEM;
 
-	req = (struct cpl_set_tcb_field *)__skb_put(skb, sizeof(*req));
-	memset(req, 0, sizeof(*req));
+	req = (struct cpl_set_tcb_field *)__skb_put_zero(skb, sizeof(*req));
 	INIT_TP_WR_CPL(req, CPL_SET_TCB_FIELD, ftid);
 	req->reply_ctrl = htons(REPLY_CHAN_V(0) |
 				QUEUENO_V(adap->sge.fw_evtq.abs_id) |
diff --git a/drivers/net/ethernet/chelsio/cxgb4/srq.c b/drivers/net/ethernet/chelsio/cxgb4/srq.c
index 6228a57..82b70a5 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/srq.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/srq.c
@@ -84,8 +84,7 @@ int cxgb4_get_srq_entry(struct net_device *dev,
 	if (!skb)
 		return -ENOMEM;
 	req = (struct cpl_srq_table_req *)
-		__skb_put(skb, sizeof(*req));
-	memset(req, 0, sizeof(*req));
+		__skb_put_zero(skb, sizeof(*req));
 	INIT_TP_WR(req, 0);
 	OPCODE_TID(req) = htonl(MK_OPCODE_TID(CPL_SRQ_TABLE_REQ,
 					      TID_TID_V(srq_idx) |
diff --git a/drivers/net/ethernet/chelsio/libcxgb/libcxgb_cm.h b/drivers/net/ethernet/chelsio/libcxgb/libcxgb_cm.h
index 4b5aacc..240ba9d 100644
--- a/drivers/net/ethernet/chelsio/libcxgb/libcxgb_cm.h
+++ b/drivers/net/ethernet/chelsio/libcxgb/libcxgb_cm.h
@@ -90,8 +90,7 @@ cxgb_mk_tid_release(struct sk_buff *skb, u32 len, u32 tid, u16 chan)
 {
 	struct cpl_tid_release *req;
 
-	req = __skb_put(skb, len);
-	memset(req, 0, len);
+	req = __skb_put_zero(skb, len);
 
 	INIT_TP_WR(req, tid);
 	OPCODE_TID(req) = cpu_to_be32(MK_OPCODE_TID(CPL_TID_RELEASE, tid));
@@ -104,8 +103,7 @@ cxgb_mk_close_con_req(struct sk_buff *skb, u32 len, u32 tid, u16 chan,
 {
 	struct cpl_close_con_req *req;
 
-	req = __skb_put(skb, len);
-	memset(req, 0, len);
+	req = __skb_put_zero(skb, len);
 
 	INIT_TP_WR(req, tid);
 	OPCODE_TID(req) = cpu_to_be32(MK_OPCODE_TID(CPL_CLOSE_CON_REQ, tid));
@@ -119,8 +117,7 @@ cxgb_mk_abort_req(struct sk_buff *skb, u32 len, u32 tid, u16 chan,
 {
 	struct cpl_abort_req *req;
 
-	req = __skb_put(skb, len);
-	memset(req, 0, len);
+	req = __skb_put_zero(skb, len);
 
 	INIT_TP_WR(req, tid);
 	OPCODE_TID(req) = cpu_to_be32(MK_OPCODE_TID(CPL_ABORT_REQ, tid));
@@ -134,8 +131,7 @@ cxgb_mk_abort_rpl(struct sk_buff *skb, u32 len, u32 tid, u16 chan)
 {
 	struct cpl_abort_rpl *rpl;
 
-	rpl = __skb_put(skb, len);
-	memset(rpl, 0, len);
+	rpl = __skb_put_zero(skb, len);
 
 	INIT_TP_WR(rpl, tid);
 	OPCODE_TID(rpl) = cpu_to_be32(MK_OPCODE_TID(CPL_ABORT_RPL, tid));
@@ -149,8 +145,7 @@ cxgb_mk_rx_data_ack(struct sk_buff *skb, u32 len, u32 tid, u16 chan,
 {
 	struct cpl_rx_data_ack *req;
 
-	req = __skb_put(skb, len);
-	memset(req, 0, len);
+	req = __skb_put_zero(skb, len);
 
 	INIT_TP_WR(req, tid);
 	OPCODE_TID(req) = cpu_to_be32(MK_OPCODE_TID(CPL_RX_DATA_ACK, tid));
-- 
2.7.0
