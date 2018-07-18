Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B078ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40A0720850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:16:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40A0720850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731262AbeGROy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 10:54:27 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9695 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730869AbeGROy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 10:54:26 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 09F4353F9BD3E;
        Wed, 18 Jul 2018 22:16:04 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.382.0; Wed, 18 Jul 2018 22:15:56 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>,
        Xiaofei Tan <tanxiaofei@huawei.com>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH 3/9] scsi: hisi_sas: Fix the failure of recovering PHY from STP link timeout
Date:   Wed, 18 Jul 2018 22:14:27 +0800
Message-ID: <1531923273-193768-4-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1531923273-193768-1-git-send-email-john.garry@huawei.com>
References: <1531923273-193768-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaofei Tan <tanxiaofei@huawei.com>

There is an issue that link reset can't recover PHY when STP link timeout.
Because current process of enabling PHY for v3 hw will wait last
transmission done. The time of one transmission depends IO size, disk
model and so on. Normally, it should be shorter than 50ms. But the last
transmission could be never done for some abnormal scenarios, such as STP
link timeout.

This patch is to fix the issue. Check PHY status after starting process of
enabling PHY for 50ms. If the PHY is still active, we disable it forcibly
by PHY reset. Of course, we need to clear the PHY reset bit when enable
PHY.

Besides, the function disable_phy_v3_hw() should not be suitable to call
in interrupts for hilink bug for this 50ms delay. Then, we do link reset
for hilink bug directly. The change is that we don't clear the invalid
dword count register. This is better. Because we should not clear such
error count while not saved.

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index d7c3774..70a6aa2 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -120,6 +120,8 @@
 #define PHY_CFG_ENA_MSK			(0x1 << PHY_CFG_ENA_OFF)
 #define PHY_CFG_DC_OPT_OFF		2
 #define PHY_CFG_DC_OPT_MSK		(0x1 << PHY_CFG_DC_OPT_OFF)
+#define PHY_CFG_PHY_RST_OFF		3
+#define PHY_CFG_PHY_RST_MSK		(0x1 << PHY_CFG_PHY_RST_OFF)
 #define PROG_PHY_LINK_RATE		(PORT_BASE + 0x8)
 #define PHY_CTRL			(PORT_BASE + 0x14)
 #define PHY_CTRL_RESET_OFF		0
@@ -760,15 +762,25 @@ static void enable_phy_v3_hw(struct hisi_hba *hisi_hba, int phy_no)
 	u32 cfg = hisi_sas_phy_read32(hisi_hba, phy_no, PHY_CFG);
 
 	cfg |= PHY_CFG_ENA_MSK;
+	cfg &= ~PHY_CFG_PHY_RST_MSK;
 	hisi_sas_phy_write32(hisi_hba, phy_no, PHY_CFG, cfg);
 }
 
 static void disable_phy_v3_hw(struct hisi_hba *hisi_hba, int phy_no)
 {
 	u32 cfg = hisi_sas_phy_read32(hisi_hba, phy_no, PHY_CFG);
+	u32 state;
 
 	cfg &= ~PHY_CFG_ENA_MSK;
 	hisi_sas_phy_write32(hisi_hba, phy_no, PHY_CFG, cfg);
+
+	mdelay(50);
+
+	state = hisi_sas_read32(hisi_hba, PHY_STATE);
+	if (state & BIT(phy_no)) {
+		cfg |= PHY_CFG_PHY_RST_MSK;
+		hisi_sas_phy_write32(hisi_hba, phy_no, PHY_CFG, cfg);
+	}
 }
 
 static void start_phy_v3_hw(struct hisi_hba *hisi_hba, int phy_no)
@@ -1385,8 +1397,6 @@ static void handle_chl_int2_v3_hw(struct hisi_hba *hisi_hba, int phy_no)
 			hisi_sas_notify_phy_event(phy, HISI_PHYE_LINK_RESET);
 	}
 
-	hisi_sas_phy_write32(hisi_hba, phy_no, CHL_INT2, irq_value);
-
 	if ((irq_value & BIT(CHL_INT2_RX_INVLD_DW_OFF)) &&
 	    (pci_dev->revision == 0x20)) {
 		u32 reg_value;
@@ -1396,15 +1406,11 @@ static void handle_chl_int2_v3_hw(struct hisi_hba *hisi_hba, int phy_no)
 				HILINK_ERR_DFX, reg_value,
 				!((reg_value >> 8) & BIT(phy_no)),
 				1000, 10000);
-		if (rc) {
-			disable_phy_v3_hw(hisi_hba, phy_no);
-			hisi_sas_phy_write32(hisi_hba, phy_no, CHL_INT2,
-					     BIT(CHL_INT2_RX_INVLD_DW_OFF));
-			hisi_sas_phy_read32(hisi_hba, phy_no, ERR_CNT_INVLD_DW);
-			mdelay(1);
-			enable_phy_v3_hw(hisi_hba, phy_no);
-		}
+		if (rc)
+			hisi_sas_notify_phy_event(phy, HISI_PHYE_LINK_RESET);
 	}
+
+	hisi_sas_phy_write32(hisi_hba, phy_no, CHL_INT2, irq_value);
 }
 
 static irqreturn_t int_chnl_int_v3_hw(int irq_no, void *p)
-- 
1.9.1

