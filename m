Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF43C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 13:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B82C21529
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 13:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKwXAxTz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B82C21529
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732638AbeITTGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 15:06:12 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37452 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbeITTGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 15:06:11 -0400
Received: by mail-wm1-f68.google.com with SMTP id n11-v6so10972519wmc.2;
        Thu, 20 Sep 2018 06:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/nxNQnjM7jCKGwl9b5dWLKokwq1xjWdI15yP3mCMmPw=;
        b=IKwXAxTz8HDfz4B3dLsmYfOz5nOVXyEEAoytqSyPA5GCVAO99VLk1ZB3z1ItZy3VRd
         D1PayEi/Czb7FKoYXtl7frXH7eVhGjInD2t3HKec3oKaYAUVEMdfhi0/VXjJyCFJc6io
         yIlgOS8BMybWIOmbXls62pp/u9MnSb8sWE5BEtaKqqgllTxsk63kVtyJ3pzWAharsDEW
         EJ5cW5E04iFz6LCbL2dPuS4aBOL08ahNF7GYpVQOjRjr94oN+PnC0lwWAU757yydAqLL
         gLcPkSnn2TX5qJ+pCzL5xC2zrAzMSXcW+XyWiWw2WL+fN+CWnS68A9ZaqrtoYSQZ0x3l
         PROQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/nxNQnjM7jCKGwl9b5dWLKokwq1xjWdI15yP3mCMmPw=;
        b=Ritbjltf/rR+RN72plKzSigqX/igP+VjNcp0Ivsp1NqIP+iStsN3rXtDaMOJshcv3f
         UtxjCGi5hADPhDQZ2xoeGgneaJtXKT4F/a+kIlej/lP9+1l9swh3W4qn2ZtUuXUiNjTS
         MJCPmovWi6G9ODmtwk05SvCmJxhIsNy+4ELFSXJjuz4zPJpHb6tDOGHIMWGpR10to6Km
         GYb2USZtDA5uHLdGXOaADnoIh6uUPcU/pT4Pmnhg8dX/eRuFITxQXzVa3wPad0/NI7P/
         7esq/pYft8CM7Bkfznerpp/TZasvRZsO/YIBYY+h4RWKKkTrc/VnPBbU68bYr/ybpGIZ
         Mwlg==
X-Gm-Message-State: APzg51DxjYgvLt+0PYflTnMrtfmdKunZ84YYuYVbkxObsIMnAPKRMy7v
        GCOpP5kF+ajJKb74eBzw1gNDhejm2c8mwQ==
X-Google-Smtp-Source: ANB0VdaXw4LBD0GRXJItuH6+r4b6zGthVX1G7vhXgqF/fyIoGM0uo18NZldAZm8P6O9wufMFQUAkyQ==
X-Received: by 2002:a1c:6846:: with SMTP id d67-v6mr2634311wmc.125.1537449748613;
        Thu, 20 Sep 2018 06:22:28 -0700 (PDT)
Received: from AQ-THINKPAD.home ([2a00:23c5:c200:5b00:5de9:20bb:eecf:e05c])
        by smtp.gmail.com with ESMTPSA id k7-v6sm1866667wmf.41.2018.09.20.06.22.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 06:22:28 -0700 (PDT)
From:   Aymen Qader <qader.aymen@gmail.com>
To:     Micky Ching <micky_ching@realsil.com.cn>
Cc:     kernel-janitors@vger.kernel.org,
        Aymen Qader <qader.aymen@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rts5208: Remove unnecessary braces {}
Date:   Thu, 20 Sep 2018 14:22:25 +0100
Message-Id: <20180920132226.23054-1-qader.aymen@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl warning "braces {} are not necessary"
in the rts5208 driver. Mostly applies to single-line return/goto if
blocks.

Signed-off-by: Aymen Qader <qader.aymen@gmail.com>
---
 drivers/staging/rts5208/ms.c        | 619 ++++++++++----------------
 drivers/staging/rts5208/rtsx_card.c |  92 ++--
 drivers/staging/rts5208/rtsx_card.h |   3 +-
 drivers/staging/rts5208/rtsx_chip.c | 396 ++++++-----------
 drivers/staging/rts5208/rtsx_scsi.c | 108 ++---
 drivers/staging/rts5208/sd.c        | 649 ++++++++++------------------
 drivers/staging/rts5208/spi.c       | 141 ++----
 drivers/staging/rts5208/xd.c        | 210 +++------
 8 files changed, 759 insertions(+), 1459 deletions(-)

