Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753642AbeFAQ5M (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 12:57:12 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:40985 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753198AbeFAQx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 12:53:56 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>
CC: <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>
Subject: [PATCH net-next 06/11] net: hns3: Fix for hclge_reset running repeatly problem
Date: Fri, 1 Jun 2018 17:52:06 +0100
Message-ID: <20180601165211.46372-7-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180601165211.46372-1-salil.mehta@huawei.com>
References: <20180601165211.46372-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.227.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

When hardware sends the HCLGE_VECTOR0_EVENT_RST event through
hclge_misc_irq_handle, currently driver enables misc_vector in
the interrupt handle, and hardware generates the same interrupt
for the same reset event again and again until the reset is
complete, which causes hclge_reset running repeatly problem.

This patch fixes by enabling the misc_vector after reset is
complete.

Fixes: 4ed340ab8f49 ("net: hns3: Add reset process in hclge_main")
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 40 ++++++++++++++++++----
 1 file changed, 34 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 746987f..fb44b1e 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -2587,9 +2587,11 @@ static irqreturn_t hclge_misc_irq_handle(int irq, void *data)
 		break;
 	}
 
-	/* we should clear the source of interrupt */
-	hclge_clear_event_cause(hdev, event_cause, clearval);
-	hclge_enable_vector(&hdev->misc_vector, true);
+	/* clear the source of interrupt if it is not cause by reset */
+	if (event_cause != HCLGE_VECTOR0_EVENT_RST) {
+		hclge_clear_event_cause(hdev, event_cause, clearval);
+		hclge_enable_vector(&hdev->misc_vector, true);
+	}
 
 	return IRQ_HANDLED;
 }
@@ -2777,6 +2779,33 @@ static enum hnae3_reset_type hclge_get_reset_level(struct hclge_dev *hdev,
 	return rst_level;
 }
 
+static void hclge_clear_reset_cause(struct hclge_dev *hdev)
+{
+	u32 clearval = 0;
+
+	switch (hdev->reset_type) {
+	case HNAE3_IMP_RESET:
+		clearval = BIT(HCLGE_VECTOR0_IMPRESET_INT_B);
+		break;
+	case HNAE3_GLOBAL_RESET:
+		clearval = BIT(HCLGE_VECTOR0_GLOBALRESET_INT_B);
+		break;
+	case HNAE3_CORE_RESET:
+		clearval = BIT(HCLGE_VECTOR0_CORERESET_INT_B);
+		break;
+	default:
+		dev_warn(&hdev->pdev->dev, "Unsupported reset event to clear:%d",
+			 hdev->reset_type);
+		break;
+	}
+
+	if (!clearval)
+		return;
+
+	hclge_write_dev(&hdev->hw, HCLGE_MISC_RESET_STS_REG, clearval);
+	hclge_enable_vector(&hdev->misc_vector, true);
+}
+
 static void hclge_reset(struct hclge_dev *hdev)
 {
 	/* perform reset of the stack & ae device for a client */
@@ -2789,6 +2818,8 @@ static void hclge_reset(struct hclge_dev *hdev)
 		hclge_reset_ae_dev(hdev->ae_dev);
 		hclge_notify_client(hdev, HNAE3_INIT_CLIENT);
 		rtnl_unlock();
+
+		hclge_clear_reset_cause(hdev);
 	} else {
 		/* schedule again to check pending resets later */
 		set_bit(hdev->reset_type, &hdev->reset_pending);
@@ -5661,9 +5692,6 @@ static int hclge_reset_ae_dev(struct hnae3_ae_dev *ae_dev)
 		return ret;
 	}
 
-	/* Enable MISC vector(vector0) */
-	hclge_enable_vector(&hdev->misc_vector, true);
-
 	dev_info(&pdev->dev, "Reset done, %s driver initialization finished.\n",
 		 HCLGE_DRIVER_NAME);
 
-- 
2.7.4
