Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932862AbeCJC5l (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 21:57:41 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6227 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751881AbeCJC5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 21:57:39 -0500
From: Peng Li <lipeng321@huawei.com>
To: <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <salil.mehta@huawei.com>,
        <lipeng321@huawei.com>
Subject: [PATCH net-next 12/12] net: hns3: add result checking for VF when modify unicast mac address
Date: Sat, 10 Mar 2018 11:29:33 +0800
Message-ID: <1520652573-75644-13-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520652573-75644-1-git-send-email-lipeng321@huawei.com>
References: <1520652573-75644-1-git-send-email-lipeng321@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Shen <shenjian15@huawei.com>

VF changes unicast mac address by sending mailbox msg to PF, then PF
completes the mac address modification. It may fail when the target
uc mac address is already in the mac_vlan table. VF should be aware
of it by reading the message result.

Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c    | 2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c | 2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c  | 4 ++++
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
index e3e4ded..4a49a6b 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
@@ -365,7 +365,7 @@ void hclge_mbx_handler(struct hclge_dev *hdev)
 					ret);
 			break;
 		case HCLGE_MBX_SET_UNICAST:
-			ret = hclge_set_vf_uc_mac_addr(vport, req, false);
+			ret = hclge_set_vf_uc_mac_addr(vport, req, true);
 			if (ret)
 				dev_err(&hdev->pdev->dev,
 					"PF fail(%d) to set VF UC MAC Addr\n",
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 6c240d6..2337025 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -744,7 +744,7 @@ static int hclgevf_set_mac_addr(struct hnae3_handle *handle, void *p,
 
 	status = hclgevf_send_mbx_msg(hdev, HCLGE_MBX_SET_UNICAST,
 				      subcode, msg_data, ETH_ALEN * 2,
-				      false, NULL, 0);
+				      true, NULL, 0);
 	if (!status)
 		ether_addr_copy(hdev->hw.mac.mac_addr, new_mac_addr);
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c
index 18283ef..9768f71 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c
@@ -54,6 +54,10 @@ static int hclgevf_get_mbx_resp(struct hclgevf_dev *hdev, u16 code0, u16 code1,
 	mbx_resp = &hdev->mbx_resp;
 	r_code0 = (u16)(mbx_resp->origin_mbx_msg >> 16);
 	r_code1 = (u16)(mbx_resp->origin_mbx_msg & 0xff);
+
+	if (mbx_resp->resp_status)
+		return mbx_resp->resp_status;
+
 	if (resp_data)
 		memcpy(resp_data, &mbx_resp->additional_info[0], resp_len);
 
-- 
2.9.3
