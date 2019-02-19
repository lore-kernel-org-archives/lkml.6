Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA50C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06A3921479
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbfBSKBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 05:01:53 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:57461 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbfBSKBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 05:01:52 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x1JA1TbN006737, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtitcasv01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x1JA1TbN006737
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NOT);
        Tue, 19 Feb 2019 18:01:29 +0800
Received: from localhost (172.22.88.128) by RTITCASV01.realtek.com.tw
 (172.21.6.18) with Microsoft SMTP Server id 14.3.408.0; Tue, 19 Feb 2019
 18:01:28 +0800
From:   <ricky_wu@realtek.com>
To:     <arnd@arnd.de>, <gregkh@linuxfoundation.org>,
        <colin.king@canonical.com>, <axboe@kernel.dk>,
        <linux-kernel@vger.kernel.org>
CC:     RickyWu <ricky_wu@realtek.com>
Subject: [PATCH] misc: rtsx: Enable OCP for rts522a rts524a rts525a rts5260
Date:   Tue, 19 Feb 2019 18:01:24 +0800
Message-ID: <20190219100124.27339-1-ricky_wu@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.22.88.128]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: RickyWu <ricky_wu@realtek.com>

this enables and adds OCP function for Realtek A series cardreader chips
and fixes some OCP flow in rts5260.c
Signed-off-by: RickyWu <ricky_wu@realtek.com>
---
 drivers/misc/cardreader/rts5227.c  |  64 +++++++++++---
 drivers/misc/cardreader/rts5249.c  |  32 +++++--
 drivers/misc/cardreader/rts5260.c  | 136 +++++++++++------------------
 drivers/misc/cardreader/rtsx_pcr.c |  40 +++++++--
 drivers/misc/cardreader/rtsx_pcr.h |   5 ++
 5 files changed, 165 insertions(+), 112 deletions(-)

diff --git a/drivers/misc/cardreader/rts5227.c b/drivers/misc/cardreader/rts5227.c
index 024dcba8d6c8..5c98e2221889 100644
--- a/drivers/misc/cardreader/rts5227.c
+++ b/drivers/misc/cardreader/rts5227.c
@@ -170,35 +170,46 @@ static int rts5227_card_power_on(struct rtsx_pcr *pcr, int card)
 {
 	int err;
 
+	if (pcr->option.ocp_en)
+		rtsx_pci_enable_ocp(pcr);
+
 	rtsx_pci_init_cmd(pcr);
 	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, CARD_PWR_CTL,
 			SD_POWER_MASK, SD_PARTIAL_POWER_ON);
+
 	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, PWR_GATE_CTRL,
 			LDO3318_PWR_MASK, 0x02);
+
 	err = rtsx_pci_send_cmd(pcr, 100);
 	if (err < 0)
 		return err;
 
 	/* To avoid too large in-rush current */
-	udelay(150);
-
+	msleep(20);
 	rtsx_pci_init_cmd(pcr);
 	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, CARD_PWR_CTL,
 			SD_POWER_MASK, SD_POWER_ON);
+
 	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, PWR_GATE_CTRL,
 			LDO3318_PWR_MASK, 0x06);
+
+	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, CARD_OE,
+			SD_OUTPUT_EN, SD_OUTPUT_EN);
+	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, CARD_OE,
+			MS_OUTPUT_EN, MS_OUTPUT_EN);
 	return rtsx_pci_send_cmd(pcr, 100);
 }
 
 static int rts5227_card_power_off(struct rtsx_pcr *pcr, int card)
 {
-	rtsx_pci_init_cmd(pcr);
-	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, CARD_PWR_CTL,
-			SD_POWER_MASK | PMOS_STRG_MASK,
-			SD_POWER_OFF | PMOS_STRG_400mA);
-	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, PWR_GATE_CTRL,
-			LDO3318_PWR_MASK, 0X00);
-	return rtsx_pci_send_cmd(pcr, 100);
+	if (pcr->option.ocp_en)
+		rtsx_pci_disable_ocp(pcr);
+
+	rtsx_pci_write_register(pcr, CARD_PWR_CTL, SD_POWER_MASK |
+			PMOS_STRG_MASK, SD_POWER_OFF | PMOS_STRG_400mA);
+	rtsx_pci_write_register(pcr, PWR_GATE_CTRL, LDO3318_PWR_MASK, 0X00);
+
+	return 0;
 }
 
 static int rts5227_switch_output_voltage(struct rtsx_pcr *pcr, u8 voltage)
