Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932974AbeCJC6f (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 21:58:35 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6226 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751880AbeCJC5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 21:57:39 -0500
From: Peng Li <lipeng321@huawei.com>
To: <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <salil.mehta@huawei.com>,
        <lipeng321@huawei.com>
Subject: [PATCH net-next 10/12] net: hns3: fix return value error of hclge_get_mac_vlan_cmd_status()
Date: Sat, 10 Mar 2018 11:29:31 +0800
Message-ID: <1520652573-75644-11-git-send-email-lipeng321@huawei.com>
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

Error code -EIO was used to indicate mutilple errors in function
hclge_get_mac_vlan_cmd_status().This patch fixes it by using
error code depending on the error type.

For no space error, return -ENOSPC.
For entry not found, return -ENOENT.
For command send fail, return -EIO.
For invalid op code, return -EINVAL.

Fixes: 46a3df9f9718 ("net: hns3: Add HNS3 Acceleration Engine & Compatibility Layer Support")
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index ba84281..47dcc98 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -3779,11 +3779,11 @@ static int hclge_get_mac_vlan_cmd_status(struct hclge_vport *vport,
 		if ((!resp_code) || (resp_code == 1)) {
 			return_status = 0;
 		} else if (resp_code == 2) {
-			return_status = -EIO;
+			return_status = -ENOSPC;
 			dev_err(&hdev->pdev->dev,
 				"add mac addr failed for uc_overflow.\n");
 		} else if (resp_code == 3) {
-			return_status = -EIO;
+			return_status = -ENOSPC;
 			dev_err(&hdev->pdev->dev,
 				"add mac addr failed for mc_overflow.\n");
 		} else {
@@ -3795,7 +3795,7 @@ static int hclge_get_mac_vlan_cmd_status(struct hclge_vport *vport,
 		if (!resp_code) {
 			return_status = 0;
 		} else if (resp_code == 1) {
-			return_status = -EIO;
+			return_status = -ENOENT;
 			dev_dbg(&hdev->pdev->dev,
 				"remove mac addr failed for miss.\n");
 		} else {
@@ -3807,7 +3807,7 @@ static int hclge_get_mac_vlan_cmd_status(struct hclge_vport *vport,
 		if (!resp_code) {
 			return_status = 0;
 		} else if (resp_code == 1) {
-			return_status = -EIO;
+			return_status = -ENOENT;
 			dev_dbg(&hdev->pdev->dev,
 				"lookup mac addr failed for miss.\n");
 		} else {
@@ -3816,7 +3816,7 @@ static int hclge_get_mac_vlan_cmd_status(struct hclge_vport *vport,
 				resp_code);
 		}
 	} else {
-		return_status = -EIO;
+		return_status = -EINVAL;
 		dev_err(&hdev->pdev->dev,
 			"unknown opcode for get_mac_vlan_cmd_status,opcode=%d.\n",
 			op);
-- 
2.9.3
