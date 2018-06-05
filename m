Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751928AbeFELnL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 07:43:11 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8695 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751856AbeFELnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 07:43:08 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>
CC: <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Xi Wang <wangxi11@huawei.com>
Subject: [PATCH net-next 1/3] net: hns3: Fix for VF mailbox cannot receiving PF response
Date: Tue, 5 Jun 2018 12:41:59 +0100
Message-ID: <20180605114201.29900-2-salil.mehta@huawei.com>
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

When the VF frequently switches the CMDQ interrupt, if the CMDQ_SRC is not
cleared, the VF will not receive the new PF response after the interrupt
is re-enabled, the corresponding log is as follows:

[  317.482222] hns3 0000:00:03.0: VF could not get mbx resp(=0) from PF
in 500 tries
[  317.483137] hns3 0000:00:03.0: VF request to get tqp info from PF
failed -5

This patch fixes this problem by clearing CMDQ_SRC before enabling
interrupt and syncing pending IRQ handlers after disabling interrupt.

Fixes: e2cb1dec9779 ("net: hns3: Add HNS3 VF HCL(Hardware Compatibility Layer) Support")
Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index dd8e8e6..d55ee9c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -1576,6 +1576,8 @@ static int hclgevf_misc_irq_init(struct hclgevf_dev *hdev)
 		return ret;
 	}
 
+	hclgevf_clear_event_cause(hdev, 0);
+
 	/* enable misc. vector(vector 0) */
 	hclgevf_enable_vector(&hdev->misc_vector, true);
 
@@ -1586,6 +1588,7 @@ static void hclgevf_misc_irq_uninit(struct hclgevf_dev *hdev)
 {
 	/* disable misc vector(vector 0) */
 	hclgevf_enable_vector(&hdev->misc_vector, false);
+	synchronize_irq(hdev->misc_vector.vector_irq);
 	free_irq(hdev->misc_vector.vector_irq, hdev);
 	hclgevf_free_vector(hdev, 0);
 }
-- 
2.7.4