@@ -348,6 +359,32 @@ static int rts522a_extra_init_hw(struct rtsx_pcr *pcr)
 	return 0;
 }
 
+static int rts522a_switch_output_voltage(struct rtsx_pcr *pcr, u8 voltage)
+{
+	int err;
+
+	if (voltage == OUTPUT_3V3) {
+		err = rtsx_pci_write_phy_register(pcr, 0x08, 0x57E4);
+		if (err < 0)
+			return err;
+	} else if (voltage == OUTPUT_1V8) {
+		err = rtsx_pci_write_phy_register(pcr, 0x11, 0x3C02);
+		if (err < 0)
+			return err;
+		err = rtsx_pci_write_phy_register(pcr, 0x08, 0x54A4);
+		if (err < 0)
+			return err;
+	} else {
+		return -EINVAL;
+	}
+
+	/* set pad drive */
+	rtsx_pci_init_cmd(pcr);
+	rts5227_fill_driving(pcr, voltage);
+	return rtsx_pci_send_cmd(pcr, 100);
+}
+
+
 /* rts522a operations mainly derived from rts5227, except phy/hw init setting.
  */
 static const struct pcr_ops rts522a_pcr_ops = {
@@ -360,7 +397,7 @@ static const struct pcr_ops rts522a_pcr_ops = {
 	.disable_auto_blink = rts5227_disable_auto_blink,
 	.card_power_on = rts5227_card_power_on,
 	.card_power_off = rts5227_card_power_off,
-	.switch_output_voltage = rts5227_switch_output_voltage,
+	.switch_output_voltage = rts522a_switch_output_voltage,
 	.cd_deglitch = NULL,
 	.conv_clk_and_div_n = NULL,
 	.force_power_down = rts5227_force_power_down,
@@ -371,4 +408,11 @@ void rts522a_init_params(struct rtsx_pcr *pcr)
 	rts5227_init_params(pcr);
 
 	pcr->reg_pm_ctrl3 = RTS522A_PM_CTRL3;
+
+	pcr->option.ocp_en = 1;
+	if (pcr->option.ocp_en)
+		pcr->hw_param.interrupt_en |= SD_OC_INT_EN;
+	pcr->hw_param.ocp_glitch = SD_OCP_GLITCH_10M;
+	pcr->option.sd_800mA_ocp_thd = RTS522A_OCP_THD_800;
+
 }
diff --git a/drivers/misc/cardreader/rts5249.c b/drivers/misc/cardreader/rts5249.c
index dbe013abdb83..0f72a7e0fdab 100644
--- a/drivers/misc/cardreader/rts5249.c
+++ b/drivers/misc/cardreader/rts5249.c
@@ -284,6 +284,10 @@ static int rtsx_base_disable_auto_blink(struct rtsx_pcr *pcr)
 static int rtsx_base_card_power_on(struct rtsx_pcr *pcr, int card)
 {
 	int err;
+	struct rtsx_cr_option *option = &pcr->option;
+
+	if (option->ocp_en)
+		rtsx_pci_enable_ocp(pcr);
 
 	rtsx_pci_init_cmd(pcr);
 	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, CARD_PWR_CTL,
@@ -306,12 +310,15 @@ static int rtsx_base_card_power_on(struct rtsx_pcr *pcr, int card)
 
 static int rtsx_base_card_power_off(struct rtsx_pcr *pcr, int card)
 {
-	rtsx_pci_init_cmd(pcr);
-	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, CARD_PWR_CTL,
-			SD_POWER_MASK, SD_POWER_OFF);
-	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, PWR_GATE_CTRL,
-			LDO3318_PWR_MASK, 0x00);
-	return rtsx_pci_send_cmd(pcr, 100);
+	struct rtsx_cr_option *option = &pcr->option;
+
+	if (option->ocp_en)
+		rtsx_pci_disable_ocp(pcr);
+
+	rtsx_pci_write_register(pcr, CARD_PWR_CTL, SD_POWER_MASK, SD_POWER_OFF);
+
+	rtsx_pci_write_register(pcr, PWR_GATE_CTRL, LDO3318_PWR_MASK, 0x00);
+	return 0;
 }
 
 static int rtsx_base_switch_output_voltage(struct rtsx_pcr *pcr, u8 voltage)
