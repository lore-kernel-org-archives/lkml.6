Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753352AbeEOSVS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 14:21:18 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59461 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753113AbeEOSVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 14:21:16 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>
CC: <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Fuyun Liang <liangfuyun1@huawei.com>
Subject: [PATCH net-next 03/10] net: hns3: Add a check for client instance init state
Date: Tue, 15 May 2018 19:20:07 +0100
Message-ID: <20180515182014.42196-4-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180515182014.42196-1-salil.mehta@huawei.com>
References: <20180515182014.42196-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.227.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fuyun Liang <liangfuyun1@huawei.com>

If the client instance is initializd failed, we do not need to uninit it.
This patch adds a state check to check init state of client instance.

Fixes: 38caee9d3ee8 ("net: hns3: Add support of the HNAE3 framework")
Signed-off-by: Fuyun Liang <liangfuyun1@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.c | 15 ++++++++++++---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h |  1 +
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.c b/drivers/net/ethernet/hisilicon/hns3/hnae3.c
index ab2e72c..21cb0c5 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.c
@@ -50,13 +50,22 @@ static int hnae3_match_n_instantiate(struct hnae3_client *client,
 	/* now, (un-)instantiate client by calling lower layer */
 	if (is_reg) {
 		ret = ae_dev->ops->init_client_instance(client, ae_dev);
-		if (ret)
+		if (ret) {
 			dev_err(&ae_dev->pdev->dev,
 				"fail to instantiate client\n");
-		return ret;
+			return ret;
+		}
+
+		hnae_set_bit(ae_dev->flag, HNAE3_CLIENT_INITED_B, 1);
+		return 0;
+	}
+
+	if (hnae_get_bit(ae_dev->flag, HNAE3_CLIENT_INITED_B)) {
+		ae_dev->ops->uninit_client_instance(client, ae_dev);
+
+		hnae_set_bit(ae_dev->flag, HNAE3_CLIENT_INITED_B, 0);
 	}
 
-	ae_dev->ops->uninit_client_instance(client, ae_dev);
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index 804ea83..ffec231 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -52,6 +52,7 @@
 #define HNAE3_DEV_INITED_B			0x0
 #define HNAE3_DEV_SUPPORT_ROCE_B		0x1
 #define HNAE3_DEV_SUPPORT_DCB_B			0x2
+#define HNAE3_CLIENT_INITED_B			0x3
 
 #define HNAE3_DEV_SUPPORT_ROCE_DCB_BITS (BIT(HNAE3_DEV_SUPPORT_DCB_B) |\
 		BIT(HNAE3_DEV_SUPPORT_ROCE_B))
-- 
2.7.4
