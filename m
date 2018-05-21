Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752627AbeEUKLl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 06:11:41 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:55739 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751202AbeEUKLj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 06:11:39 -0400
From: John Garry <john.garry@huawei.com>
To: <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC: <linux-scsi@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, Xiaofei Tan <tanxiaofei@huawei.com>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH 04/13] scsi: hisi_sas: Add LED feature for v3 hw
Date: Mon, 21 May 2018 18:09:16 +0800
Message-ID: <1526897365-228549-5-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1526897365-228549-1-git-send-email-john.garry@huawei.com>
References: <1526897365-228549-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaofei Tan <tanxiaofei@huawei.com>

This patch implements LED feature of directly attached disk
for v3 hw.

In fact, this hw has created an SGPIO component for LED
feature, and we can control LEDs just by internal registers.

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 42 ++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 0a80a39..a043d9c 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -107,6 +107,10 @@
 #define AWQOS_AWCACHE_CFG	0xc84
 #define ARQOS_ARCACHE_CFG	0xc88
 #define HILINK_ERR_DFX		0xe04
+#define SAS_GPIO_CFG_0		0x1000
+#define SAS_GPIO_CFG_1		0x1004
+#define SAS_GPIO_TX_0_1	0x1040
+#define SAS_CFG_DRIVE_VLD	0x1070
 
 /* phy registers requiring init */
 #define PORT_BASE			(0x2000)
@@ -549,6 +553,14 @@ static void init_reg_v3_hw(struct hisi_hba *hisi_hba)
 	hisi_sas_write32(hisi_hba, SAS_RAS_INTR1_MASK, 0x0);
 	hisi_sas_write32(hisi_hba, SAS_RAS_INTR2_MASK, 0x0);
 	hisi_sas_write32(hisi_hba, CFG_SAS_RAS_INTR_MASK, 0x0);
+
+	/* LED registers init */
+	hisi_sas_write32(hisi_hba, SAS_CFG_DRIVE_VLD, 0x80000ff);
+	hisi_sas_write32(hisi_hba, SAS_GPIO_TX_0_1, 0x80808080);
+	hisi_sas_write32(hisi_hba, SAS_GPIO_TX_0_1 + 0x4, 0x80808080);
+	/* Configure blink generator rate A to 1Hz and B to 4Hz */
+	hisi_sas_write32(hisi_hba, SAS_GPIO_CFG_1, 0x121700);
+	hisi_sas_write32(hisi_hba, SAS_GPIO_CFG_0, 0x800000);
 }
 
 static void config_phy_opt_mode_v3_hw(struct hisi_hba *hisi_hba, int phy_no)
@@ -1974,6 +1986,35 @@ static int soft_reset_v3_hw(struct hisi_hba *hisi_hba)
 	return hw_init_v3_hw(hisi_hba);
 }
 
+static int write_gpio_v3_hw(struct hisi_hba *hisi_hba, u8 reg_type,
+			u8 reg_index, u8 reg_count, u8 *write_data)
+{
+	struct device *dev = hisi_hba->dev;
+	u32 *data = (u32 *)write_data;
+	int i;
+
+	switch (reg_type) {
+	case SAS_GPIO_REG_TX:
+		if ((reg_index + reg_count) > ((hisi_hba->n_phy + 3) / 4)) {
+			dev_err(dev, "write gpio: invalid reg range[%d, %d]\n",
+				reg_index, reg_index + reg_count - 1);
+			return -EINVAL;
+		}
+
+		for (i = 0; i < reg_count; i++)
+			hisi_sas_write32(hisi_hba,
+					 SAS_GPIO_TX_0_1 + (reg_index + i) * 4,
+					 data[i]);
+		break;
+	default:
+		dev_err(dev, "write gpio: unsupported or bad reg type %d\n",
+				reg_type);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static const struct hisi_sas_hw hisi_sas_v3_hw = {
 	.hw_init = hisi_sas_v3_init,
 	.setup_itct = setup_itct_v3_hw,
@@ -1999,6 +2040,7 @@ static int soft_reset_v3_hw(struct hisi_hba *hisi_hba)
 	.soft_reset = soft_reset_v3_hw,
 	.get_phys_state = get_phys_state_v3_hw,
 	.get_events = phy_get_events_v3_hw,
+	.write_gpio = write_gpio_v3_hw,
 };
 
 static struct Scsi_Host *
-- 
1.9.1