@@ -629,6 +636,13 @@ void rts524a_init_params(struct rtsx_pcr *pcr)
 
 	pcr->reg_pm_ctrl3 = RTS524A_PM_CTRL3;
 	pcr->ops = &rts524a_pcr_ops;
+
+	pcr->option.ocp_en = 1;
+	if (pcr->option.ocp_en)
+		pcr->hw_param.interrupt_en |= SD_OC_INT_EN;
+	pcr->hw_param.ocp_glitch = SD_OCP_GLITCH_10M;
+	pcr->option.sd_800mA_ocp_thd = RTS524A_OCP_THD_800;
+
 }
 
 static int rts525a_card_power_on(struct rtsx_pcr *pcr, int card)
@@ -737,4 +751,10 @@ void rts525a_init_params(struct rtsx_pcr *pcr)
 
 	pcr->reg_pm_ctrl3 = RTS524A_PM_CTRL3;
 	pcr->ops = &rts525a_pcr_ops;
+
+	pcr->option.ocp_en = 1;
+	if (pcr->option.ocp_en)
+		pcr->hw_param.interrupt_en |= SD_OC_INT_EN;
+	pcr->hw_param.ocp_glitch = SD_OCP_GLITCH_10M;
+	pcr->option.sd_800mA_ocp_thd = RTS525A_OCP_THD_800;
 }
diff --git a/drivers/misc/cardreader/rts5260.c b/drivers/misc/cardreader/rts5260.c
index a493b01c5bc6..da22bcb62b04 100644
--- a/drivers/misc/cardreader/rts5260.c
+++ b/drivers/misc/cardreader/rts5260.c
@@ -64,11 +64,13 @@ static void rts5260_fill_driving(struct rtsx_pcr *pcr, u8 voltage)
 		drive_sel = pcr->sd30_drive_sel_1v8;
 	}
 
-	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, SD30_CLK_DRIVE_SEL,
+	rtsx_pci_write_register(pcr, SD30_CLK_DRIVE_SEL,
 			 0xFF, driving[drive_sel][0]);
-	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, SD30_CMD_DRIVE_SEL,
+
+	rtsx_pci_write_register(pcr, SD30_CMD_DRIVE_SEL,
 			 0xFF, driving[drive_sel][1]);
-	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, SD30_DAT_DRIVE_SEL,
+
+	rtsx_pci_write_register(pcr, SD30_CMD_DRIVE_SEL,
 			 0xFF, driving[drive_sel][2]);
 }
 
@@ -193,7 +195,7 @@ static int sd_set_sample_push_timing_sd30(struct rtsx_pcr *pcr)
 		| SD_ASYNC_FIFO_NOT_RST, SD_30_MODE | SD_ASYNC_FIFO_NOT_RST);
 	rtsx_pci_write_register(pcr, CLK_CTL, CLK_LOW_FREQ, CLK_LOW_FREQ);
 	rtsx_pci_write_register(pcr, CARD_CLK_SOURCE, 0xFF,
-				CRC_VAR_CLK0 | SD30_FIX_CLK | SAMPLE_VAR_CLK1);
+			CRC_VAR_CLK0 | SD30_FIX_CLK | SAMPLE_VAR_CLK1);
 	rtsx_pci_write_register(pcr, CLK_CTL, CLK_LOW_FREQ, 0);
 
 	return 0;
@@ -207,22 +209,16 @@ static int rts5260_card_power_on(struct rtsx_pcr *pcr, int card)
 	if (option->ocp_en)
 		rtsx_pci_enable_ocp(pcr);
 
