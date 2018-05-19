Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752629AbeESPy5 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 11:54:57 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7707 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752585AbeESPyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 11:54:54 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>
CC: <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Xi Wang <wangxi11@huawei.com>
Subject: [PATCH net-next 5/9] net: hns3: Fix for hns3 module is loaded multiple times problem
Date: Sat, 19 May 2018 16:53:19 +0100
Message-ID: <20180519155323.68960-6-salil.mehta@huawei.com>
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

From: Xi Wang <wangxi11@huawei.com>

If the hns3 driver has been built into kernel and then loaded with
the same driver which built as KLM, it may trigger an error like
below:

[   20.009555] hns3: Hisilicon Ethernet Network Driver for Hip08 Family - version
[   20.016789] hns3: Copyright (c) 2017 Huawei Corporation.
[   20.022100] Error: Driver 'hns3' is already registered, aborting...
[   23.517397] Unable to handle kernel NULL pointer dereference at virtual address 00000000
...
[   23.691583] Process insmod (pid: 1982, stack limit = 0x00000000cd5f21cb)
[   23.698270] Call trace:
[   23.700705]  __list_del_entry_valid+0x2c/0xd8
[   23.705049]  hnae3_unregister_client+0x68/0xa8
[   23.709487]  hns3_init_module+0x98/0x1000 [hns3]
[   23.714093]  do_one_initcall+0x5c/0x170
[   23.717918]  do_init_module+0x64/0x1f4
[   23.721654]  load_module+0x1d14/0x24b0
[   23.725390]  SyS_init_module+0x158/0x208
[   23.729300]  el0_svc_naked+0x30/0x34

This patch fixes it by adding module version info.

Fixes: 38caee9d3ee8 ("net: hns3: Add support of the HNAE3 framework")
Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.c               | 1 +
 drivers/net/ethernet/hisilicon/hns3/hnae3.h               | 2 ++
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c           | 1 +
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h           | 2 ++
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h   | 2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h | 2 +-
 6 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.c b/drivers/net/ethernet/hisilicon/hns3/hnae3.c
index bd3c232..63d7dbf 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.c
@@ -285,3 +285,4 @@ EXPORT_SYMBOL(hnae3_unregister_ae_dev);
 MODULE_AUTHOR("Huawei Tech. Co., Ltd.");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("HNAE3(Hisilicon Network Acceleration Engine) Framework");
+MODULE_VERSION(HNAE3_MOD_VERSION);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index 2f266ef..45c571e 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -36,6 +36,8 @@
 #include <linux/pci.h>
 #include <linux/types.h>
 
+#define HNAE3_MOD_VERSION "1.0"
+
 /* Device IDs */
 #define HNAE3_DEV_ID_GE				0xA220
 #define HNAE3_DEV_ID_25GE			0xA221
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 701ae5e..cac5195 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -3538,3 +3538,4 @@ MODULE_DESCRIPTION("HNS3: Hisilicon Ethernet Driver");
 MODULE_AUTHOR("Huawei Tech. Co., Ltd.");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("pci:hns-nic");
+MODULE_VERSION(HNS3_MOD_VERSION);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
index 98cdbd3..5b40f5a 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
@@ -14,6 +14,8 @@
 
 #include "hnae3.h"
 
+#define HNS3_MOD_VERSION "1.0"
+
 extern const char hns3_driver_version[];
 
 enum hns3_nic_state {
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index af736a4..93177d9 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -17,7 +17,7 @@
 #include "hclge_cmd.h"
 #include "hnae3.h"
 
-#define HCLGE_MOD_VERSION "v1.0"
+#define HCLGE_MOD_VERSION "1.0"
 #define HCLGE_DRIVER_NAME "hclge"
 
 #define HCLGE_INVALID_VPORT 0xffff
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
index a477a7c..9763e74 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
@@ -9,7 +9,7 @@
 #include "hclgevf_cmd.h"
 #include "hnae3.h"
 
-#define HCLGEVF_MOD_VERSION "v1.0"
+#define HCLGEVF_MOD_VERSION "1.0"
 #define HCLGEVF_DRIVER_NAME "hclgevf"
 
 #define HCLGEVF_ROCEE_VECTOR_NUM	0
-- 
2.7.4
