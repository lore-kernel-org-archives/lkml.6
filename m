Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751952AbeFELnR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 07:43:17 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8644 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751721AbeFELnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 07:43:14 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>
CC: <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Xi Wang <wangxi11@huawei.com>
Subject: [PATCH net-next 3/3] net: hns3: Optimize PF CMDQ interrupt switching process
Date: Tue, 5 Jun 2018 12:42:01 +0100
Message-ID: <20180605114201.29900-4-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180605114201.29900-1-salil.mehta@huawei.com>
References: <20180605114201.29900-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.227.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

When the PF frequently switches the CMDQ interrupt, if the CMDQ_SRC is
not cleared before the hardware interrupt is generated, the new interrupt
will not be reported.

This patch optimizes this problem by clearing CMDQ_SRC and RESET_STS
before enabling interrupt and syncing pending IRQ handlers after disabling
interrupt.

Fixes: 466b0c00391b ("net: hns3: Add support for misc interrupt")
Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 2a80134..d318d35 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -2557,6 +2557,15 @@ static void hclge_clear_event_cause(struct hclge_dev *hdev, u32 event_type,
 	}
 }
 
+static void hclge_clear_all_event_cause(struct hclge_dev *hdev)
+{
+	hclge_clear_event_cause(hdev, HCLGE_VECTOR0_EVENT_RST,
+				BIT(HCLGE_VECTOR0_GLOBALRESET_INT_B) |
+				BIT(HCLGE_VECTOR0_CORERESET_INT_B) |
+				BIT(HCLGE_VECTOR0_IMPRESET_INT_B));
+	hclge_clear_event_cause(hdev, HCLGE_VECTOR0_EVENT_MBX, 0);
+}
+
 static void hclge_enable_vector(struct hclge_misc_vector *vector, bool enable)
 {
 	writel(enable ? 1 : 0, vector->addr);
@@ -5688,6 +5697,8 @@ static int hclge_init_ae_dev(struct hnae3_ae_dev *ae_dev)
 	INIT_WORK(&hdev->rst_service_task, hclge_reset_service_task);
 	INIT_WORK(&hdev->mbx_service_task, hclge_mailbox_service_task);
 
+	hclge_clear_all_event_cause(hdev);
+
 	/* Enable MISC vector(vector0) */
 	hclge_enable_vector(&hdev->misc_vector, true);
 
@@ -5817,6 +5828,8 @@ static void hclge_uninit_ae_dev(struct hnae3_ae_dev *ae_dev)
 
 	/* Disable MISC vector(vector0) */
 	hclge_enable_vector(&hdev->misc_vector, false);
+	synchronize_irq(hdev->misc_vector.vector_irq);
+
 	hclge_destroy_cmd_queue(&hdev->hw);
 	hclge_misc_irq_uninit(hdev);
 	hclge_pci_uninit(hdev);
-- 
2.7.4
