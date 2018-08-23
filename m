Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E5BC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C4FE208F7
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:57:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C4FE208F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729597AbeHWN0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 09:26:38 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:12360 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbeHWN0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 09:26:38 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.19]) by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee45b7e8511571-c1255; Thu, 23 Aug 2018 17:57:37 +0800 (CST)
X-RM-TRANSID: 2ee45b7e8511571-c1255
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from bclinux72.localdomain (unknown[223.105.0.243])
        by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea5b7e8510c48-2318a;
        Thu, 23 Aug 2018 17:57:37 +0800 (CST)
X-RM-TRANSID: 2eea5b7e8510c48-2318a
From:   Ding Xiang <dingxiang@cmss.chinamobile.com>
To:     john.garry@huawei.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: hisi_sas: Switch from msleep to usleep_range per timers-howto.txt
Date:   Thu, 23 Aug 2018 07:08:59 -0400
Message-Id: <1535022539-10634-1-git-send-email-dingxiang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use usleep_range to sleep for 10us - 20ms

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c | 8 ++++----
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c | 6 +++---
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
index 8f60f0e..0584f711 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
@@ -579,7 +579,7 @@ static int reset_hw_v1_hw(struct hisi_hba *hisi_hba)
 		phy_ctrl |= PHY_CTRL_RESET_MSK;
 		hisi_sas_phy_write32(hisi_hba, i, PHY_CTRL, phy_ctrl);
 	}
-	msleep(1); /* It is safe to wait for 50us */
+	usleep_range(1000, 1100); /* It is safe to wait for 50us */
 
 	/* Ensure DMA tx & rx idle */
 	for (i = 0; i < hisi_hba->n_phy; i++) {
@@ -632,7 +632,7 @@ static int reset_hw_v1_hw(struct hisi_hba *hisi_hba)
 			     RESET_VALUE);
 		regmap_write(hisi_hba->ctrl, hisi_hba->ctrl_clock_ena_reg + 4,
 			     RESET_VALUE);
-		msleep(1);
+		usleep_range(1000, 1100);
 		regmap_read(hisi_hba->ctrl, hisi_hba->ctrl_reset_sts_reg, &val);
 		if (RESET_VALUE != (val & RESET_VALUE)) {
 			dev_err(dev, "Reset failed\n");
@@ -645,7 +645,7 @@ static int reset_hw_v1_hw(struct hisi_hba *hisi_hba)
 			     RESET_VALUE);
 		regmap_write(hisi_hba->ctrl, hisi_hba->ctrl_clock_ena_reg,
 			     RESET_VALUE);
-		msleep(1);
+		usleep_range(1000, 1100);
 		regmap_read(hisi_hba->ctrl, hisi_hba->ctrl_reset_sts_reg, &val);
 		if (val & RESET_VALUE) {
 			dev_err(dev, "De-reset failed\n");
@@ -841,7 +841,7 @@ static void sl_notify_v1_hw(struct hisi_hba *hisi_hba, int phy_no)
 	sl_control = hisi_sas_phy_read32(hisi_hba, phy_no, SL_CONTROL);
 	sl_control |= SL_CONTROL_NOTIFY_EN_MSK;
 	hisi_sas_phy_write32(hisi_hba, phy_no, SL_CONTROL, sl_control);
-	msleep(1);
+	usleep_range(1000, 1100);
 	sl_control = hisi_sas_phy_read32(hisi_hba, phy_no, SL_CONTROL);
 	sl_control &= ~SL_CONTROL_NOTIFY_EN_MSK;
 	hisi_sas_phy_write32(hisi_hba, phy_no, SL_CONTROL, sl_control);
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
index 9c5c5a6..4ca5f77 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -1081,7 +1081,7 @@ static int reset_hw_v2_hw(struct hisi_hba *hisi_hba)
 				reset_val);
 		regmap_write(hisi_hba->ctrl, hisi_hba->ctrl_clock_ena_reg + 4,
 				reset_val);
-		msleep(1);
+		usleep_range(1000, 1100);
 		regmap_read(hisi_hba->ctrl, hisi_hba->ctrl_reset_sts_reg, &val);
 		if (reset_val != (val & reset_val)) {
 			dev_err(dev, "SAS reset fail.\n");
@@ -1093,7 +1093,7 @@ static int reset_hw_v2_hw(struct hisi_hba *hisi_hba)
 				reset_val);
 		regmap_write(hisi_hba->ctrl, hisi_hba->ctrl_clock_ena_reg,
 				reset_val);
-		msleep(1);
+		usleep_range(1000, 1100);
 		regmap_read(hisi_hba->ctrl, hisi_hba->ctrl_reset_sts_reg,
 				&val);
 		if (val & reset_val) {
@@ -1591,7 +1591,7 @@ static void sl_notify_v2_hw(struct hisi_hba *hisi_hba, int phy_no)
 	sl_control = hisi_sas_phy_read32(hisi_hba, phy_no, SL_CONTROL);
 	sl_control |= SL_CONTROL_NOTIFY_EN_MSK;
 	hisi_sas_phy_write32(hisi_hba, phy_no, SL_CONTROL, sl_control);
-	msleep(1);
+	usleep_range(1000, 1100);
 	sl_control = hisi_sas_phy_read32(hisi_hba, phy_no, SL_CONTROL);
 	sl_control &= ~SL_CONTROL_NOTIFY_EN_MSK;
 	hisi_sas_phy_write32(hisi_hba, phy_no, SL_CONTROL, sl_control);
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 08b503e2..8f57737 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -834,7 +834,7 @@ static void sl_notify_v3_hw(struct hisi_hba *hisi_hba, int phy_no)
 	sl_control = hisi_sas_phy_read32(hisi_hba, phy_no, SL_CONTROL);
 	sl_control |= SL_CONTROL_NOTIFY_EN_MSK;
 	hisi_sas_phy_write32(hisi_hba, phy_no, SL_CONTROL, sl_control);
-	msleep(1);
+	usleep_range(1000, 1100);
 	sl_control = hisi_sas_phy_read32(hisi_hba, phy_no, SL_CONTROL);
 	sl_control &= ~SL_CONTROL_NOTIFY_EN_MSK;
 	hisi_sas_phy_write32(hisi_hba, phy_no, SL_CONTROL, sl_control);
-- 
1.8.3.1



