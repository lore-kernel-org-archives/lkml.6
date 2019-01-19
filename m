Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC88C61CE3
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 03:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E713F2086D
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 03:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730442AbfASDBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 22:01:21 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:60142 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730365AbfASDBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 22:01:10 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id F16F283FABDA652660BB;
        Sat, 19 Jan 2019 11:01:07 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.408.0; Sat, 19 Jan 2019 11:01:00 +0800
From:   "Wei Hu (Xavier)" <xavier.huwei@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <xavier.huwei@huawei.com>,
        <lijun_nudt@163.com>, <oulijun@huawei.com>,
        <liudongdong3@huawei.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <xavier_huwei@163.com>
Subject: [PATCH V2 rdma-next 3/3] RDMA/hns: Fix the chip hanging caused by sending doorbell during reset
Date:   Sat, 19 Jan 2019 11:36:07 +0800
Message-ID: <1547868967-115951-4-git-send-email-xavier.huwei@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1547868967-115951-1-git-send-email-xavier.huwei@huawei.com>
References: <1547868967-115951-1-git-send-email-xavier.huwei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On hi08 chip, There is a possibility of chip hanging when sending
doorbell during reset. We can fix it by prohibiting doorbell during
reset.

Fixes: 2d40788825ac ("RDMA/hns: Add support for processing send wr and receive wr")
Signed-off-by: Wei Hu (Xavier) <xavier.huwei@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |  1 +
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 20 +++++++++++++-------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  | 11 +++++++++++
 3 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 65eb4bc..8ca8d74 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -947,6 +947,7 @@ struct hns_roce_dev {
 	spinlock_t		bt_cmd_lock;
 	bool			active;
 	bool			is_reset;
+	bool			dis_db;
 	unsigned long		reset_cnt;
 	struct hns_roce_ib_iboe iboe;
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 811e186..3492262 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -587,7 +587,7 @@ static int hns_roce_v2_post_send(struct ib_qp *ibqp,
 		roce_set_field(sq_db.parameter, V2_DB_PARAMETER_SL_M,
 			       V2_DB_PARAMETER_SL_S, qp->sl);
 
-		hns_roce_write64_k((__le32 *)&sq_db, qp->sq.db_reg_l);
+		hns_roce_write64(hr_dev, (__le32 *)&sq_db, qp->sq.db_reg_l);
 
 		qp->sq_next_wqe = ind;
 		qp->next_sge = sge_ind;
@@ -717,7 +717,7 @@ static int hns_roce_v2_cmd_hw_reseted(struct hns_roce_dev *hr_dev,
 				      unsigned long reset_stage)
 {
 	/* When hardware reset has been completed once or more, we should stop
-	 * sending mailbox&cmq to hardware. If now in .init_instance()
+	 * sending mailbox&cmq&doorbell to hardware. If now in .init_instance()
 	 * function, we should exit with error. If now at HNAE3_INIT_CLIENT
 	 * stage of soft reset process, we should exit with error, and then
 	 * HNAE3_INIT_CLIENT related process can rollback the operation like
@@ -726,6 +726,7 @@ static int hns_roce_v2_cmd_hw_reseted(struct hns_roce_dev *hr_dev,
 	 * reset process once again.
 	 */
 	hr_dev->is_reset = true;
+	hr_dev->dis_db = true;
 
 	if (reset_stage == HNS_ROCE_STATE_RST_INIT ||
 	    instance_stage == HNS_ROCE_STATE_INIT)
@@ -743,8 +744,8 @@ static int hns_roce_v2_cmd_hw_resetting(struct hns_roce_dev *hr_dev,
 	const struct hnae3_ae_ops *ops = handle->ae_algo->ops;
 	unsigned long end;
 
-	/* When hardware reset is detected, we should stop sending mailbox&cmq
-	 * to hardware, and wait until hardware reset finished. If now
+	/* When hardware reset is detected, we should stop sending mailbox&cmq&
+	 * doorbell to hardware, and wait until hardware reset finished. If now
 	 * in .init_instance() function, we should exit with error. If now at
 	 * HNAE3_INIT_CLIENT stage of soft reset process, we should exit with
 	 * error, and then HNAE3_INIT_CLIENT related process can rollback the
@@ -752,6 +753,7 @@ static int hns_roce_v2_cmd_hw_resetting(struct hns_roce_dev *hr_dev,
 	 * related process will exit with error to notify NIC driver to
 	 * reschedule soft reset process once again.
 	 */
+	hr_dev->dis_db = true;
 	end = msecs_to_jiffies(HNS_ROCE_V2_HW_RST_TIMEOUT) + jiffies;
 	while (ops->get_hw_reset_stat(handle) && time_before(jiffies, end))
 		udelay(1);
@@ -776,9 +778,10 @@ static int hns_roce_v2_cmd_sw_resetting(struct hns_roce_dev *hr_dev)
 	unsigned long end;
 
 	/* When software reset is detected at .init_instance() function, we
-	 * should stop sending mailbox&cmq to hardware, and
+	 * should stop sending mailbox&cmq&doorbell to hardware, and
 	 * wait until hardware reset finished, we should exit with error.
 	 */
+	hr_dev->dis_db = true;
 	end = msecs_to_jiffies(HNS_ROCE_V2_HW_RST_TIMEOUT) + jiffies;
 	while (ops->ae_dev_reset_cnt(handle) == hr_dev->reset_cnt &&
 	       time_before(jiffies, end))
@@ -2510,6 +2513,7 @@ static void hns_roce_v2_write_cqc(struct hns_roce_dev *hr_dev,
 static int hns_roce_v2_req_notify_cq(struct ib_cq *ibcq,
 				     enum ib_cq_notify_flags flags)
 {
+	struct hns_roce_dev *hr_dev = to_hr_dev(ibcq->device);
 	struct hns_roce_cq *hr_cq = to_hr_cq(ibcq);
 	u32 notification_flag;
 	u32 doorbell[2];
@@ -2535,7 +2539,7 @@ static int hns_roce_v2_req_notify_cq(struct ib_cq *ibcq,
 	roce_set_bit(doorbell[1], V2_CQ_DB_PARAMETER_NOTIFY_S,
 		     notification_flag);
 
-	hns_roce_write64_k(doorbell, hr_cq->cq_db_l);
+	hns_roce_write64(hr_dev, doorbell, hr_cq->cq_db_l);
 
 	return 0;
 }
@@ -4779,6 +4783,7 @@ static void hns_roce_v2_init_irq_work(struct hns_roce_dev *hr_dev,
 
 static void set_eq_cons_index_v2(struct hns_roce_eq *eq)
 {
+	struct hns_roce_dev *hr_dev = eq->hr_dev;
 	u32 doorbell[2];
 
 	doorbell[0] = 0;
@@ -4805,7 +4810,7 @@ static void set_eq_cons_index_v2(struct hns_roce_eq *eq)
 		       HNS_ROCE_V2_EQ_DB_PARA_S,
 		       (eq->cons_index & HNS_ROCE_V2_CONS_IDX_M));
 
-	hns_roce_write64_k(doorbell, eq->doorbell);
+	hns_roce_write64(hr_dev, doorbell, eq->doorbell);
 }
 
 static struct hns_roce_aeqe *get_aeqe_v2(struct hns_roce_eq *eq, u32 entry)
@@ -6325,6 +6330,7 @@ static int hns_roce_hw_v2_reset_notify_down(struct hnae3_handle *handle)
 		return 0;
 
 	hr_dev->active = false;
+	hr_dev->dis_db = true;
 
 	event.event = IB_EVENT_DEVICE_FATAL;
 	event.device = &hr_dev->ib_dev;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index f22094e..6b0486f 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -1799,4 +1799,15 @@ struct hns_roce_sccc_clr_done {
 	__le32 rsv[5];
 };
 
+static inline void hns_roce_write64(struct hns_roce_dev *hr_dev, __le32 val[2],
+				    void __iomem *dest)
+{
+	struct hns_roce_v2_priv *priv = (struct hns_roce_v2_priv *)hr_dev->priv;
+	struct hnae3_handle *handle = priv->handle;
+	const struct hnae3_ae_ops *ops = handle->ae_algo->ops;
+
+	if (!hr_dev->dis_db && !ops->get_hw_reset_stat(handle))
+		hns_roce_write64_k(val, dest);
+}
+
 #endif
-- 
1.9.1

