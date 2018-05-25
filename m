Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968270AbeEYSpy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 14:45:54 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8143 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S968165AbeEYSpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 14:45:14 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>
CC: <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Jian Shen <shenjian15@huawei.com>
Subject: [PATCH net-next 11/12] net: hns3: Adds support for led locate command for copper port
Date: Fri, 25 May 2018 19:43:06 +0100
Message-ID: <20180525184307.36288-12-salil.mehta@huawei.com>
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

From: Jian Shen <shenjian15@huawei.com>

Firmware now supports control of all leds. Existing HNS3 driver code
only supported led locate command over SFP Fibre ports. But now it
is also supported over copper port.
This patch removes existing not needed code for the led locate
command and updates the led control command between driver and
firmware.

Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h | 12 ++------
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 35 +++-------------------
 2 files changed, 6 insertions(+), 41 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
index de2f6f1..d9aaa76 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
@@ -817,21 +817,13 @@ struct hclge_reset_cmd {
 #define HCLGE_NIC_CMQ_DESC_NUM		1024
 #define HCLGE_NIC_CMQ_DESC_NUM_S	3
 
-#define HCLGE_LED_PORT_SPEED_STATE_S	0
-#define HCLGE_LED_PORT_SPEED_STATE_M	GENMASK(5, 0)
-#define HCLGE_LED_ACTIVITY_STATE_S	0
-#define HCLGE_LED_ACTIVITY_STATE_M	GENMASK(1, 0)
-#define HCLGE_LED_LINK_STATE_S		0
-#define HCLGE_LED_LINK_STATE_M		GENMASK(1, 0)
 #define HCLGE_LED_LOCATE_STATE_S	0
 #define HCLGE_LED_LOCATE_STATE_M	GENMASK(1, 0)
 
 struct hclge_set_led_state_cmd {
-	u8 port_speed_led_config;
-	u8 link_led_config;
-	u8 activity_led_config;
+	u8 rsv1[3];
 	u8 locate_led_config;
-	u8 rsv[20];
+	u8 rsv2[20];
 };
 
 int hclge_cmd_init(struct hclge_dev *hdev);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 20988aa..6916685 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -5991,9 +5991,7 @@ static void hclge_get_regs(struct hnae3_handle *handle, u32 *version,
 			"Get 64 bit register failed, ret = %d.\n", ret);
 }
 
-static int hclge_set_led_status_sfp(struct hclge_dev *hdev, u8 speed_led_status,
-				    u8 act_led_status, u8 link_led_status,
-				    u8 locate_led_status)
+static int hclge_set_led_status(struct hclge_dev *hdev, u8 locate_led_status)
 {
 	struct hclge_set_led_state_cmd *req;
 	struct hclge_desc desc;
@@ -6002,12 +6000,6 @@ static int hclge_set_led_status_sfp(struct hclge_dev *hdev, u8 speed_led_status,
 	hclge_cmd_setup_basic_desc(&desc, HCLGE_OPC_LED_STATUS_CFG, false);
 
 	req = (struct hclge_set_led_state_cmd *)desc.data;
-	hnae_set_field(req->port_speed_led_config, HCLGE_LED_PORT_SPEED_STATE_M,
-		       HCLGE_LED_PORT_SPEED_STATE_S, speed_led_status);
-	hnae_set_field(req->link_led_config, HCLGE_LED_ACTIVITY_STATE_M,
-		       HCLGE_LED_ACTIVITY_STATE_S, act_led_status);
-	hnae_set_field(req->activity_led_config, HCLGE_LED_LINK_STATE_M,
-		       HCLGE_LED_LINK_STATE_S, link_led_status);
 	hnae_set_field(req->locate_led_config, HCLGE_LED_LOCATE_STATE_M,
 		       HCLGE_LED_LOCATE_STATE_S, locate_led_status);
 
@@ -6028,36 +6020,17 @@ enum hclge_led_status {
 static int hclge_set_led_id(struct hnae3_handle *handle,
 			    enum ethtool_phys_id_state status)
 {
-#define BLINK_FREQUENCY		2
 	struct hclge_vport *vport = hclge_get_vport(handle);
 	struct hclge_dev *hdev = vport->back;
-	struct phy_device *phydev = hdev->hw.mac.phydev;
-	int ret = 0;
-
-	if (phydev || hdev->hw.mac.media_type != HNAE3_MEDIA_TYPE_FIBER)
-		return -EOPNOTSUPP;
 
 	switch (status) {
 	case ETHTOOL_ID_ACTIVE:
-		ret = hclge_set_led_status_sfp(hdev,
-					       HCLGE_LED_NO_CHANGE,
-					       HCLGE_LED_NO_CHANGE,
-					       HCLGE_LED_NO_CHANGE,
-					       HCLGE_LED_ON);
-		break;
+		return hclge_set_led_status(hdev, HCLGE_LED_ON);
 	case ETHTOOL_ID_INACTIVE:
-		ret = hclge_set_led_status_sfp(hdev,
-					       HCLGE_LED_NO_CHANGE,
-					       HCLGE_LED_NO_CHANGE,
-					       HCLGE_LED_NO_CHANGE,
-					       HCLGE_LED_OFF);
-		break;
+		return hclge_set_led_status(hdev, HCLGE_LED_OFF);
 	default:
-		ret = -EINVAL;
-		break;
+		return -EINVAL;
 	}
-
-	return ret;
 }
 
 static void hclge_get_link_mode(struct hnae3_handle *handle,
-- 
2.7.4
