Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968110AbeEYSpJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 14:45:09 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8142 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S968030AbeEYSo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 14:44:59 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>
CC: <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH net-next 06/12] net: hns3: Fixes the state to indicate client-type initialization
Date: Fri, 25 May 2018 19:43:01 +0100
Message-ID: <20180525184307.36288-7-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180525184307.36288-1-salil.mehta@huawei.com>
References: <20180525184307.36288-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.227.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Li <lipeng321@huawei.com>

HNAE3 module supports kernel nic driver, user nic driver and roce driver,
and there are 3 client types. Driver uses one bit(HNAE3_CLIENT_INITED_B)
to indicate the client initialization state, it will cause confusion
for 3 client types. This patch fixes it by use 3 bits to indicate the
initialization state.

Fixes: 38caee9d3ee8 ("net: hns3: Add support of the HNAE3 framework")
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.c | 49 +++++++++++++++++++++++++++--
 drivers/net/ethernet/hisilicon/hns3/hnae3.h |  4 ++-
 2 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.c b/drivers/net/ethernet/hisilicon/hns3/hnae3.c
index 63d7dbf..9d79dad 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.c
@@ -36,6 +36,49 @@ static bool hnae3_client_match(enum hnae3_client_type client_type,
 	return false;
 }
 
+static void hnae3_set_client_init_flag(struct hnae3_client *client,
+				       struct hnae3_ae_dev *ae_dev, int inited)
+{
+	switch (client->type) {
+	case HNAE3_CLIENT_KNIC:
+		hnae_set_bit(ae_dev->flag, HNAE3_KNIC_CLIENT_INITED_B, inited);
+		break;
+	case HNAE3_CLIENT_UNIC:
+		hnae_set_bit(ae_dev->flag, HNAE3_UNIC_CLIENT_INITED_B, inited);
+		break;
+	case HNAE3_CLIENT_ROCE:
+		hnae_set_bit(ae_dev->flag, HNAE3_ROCE_CLIENT_INITED_B, inited);
+		break;
+	default:
+		break;
+	}
+}
+
+static int hnae3_get_client_init_flag(struct hnae3_client *client,
+				       struct hnae3_ae_dev *ae_dev)
+{
+	int inited = 0;
+
+	switch (client->type) {
+	case HNAE3_CLIENT_KNIC:
+		inited = hnae_get_bit(ae_dev->flag,
+				       HNAE3_KNIC_CLIENT_INITED_B);
+		break;
+	case HNAE3_CLIENT_UNIC:
+		inited = hnae_get_bit(ae_dev->flag,
+				       HNAE3_UNIC_CLIENT_INITED_B);
+		break;
+	case HNAE3_CLIENT_ROCE:
+		inited = hnae_get_bit(ae_dev->flag,
+				      HNAE3_ROCE_CLIENT_INITED_B);
+		break;
+	default:
+		break;
+	}
+
+	return inited;
+}
+
 static int hnae3_match_n_instantiate(struct hnae3_client *client,
 				     struct hnae3_ae_dev *ae_dev, bool is_reg)
 {
@@ -56,14 +99,14 @@ static int hnae3_match_n_instantiate(struct hnae3_client *client,
 			return ret;
 		}
 
-		hnae_set_bit(ae_dev->flag, HNAE3_CLIENT_INITED_B, 1);
+		hnae3_set_client_init_flag(client, ae_dev, 1);
 		return 0;
 	}
 
-	if (hnae_get_bit(ae_dev->flag, HNAE3_CLIENT_INITED_B)) {
+	if (hnae3_get_client_init_flag(client, ae_dev)) {
 		ae_dev->ops->uninit_client_instance(client, ae_dev);
 
-		hnae_set_bit(ae_dev->flag, HNAE3_CLIENT_INITED_B, 0);
+		hnae3_set_client_init_flag(client, ae_dev, 0);
 	}
 
 	return 0;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index 45c571e..f250c59 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -54,7 +54,9 @@
 #define HNAE3_DEV_INITED_B			0x0
 #define HNAE3_DEV_SUPPORT_ROCE_B		0x1
 #define HNAE3_DEV_SUPPORT_DCB_B			0x2
-#define HNAE3_CLIENT_INITED_B			0x3
+#define HNAE3_KNIC_CLIENT_INITED_B		0x3
+#define HNAE3_UNIC_CLIENT_INITED_B		0x4
+#define HNAE3_ROCE_CLIENT_INITED_B		0x5
 
 #define HNAE3_DEV_SUPPORT_ROCE_DCB_BITS (BIT(HNAE3_DEV_SUPPORT_DCB_B) |\
 		BIT(HNAE3_DEV_SUPPORT_ROCE_B))
-- 
2.7.4
