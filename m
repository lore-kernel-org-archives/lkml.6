Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8049EC43610
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 14:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52C7720863
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 14:37:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52C7720863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440059AbeKXBWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 20:22:16 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:49947 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2436828AbeKXBWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 20:22:15 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7B177FCB3902;
        Fri, 23 Nov 2018 22:37:45 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.408.0; Fri, 23 Nov 2018 22:37:36 +0800
From:   "Wei Hu (Xavier)" <xavier.huwei@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <xavier.huwei@huawei.com>,
        <lijun_nudt@163.com>, <oulijun@huawei.com>,
        <charles.chenxin@huawei.com>, <liuyixian@huawei.com>,
        <zhangxiping3@huawei.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <xavier_huwei@163.com>
Subject: [PATCH rdma-next 3/3] RDMA/hns: Modify hns RoCE device's name
Date:   Fri, 23 Nov 2018 23:14:25 +0800
Message-ID: <1542986065-44265-4-git-send-email-xavier.huwei@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1542986065-44265-1-git-send-email-xavier.huwei@huawei.com>
References: <1542986065-44265-1-git-send-email-xavier.huwei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch modifies the name of hns RoCE device's name in order
to ensure that the name is consistent before and after reset.

Signed-off-by: Wei Hu (Xavier) <xavier.huwei@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h | 1 +
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 3 +++
 drivers/infiniband/hw/hns/hns_roce_main.c   | 4 +++-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 259977b..a8cfe76 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -954,6 +954,7 @@ struct hns_roce_dev {
 	struct pci_dev		*pci_dev;
 	struct device		*dev;
 	struct hns_roce_uar     priv_uar;
+	char			name[IB_DEVICE_NAME_MAX];
 	const char		*irq_names[HNS_ROCE_MAX_IRQ_NUM];
 	spinlock_t		sm_lock;
 	spinlock_t		bt_cmd_lock;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 1d639a0..678c7ec 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -6110,6 +6110,9 @@ static int hns_roce_hw_v2_get_cfg(struct hns_roce_dev *hr_dev,
 		hr_dev->irq[i] = pci_irq_vector(handle->pdev,
 						i + handle->rinfo.base_vector);
 
+	snprintf(hr_dev->name, IB_DEVICE_NAME_MAX, "hns%s",
+		 handle->rinfo.netdev->name);
+
 	/* cmd issue mode: 0 is poll, 1 is event */
 	hr_dev->cmd_mod = 1;
 	hr_dev->loop_idc = 0;
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 68f22b8..8bbb1ef 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -456,6 +456,8 @@ static int hns_roce_register_device(struct hns_roce_dev *hr_dev)
 	spin_lock_init(&iboe->lock);
 
 	ib_dev = &hr_dev->ib_dev;
+	if (!strlen(hr_dev->name))
+		strlcpy(hr_dev->name, "hns_%d", IB_DEVICE_NAME_MAX);
 
 	ib_dev->owner			= THIS_MODULE;
 	ib_dev->node_type		= RDMA_NODE_IB_CA;
@@ -566,7 +568,7 @@ static int hns_roce_register_device(struct hns_roce_dev *hr_dev)
 	ib_dev->disassociate_ucontext	= hns_roce_disassociate_ucontext;
 
 	ib_dev->driver_id = RDMA_DRIVER_HNS;
-	ret = ib_register_device(ib_dev, "hns_%d", NULL);
+	ret = ib_register_device(ib_dev, hr_dev->name, NULL);
 	if (ret) {
 		dev_err(dev, "ib_register_device failed!\n");
 		return ret;
-- 
1.9.1