-	rtsx_pci_init_cmd(pcr);
-	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, LDO_CONFIG2,
-			 DV331812_VDD1, DV331812_VDD1);
-	err = rtsx_pci_send_cmd(pcr, CMD_TIMEOUT_DEF);
-	if (err < 0)
-		return err;
 
-	rtsx_pci_init_cmd(pcr);
-	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, LDO_VCC_CFG0,
+	rtsx_pci_write_register(pcr, LDO_CONFIG2, DV331812_VDD1, DV331812_VDD1);
+	rtsx_pci_write_register(pcr, LDO_VCC_CFG0,
 			 RTS5260_DVCC_TUNE_MASK, RTS5260_DVCC_33);
-	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, LDO_VCC_CFG1,
-			 LDO_POW_SDVDD1_MASK, LDO_POW_SDVDD1_ON);
-	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, LDO_CONFIG2,
-			 DV331812_POWERON, DV331812_POWERON);
-	err = rtsx_pci_send_cmd(pcr, CMD_TIMEOUT_DEF);
 
+	rtsx_pci_write_register(pcr, LDO_VCC_CFG1, LDO_POW_SDVDD1_MASK,
+			LDO_POW_SDVDD1_ON);
+
+	rtsx_pci_write_register(pcr, LDO_CONFIG2,
+			 DV331812_POWERON, DV331812_POWERON);
 	msleep(20);
 
 	if (pcr->extra_caps & EXTRA_CAPS_SD_SDR50 ||
@@ -242,8 +238,8 @@ static int rts5260_card_power_on(struct rtsx_pcr *pcr, int card)
 	/* Reset SD_CFG3 register */
 	rtsx_pci_write_register(pcr, SD_CFG3, SD30_CLK_END_EN, 0);
 	rtsx_pci_write_register(pcr, REG_SD_STOP_SDCLK_CFG,
-				SD30_CLK_STOP_CFG_EN | SD30_CLK_STOP_CFG1 |
-				SD30_CLK_STOP_CFG0, 0);
+			SD30_CLK_STOP_CFG_EN | SD30_CLK_STOP_CFG1 |
+			SD30_CLK_STOP_CFG0, 0);
 
 	rtsx_pci_write_register(pcr, REG_PRE_RW_MODE, EN_INFINITE_MODE, 0);
 
@@ -273,9 +269,9 @@ static int rts5260_switch_output_voltage(struct rtsx_pcr *pcr, u8 voltage)
 	}
 
 	/* set pad drive */
-	rtsx_pci_init_cmd(pcr);
 	rts5260_fill_driving(pcr, voltage);
-	return rtsx_pci_send_cmd(pcr, CMD_TIMEOUT_DEF);
+
+	return 0;
 }
 
 static void rts5260_stop_cmd(struct rtsx_pcr *pcr)
@@ -290,13 +286,9 @@ static void rts5260_stop_cmd(struct rtsx_pcr *pcr)
 
 static void rts5260_card_before_power_off(struct rtsx_pcr *pcr)
 {
-	struct rtsx_cr_option *option = &pcr->option;
-
 	rts5260_stop_cmd(pcr);
 	rts5260_switch_output_voltage(pcr, OUTPUT_3V3);
 
-	if (option->ocp_en)
-		rtsx_pci_disable_ocp(pcr);
 }
 
 static int rts5260_card_power_off(struct rtsx_pcr *pcr, int card)
@@ -304,13 +296,12 @@ static int rts5260_card_power_off(struct rtsx_pcr *pcr, int card)
 	int err = 0;
 
 	rts5260_card_before_power_off(pcr);
-
-	rtsx_pci_init_cmd(pcr);
-	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, LDO_VCC_CFG1,
+	err = rtsx_pci_write_register(pcr, LDO_VCC_CFG1,
 			 LDO_POW_SDVDD1_MASK, LDO_POW_SDVDD1_OFF);
-	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, LDO_CONFIG2,
+	err = rtsx_pci_write_register(pcr, LDO_CONFIG2,
 			 DV331812_POWERON, DV331812_POWEROFF);
