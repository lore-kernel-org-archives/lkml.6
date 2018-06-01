Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753258AbeFAQx5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 12:53:57 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8247 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751693AbeFAQxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 12:53:52 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>
CC: <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>
Subject: [PATCH net-next 01/11] net: hns3: Disable vf vlan filter when vf vlan table is full
Date: Fri, 1 Jun 2018 17:52:01 +0100
Message-ID: <20180601165211.46372-2-salil.mehta@huawei.com>
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

This is only 128 entries for hardware's vf vlan table, when
the vf table is full, the firmware will disable the vf vlan
filter and return a resp_code of HCLGE_VF_VLAN_NO_ENTRY to
driver.

This patch checks the if resp_code from firmware is
HCLGE_VF_VLAN_NO_ENTRY, if yes, then print a warning and
return ok to the caller.

Fixes: 46a3df9f9718 ("net: hns3: Add HNS3 Acceleration Engine & Compatibility Layer Support")
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 6916685..4ca5318 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -4525,9 +4525,16 @@ static int hclge_set_vf_vlan_common(struct hclge_dev *hdev, int vfid,
 	}
 
 	if (!is_kill) {
+#define HCLGE_VF_VLAN_NO_ENTRY	2
 		if (!req0->resp_code || req0->resp_code == 1)
 			return 0;
 
+		if (req0->resp_code == HCLGE_VF_VLAN_NO_ENTRY) {
+			dev_warn(&hdev->pdev->dev,
+				 "vf vlan table is full, vf vlan filter is disabled\n");
+			return 0;
+		}
+
 		dev_err(&hdev->pdev->dev,
 			"Add vf vlan filter fail, ret =%d.\n",
 			req0->resp_code);
-- 
2.7.4
