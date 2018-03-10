Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932896AbeCJC5n (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 21:57:43 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6229 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932716AbeCJC5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 21:57:39 -0500
From: Peng Li <lipeng321@huawei.com>
To: <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <salil.mehta@huawei.com>,
        <lipeng321@huawei.com>
Subject: [PATCH net-next 11/12] net: hns3: add existence checking before adding unicast mac address
Date: Sat, 10 Mar 2018 11:29:32 +0800
Message-ID: <1520652573-75644-12-git-send-email-lipeng321@huawei.com>
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

It's not allowed to add two same unicast mac address entries to the
mac_vlan table. When modify the uc mac address of a VF device to the
same value with the PF device's, the PF device will lose its entry of
the mac_vlan table.

Lookup the mac address in the mac_vlan table, and add it if the entry
is inexistent.

Fixes: 46a3df9f9718 ("net: hns3: Add HNS3 Acceleration Engine & Compatibility Layer Support")
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 47dcc98..d70619b 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -4107,6 +4107,7 @@ int hclge_add_uc_addr_common(struct hclge_vport *vport,
 {
 	struct hclge_dev *hdev = vport->back;
 	struct hclge_mac_vlan_tbl_entry_cmd req;
+	struct hclge_desc desc;
 	u16 egress_port = 0;
 	int ret;
 
@@ -4140,7 +4141,21 @@ int hclge_add_uc_addr_common(struct hclge_vport *vport,
 
 	hclge_prepare_mac_addr(&req, addr);
 
-	ret = hclge_add_mac_vlan_tbl(vport, &req, NULL);
+	/* Lookup the mac address in the mac_vlan table, and add
+	 * it if the entry is inexistent. Repeated unicast entry
+	 * is not allowed in the mac vlan table.
+	 */
+	ret = hclge_lookup_mac_vlan_tbl(vport, &req, &desc, false);
+	if (ret == -ENOENT)
+		return hclge_add_mac_vlan_tbl(vport, &req, NULL);
+
+	/* check if we just hit the duplicate */
+	if (!ret)
+		ret = -EINVAL;
+
+	dev_err(&hdev->pdev->dev,
+		"PF failed to add unicast entry(%pM) in the MAC table\n",
+		addr);
 
 	return ret;
 }
-- 
2.9.3