-	err = rtsx_pci_send_cmd(pcr, CMD_TIMEOUT_DEF);
+	if (pcr->option.ocp_en)
+		rtsx_pci_disable_ocp(pcr);
 
 	return err;
 }
@@ -322,41 +313,29 @@ static void rts5260_init_ocp(struct rtsx_pcr *pcr)
 	if (option->ocp_en) {
 		u8 mask, val;
 
-		rtsx_pci_write_register(pcr, RTS5260_DVCC_CTRL,
-					RTS5260_DVCC_OCP_EN |
-					RTS5260_DVCC_OCP_CL_EN,
-					RTS5260_DVCC_OCP_EN |
-					RTS5260_DVCC_OCP_CL_EN);
-		rtsx_pci_write_register(pcr, RTS5260_DVIO_CTRL,
-					RTS5260_DVIO_OCP_EN |
-					RTS5260_DVIO_OCP_CL_EN,
-					RTS5260_DVIO_OCP_EN |
-					RTS5260_DVIO_OCP_CL_EN);
 
 		rtsx_pci_write_register(pcr, RTS5260_DVCC_CTRL,
-					RTS5260_DVCC_OCP_THD_MASK,
-					option->sd_400mA_ocp_thd);
-
-		rtsx_pci_write_register(pcr, RTS5260_DVIO_CTRL,
-					RTS5260_DVIO_OCP_THD_MASK,
-					RTS5260_DVIO_OCP_THD_350);
+				RTS5260_DVCC_OCP_THD_MASK,
+				option->sd_800mA_ocp_thd);
 
 		rtsx_pci_write_register(pcr, RTS5260_DV331812_CFG,
-					RTS5260_DV331812_OCP_THD_MASK,
-					RTS5260_DV331812_OCP_THD_210);
+				RTS5260_DV331812_OCP_THD_MASK,
+				RTS5260_DV331812_OCP_THD_270);
 
-		mask = SD_OCP_GLITCH_MASK | SDVIO_OCP_GLITCH_MASK;
+		mask = SD_OCP_GLITCH_MASK;
 		val = pcr->hw_param.ocp_glitch;
 		rtsx_pci_write_register(pcr, REG_OCPGLITCH, mask, val);
+		rtsx_pci_write_register(pcr, RTS5260_DVCC_CTRL,
+					RTS5260_DVCC_OCP_EN |
+					RTS5260_DVCC_OCP_CL_EN,
+					RTS5260_DVCC_OCP_EN |
+					RTS5260_DVCC_OCP_CL_EN);
 
 		rtsx_pci_enable_ocp(pcr);
 	} else {
 		rtsx_pci_write_register(pcr, RTS5260_DVCC_CTRL,
 					RTS5260_DVCC_OCP_EN |
 					RTS5260_DVCC_OCP_CL_EN, 0);
-		rtsx_pci_write_register(pcr, RTS5260_DVIO_CTRL,
-					RTS5260_DVIO_OCP_EN |
-					RTS5260_DVIO_OCP_CL_EN, 0);
 	}
 }
 
@@ -364,14 +343,9 @@ static void rts5260_enable_ocp(struct rtsx_pcr *pcr)
 {
 	u8 val = 0;
 
-	rtsx_pci_write_register(pcr, FPDCTL, OC_POWER_DOWN, 0);
-
 	val = SD_OCP_INT_EN | SD_DETECT_EN;
-	val |= SDVIO_OCP_INT_EN | SDVIO_DETECT_EN;
 	rtsx_pci_write_register(pcr, REG_OCPCTL, 0xFF, val);
-	rtsx_pci_write_register(pcr, REG_DV3318_OCPCTL,
-				DV3318_DETECT_EN | DV3318_OCP_INT_EN,
-				DV3318_DETECT_EN | DV3318_OCP_INT_EN);
+
 }
 
 static void rts5260_disable_ocp(struct rtsx_pcr *pcr)
@@ -379,15 +353,11 @@ static void rts5260_disable_ocp(struct rtsx_pcr *pcr)
 	u8 mask = 0;
 
 	mask = SD_OCP_INT_EN | SD_DETECT_EN;
