Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752710AbeESP5U (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 11:57:20 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7689 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752537AbeESPyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 11:54:43 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>
CC: <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Jian Shen <shenjian15@huawei.com>
Subject: [PATCH net-next 3/9] net: hns3: cleanup of return values in hclge_init_client_instance()
Date: Sat, 19 May 2018 16:53:17 +0100
Message-ID: <20180519155323.68960-4-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180519155323.68960-1-salil.mehta@huawei.com>
References: <20180519155323.68960-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.227.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Shen <shenjian15@huawei.com>

Removes the goto and directly returns in case of errors as part of the
cleanup.

Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 46435c8..46e030c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -5297,7 +5297,7 @@ static int hclge_init_client_instance(struct hnae3_client *client,
 			vport->nic.client = client;
 			ret = client->ops->init_instance(&vport->nic);
 			if (ret)
-				goto err;
+				return ret;
 
 			if (hdev->roce_client &&
 			    hnae3_dev_roce_supported(hdev)) {
@@ -5305,11 +5305,11 @@ static int hclge_init_client_instance(struct hnae3_client *client,
 
 				ret = hclge_init_roce_base_info(vport);
 				if (ret)
-					goto err;
+					return ret;
 
 				ret = rc->ops->init_instance(&vport->roce);
 				if (ret)
-					goto err;
+					return ret;
 			}
 
 			break;
@@ -5319,7 +5319,7 @@ static int hclge_init_client_instance(struct hnae3_client *client,
 
 			ret = client->ops->init_instance(&vport->nic);
 			if (ret)
-				goto err;
+				return ret;
 
 			break;
 		case HNAE3_CLIENT_ROCE:
@@ -5331,18 +5331,16 @@ static int hclge_init_client_instance(struct hnae3_client *client,
 			if (hdev->roce_client && hdev->nic_client) {
 				ret = hclge_init_roce_base_info(vport);
 				if (ret)
-					goto err;
+					return ret;
 
 				ret = client->ops->init_instance(&vport->roce);
 				if (ret)
-					goto err;
+					return ret;
 			}
 		}
 	}
 
 	return 0;
-err:
-	return ret;
 }
 
 static void hclge_uninit_client_instance(struct hnae3_client *client,
-- 
2.7.4
