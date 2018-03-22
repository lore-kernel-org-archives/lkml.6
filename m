Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756065AbeCVOa1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 10:30:27 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6261 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753729AbeCVOaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 10:30:23 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>
CC: <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <mehta.salil.lnk@gmail.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH net-next 8/9] net: hns3: Add *Asserting Reset* mailbox message & handling in VF
Date: Thu, 22 Mar 2018 14:28:59 +0000
Message-ID: <20180322142900.22860-9-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180322142900.22860-1-salil.mehta@huawei.com>
References: <20180322142900.22860-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.47]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reset Asserting message is forwarded by PF to inform VF about
the hardware reset which is about to happen. This might be due
to the earlier VF reset request received by the PF or because PF
for any reason decides to undergo reset. This message results in
VF to go in pending state in which it polls the hardware to
complete the reset and then further resets/tears its own stack.

Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h          |  1 +
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h b/drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h
index f3e90c2..519e2bd 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h
@@ -11,6 +11,7 @@
 
 enum HCLGE_MBX_OPCODE {
 	HCLGE_MBX_RESET = 0x01,		/* (VF -> PF) assert reset */
+	HCLGE_MBX_ASSERTING_RESET,	/* (PF -> VF) PF is asserting reset*/
 	HCLGE_MBX_SET_UNICAST,		/* (VF -> PF) set UC addr */
 	HCLGE_MBX_SET_MULTICAST,	/* (VF -> PF) set MC addr */
 	HCLGE_MBX_SET_VLAN,		/* (VF -> PF) set VLAN */
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c
index 7687911..a286184 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c
@@ -170,6 +170,7 @@ void hclgevf_mbx_handler(struct hclgevf_dev *hdev)
 			}
 			break;
 		case HCLGE_MBX_LINK_STAT_CHANGE:
+		case HCLGE_MBX_ASSERTING_RESET:
 			/* set this mbx event as pending. This is required as we
 			 * might loose interrupt event when mbx task is busy
 			 * handling. This shall be cleared when mbx task just
@@ -242,6 +243,17 @@ void hclgevf_mbx_async_handler(struct hclgevf_dev *hdev)
 			hclgevf_update_speed_duplex(hdev, speed, duplex);
 
 			break;
+		case HCLGE_MBX_ASSERTING_RESET:
+			/* PF has asserted reset hence VF should go in pending
+			 * state and poll for the hardware reset status till it
+			 * has been completely reset. After this stack should
+			 * eventually be re-initialized.
+			 */
+			hdev->nic.reset_level = HNAE3_VF_RESET;
+			set_bit(HCLGEVF_RESET_PENDING, &hdev->reset_state);
+			hclgevf_reset_task_schedule(hdev);
+
+			break;
 		default:
 			dev_err(&hdev->pdev->dev,
 				"fetched unsupported(%d) message from arq\n",
-- 
2.7.4