-	mask |= SDVIO_OCP_INT_EN | SDVIO_DETECT_EN;
 	rtsx_pci_write_register(pcr, REG_OCPCTL, mask, 0);
-	rtsx_pci_write_register(pcr, REG_DV3318_OCPCTL,
-				DV3318_DETECT_EN | DV3318_OCP_INT_EN, 0);
 
-	rtsx_pci_write_register(pcr, FPDCTL, OC_POWER_DOWN,
-				OC_POWER_DOWN);
 }
 
+
 static int rts5260_get_ocpstat(struct rtsx_pcr *pcr, u8 *val)
 {
 	return rtsx_pci_read_register(pcr, REG_OCPSTAT, val);
@@ -404,9 +374,7 @@ static void rts5260_clear_ocpstat(struct rtsx_pcr *pcr)
 	u8 val = 0;
 
 	mask = SD_OCP_INT_CLR | SD_OC_CLR;
-	mask |= SDVIO_OCP_INT_CLR | SDVIO_OC_CLR;
 	val = SD_OCP_INT_CLR | SD_OC_CLR;
-	val |= SDVIO_OCP_INT_CLR | SDVIO_OC_CLR;
 
 	rtsx_pci_write_register(pcr, REG_OCPCTL, mask, val);
 	rtsx_pci_write_register(pcr, REG_DV3318_OCPCTL,
@@ -425,36 +393,22 @@ static void rts5260_process_ocp(struct rtsx_pcr *pcr)
 
 	rtsx_pci_get_ocpstat(pcr, &pcr->ocp_stat);
 	rts5260_get_ocpstat2(pcr, &pcr->ocp_stat2);
-	if (pcr->card_exist & SD_EXIST)
-		rtsx_sd_power_off_card3v3(pcr);
-	else if (pcr->card_exist & MS_EXIST)
-		rtsx_ms_power_off_card3v3(pcr);
-
-	if (!(pcr->card_exist & MS_EXIST) && !(pcr->card_exist & SD_EXIST)) {
-		if ((pcr->ocp_stat & (SD_OC_NOW | SD_OC_EVER |
-			SDVIO_OC_NOW | SDVIO_OC_EVER)) ||
-			(pcr->ocp_stat2 & (DV3318_OCP_NOW | DV3318_OCP_EVER)))
-			rtsx_pci_clear_ocpstat(pcr);
+
+	if ((pcr->ocp_stat & (SD_OC_NOW | SD_OC_EVER)) ||
+		(pcr->ocp_stat2 & (DV3318_OCP_NOW | DV3318_OCP_EVER))) {
+		rtsx_pci_card_power_off(pcr, RTSX_SD_CARD);
+		rtsx_pci_write_register(pcr, CARD_OE, SD_OUTPUT_EN, 0);
+		rtsx_pci_clear_ocpstat(pcr);
 		pcr->ocp_stat = 0;
 		pcr->ocp_stat2 = 0;
 	}
 
-	if ((pcr->ocp_stat & (SD_OC_NOW | SD_OC_EVER |
-			SDVIO_OC_NOW | SDVIO_OC_EVER)) ||
-			(pcr->ocp_stat2 & (DV3318_OCP_NOW | DV3318_OCP_EVER))) {
-		if (pcr->card_exist & SD_EXIST)
-			rtsx_pci_write_register(pcr, CARD_OE, SD_OUTPUT_EN, 0);
-		else if (pcr->card_exist & MS_EXIST)
-			rtsx_pci_write_register(pcr, CARD_OE, MS_OUTPUT_EN, 0);
-	}
 }
 
 static int rts5260_init_hw(struct rtsx_pcr *pcr)
 {
 	int err;
 
-	rtsx_pci_init_ocp(pcr);
-
 	rtsx_pci_init_cmd(pcr);
 
 	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, L1SUB_CONFIG1,
@@ -483,6 +437,8 @@ static int rts5260_init_hw(struct rtsx_pcr *pcr)
 	if (err < 0)
 		return err;
 
+	rtsx_pci_init_ocp(pcr);
+
 	return 0;
 }
 
@@ -499,7 +455,13 @@ static void rts5260_pwr_saving_setting(struct rtsx_pcr *pcr)
 		pcr_dbg(pcr, "Set parameters for L1.2.");
 		rtsx_pci_write_register(pcr, PWR_GLOBAL_CTRL,
 					0xFF, PCIE_L1_2_EN);
-		rtsx_pci_write_register(pcr, PWR_FE_CTL,
+	rtsx_pci_write_register(pcr, RTS5260_DVCC_CTRL,
+					RTS5260_DVCC_OCP_EN |
+					RTS5260_DVCC_OCP_CL_EN,
+					RTS5260_DVCC_OCP_EN |
+					RTS5260_DVCC_OCP_CL_EN);
+
+	rtsx_pci_write_register(pcr, PWR_FE_CTL,
 					0xFF, PCIE_L1_2_PD_FE_EN);
 	} else if (lss_l1_1) {
 		pcr_dbg(pcr, "Set parameters for L1.1.");
@@ -742,7 +704,7 @@ void rts5260_init_params(struct rtsx_pcr *pcr)
 	option->ocp_en = 1;
 	if (option->ocp_en)
 		hw_param->interrupt_en |= SD_OC_INT_EN;
-	hw_param->ocp_glitch = SD_OCP_GLITCH_10M | SDVIO_OCP_GLITCH_800U;
+	hw_param->ocp_glitch =  SDVIO_OCP_GLITCH_800U | SDVIO_OCP_GLITCH_800U;
 	option->sd_400mA_ocp_thd = RTS5260_DVCC_OCP_THD_550;
 	option->sd_800mA_ocp_thd = RTS5260_DVCC_OCP_THD_970;
 }
diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
index da445223f4cc..0d320e0ab4c9 100644
--- a/drivers/misc/cardreader/rtsx_pcr.c
+++ b/drivers/misc/cardreader/rtsx_pcr.c
@@ -703,7 +703,10 @@ EXPORT_SYMBOL_GPL(rtsx_pci_card_pull_ctl_disable);
 
 static void rtsx_pci_enable_bus_int(struct rtsx_pcr *pcr)
 {
-	pcr->bier = TRANS_OK_INT_EN | TRANS_FAIL_INT_EN | SD_INT_EN;
+	struct rtsx_hw_param *hw_param = &pcr->hw_param;
+
+	pcr->bier = TRANS_OK_INT_EN | TRANS_FAIL_INT_EN | SD_INT_EN
+		| hw_param->interrupt_en;
 
 	if (pcr->num_slots > 1)
 		pcr->bier |= MS_INT_EN;
@@ -969,8 +972,19 @@ static void rtsx_pci_card_detect(struct work_struct *work)
 
 static void rtsx_pci_process_ocp(struct rtsx_pcr *pcr)
 {
-	if (pcr->ops->process_ocp)
+	if (pcr->ops->process_ocp) {
 		pcr->ops->process_ocp(pcr);
+	} else {
+		if (!pcr->option.ocp_en)
+			return;
+		rtsx_pci_get_ocpstat(pcr, &pcr->ocp_stat);
+		if (pcr->ocp_stat & (SD_OC_NOW | SD_OC_EVER)) {
+			rtsx_pci_card_power_off(pcr, RTSX_SD_CARD);
+			rtsx_pci_write_register(pcr, CARD_OE, SD_OUTPUT_EN, 0);
+			rtsx_pci_clear_ocpstat(pcr);
+			pcr->ocp_stat = 0;
+		}
+	}
 }
 
 static int rtsx_pci_process_ocp_interrupt(struct rtsx_pcr *pcr)
@@ -1039,7 +1053,7 @@ static irqreturn_t rtsx_pci_isr(int irq, void *dev_id)
 		}
 	}
 
-	if (pcr->card_inserted || pcr->card_removed)
+	if ((pcr->card_inserted || pcr->card_removed) && !(int_reg & SD_OC_INT))
 		schedule_delayed_work(&pcr->carddet_work,
 				msecs_to_jiffies(200));
 
@@ -1144,10 +1158,12 @@ void rtsx_pci_enable_ocp(struct rtsx_pcr *pcr)
 {
 	u8 val = SD_OCP_INT_EN | SD_DETECT_EN;
 
-	if (pcr->ops->enable_ocp)
+	if (pcr->ops->enable_ocp) {
 		pcr->ops->enable_ocp(pcr);
-	else
+	} else {
+		rtsx_pci_write_register(pcr, FPDCTL, OC_POWER_DOWN, 0);
 		rtsx_pci_write_register(pcr, REG_OCPCTL, 0xFF, val);
+	}
 
 }
 
@@ -1155,10 +1171,13 @@ void rtsx_pci_disable_ocp(struct rtsx_pcr *pcr)
 {
 	u8 mask = SD_OCP_INT_EN | SD_DETECT_EN;
 
-	if (pcr->ops->disable_ocp)
+	if (pcr->ops->disable_ocp) {
 		pcr->ops->disable_ocp(pcr);
-	else
+	} else {
 		rtsx_pci_write_register(pcr, REG_OCPCTL, mask, 0);
+		rtsx_pci_write_register(pcr, FPDCTL, OC_POWER_DOWN,
+				OC_POWER_DOWN);
+	}
 }
 
 void rtsx_pci_init_ocp(struct rtsx_pcr *pcr)
@@ -1169,7 +1188,7 @@ void rtsx_pci_init_ocp(struct rtsx_pcr *pcr)
 		struct rtsx_cr_option *option = &(pcr->option);
 
 		if (option->ocp_en) {
-			u8 val = option->sd_400mA_ocp_thd;
+			u8 val = option->sd_800mA_ocp_thd;
 
 			rtsx_pci_write_register(pcr, FPDCTL, OC_POWER_DOWN, 0);
 			rtsx_pci_write_register(pcr, REG_OCPPARA1,
@@ -1204,6 +1223,7 @@ void rtsx_pci_clear_ocpstat(struct rtsx_pcr *pcr)
 		u8 val = SD_OCP_INT_CLR | SD_OC_CLR;
 
 		rtsx_pci_write_register(pcr, REG_OCPCTL, mask, val);
+		udelay(100);
 		rtsx_pci_write_register(pcr, REG_OCPCTL, mask, 0);
 	}
 }
@@ -1213,7 +1233,6 @@ int rtsx_sd_power_off_card3v3(struct rtsx_pcr *pcr)
 	rtsx_pci_write_register(pcr, CARD_CLK_EN, SD_CLK_EN |
 		MS_CLK_EN | SD40_CLK_EN, 0);
 	rtsx_pci_write_register(pcr, CARD_OE, SD_OUTPUT_EN, 0);
-
 	rtsx_pci_card_power_off(pcr, RTSX_SD_CARD);
 
 	msleep(50);
@@ -1313,6 +1332,9 @@ static int rtsx_pci_init_hw(struct rtsx_pcr *pcr)
 		break;
 	}
 
+	/*init ocp*/
+	rtsx_pci_init_ocp(pcr);
+
 	/* Enable clk_request_n to enable clock power management */
 	rtsx_pci_write_config_byte(pcr, pcr->pcie_cap + PCI_EXP_LNKCTL + 1, 1);
 	/* Enter L1 when host tx idle */
diff --git a/drivers/misc/cardreader/rtsx_pcr.h b/drivers/misc/cardreader/rtsx_pcr.h
index 6ea1655db0bb..300fc31d8e67 100644
--- a/drivers/misc/cardreader/rtsx_pcr.h
+++ b/drivers/misc/cardreader/rtsx_pcr.h
@@ -46,6 +46,11 @@
 
 #define SSC_CLOCK_STABLE_WAIT	130
 
+#define RTS524A_OCP_THD_800	0x04
+#define RTS525A_OCP_THD_800	0x05
+#define RTS522A_OCP_THD_800	0x06
+
+
 int __rtsx_pci_write_phy_register(struct rtsx_pcr *pcr, u8 addr, u16 val);
 int __rtsx_pci_read_phy_register(struct rtsx_pcr *pcr, u8 addr, u16 *val);
 
-- 
2.17.1