diff --git a/drivers/staging/rts5208/ms.c b/drivers/staging/rts5208/ms.c
index 3a71dbb6d24a..f53adf15c685 100644
--- a/drivers/staging/rts5208/ms.c
+++ b/drivers/staging/rts5208/ms.c
@@ -111,9 +111,8 @@ static int ms_transfer_data(struct rtsx_chip *chip, u8 trans_mode,
 	u8 val, err_code = 0;
 	enum dma_data_direction dir;
 
-	if (!buf || !buf_len) {
+	if (!buf || !buf_len)
 		return STATUS_FAIL;
-	}
 
 	if (trans_mode == MS_TM_AUTO_READ) {
 		dir = DMA_FROM_DEVICE;
@@ -162,12 +161,11 @@ static int ms_transfer_data(struct rtsx_chip *chip, u8 trans_mode,
 	}
 
 	retval = rtsx_read_register(chip, MS_TRANS_CFG, &val);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
-	if (val & (MS_INT_CMDNK | MS_INT_ERR | MS_CRC16_ERR | MS_RDY_TIMEOUT)) {
+
+	if (val & (MS_INT_CMDNK | MS_INT_ERR | MS_CRC16_ERR | MS_RDY_TIMEOUT))
 		return STATUS_FAIL;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -178,9 +176,8 @@ static int ms_write_bytes(struct rtsx_chip *chip,
 	struct ms_info *ms_card = &chip->ms_card;
 	int retval, i;
 
-	if (!data || (data_len < cnt)) {
+	if (!data || (data_len < cnt))
 		return STATUS_ERROR;
-	}
 
 	rtsx_init_cmd(chip);
 
@@ -244,9 +241,8 @@ static int ms_read_bytes(struct rtsx_chip *chip,
 	int retval, i;
 	u8 *ptr;
 
-	if (!data) {
+	if (!data)
 		return STATUS_ERROR;
-	}
 
 	rtsx_init_cmd(chip);
 
@@ -371,14 +367,12 @@ static int ms_set_init_para(struct rtsx_chip *chip)
 	}
 
 	retval = switch_clock(chip, ms_card->ms_clock);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	retval = select_card(chip, MS_CARD);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -389,14 +383,12 @@ static int ms_switch_clock(struct rtsx_chip *chip)
 	int retval;
 
 	retval = select_card(chip, MS_CARD);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	retval = switch_clock(chip, ms_card->ms_clock);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -409,60 +401,59 @@ static int ms_pull_ctl_disable(struct rtsx_chip *chip)
 		retval = rtsx_write_register(chip, CARD_PULL_CTL1, 0xFF,
 					     MS_D1_PD | MS_D2_PD | MS_CLK_PD |
 					     MS_D6_PD);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
+
 		retval = rtsx_write_register(chip, CARD_PULL_CTL2, 0xFF,
 					     MS_D3_PD | MS_D0_PD | MS_BS_PD |
 					     XD_D4_PD);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
+
 		retval = rtsx_write_register(chip, CARD_PULL_CTL3, 0xFF,
 					     MS_D7_PD | XD_CE_PD | XD_CLE_PD |
 					     XD_CD_PU);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
+
 		retval = rtsx_write_register(chip, CARD_PULL_CTL4, 0xFF,
 					     XD_RDY_PD | SD_D3_PD | SD_D2_PD |
 					     XD_ALE_PD);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
+
 		retval = rtsx_write_register(chip, CARD_PULL_CTL5, 0xFF,
 					     MS_INS_PU | SD_WP_PD | SD_CD_PU |
 					     SD_CMD_PD);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
+
 		retval = rtsx_write_register(chip, CARD_PULL_CTL6, 0xFF,
 					     MS_D5_PD | MS_D4_PD);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
+
 	} else if (CHECK_PID(chip, 0x5288)) {
 		if (CHECK_BARO_PKG(chip, QFN)) {
 			retval = rtsx_write_register(chip, CARD_PULL_CTL1,
 						     0xFF, 0x55);
-			if (retval) {
+			if (retval)
 				return retval;
-			}
+
 			retval = rtsx_write_register(chip, CARD_PULL_CTL2,
 						     0xFF, 0x55);
-			if (retval) {
+			if (retval)
 				return retval;
-			}
+
 			retval = rtsx_write_register(chip, CARD_PULL_CTL3,
 						     0xFF, 0x4B);
-			if (retval) {
+			if (retval)
 				return retval;
-			}
+
 			retval = rtsx_write_register(chip, CARD_PULL_CTL4,
 						     0xFF, 0x69);
-			if (retval) {
+			if (retval)
 				return retval;
-			}
 		}
 	}
 
@@ -502,9 +493,8 @@ static int ms_pull_ctl_enable(struct rtsx_chip *chip)
 	}
 
 	retval = rtsx_send_cmd(chip, MS_CARD, 100);
-	if (retval < 0) {
+	if (retval < 0)
 		return STATUS_FAIL;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -523,36 +513,31 @@ static int ms_prepare_reset(struct rtsx_chip *chip)
 	ms_card->pro_under_formatting = 0;
 
 	retval = ms_power_off_card3v3(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	if (!chip->ft2_fast_mode)
 		wait_timeout(250);
 
 	retval = enable_card_clock(chip, MS_CARD);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	if (chip->asic_code) {
 		retval = ms_pull_ctl_enable(chip);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 	} else {
 		retval = rtsx_write_register(chip, FPGA_PULL_CTL,
 					     FPGA_MS_PULL_CTL_BIT | 0x20, 0);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 	}
 
 	if (!chip->ft2_fast_mode) {
 		retval = card_power_on(chip, MS_CARD);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 
 		wait_timeout(150);
 
@@ -572,9 +557,8 @@ static int ms_prepare_reset(struct rtsx_chip *chip)
 
 	retval = rtsx_write_register(chip, CARD_OE, MS_OUTPUT_EN,
 				     MS_OUTPUT_EN);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	if (chip->asic_code) {
 		retval = rtsx_write_register(chip, MS_CFG, 0xFF,
@@ -582,34 +566,31 @@ static int ms_prepare_reset(struct rtsx_chip *chip)
 					     PUSH_TIME_DEFAULT |
 					     NO_EXTEND_TOGGLE |
 					     MS_BUS_WIDTH_1);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
+
 	} else {
 		retval = rtsx_write_register(chip, MS_CFG, 0xFF,
 					     SAMPLE_TIME_FALLING |
 					     PUSH_TIME_DEFAULT |
 					     NO_EXTEND_TOGGLE |
 					     MS_BUS_WIDTH_1);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 	}
 	retval = rtsx_write_register(chip, MS_TRANS_CFG, 0xFF,
 				     NO_WAIT_INT | NO_AUTO_READ_INT_REG);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
+
 	retval = rtsx_write_register(chip, CARD_STOP, MS_STOP | MS_CLR_ERR,
 				     MS_STOP | MS_CLR_ERR);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	retval = ms_set_init_para(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -621,9 +602,8 @@ static int ms_identify_media_type(struct rtsx_chip *chip, int switch_8bit_bus)
 	u8 val;
 
 	retval = ms_set_rw_reg_addr(chip, Pro_StatusReg, 6, SystemParm, 1);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	for (i = 0; i < MS_MAX_RETRY_COUNT; i++) {
 		retval = ms_transfer_tpc(chip, MS_TM_READ_BYTES, READ_REG,
@@ -631,14 +611,13 @@ static int ms_identify_media_type(struct rtsx_chip *chip, int switch_8bit_bus)
 		if (retval == STATUS_SUCCESS)
 			break;
 	}
-	if (i == MS_MAX_RETRY_COUNT) {
+	if (i == MS_MAX_RETRY_COUNT)
 		return STATUS_FAIL;
-	}
 
 	retval = rtsx_read_register(chip, PPBUF_BASE2 + 2, &val);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
+
 	dev_dbg(rtsx_dev(chip), "Type register: 0x%x\n", val);
 	if (val != 0x01) {
 		if (val != 0x02)
@@ -648,9 +627,9 @@ static int ms_identify_media_type(struct rtsx_chip *chip, int switch_8bit_bus)
 	}
 
 	retval = rtsx_read_register(chip, PPBUF_BASE2 + 4, &val);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
+
 	dev_dbg(rtsx_dev(chip), "Category register: 0x%x\n", val);
 	if (val != 0) {
 		ms_card->check_ms_flow = 1;
@@ -658,15 +637,15 @@ static int ms_identify_media_type(struct rtsx_chip *chip, int switch_8bit_bus)
 	}
 
 	retval = rtsx_read_register(chip, PPBUF_BASE2 + 5, &val);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
+
 	dev_dbg(rtsx_dev(chip), "Class register: 0x%x\n", val);
 	if (val == 0) {
 		retval = rtsx_read_register(chip, PPBUF_BASE2, &val);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
+
 		if (val & WRT_PRTCT)
 			chip->card_wp |= MS_CARD;
 		else
@@ -682,9 +661,9 @@ static int ms_identify_media_type(struct rtsx_chip *chip, int switch_8bit_bus)
 	ms_card->ms_type |= TYPE_MSPRO;
 
 	retval = rtsx_read_register(chip, PPBUF_BASE2 + 3, &val);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
+
 	dev_dbg(rtsx_dev(chip), "IF Mode register: 0x%x\n", val);
 	if (val == 0) {
 		ms_card->ms_type &= 0x0F;
@@ -720,13 +699,11 @@ static int ms_confirm_cpu_startup(struct rtsx_chip *chip)
 			if (retval == STATUS_SUCCESS)
 				break;
 		}
-		if (i == MS_MAX_RETRY_COUNT) {
+		if (i == MS_MAX_RETRY_COUNT)
 			return STATUS_FAIL;
-		}
 
-		if (k > 100) {
+		if (k > 100)
 			return STATUS_FAIL;
-		}
 
 		k++;
 		wait_timeout(100);
@@ -737,16 +714,14 @@ static int ms_confirm_cpu_startup(struct rtsx_chip *chip)
 		if (retval == STATUS_SUCCESS)
 			break;
 	}
-	if (i == MS_MAX_RETRY_COUNT) {
+	if (i == MS_MAX_RETRY_COUNT)
 		return STATUS_FAIL;
-	}
 
 	if (val & INT_REG_ERR) {
-		if (val & INT_REG_CMDNK) {
+		if (val & INT_REG_CMDNK)
 			chip->card_wp |= (MS_CARD);
-		} else {
+		else
 			return STATUS_FAIL;
-		}
 	}
 	/* --  end confirm CPU startup */
 
@@ -766,9 +741,8 @@ static int ms_switch_parallel_bus(struct rtsx_chip *chip)
 		if (retval == STATUS_SUCCESS)
 			break;
 	}
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -787,27 +761,24 @@ static int ms_switch_8bit_bus(struct rtsx_chip *chip)
 		if (retval == STATUS_SUCCESS)
 			break;
 	}
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	retval = rtsx_write_register(chip, MS_CFG, 0x98,
 				     MS_BUS_WIDTH_8 | SAMPLE_TIME_FALLING);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
+
 	ms_card->ms_type |= MS_8BIT;
 	retval = ms_set_init_para(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	for (i = 0; i < MS_MAX_RETRY_COUNT; i++) {
 		retval = ms_transfer_tpc(chip, MS_TM_READ_BYTES, GET_INT,
 					 1, NO_WAIT_INT);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 	}
 
 	return STATUS_SUCCESS;
@@ -820,19 +791,16 @@ static int ms_pro_reset_flow(struct rtsx_chip *chip, int switch_8bit_bus)
 
 	for (i = 0; i < 3; i++) {
 		retval = ms_prepare_reset(chip);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 
 		retval = ms_identify_media_type(chip, switch_8bit_bus);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 
 		retval = ms_confirm_cpu_startup(chip);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 
 		retval = ms_switch_parallel_bus(chip);
 		if (retval != STATUS_SUCCESS) {
@@ -846,25 +814,22 @@ static int ms_pro_reset_flow(struct rtsx_chip *chip, int switch_8bit_bus)
 		}
 	}
 
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	/* Switch MS-PRO into Parallel mode */
 	retval = rtsx_write_register(chip, MS_CFG, 0x18, MS_BUS_WIDTH_4);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
+
 	retval = rtsx_write_register(chip, MS_CFG, PUSH_TIME_ODD,
 				     PUSH_TIME_ODD);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	retval = ms_set_init_para(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	/* If MSPro HG Card, We shall try to switch to 8-bit bus */
 	if (CHK_MSHG(ms_card) && chip->support_ms_8bit && switch_8bit_bus) {
@@ -887,9 +852,8 @@ static int msxc_change_power(struct rtsx_chip *chip, u8 mode)
 	ms_cleanup_work(chip);
 
 	retval = ms_set_rw_reg_addr(chip, 0, 0, Pro_DataCount1, 6);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	buf[0] = 0;
 	buf[1] = mode;
@@ -899,22 +863,19 @@ static int msxc_change_power(struct rtsx_chip *chip, u8 mode)
 	buf[5] = 0;
 
 	retval = ms_write_bytes(chip, PRO_WRITE_REG, 6, NO_WAIT_INT, buf, 6);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	retval = ms_send_cmd(chip, XC_CHG_POWER, WAIT_INT);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	retval = rtsx_read_register(chip, MS_TRANS_CFG, buf);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
-	if (buf[0] & (MS_INT_CMDNK | MS_INT_ERR)) {
+
+	if (buf[0] & (MS_INT_CMDNK | MS_INT_ERR))
 		return STATUS_FAIL;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -936,9 +897,8 @@ static int ms_read_attribute_info(struct rtsx_chip *chip)
 #endif
 
 	retval = ms_set_rw_reg_addr(chip, Pro_IntReg, 2, Pro_SystemParm, 7);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	if (CHK_MS8BIT(ms_card))
 		data[0] = PARALLEL_8BIT_IF;
@@ -960,14 +920,12 @@ static int ms_read_attribute_info(struct rtsx_chip *chip)
 		if (retval == STATUS_SUCCESS)
 			break;
 	}
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	buf = kmalloc(64 * 512, GFP_KERNEL);
-	if (!buf) {
+	if (!buf)
 		return STATUS_ERROR;
-	}
 
 	for (i = 0; i < MS_MAX_RETRY_COUNT; i++) {
 		retval = ms_send_cmd(chip, PRO_READ_ATRB, WAIT_INT);
@@ -1150,18 +1108,15 @@ static int ms_read_attribute_info(struct rtsx_chip *chip)
 
 #ifdef SUPPORT_MSXC
 	if (CHK_MSXC(ms_card)) {
-		if (class_code != 0x03) {
+		if (class_code != 0x03)
 			return STATUS_FAIL;
-		}
 	} else {
-		if (class_code != 0x02) {
+		if (class_code != 0x02)
 			return STATUS_FAIL;
-		}
 	}
 #else
-	if (class_code != 0x02) {
+	if (class_code != 0x02)
 		return STATUS_FAIL;
-	}
 #endif
 
 	if (device_type != 0x00) {
@@ -1173,9 +1128,8 @@ static int ms_read_attribute_info(struct rtsx_chip *chip)
 		}
 	}
 
-	if (sub_class & 0xC0) {
+	if (sub_class & 0xC0)
 		return STATUS_FAIL;
-	}
 
 	dev_dbg(rtsx_dev(chip), "class_code: 0x%x, device_type: 0x%x, sub_class: 0x%x\n",
 		class_code, device_type, sub_class);
@@ -1223,18 +1177,16 @@ static int reset_ms_pro(struct rtsx_chip *chip)
 	if (retval != STATUS_SUCCESS) {
 		if (ms_card->switch_8bit_fail) {
 			retval = ms_pro_reset_flow(chip, 0);
-			if (retval != STATUS_SUCCESS) {
+			if (retval != STATUS_SUCCESS)
 				return STATUS_FAIL;
-			}
 		} else {
 			return STATUS_FAIL;
 		}
 	}
 
 	retval = ms_read_attribute_info(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 #ifdef XC_POWERCLASS
 	if (CHK_HG8BIT(ms_card))
@@ -1274,9 +1226,8 @@ static int reset_ms_pro(struct rtsx_chip *chip)
 
 #ifdef SUPPORT_MAGIC_GATE
 	retval = mg_set_tpc_para_sub(chip, 0, 0);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 #endif
 
 	if (CHK_HG8BIT(ms_card))
@@ -1293,14 +1244,12 @@ static int ms_read_status_reg(struct rtsx_chip *chip)
 	u8 val[2];
 
 	retval = ms_set_rw_reg_addr(chip, StatusReg0, 2, 0, 0);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	retval = ms_read_bytes(chip, READ_REG, 2, NO_WAIT_INT, val, 2);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	if (val[1] & (STS_UCDT | STS_UCEX | STS_UCFG)) {
 		ms_set_err_code(chip, MS_FLASH_READ_ERROR);
@@ -1319,9 +1268,8 @@ static int ms_read_extra_data(struct rtsx_chip *chip,
 
 	retval = ms_set_rw_reg_addr(chip, OverwriteFlag, MS_EXTRA_SIZE,
 				    SystemParm, 6);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	if (CHK_MS4BIT(ms_card)) {
 		/* Parallel interface */
@@ -1342,9 +1290,8 @@ static int ms_read_extra_data(struct rtsx_chip *chip,
 		if (retval == STATUS_SUCCESS)
 			break;
 	}
-	if (i == MS_MAX_RETRY_COUNT) {
+	if (i == MS_MAX_RETRY_COUNT)
 		return STATUS_FAIL;
-	}
 
 	ms_set_err_code(chip, MS_NO_ERROR);
 
@@ -1353,15 +1300,13 @@ static int ms_read_extra_data(struct rtsx_chip *chip,
 		if (retval == STATUS_SUCCESS)
 			break;
 	}
-	if (i == MS_MAX_RETRY_COUNT) {
+	if (i == MS_MAX_RETRY_COUNT)
 		return STATUS_FAIL;
-	}
 
 	ms_set_err_code(chip, MS_NO_ERROR);
 	retval = ms_read_bytes(chip, GET_INT, 1, NO_WAIT_INT, &val, 1);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	if (val & INT_REG_CMDNK) {
 		ms_set_err_code(chip, MS_CMD_NK);
@@ -1370,24 +1315,21 @@ static int ms_read_extra_data(struct rtsx_chip *chip,
 	if (val & INT_REG_CED) {
 		if (val & INT_REG_ERR) {
 			retval = ms_read_status_reg(chip);
-			if (retval != STATUS_SUCCESS) {
+			if (retval != STATUS_SUCCESS)
 				return STATUS_FAIL;
-			}
 
 			retval = ms_set_rw_reg_addr(chip, OverwriteFlag,
 						    MS_EXTRA_SIZE, SystemParm,
 						    6);
-			if (retval != STATUS_SUCCESS) {
+			if (retval != STATUS_SUCCESS)
 				return STATUS_FAIL;
-			}
 		}
 	}
 
 	retval = ms_read_bytes(chip, READ_REG, MS_EXTRA_SIZE, NO_WAIT_INT,
 			       data, MS_EXTRA_SIZE);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	if (buf && buf_len) {
 		if (buf_len > MS_EXTRA_SIZE)
@@ -1405,15 +1347,13 @@ static int ms_write_extra_data(struct rtsx_chip *chip, u16 block_addr,
 	int retval, i;
 	u8 val, data[16];
 
-	if (!buf || (buf_len < MS_EXTRA_SIZE)) {
+	if (!buf || (buf_len < MS_EXTRA_SIZE))
 		return STATUS_FAIL;
-	}
 
 	retval = ms_set_rw_reg_addr(chip, OverwriteFlag, MS_EXTRA_SIZE,
 				    SystemParm, 6 + MS_EXTRA_SIZE);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	if (CHK_MS4BIT(ms_card))
 		data[0] = 0x88;
@@ -1431,20 +1371,17 @@ static int ms_write_extra_data(struct rtsx_chip *chip, u16 block_addr,
 
 	retval = ms_write_bytes(chip, WRITE_REG, (6 + MS_EXTRA_SIZE),
 				NO_WAIT_INT, data, 16);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	retval = ms_send_cmd(chip, BLOCK_WRITE, WAIT_INT);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	ms_set_err_code(chip, MS_NO_ERROR);
 	retval = ms_read_bytes(chip, GET_INT, 1, NO_WAIT_INT, &val, 1);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	if (val & INT_REG_CMDNK) {
 		ms_set_err_code(chip, MS_CMD_NK);
@@ -1468,9 +1405,8 @@ static int ms_read_page(struct rtsx_chip *chip, u16 block_addr, u8 page_num)
 
 	retval = ms_set_rw_reg_addr(chip, OverwriteFlag, MS_EXTRA_SIZE,
 				    SystemParm, 6);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	if (CHK_MS4BIT(ms_card))
 		data[0] = 0x88;
@@ -1484,20 +1420,17 @@ static int ms_read_page(struct rtsx_chip *chip, u16 block_addr, u8 page_num)
 	data[5] = page_num;
 
 	retval = ms_write_bytes(chip, WRITE_REG, 6, NO_WAIT_INT, data, 6);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	retval = ms_send_cmd(chip, BLOCK_READ, WAIT_INT);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	ms_set_err_code(chip, MS_NO_ERROR);
 	retval = ms_read_bytes(chip, GET_INT, 1, NO_WAIT_INT, &val, 1);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	if (val & INT_REG_CMDNK) {
 		ms_set_err_code(chip, MS_CMD_NK);
@@ -1524,13 +1457,11 @@ static int ms_read_page(struct rtsx_chip *chip, u16 block_addr, u8 page_num)
 
 	retval = ms_transfer_tpc(chip, MS_TM_NORMAL_READ, READ_PAGE_DATA,
 				 0, NO_WAIT_INT);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
-	if (ms_check_err_code(chip, MS_FLASH_WRITE_ERROR)) {
+	if (ms_check_err_code(chip, MS_FLASH_WRITE_ERROR))
 		return STATUS_FAIL;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -1542,15 +1473,13 @@ static int ms_set_bad_block(struct rtsx_chip *chip, u16 phy_blk)
 	u8 val, data[8], extra[MS_EXTRA_SIZE];
 
 	retval = ms_read_extra_data(chip, phy_blk, 0, extra, MS_EXTRA_SIZE);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	retval = ms_set_rw_reg_addr(chip, OverwriteFlag, MS_EXTRA_SIZE,
 				    SystemParm, 7);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	ms_set_err_code(chip, MS_NO_ERROR);
 
@@ -1568,20 +1497,17 @@ static int ms_set_bad_block(struct rtsx_chip *chip, u16 phy_blk)
 	data[7] = 0xFF;
 
 	retval = ms_write_bytes(chip, WRITE_REG, 7, NO_WAIT_INT, data, 7);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	retval = ms_send_cmd(chip, BLOCK_WRITE, WAIT_INT);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	ms_set_err_code(chip, MS_NO_ERROR);
 	retval = ms_read_bytes(chip, GET_INT, 1, NO_WAIT_INT, &val, 1);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	if (val & INT_REG_CMDNK) {
 		ms_set_err_code(chip, MS_CMD_NK);
@@ -1606,9 +1532,8 @@ static int ms_erase_block(struct rtsx_chip *chip, u16 phy_blk)
 
 	retval = ms_set_rw_reg_addr(chip, OverwriteFlag, MS_EXTRA_SIZE,
 				    SystemParm, 6);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	ms_set_err_code(chip, MS_NO_ERROR);
 
@@ -1624,21 +1549,18 @@ static int ms_erase_block(struct rtsx_chip *chip, u16 phy_blk)
 	data[5] = 0;
 
 	retval = ms_write_bytes(chip, WRITE_REG, 6, NO_WAIT_INT, data, 6);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 ERASE_RTY:
 	retval = ms_send_cmd(chip, BLOCK_ERASE, WAIT_INT);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	ms_set_err_code(chip, MS_NO_ERROR);
 	retval = ms_read_bytes(chip, GET_INT, 1, NO_WAIT_INT, &val, 1);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	if (val & INT_REG_CMDNK) {
 		if (i < 3) {
@@ -1701,9 +1623,8 @@ static int ms_init_page(struct rtsx_chip *chip, u16 phy_blk, u16 log_blk,
 
 		retval = ms_write_extra_data(chip, phy_blk, i,
 					     extra, MS_EXTRA_SIZE);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 	}
 
 	return STATUS_SUCCESS;
@@ -1723,30 +1644,25 @@ static int ms_copy_page(struct rtsx_chip *chip, u16 old_blk, u16 new_blk,
 		start_page, end_page);
 
 	retval = ms_read_extra_data(chip, new_blk, 0, extra, MS_EXTRA_SIZE);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	retval = ms_read_status_reg(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	retval = rtsx_read_register(chip, PPBUF_BASE2, &val);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	if (val & BUF_FULL) {
 		retval = ms_send_cmd(chip, CLEAR_BUF, WAIT_INT);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 
 		retval = ms_read_bytes(chip, GET_INT, 1, NO_WAIT_INT, &val, 1);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 
 		if (!(val & INT_REG_CED)) {
 			ms_set_err_code(chip, MS_FLASH_WRITE_ERROR);
@@ -1764,9 +1680,8 @@ static int ms_copy_page(struct rtsx_chip *chip, u16 old_blk, u16 new_blk,
 
 		retval = ms_set_rw_reg_addr(chip, OverwriteFlag,
 					    MS_EXTRA_SIZE, SystemParm, 6);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 
 		ms_set_err_code(chip, MS_NO_ERROR);
 
@@ -1783,20 +1698,17 @@ static int ms_copy_page(struct rtsx_chip *chip, u16 old_blk, u16 new_blk,
 
 		retval = ms_write_bytes(chip, WRITE_REG, 6, NO_WAIT_INT,
 					data, 6);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 
 		retval = ms_send_cmd(chip, BLOCK_READ, WAIT_INT);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 
 		ms_set_err_code(chip, MS_NO_ERROR);
 		retval = ms_read_bytes(chip, GET_INT, 1, NO_WAIT_INT, &val, 1);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 
 		if (val & INT_REG_CMDNK) {
 			ms_set_err_code(chip, MS_CMD_NK);
@@ -1817,9 +1729,8 @@ static int ms_copy_page(struct rtsx_chip *chip, u16 old_blk, u16 new_blk,
 							 MS_TM_NORMAL_READ,
 							 READ_PAGE_DATA,
 							 0, NO_WAIT_INT);
-				if (retval != STATUS_SUCCESS) {
+				if (retval != STATUS_SUCCESS)
 					return STATUS_FAIL;
-				}
 
 				if (uncorrect_flag) {
 					ms_set_page_status(log_blk, setPS_NG,
@@ -1854,9 +1765,8 @@ static int ms_copy_page(struct rtsx_chip *chip, u16 old_blk, u16 new_blk,
 					if (retval == STATUS_SUCCESS)
 						break;
 				}
-				if (rty_cnt == MS_MAX_RETRY_COUNT) {
+				if (rty_cnt == MS_MAX_RETRY_COUNT)
 					return STATUS_FAIL;
-				}
 			}
 
 			if (!(val & INT_REG_BREQ)) {
@@ -1895,20 +1805,17 @@ static int ms_copy_page(struct rtsx_chip *chip, u16 old_blk, u16 new_blk,
 
 		retval = ms_write_bytes(chip, WRITE_REG, (6 + MS_EXTRA_SIZE),
 					NO_WAIT_INT, data, 16);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 
 		retval = ms_send_cmd(chip, BLOCK_WRITE, WAIT_INT);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 
 		ms_set_err_code(chip, MS_NO_ERROR);
 		retval = ms_read_bytes(chip, GET_INT, 1, NO_WAIT_INT, &val, 1);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 
 		if (val & INT_REG_CMDNK) {
 			ms_set_err_code(chip, MS_CMD_NK);
@@ -1926,9 +1833,8 @@ static int ms_copy_page(struct rtsx_chip *chip, u16 old_blk, u16 new_blk,
 			retval = ms_set_rw_reg_addr(chip, OverwriteFlag,
 						    MS_EXTRA_SIZE, SystemParm,
 						    7);
-			if (retval != STATUS_SUCCESS) {
+			if (retval != STATUS_SUCCESS)
 				return STATUS_FAIL;
-			}
 
 			ms_set_err_code(chip, MS_NO_ERROR);
 
@@ -1947,21 +1853,18 @@ static int ms_copy_page(struct rtsx_chip *chip, u16 old_blk, u16 new_blk,
 
 			retval = ms_write_bytes(chip, WRITE_REG, 7,
 						NO_WAIT_INT, data, 8);
-			if (retval != STATUS_SUCCESS) {
+			if (retval != STATUS_SUCCESS)
 				return STATUS_FAIL;
-			}
 
 			retval = ms_send_cmd(chip, BLOCK_WRITE, WAIT_INT);
-			if (retval != STATUS_SUCCESS) {
+			if (retval != STATUS_SUCCESS)
 				return STATUS_FAIL;
-			}
 
 			ms_set_err_code(chip, MS_NO_ERROR);
 			retval = ms_read_bytes(chip, GET_INT, 1,
 					       NO_WAIT_INT, &val, 1);
-			if (retval != STATUS_SUCCESS) {
+			if (retval != STATUS_SUCCESS)
 				return STATUS_FAIL;
-			}
 
 			if (val & INT_REG_CMDNK) {
 				ms_set_err_code(chip, MS_CMD_NK);
@@ -1992,26 +1895,23 @@ static int reset_ms(struct rtsx_chip *chip)
 #endif
 
 	retval = ms_prepare_reset(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	ms_card->ms_type |= TYPE_MS;
 
 	retval = ms_send_cmd(chip, MS_RESET, NO_WAIT_INT);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	retval = ms_read_status_reg(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	retval = rtsx_read_register(chip, PPBUF_BASE2, &val);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
+
 	if (val & WRT_PRTCT)
 		chip->card_wp |= MS_CARD;
 	else
@@ -2059,9 +1959,8 @@ static int reset_ms(struct rtsx_chip *chip)
 	}
 
 	retval = ms_read_page(chip, ms_card->boot_block, 0);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	/* Read MS system information as sys_info */
 	rtsx_init_cmd(chip);
@@ -2070,9 +1969,8 @@ static int reset_ms(struct rtsx_chip *chip)
 		rtsx_add_cmd(chip, READ_REG_CMD, PPBUF_BASE2 + 0x1A0 + i, 0, 0);
 
 	retval = rtsx_send_cmd(chip, MS_CARD, 100);
-	if (retval < 0) {
+	if (retval < 0)
 		return STATUS_FAIL;
-	}
 
 	ptr = rtsx_get_cmd_data(chip);
 	memcpy(ms_card->raw_sys_info, ptr, 96);
@@ -2094,9 +1992,8 @@ static int reset_ms(struct rtsx_chip *chip)
 	rtsx_add_cmd(chip, READ_REG_CMD, MS_4bit_Support, 0, 0);
 
 	retval = rtsx_send_cmd(chip, MS_CARD, 100);
-	if (retval < 0) {
+	if (retval < 0)
 		return STATUS_FAIL;
-	}
 
 	ptr = rtsx_get_cmd_data(chip);
 
@@ -2169,33 +2066,29 @@ static int reset_ms(struct rtsx_chip *chip)
 	/* Switch I/F Mode */
 	if (ptr[15]) {
 		retval = ms_set_rw_reg_addr(chip, 0, 0, SystemParm, 1);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 
 		retval = rtsx_write_register(chip, PPBUF_BASE2, 0xFF, 0x88);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
+
 		retval = rtsx_write_register(chip, PPBUF_BASE2 + 1, 0xFF, 0);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 
 		retval = ms_transfer_tpc(chip, MS_TM_WRITE_BYTES, WRITE_REG, 1,
 					 NO_WAIT_INT);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 
 		retval = rtsx_write_register(chip, MS_CFG,
 					     0x58 | MS_NO_CHECK_INT,
 					     MS_BUS_WIDTH_4 |
 					     PUSH_TIME_ODD |
 					     MS_NO_CHECK_INT);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 
 		ms_card->ms_type |= MS_4BIT;
 	}
@@ -2221,28 +2114,24 @@ static int ms_init_l2p_tbl(struct rtsx_chip *chip)
 
 	size = ms_card->segment_cnt * sizeof(struct zone_entry);
 	ms_card->segment = vzalloc(size);
-	if (!ms_card->segment) {
+	if (!ms_card->segment)
 		return STATUS_FAIL;
-	}
 
 	retval = ms_read_page(chip, ms_card->boot_block, 1);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		goto INIT_FAIL;
-	}
 
 	reg_addr = PPBUF_BASE2;
 	for (i = 0; i < (((ms_card->total_block >> 9) * 10) + 1); i++) {
 		int block_no;
 
 		retval = rtsx_read_register(chip, reg_addr++, &val1);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			goto INIT_FAIL;
-		}
 
 		retval = rtsx_read_register(chip, reg_addr++, &val2);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			goto INIT_FAIL;
-		}
 
 		defect_block = ((u16)val1 << 8) | val2;
 		if (defect_block == 0xFFFF)
@@ -2403,9 +2292,8 @@ static int ms_build_l2p_tbl(struct rtsx_chip *chip, int seg_no)
 
 	if (!ms_card->segment) {
 		retval = ms_init_l2p_tbl(chip);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return retval;
-		}
 	}
 
 	if (ms_card->segment[seg_no].build_flag) {
@@ -2423,17 +2311,15 @@ static int ms_build_l2p_tbl(struct rtsx_chip *chip, int seg_no)
 
 	if (!segment->l2p_table) {
 		segment->l2p_table = vmalloc(array_size(table_size, 2));
-		if (!segment->l2p_table) {
+		if (!segment->l2p_table)
 			goto BUILD_FAIL;
-		}
 	}
 	memset((u8 *)(segment->l2p_table), 0xff, table_size * 2);
 
 	if (!segment->free_table) {
 		segment->free_table = vmalloc(MS_FREE_TABLE_CNT * 2);
-		if (!segment->free_table) {
+		if (!segment->free_table)
 			goto BUILD_FAIL;
-		}
 	}
 	memset((u8 *)(segment->free_table), 0xff, MS_FREE_TABLE_CNT * 2);
 
@@ -2558,9 +2444,8 @@ static int ms_build_l2p_tbl(struct rtsx_chip *chip, int seg_no)
 				return STATUS_SUCCESS;
 			}
 			retval = ms_init_page(chip, phy_blk, log_blk, 0, 1);
-			if (retval != STATUS_SUCCESS) {
+			if (retval != STATUS_SUCCESS)
 				goto BUILD_FAIL;
-			}
 
 			segment->l2p_table[idx] = phy_blk;
 			if (seg_no == ms_card->segment_cnt - 1) {
@@ -2591,16 +2476,14 @@ static int ms_build_l2p_tbl(struct rtsx_chip *chip, int seg_no)
 				retval = ms_copy_page(chip, tmp_blk, phy_blk,
 						      log_blk, 0,
 						      ms_card->page_off + 1);
-				if (retval != STATUS_SUCCESS) {
+				if (retval != STATUS_SUCCESS)
 					return STATUS_FAIL;
-				}
 
 				segment->l2p_table[log_blk] = phy_blk;
 
 				retval = ms_set_bad_block(chip, tmp_blk);
-				if (retval != STATUS_SUCCESS) {
+				if (retval != STATUS_SUCCESS)
 					return STATUS_FAIL;
-				}
 			}
 		}
 	}
@@ -2626,14 +2509,12 @@ int reset_ms_card(struct rtsx_chip *chip)
 	memset(ms_card, 0, sizeof(struct ms_info));
 
 	retval = enable_card_clock(chip, MS_CARD);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	retval = select_card(chip, MS_CARD);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	ms_card->ms_type = 0;
 
@@ -2641,27 +2522,24 @@ int reset_ms_card(struct rtsx_chip *chip)
 	if (retval != STATUS_SUCCESS) {
 		if (ms_card->check_ms_flow) {
 			retval = reset_ms(chip);
-			if (retval != STATUS_SUCCESS) {
+			if (retval != STATUS_SUCCESS)
 				return STATUS_FAIL;
-			}
 		} else {
 			return STATUS_FAIL;
 		}
 	}
 
 	retval = ms_set_init_para(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	if (!CHK_MSPRO(ms_card)) {
 		/* Build table for the last segment,
 		 * to check if L2P table block exists, erasing it
 		 */
 		retval = ms_build_l2p_tbl(chip, seg_no);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 	}
 
 	dev_dbg(rtsx_dev(chip), "ms_card->ms_type = 0x%x\n", ms_card->ms_type);
@@ -2690,9 +2568,8 @@ static int mspro_set_rw_cmd(struct rtsx_chip *chip,
 		if (retval == STATUS_SUCCESS)
 			break;
 	}
-	if (i == MS_MAX_RETRY_COUNT) {
+	if (i == MS_MAX_RETRY_COUNT)
 		return STATUS_FAIL;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -2731,9 +2608,8 @@ static inline int ms_auto_tune_clock(struct rtsx_chip *chip)
 	}
 
 	retval = ms_switch_clock(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -2782,9 +2658,8 @@ static int mspro_rw_multi_sector(struct scsi_cmnd *srb,
 	}
 
 	retval = ms_switch_clock(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	if (srb->sc_data_direction == DMA_FROM_DEVICE)
 		trans_mode = MS_TM_AUTO_READ;
@@ -2792,9 +2667,8 @@ static int mspro_rw_multi_sector(struct scsi_cmnd *srb,
 		trans_mode = MS_TM_AUTO_WRITE;
 
 	retval = rtsx_read_register(chip, MS_TRANS_CFG, &val);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	if (ms_card->seq_mode) {
 		if ((ms_card->pre_dir != srb->sc_data_direction) ||
@@ -2808,9 +2682,8 @@ static int mspro_rw_multi_sector(struct scsi_cmnd *srb,
 			ms_card->total_sec_cnt = 0;
 			if (val & MS_INT_BREQ) {
 				retval = ms_send_cmd(chip, PRO_STOP, WAIT_INT);
-				if (retval != STATUS_SUCCESS) {
+				if (retval != STATUS_SUCCESS)
 					return STATUS_FAIL;
-				}
 
 				rtsx_write_register(chip, RBCTL, RB_FLUSH,
 						    RB_FLUSH);
@@ -3019,14 +2892,12 @@ int mspro_format(struct scsi_cmnd *srb, struct rtsx_chip *chip,
 	u16 para;
 
 	retval = ms_switch_clock(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	retval = ms_set_rw_reg_addr(chip, 0x00, 0x00, Pro_TPCParm, 0x01);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	memset(buf, 0, 2);
 	switch (short_data_len) {
@@ -3051,9 +2922,8 @@ int mspro_format(struct scsi_cmnd *srb, struct rtsx_chip *chip,
 		if (retval == STATUS_SUCCESS)
 			break;
 	}
-	if (i == MS_MAX_RETRY_COUNT) {
+	if (i == MS_MAX_RETRY_COUNT)
 		return STATUS_FAIL;
-	}
 
 	if (quick_format)
 		para = 0x0000;
@@ -3061,18 +2931,15 @@ int mspro_format(struct scsi_cmnd *srb, struct rtsx_chip *chip,
 		para = 0x0001;
 
 	retval = mspro_set_rw_cmd(chip, 0, para, PRO_FORMAT);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	retval = rtsx_read_register(chip, MS_TRANS_CFG, &tmp);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
-	if (tmp & (MS_INT_CMDNK | MS_INT_ERR)) {
+	if (tmp & (MS_INT_CMDNK | MS_INT_ERR))
 		return STATUS_FAIL;
-	}
 
 	if ((tmp & (MS_INT_BREQ | MS_INT_CED)) == MS_INT_BREQ) {
 		ms_card->pro_under_formatting = 1;
@@ -3113,9 +2980,8 @@ static int ms_read_multiple_pages(struct rtsx_chip *chip, u16 phy_blk,
 
 	retval = ms_set_rw_reg_addr(chip, OverwriteFlag, MS_EXTRA_SIZE,
 				    SystemParm, 6);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	if (CHK_MS4BIT(ms_card))
 		data[0] = 0x88;
@@ -3134,16 +3000,14 @@ static int ms_read_multiple_pages(struct rtsx_chip *chip, u16 phy_blk,
 		if (retval == STATUS_SUCCESS)
 			break;
 	}
-	if (i == MS_MAX_RETRY_COUNT) {
+	if (i == MS_MAX_RETRY_COUNT)
 		return STATUS_FAIL;
-	}
 
 	ms_set_err_code(chip, MS_NO_ERROR);
 
 	retval = ms_send_cmd(chip, BLOCK_READ, WAIT_INT);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	ptr = buf;
 
@@ -3156,9 +3020,8 @@ static int ms_read_multiple_pages(struct rtsx_chip *chip, u16 phy_blk,
 		}
 
 		retval = ms_read_bytes(chip, GET_INT, 1, NO_WAIT_INT, &val, 1);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 
 		if (val & INT_REG_CMDNK) {
 			ms_set_err_code(chip, MS_CMD_NK);
@@ -3197,16 +3060,14 @@ static int ms_read_multiple_pages(struct rtsx_chip *chip, u16 phy_blk,
 		if (page_addr == (end_page - 1)) {
 			if (!(val & INT_REG_CED)) {
 				retval = ms_send_cmd(chip, BLOCK_END, WAIT_INT);
-				if (retval != STATUS_SUCCESS) {
+				if (retval != STATUS_SUCCESS)
 					return STATUS_FAIL;
-				}
 			}
 
 			retval = ms_read_bytes(chip, GET_INT, 1, NO_WAIT_INT,
 					       &val, 1);
-			if (retval != STATUS_SUCCESS) {
+			if (retval != STATUS_SUCCESS)
 				return STATUS_FAIL;
-			}
 
 			if (!(val & INT_REG_CED)) {
 				ms_set_err_code(chip, MS_FLASH_READ_ERROR);
@@ -3280,9 +3141,8 @@ static int ms_write_multiple_pages(struct rtsx_chip *chip, u16 old_blk,
 	if (!start_page) {
 		retval = ms_set_rw_reg_addr(chip, OverwriteFlag, MS_EXTRA_SIZE,
 					    SystemParm, 7);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 
 		if (CHK_MS4BIT(ms_card))
 			data[0] = 0x88;
@@ -3299,28 +3159,24 @@ static int ms_write_multiple_pages(struct rtsx_chip *chip, u16 old_blk,
 
 		retval = ms_write_bytes(chip, WRITE_REG, 7, NO_WAIT_INT,
 					data, 8);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 
 		retval = ms_send_cmd(chip, BLOCK_WRITE, WAIT_INT);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 
 		ms_set_err_code(chip, MS_NO_ERROR);
 		retval = ms_transfer_tpc(chip, MS_TM_READ_BYTES, GET_INT, 1,
 					 NO_WAIT_INT);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 	}
 
 	retval = ms_set_rw_reg_addr(chip, OverwriteFlag, MS_EXTRA_SIZE,
 				    SystemParm, (6 + MS_EXTRA_SIZE));
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	ms_set_err_code(chip, MS_NO_ERROR);
 
@@ -3352,23 +3208,20 @@ static int ms_write_multiple_pages(struct rtsx_chip *chip, u16 old_blk,
 		if (retval == STATUS_SUCCESS)
 			break;
 	}
-	if (i == MS_MAX_RETRY_COUNT) {
+	if (i == MS_MAX_RETRY_COUNT)
 		return STATUS_FAIL;
-	}
 
 	for (i = 0; i < MS_MAX_RETRY_COUNT; i++) {
 		retval = ms_send_cmd(chip, BLOCK_WRITE, WAIT_INT);
 		if (retval == STATUS_SUCCESS)
 			break;
 	}
-	if (i == MS_MAX_RETRY_COUNT) {
+	if (i == MS_MAX_RETRY_COUNT)
 		return STATUS_FAIL;
-	}
 
 	retval = ms_read_bytes(chip, GET_INT, 1, NO_WAIT_INT, &val, 1);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	ptr = buf;
 	for (page_addr = start_page; page_addr < end_page; page_addr++) {
@@ -3421,16 +3274,14 @@ static int ms_write_multiple_pages(struct rtsx_chip *chip, u16 old_blk,
 			ms_set_err_code(chip, MS_TO_ERROR);
 			rtsx_clear_ms_error(chip);
 
-			if (retval == -ETIMEDOUT) {
+			if (retval == -ETIMEDOUT)
 				return STATUS_TIMEDOUT;
-			}
 			return STATUS_FAIL;
 		}
 
 		retval = ms_read_bytes(chip, GET_INT, 1, NO_WAIT_INT, &val, 1);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 
 		if ((end_page - start_page) == 1) {
 			if (!(val & INT_REG_CED)) {
@@ -3442,16 +3293,14 @@ static int ms_write_multiple_pages(struct rtsx_chip *chip, u16 old_blk,
 				if (!(val & INT_REG_CED)) {
 					retval = ms_send_cmd(chip, BLOCK_END,
 							     WAIT_INT);
-					if (retval != STATUS_SUCCESS) {
+					if (retval != STATUS_SUCCESS)
 						return STATUS_FAIL;
-					}
 				}
 
 				retval = ms_read_bytes(chip, GET_INT, 1,
 						       NO_WAIT_INT, &val, 1);
-				if (retval != STATUS_SUCCESS) {
+				if (retval != STATUS_SUCCESS)
 					return STATUS_FAIL;
-				}
 			}
 
 			if ((page_addr == (end_page - 1)) ||
@@ -3479,9 +3328,8 @@ static int ms_finish_write(struct rtsx_chip *chip, u16 old_blk, u16 new_blk,
 
 	retval = ms_copy_page(chip, old_blk, new_blk, log_blk,
 			      page_off, ms_card->page_off + 1);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	seg_no = old_blk >> 9;
 
@@ -3507,9 +3355,8 @@ static int ms_prepare_write(struct rtsx_chip *chip, u16 old_blk, u16 new_blk,
 	if (start_page) {
 		retval = ms_copy_page(chip, old_blk, new_blk, log_blk,
 				      0, start_page);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 	}
 
 	return STATUS_SUCCESS;
@@ -3524,9 +3371,8 @@ int ms_delay_write(struct rtsx_chip *chip)
 
 	if (delay_write->delay_write_flag) {
 		retval = ms_set_init_para(chip);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 
 		delay_write->delay_write_flag = 0;
 		retval = ms_finish_write(chip,
@@ -3534,9 +3380,8 @@ int ms_delay_write(struct rtsx_chip *chip)
 					delay_write->new_phyblock,
 					delay_write->logblock,
 					delay_write->pageoff);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 	}
 
 	return STATUS_SUCCESS;
@@ -3850,14 +3695,12 @@ static int ms_poll_int(struct rtsx_chip *chip)
 	rtsx_add_cmd(chip, CHECK_REG_CMD, MS_TRANS_CFG, MS_INT_CED, MS_INT_CED);
 
 	retval = rtsx_send_cmd(chip, MS_CARD, 5000);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	val = *rtsx_get_cmd_data(chip);
-	if (val & MS_INT_ERR) {
+	if (val & MS_INT_ERR)
 		return STATUS_FAIL;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -3920,9 +3763,8 @@ static int mg_send_ex_cmd(struct rtsx_chip *chip, u8 cmd, u8 entry_num)
 		if (retval == STATUS_SUCCESS)
 			break;
 	}
-	if (i == MS_MAX_RETRY_COUNT) {
+	if (i == MS_MAX_RETRY_COUNT)
 		return STATUS_FAIL;
-	}
 
 	if (check_ms_err(chip)) {
 		rtsx_clear_ms_error(chip);
@@ -3943,9 +3785,8 @@ static int mg_set_tpc_para_sub(struct rtsx_chip *chip, int type,
 	else
 		retval = ms_set_rw_reg_addr(chip, 0, 0, Pro_DataCount1, 6);
 
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	buf[0] = 0;
 	buf[1] = 0;
@@ -3957,9 +3798,8 @@ static int mg_set_tpc_para_sub(struct rtsx_chip *chip, int type,
 	}
 	retval = ms_write_bytes(chip, PRO_WRITE_REG, (type == 0) ? 1 : 6,
 				NO_WAIT_INT, buf, 6);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -3979,9 +3819,8 @@ int mg_set_leaf_id(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	ms_cleanup_work(chip);
 
 	retval = ms_switch_clock(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	retval = mg_send_ex_cmd(chip, MG_SET_LID, 0);
 	if (retval != STATUS_SUCCESS) {
@@ -4019,14 +3858,12 @@ int mg_get_local_EKB(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	ms_cleanup_work(chip);
 
 	retval = ms_switch_clock(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	buf = kmalloc(1540, GFP_KERNEL);
-	if (!buf) {
+	if (!buf)
 		return STATUS_ERROR;
-	}
 
 	buf[0] = 0x04;
 	buf[1] = 0x1A;
@@ -4073,9 +3910,8 @@ int mg_chg(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	ms_cleanup_work(chip);
 
 	retval = ms_switch_clock(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	retval = mg_send_ex_cmd(chip, MG_GET_ID, 0);
 	if (retval != STATUS_SUCCESS) {
@@ -4148,9 +3984,8 @@ int mg_get_rsp_chg(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	ms_cleanup_work(chip);
 
 	retval = ms_switch_clock(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	retval = mg_send_ex_cmd(chip, MG_MAKE_RMS, 0);
 	if (retval != STATUS_SUCCESS) {
@@ -4204,9 +4039,8 @@ int mg_rsp(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	ms_cleanup_work(chip);
 
 	retval = ms_switch_clock(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	retval = mg_send_ex_cmd(chip, MG_MAKE_KSE, 0);
 	if (retval != STATUS_SUCCESS) {
@@ -4251,14 +4085,12 @@ int mg_get_ICV(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	ms_cleanup_work(chip);
 
 	retval = ms_switch_clock(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	buf = kmalloc(1028, GFP_KERNEL);
-	if (!buf) {
+	if (!buf)
 		return STATUS_ERROR;
-	}
 
 	buf[0] = 0x04;
 	buf[1] = 0x02;
@@ -4307,14 +4139,12 @@ int mg_set_ICV(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	ms_cleanup_work(chip);
 
 	retval = ms_switch_clock(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	buf = kmalloc(1028, GFP_KERNEL);
-	if (!buf) {
+	if (!buf)
 		return STATUS_ERROR;
-	}
 
 	bufflen = min_t(int, 1028, scsi_bufflen(srb));
 	rtsx_stor_get_xfer_buf(buf, bufflen, srb);
@@ -4433,32 +4263,28 @@ int ms_power_off_card3v3(struct rtsx_chip *chip)
 	int retval;
 
 	retval = disable_card_clock(chip, MS_CARD);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	if (chip->asic_code) {
 		retval = ms_pull_ctl_disable(chip);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 	} else {
 		retval = rtsx_write_register(chip, FPGA_PULL_CTL,
 					     FPGA_MS_PULL_CTL_BIT | 0x20,
 					     FPGA_MS_PULL_CTL_BIT);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 	}
 	retval = rtsx_write_register(chip, CARD_OE, MS_OUTPUT_EN, 0);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
+
 	if (!chip->ft2_fast_mode) {
 		retval = card_power_off(chip, MS_CARD);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 	}
 
 	return STATUS_SUCCESS;
@@ -4486,9 +4312,8 @@ int release_ms_card(struct rtsx_chip *chip)
 #endif
 
 	retval = ms_power_off_card3v3(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	return STATUS_SUCCESS;
 }
diff --git a/drivers/staging/rts5208/rtsx_card.c b/drivers/staging/rts5208/rtsx_card.c
index d26a8e372fce..6dc541e06fb9 100644
--- a/drivers/staging/rts5208/rtsx_card.c
+++ b/drivers/staging/rts5208/rtsx_card.c
@@ -647,9 +647,8 @@ int switch_ssc_clock(struct rtsx_chip *chip, int clk)
 	dev_dbg(rtsx_dev(chip), "Switch SSC clock to %dMHz (cur_clk = %d)\n",
 		clk, chip->cur_clk);
 
-	if ((clk <= 2) || (n > max_n)) {
+	if ((clk <= 2) || (n > max_n))
 		return STATUS_FAIL;
-	}
 
 	mcu_cnt = (u8)(125 / clk + 3);
 	if (mcu_cnt > 7)
@@ -688,15 +687,13 @@ int switch_ssc_clock(struct rtsx_chip *chip, int clk)
 	}
 
 	retval = rtsx_send_cmd(chip, 0, WAIT_TIME);
-	if (retval < 0) {
+	if (retval < 0)
 		return STATUS_ERROR;
-	}
 
 	udelay(10);
 	retval = rtsx_write_register(chip, CLK_CTL, CLK_LOW_FREQ, 0);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	chip->cur_clk = clk;
 
@@ -790,49 +787,41 @@ int switch_normal_clock(struct rtsx_chip *chip, int clk)
 	}
 
 	retval = rtsx_write_register(chip, CLK_CTL, 0xFF, CLK_LOW_FREQ);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 	if (sd_vpclk_phase_reset) {
 		retval = rtsx_write_register(chip, SD_VPCLK0_CTL,
 					     PHASE_NOT_RESET, 0);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 		retval = rtsx_write_register(chip, SD_VPCLK1_CTL,
 					     PHASE_NOT_RESET, 0);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 	}
 	retval = rtsx_write_register(chip, CLK_DIV, 0xFF,
 				     (div << 4) | mcu_cnt);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 	retval = rtsx_write_register(chip, CLK_SEL, 0xFF, sel);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	if (sd_vpclk_phase_reset) {
 		udelay(200);
 		retval = rtsx_write_register(chip, SD_VPCLK0_CTL,
 					     PHASE_NOT_RESET, PHASE_NOT_RESET);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 		retval = rtsx_write_register(chip, SD_VPCLK1_CTL,
 					     PHASE_NOT_RESET, PHASE_NOT_RESET);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 		udelay(200);
 	}
 	retval = rtsx_write_register(chip, CLK_CTL, 0xFF, 0);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	chip->cur_clk = clk;
 
@@ -878,9 +867,8 @@ int enable_card_clock(struct rtsx_chip *chip, u8 card)
 		clk_en |= MS_CLK_EN;
 
 	retval = rtsx_write_register(chip, CARD_CLK_EN, clk_en, clk_en);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -898,9 +886,8 @@ int disable_card_clock(struct rtsx_chip *chip, u8 card)
 		clk_en |= MS_CLK_EN;
 
 	retval = rtsx_write_register(chip, CARD_CLK_EN, clk_en, 0);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -924,9 +911,8 @@ int card_power_on(struct rtsx_chip *chip, u8 card)
 	rtsx_add_cmd(chip, WRITE_REG_CMD, CARD_PWR_CTL, mask, val1);
 
 	retval = rtsx_send_cmd(chip, 0, 100);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	udelay(chip->pmos_pwr_on_interval);
 
@@ -934,9 +920,8 @@ int card_power_on(struct rtsx_chip *chip, u8 card)
 	rtsx_add_cmd(chip, WRITE_REG_CMD, CARD_PWR_CTL, mask, val2);
 
 	retval = rtsx_send_cmd(chip, 0, 100);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -955,9 +940,8 @@ int card_power_off(struct rtsx_chip *chip, u8 card)
 	}
 
 	retval = rtsx_write_register(chip, CARD_PWR_CTL, mask, val);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -969,9 +953,8 @@ int card_rw(struct scsi_cmnd *srb, struct rtsx_chip *chip,
 	unsigned int lun = SCSI_LUN(srb);
 	int i;
 
-	if (!chip->rw_card[lun]) {
+	if (!chip->rw_card[lun])
 		return STATUS_FAIL;
-	}
 
 	for (i = 0; i < 3; i++) {
 		chip->rw_need_retry = 0;
@@ -1009,36 +992,33 @@ int card_share_mode(struct rtsx_chip *chip, int card)
 
 	if (CHECK_PID(chip, 0x5208)) {
 		mask = CARD_SHARE_MASK;
-		if (card == SD_CARD) {
+		if (card == SD_CARD)
 			value = CARD_SHARE_48_SD;
-		} else if (card == MS_CARD) {
+		else if (card == MS_CARD)
 			value = CARD_SHARE_48_MS;
-		} else if (card == XD_CARD) {
+		else if (card == XD_CARD)
 			value = CARD_SHARE_48_XD;
-		} else {
+		else
 			return STATUS_FAIL;
-		}
 
 	} else if (CHECK_PID(chip, 0x5288)) {
 		mask = 0x03;
-		if (card == SD_CARD) {
+		if (card == SD_CARD)
 			value = CARD_SHARE_BAROSSA_SD;
-		} else if (card == MS_CARD) {
+		else if (card == MS_CARD)
 			value = CARD_SHARE_BAROSSA_MS;
-		} else if (card == XD_CARD) {
+		else if (card == XD_CARD)
 			value = CARD_SHARE_BAROSSA_XD;
-		} else {
+		else
 			return STATUS_FAIL;
-		}
 
 	} else {
 		return STATUS_FAIL;
 	}
 
 	retval = rtsx_write_register(chip, CARD_SHARE_MODE, mask, value);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -1050,28 +1030,25 @@ int select_card(struct rtsx_chip *chip, int card)
 	if (chip->cur_card != card) {
 		u8 mod;
 
-		if (card == SD_CARD) {
+		if (card == SD_CARD)
 			mod = SD_MOD_SEL;
-		} else if (card == MS_CARD) {
+		else if (card == MS_CARD)
 			mod = MS_MOD_SEL;
-		} else if (card == XD_CARD) {
+		else if (card == XD_CARD)
 			mod = XD_MOD_SEL;
-		} else if (card == SPI_CARD) {
+		else if (card == SPI_CARD)
 			mod = SPI_MOD_SEL;
-		} else {
+		else
 			return STATUS_FAIL;
-		}
 
 		retval = rtsx_write_register(chip, CARD_SELECT, 0x07, mod);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 		chip->cur_card = card;
 
 		retval =  card_share_mode(chip, card);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 	}
 
 	return STATUS_SUCCESS;
@@ -1120,9 +1097,8 @@ int detect_card_cd(struct rtsx_chip *chip, int card)
 	}
 
 	status = rtsx_readl(chip, RTSX_BIPR);
-	if (!(status & card_cd)) {
+	if (!(status & card_cd))
 		return STATUS_FAIL;
-	}
 
 	return STATUS_SUCCESS;
 }
diff --git a/drivers/staging/rts5208/rtsx_card.h b/drivers/staging/rts5208/rtsx_card.h
index ac165d8a081c..820b1113ea89 100644
--- a/drivers/staging/rts5208/rtsx_card.h
+++ b/drivers/staging/rts5208/rtsx_card.h
@@ -1062,9 +1062,8 @@ static inline int card_power_off_all(struct rtsx_chip *chip)
 	int retval;
 
 	retval = rtsx_write_register(chip, CARD_PWR_CTL, 0x0F, 0x0F);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	return STATUS_SUCCESS;
 }
diff --git a/drivers/staging/rts5208/rtsx_chip.c b/drivers/staging/rts5208/rtsx_chip.c
index 6b1234bff09c..94fb35429bf1 100644
--- a/drivers/staging/rts5208/rtsx_chip.c
+++ b/drivers/staging/rts5208/rtsx_chip.c
@@ -116,34 +116,29 @@ static int rtsx_pre_handle_sdio_old(struct rtsx_chip *chip)
 						     0xFF,
 						     MS_INS_PU | SD_WP_PU |
 						     SD_CD_PU | SD_CMD_PU);
-			if (retval) {
+			if (retval)
 				return retval;
-			}
 		} else {
 			retval = rtsx_write_register(chip, FPGA_PULL_CTL,
 						     0xFF,
 						     FPGA_SD_PULL_CTL_EN);
-			if (retval) {
+			if (retval)
 				return retval;
-			}
 		}
 		retval = rtsx_write_register(chip, CARD_SHARE_MODE, 0xFF,
 					     CARD_SHARE_48_SD);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 
 		/* Enable SDIO internal clock */
 		retval = rtsx_write_register(chip, 0xFF2C, 0x01, 0x01);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 
 		retval = rtsx_write_register(chip, SDIO_CTRL, 0xFF,
 					     SDIO_BUS_CTRL | SDIO_CD_CTRL);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 
 		chip->sd_int = 1;
 		chip->sd_io = 1;
@@ -164,16 +159,14 @@ static int rtsx_pre_handle_sdio_new(struct rtsx_chip *chip)
 	if (chip->driver_first_load) {
 		if (CHECK_PID(chip, 0x5288)) {
 			retval = rtsx_read_register(chip, 0xFE5A, &tmp);
-			if (retval) {
+			if (retval)
 				return retval;
-			}
 			if (tmp & 0x08)
 				sw_bypass_sd = true;
 		} else if (CHECK_PID(chip, 0x5208)) {
 			retval = rtsx_read_register(chip, 0xFE70, &tmp);
-			if (retval) {
+			if (retval)
 				return retval;
-			}
 			if (tmp & 0x80)
 				sw_bypass_sd = true;
 		}
@@ -192,9 +185,8 @@ static int rtsx_pre_handle_sdio_new(struct rtsx_chip *chip)
 		u8 cd_toggle_mask = 0;
 
 		retval = rtsx_read_register(chip, TLPTISTAT, &tmp);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 		cd_toggle_mask = 0x08;
 
 		if (tmp & cd_toggle_mask) {
@@ -202,22 +194,19 @@ static int rtsx_pre_handle_sdio_new(struct rtsx_chip *chip)
 			if (CHECK_PID(chip, 0x5288)) {
 				retval = rtsx_write_register(chip, 0xFE5A,
 							     0x08, 0x00);
-				if (retval) {
+				if (retval)
 					return retval;
-				}
 			} else if (CHECK_PID(chip, 0x5208)) {
 				retval = rtsx_write_register(chip, 0xFE70,
 							     0x80, 0x00);
-				if (retval) {
+				if (retval)
 					return retval;
-				}
 			}
 
 			retval = rtsx_write_register(chip, TLPTISTAT, 0xFF,
 						     tmp);
-			if (retval) {
+			if (retval)
 				return retval;
-			}
 
 			chip->need_reset |= SD_CARD;
 		} else {
@@ -225,36 +214,31 @@ static int rtsx_pre_handle_sdio_new(struct rtsx_chip *chip)
 
 			if (chip->asic_code) {
 				retval = sd_pull_ctl_enable(chip);
-				if (retval != STATUS_SUCCESS) {
+				if (retval != STATUS_SUCCESS)
 					return STATUS_FAIL;
-				}
 			} else {
 				retval = rtsx_write_register
 						(chip, FPGA_PULL_CTL,
 						 FPGA_SD_PULL_CTL_BIT | 0x20,
 						 0);
-				if (retval) {
+				if (retval)
 					return retval;
-				}
 			}
 			retval = card_share_mode(chip, SD_CARD);
-			if (retval != STATUS_SUCCESS) {
+			if (retval != STATUS_SUCCESS)
 				return STATUS_FAIL;
-			}
 
 			/* Enable sdio_bus_auto_switch */
 			if (CHECK_PID(chip, 0x5288)) {
 				retval = rtsx_write_register(chip, 0xFE5A,
 							     0x08, 0x08);
-				if (retval) {
+				if (retval)
 					return retval;
-				}
 			} else if (CHECK_PID(chip, 0x5208)) {
 				retval = rtsx_write_register(chip, 0xFE70,
 							     0x80, 0x80);
-				if (retval) {
+				if (retval)
 					return retval;
-				}
 			}
 
 			chip->chip_insert_with_sdio = 1;
@@ -262,9 +246,8 @@ static int rtsx_pre_handle_sdio_new(struct rtsx_chip *chip)
 		}
 	} else {
 		retval = rtsx_write_register(chip, TLPTISTAT, 0x08, 0x08);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 
 		chip->need_reset |= SD_CARD;
 	}
@@ -283,32 +266,28 @@ static int rtsx_reset_aspm(struct rtsx_chip *chip)
 
 		ret = rtsx_write_cfg_dw(chip, 2, 0xC0, 0xFF,
 					chip->aspm_l0s_l1_en);
-		if (ret != STATUS_SUCCESS) {
+		if (ret != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 
 		return STATUS_SUCCESS;
 	}
 
 	if (CHECK_PID(chip, 0x5208)) {
 		ret = rtsx_write_register(chip, ASPM_FORCE_CTL, 0xFF, 0x3F);
-		if (ret) {
+		if (ret)
 			return ret;
-		}
 	}
 	ret = rtsx_write_config_byte(chip, LCTLR, chip->aspm_l0s_l1_en);
-	if (ret != STATUS_SUCCESS) {
+	if (ret != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	chip->aspm_level[0] = chip->aspm_l0s_l1_en;
 	if (CHK_SDIO_EXIST(chip)) {
 		chip->aspm_level[1] = chip->aspm_l0s_l1_en;
 		ret = rtsx_write_cfg_dw(chip, CHECK_PID(chip, 0x5288) ? 2 : 1,
 					0xC0, 0xFF, chip->aspm_l0s_l1_en);
-		if (ret != STATUS_SUCCESS) {
+		if (ret != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 	}
 
 	chip->aspm_enabled = 1;
@@ -327,9 +306,8 @@ static int rtsx_enable_pcie_intr(struct rtsx_chip *chip)
 
 	if (chip->phy_debug_mode) {
 		ret = rtsx_write_register(chip, CDRESUMECTL, 0x77, 0);
-		if (ret) {
+		if (ret)
 			return ret;
-		}
 		rtsx_disable_bus_int(chip);
 	} else {
 		rtsx_enable_bus_int(chip);
@@ -339,27 +317,23 @@ static int rtsx_enable_pcie_intr(struct rtsx_chip *chip)
 		u16 reg;
 
 		ret = rtsx_read_phy_register(chip, 0x00, &reg);
-		if (ret != STATUS_SUCCESS) {
+		if (ret != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 
 		reg &= 0xFE7F;
 		reg |= 0x80;
 		ret = rtsx_write_phy_register(chip, 0x00, reg);
-		if (ret != STATUS_SUCCESS) {
+		if (ret != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 
 		ret = rtsx_read_phy_register(chip, 0x1C, &reg);
-		if (ret != STATUS_SUCCESS) {
+		if (ret != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 
 		reg &= 0xFFF7;
 		ret = rtsx_write_phy_register(chip, 0x1C, reg);
-		if (ret != STATUS_SUCCESS) {
+		if (ret != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 	}
 
 	if (chip->driver_first_load && (chip->ic_version < IC_VER_C))
@@ -377,100 +351,85 @@ int rtsx_reset_chip(struct rtsx_chip *chip)
 	rtsx_disable_aspm(chip);
 
 	retval = rtsx_write_register(chip, HOST_SLEEP_STATE, 0x03, 0x00);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	/* Disable card clock */
 	retval = rtsx_write_register(chip, CARD_CLK_EN, 0x1E, 0);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 #ifdef SUPPORT_OCP
 	/* SSC power on, OCD power on */
 	if (CHECK_LUN_MODE(chip, SD_MS_2LUN)) {
 		retval = rtsx_write_register(chip, FPDCTL, OC_POWER_DOWN, 0);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 	} else {
 		retval = rtsx_write_register(chip, FPDCTL, OC_POWER_DOWN,
 					     MS_OC_POWER_DOWN);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 	}
 
 	retval = rtsx_write_register(chip, OCPPARA1, OCP_TIME_MASK,
 				     OCP_TIME_800);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 	retval = rtsx_write_register(chip, OCPPARA2, OCP_THD_MASK,
 				     OCP_THD_244_946);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 	retval = rtsx_write_register(chip, OCPCTL, 0xFF,
 				     CARD_OC_INT_EN | CARD_DETECT_EN);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 #else
 	/* OC power down */
 	retval = rtsx_write_register(chip, FPDCTL, OC_POWER_DOWN,
 				     OC_POWER_DOWN);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 #endif
 
 	if (!CHECK_PID(chip, 0x5288)) {
 		retval = rtsx_write_register(chip, CARD_GPIO_DIR, 0xFF, 0x03);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 	}
 
 	/* Turn off LED */
 	retval = rtsx_write_register(chip, CARD_GPIO, 0xFF, 0x03);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	/* Reset delink mode */
 	retval = rtsx_write_register(chip, CHANGE_LINK_STATE, 0x0A, 0);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	/* Card driving select */
 	retval = rtsx_write_register(chip, CARD_DRIVE_SEL, 0xFF,
 				     chip->card_drive_sel);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 #ifdef LED_AUTO_BLINK
 	retval = rtsx_write_register(chip, CARD_AUTO_BLINK, 0xFF,
 				     LED_BLINK_SPEED | BLINK_EN | LED_GPIO0);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 #endif
 
 	if (chip->asic_code) {
 		/* Enable SSC Clock */
 		retval = rtsx_write_register(chip, SSC_CTL1, 0xFF,
 					     SSC_8X_EN | SSC_SEL_4M);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 		retval = rtsx_write_register(chip, SSC_CTL2, 0xFF, 0x12);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 	}
 
 	/*
@@ -482,72 +441,61 @@ int rtsx_reset_chip(struct rtsx_chip *chip)
 	 *    bit[4]	u_non_sticky_rst_n_dbg	rst_value = 0
 	 */
 	retval = rtsx_write_register(chip, CHANGE_LINK_STATE, 0x16, 0x10);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	/* Enable ASPM */
 	if (chip->aspm_l0s_l1_en) {
 		retval = rtsx_reset_aspm(chip);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 	} else {
 		if (chip->asic_code && CHECK_PID(chip, 0x5208)) {
 			retval = rtsx_write_phy_register(chip, 0x07, 0x0129);
-			if (retval != STATUS_SUCCESS) {
+			if (retval != STATUS_SUCCESS)
 				return STATUS_FAIL;
-			}
 		}
 		retval = rtsx_write_config_byte(chip, LCTLR,
 						chip->aspm_l0s_l1_en);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 	}
 
 	retval = rtsx_write_config_byte(chip, 0x81, 1);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	if (CHK_SDIO_EXIST(chip)) {
 		retval = rtsx_write_cfg_dw(chip,
 					   CHECK_PID(chip, 0x5288) ? 2 : 1,
 					   0xC0, 0xFF00, 0x0100);
 
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 	}
 
 	if (CHECK_PID(chip, 0x5288) && !CHK_SDIO_EXIST(chip)) {
 		retval = rtsx_write_cfg_dw(chip, 2, 0xC0, 0xFFFF, 0x0103);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 
 		retval = rtsx_write_cfg_dw(chip, 2, 0x84, 0xFF, 0x03);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 	}
 
 	retval = rtsx_write_register(chip, IRQSTAT0, LINK_RDY_INT,
 				     LINK_RDY_INT);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	retval = rtsx_write_register(chip, PERST_GLITCH_WIDTH, 0xFF, 0x80);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	retval = rtsx_enable_pcie_intr(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	chip->need_reset = 0;
 
@@ -569,17 +517,15 @@ int rtsx_reset_chip(struct rtsx_chip *chip)
 #else  /* HW_AUTO_SWITCH_SD_BUS */
 		retval = rtsx_pre_handle_sdio_old(chip);
 #endif  /* HW_AUTO_SWITCH_SD_BUS */
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 
 	} else {
 		chip->sd_io = 0;
 		retval = rtsx_write_register(chip, SDIO_CTRL,
 					     SDIO_BUS_CTRL | SDIO_CD_CTRL, 0);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 	}
 
 nextcard:
@@ -590,78 +536,67 @@ int rtsx_reset_chip(struct rtsx_chip *chip)
 	if (chip->int_reg & CARD_EXIST) {
 		retval = rtsx_write_register(chip, SSC_CTL1, SSC_RSTB,
 					     SSC_RSTB);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 	}
 
 	dev_dbg(rtsx_dev(chip), "In %s, chip->need_reset = 0x%x\n", __func__,
 		(unsigned int)(chip->need_reset));
 
 	retval = rtsx_write_register(chip, RCCTL, 0x01, 0x00);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	if (CHECK_PID(chip, 0x5208) || CHECK_PID(chip, 0x5288)) {
 		/* Turn off main power when entering S3/S4 state */
 		retval = rtsx_write_register(chip, MAIN_PWR_OFF_CTL, 0x03,
 					     0x03);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 	}
 
 	if (chip->remote_wakeup_en && !chip->auto_delink_en) {
 		retval = rtsx_write_register(chip, WAKE_SEL_CTL, 0x07, 0x07);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 		if (chip->aux_pwr_exist) {
 			retval = rtsx_write_register(chip, PME_FORCE_CTL,
 						     0xFF, 0x33);
-			if (retval) {
+			if (retval)
 				return retval;
-			}
 		}
 	} else {
 		retval = rtsx_write_register(chip, WAKE_SEL_CTL, 0x07, 0x04);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 		retval = rtsx_write_register(chip, PME_FORCE_CTL, 0xFF, 0x30);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 	}
 
 	if (CHECK_PID(chip, 0x5208) && (chip->ic_version >= IC_VER_D)) {
 		retval = rtsx_write_register(chip, PETXCFG, 0x1C, 0x14);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 	}
 
 	if (chip->asic_code && CHECK_PID(chip, 0x5208)) {
 		retval = rtsx_clr_phy_reg_bit(chip, 0x1C, 2);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 	}
 
 	if (chip->ft2_fast_mode) {
 		retval = rtsx_write_register(chip, CARD_PWR_CTL, 0xFF,
 					     MS_PARTIAL_POWER_ON |
 					     SD_PARTIAL_POWER_ON);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 		udelay(chip->pmos_pwr_on_interval);
 		retval = rtsx_write_register(chip, CARD_PWR_CTL, 0xFF,
 					     MS_POWER_ON | SD_POWER_ON);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 
 		wait_timeout(200);
 	}
@@ -715,20 +650,17 @@ static int rts5208_init(struct rtsx_chip *chip)
 	u8 val = 0;
 
 	retval = rtsx_write_register(chip, CLK_SEL, 0x03, 0x03);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 	retval = rtsx_read_register(chip, CLK_SEL, &val);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 	chip->asic_code = val == 0 ? 1 : 0;
 
 	if (chip->asic_code) {
 		retval = rtsx_read_phy_register(chip, 0x1C, &reg);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 
 		dev_dbg(rtsx_dev(chip), "Value of phy register 0x1C is 0x%x\n",
 			reg);
@@ -737,24 +669,21 @@ static int rts5208_init(struct rtsx_chip *chip)
 
 	} else {
 		retval = rtsx_read_register(chip, 0xFE80, &val);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 		chip->ic_version = val;
 		chip->phy_debug_mode = 0;
 	}
 
 	retval = rtsx_read_register(chip, PDINFO, &val);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 	dev_dbg(rtsx_dev(chip), "PDINFO: 0x%x\n", val);
 	chip->aux_pwr_exist = val & AUX_PWR_DETECTED ? 1 : 0;
 
 	retval = rtsx_read_register(chip, 0xFE50, &val);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 	chip->hw_bypass_sd = val & 0x01 ? 1 : 0;
 
 	rtsx_read_config_byte(chip, 0x0E, &val);
@@ -765,9 +694,8 @@ static int rts5208_init(struct rtsx_chip *chip)
 
 	if (chip->use_hw_setting) {
 		retval = rtsx_read_register(chip, CHANGE_LINK_STATE, &val);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 		chip->auto_delink_en = val & 0x80 ? 1 : 0;
 	}
 
@@ -781,42 +709,36 @@ static int rts5288_init(struct rtsx_chip *chip)
 	u32 lval = 0;
 
 	retval = rtsx_write_register(chip, CLK_SEL, 0x03, 0x03);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 	retval = rtsx_read_register(chip, CLK_SEL, &val);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 	chip->asic_code = val == 0 ? 1 : 0;
 
 	chip->ic_version = 0;
 	chip->phy_debug_mode = 0;
 
 	retval = rtsx_read_register(chip, PDINFO, &val);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 	dev_dbg(rtsx_dev(chip), "PDINFO: 0x%x\n", val);
 	chip->aux_pwr_exist = val & AUX_PWR_DETECTED ? 1 : 0;
 
 	retval = rtsx_read_register(chip, CARD_SHARE_MODE, &val);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 	dev_dbg(rtsx_dev(chip), "CARD_SHARE_MODE: 0x%x\n", val);
 	chip->baro_pkg = val & 0x04 ? QFN : LQFP;
 
 	retval = rtsx_read_register(chip, 0xFE5A, &val);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 	chip->hw_bypass_sd = val & 0x10 ? 1 : 0;
 
 	retval = rtsx_read_cfg_dw(chip, 0, 0x718, &lval);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	max_func = (u8)((lval >> 29) & 0x07);
 	dev_dbg(rtsx_dev(chip), "Max function number: %d\n", max_func);
@@ -827,9 +749,8 @@ static int rts5288_init(struct rtsx_chip *chip)
 
 	if (chip->use_hw_setting) {
 		retval = rtsx_read_register(chip, CHANGE_LINK_STATE, &val);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 		chip->auto_delink_en = val & 0x80 ? 1 : 0;
 
 		if (CHECK_BARO_PKG(chip, LQFP))
@@ -905,28 +826,24 @@ int rtsx_init_chip(struct rtsx_chip *chip)
 		chip->mmc_ddr_tx_phase = 0;
 
 	retval = rtsx_write_register(chip, FPDCTL, SSC_POWER_DOWN, 0);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 	wait_timeout(200);
 	retval = rtsx_write_register(chip, CLK_DIV, 0x07, 0x07);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 	dev_dbg(rtsx_dev(chip), "chip->use_hw_setting = %d\n",
 		chip->use_hw_setting);
 
 	if (CHECK_PID(chip, 0x5208)) {
 		retval = rts5208_init(chip);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 
 	} else if (CHECK_PID(chip, 0x5288)) {
 		retval = rts5288_init(chip);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 	}
 
 	if (chip->ss_en == 2)
@@ -973,9 +890,8 @@ int rtsx_init_chip(struct rtsx_chip *chip)
 	}
 
 	retval = rtsx_reset_chip(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -1403,9 +1319,8 @@ int rtsx_write_register(struct rtsx_chip *chip, u16 addr, u8 mask, u8 data)
 	for (i = 0; i < MAX_RW_REG_CNT; i++) {
 		val = rtsx_readl(chip, RTSX_HAIMR);
 		if ((val & BIT(31)) == 0) {
-			if (data != (u8)val) {
+			if (data != (u8)val)
 				return STATUS_FAIL;
-			}
 
 			return STATUS_SUCCESS;
 		}
@@ -1432,9 +1347,8 @@ int rtsx_read_register(struct rtsx_chip *chip, u16 addr, u8 *data)
 			break;
 	}
 
-	if (i >= MAX_RW_REG_CNT) {
+	if (i >= MAX_RW_REG_CNT)
 		return STATUS_TIMEDOUT;
-	}
 
 	if (data)
 		*data = (u8)(val & 0xFF);
@@ -1454,9 +1368,8 @@ int rtsx_write_cfg_dw(struct rtsx_chip *chip, u8 func_no, u16 addr, u32 mask,
 			retval = rtsx_write_register(chip, CFGDATA0 + i,
 						     0xFF,
 						     (u8)(val & mask & 0xFF));
-			if (retval) {
+			if (retval)
 				return retval;
-			}
 			mode |= (1 << i);
 		}
 		mask >>= 8;
@@ -1465,27 +1378,23 @@ int rtsx_write_cfg_dw(struct rtsx_chip *chip, u8 func_no, u16 addr, u32 mask,
 
 	if (mode) {
 		retval = rtsx_write_register(chip, CFGADDR0, 0xFF, (u8)addr);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 		retval = rtsx_write_register(chip, CFGADDR1, 0xFF,
 					     (u8)(addr >> 8));
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 
 		retval = rtsx_write_register(chip, CFGRWCTL, 0xFF,
 					     0x80 | mode |
 					     ((func_no & 0x03) << 4));
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 
 		for (i = 0; i < MAX_RW_REG_CNT; i++) {
 			retval = rtsx_read_register(chip, CFGRWCTL, &tmp);
-			if (retval) {
+			if (retval)
 				return retval;
-			}
 			if ((tmp & 0x80) == 0)
 				break;
 		}
@@ -1502,33 +1411,28 @@ int rtsx_read_cfg_dw(struct rtsx_chip *chip, u8 func_no, u16 addr, u32 *val)
 	u32 data = 0;
 
 	retval = rtsx_write_register(chip, CFGADDR0, 0xFF, (u8)addr);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 	retval = rtsx_write_register(chip, CFGADDR1, 0xFF, (u8)(addr >> 8));
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 	retval = rtsx_write_register(chip, CFGRWCTL, 0xFF,
 				     0x80 | ((func_no & 0x03) << 4));
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	for (i = 0; i < MAX_RW_REG_CNT; i++) {
 		retval = rtsx_read_register(chip, CFGRWCTL, &tmp);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 		if ((tmp & 0x80) == 0)
 			break;
 	}
 
 	for (i = 0; i < 4; i++) {
 		retval = rtsx_read_register(chip, CFGDATA0 + i, &tmp);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 		data |= (u32)tmp << (i * 8);
 	}
 
@@ -1547,9 +1451,8 @@ int rtsx_write_cfg_seq(struct rtsx_chip *chip, u8 func, u16 addr, u8 *buf,
 	int dw_len, i, j;
 	int retval;
 
-	if (!buf) {
+	if (!buf)
 		return STATUS_NOMEM;
-	}
 
 	if ((len + offset) % 4)
 		dw_len = (len + offset) / 4 + 1;
@@ -1559,9 +1462,8 @@ int rtsx_write_cfg_seq(struct rtsx_chip *chip, u8 func, u16 addr, u8 *buf,
 	dev_dbg(rtsx_dev(chip), "dw_len = %d\n", dw_len);
 
 	data = vzalloc(array_size(dw_len, 4));
-	if (!data) {
+	if (!data)
 		return STATUS_NOMEM;
-	}
 
 	mask = vzalloc(array_size(dw_len, 4));
 	if (!mask) {
@@ -1617,9 +1519,8 @@ int rtsx_read_cfg_seq(struct rtsx_chip *chip, u8 func, u16 addr, u8 *buf,
 	dev_dbg(rtsx_dev(chip), "dw_len = %d\n", dw_len);
 
 	data = vmalloc(array_size(dw_len, 4));
-	if (!data) {
+	if (!data)
 		return STATUS_NOMEM;
-	}
 
 	for (i = 0; i < dw_len; i++) {
 		retval = rtsx_read_cfg_dw(chip, func, aligned_addr + i * 4,
@@ -1655,36 +1556,30 @@ int rtsx_write_phy_register(struct rtsx_chip *chip, u8 addr, u16 val)
 	u8 tmp;
 
 	retval = rtsx_write_register(chip, PHYDATA0, 0xFF, (u8)val);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 	retval = rtsx_write_register(chip, PHYDATA1, 0xFF, (u8)(val >> 8));
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 	retval = rtsx_write_register(chip, PHYADDR, 0xFF, addr);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 	retval = rtsx_write_register(chip, PHYRWCTL, 0xFF, 0x81);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	for (i = 0; i < 100000; i++) {
 		retval = rtsx_read_register(chip, PHYRWCTL, &tmp);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 		if (!(tmp & 0x80)) {
 			finished = true;
 			break;
 		}
 	}
 
-	if (!finished) {
+	if (!finished)
 		return STATUS_FAIL;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -1698,38 +1593,32 @@ int rtsx_read_phy_register(struct rtsx_chip *chip, u8 addr, u16 *val)
 	u8 tmp;
 
 	retval = rtsx_write_register(chip, PHYADDR, 0xFF, addr);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 	retval = rtsx_write_register(chip, PHYRWCTL, 0xFF, 0x80);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	for (i = 0; i < 100000; i++) {
 		retval = rtsx_read_register(chip, PHYRWCTL, &tmp);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 		if (!(tmp & 0x80)) {
 			finished = true;
 			break;
 		}
 	}
 
-	if (!finished) {
+	if (!finished)
 		return STATUS_FAIL;
-	}
 
 	retval = rtsx_read_register(chip, PHYDATA0, &tmp);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 	data = tmp;
 	retval = rtsx_read_register(chip, PHYDATA1, &tmp);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 	data |= (u16)tmp << 8;
 
 	if (val)
@@ -1745,28 +1634,24 @@ int rtsx_read_efuse(struct rtsx_chip *chip, u8 addr, u8 *val)
 	u8 data = 0;
 
 	retval = rtsx_write_register(chip, EFUSE_CTRL, 0xFF, 0x80 | addr);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	for (i = 0; i < 100; i++) {
 		retval = rtsx_read_register(chip, EFUSE_CTRL, &data);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 		if (!(data & 0x80))
 			break;
 		udelay(1);
 	}
 
-	if (data & 0x80) {
+	if (data & 0x80)
 		return STATUS_TIMEDOUT;
-	}
 
 	retval = rtsx_read_register(chip, EFUSE_DATA, &data);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 	if (val)
 		*val = data;
 
@@ -1787,28 +1672,24 @@ int rtsx_write_efuse(struct rtsx_chip *chip, u8 addr, u8 val)
 		dev_dbg(rtsx_dev(chip), "Write 0x%x to 0x%x\n", tmp, addr);
 
 		retval = rtsx_write_register(chip, EFUSE_DATA, 0xFF, tmp);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 		retval = rtsx_write_register(chip, EFUSE_CTRL, 0xFF,
 					     0xA0 | addr);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 
 		for (j = 0; j < 100; j++) {
 			retval = rtsx_read_register(chip, EFUSE_CTRL, &data);
-			if (retval) {
+			if (retval)
 				return retval;
-			}
 			if (!(data & 0x80))
 				break;
 			wait_timeout(3);
 		}
 
-		if (data & 0x80) {
+		if (data & 0x80)
 			return STATUS_TIMEDOUT;
-		}
 
 		wait_timeout(5);
 	}
@@ -1822,16 +1703,14 @@ int rtsx_clr_phy_reg_bit(struct rtsx_chip *chip, u8 reg, u8 bit)
 	u16 value;
 
 	retval = rtsx_read_phy_register(chip, reg, &value);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	if (value & (1 << bit)) {
 		value &= ~(1 << bit);
 		retval = rtsx_write_phy_register(chip, reg, value);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 	}
 
 	return STATUS_SUCCESS;
@@ -1843,16 +1722,14 @@ int rtsx_set_phy_reg_bit(struct rtsx_chip *chip, u8 reg, u8 bit)
 	u16 value;
 
 	retval = rtsx_read_phy_register(chip, reg, &value);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	if ((value & (1 << bit)) == 0) {
 		value |= (1 << bit);
 		retval = rtsx_write_phy_register(chip, reg, value);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 	}
 
 	return STATUS_SUCCESS;
@@ -2153,9 +2030,8 @@ int rtsx_read_ppbuf(struct rtsx_chip *chip, u8 *buf, int buf_len)
 	u16 reg_addr;
 	u8 *ptr;
 
-	if (!buf) {
+	if (!buf)
 		return STATUS_ERROR;
-	}
 
 	ptr = buf;
 	reg_addr = PPBUF_BASE2;
@@ -2166,9 +2042,8 @@ int rtsx_read_ppbuf(struct rtsx_chip *chip, u8 *buf, int buf_len)
 			rtsx_add_cmd(chip, READ_REG_CMD, reg_addr++, 0, 0);
 
 		retval = rtsx_send_cmd(chip, 0, 250);
-		if (retval < 0) {
+		if (retval < 0)
 			return STATUS_FAIL;
-		}
 
 		memcpy(ptr, rtsx_get_cmd_data(chip), 256);
 		ptr += 256;
@@ -2181,9 +2056,8 @@ int rtsx_read_ppbuf(struct rtsx_chip *chip, u8 *buf, int buf_len)
 			rtsx_add_cmd(chip, READ_REG_CMD, reg_addr++, 0, 0);
 
 		retval = rtsx_send_cmd(chip, 0, 250);
-		if (retval < 0) {
+		if (retval < 0)
 			return STATUS_FAIL;
-		}
 	}
 
 	memcpy(ptr, rtsx_get_cmd_data(chip), buf_len % 256);
@@ -2198,9 +2072,8 @@ int rtsx_write_ppbuf(struct rtsx_chip *chip, u8 *buf, int buf_len)
 	u16 reg_addr;
 	u8 *ptr;
 
-	if (!buf) {
+	if (!buf)
 		return STATUS_ERROR;
-	}
 
 	ptr = buf;
 	reg_addr = PPBUF_BASE2;
@@ -2214,9 +2087,8 @@ int rtsx_write_ppbuf(struct rtsx_chip *chip, u8 *buf, int buf_len)
 		}
 
 		retval = rtsx_send_cmd(chip, 0, 250);
-		if (retval < 0) {
+		if (retval < 0)
 			return STATUS_FAIL;
-		}
 	}
 
 	if (buf_len % 256) {
@@ -2229,9 +2101,8 @@ int rtsx_write_ppbuf(struct rtsx_chip *chip, u8 *buf, int buf_len)
 		}
 
 		retval = rtsx_send_cmd(chip, 0, 250);
-		if (retval < 0) {
+		if (retval < 0)
 			return STATUS_FAIL;
-		}
 	}
 
 	return STATUS_SUCCESS;
@@ -2239,9 +2110,8 @@ int rtsx_write_ppbuf(struct rtsx_chip *chip, u8 *buf, int buf_len)
 
 int rtsx_check_chip_exist(struct rtsx_chip *chip)
 {
-	if (rtsx_readl(chip, 0) == 0xFFFFFFFF) {
+	if (rtsx_readl(chip, 0) == 0xFFFFFFFF)
 		return STATUS_FAIL;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -2264,9 +2134,8 @@ int rtsx_force_power_on(struct rtsx_chip *chip, u8 ctl)
 
 	if (mask) {
 		retval = rtsx_write_register(chip, FPDCTL, mask, 0);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 
 		if (CHECK_PID(chip, 0x5288))
 			wait_timeout(200);
@@ -2294,9 +2163,8 @@ int rtsx_force_power_down(struct rtsx_chip *chip, u8 ctl)
 	if (mask) {
 		val = mask;
 		retval = rtsx_write_register(chip, FPDCTL, mask, val);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 	}
 
 	return STATUS_SUCCESS;
diff --git a/drivers/staging/rts5208/rtsx_scsi.c b/drivers/staging/rts5208/rtsx_scsi.c
index c9a6d97938f6..9c594a778425 100644
--- a/drivers/staging/rts5208/rtsx_scsi.c
+++ b/drivers/staging/rts5208/rtsx_scsi.c
@@ -507,9 +507,8 @@ static int inquiry(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	}
 
 	buf = vmalloc(scsi_bufflen(srb));
-	if (!buf) {
+	if (!buf)
 		return TRANSPORT_ERROR;
-	}
 
 #ifdef SUPPORT_MAGIC_GATE
 	if ((chip->mspro_formatter_enable) &&
@@ -637,9 +636,8 @@ static int request_sense(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	}
 
 	buf = vmalloc(scsi_bufflen(srb));
-	if (!buf) {
+	if (!buf)
 		return TRANSPORT_ERROR;
-	}
 
 	tmp = (unsigned char *)sense;
 	memcpy(buf, tmp, scsi_bufflen(srb));
@@ -783,9 +781,8 @@ static int mode_sense(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 #endif
 
 	buf = kmalloc(data_size, GFP_KERNEL);
-	if (!buf) {
+	if (!buf)
 		return TRANSPORT_ERROR;
-	}
 
 	page_code = srb->cmnd[2] & 0x3f;
 
@@ -999,9 +996,8 @@ static int read_format_capacity(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	buf_len = (scsi_bufflen(srb) > 12) ? 0x14 : 12;
 
 	buf = kmalloc(buf_len, GFP_KERNEL);
-	if (!buf) {
+	if (!buf)
 		return TRANSPORT_ERROR;
-	}
 
 	buf[i++] = 0;
 	buf[i++] = 0;
@@ -1076,9 +1072,8 @@ static int read_capacity(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	}
 
 	buf = kmalloc(8, GFP_KERNEL);
-	if (!buf) {
+	if (!buf)
 		return TRANSPORT_ERROR;
-	}
 
 	card_size = get_card_size(chip, lun);
 	buf[0] = (unsigned char)((card_size - 1) >> 24);
@@ -1116,9 +1111,8 @@ static int read_eeprom(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	len = ((u16)srb->cmnd[4] << 8) | srb->cmnd[5];
 
 	buf = vmalloc(len);
-	if (!buf) {
+	if (!buf)
 		return TRANSPORT_ERROR;
-	}
 
 	retval = rtsx_force_power_on(chip, SSC_PDCTL);
 	if (retval != STATUS_SUCCESS) {
@@ -1180,9 +1174,8 @@ static int write_eeprom(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 		len = (unsigned short)min_t(unsigned int, scsi_bufflen(srb),
 					len);
 		buf = vmalloc(len);
-		if (!buf) {
+		if (!buf)
 			return TRANSPORT_ERROR;
-		}
 
 		rtsx_stor_get_xfer_buf(buf, len, srb);
 		scsi_set_resid(srb, scsi_bufflen(srb) - len);
@@ -1227,9 +1220,8 @@ static int read_mem(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	}
 
 	buf = vmalloc(len);
-	if (!buf) {
+	if (!buf)
 		return TRANSPORT_ERROR;
-	}
 
 	retval = rtsx_force_power_on(chip, SSC_PDCTL);
 	if (retval != STATUS_SUCCESS) {
@@ -1282,9 +1274,8 @@ static int write_mem(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 	len = (unsigned short)min_t(unsigned int, scsi_bufflen(srb), len);
 	buf = vmalloc(len);
-	if (!buf) {
+	if (!buf)
 		return TRANSPORT_ERROR;
-	}
 
 	rtsx_stor_get_xfer_buf(buf, len, srb);
 	scsi_set_resid(srb, scsi_bufflen(srb) - len);
@@ -1702,41 +1693,35 @@ static int set_chip_mode(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	if (phy_debug_mode) {
 		chip->phy_debug_mode = 1;
 		retval = rtsx_write_register(chip, CDRESUMECTL, 0x77, 0);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return TRANSPORT_FAILED;
-		}
 
 		rtsx_disable_bus_int(chip);
 
 		retval = rtsx_read_phy_register(chip, 0x1C, &reg);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return TRANSPORT_FAILED;
-		}
 
 		reg |= 0x0001;
 		retval = rtsx_write_phy_register(chip, 0x1C, reg);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return TRANSPORT_FAILED;
-		}
 	} else {
 		chip->phy_debug_mode = 0;
 		retval = rtsx_write_register(chip, CDRESUMECTL, 0x77, 0x77);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return TRANSPORT_FAILED;
-		}
 
 		rtsx_enable_bus_int(chip);
 
 		retval = rtsx_read_phy_register(chip, 0x1C, &reg);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return TRANSPORT_FAILED;
-		}
 
 		reg &= 0xFFFE;
 		retval = rtsx_write_phy_register(chip, 0x1C, reg);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return TRANSPORT_FAILED;
-		}
 	}
 
 	return TRANSPORT_GOOD;
@@ -1840,9 +1825,8 @@ static int read_phy_register(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 	if (len) {
 		buf = vmalloc(len);
-		if (!buf) {
+		if (!buf)
 			return TRANSPORT_ERROR;
-		}
 
 		retval = rtsx_force_power_on(chip, SSC_PDCTL);
 		if (retval != STATUS_SUCCESS) {
@@ -1903,9 +1887,8 @@ static int write_phy_register(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 					len);
 
 		buf = vmalloc(len);
-		if (!buf) {
+		if (!buf)
 			return TRANSPORT_ERROR;
-		}
 
 		rtsx_stor_get_xfer_buf(buf, len, srb);
 		scsi_set_resid(srb, scsi_bufflen(srb) - len);
@@ -1999,9 +1982,8 @@ static int read_eeprom2(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	len = ((u16)srb->cmnd[6] << 8) | srb->cmnd[7];
 
 	buf = vmalloc(len);
-	if (!buf) {
+	if (!buf)
 		return TRANSPORT_ERROR;
-	}
 
 	retval = rtsx_force_power_on(chip, SSC_PDCTL);
 	if (retval != STATUS_SUCCESS) {
@@ -2049,9 +2031,8 @@ static int write_eeprom2(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 	len = (unsigned short)min_t(unsigned int, scsi_bufflen(srb), len);
 	buf = vmalloc(len);
-	if (!buf) {
+	if (!buf)
 		return TRANSPORT_ERROR;
-	}
 
 	rtsx_stor_get_xfer_buf(buf, len, srb);
 	scsi_set_resid(srb, scsi_bufflen(srb) - len);
@@ -2096,9 +2077,8 @@ static int read_efuse(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	len = srb->cmnd[5];
 
 	buf = vmalloc(len);
-	if (!buf) {
+	if (!buf)
 		return TRANSPORT_ERROR;
-	}
 
 	retval = rtsx_force_power_on(chip, SSC_PDCTL);
 	if (retval != STATUS_SUCCESS) {
@@ -2147,9 +2127,8 @@ static int write_efuse(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 	len = (u8)min_t(unsigned int, scsi_bufflen(srb), len);
 	buf = vmalloc(len);
-	if (!buf) {
+	if (!buf)
 		return TRANSPORT_ERROR;
-	}
 
 	rtsx_stor_get_xfer_buf(buf, len, srb);
 	scsi_set_resid(srb, scsi_bufflen(srb) - len);
@@ -2215,29 +2194,25 @@ static int write_efuse(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	vfree(buf);
 
 	retval = card_power_off(chip, SPI_CARD);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return TRANSPORT_ERROR;
-	}
 
 	if (chip->asic_code) {
 		retval = rtsx_write_register(chip, PWR_GATE_CTRL,
 					     LDO3318_PWR_MASK, LDO_OFF);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return TRANSPORT_ERROR;
-		}
 
 		wait_timeout(600);
 
 		retval = rtsx_write_phy_register(chip, 0x08, val);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return TRANSPORT_ERROR;
-		}
 
 		retval = rtsx_write_register(chip, PWR_GATE_CTRL,
 					     LDO3318_PWR_MASK, LDO_ON);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return TRANSPORT_ERROR;
-		}
 	}
 
 	return result;
@@ -2278,9 +2253,8 @@ static int read_cfg_byte(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	}
 
 	buf = vmalloc(len);
-	if (!buf) {
+	if (!buf)
 		return TRANSPORT_ERROR;
-	}
 
 	retval = rtsx_read_cfg_seq(chip, func, addr, buf, len);
 	if (retval != STATUS_SUCCESS) {
@@ -2335,9 +2309,8 @@ static int write_cfg_byte(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 	len = (unsigned short)min_t(unsigned int, scsi_bufflen(srb), len);
 	buf = vmalloc(len);
-	if (!buf) {
+	if (!buf)
 		return TRANSPORT_ERROR;
-	}
 
 	rtsx_stor_get_xfer_buf(buf, len, srb);
 	scsi_set_resid(srb, scsi_bufflen(srb) - len);
@@ -2657,9 +2630,8 @@ static int spi_vendor_cmd(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 	rtsx_write_register(chip, CARD_GPIO_DIR, 0x07, gpio_dir);
 
-	if (result != STATUS_SUCCESS) {
+	if (result != STATUS_SUCCESS)
 		return TRANSPORT_FAILED;
-	}
 
 	return TRANSPORT_GOOD;
 }
@@ -2849,9 +2821,8 @@ static int get_ms_information(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	}
 
 	buf = kmalloc(buf_len, GFP_KERNEL);
-	if (!buf) {
+	if (!buf)
 		return TRANSPORT_ERROR;
-	}
 
 	i = 0;
 	/*  GET Memory Stick Media Information Response Header */
@@ -3025,9 +2996,8 @@ static int mg_report_key(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 		    (srb->cmnd[8] == 0x04) &&
 		    (srb->cmnd[9] == 0x1C)) {
 			retval = mg_get_local_EKB(srb, chip);
-			if (retval != STATUS_SUCCESS) {
+			if (retval != STATUS_SUCCESS)
 				return TRANSPORT_FAILED;
-			}
 
 		} else {
 			set_sense_type(chip, lun,
@@ -3041,9 +3011,8 @@ static int mg_report_key(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 		    (srb->cmnd[8] == 0x00) &&
 		    (srb->cmnd[9] == 0x24)) {
 			retval = mg_get_rsp_chg(srb, chip);
-			if (retval != STATUS_SUCCESS) {
+			if (retval != STATUS_SUCCESS)
 				return TRANSPORT_FAILED;
-			}
 
 		} else {
 			set_sense_type(chip, lun,
@@ -3062,9 +3031,8 @@ static int mg_report_key(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 		    (srb->cmnd[4] == 0x00) &&
 		    (srb->cmnd[5] < 32)) {
 			retval = mg_get_ICV(srb, chip);
-			if (retval != STATUS_SUCCESS) {
+			if (retval != STATUS_SUCCESS)
 				return TRANSPORT_FAILED;
-			}
 
 		} else {
 			set_sense_type(chip, lun,
@@ -3131,9 +3099,8 @@ static int mg_send_key(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 		    (srb->cmnd[8] == 0x00) &&
 		    (srb->cmnd[9] == 0x0C)) {
 			retval = mg_set_leaf_id(srb, chip);
-			if (retval != STATUS_SUCCESS) {
+			if (retval != STATUS_SUCCESS)
 				return TRANSPORT_FAILED;
-			}
 
 		} else {
 			set_sense_type(chip, lun,
@@ -3147,9 +3114,8 @@ static int mg_send_key(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 		    (srb->cmnd[8] == 0x00) &&
 		    (srb->cmnd[9] == 0x0C)) {
 			retval = mg_chg(srb, chip);
-			if (retval != STATUS_SUCCESS) {
+			if (retval != STATUS_SUCCESS)
 				return TRANSPORT_FAILED;
-			}
 
 		} else {
 			set_sense_type(chip, lun,
@@ -3163,9 +3129,8 @@ static int mg_send_key(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 		    (srb->cmnd[8] == 0x00) &&
 		    (srb->cmnd[9] == 0x0C)) {
 			retval = mg_rsp(srb, chip);
-			if (retval != STATUS_SUCCESS) {
+			if (retval != STATUS_SUCCESS)
 				return TRANSPORT_FAILED;
-			}
 
 		} else {
 			set_sense_type(chip, lun,
@@ -3184,9 +3149,8 @@ static int mg_send_key(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 		    (srb->cmnd[4] == 0x00) &&
 		    (srb->cmnd[5] < 32)) {
 			retval = mg_set_ICV(srb, chip);
-			if (retval != STATUS_SUCCESS) {
+			if (retval != STATUS_SUCCESS)
 				return TRANSPORT_FAILED;
-			}
 
 		} else {
 			set_sense_type(chip, lun,
diff --git a/drivers/staging/rts5208/sd.c b/drivers/staging/rts5208/sd.c
index e7efa34195c7..ff1a9aa152ce 100644
--- a/drivers/staging/rts5208/sd.c
+++ b/drivers/staging/rts5208/sd.c
@@ -109,9 +109,8 @@ static int sd_check_data0_status(struct rtsx_chip *chip)
 	u8 stat;
 
 	retval = rtsx_read_register(chip, REG_SD_STAT1, &stat);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	if (!(stat & SD_DAT0_STATUS)) {
 		sd_set_err_code(chip, SD_BUSY);
@@ -234,9 +233,8 @@ static int sd_send_cmd_get_rsp(struct rtsx_chip *chip, u8 cmd_idx,
 		if ((cmd_idx != SEND_RELATIVE_ADDR) &&
 		    (cmd_idx != SEND_IF_COND)) {
 			if (cmd_idx != STOP_TRANSMISSION) {
-				if (ptr[1] & 0x80) {
+				if (ptr[1] & 0x80)
 					return STATUS_FAIL;
-				}
 			}
 #ifdef SUPPORT_SD_LOCK
 			if (ptr[1] & 0x7D) {
@@ -284,9 +282,8 @@ static int sd_read_data(struct rtsx_chip *chip,
 	if (!buf)
 		buf_len = 0;
 
-	if (buf_len > 512) {
+	if (buf_len > 512)
 		return STATUS_FAIL;
-	}
 
 	rtsx_init_cmd(chip);
 
@@ -331,9 +328,8 @@ static int sd_read_data(struct rtsx_chip *chip,
 
 	if (buf && buf_len) {
 		retval = rtsx_read_ppbuf(chip, buf, buf_len);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 	}
 
 	return STATUS_SUCCESS;
@@ -359,9 +355,8 @@ static int sd_write_data(struct rtsx_chip *chip, u8 trans_mode,
 
 	if (buf && buf_len) {
 		retval = rtsx_write_ppbuf(chip, buf, buf_len);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 	}
 
 	rtsx_init_cmd(chip);
@@ -426,9 +421,8 @@ static int sd_check_csd(struct rtsx_chip *chip, char check_wp)
 			break;
 	}
 
-	if (i == 6) {
+	if (i == 6)
 		return STATUS_FAIL;
-	}
 
 	memcpy(sd_card->raw_csd, rsp + 1, 15);
 
@@ -543,9 +537,8 @@ static int sd_set_sample_push_timing(struct rtsx_chip *chip)
 	}
 
 	retval = rtsx_write_register(chip, REG_SD_CFG1, 0x1C, val);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -606,9 +599,8 @@ static int sd_set_clock_divider(struct rtsx_chip *chip, u8 clk_div)
 		val = 0x20;
 
 	retval = rtsx_write_register(chip, REG_SD_CFG1, mask, val);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -619,16 +611,14 @@ static int sd_set_init_para(struct rtsx_chip *chip)
 	int retval;
 
 	retval = sd_set_sample_push_timing(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	sd_choose_proper_clock(chip);
 
 	retval = switch_clock(chip, sd_card->sd_clock);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -651,9 +641,8 @@ int sd_select_card(struct rtsx_chip *chip, int select)
 	}
 
 	retval = sd_send_cmd_get_rsp(chip, cmd_idx, addr, cmd_type, NULL, 0);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -667,9 +656,8 @@ static int sd_update_lock_status(struct rtsx_chip *chip)
 
 	retval = sd_send_cmd_get_rsp(chip, SEND_STATUS, sd_card->sd_addr,
 				     SD_RSP_TYPE_R1, rsp, 5);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	if (rsp[1] & 0x02)
 		sd_card->sd_lock_status |= SD_LOCKED;
@@ -679,9 +667,8 @@ static int sd_update_lock_status(struct rtsx_chip *chip)
 	dev_dbg(rtsx_dev(chip), "sd_card->sd_lock_status = 0x%x\n",
 		sd_card->sd_lock_status);
 
-	if (rsp[1] & 0x01) {
+	if (rsp[1] & 0x01)
 		return STATUS_FAIL;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -698,9 +685,8 @@ static int sd_wait_state_data_ready(struct rtsx_chip *chip, u8 state,
 		retval = sd_send_cmd_get_rsp(chip, SEND_STATUS,
 					     sd_card->sd_addr, SD_RSP_TYPE_R1,
 					     rsp, 5);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 
 		if (((rsp[3] & 0x1E) == state) &&
 		    ((rsp[3] & 0x01) == data_ready))
@@ -719,31 +705,27 @@ static int sd_change_bank_voltage(struct rtsx_chip *chip, u8 voltage)
 			retval = rtsx_write_phy_register(chip, 0x08,
 							 0x4FC0 |
 							 chip->phy_voltage);
-			if (retval != STATUS_SUCCESS) {
+			if (retval != STATUS_SUCCESS)
 				return STATUS_FAIL;
-			}
 		} else {
 			retval = rtsx_write_register(chip, SD_PAD_CTL,
 						     SD_IO_USING_1V8, 0);
-			if (retval) {
+			if (retval)
 				return retval;
-			}
 		}
 	} else if (voltage == SD_IO_1V8) {
 		if (chip->asic_code) {
 			retval = rtsx_write_phy_register(chip, 0x08,
 							 0x4C40 |
 							 chip->phy_voltage);
-			if (retval != STATUS_SUCCESS) {
+			if (retval != STATUS_SUCCESS)
 				return STATUS_FAIL;
-			}
 		} else {
 			retval = rtsx_write_register(chip, SD_PAD_CTL,
 						     SD_IO_USING_1V8,
 						     SD_IO_USING_1V8);
-			if (retval) {
+			if (retval)
 				return retval;
-			}
 		}
 	} else {
 		return STATUS_FAIL;
@@ -760,22 +742,19 @@ static int sd_voltage_switch(struct rtsx_chip *chip)
 	retval = rtsx_write_register(chip, SD_BUS_STAT,
 				     SD_CLK_TOGGLE_EN | SD_CLK_FORCE_STOP,
 				     SD_CLK_TOGGLE_EN);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	retval = sd_send_cmd_get_rsp(chip, VOLTAGE_SWITCH, 0, SD_RSP_TYPE_R1,
 				     NULL, 0);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	udelay(chip->sd_voltage_switch_delay);
 
 	retval = rtsx_read_register(chip, SD_BUS_STAT, &stat);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 	if (stat & (SD_CMD_STATUS | SD_DAT3_STATUS | SD_DAT2_STATUS |
 				SD_DAT1_STATUS | SD_DAT0_STATUS)) {
 		return STATUS_FAIL;
@@ -783,27 +762,23 @@ static int sd_voltage_switch(struct rtsx_chip *chip)
 
 	retval = rtsx_write_register(chip, SD_BUS_STAT, 0xFF,
 				     SD_CLK_FORCE_STOP);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 	retval = sd_change_bank_voltage(chip, SD_IO_1V8);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	wait_timeout(50);
 
 	retval = rtsx_write_register(chip, SD_BUS_STAT, 0xFF,
 				     SD_CLK_TOGGLE_EN);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 	wait_timeout(10);
 
 	retval = rtsx_read_register(chip, SD_BUS_STAT, &stat);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 	if ((stat & (SD_CMD_STATUS | SD_DAT3_STATUS | SD_DAT2_STATUS |
 				SD_DAT1_STATUS | SD_DAT0_STATUS)) !=
 			(SD_CMD_STATUS | SD_DAT3_STATUS | SD_DAT2_STATUS |
@@ -817,9 +792,8 @@ static int sd_voltage_switch(struct rtsx_chip *chip)
 
 	retval = rtsx_write_register(chip, SD_BUS_STAT,
 				     SD_CLK_TOGGLE_EN | SD_CLK_FORCE_STOP, 0);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -831,23 +805,19 @@ static int sd_reset_dcm(struct rtsx_chip *chip, u8 tune_dir)
 	if (tune_dir == TUNE_RX) {
 		retval = rtsx_write_register(chip, DCM_DRP_CTL, 0xFF,
 					     DCM_RESET | DCM_RX);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 		retval = rtsx_write_register(chip, DCM_DRP_CTL, 0xFF, DCM_RX);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 	} else {
 		retval = rtsx_write_register(chip, DCM_DRP_CTL, 0xFF,
 					     DCM_RESET | DCM_TX);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 		retval = rtsx_write_register(chip, DCM_DRP_CTL, 0xFF, DCM_TX);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 	}
 
 	return STATUS_SUCCESS;
@@ -877,28 +847,23 @@ static int sd_change_phase(struct rtsx_chip *chip, u8 sample_point, u8 tune_dir)
 	if (chip->asic_code) {
 		retval = rtsx_write_register(chip, CLK_CTL, CHANGE_CLK,
 					     CHANGE_CLK);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 		retval = rtsx_write_register(chip, SD_VP_CTL, 0x1F,
 					     sample_point);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 		retval = rtsx_write_register(chip, SD_VPCLK0_CTL,
 					     PHASE_NOT_RESET, 0);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 		retval = rtsx_write_register(chip, SD_VPCLK0_CTL,
 					     PHASE_NOT_RESET, PHASE_NOT_RESET);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 		retval = rtsx_write_register(chip, CLK_CTL, CHANGE_CLK, 0);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 	} else {
 		rtsx_read_register(chip, SD_VP_CTL, &val);
 		dev_dbg(rtsx_dev(chip), "SD_VP_CTL: 0x%x\n", val);
@@ -909,30 +874,26 @@ static int sd_change_phase(struct rtsx_chip *chip, u8 sample_point, u8 tune_dir)
 			retval = rtsx_write_register(chip, SD_VP_CTL,
 						     PHASE_CHANGE,
 						     PHASE_CHANGE);
-			if (retval) {
+			if (retval)
 				return retval;
-			}
 			udelay(50);
 			retval = rtsx_write_register(chip, SD_VP_CTL, 0xFF,
 						     PHASE_CHANGE |
 						     PHASE_NOT_RESET |
 						     sample_point);
-			if (retval) {
+			if (retval)
 				return retval;
-			}
 		} else {
 			retval = rtsx_write_register(chip, CLK_CTL,
 						     CHANGE_CLK, CHANGE_CLK);
-			if (retval) {
+			if (retval)
 				return retval;
-			}
 			udelay(50);
 			retval = rtsx_write_register(chip, SD_VP_CTL, 0xFF,
 						     PHASE_NOT_RESET |
 						     sample_point);
-			if (retval) {
+			if (retval)
 				return retval;
-			}
 		}
 		udelay(100);
 
@@ -942,45 +903,38 @@ static int sd_change_phase(struct rtsx_chip *chip, u8 sample_point, u8 tune_dir)
 		rtsx_add_cmd(chip, CHECK_REG_CMD, SD_DCMPS_CTL,
 			     DCMPS_CHANGE_DONE, DCMPS_CHANGE_DONE);
 		retval = rtsx_send_cmd(chip, SD_CARD, 100);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			goto fail;
-		}
 
 		val = *rtsx_get_cmd_data(chip);
-		if (val & DCMPS_ERROR) {
+		if (val & DCMPS_ERROR)
 			goto fail;
-		}
 
-		if ((val & DCMPS_CURRENT_PHASE) != sample_point) {
+		if ((val & DCMPS_CURRENT_PHASE) != sample_point)
 			goto fail;
-		}
 
 		retval = rtsx_write_register(chip, SD_DCMPS_CTL,
 					     DCMPS_CHANGE, 0);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 		if (ddr_rx) {
 			retval = rtsx_write_register(chip, SD_VP_CTL,
 						     PHASE_CHANGE, 0);
-			if (retval) {
+			if (retval)
 				return retval;
-			}
 		} else {
 			retval = rtsx_write_register(chip, CLK_CTL,
 						     CHANGE_CLK, 0);
-			if (retval) {
+			if (retval)
 				return retval;
-			}
 		}
 
 		udelay(50);
 	}
 
 	retval = rtsx_write_register(chip, SD_CFG1, SD_ASYNC_FIFO_NOT_RST, 0);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	return STATUS_SUCCESS;
 
@@ -1005,9 +959,8 @@ static int sd_check_spec(struct rtsx_chip *chip, u8 bus_width)
 
 	retval = sd_send_cmd_get_rsp(chip, APP_CMD, sd_card->sd_addr,
 				     SD_RSP_TYPE_R1, NULL, 0);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	cmd[0] = 0x40 | SEND_SCR;
 	cmd[1] = 0;
@@ -1024,9 +977,8 @@ static int sd_check_spec(struct rtsx_chip *chip, u8 bus_width)
 
 	memcpy(sd_card->raw_scr, buf, 8);
 
-	if ((buf[0] & 0x0F) == 0) {
+	if ((buf[0] & 0x0F) == 0)
 		return STATUS_FAIL;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -1207,29 +1159,25 @@ static int sd_check_switch_mode(struct rtsx_chip *chip, u8 mode, u8 func_group,
 
 		dev_dbg(rtsx_dev(chip), "Maximum current consumption: %dmA\n",
 			cc);
-		if ((cc == 0) || (cc > 800)) {
+		if ((cc == 0) || (cc > 800))
 			return STATUS_FAIL;
-		}
 
 		retval = sd_query_switch_result(chip, func_group,
 						func_to_switch, buf, 64);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 
 		if ((cc > 400) || (func_to_switch > CURRENT_LIMIT_400)) {
 			retval = rtsx_write_register(chip, OCPPARA2,
 						     SD_OCP_THD_MASK,
 						     chip->sd_800mA_ocp_thd);
-			if (retval) {
+			if (retval)
 				return retval;
-			}
 			retval = rtsx_write_register(chip, CARD_PWR_CTL,
 						     PMOS_STRG_MASK,
 						     PMOS_STRG_800mA);
-			if (retval) {
+			if (retval)
 				return retval;
-			}
 		}
 	}
 
@@ -1278,9 +1226,8 @@ static int sd_check_switch(struct rtsx_chip *chip,
 			}
 
 			retval = rtsx_read_register(chip, SD_STAT1, &stat);
-			if (retval) {
+			if (retval)
 				return retval;
-			}
 			if (stat & SD_CRC16_ERR) {
 				dev_dbg(rtsx_dev(chip), "SD CRC16 error when switching mode\n");
 				return STATUS_FAIL;
@@ -1293,9 +1240,8 @@ static int sd_check_switch(struct rtsx_chip *chip,
 		wait_timeout(20);
 	}
 
-	if (!switch_good) {
+	if (!switch_good)
 		return STATUS_FAIL;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -1310,9 +1256,8 @@ static int sd_switch_function(struct rtsx_chip *chip, u8 bus_width)
 	/* Get supported functions */
 	retval = sd_check_switch_mode(chip, SD_CHECK_MODE, NO_ARGUMENT,
 				      NO_ARGUMENT, bus_width);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	sd_card->func_group1_mask &= ~(sd_card->sd_switch_fail);
 
@@ -1394,13 +1339,11 @@ static int sd_switch_function(struct rtsx_chip *chip, u8 bus_width)
 	if (CHK_SD_DDR50(sd_card)) {
 		retval = rtsx_write_register(chip, SD_PUSH_POINT_CTL, 0x06,
 					     0x04);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 		retval = sd_set_sample_push_timing(chip);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 	}
 
 	if (!func_to_switch || (func_to_switch == HS_SUPPORT)) {
@@ -1454,9 +1397,8 @@ static int sd_switch_function(struct rtsx_chip *chip, u8 bus_width)
 		retval = sd_check_switch(chip, SD_FUNC_GROUP_4, func_to_switch,
 					 bus_width);
 		if (retval != STATUS_SUCCESS) {
-			if (sd_check_err_code(chip, SD_NO_CARD)) {
+			if (sd_check_err_code(chip, SD_NO_CARD))
 				return STATUS_FAIL;
-			}
 		}
 		dev_dbg(rtsx_dev(chip), "Switch current limit finished! (%d)\n",
 			retval);
@@ -1464,9 +1406,8 @@ static int sd_switch_function(struct rtsx_chip *chip, u8 bus_width)
 
 	if (CHK_SD_DDR50(sd_card)) {
 		retval = rtsx_write_register(chip, SD_PUSH_POINT_CTL, 0x06, 0);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 	}
 
 	return STATUS_SUCCESS;
@@ -1480,9 +1421,8 @@ static int sd_wait_data_idle(struct rtsx_chip *chip)
 
 	for (i = 0; i < 100; i++) {
 		retval = rtsx_read_register(chip, SD_DATA_STATE, &val);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 		if (val & SD_DATA_IDLE) {
 			retval = STATUS_SUCCESS;
 			break;
@@ -1500,9 +1440,8 @@ static int sd_sdr_tuning_rx_cmd(struct rtsx_chip *chip, u8 sample_point)
 	u8 cmd[5];
 
 	retval = sd_change_phase(chip, sample_point, TUNE_RX);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	cmd[0] = 0x40 | SEND_TUNING_PATTERN;
 	cmd[1] = 0;
@@ -1529,17 +1468,15 @@ static int sd_ddr_tuning_rx_cmd(struct rtsx_chip *chip, u8 sample_point)
 	u8 cmd[5];
 
 	retval = sd_change_phase(chip, sample_point, TUNE_RX);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	dev_dbg(rtsx_dev(chip), "sd ddr tuning rx\n");
 
 	retval = sd_send_cmd_get_rsp(chip, APP_CMD, sd_card->sd_addr,
 				     SD_RSP_TYPE_R1, NULL, 0);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	cmd[0] = 0x40 | SD_STATUS;
 	cmd[1] = 0;
@@ -1573,9 +1510,8 @@ static int mmc_ddr_tuning_rx_cmd(struct rtsx_chip *chip, u8 sample_point)
 		bus_width = SD_BUS_WIDTH_1;
 
 	retval = sd_change_phase(chip, sample_point, TUNE_RX);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	dev_dbg(rtsx_dev(chip), "mmc ddr tuning rx\n");
 
@@ -1603,15 +1539,13 @@ static int sd_sdr_tuning_tx_cmd(struct rtsx_chip *chip, u8 sample_point)
 	int retval;
 
 	retval = sd_change_phase(chip, sample_point, TUNE_TX);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	retval = rtsx_write_register(chip, SD_CFG3, SD_RSP_80CLK_TIMEOUT_EN,
 				     SD_RSP_80CLK_TIMEOUT_EN);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	retval = sd_send_cmd_get_rsp(chip, SEND_STATUS, sd_card->sd_addr,
 				     SD_RSP_TYPE_R1, NULL, 0);
@@ -1625,9 +1559,8 @@ static int sd_sdr_tuning_tx_cmd(struct rtsx_chip *chip, u8 sample_point)
 
 	retval = rtsx_write_register(chip, SD_CFG3, SD_RSP_80CLK_TIMEOUT_EN,
 				     0);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -1639,9 +1572,8 @@ static int sd_ddr_tuning_tx_cmd(struct rtsx_chip *chip, u8 sample_point)
 	u8 cmd[5], bus_width;
 
 	retval = sd_change_phase(chip, sample_point, TUNE_TX);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	if (CHK_SD(sd_card)) {
 		bus_width = SD_BUS_WIDTH_4;
@@ -1655,15 +1587,13 @@ static int sd_ddr_tuning_tx_cmd(struct rtsx_chip *chip, u8 sample_point)
 	}
 
 	retval = sd_wait_state_data_ready(chip, 0x08, 1, 1000);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	retval = rtsx_write_register(chip, SD_CFG3, SD_RSP_80CLK_TIMEOUT_EN,
 				     SD_RSP_80CLK_TIMEOUT_EN);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	cmd[0] = 0x40 | PROGRAM_CSD;
 	cmd[1] = 0;
@@ -1681,9 +1611,8 @@ static int sd_ddr_tuning_tx_cmd(struct rtsx_chip *chip, u8 sample_point)
 
 	retval = rtsx_write_register(chip, SD_CFG3, SD_RSP_80CLK_TIMEOUT_EN,
 				     0);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	sd_send_cmd_get_rsp(chip, SEND_STATUS, sd_card->sd_addr, SD_RSP_TYPE_R1,
 			    NULL, 0);
@@ -1826,11 +1755,10 @@ static int sd_tuning_rx(struct rtsx_chip *chip)
 			tuning_cmd = sd_sdr_tuning_rx_cmd;
 
 	} else {
-		if (CHK_MMC_DDR52(sd_card)) {
+		if (CHK_MMC_DDR52(sd_card))
 			tuning_cmd = mmc_ddr_tuning_rx_cmd;
-		} else {
+		else
 			return STATUS_FAIL;
-		}
 	}
 
 	for (i = 0; i < 3; i++) {
@@ -1855,14 +1783,12 @@ static int sd_tuning_rx(struct rtsx_chip *chip)
 	dev_dbg(rtsx_dev(chip), "RX phase_map = 0x%08x\n", phase_map);
 
 	final_phase = sd_search_final_phase(chip, phase_map, TUNE_RX);
-	if (final_phase == 0xFF) {
+	if (final_phase == 0xFF)
 		return STATUS_FAIL;
-	}
 
 	retval = sd_change_phase(chip, final_phase, TUNE_RX);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -1877,9 +1803,8 @@ static int sd_ddr_pre_tuning_tx(struct rtsx_chip *chip)
 
 	retval = rtsx_write_register(chip, SD_CFG3, SD_RSP_80CLK_TIMEOUT_EN,
 				     SD_RSP_80CLK_TIMEOUT_EN);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	phase_map = 0;
 	for (i = MAX_PHASE; i >= 0; i--) {
@@ -1904,22 +1829,19 @@ static int sd_ddr_pre_tuning_tx(struct rtsx_chip *chip)
 
 	retval = rtsx_write_register(chip, SD_CFG3, SD_RSP_80CLK_TIMEOUT_EN,
 				     0);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	dev_dbg(rtsx_dev(chip), "DDR TX pre tune phase_map = 0x%08x\n",
 		phase_map);
 
 	final_phase = sd_search_final_phase(chip, phase_map, TUNE_TX);
-	if (final_phase == 0xFF) {
+	if (final_phase == 0xFF)
 		return STATUS_FAIL;
-	}
 
 	retval = sd_change_phase(chip, final_phase, TUNE_TX);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	dev_dbg(rtsx_dev(chip), "DDR TX pre tune phase: %d\n",
 		(int)final_phase);
@@ -1943,11 +1865,10 @@ static int sd_tuning_tx(struct rtsx_chip *chip)
 			tuning_cmd = sd_sdr_tuning_tx_cmd;
 
 	} else {
-		if (CHK_MMC_DDR52(sd_card)) {
+		if (CHK_MMC_DDR52(sd_card))
 			tuning_cmd = sd_ddr_tuning_tx_cmd;
-		} else {
+		else
 			return STATUS_FAIL;
-		}
 	}
 
 	for (i = 0; i < 3; i++) {
@@ -1974,14 +1895,12 @@ static int sd_tuning_tx(struct rtsx_chip *chip)
 	dev_dbg(rtsx_dev(chip), "TX phase_map = 0x%08x\n", phase_map);
 
 	final_phase = sd_search_final_phase(chip, phase_map, TUNE_TX);
-	if (final_phase == 0xFF) {
+	if (final_phase == 0xFF)
 		return STATUS_FAIL;
-	}
 
 	retval = sd_change_phase(chip, final_phase, TUNE_TX);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -1991,14 +1910,12 @@ static int sd_sdr_tuning(struct rtsx_chip *chip)
 	int retval;
 
 	retval = sd_tuning_tx(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	retval = sd_tuning_rx(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -2009,27 +1926,23 @@ static int sd_ddr_tuning(struct rtsx_chip *chip)
 
 	if (!(chip->sd_ctl & SD_DDR_TX_PHASE_SET_BY_USER)) {
 		retval = sd_ddr_pre_tuning_tx(chip);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 	} else {
 		retval = sd_change_phase(chip, (u8)chip->sd_ddr_tx_phase,
 					 TUNE_TX);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 	}
 
 	retval = sd_tuning_rx(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	if (!(chip->sd_ctl & SD_DDR_TX_PHASE_SET_BY_USER)) {
 		retval = sd_tuning_tx(chip);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 	}
 
 	return STATUS_SUCCESS;
@@ -2041,27 +1954,23 @@ static int mmc_ddr_tuning(struct rtsx_chip *chip)
 
 	if (!(chip->sd_ctl & MMC_DDR_TX_PHASE_SET_BY_USER)) {
 		retval = sd_ddr_pre_tuning_tx(chip);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 	} else {
 		retval = sd_change_phase(chip, (u8)chip->mmc_ddr_tx_phase,
 					 TUNE_TX);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 	}
 
 	retval = sd_tuning_rx(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	if (!(chip->sd_ctl & MMC_DDR_TX_PHASE_SET_BY_USER)) {
 		retval = sd_tuning_tx(chip);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 	}
 
 	return STATUS_SUCCESS;
@@ -2074,14 +1983,12 @@ int sd_switch_clock(struct rtsx_chip *chip)
 	int re_tuning = 0;
 
 	retval = select_card(chip, SD_CARD);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	retval = switch_clock(chip, sd_card->sd_clock);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	if (re_tuning) {
 		if (CHK_SD(sd_card)) {
@@ -2094,9 +2001,8 @@ int sd_switch_clock(struct rtsx_chip *chip)
 				retval = mmc_ddr_tuning(chip);
 		}
 
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 	}
 
 	return STATUS_SUCCESS;
@@ -2126,25 +2032,21 @@ static int sd_prepare_reset(struct rtsx_chip *chip)
 	chip->sd_io = 0;
 
 	retval = sd_set_init_para(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return retval;
-	}
 
 	retval = rtsx_write_register(chip, REG_SD_CFG1, 0xFF, 0x40);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	retval = rtsx_write_register(chip, CARD_STOP, SD_STOP | SD_CLR_ERR,
 				     SD_STOP | SD_CLR_ERR);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	retval = select_card(chip, SD_CARD);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -2157,60 +2059,50 @@ static int sd_pull_ctl_disable(struct rtsx_chip *chip)
 		retval = rtsx_write_register(chip, CARD_PULL_CTL1, 0xFF,
 					     XD_D3_PD | SD_D7_PD | SD_CLK_PD |
 					     SD_D5_PD);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 		retval = rtsx_write_register(chip, CARD_PULL_CTL2, 0xFF,
 					     SD_D6_PD | SD_D0_PD | SD_D1_PD |
 					     XD_D5_PD);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 		retval = rtsx_write_register(chip, CARD_PULL_CTL3, 0xFF,
 					     SD_D4_PD | XD_CE_PD | XD_CLE_PD |
 					     XD_CD_PU);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 		retval = rtsx_write_register(chip, CARD_PULL_CTL4, 0xFF,
 					     XD_RDY_PD | SD_D3_PD | SD_D2_PD |
 					     XD_ALE_PD);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 		retval = rtsx_write_register(chip, CARD_PULL_CTL5, 0xFF,
 					     MS_INS_PU | SD_WP_PD | SD_CD_PU |
 					     SD_CMD_PD);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 		retval = rtsx_write_register(chip, CARD_PULL_CTL6, 0xFF,
 					     MS_D5_PD | MS_D4_PD);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 	} else if (CHECK_PID(chip, 0x5288)) {
 		if (CHECK_BARO_PKG(chip, QFN)) {
 			retval = rtsx_write_register(chip, CARD_PULL_CTL1,
 						     0xFF, 0x55);
-			if (retval) {
+			if (retval)
 				return retval;
-			}
 			retval = rtsx_write_register(chip, CARD_PULL_CTL2,
 						     0xFF, 0x55);
-			if (retval) {
+			if (retval)
 				return retval;
-			}
 			retval = rtsx_write_register(chip, CARD_PULL_CTL3,
 						     0xFF, 0x4B);
-			if (retval) {
+			if (retval)
 				return retval;
-			}
 			retval = rtsx_write_register(chip, CARD_PULL_CTL4,
 						     0xFF, 0x69);
-			if (retval) {
+			if (retval)
 				return retval;
-			}
 		}
 	}
 
@@ -2250,9 +2142,8 @@ int sd_pull_ctl_enable(struct rtsx_chip *chip)
 	}
 
 	retval = rtsx_send_cmd(chip, SD_CARD, 100);
-	if (retval < 0) {
+	if (retval < 0)
 		return STATUS_FAIL;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -2262,36 +2153,31 @@ static int sd_init_power(struct rtsx_chip *chip)
 	int retval;
 
 	retval = sd_power_off_card3v3(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	if (!chip->ft2_fast_mode)
 		wait_timeout(250);
 
 	retval = enable_card_clock(chip, SD_CARD);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	if (chip->asic_code) {
 		retval = sd_pull_ctl_enable(chip);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 	} else {
 		retval = rtsx_write_register(chip, FPGA_PULL_CTL,
 					     FPGA_SD_PULL_CTL_BIT | 0x20, 0);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 	}
 
 	if (!chip->ft2_fast_mode) {
 		retval = card_power_on(chip, SD_CARD);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 
 		wait_timeout(260);
 
@@ -2306,9 +2192,8 @@ static int sd_init_power(struct rtsx_chip *chip)
 
 	retval = rtsx_write_register(chip, CARD_OE, SD_OUTPUT_EN,
 				     SD_OUTPUT_EN);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -2318,14 +2203,12 @@ static int sd_dummy_clock(struct rtsx_chip *chip)
 	int retval;
 
 	retval = rtsx_write_register(chip, REG_SD_CFG3, 0x01, 0x01);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 	wait_timeout(5);
 	retval = rtsx_write_register(chip, REG_SD_CFG3, 0x01, 0);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -2373,9 +2256,8 @@ static int sd_check_wp_state(struct rtsx_chip *chip)
 
 	retval = sd_send_cmd_get_rsp(chip, APP_CMD, sd_card->sd_addr,
 				     SD_RSP_TYPE_R1, NULL, 0);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	cmd[0] = 0x40 | SD_STATUS;
 	cmd[1] = 0;
@@ -2689,9 +2571,8 @@ static int reset_sd(struct rtsx_chip *chip)
 
 		retval = rtsx_write_register(chip, SD30_DRIVE_SEL, 0x07,
 					     chip->sd30_drive_sel_1v8);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 
 		retval = sd_set_init_para(chip);
 		if (retval != STATUS_SUCCESS)
@@ -2753,14 +2634,12 @@ static int reset_sd(struct rtsx_chip *chip)
 	if (sd_card->sd_lock_status & SD_UNLOCK_POW_ON) {
 		retval = rtsx_write_register(chip, REG_SD_BLOCK_CNT_H, 0xFF,
 					     0x02);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 		retval = rtsx_write_register(chip, REG_SD_BLOCK_CNT_L, 0xFF,
 					     0x00);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 	}
 #endif
 
@@ -2780,9 +2659,8 @@ static int mmc_test_switch_bus(struct rtsx_chip *chip, u8 width)
 
 	retval = sd_send_cmd_get_rsp(chip, BUSTEST_W, 0, SD_RSP_TYPE_R1, NULL,
 				     0);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return SWITCH_FAIL;
-	}
 
 	if (width == MMC_8BIT_BUS) {
 		buf[0] = 0x55;
@@ -2798,9 +2676,8 @@ static int mmc_test_switch_bus(struct rtsx_chip *chip, u8 width)
 	}
 
 	retval = rtsx_write_register(chip, REG_SD_CFG3, 0x02, 0x02);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return SWITCH_ERR;
-	}
 
 	retval = sd_write_data(chip, SD_TM_AUTO_WRITE_3, NULL, 0, byte_cnt, 1,
 			       bus_width, buf, len, 100);
@@ -2811,9 +2688,8 @@ static int mmc_test_switch_bus(struct rtsx_chip *chip, u8 width)
 	}
 
 	retval = rtsx_write_register(chip, REG_SD_CFG3, 0x02, 0);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return SWITCH_ERR;
-	}
 
 	dev_dbg(rtsx_dev(chip), "SD/MMC CMD %d\n", BUSTEST_R);
 
@@ -2979,9 +2855,8 @@ static int mmc_switch_timing_bus(struct rtsx_chip *chip, bool switch_ddr)
 
 	sd_choose_proper_clock(chip);
 	retval = switch_clock(chip, sd_card->sd_clock);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	/* Test Bus Procedure */
 	retval = mmc_test_switch_bus(chip, MMC_8BIT_BUS);
@@ -3028,18 +2903,16 @@ static int reset_mmc(struct rtsx_chip *chip)
 
 switch_fail:
 	retval = sd_prepare_reset(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return retval;
-	}
 
 	SET_MMC(sd_card);
 
 RTY_MMC_RST:
 	retval = sd_send_cmd_get_rsp(chip, GO_IDLE_STATE, 0, SD_RSP_TYPE_R0,
 				     NULL, 0);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	do {
 		if (detect_card_cd(chip, SD_CARD) != STATUS_SUCCESS) {
@@ -3075,9 +2948,8 @@ static int reset_mmc(struct rtsx_chip *chip)
 		i++;
 	} while (!(rsp[1] & 0x80) && (i < 255));
 
-	if (i == 255) {
+	if (i == 255)
 		return STATUS_FAIL;
-	}
 
 	if ((rsp[1] & 0x60) == 0x40)
 		SET_MMC_SECTOR_MODE(sd_card);
@@ -3086,47 +2958,40 @@ static int reset_mmc(struct rtsx_chip *chip)
 
 	retval = sd_send_cmd_get_rsp(chip, ALL_SEND_CID, 0, SD_RSP_TYPE_R2,
 				     NULL, 0);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	sd_card->sd_addr = 0x00100000;
 	retval = sd_send_cmd_get_rsp(chip, SET_RELATIVE_ADDR, sd_card->sd_addr,
 				     SD_RSP_TYPE_R6, rsp, 5);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	retval = sd_check_csd(chip, 1);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	spec_ver = (sd_card->raw_csd[0] & 0x3C) >> 2;
 
 	retval = sd_select_card(chip, 1);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	retval = sd_send_cmd_get_rsp(chip, SET_BLOCKLEN, 0x200, SD_RSP_TYPE_R1,
 				     NULL, 0);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 #ifdef SUPPORT_SD_LOCK
 MMC_UNLOCK_ENTRY:
 	retval = sd_update_lock_status(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 #endif
 
 	retval = sd_set_clock_divider(chip, SD_CLK_DIVIDE_0);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	chip->card_bus_width[chip->card2lun[SD_CARD]] = 1;
 
@@ -3136,30 +3001,26 @@ static int reset_mmc(struct rtsx_chip *chip)
 			retval = mmc_switch_timing_bus(chip, switch_ddr);
 			if (retval != STATUS_SUCCESS) {
 				retval = sd_init_power(chip);
-				if (retval != STATUS_SUCCESS) {
+				if (retval != STATUS_SUCCESS)
 					return STATUS_FAIL;
-				}
 				sd_card->mmc_dont_switch_bus = 1;
 				goto switch_fail;
 			}
 		}
 
-		if (CHK_MMC_SECTOR_MODE(sd_card) && (sd_card->capacity == 0)) {
+		if (CHK_MMC_SECTOR_MODE(sd_card) && (sd_card->capacity == 0))
 			return STATUS_FAIL;
-		}
 
 		if (switch_ddr && CHK_MMC_DDR52(sd_card)) {
 			retval = sd_set_init_para(chip);
-			if (retval != STATUS_SUCCESS) {
+			if (retval != STATUS_SUCCESS)
 				return STATUS_FAIL;
-			}
 
 			retval = mmc_ddr_tuning(chip);
 			if (retval != STATUS_SUCCESS) {
 				retval = sd_init_power(chip);
-				if (retval != STATUS_SUCCESS) {
+				if (retval != STATUS_SUCCESS)
 					return STATUS_FAIL;
-				}
 
 				switch_ddr = false;
 				goto switch_fail;
@@ -3170,9 +3031,8 @@ static int reset_mmc(struct rtsx_chip *chip)
 				retval = sd_read_lba0(chip);
 				if (retval != STATUS_SUCCESS) {
 					retval = sd_init_power(chip);
-					if (retval != STATUS_SUCCESS) {
+					if (retval != STATUS_SUCCESS)
 						return STATUS_FAIL;
-					}
 
 					switch_ddr = false;
 					goto switch_fail;
@@ -3185,14 +3045,12 @@ static int reset_mmc(struct rtsx_chip *chip)
 	if (sd_card->sd_lock_status & SD_UNLOCK_POW_ON) {
 		retval = rtsx_write_register(chip, REG_SD_BLOCK_CNT_H, 0xFF,
 					     0x02);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 		retval = rtsx_write_register(chip, REG_SD_BLOCK_CNT_L, 0xFF,
 					     0x00);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 	}
 #endif
 
@@ -3214,88 +3072,74 @@ int reset_sd_card(struct rtsx_chip *chip)
 	chip->capacity[chip->card2lun[SD_CARD]] = 0;
 
 	retval = enable_card_clock(chip, SD_CARD);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	if (chip->ignore_sd && CHK_SDIO_EXIST(chip) &&
 	    !CHK_SDIO_IGNORED(chip)) {
 		if (chip->asic_code) {
 			retval = sd_pull_ctl_enable(chip);
-			if (retval != STATUS_SUCCESS) {
+			if (retval != STATUS_SUCCESS)
 				return STATUS_FAIL;
-			}
 		} else {
 			retval = rtsx_write_register(chip, FPGA_PULL_CTL,
 						     FPGA_SD_PULL_CTL_BIT |
 						     0x20, 0);
-			if (retval != STATUS_SUCCESS) {
+			if (retval != STATUS_SUCCESS)
 				return STATUS_FAIL;
-			}
 		}
 		retval = card_share_mode(chip, SD_CARD);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 
 		chip->sd_io = 1;
 		return STATUS_FAIL;
 	}
 
 	retval = sd_init_power(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	if (chip->sd_ctl & RESET_MMC_FIRST) {
 		retval = reset_mmc(chip);
 		if (retval != STATUS_SUCCESS) {
-			if (sd_check_err_code(chip, SD_NO_CARD)) {
+			if (sd_check_err_code(chip, SD_NO_CARD))
 				return STATUS_FAIL;
-			}
 
 			retval = reset_sd(chip);
-			if (retval != STATUS_SUCCESS) {
+			if (retval != STATUS_SUCCESS)
 				return STATUS_FAIL;
-			}
 		}
 	} else {
 		retval = reset_sd(chip);
 		if (retval != STATUS_SUCCESS) {
-			if (sd_check_err_code(chip, SD_NO_CARD)) {
+			if (sd_check_err_code(chip, SD_NO_CARD))
 				return STATUS_FAIL;
-			}
 
-			if (chip->sd_io) {
+			if (chip->sd_io)
 				return STATUS_FAIL;
-			}
 			retval = reset_mmc(chip);
-			if (retval != STATUS_SUCCESS) {
+			if (retval != STATUS_SUCCESS)
 				return STATUS_FAIL;
-			}
 		}
 	}
 
 	retval = sd_set_clock_divider(chip, SD_CLK_DIVIDE_0);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	retval = rtsx_write_register(chip, REG_SD_BYTE_CNT_L, 0xFF, 0);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 	retval = rtsx_write_register(chip, REG_SD_BYTE_CNT_H, 0xFF, 2);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	chip->capacity[chip->card2lun[SD_CARD]] = sd_card->capacity;
 
 	retval = sd_set_init_para(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	dev_dbg(rtsx_dev(chip), "sd_card->sd_type = 0x%x\n", sd_card->sd_type);
 
@@ -3321,40 +3165,33 @@ static int reset_mmc_only(struct rtsx_chip *chip)
 	chip->capacity[chip->card2lun[SD_CARD]] = sd_card->capacity = 0;
 
 	retval = enable_card_clock(chip, SD_CARD);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	retval = sd_init_power(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	retval = reset_mmc(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	retval = sd_set_clock_divider(chip, SD_CLK_DIVIDE_0);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	retval = rtsx_write_register(chip, REG_SD_BYTE_CNT_L, 0xFF, 0);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 	retval = rtsx_write_register(chip, REG_SD_BYTE_CNT_H, 0xFF, 2);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	chip->capacity[chip->card2lun[SD_CARD]] = sd_card->capacity;
 
 	retval = sd_set_init_para(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	dev_dbg(rtsx_dev(chip), "In %s, sd_card->sd_type = 0x%x\n",
 		__func__, sd_card->sd_type);
@@ -3380,9 +3217,8 @@ static int wait_data_buf_ready(struct rtsx_chip *chip)
 		retval = sd_send_cmd_get_rsp(chip, SEND_STATUS,
 					     sd_card->sd_addr, SD_RSP_TYPE_R1,
 					     NULL, 0);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 
 		if (sd_card->sd_data_buf_ready) {
 			return sd_send_cmd_get_rsp(chip, SEND_STATUS,
@@ -3460,9 +3296,8 @@ static inline int sd_auto_tune_clock(struct rtsx_chip *chip)
 	}
 
 	retval = sd_switch_clock(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -3819,9 +3654,8 @@ int ext_sd_send_cmd_get_rsp(struct rtsx_chip *chip, u8 cmd_idx, u32 arg,
 
 			if (rsp_type & SD_WAIT_BUSY_END) {
 				retval = sd_check_data0_status(chip);
-				if (retval != STATUS_SUCCESS) {
+				if (retval != STATUS_SUCCESS)
 					return retval;
-				}
 			} else {
 				sd_set_err_code(chip, SD_TO_ERR);
 			}
@@ -3859,9 +3693,8 @@ int ext_sd_send_cmd_get_rsp(struct rtsx_chip *chip, u8 cmd_idx, u32 arg,
 	if ((cmd_idx == SELECT_CARD) || (cmd_idx == APP_CMD) ||
 	    (cmd_idx == SEND_STATUS) || (cmd_idx == STOP_TRANSMISSION)) {
 		if ((cmd_idx != STOP_TRANSMISSION) && !special_check) {
-			if (ptr[1] & 0x80) {
+			if (ptr[1] & 0x80)
 				return STATUS_FAIL;
-			}
 		}
 #ifdef SUPPORT_SD_LOCK
 		if (ptr[1] & 0x7D) {
@@ -3870,15 +3703,13 @@ int ext_sd_send_cmd_get_rsp(struct rtsx_chip *chip, u8 cmd_idx, u32 arg,
 #endif
 			return STATUS_FAIL;
 		}
-		if (ptr[2] & 0xF8) {
+		if (ptr[2] & 0xF8)
 			return STATUS_FAIL;
-		}
 
 		if (cmd_idx == SELECT_CARD) {
 			if (rsp_type == SD_RSP_TYPE_R2) {
-				if ((ptr[3] & 0x1E) != 0x04) {
+				if ((ptr[3] & 0x1E) != 0x04)
 					return STATUS_FAIL;
-				}
 			}
 		}
 	}
@@ -3915,9 +3746,8 @@ int ext_sd_get_rsp(struct rtsx_chip *chip, int len, u8 *rsp, u8 rsp_type)
 	rtsx_add_cmd(chip, READ_REG_CMD, REG_SD_CMD5, 0xFF, 0);
 
 	retval = rtsx_send_cmd(chip, SD_CARD, 100);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	if (rsp) {
 		int min_len = (rsp_len < len) ? rsp_len : len;
@@ -4057,9 +3887,8 @@ int sd_execute_no_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	}
 
 	retval = sd_switch_clock(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return TRANSPORT_FAILED;
-	}
 
 	if (sd_card->pre_cmd_err) {
 		sd_card->pre_cmd_err = 0;
@@ -4085,39 +3914,34 @@ int sd_execute_no_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	sd_card->last_rsp_type = rsp_type;
 
 	retval = sd_switch_clock(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return TRANSPORT_FAILED;
-	}
 
 #ifdef SUPPORT_SD_LOCK
 	if ((sd_card->sd_lock_status & SD_LOCK_1BIT_MODE) == 0) {
 		if (CHK_MMC_8BIT(sd_card)) {
 			retval = rtsx_write_register(chip, REG_SD_CFG1, 0x03,
 						     SD_BUS_WIDTH_8);
-			if (retval != STATUS_SUCCESS) {
+			if (retval != STATUS_SUCCESS)
 				return TRANSPORT_FAILED;
-			}
 
 		} else if (CHK_SD(sd_card) || CHK_MMC_4BIT(sd_card)) {
 			retval = rtsx_write_register(chip, REG_SD_CFG1, 0x03,
 						     SD_BUS_WIDTH_4);
-			if (retval != STATUS_SUCCESS) {
+			if (retval != STATUS_SUCCESS)
 				return TRANSPORT_FAILED;
-			}
 		}
 	}
 #else
 	retval = rtsx_write_register(chip, REG_SD_CFG1, 0x03, SD_BUS_WIDTH_4);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return TRANSPORT_FAILED;
-	}
 #endif
 
 	if (standby) {
 		retval = sd_select_card(chip, 0);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			goto sd_execute_cmd_failed;
-		}
 	}
 
 	if (acmd) {
@@ -4125,29 +3949,25 @@ int sd_execute_no_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 						 sd_card->sd_addr,
 						 SD_RSP_TYPE_R1, NULL, 0,
 						 false);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			goto sd_execute_cmd_failed;
-		}
 	}
 
 	retval = ext_sd_send_cmd_get_rsp(chip, cmd_idx, arg, rsp_type,
 					 sd_card->rsp, rsp_len, false);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		goto sd_execute_cmd_failed;
-	}
 
 	if (standby) {
 		retval = sd_select_card(chip, 1);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			goto sd_execute_cmd_failed;
-		}
 	}
 
 #ifdef SUPPORT_SD_LOCK
 	retval = sd_update_lock_status(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		goto sd_execute_cmd_failed;
-	}
 #endif
 
 	scsi_set_resid(srb, 0);
@@ -4186,9 +4006,8 @@ int sd_execute_read_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	}
 
 	retval = sd_switch_clock(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return TRANSPORT_FAILED;
-	}
 
 	cmd_idx = srb->cmnd[2] & 0x3F;
 	if (srb->cmnd[1] & 0x04)
@@ -4211,9 +4030,8 @@ int sd_execute_read_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	sd_card->last_rsp_type = rsp_type;
 
 	retval = sd_switch_clock(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return TRANSPORT_FAILED;
-	}
 
 #ifdef SUPPORT_SD_LOCK
 	if ((sd_card->sd_lock_status & SD_LOCK_1BIT_MODE) == 0) {
@@ -4235,16 +4053,14 @@ int sd_execute_read_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 		retval = ext_sd_send_cmd_get_rsp(chip, SET_BLOCKLEN, data_len,
 						 SD_RSP_TYPE_R1, NULL, 0,
 						 false);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			goto sd_execute_read_cmd_failed;
-		}
 	}
 
 	if (standby) {
 		retval = sd_select_card(chip, 0);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			goto sd_execute_read_cmd_failed;
-		}
 	}
 
 	if (acmd) {
@@ -4252,9 +4068,8 @@ int sd_execute_read_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 						 sd_card->sd_addr,
 						 SD_RSP_TYPE_R1, NULL, 0,
 						 false);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			goto sd_execute_read_cmd_failed;
-		}
 	}
 
 	if (data_len <= 512) {
@@ -4273,9 +4088,8 @@ int sd_execute_read_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 		cmd[4] = srb->cmnd[6];
 
 		buf = kmalloc(data_len, GFP_KERNEL);
-		if (!buf) {
+		if (!buf)
 			return TRANSPORT_ERROR;
-		}
 
 		retval = sd_read_data(chip, SD_TM_NORMAL_READ, cmd, 5, byte_cnt,
 				      blk_cnt, bus_width, buf, data_len, 2000);
@@ -4340,43 +4154,37 @@ int sd_execute_read_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	}
 
 	retval = ext_sd_get_rsp(chip, rsp_len, sd_card->rsp, rsp_type);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		goto sd_execute_read_cmd_failed;
-	}
 
 	if (standby) {
 		retval = sd_select_card(chip, 1);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			goto sd_execute_read_cmd_failed;
-		}
 	}
 
 	if (send_cmd12) {
 		retval = ext_sd_send_cmd_get_rsp(chip, STOP_TRANSMISSION, 0,
 						 SD_RSP_TYPE_R1b, NULL, 0,
 						 false);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			goto sd_execute_read_cmd_failed;
-		}
 	}
 
 	if (data_len < 512) {
 		retval = ext_sd_send_cmd_get_rsp(chip, SET_BLOCKLEN, 0x200,
 						 SD_RSP_TYPE_R1, NULL, 0,
 						 false);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			goto sd_execute_read_cmd_failed;
-		}
 
 		retval = rtsx_write_register(chip, SD_BYTE_CNT_H, 0xFF, 0x02);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			goto sd_execute_read_cmd_failed;
-		}
 
 		retval = rtsx_write_register(chip, SD_BYTE_CNT_L, 0xFF, 0x00);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			goto sd_execute_read_cmd_failed;
-		}
 	}
 
 	if ((srb->cmnd[1] & 0x02) || (srb->cmnd[1] & 0x04))
@@ -4390,9 +4198,8 @@ int sd_execute_read_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 		if (retval == STATUS_SUCCESS)
 			break;
 	}
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		goto sd_execute_read_cmd_failed;
-	}
 
 	scsi_set_resid(srb, 0);
 	return TRANSPORT_GOOD;
@@ -4438,9 +4245,8 @@ int sd_execute_write_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	}
 
 	retval = sd_switch_clock(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return TRANSPORT_FAILED;
-	}
 
 	cmd_idx = srb->cmnd[2] & 0x3F;
 	if (srb->cmnd[1] & 0x04)
@@ -4472,48 +4278,42 @@ int sd_execute_write_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	sd_card->last_rsp_type = rsp_type;
 
 	retval = sd_switch_clock(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return TRANSPORT_FAILED;
-	}
 
 #ifdef SUPPORT_SD_LOCK
 	if ((sd_card->sd_lock_status & SD_LOCK_1BIT_MODE) == 0) {
 		if (CHK_MMC_8BIT(sd_card)) {
 			retval = rtsx_write_register(chip, REG_SD_CFG1, 0x03,
 						     SD_BUS_WIDTH_8);
-			if (retval != STATUS_SUCCESS) {
+			if (retval != STATUS_SUCCESS)
 				return TRANSPORT_FAILED;
-			}
 
 		} else if (CHK_SD(sd_card) || CHK_MMC_4BIT(sd_card)) {
 			retval = rtsx_write_register(chip, REG_SD_CFG1, 0x03,
 						     SD_BUS_WIDTH_4);
-			if (retval != STATUS_SUCCESS) {
+			if (retval != STATUS_SUCCESS)
 				return TRANSPORT_FAILED;
-			}
 		}
 	}
 #else
 	retval = rtsx_write_register(chip, REG_SD_CFG1, 0x03, SD_BUS_WIDTH_4);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return TRANSPORT_FAILED;
-	}
 #endif
 
 	if (data_len < 512) {
 		retval = ext_sd_send_cmd_get_rsp(chip, SET_BLOCKLEN, data_len,
 						 SD_RSP_TYPE_R1, NULL, 0,
 						 false);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			goto sd_execute_write_cmd_failed;
-		}
 	}
 
 	if (standby) {
 		retval = sd_select_card(chip, 0);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			goto sd_execute_write_cmd_failed;
-		}
 	}
 
 	if (acmd) {
@@ -4521,25 +4321,22 @@ int sd_execute_write_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 						 sd_card->sd_addr,
 						 SD_RSP_TYPE_R1, NULL, 0,
 						 false);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			goto sd_execute_write_cmd_failed;
-		}
 	}
 
 	retval = ext_sd_send_cmd_get_rsp(chip, cmd_idx, arg, rsp_type,
 					 sd_card->rsp, rsp_len, false);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		goto sd_execute_write_cmd_failed;
-	}
 
 	if (data_len <= 512) {
 		u16 i;
 		u8 *buf;
 
 		buf = kmalloc(data_len, GFP_KERNEL);
-		if (!buf) {
+		if (!buf)
 			return TRANSPORT_ERROR;
-		}
 
 		rtsx_stor_get_xfer_buf(buf, data_len, srb);
 
@@ -4663,37 +4460,32 @@ int sd_execute_write_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 	if (standby) {
 		retval = sd_select_card(chip, 1);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			goto sd_execute_write_cmd_failed;
-		}
 	}
 
 	if (send_cmd12) {
 		retval = ext_sd_send_cmd_get_rsp(chip, STOP_TRANSMISSION, 0,
 						 SD_RSP_TYPE_R1b, NULL, 0,
 						 false);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			goto sd_execute_write_cmd_failed;
-		}
 	}
 
 	if (data_len < 512) {
 		retval = ext_sd_send_cmd_get_rsp(chip, SET_BLOCKLEN, 0x200,
 						 SD_RSP_TYPE_R1, NULL, 0,
 						 false);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			goto sd_execute_write_cmd_failed;
-		}
 
 		retval = rtsx_write_register(chip, SD_BYTE_CNT_H, 0xFF, 0x02);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			goto sd_execute_write_cmd_failed;
-		}
 
 		retval = rtsx_write_register(chip, SD_BYTE_CNT_L, 0xFF, 0x00);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			goto sd_execute_write_cmd_failed;
-		}
 	}
 
 	if ((srb->cmnd[1] & 0x02) || (srb->cmnd[1] & 0x04))
@@ -4707,9 +4499,8 @@ int sd_execute_write_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 		if (retval == STATUS_SUCCESS)
 			break;
 	}
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		goto sd_execute_write_cmd_failed;
-	}
 
 #ifdef SUPPORT_SD_LOCK
 	if (cmd_idx == LOCK_UNLOCK) {
@@ -4888,36 +4679,31 @@ int sd_power_off_card3v3(struct rtsx_chip *chip)
 	int retval;
 
 	retval = disable_card_clock(chip, SD_CARD);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	retval = rtsx_write_register(chip, CARD_OE, SD_OUTPUT_EN, 0);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	if (!chip->ft2_fast_mode) {
 		retval = card_power_off(chip, SD_CARD);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 
 		mdelay(50);
 	}
 
 	if (chip->asic_code) {
 		retval = sd_pull_ctl_disable(chip);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 	} else {
 		retval = rtsx_write_register(chip, FPGA_PULL_CTL,
 					     FPGA_SD_PULL_CTL_BIT | 0x20,
 					     FPGA_SD_PULL_CTL_BIT);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 	}
 
 	return STATUS_SUCCESS;
@@ -4944,9 +4730,8 @@ int release_sd_card(struct rtsx_chip *chip)
 	memset(sd_card->raw_scr, 0, 8);
 
 	retval = sd_power_off_card3v3(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	return STATUS_SUCCESS;
 }
diff --git a/drivers/staging/rts5208/spi.c b/drivers/staging/rts5208/spi.c
index 4675668ad977..110cb9093f30 100644
--- a/drivers/staging/rts5208/spi.c
+++ b/drivers/staging/rts5208/spi.c
@@ -41,14 +41,12 @@ static int spi_init(struct rtsx_chip *chip)
 	retval = rtsx_write_register(chip, SPI_CONTROL, 0xFF,
 				     CS_POLARITY_LOW | DTO_MSB_FIRST
 				     | SPI_MASTER | SPI_MODE0 | SPI_AUTO);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 	retval = rtsx_write_register(chip, SPI_TCTL, EDO_TIMING_MASK,
 				     SAMPLE_DELAY_HALF);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -60,42 +58,35 @@ static int spi_set_init_para(struct rtsx_chip *chip)
 
 	retval = rtsx_write_register(chip, SPI_CLK_DIVIDER1, 0xFF,
 				     (u8)(spi->clk_div >> 8));
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 	retval = rtsx_write_register(chip, SPI_CLK_DIVIDER0, 0xFF,
 				     (u8)(spi->clk_div));
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	retval = switch_clock(chip, spi->spi_clock);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	retval = select_card(chip, SPI_CARD);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	retval = rtsx_write_register(chip, CARD_CLK_EN, SPI_CLK_EN,
 				     SPI_CLK_EN);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 	retval = rtsx_write_register(chip, CARD_OE, SPI_OUTPUT_EN,
 				     SPI_OUTPUT_EN);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	wait_timeout(10);
 
 	retval = spi_init(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -247,47 +238,39 @@ static int spi_init_eeprom(struct rtsx_chip *chip)
 		clk = CLK_30;
 
 	retval = rtsx_write_register(chip, SPI_CLK_DIVIDER1, 0xFF, 0x00);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 	retval = rtsx_write_register(chip, SPI_CLK_DIVIDER0, 0xFF, 0x27);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	retval = switch_clock(chip, clk);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	retval = select_card(chip, SPI_CARD);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	retval = rtsx_write_register(chip, CARD_CLK_EN, SPI_CLK_EN,
 				     SPI_CLK_EN);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 	retval = rtsx_write_register(chip, CARD_OE, SPI_OUTPUT_EN,
 				     SPI_OUTPUT_EN);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	wait_timeout(10);
 
 	retval = rtsx_write_register(chip, SPI_CONTROL, 0xFF,
 				     CS_POLARITY_HIGH | SPI_EEPROM_AUTO);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 	retval = rtsx_write_register(chip, SPI_TCTL, EDO_TIMING_MASK,
 				     SAMPLE_DELAY_HALF);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -306,9 +289,8 @@ static int spi_eeprom_program_enable(struct rtsx_chip *chip)
 		     SPI_TRANSFER0_END);
 
 	retval = rtsx_send_cmd(chip, 0, 100);
-	if (retval < 0) {
+	if (retval < 0)
 		return STATUS_FAIL;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -318,14 +300,12 @@ int spi_erase_eeprom_chip(struct rtsx_chip *chip)
 	int retval;
 
 	retval = spi_init_eeprom(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	retval = spi_eeprom_program_enable(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	rtsx_init_cmd(chip);
 
@@ -339,14 +319,12 @@ int spi_erase_eeprom_chip(struct rtsx_chip *chip)
 		     SPI_TRANSFER0_END);
 
 	retval = rtsx_send_cmd(chip, 0, 100);
-	if (retval < 0) {
+	if (retval < 0)
 		return STATUS_FAIL;
-	}
 
 	retval = rtsx_write_register(chip, CARD_GPIO_DIR, 0x01, 0x01);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -356,14 +334,12 @@ int spi_erase_eeprom_byte(struct rtsx_chip *chip, u16 addr)
 	int retval;
 
 	retval = spi_init_eeprom(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	retval = spi_eeprom_program_enable(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	rtsx_init_cmd(chip);
 
@@ -379,14 +355,12 @@ int spi_erase_eeprom_byte(struct rtsx_chip *chip, u16 addr)
 		     SPI_TRANSFER0_END);
 
 	retval = rtsx_send_cmd(chip, 0, 100);
-	if (retval < 0) {
+	if (retval < 0)
 		return STATUS_FAIL;
-	}
 
 	retval = rtsx_write_register(chip, CARD_GPIO_DIR, 0x01, 0x01);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -397,9 +371,8 @@ int spi_read_eeprom(struct rtsx_chip *chip, u16 addr, u8 *val)
 	u8 data;
 
 	retval = spi_init_eeprom(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	rtsx_init_cmd(chip);
 
@@ -416,23 +389,20 @@ int spi_read_eeprom(struct rtsx_chip *chip, u16 addr, u8 *val)
 		     SPI_TRANSFER0_END);
 
 	retval = rtsx_send_cmd(chip, 0, 100);
-	if (retval < 0) {
+	if (retval < 0)
 		return STATUS_FAIL;
-	}
 
 	wait_timeout(5);
 	retval = rtsx_read_register(chip, SPI_DATA, &data);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	if (val)
 		*val = data;
 
 	retval = rtsx_write_register(chip, CARD_GPIO_DIR, 0x01, 0x01);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -442,14 +412,12 @@ int spi_write_eeprom(struct rtsx_chip *chip, u16 addr, u8 val)
 	int retval;
 
 	retval = spi_init_eeprom(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	retval = spi_eeprom_program_enable(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	rtsx_init_cmd(chip);
 
@@ -466,14 +434,12 @@ int spi_write_eeprom(struct rtsx_chip *chip, u16 addr, u8 val)
 		     SPI_TRANSFER0_END);
 
 	retval = rtsx_send_cmd(chip, 0, 100);
-	if (retval < 0) {
+	if (retval < 0)
 		return STATUS_FAIL;
-	}
 
 	retval = rtsx_write_register(chip, CARD_GPIO_DIR, 0x01, 0x01);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -577,9 +543,8 @@ int spi_read_flash_id(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 	if (len) {
 		buf = kmalloc(len, GFP_KERNEL);
-		if (!buf) {
+		if (!buf)
 			return STATUS_ERROR;
-		}
 
 		retval = rtsx_read_ppbuf(chip, buf, len);
 		if (retval != STATUS_SUCCESS) {
@@ -621,9 +586,8 @@ int spi_read_flash(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	}
 
 	buf = kmalloc(SF_PAGE_LEN, GFP_KERNEL);
-	if (!buf) {
+	if (!buf)
 		return STATUS_ERROR;
-	}
 
 	while (len) {
 		u16 pagelen = SF_PAGE_LEN - (u8)addr;
@@ -716,9 +680,8 @@ int spi_write_flash(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 	if (program_mode == BYTE_PROGRAM) {
 		buf = kmalloc(4, GFP_KERNEL);
-		if (!buf) {
+		if (!buf)
 			return STATUS_ERROR;
-		}
 
 		while (len) {
 			retval = sf_enable_write(chip, SPI_WREN);
@@ -762,14 +725,12 @@ int spi_write_flash(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 		int first_byte = 1;
 
 		retval = sf_enable_write(chip, SPI_WREN);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 
 		buf = kmalloc(4, GFP_KERNEL);
-		if (!buf) {
+		if (!buf)
 			return STATUS_ERROR;
-		}
 
 		while (len) {
 			rtsx_stor_access_xfer_buf(buf, 1, srb, &index, &offset,
@@ -808,19 +769,16 @@ int spi_write_flash(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 		kfree(buf);
 
 		retval = sf_disable_write(chip, SPI_WRDI);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 
 		retval = sf_polling_status(chip, 100);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 	} else if (program_mode == PAGE_PROGRAM) {
 		buf = kmalloc(SF_PAGE_LEN, GFP_KERNEL);
-		if (!buf) {
+		if (!buf)
 			return STATUS_NOMEM;
-		}
 
 		while (len) {
 			u16 pagelen = SF_PAGE_LEN - (u8)addr;
@@ -893,24 +851,20 @@ int spi_erase_flash(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 	if (erase_mode == PAGE_ERASE) {
 		retval = sf_enable_write(chip, SPI_WREN);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 
 		retval = sf_erase(chip, ins, 1, addr);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 	} else if (erase_mode == CHIP_ERASE) {
 		retval = sf_enable_write(chip, SPI_WREN);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 
 		retval = sf_erase(chip, ins, 0, 0);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 	} else {
 		spi_set_err_code(chip, SPI_INVALID_COMMAND);
 		return STATUS_FAIL;
@@ -935,9 +889,8 @@ int spi_write_flash_status(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	}
 
 	retval = sf_enable_write(chip, ewsr);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	rtsx_init_cmd(chip);
 
diff --git a/drivers/staging/rts5208/xd.c b/drivers/staging/rts5208/xd.c
index 261d868a3072..d71f19ceb6fa 100644
--- a/drivers/staging/rts5208/xd.c
+++ b/drivers/staging/rts5208/xd.c
@@ -60,9 +60,8 @@ static int xd_set_init_para(struct rtsx_chip *chip)
 		xd_card->xd_clock = CLK_50;
 
 	retval = switch_clock(chip, xd_card->xd_clock);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -73,14 +72,12 @@ static int xd_switch_clock(struct rtsx_chip *chip)
 	int retval;
 
 	retval = select_card(chip, XD_CARD);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	retval = switch_clock(chip, xd_card->xd_clock);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -102,9 +99,8 @@ static int xd_read_id(struct rtsx_chip *chip, u8 id_cmd, u8 *id_buf, u8 buf_len)
 		rtsx_add_cmd(chip, READ_REG_CMD, (u16)(XD_ADDRESS1 + i), 0, 0);
 
 	retval = rtsx_send_cmd(chip, XD_CARD, 20);
-	if (retval < 0) {
+	if (retval < 0)
 		return STATUS_FAIL;
-	}
 
 	ptr = rtsx_get_cmd_data(chip) + 1;
 	if (id_buf && buf_len) {
@@ -173,9 +169,8 @@ static int xd_read_redundant(struct rtsx_chip *chip, u32 page_addr,
 	rtsx_add_cmd(chip, READ_REG_CMD, XD_PARITY, 0, 0);
 
 	retval = rtsx_send_cmd(chip, XD_CARD, 500);
-	if (retval < 0) {
+	if (retval < 0)
 		return STATUS_FAIL;
-	}
 
 	if (buf && buf_len) {
 		u8 *ptr = rtsx_get_cmd_data(chip) + 1;
@@ -193,9 +188,8 @@ static int xd_read_data_from_ppb(struct rtsx_chip *chip, int offset,
 {
 	int retval, i;
 
-	if (!buf || (buf_len < 0)) {
+	if (!buf || (buf_len < 0))
 		return STATUS_FAIL;
-	}
 
 	rtsx_init_cmd(chip);
 
@@ -220,9 +214,8 @@ static int xd_read_cis(struct rtsx_chip *chip, u32 page_addr, u8 *buf,
 	int retval;
 	u8 reg;
 
-	if (!buf || (buf_len < 10)) {
+	if (!buf || (buf_len < 10))
 		return STATUS_FAIL;
-	}
 
 	rtsx_init_cmd(chip);
 
@@ -246,36 +239,31 @@ static int xd_read_cis(struct rtsx_chip *chip, u32 page_addr, u8 *buf,
 	}
 
 	retval = rtsx_read_register(chip, XD_PAGE_STATUS, &reg);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 	if (reg != XD_GPG) {
 		rtsx_clear_xd_error(chip);
 		return STATUS_FAIL;
 	}
 
 	retval = rtsx_read_register(chip, XD_CTL, &reg);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 	if (!(reg & XD_ECC1_ERROR) || !(reg & XD_ECC1_UNCORRECTABLE)) {
 		retval = xd_read_data_from_ppb(chip, 0, buf, buf_len);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 		if (reg & XD_ECC1_ERROR) {
 			u8 ecc_bit, ecc_byte;
 
 			retval = rtsx_read_register(chip, XD_ECC_BIT1,
 						    &ecc_bit);
-			if (retval) {
+			if (retval)
 				return retval;
-			}
 			retval = rtsx_read_register(chip, XD_ECC_BYTE1,
 						    &ecc_byte);
-			if (retval) {
+			if (retval)
 				return retval;
-			}
 
 			dev_dbg(rtsx_dev(chip), "ECC_BIT1 = 0x%x, ECC_BYTE1 = 0x%x\n",
 				ecc_bit, ecc_byte);
@@ -291,22 +279,19 @@ static int xd_read_cis(struct rtsx_chip *chip, u32 page_addr, u8 *buf,
 		rtsx_clear_xd_error(chip);
 
 		retval = xd_read_data_from_ppb(chip, 256, buf, buf_len);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 		if (reg & XD_ECC2_ERROR) {
 			u8 ecc_bit, ecc_byte;
 
 			retval = rtsx_read_register(chip, XD_ECC_BIT2,
 						    &ecc_bit);
-			if (retval) {
+			if (retval)
 				return retval;
-			}
 			retval = rtsx_read_register(chip, XD_ECC_BYTE2,
 						    &ecc_byte);
-			if (retval) {
+			if (retval)
 				return retval;
-			}
 
 			dev_dbg(rtsx_dev(chip), "ECC_BIT2 = 0x%x, ECC_BYTE2 = 0x%x\n",
 				ecc_bit, ecc_byte);
@@ -404,68 +389,58 @@ static int xd_pull_ctl_disable(struct rtsx_chip *chip)
 					     XD_D2_PD |
 					     XD_D1_PD |
 					     XD_D0_PD);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 		retval = rtsx_write_register(chip, CARD_PULL_CTL2, 0xFF,
 					     XD_D7_PD |
 					     XD_D6_PD |
 					     XD_D5_PD |
 					     XD_D4_PD);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 		retval = rtsx_write_register(chip, CARD_PULL_CTL3, 0xFF,
 					     XD_WP_PD |
 					     XD_CE_PD |
 					     XD_CLE_PD |
 					     XD_CD_PU);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 		retval = rtsx_write_register(chip, CARD_PULL_CTL4, 0xFF,
 					     XD_RDY_PD |
 					     XD_WE_PD |
 					     XD_RE_PD |
 					     XD_ALE_PD);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 		retval = rtsx_write_register(chip, CARD_PULL_CTL5, 0xFF,
 					     MS_INS_PU |
 					     SD_WP_PD |
 					     SD_CD_PU |
 					     SD_CMD_PD);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 		retval = rtsx_write_register(chip, CARD_PULL_CTL6, 0xFF,
 					     MS_D5_PD | MS_D4_PD);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 	} else if (CHECK_PID(chip, 0x5288)) {
 		if (CHECK_BARO_PKG(chip, QFN)) {
 			retval = rtsx_write_register(chip, CARD_PULL_CTL1,
 						     0xFF, 0x55);
-			if (retval) {
+			if (retval)
 				return retval;
-			}
 			retval = rtsx_write_register(chip, CARD_PULL_CTL2,
 						     0xFF, 0x55);
-			if (retval) {
+			if (retval)
 				return retval;
-			}
 			retval = rtsx_write_register(chip, CARD_PULL_CTL3,
 						     0xFF, 0x4B);
-			if (retval) {
+			if (retval)
 				return retval;
-			}
 			retval = rtsx_write_register(chip, CARD_PULL_CTL4,
 						     0xFF, 0x69);
-			if (retval) {
+			if (retval)
 				return retval;
-			}
 		}
 	}
 
@@ -479,9 +454,8 @@ static int reset_xd(struct rtsx_chip *chip)
 	u8 *ptr, id_buf[4], redunt[11];
 
 	retval = select_card(chip, XD_CARD);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	rtsx_init_cmd(chip);
 
@@ -505,15 +479,13 @@ static int reset_xd(struct rtsx_chip *chip)
 	rtsx_add_cmd(chip, WRITE_REG_CMD, CARD_OE, XD_OUTPUT_EN, 0);
 
 	retval = rtsx_send_cmd(chip, XD_CARD, 100);
-	if (retval < 0) {
+	if (retval < 0)
 		return STATUS_FAIL;
-	}
 
 	if (!chip->ft2_fast_mode) {
 		retval = card_power_off(chip, XD_CARD);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 
 		wait_timeout(250);
 
@@ -529,14 +501,12 @@ static int reset_xd(struct rtsx_chip *chip)
 		}
 
 		retval = rtsx_send_cmd(chip, XD_CARD, 100);
-		if (retval < 0) {
+		if (retval < 0)
 			return STATUS_FAIL;
-		}
 
 		retval = card_power_on(chip, XD_CARD);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 
 #ifdef SUPPORT_OCP
 		wait_timeout(50);
@@ -565,17 +535,15 @@ static int reset_xd(struct rtsx_chip *chip)
 	rtsx_add_cmd(chip, WRITE_REG_CMD, XD_CTL, XD_CE_DISEN, XD_CE_DISEN);
 
 	retval = rtsx_send_cmd(chip, XD_CARD, 100);
-	if (retval < 0) {
+	if (retval < 0)
 		return STATUS_FAIL;
-	}
 
 	if (!chip->ft2_fast_mode)
 		wait_timeout(200);
 
 	retval = xd_set_init_para(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	/* Read ID to check if the timing setting is right */
 	for (i = 0; i < 4; i++) {
@@ -598,9 +566,8 @@ static int reset_xd(struct rtsx_chip *chip)
 		rtsx_add_cmd(chip, READ_REG_CMD, XD_CTL, 0, 0);
 
 		retval = rtsx_send_cmd(chip, XD_CARD, 100);
-		if (retval < 0) {
+		if (retval < 0)
 			return STATUS_FAIL;
-		}
 
 		ptr = rtsx_get_cmd_data(chip) + 1;
 
@@ -612,9 +579,8 @@ static int reset_xd(struct rtsx_chip *chip)
 			continue;
 
 		retval = xd_read_id(chip, READ_ID, id_buf, 4);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 
 		dev_dbg(rtsx_dev(chip), "READ_ID: 0x%x 0x%x 0x%x 0x%x\n",
 			id_buf[0], id_buf[1], id_buf[2], id_buf[3]);
@@ -694,9 +660,8 @@ static int reset_xd(struct rtsx_chip *chip)
 		/* Confirm timing setting */
 		for (j = 0; j < 10; j++) {
 			retval = xd_read_id(chip, READ_ID, id_buf, 4);
-			if (retval != STATUS_SUCCESS) {
+			if (retval != STATUS_SUCCESS)
 				return STATUS_FAIL;
-			}
 
 			if (id_buf[1] != xd_card->device_code)
 				break;
@@ -716,22 +681,19 @@ static int reset_xd(struct rtsx_chip *chip)
 	}
 
 	retval = xd_read_id(chip, READ_xD_ID, id_buf, 4);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 	dev_dbg(rtsx_dev(chip), "READ_xD_ID: 0x%x 0x%x 0x%x 0x%x\n",
 		id_buf[0], id_buf[1], id_buf[2], id_buf[3]);
-	if (id_buf[2] != XD_ID_CODE) {
+	if (id_buf[2] != XD_ID_CODE)
 		return STATUS_FAIL;
-	}
 
 	/* Search CIS block */
 	for (i = 0; i < 24; i++) {
 		u32 page_addr;
 
-		if (detect_card_cd(chip, XD_CARD) != STATUS_SUCCESS) {
+		if (detect_card_cd(chip, XD_CARD) != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 
 		page_addr = (u32)i << xd_card->block_shift;
 
@@ -769,9 +731,8 @@ static int reset_xd(struct rtsx_chip *chip)
 			page_addr += j;
 
 			retval = xd_read_cis(chip, page_addr, buf, 10);
-			if (retval != STATUS_SUCCESS) {
+			if (retval != STATUS_SUCCESS)
 				return STATUS_FAIL;
-			}
 
 			if ((buf[0] == 0x01) && (buf[1] == 0x03) &&
 			    (buf[2] == 0xD9) &&
@@ -841,17 +802,15 @@ static int xd_init_l2p_tbl(struct rtsx_chip *chip)
 	dev_dbg(rtsx_dev(chip), "%s: zone_cnt = %d\n", __func__,
 		xd_card->zone_cnt);
 
-	if (xd_card->zone_cnt < 1) {
+	if (xd_card->zone_cnt < 1)
 		return STATUS_FAIL;
-	}
 
 	size = xd_card->zone_cnt * sizeof(struct zone_entry);
 	dev_dbg(rtsx_dev(chip), "Buffer size for l2p table is %d\n", size);
 
 	xd_card->zone = vmalloc(size);
-	if (!xd_card->zone) {
+	if (!xd_card->zone)
 		return STATUS_ERROR;
-	}
 
 	for (i = 0; i < xd_card->zone_cnt; i++) {
 		xd_card->zone[i].build_flag = 0;
@@ -1028,19 +987,16 @@ int reset_xd_card(struct rtsx_chip *chip)
 	xd_card->delay_write.delay_write_flag = 0;
 
 	retval = enable_card_clock(chip, XD_CARD);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	retval = reset_xd(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	retval = xd_init_l2p_tbl(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -1054,9 +1010,8 @@ static int xd_mark_bad_block(struct rtsx_chip *chip, u32 phy_blk)
 
 	dev_dbg(rtsx_dev(chip), "mark block 0x%x as bad block\n", phy_blk);
 
-	if (phy_blk == BLK_NOT_FOUND) {
+	if (phy_blk == BLK_NOT_FOUND)
 		return STATUS_FAIL;
-	}
 
 	rtsx_init_cmd(chip);
 
@@ -1107,12 +1062,10 @@ static int xd_init_page(struct rtsx_chip *chip, u32 phy_blk,
 
 	dev_dbg(rtsx_dev(chip), "Init block 0x%x\n", phy_blk);
 
-	if (start_page > end_page) {
+	if (start_page > end_page)
 		return STATUS_FAIL;
-	}
-	if (phy_blk == BLK_NOT_FOUND) {
+	if (phy_blk == BLK_NOT_FOUND)
 		return STATUS_FAIL;
-	}
 
 	rtsx_init_cmd(chip);
 
@@ -1164,13 +1117,11 @@ static int xd_copy_page(struct rtsx_chip *chip, u32 old_blk, u32 new_blk,
 	dev_dbg(rtsx_dev(chip), "Copy page from block 0x%x to block 0x%x\n",
 		old_blk, new_blk);
 
-	if (start_page > end_page) {
+	if (start_page > end_page)
 		return STATUS_FAIL;
-	}
 
-	if ((old_blk == BLK_NOT_FOUND) || (new_blk == BLK_NOT_FOUND)) {
+	if ((old_blk == BLK_NOT_FOUND) || (new_blk == BLK_NOT_FOUND))
 		return STATUS_FAIL;
-	}
 
 	old_page = (old_blk << xd_card->block_shift) + start_page;
 	new_page = (new_blk << xd_card->block_shift) + start_page;
@@ -1179,9 +1130,8 @@ static int xd_copy_page(struct rtsx_chip *chip, u32 old_blk, u32 new_blk,
 
 	retval = rtsx_write_register(chip, CARD_DATA_SOURCE, 0x01,
 				     PINGPONG_BUFFER);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	for (i = start_page; i < end_page; i++) {
 		if (detect_card_cd(chip, XD_CARD) != STATUS_SUCCESS) {
@@ -1287,9 +1237,8 @@ static int xd_reset_cmd(struct rtsx_chip *chip)
 	rtsx_add_cmd(chip, READ_REG_CMD, XD_CTL, 0, 0);
 
 	retval = rtsx_send_cmd(chip, XD_CARD, 100);
-	if (retval < 0) {
+	if (retval < 0)
 		return STATUS_FAIL;
-	}
 
 	ptr = rtsx_get_cmd_data(chip) + 1;
 	if (((ptr[0] & READY_FLAG) == READY_STATE) && (ptr[1] & XD_RDY))
@@ -1305,9 +1254,8 @@ static int xd_erase_block(struct rtsx_chip *chip, u32 phy_blk)
 	u8 reg = 0, *ptr;
 	int i, retval;
 
-	if (phy_blk == BLK_NOT_FOUND) {
+	if (phy_blk == BLK_NOT_FOUND)
 		return STATUS_FAIL;
-	}
 
 	page_addr = phy_blk << xd_card->block_shift;
 
@@ -1333,9 +1281,8 @@ static int xd_erase_block(struct rtsx_chip *chip, u32 phy_blk)
 			}
 			xd_set_err_code(chip, XD_ERASE_FAIL);
 			retval = xd_reset_cmd(chip);
-			if (retval != STATUS_SUCCESS) {
+			if (retval != STATUS_SUCCESS)
 				return STATUS_FAIL;
-			}
 			continue;
 		}
 
@@ -1382,17 +1329,15 @@ static int xd_build_l2p_tbl(struct rtsx_chip *chip, int zone_no)
 
 	if (!zone->l2p_table) {
 		zone->l2p_table = vmalloc(2000);
-		if (!zone->l2p_table) {
+		if (!zone->l2p_table)
 			goto build_fail;
-		}
 	}
 	memset((u8 *)(zone->l2p_table), 0xff, 2000);
 
 	if (!zone->free_table) {
 		zone->free_table = vmalloc(XD_FREE_TABLE_CNT * 2);
-		if (!zone->free_table) {
+		if (!zone->free_table)
 			goto build_fail;
-		}
 	}
 	memset((u8 *)(zone->free_table), 0xff, XD_FREE_TABLE_CNT * 2);
 
@@ -1555,9 +1500,8 @@ static int xd_send_cmd(struct rtsx_chip *chip, u8 cmd)
 		     XD_TRANSFER_END, XD_TRANSFER_END);
 
 	retval = rtsx_send_cmd(chip, XD_CARD, 200);
-	if (retval < 0) {
+	if (retval < 0)
 		return STATUS_FAIL;
-	}
 
 	return STATUS_SUCCESS;
 }
@@ -1636,17 +1580,15 @@ static int xd_read_multiple_pages(struct rtsx_chip *chip, u32 phy_blk,
 
 fail:
 	retval = rtsx_read_register(chip, XD_PAGE_STATUS, &reg_val);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	if (reg_val !=  XD_GPG)
 		xd_set_err_code(chip, XD_PRG_ERROR);
 
 	retval = rtsx_read_register(chip, XD_CTL, &reg_val);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	if (((reg_val & (XD_ECC1_ERROR | XD_ECC1_UNCORRECTABLE)) ==
 				(XD_ECC1_ERROR | XD_ECC1_UNCORRECTABLE)) ||
@@ -1702,9 +1644,8 @@ static int xd_finish_write(struct rtsx_chip *chip,
 	dev_dbg(rtsx_dev(chip),	"new_blk = 0x%x, ", new_blk);
 	dev_dbg(rtsx_dev(chip), "log_blk = 0x%x\n", log_blk);
 
-	if (page_off > xd_card->page_off) {
+	if (page_off > xd_card->page_off)
 		return STATUS_FAIL;
-	}
 
 	zone_no = (int)(log_blk / 1000);
 	log_off = (u16)(log_blk % 1000);
@@ -1760,9 +1701,8 @@ static int xd_prepare_write(struct rtsx_chip *chip,
 
 	if (page_off) {
 		retval = xd_copy_page(chip, old_blk, new_blk, 0, page_off);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 	}
 
 	return STATUS_SUCCESS;
@@ -1858,9 +1798,8 @@ static int xd_write_multiple_pages(struct rtsx_chip *chip, u32 old_blk,
 
 fail:
 	retval = rtsx_read_register(chip, XD_DAT, &reg_val);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 	if (reg_val & PROGRAM_ERROR) {
 		xd_set_err_code(chip, XD_PRG_ERROR);
 		xd_mark_bad_block(chip, new_blk);
@@ -1880,9 +1819,8 @@ int xd_delay_write(struct rtsx_chip *chip)
 	if (delay_write->delay_write_flag) {
 		dev_dbg(rtsx_dev(chip), "%s\n", __func__);
 		retval = xd_switch_clock(chip);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 
 		delay_write->delay_write_flag = 0;
 		retval = xd_finish_write(chip,
@@ -1890,9 +1828,8 @@ int xd_delay_write(struct rtsx_chip *chip)
 					 delay_write->new_phyblock,
 					 delay_write->logblock,
 					 delay_write->pageoff);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 	}
 
 	return STATUS_SUCCESS;
@@ -1924,9 +1861,8 @@ int xd_rw(struct scsi_cmnd *srb, struct rtsx_chip *chip,
 	ptr = (u8 *)scsi_sglist(srb);
 
 	retval = xd_switch_clock(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	if (detect_card_cd(chip, XD_CARD) != STATUS_SUCCESS) {
 		chip->card_fail |= XD_CARD;
@@ -2180,34 +2116,29 @@ int xd_power_off_card3v3(struct rtsx_chip *chip)
 	int retval;
 
 	retval = disable_card_clock(chip, XD_CARD);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	retval = rtsx_write_register(chip, CARD_OE, XD_OUTPUT_EN, 0);
-	if (retval) {
+	if (retval)
 		return retval;
-	}
 
 	if (!chip->ft2_fast_mode) {
 		retval = card_power_off(chip, XD_CARD);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 
 		wait_timeout(50);
 	}
 
 	if (chip->asic_code) {
 		retval = xd_pull_ctl_disable(chip);
-		if (retval != STATUS_SUCCESS) {
+		if (retval != STATUS_SUCCESS)
 			return STATUS_FAIL;
-		}
 	} else {
 		retval = rtsx_write_register(chip, FPGA_PULL_CTL, 0xFF, 0xDF);
-		if (retval) {
+		if (retval)
 			return retval;
-		}
 	}
 
 	return STATUS_SUCCESS;
@@ -2227,9 +2158,8 @@ int release_xd_card(struct rtsx_chip *chip)
 	xd_free_l2p_tbl(chip);
 
 	retval = xd_power_off_card3v3(chip);
-	if (retval != STATUS_SUCCESS) {
+	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	}
 
 	return STATUS_SUCCESS;
 }
-- 
2.17.1

