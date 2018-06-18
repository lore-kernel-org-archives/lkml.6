Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE808C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3086E208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:38:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3086E208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935040AbeFROi0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 10:38:26 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:33393 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934556AbeFROiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 10:38:22 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue105 [212.227.15.145]) with ESMTPA (Nemesis) id
 0M2u5m-1gJrgi3QlK-00sh8w; Mon, 18 Jun 2018 16:38:11 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, Micky Ching <micky_ching@realsil.com.cn>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] staging: rtsx: remove rtsx_trace() and related code
Date:   Mon, 18 Jun 2018 16:38:02 +0200
Message-Id: <20180618143802.4124691-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:i/xlM6svwuki+2lqBraH4WuGTcbRgeS49bWXQciMOmrpIebI9lC
 SK7qTQNKf5IvTR/wPF06+4iLmjBk+bZ/ZRi5wVcgEvrB9mmXSvCBn3OduEL5jDuWJxhmeaN
 CCrDtvX62WvqtqE9hQ6IadTeechrvsAcOIEFIn/OcdiKXo/KhbWirIZTsRjpOMfYcfiyOMG
 dTcgQ+z7VbufNOPq728kA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+5Ee6l7+1v4=:Fk/Wl79eXXIjq90Ghx75yu
 o8bT0EsdIErz02MIN3+DWLqo5sTGK27xXCy23pRF7uORLgelZhn8IEZjzXdYRxgf8JjaWkG4V
 NX/na3miEDP8j47BImcTgR/URR0Ws4feq38aNJbCGac67Wb5VDFdIgjgngAYZg/OtzSIRsZCS
 QZzaelWDX96ANH4slBwg89DoocpxrWt3AMj2eYXq5vH4OLyYKyMvRT1dupAbGJMW92q/VQCna
 VgLLbn30DtMvXE1mUBhpNj8zccLD8GADMpm0LV7YL57lnHWbmG+HImaC1e6+emBKgBFVRS4Gk
 9cVPt/Ilmbo3SiyF0erRGv3FYBBP3ZZu4ZMpjTSPPQhur3wRXG7Nwo/JH1n9GFPkn6meGTySq
 EshHC4M2/mKf4RzIWrpzs0uyX0XX5y34bVIUkgwSuNdauHdMqHvopM8641QreSSZ7ahESMtHm
 UK90OaGo3vR2TabKI1Drse4Q34O7wCK/C0AHLUvwChf+kQCJ80FyXaQ0tP0gukmByTObTCgbK
 B5jBQtgfg+d8AbtcWvD2XLH1HEIKADi8p7v4TlIggK/NVhwJ43VNK54p/vlCyLCyczAn3gp9l
 7trz3O9GNVArwDjAF8uDqitIPzhmaNfBN9cj5squloc8NWrb3/egyVmPght8sXJt0F0WmvfBm
 BnmLFIMgaWN1YyEhjz/ZUbNg/4cHVIt/N47QkN65YiGQmDQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver has rather excessive amount of tracing code, which would be
better done using ftrace. This is obviously not a main feature of the
driver, and it should work just as well without it.

Removing it saves over 1300 lines of code and likely makes the driver
a bit faster by avoiding lots of calls into the timekeeping code.

I came across this while cleaning up the last users of the deprecated
getnstimeofday64() function, of which there is one in the now-removed
get_current_time() function of the rtsx driver that was only used for
tracing.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/rts5208/Makefile         |   2 +-
 drivers/staging/rts5208/ms.c             | 337 -------------------------------
 drivers/staging/rts5208/rtsx.h           |  25 ---
 drivers/staging/rts5208/rtsx_card.c      |  29 ---
 drivers/staging/rts5208/rtsx_card.h      |   1 -
 drivers/staging/rts5208/rtsx_chip.c      | 140 -------------
 drivers/staging/rts5208/rtsx_chip.h      |  18 --
 drivers/staging/rts5208/rtsx_scsi.c      | 216 --------------------
 drivers/staging/rts5208/rtsx_transport.c |   1 -
 drivers/staging/rts5208/sd.c             | 326 ------------------------------
 drivers/staging/rts5208/spi.c            |  71 -------
 drivers/staging/rts5208/trace.c          |  27 ---
 drivers/staging/rts5208/trace.h          |  40 ----
 drivers/staging/rts5208/xd.c             | 112 ----------
 14 files changed, 1 insertion(+), 1344 deletions(-)
 delete mode 100644 drivers/staging/rts5208/trace.c
 delete mode 100644 drivers/staging/rts5208/trace.h

diff --git a/drivers/staging/rts5208/Makefile b/drivers/staging/rts5208/Makefile
index f7fd03a94e5f..17b4471c4d6d 100644
--- a/drivers/staging/rts5208/Makefile
+++ b/drivers/staging/rts5208/Makefile
@@ -3,4 +3,4 @@ obj-$(CONFIG_RTS5208) := rts5208.o
 ccflags-y := -Idrivers/scsi
 
 rts5208-y := rtsx.o rtsx_chip.o rtsx_transport.o rtsx_scsi.o \
-	rtsx_card.o general.o sd.o xd.o ms.o spi.o trace.o
+	rtsx_card.o general.o sd.o xd.o ms.o spi.o
diff --git a/drivers/staging/rts5208/ms.c b/drivers/staging/rts5208/ms.c
index b89ef15e3c20..3a71dbb6d24a 100644
--- a/drivers/staging/rts5208/ms.c
+++ b/drivers/staging/rts5208/ms.c
@@ -44,7 +44,6 @@ static inline int ms_check_err_code(struct rtsx_chip *chip, u8 err_code)
 
 static int ms_parse_err_code(struct rtsx_chip *chip)
 {
-	rtsx_trace(chip);
 	return STATUS_FAIL;
 }
 
@@ -76,7 +75,6 @@ static int ms_transfer_tpc(struct rtsx_chip *chip, u8 trans_mode,
 	if (retval < 0) {
 		rtsx_clear_ms_error(chip);
 		ms_set_err_code(chip, MS_TO_ERROR);
-		rtsx_trace(chip);
 		return ms_parse_err_code(chip);
 	}
 
@@ -85,14 +83,12 @@ static int ms_transfer_tpc(struct rtsx_chip *chip, u8 trans_mode,
 	if (!(tpc & 0x08)) {		/* Read Packet */
 		if (*ptr & MS_CRC16_ERR) {
 			ms_set_err_code(chip, MS_CRC16_ERROR);
-			rtsx_trace(chip);
 			return ms_parse_err_code(chip);
 		}
 	} else {			/* Write Packet */
 		if (CHK_MSPRO(ms_card) && !(*ptr & 0x80)) {
 			if (*ptr & (MS_INT_ERR | MS_INT_CMDNK)) {
 				ms_set_err_code(chip, MS_CMD_NK);
-				rtsx_trace(chip);
 				return ms_parse_err_code(chip);
 			}
 		}
@@ -101,7 +97,6 @@ static int ms_transfer_tpc(struct rtsx_chip *chip, u8 trans_mode,
 	if (*ptr & MS_RDY_TIMEOUT) {
 		rtsx_clear_ms_error(chip);
 		ms_set_err_code(chip, MS_TO_ERROR);
-		rtsx_trace(chip);
 		return ms_parse_err_code(chip);
 	}
 
@@ -117,7 +112,6 @@ static int ms_transfer_data(struct rtsx_chip *chip, u8 trans_mode,
 	enum dma_data_direction dir;
 
 	if (!buf || !buf_len) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -128,7 +122,6 @@ static int ms_transfer_data(struct rtsx_chip *chip, u8 trans_mode,
 		dir = DMA_TO_DEVICE;
 		err_code = MS_FLASH_WRITE_ERROR;
 	} else {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -165,17 +158,14 @@ static int ms_transfer_data(struct rtsx_chip *chip, u8 trans_mode,
 		else
 			retval = STATUS_FAIL;
 
-		rtsx_trace(chip);
 		return retval;
 	}
 
 	retval = rtsx_read_register(chip, MS_TRANS_CFG, &val);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 	if (val & (MS_INT_CMDNK | MS_INT_ERR | MS_CRC16_ERR | MS_RDY_TIMEOUT)) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -189,7 +179,6 @@ static int ms_write_bytes(struct rtsx_chip *chip,
 	int retval, i;
 
 	if (!data || (data_len < cnt)) {
-		rtsx_trace(chip);
 		return STATUS_ERROR;
 	}
 
@@ -225,14 +214,12 @@ static int ms_write_bytes(struct rtsx_chip *chip,
 		if (!(tpc & 0x08)) {
 			if (val & MS_CRC16_ERR) {
 				ms_set_err_code(chip, MS_CRC16_ERROR);
-				rtsx_trace(chip);
 				return ms_parse_err_code(chip);
 			}
 		} else {
 			if (CHK_MSPRO(ms_card) && !(val & 0x80)) {
 				if (val & (MS_INT_ERR | MS_INT_CMDNK)) {
 					ms_set_err_code(chip, MS_CMD_NK);
-					rtsx_trace(chip);
 					return ms_parse_err_code(chip);
 				}
 			}
@@ -240,12 +227,10 @@ static int ms_write_bytes(struct rtsx_chip *chip,
 
 		if (val & MS_RDY_TIMEOUT) {
 			ms_set_err_code(chip, MS_TO_ERROR);
-			rtsx_trace(chip);
 			return ms_parse_err_code(chip);
 		}
 
 		ms_set_err_code(chip, MS_TO_ERROR);
-		rtsx_trace(chip);
 		return ms_parse_err_code(chip);
 	}
 
@@ -260,7 +245,6 @@ static int ms_read_bytes(struct rtsx_chip *chip,
 	u8 *ptr;
 
 	if (!data) {
-		rtsx_trace(chip);
 		return STATUS_ERROR;
 	}
 
@@ -296,14 +280,12 @@ static int ms_read_bytes(struct rtsx_chip *chip,
 		if (!(tpc & 0x08)) {
 			if (val & MS_CRC16_ERR) {
 				ms_set_err_code(chip, MS_CRC16_ERROR);
-				rtsx_trace(chip);
 				return ms_parse_err_code(chip);
 			}
 		} else {
 			if (CHK_MSPRO(ms_card) && !(val & 0x80)) {
 				if (val & (MS_INT_ERR | MS_INT_CMDNK)) {
 					ms_set_err_code(chip, MS_CMD_NK);
-					rtsx_trace(chip);
 					return ms_parse_err_code(chip);
 				}
 			}
@@ -311,12 +293,10 @@ static int ms_read_bytes(struct rtsx_chip *chip,
 
 		if (val & MS_RDY_TIMEOUT) {
 			ms_set_err_code(chip, MS_TO_ERROR);
-			rtsx_trace(chip);
 			return ms_parse_err_code(chip);
 		}
 
 		ms_set_err_code(chip, MS_TO_ERROR);
-		rtsx_trace(chip);
 		return ms_parse_err_code(chip);
 	}
 
@@ -353,7 +333,6 @@ static int ms_set_rw_reg_addr(struct rtsx_chip *chip, u8 read_start,
 		rtsx_clear_ms_error(chip);
 	}
 
-	rtsx_trace(chip);
 	return STATUS_FAIL;
 }
 
@@ -393,13 +372,11 @@ static int ms_set_init_para(struct rtsx_chip *chip)
 
 	retval = switch_clock(chip, ms_card->ms_clock);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	retval = select_card(chip, MS_CARD);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -413,13 +390,11 @@ static int ms_switch_clock(struct rtsx_chip *chip)
 
 	retval = select_card(chip, MS_CARD);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	retval = switch_clock(chip, ms_card->ms_clock);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -435,41 +410,35 @@ static int ms_pull_ctl_disable(struct rtsx_chip *chip)
 					     MS_D1_PD | MS_D2_PD | MS_CLK_PD |
 					     MS_D6_PD);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 		retval = rtsx_write_register(chip, CARD_PULL_CTL2, 0xFF,
 					     MS_D3_PD | MS_D0_PD | MS_BS_PD |
 					     XD_D4_PD);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 		retval = rtsx_write_register(chip, CARD_PULL_CTL3, 0xFF,
 					     MS_D7_PD | XD_CE_PD | XD_CLE_PD |
 					     XD_CD_PU);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 		retval = rtsx_write_register(chip, CARD_PULL_CTL4, 0xFF,
 					     XD_RDY_PD | SD_D3_PD | SD_D2_PD |
 					     XD_ALE_PD);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 		retval = rtsx_write_register(chip, CARD_PULL_CTL5, 0xFF,
 					     MS_INS_PU | SD_WP_PD | SD_CD_PU |
 					     SD_CMD_PD);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 		retval = rtsx_write_register(chip, CARD_PULL_CTL6, 0xFF,
 					     MS_D5_PD | MS_D4_PD);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 	} else if (CHECK_PID(chip, 0x5288)) {
@@ -477,25 +446,21 @@ static int ms_pull_ctl_disable(struct rtsx_chip *chip)
 			retval = rtsx_write_register(chip, CARD_PULL_CTL1,
 						     0xFF, 0x55);
 			if (retval) {
-				rtsx_trace(chip);
 				return retval;
 			}
 			retval = rtsx_write_register(chip, CARD_PULL_CTL2,
 						     0xFF, 0x55);
 			if (retval) {
-				rtsx_trace(chip);
 				return retval;
 			}
 			retval = rtsx_write_register(chip, CARD_PULL_CTL3,
 						     0xFF, 0x4B);
 			if (retval) {
-				rtsx_trace(chip);
 				return retval;
 			}
 			retval = rtsx_write_register(chip, CARD_PULL_CTL4,
 						     0xFF, 0x69);
 			if (retval) {
-				rtsx_trace(chip);
 				return retval;
 			}
 		}
@@ -538,7 +503,6 @@ static int ms_pull_ctl_enable(struct rtsx_chip *chip)
 
 	retval = rtsx_send_cmd(chip, MS_CARD, 100);
 	if (retval < 0) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -560,7 +524,6 @@ static int ms_prepare_reset(struct rtsx_chip *chip)
 
 	retval = ms_power_off_card3v3(chip);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -569,21 +532,18 @@ static int ms_prepare_reset(struct rtsx_chip *chip)
 
 	retval = enable_card_clock(chip, MS_CARD);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	if (chip->asic_code) {
 		retval = ms_pull_ctl_enable(chip);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	} else {
 		retval = rtsx_write_register(chip, FPGA_PULL_CTL,
 					     FPGA_MS_PULL_CTL_BIT | 0x20, 0);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 	}
@@ -591,7 +551,6 @@ static int ms_prepare_reset(struct rtsx_chip *chip)
 	if (!chip->ft2_fast_mode) {
 		retval = card_power_on(chip, MS_CARD);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
@@ -606,7 +565,6 @@ static int ms_prepare_reset(struct rtsx_chip *chip)
 		if (chip->ocp_stat & oc_mask) {
 			dev_dbg(rtsx_dev(chip), "Over current, OCPSTAT is 0x%x\n",
 				chip->ocp_stat);
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 #endif
@@ -615,7 +573,6 @@ static int ms_prepare_reset(struct rtsx_chip *chip)
 	retval = rtsx_write_register(chip, CARD_OE, MS_OUTPUT_EN,
 				     MS_OUTPUT_EN);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 
@@ -626,7 +583,6 @@ static int ms_prepare_reset(struct rtsx_chip *chip)
 					     NO_EXTEND_TOGGLE |
 					     MS_BUS_WIDTH_1);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 	} else {
@@ -636,26 +592,22 @@ static int ms_prepare_reset(struct rtsx_chip *chip)
 					     NO_EXTEND_TOGGLE |
 					     MS_BUS_WIDTH_1);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 	}
 	retval = rtsx_write_register(chip, MS_TRANS_CFG, 0xFF,
 				     NO_WAIT_INT | NO_AUTO_READ_INT_REG);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 	retval = rtsx_write_register(chip, CARD_STOP, MS_STOP | MS_CLR_ERR,
 				     MS_STOP | MS_CLR_ERR);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 
 	retval = ms_set_init_para(chip);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -670,7 +622,6 @@ static int ms_identify_media_type(struct rtsx_chip *chip, int switch_8bit_bus)
 
 	retval = ms_set_rw_reg_addr(chip, Pro_StatusReg, 6, SystemParm, 1);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -681,13 +632,11 @@ static int ms_identify_media_type(struct rtsx_chip *chip, int switch_8bit_bus)
 			break;
 	}
 	if (i == MS_MAX_RETRY_COUNT) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	retval = rtsx_read_register(chip, PPBUF_BASE2 + 2, &val);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 	dev_dbg(rtsx_dev(chip), "Type register: 0x%x\n", val);
@@ -695,32 +644,27 @@ static int ms_identify_media_type(struct rtsx_chip *chip, int switch_8bit_bus)
 		if (val != 0x02)
 			ms_card->check_ms_flow = 1;
 
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	retval = rtsx_read_register(chip, PPBUF_BASE2 + 4, &val);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 	dev_dbg(rtsx_dev(chip), "Category register: 0x%x\n", val);
 	if (val != 0) {
 		ms_card->check_ms_flow = 1;
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	retval = rtsx_read_register(chip, PPBUF_BASE2 + 5, &val);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 	dev_dbg(rtsx_dev(chip), "Class register: 0x%x\n", val);
 	if (val == 0) {
 		retval = rtsx_read_register(chip, PPBUF_BASE2, &val);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 		if (val & WRT_PRTCT)
@@ -732,7 +676,6 @@ static int ms_identify_media_type(struct rtsx_chip *chip, int switch_8bit_bus)
 		chip->card_wp |= MS_CARD;
 	} else {
 		ms_card->check_ms_flow = 1;
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -740,7 +683,6 @@ static int ms_identify_media_type(struct rtsx_chip *chip, int switch_8bit_bus)
 
 	retval = rtsx_read_register(chip, PPBUF_BASE2 + 3, &val);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 	dev_dbg(rtsx_dev(chip), "IF Mode register: 0x%x\n", val);
@@ -753,7 +695,6 @@ static int ms_identify_media_type(struct rtsx_chip *chip, int switch_8bit_bus)
 			ms_card->ms_type &= 0x0F;
 
 	} else {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -770,7 +711,6 @@ static int ms_confirm_cpu_startup(struct rtsx_chip *chip)
 	do {
 		if (detect_card_cd(chip, MS_CARD) != STATUS_SUCCESS) {
 			ms_set_err_code(chip, MS_NO_CARD);
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
@@ -781,12 +721,10 @@ static int ms_confirm_cpu_startup(struct rtsx_chip *chip)
 				break;
 		}
 		if (i == MS_MAX_RETRY_COUNT) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
 		if (k > 100) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
@@ -800,7 +738,6 @@ static int ms_confirm_cpu_startup(struct rtsx_chip *chip)
 			break;
 	}
 	if (i == MS_MAX_RETRY_COUNT) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -808,7 +745,6 @@ static int ms_confirm_cpu_startup(struct rtsx_chip *chip)
 		if (val & INT_REG_CMDNK) {
 			chip->card_wp |= (MS_CARD);
 		} else {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	}
@@ -831,7 +767,6 @@ static int ms_switch_parallel_bus(struct rtsx_chip *chip)
 			break;
 	}
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -853,20 +788,17 @@ static int ms_switch_8bit_bus(struct rtsx_chip *chip)
 			break;
 	}
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	retval = rtsx_write_register(chip, MS_CFG, 0x98,
 				     MS_BUS_WIDTH_8 | SAMPLE_TIME_FALLING);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 	ms_card->ms_type |= MS_8BIT;
 	retval = ms_set_init_para(chip);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -874,7 +806,6 @@ static int ms_switch_8bit_bus(struct rtsx_chip *chip)
 		retval = ms_transfer_tpc(chip, MS_TM_READ_BYTES, GET_INT,
 					 1, NO_WAIT_INT);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	}
@@ -890,19 +821,16 @@ static int ms_pro_reset_flow(struct rtsx_chip *chip, int switch_8bit_bus)
 	for (i = 0; i < 3; i++) {
 		retval = ms_prepare_reset(chip);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
 		retval = ms_identify_media_type(chip, switch_8bit_bus);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
 		retval = ms_confirm_cpu_startup(chip);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
@@ -910,7 +838,6 @@ static int ms_pro_reset_flow(struct rtsx_chip *chip, int switch_8bit_bus)
 		if (retval != STATUS_SUCCESS) {
 			if (detect_card_cd(chip, MS_CARD) != STATUS_SUCCESS) {
 				ms_set_err_code(chip, MS_NO_CARD);
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 			continue;
@@ -920,26 +847,22 @@ static int ms_pro_reset_flow(struct rtsx_chip *chip, int switch_8bit_bus)
 	}
 
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	/* Switch MS-PRO into Parallel mode */
 	retval = rtsx_write_register(chip, MS_CFG, 0x18, MS_BUS_WIDTH_4);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 	retval = rtsx_write_register(chip, MS_CFG, PUSH_TIME_ODD,
 				     PUSH_TIME_ODD);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 
 	retval = ms_set_init_para(chip);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -948,7 +871,6 @@ static int ms_pro_reset_flow(struct rtsx_chip *chip, int switch_8bit_bus)
 		retval = ms_switch_8bit_bus(chip);
 		if (retval != STATUS_SUCCESS) {
 			ms_card->switch_8bit_fail = 1;
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	}
@@ -966,7 +888,6 @@ static int msxc_change_power(struct rtsx_chip *chip, u8 mode)
 
 	retval = ms_set_rw_reg_addr(chip, 0, 0, Pro_DataCount1, 6);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -979,23 +900,19 @@ static int msxc_change_power(struct rtsx_chip *chip, u8 mode)
 
 	retval = ms_write_bytes(chip, PRO_WRITE_REG, 6, NO_WAIT_INT, buf, 6);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	retval = ms_send_cmd(chip, XC_CHG_POWER, WAIT_INT);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	retval = rtsx_read_register(chip, MS_TRANS_CFG, buf);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 	if (buf[0] & (MS_INT_CMDNK | MS_INT_ERR)) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -1020,7 +937,6 @@ static int ms_read_attribute_info(struct rtsx_chip *chip)
 
 	retval = ms_set_rw_reg_addr(chip, Pro_IntReg, 2, Pro_SystemParm, 7);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -1045,13 +961,11 @@ static int ms_read_attribute_info(struct rtsx_chip *chip)
 			break;
 	}
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	buf = kmalloc(64 * 512, GFP_KERNEL);
 	if (!buf) {
-		rtsx_trace(chip);
 		return STATUS_ERROR;
 	}
 
@@ -1063,12 +977,10 @@ static int ms_read_attribute_info(struct rtsx_chip *chip)
 		retval = rtsx_read_register(chip, MS_TRANS_CFG, &val);
 		if (retval != STATUS_SUCCESS) {
 			kfree(buf);
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 		if (!(val & MS_INT_BREQ)) {
 			kfree(buf);
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 		retval = ms_transfer_data(chip, MS_TM_AUTO_READ,
@@ -1081,7 +993,6 @@ static int ms_read_attribute_info(struct rtsx_chip *chip)
 	}
 	if (retval != STATUS_SUCCESS) {
 		kfree(buf);
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -1090,7 +1001,6 @@ static int ms_read_attribute_info(struct rtsx_chip *chip)
 		retval = rtsx_read_register(chip, MS_TRANS_CFG, &val);
 		if (retval != STATUS_SUCCESS) {
 			kfree(buf);
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
@@ -1101,7 +1011,6 @@ static int ms_read_attribute_info(struct rtsx_chip *chip)
 					 PRO_READ_LONG_DATA, 0, WAIT_INT);
 		if (retval != STATUS_SUCCESS) {
 			kfree(buf);
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
@@ -1111,13 +1020,11 @@ static int ms_read_attribute_info(struct rtsx_chip *chip)
 	if ((buf[0] != 0xa5) && (buf[1] != 0xc3)) {
 		/* Signature code is wrong */
 		kfree(buf);
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	if ((buf[4] < 1) || (buf[4] > 12)) {
 		kfree(buf);
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -1142,17 +1049,14 @@ static int ms_read_attribute_info(struct rtsx_chip *chip)
 				sys_info_addr, sys_info_size);
 			if (sys_info_size != 96)  {
 				kfree(buf);
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 			if (sys_info_addr < 0x1A0) {
 				kfree(buf);
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 			if ((sys_info_size + sys_info_addr) > 0x8000) {
 				kfree(buf);
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 
@@ -1180,17 +1084,14 @@ static int ms_read_attribute_info(struct rtsx_chip *chip)
 				model_name_addr, model_name_size);
 			if (model_name_size != 48)  {
 				kfree(buf);
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 			if (model_name_addr < 0x1A0) {
 				kfree(buf);
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 			if ((model_name_size + model_name_addr) > 0x8000) {
 				kfree(buf);
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 
@@ -1204,7 +1105,6 @@ static int ms_read_attribute_info(struct rtsx_chip *chip)
 
 	if (i == buf[4]) {
 		kfree(buf);
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -1251,18 +1151,15 @@ static int ms_read_attribute_info(struct rtsx_chip *chip)
 #ifdef SUPPORT_MSXC
 	if (CHK_MSXC(ms_card)) {
 		if (class_code != 0x03) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	} else {
 		if (class_code != 0x02) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	}
 #else
 	if (class_code != 0x02) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 #endif
@@ -1272,13 +1169,11 @@ static int ms_read_attribute_info(struct rtsx_chip *chip)
 		    (device_type == 0x03)) {
 			chip->card_wp |= MS_CARD;
 		} else {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	}
 
 	if (sub_class & 0xC0) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -1329,18 +1224,15 @@ static int reset_ms_pro(struct rtsx_chip *chip)
 		if (ms_card->switch_8bit_fail) {
 			retval = ms_pro_reset_flow(chip, 0);
 			if (retval != STATUS_SUCCESS) {
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 		} else {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	}
 
 	retval = ms_read_attribute_info(chip);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -1383,7 +1275,6 @@ static int reset_ms_pro(struct rtsx_chip *chip)
 #ifdef SUPPORT_MAGIC_GATE
 	retval = mg_set_tpc_para_sub(chip, 0, 0);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 #endif
@@ -1403,19 +1294,16 @@ static int ms_read_status_reg(struct rtsx_chip *chip)
 
 	retval = ms_set_rw_reg_addr(chip, StatusReg0, 2, 0, 0);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	retval = ms_read_bytes(chip, READ_REG, 2, NO_WAIT_INT, val, 2);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	if (val[1] & (STS_UCDT | STS_UCEX | STS_UCFG)) {
 		ms_set_err_code(chip, MS_FLASH_READ_ERROR);
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -1432,7 +1320,6 @@ static int ms_read_extra_data(struct rtsx_chip *chip,
 	retval = ms_set_rw_reg_addr(chip, OverwriteFlag, MS_EXTRA_SIZE,
 				    SystemParm, 6);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -1456,7 +1343,6 @@ static int ms_read_extra_data(struct rtsx_chip *chip,
 			break;
 	}
 	if (i == MS_MAX_RETRY_COUNT) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -1468,27 +1354,23 @@ static int ms_read_extra_data(struct rtsx_chip *chip,
 			break;
 	}
 	if (i == MS_MAX_RETRY_COUNT) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	ms_set_err_code(chip, MS_NO_ERROR);
 	retval = ms_read_bytes(chip, GET_INT, 1, NO_WAIT_INT, &val, 1);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	if (val & INT_REG_CMDNK) {
 		ms_set_err_code(chip, MS_CMD_NK);
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 	if (val & INT_REG_CED) {
 		if (val & INT_REG_ERR) {
 			retval = ms_read_status_reg(chip);
 			if (retval != STATUS_SUCCESS) {
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 
@@ -1496,7 +1378,6 @@ static int ms_read_extra_data(struct rtsx_chip *chip,
 						    MS_EXTRA_SIZE, SystemParm,
 						    6);
 			if (retval != STATUS_SUCCESS) {
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 		}
@@ -1505,7 +1386,6 @@ static int ms_read_extra_data(struct rtsx_chip *chip,
 	retval = ms_read_bytes(chip, READ_REG, MS_EXTRA_SIZE, NO_WAIT_INT,
 			       data, MS_EXTRA_SIZE);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -1526,14 +1406,12 @@ static int ms_write_extra_data(struct rtsx_chip *chip, u16 block_addr,
 	u8 val, data[16];
 
 	if (!buf || (buf_len < MS_EXTRA_SIZE)) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	retval = ms_set_rw_reg_addr(chip, OverwriteFlag, MS_EXTRA_SIZE,
 				    SystemParm, 6 + MS_EXTRA_SIZE);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -1554,32 +1432,27 @@ static int ms_write_extra_data(struct rtsx_chip *chip, u16 block_addr,
 	retval = ms_write_bytes(chip, WRITE_REG, (6 + MS_EXTRA_SIZE),
 				NO_WAIT_INT, data, 16);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	retval = ms_send_cmd(chip, BLOCK_WRITE, WAIT_INT);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	ms_set_err_code(chip, MS_NO_ERROR);
 	retval = ms_read_bytes(chip, GET_INT, 1, NO_WAIT_INT, &val, 1);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	if (val & INT_REG_CMDNK) {
 		ms_set_err_code(chip, MS_CMD_NK);
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 	if (val & INT_REG_CED) {
 		if (val & INT_REG_ERR) {
 			ms_set_err_code(chip, MS_FLASH_WRITE_ERROR);
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	}
@@ -1596,7 +1469,6 @@ static int ms_read_page(struct rtsx_chip *chip, u16 block_addr, u8 page_num)
 	retval = ms_set_rw_reg_addr(chip, OverwriteFlag, MS_EXTRA_SIZE,
 				    SystemParm, 6);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -1613,26 +1485,22 @@ static int ms_read_page(struct rtsx_chip *chip, u16 block_addr, u8 page_num)
 
 	retval = ms_write_bytes(chip, WRITE_REG, 6, NO_WAIT_INT, data, 6);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	retval = ms_send_cmd(chip, BLOCK_READ, WAIT_INT);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	ms_set_err_code(chip, MS_NO_ERROR);
 	retval = ms_read_bytes(chip, GET_INT, 1, NO_WAIT_INT, &val, 1);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	if (val & INT_REG_CMDNK) {
 		ms_set_err_code(chip, MS_CMD_NK);
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -1640,7 +1508,6 @@ static int ms_read_page(struct rtsx_chip *chip, u16 block_addr, u8 page_num)
 		if (val & INT_REG_ERR) {
 			if (!(val & INT_REG_BREQ)) {
 				ms_set_err_code(chip,  MS_FLASH_READ_ERROR);
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 			retval = ms_read_status_reg(chip);
@@ -1650,7 +1517,6 @@ static int ms_read_page(struct rtsx_chip *chip, u16 block_addr, u8 page_num)
 		} else {
 			if (!(val & INT_REG_BREQ)) {
 				ms_set_err_code(chip, MS_BREQ_ERROR);
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 		}
@@ -1659,12 +1525,10 @@ static int ms_read_page(struct rtsx_chip *chip, u16 block_addr, u8 page_num)
 	retval = ms_transfer_tpc(chip, MS_TM_NORMAL_READ, READ_PAGE_DATA,
 				 0, NO_WAIT_INT);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	if (ms_check_err_code(chip, MS_FLASH_WRITE_ERROR)) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -1679,14 +1543,12 @@ static int ms_set_bad_block(struct rtsx_chip *chip, u16 phy_blk)
 
 	retval = ms_read_extra_data(chip, phy_blk, 0, extra, MS_EXTRA_SIZE);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	retval = ms_set_rw_reg_addr(chip, OverwriteFlag, MS_EXTRA_SIZE,
 				    SystemParm, 7);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -1707,33 +1569,28 @@ static int ms_set_bad_block(struct rtsx_chip *chip, u16 phy_blk)
 
 	retval = ms_write_bytes(chip, WRITE_REG, 7, NO_WAIT_INT, data, 7);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	retval = ms_send_cmd(chip, BLOCK_WRITE, WAIT_INT);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	ms_set_err_code(chip, MS_NO_ERROR);
 	retval = ms_read_bytes(chip, GET_INT, 1, NO_WAIT_INT, &val, 1);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	if (val & INT_REG_CMDNK) {
 		ms_set_err_code(chip, MS_CMD_NK);
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	if (val & INT_REG_CED) {
 		if (val & INT_REG_ERR) {
 			ms_set_err_code(chip, MS_FLASH_WRITE_ERROR);
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	}
@@ -1750,7 +1607,6 @@ static int ms_erase_block(struct rtsx_chip *chip, u16 phy_blk)
 	retval = ms_set_rw_reg_addr(chip, OverwriteFlag, MS_EXTRA_SIZE,
 				    SystemParm, 6);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -1769,21 +1625,18 @@ static int ms_erase_block(struct rtsx_chip *chip, u16 phy_blk)
 
 	retval = ms_write_bytes(chip, WRITE_REG, 6, NO_WAIT_INT, data, 6);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 ERASE_RTY:
 	retval = ms_send_cmd(chip, BLOCK_ERASE, WAIT_INT);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	ms_set_err_code(chip, MS_NO_ERROR);
 	retval = ms_read_bytes(chip, GET_INT, 1, NO_WAIT_INT, &val, 1);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -1795,14 +1648,12 @@ static int ms_erase_block(struct rtsx_chip *chip, u16 phy_blk)
 
 		ms_set_err_code(chip, MS_CMD_NK);
 		ms_set_bad_block(chip, phy_blk);
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	if (val & INT_REG_CED) {
 		if (val & INT_REG_ERR) {
 			ms_set_err_code(chip, MS_FLASH_WRITE_ERROR);
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	}
@@ -1845,14 +1696,12 @@ static int ms_init_page(struct rtsx_chip *chip, u16 phy_blk, u16 log_blk,
 	for (i = start_page; i < end_page; i++) {
 		if (detect_card_cd(chip, MS_CARD) != STATUS_SUCCESS) {
 			ms_set_err_code(chip, MS_NO_CARD);
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
 		retval = ms_write_extra_data(chip, phy_blk, i,
 					     extra, MS_EXTRA_SIZE);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	}
@@ -1875,38 +1724,32 @@ static int ms_copy_page(struct rtsx_chip *chip, u16 old_blk, u16 new_blk,
 
 	retval = ms_read_extra_data(chip, new_blk, 0, extra, MS_EXTRA_SIZE);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	retval = ms_read_status_reg(chip);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	retval = rtsx_read_register(chip, PPBUF_BASE2, &val);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 
 	if (val & BUF_FULL) {
 		retval = ms_send_cmd(chip, CLEAR_BUF, WAIT_INT);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
 		retval = ms_read_bytes(chip, GET_INT, 1, NO_WAIT_INT, &val, 1);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
 		if (!(val & INT_REG_CED)) {
 			ms_set_err_code(chip, MS_FLASH_WRITE_ERROR);
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	}
@@ -1914,7 +1757,6 @@ static int ms_copy_page(struct rtsx_chip *chip, u16 old_blk, u16 new_blk,
 	for (i = start_page; i < end_page; i++) {
 		if (detect_card_cd(chip, MS_CARD) != STATUS_SUCCESS) {
 			ms_set_err_code(chip, MS_NO_CARD);
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
@@ -1923,7 +1765,6 @@ static int ms_copy_page(struct rtsx_chip *chip, u16 old_blk, u16 new_blk,
 		retval = ms_set_rw_reg_addr(chip, OverwriteFlag,
 					    MS_EXTRA_SIZE, SystemParm, 6);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
@@ -1943,26 +1784,22 @@ static int ms_copy_page(struct rtsx_chip *chip, u16 old_blk, u16 new_blk,
 		retval = ms_write_bytes(chip, WRITE_REG, 6, NO_WAIT_INT,
 					data, 6);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
 		retval = ms_send_cmd(chip, BLOCK_READ, WAIT_INT);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
 		ms_set_err_code(chip, MS_NO_ERROR);
 		retval = ms_read_bytes(chip, GET_INT, 1, NO_WAIT_INT, &val, 1);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
 		if (val & INT_REG_CMDNK) {
 			ms_set_err_code(chip, MS_CMD_NK);
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
@@ -1981,7 +1818,6 @@ static int ms_copy_page(struct rtsx_chip *chip, u16 old_blk, u16 new_blk,
 							 READ_PAGE_DATA,
 							 0, NO_WAIT_INT);
 				if (retval != STATUS_SUCCESS) {
-					rtsx_trace(chip);
 					return STATUS_FAIL;
 				}
 
@@ -2019,14 +1855,12 @@ static int ms_copy_page(struct rtsx_chip *chip, u16 old_blk, u16 new_blk,
 						break;
 				}
 				if (rty_cnt == MS_MAX_RETRY_COUNT) {
-					rtsx_trace(chip);
 					return STATUS_FAIL;
 				}
 			}
 
 			if (!(val & INT_REG_BREQ)) {
 				ms_set_err_code(chip, MS_BREQ_ERROR);
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 		}
@@ -2062,33 +1896,28 @@ static int ms_copy_page(struct rtsx_chip *chip, u16 old_blk, u16 new_blk,
 		retval = ms_write_bytes(chip, WRITE_REG, (6 + MS_EXTRA_SIZE),
 					NO_WAIT_INT, data, 16);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
 		retval = ms_send_cmd(chip, BLOCK_WRITE, WAIT_INT);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
 		ms_set_err_code(chip, MS_NO_ERROR);
 		retval = ms_read_bytes(chip, GET_INT, 1, NO_WAIT_INT, &val, 1);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
 		if (val & INT_REG_CMDNK) {
 			ms_set_err_code(chip, MS_CMD_NK);
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
 		if (val & INT_REG_CED) {
 			if (val & INT_REG_ERR) {
 				ms_set_err_code(chip, MS_FLASH_WRITE_ERROR);
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 		}
@@ -2098,7 +1927,6 @@ static int ms_copy_page(struct rtsx_chip *chip, u16 old_blk, u16 new_blk,
 						    MS_EXTRA_SIZE, SystemParm,
 						    7);
 			if (retval != STATUS_SUCCESS) {
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 
@@ -2120,13 +1948,11 @@ static int ms_copy_page(struct rtsx_chip *chip, u16 old_blk, u16 new_blk,
 			retval = ms_write_bytes(chip, WRITE_REG, 7,
 						NO_WAIT_INT, data, 8);
 			if (retval != STATUS_SUCCESS) {
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 
 			retval = ms_send_cmd(chip, BLOCK_WRITE, WAIT_INT);
 			if (retval != STATUS_SUCCESS) {
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 
@@ -2134,13 +1960,11 @@ static int ms_copy_page(struct rtsx_chip *chip, u16 old_blk, u16 new_blk,
 			retval = ms_read_bytes(chip, GET_INT, 1,
 					       NO_WAIT_INT, &val, 1);
 			if (retval != STATUS_SUCCESS) {
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 
 			if (val & INT_REG_CMDNK) {
 				ms_set_err_code(chip, MS_CMD_NK);
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 
@@ -2148,7 +1972,6 @@ static int ms_copy_page(struct rtsx_chip *chip, u16 old_blk, u16 new_blk,
 				if (val & INT_REG_ERR) {
 					ms_set_err_code(chip,
 							MS_FLASH_WRITE_ERROR);
-					rtsx_trace(chip);
 					return STATUS_FAIL;
 				}
 			}
@@ -2170,7 +1993,6 @@ static int reset_ms(struct rtsx_chip *chip)
 
 	retval = ms_prepare_reset(chip);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -2178,19 +2000,16 @@ static int reset_ms(struct rtsx_chip *chip)
 
 	retval = ms_send_cmd(chip, MS_RESET, NO_WAIT_INT);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	retval = ms_read_status_reg(chip);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	retval = rtsx_read_register(chip, PPBUF_BASE2, &val);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 	if (val & WRT_PRTCT)
@@ -2205,7 +2024,6 @@ static int reset_ms(struct rtsx_chip *chip)
 	while (i < (MAX_DEFECTIVE_BLOCK + 2)) {
 		if (detect_card_cd(chip, MS_CARD) != STATUS_SUCCESS) {
 			ms_set_err_code(chip, MS_NO_CARD);
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
@@ -2226,7 +2044,6 @@ static int reset_ms(struct rtsx_chip *chip)
 
 	if (i == (MAX_DEFECTIVE_BLOCK + 2)) {
 		dev_dbg(rtsx_dev(chip), "No boot block found!");
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -2243,7 +2060,6 @@ static int reset_ms(struct rtsx_chip *chip)
 
 	retval = ms_read_page(chip, ms_card->boot_block, 0);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -2255,7 +2071,6 @@ static int reset_ms(struct rtsx_chip *chip)
 
 	retval = rtsx_send_cmd(chip, MS_CARD, 100);
 	if (retval < 0) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -2280,7 +2095,6 @@ static int reset_ms(struct rtsx_chip *chip)
 
 	retval = rtsx_send_cmd(chip, MS_CARD, 100);
 	if (retval < 0) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -2356,25 +2170,21 @@ static int reset_ms(struct rtsx_chip *chip)
 	if (ptr[15]) {
 		retval = ms_set_rw_reg_addr(chip, 0, 0, SystemParm, 1);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
 		retval = rtsx_write_register(chip, PPBUF_BASE2, 0xFF, 0x88);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 		retval = rtsx_write_register(chip, PPBUF_BASE2 + 1, 0xFF, 0);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 
 		retval = ms_transfer_tpc(chip, MS_TM_WRITE_BYTES, WRITE_REG, 1,
 					 NO_WAIT_INT);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
@@ -2384,7 +2194,6 @@ static int reset_ms(struct rtsx_chip *chip)
 					     PUSH_TIME_ODD |
 					     MS_NO_CHECK_INT);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 
@@ -2413,13 +2222,11 @@ static int ms_init_l2p_tbl(struct rtsx_chip *chip)
 	size = ms_card->segment_cnt * sizeof(struct zone_entry);
 	ms_card->segment = vzalloc(size);
 	if (!ms_card->segment) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	retval = ms_read_page(chip, ms_card->boot_block, 1);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		goto INIT_FAIL;
 	}
 
@@ -2429,13 +2236,11 @@ static int ms_init_l2p_tbl(struct rtsx_chip *chip)
 
 		retval = rtsx_read_register(chip, reg_addr++, &val1);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			goto INIT_FAIL;
 		}
 
 		retval = rtsx_read_register(chip, reg_addr++, &val2);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			goto INIT_FAIL;
 		}
 
@@ -2599,7 +2404,6 @@ static int ms_build_l2p_tbl(struct rtsx_chip *chip, int seg_no)
 	if (!ms_card->segment) {
 		retval = ms_init_l2p_tbl(chip);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return retval;
 		}
 	}
@@ -2620,7 +2424,6 @@ static int ms_build_l2p_tbl(struct rtsx_chip *chip, int seg_no)
 	if (!segment->l2p_table) {
 		segment->l2p_table = vmalloc(array_size(table_size, 2));
 		if (!segment->l2p_table) {
-			rtsx_trace(chip);
 			goto BUILD_FAIL;
 		}
 	}
@@ -2629,7 +2432,6 @@ static int ms_build_l2p_tbl(struct rtsx_chip *chip, int seg_no)
 	if (!segment->free_table) {
 		segment->free_table = vmalloc(MS_FREE_TABLE_CNT * 2);
 		if (!segment->free_table) {
-			rtsx_trace(chip);
 			goto BUILD_FAIL;
 		}
 	}
@@ -2757,7 +2559,6 @@ static int ms_build_l2p_tbl(struct rtsx_chip *chip, int seg_no)
 			}
 			retval = ms_init_page(chip, phy_blk, log_blk, 0, 1);
 			if (retval != STATUS_SUCCESS) {
-				rtsx_trace(chip);
 				goto BUILD_FAIL;
 			}
 
@@ -2791,7 +2592,6 @@ static int ms_build_l2p_tbl(struct rtsx_chip *chip, int seg_no)
 						      log_blk, 0,
 						      ms_card->page_off + 1);
 				if (retval != STATUS_SUCCESS) {
-					rtsx_trace(chip);
 					return STATUS_FAIL;
 				}
 
@@ -2799,7 +2599,6 @@ static int ms_build_l2p_tbl(struct rtsx_chip *chip, int seg_no)
 
 				retval = ms_set_bad_block(chip, tmp_blk);
 				if (retval != STATUS_SUCCESS) {
-					rtsx_trace(chip);
 					return STATUS_FAIL;
 				}
 			}
@@ -2828,13 +2627,11 @@ int reset_ms_card(struct rtsx_chip *chip)
 
 	retval = enable_card_clock(chip, MS_CARD);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	retval = select_card(chip, MS_CARD);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -2845,18 +2642,15 @@ int reset_ms_card(struct rtsx_chip *chip)
 		if (ms_card->check_ms_flow) {
 			retval = reset_ms(chip);
 			if (retval != STATUS_SUCCESS) {
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 		} else {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	}
 
 	retval = ms_set_init_para(chip);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -2866,7 +2660,6 @@ int reset_ms_card(struct rtsx_chip *chip)
 		 */
 		retval = ms_build_l2p_tbl(chip, seg_no);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	}
@@ -2898,7 +2691,6 @@ static int mspro_set_rw_cmd(struct rtsx_chip *chip,
 			break;
 	}
 	if (i == MS_MAX_RETRY_COUNT) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -2940,7 +2732,6 @@ static inline int ms_auto_tune_clock(struct rtsx_chip *chip)
 
 	retval = ms_switch_clock(chip);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -2992,7 +2783,6 @@ static int mspro_rw_multi_sector(struct scsi_cmnd *srb,
 
 	retval = ms_switch_clock(chip);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -3003,7 +2793,6 @@ static int mspro_rw_multi_sector(struct scsi_cmnd *srb,
 
 	retval = rtsx_read_register(chip, MS_TRANS_CFG, &val);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 
@@ -3020,7 +2809,6 @@ static int mspro_rw_multi_sector(struct scsi_cmnd *srb,
 			if (val & MS_INT_BREQ) {
 				retval = ms_send_cmd(chip, PRO_STOP, WAIT_INT);
 				if (retval != STATUS_SUCCESS) {
-					rtsx_trace(chip);
 					return STATUS_FAIL;
 				}
 
@@ -3050,7 +2838,6 @@ static int mspro_rw_multi_sector(struct scsi_cmnd *srb,
 		retval = mspro_set_rw_cmd(chip, start_sector, count, rw_cmd);
 		if (retval != STATUS_SUCCESS) {
 			ms_card->seq_mode = 0;
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	}
@@ -3067,7 +2854,6 @@ static int mspro_rw_multi_sector(struct scsi_cmnd *srb,
 			chip->rw_need_retry = 0;
 			dev_dbg(rtsx_dev(chip), "No card exist, exit %s\n",
 				__func__);
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
@@ -3080,7 +2866,6 @@ static int mspro_rw_multi_sector(struct scsi_cmnd *srb,
 			ms_auto_tune_clock(chip);
 		}
 
-		rtsx_trace(chip);
 		return retval;
 	}
 
@@ -3109,14 +2894,12 @@ static int mspro_read_format_progress(struct rtsx_chip *chip,
 	retval = ms_switch_clock(chip);
 	if (retval != STATUS_SUCCESS) {
 		ms_card->format_status = FORMAT_FAIL;
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	retval = rtsx_read_register(chip, MS_TRANS_CFG, &tmp);
 	if (retval != STATUS_SUCCESS) {
 		ms_card->format_status = FORMAT_FAIL;
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -3127,7 +2910,6 @@ static int mspro_read_format_progress(struct rtsx_chip *chip,
 			return STATUS_SUCCESS;
 		}
 		ms_card->format_status = FORMAT_FAIL;
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -3140,7 +2922,6 @@ static int mspro_read_format_progress(struct rtsx_chip *chip,
 				     MS_NO_CHECK_INT);
 	if (retval != STATUS_SUCCESS) {
 		ms_card->format_status = FORMAT_FAIL;
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -3148,7 +2929,6 @@ static int mspro_read_format_progress(struct rtsx_chip *chip,
 			       data, 8);
 	if (retval != STATUS_SUCCESS) {
 		ms_card->format_status = FORMAT_FAIL;
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -3174,7 +2954,6 @@ static int mspro_read_format_progress(struct rtsx_chip *chip,
 		retval = rtsx_read_register(chip, MS_TRANS_CFG, &tmp);
 		if (retval != STATUS_SUCCESS) {
 			ms_card->format_status = FORMAT_FAIL;
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 		if (tmp & (MS_INT_CED | MS_INT_CMDNK |
@@ -3187,19 +2966,16 @@ static int mspro_read_format_progress(struct rtsx_chip *chip,
 	retval = rtsx_write_register(chip, MS_CFG, MS_NO_CHECK_INT, 0);
 	if (retval != STATUS_SUCCESS) {
 		ms_card->format_status = FORMAT_FAIL;
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	if (i == 5000) {
 		ms_card->format_status = FORMAT_FAIL;
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	if (tmp & (MS_INT_CMDNK | MS_INT_ERR)) {
 		ms_card->format_status = FORMAT_FAIL;
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -3211,7 +2987,6 @@ static int mspro_read_format_progress(struct rtsx_chip *chip,
 	} else {
 		ms_card->format_status = FORMAT_FAIL;
 		ms_card->pro_under_formatting = 0;
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -3245,13 +3020,11 @@ int mspro_format(struct scsi_cmnd *srb, struct rtsx_chip *chip,
 
 	retval = ms_switch_clock(chip);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	retval = ms_set_rw_reg_addr(chip, 0x00, 0x00, Pro_TPCParm, 0x01);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -3279,7 +3052,6 @@ int mspro_format(struct scsi_cmnd *srb, struct rtsx_chip *chip,
 			break;
 	}
 	if (i == MS_MAX_RETRY_COUNT) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -3290,18 +3062,15 @@ int mspro_format(struct scsi_cmnd *srb, struct rtsx_chip *chip,
 
 	retval = mspro_set_rw_cmd(chip, 0, para, PRO_FORMAT);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	retval = rtsx_read_register(chip, MS_TRANS_CFG, &tmp);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 
 	if (tmp & (MS_INT_CMDNK | MS_INT_ERR)) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -3320,7 +3089,6 @@ int mspro_format(struct scsi_cmnd *srb, struct rtsx_chip *chip,
 		return STATUS_SUCCESS;
 	}
 
-	rtsx_trace(chip);
 	return STATUS_FAIL;
 }
 
@@ -3339,7 +3107,6 @@ static int ms_read_multiple_pages(struct rtsx_chip *chip, u16 phy_blk,
 	if (retval == STATUS_SUCCESS) {
 		if ((extra[1] & 0x30) != 0x30) {
 			ms_set_err_code(chip, MS_FLASH_READ_ERROR);
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	}
@@ -3347,7 +3114,6 @@ static int ms_read_multiple_pages(struct rtsx_chip *chip, u16 phy_blk,
 	retval = ms_set_rw_reg_addr(chip, OverwriteFlag, MS_EXTRA_SIZE,
 				    SystemParm, 6);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -3369,7 +3135,6 @@ static int ms_read_multiple_pages(struct rtsx_chip *chip, u16 phy_blk,
 			break;
 	}
 	if (i == MS_MAX_RETRY_COUNT) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -3377,7 +3142,6 @@ static int ms_read_multiple_pages(struct rtsx_chip *chip, u16 phy_blk,
 
 	retval = ms_send_cmd(chip, BLOCK_READ, WAIT_INT);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -3388,19 +3152,16 @@ static int ms_read_multiple_pages(struct rtsx_chip *chip, u16 phy_blk,
 
 		if (detect_card_cd(chip, MS_CARD) != STATUS_SUCCESS) {
 			ms_set_err_code(chip, MS_NO_CARD);
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
 		retval = ms_read_bytes(chip, GET_INT, 1, NO_WAIT_INT, &val, 1);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
 		if (val & INT_REG_CMDNK) {
 			ms_set_err_code(chip, MS_CMD_NK);
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 		if (val & INT_REG_ERR) {
@@ -3420,18 +3181,15 @@ static int ms_read_multiple_pages(struct rtsx_chip *chip, u16 phy_blk,
 					}
 					ms_set_err_code(chip,
 							MS_FLASH_READ_ERROR);
-					rtsx_trace(chip);
 					return STATUS_FAIL;
 				}
 			} else {
 				ms_set_err_code(chip, MS_FLASH_READ_ERROR);
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 		} else {
 			if (!(val & INT_REG_BREQ)) {
 				ms_set_err_code(chip, MS_BREQ_ERROR);
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 		}
@@ -3440,7 +3198,6 @@ static int ms_read_multiple_pages(struct rtsx_chip *chip, u16 phy_blk,
 			if (!(val & INT_REG_CED)) {
 				retval = ms_send_cmd(chip, BLOCK_END, WAIT_INT);
 				if (retval != STATUS_SUCCESS) {
-					rtsx_trace(chip);
 					return STATUS_FAIL;
 				}
 			}
@@ -3448,13 +3205,11 @@ static int ms_read_multiple_pages(struct rtsx_chip *chip, u16 phy_blk,
 			retval = ms_read_bytes(chip, GET_INT, 1, NO_WAIT_INT,
 					       &val, 1);
 			if (retval != STATUS_SUCCESS) {
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 
 			if (!(val & INT_REG_CED)) {
 				ms_set_err_code(chip, MS_FLASH_READ_ERROR);
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 
@@ -3489,7 +3244,6 @@ static int ms_read_multiple_pages(struct rtsx_chip *chip, u16 phy_blk,
 			if (retval == -ETIMEDOUT) {
 				ms_set_err_code(chip, MS_TO_ERROR);
 				rtsx_clear_ms_error(chip);
-				rtsx_trace(chip);
 				return STATUS_TIMEDOUT;
 			}
 
@@ -3497,13 +3251,11 @@ static int ms_read_multiple_pages(struct rtsx_chip *chip, u16 phy_blk,
 			if (retval != STATUS_SUCCESS) {
 				ms_set_err_code(chip, MS_TO_ERROR);
 				rtsx_clear_ms_error(chip);
-				rtsx_trace(chip);
 				return STATUS_TIMEDOUT;
 			}
 			if (val & (MS_CRC16_ERR | MS_RDY_TIMEOUT)) {
 				ms_set_err_code(chip, MS_CRC16_ERROR);
 				rtsx_clear_ms_error(chip);
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 		}
@@ -3529,7 +3281,6 @@ static int ms_write_multiple_pages(struct rtsx_chip *chip, u16 old_blk,
 		retval = ms_set_rw_reg_addr(chip, OverwriteFlag, MS_EXTRA_SIZE,
 					    SystemParm, 7);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
@@ -3549,13 +3300,11 @@ static int ms_write_multiple_pages(struct rtsx_chip *chip, u16 old_blk,
 		retval = ms_write_bytes(chip, WRITE_REG, 7, NO_WAIT_INT,
 					data, 8);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
 		retval = ms_send_cmd(chip, BLOCK_WRITE, WAIT_INT);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
@@ -3563,7 +3312,6 @@ static int ms_write_multiple_pages(struct rtsx_chip *chip, u16 old_blk,
 		retval = ms_transfer_tpc(chip, MS_TM_READ_BYTES, GET_INT, 1,
 					 NO_WAIT_INT);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	}
@@ -3571,7 +3319,6 @@ static int ms_write_multiple_pages(struct rtsx_chip *chip, u16 old_blk,
 	retval = ms_set_rw_reg_addr(chip, OverwriteFlag, MS_EXTRA_SIZE,
 				    SystemParm, (6 + MS_EXTRA_SIZE));
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -3606,7 +3353,6 @@ static int ms_write_multiple_pages(struct rtsx_chip *chip, u16 old_blk,
 			break;
 	}
 	if (i == MS_MAX_RETRY_COUNT) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -3616,13 +3362,11 @@ static int ms_write_multiple_pages(struct rtsx_chip *chip, u16 old_blk,
 			break;
 	}
 	if (i == MS_MAX_RETRY_COUNT) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	retval = ms_read_bytes(chip, GET_INT, 1, NO_WAIT_INT, &val, 1);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -3632,23 +3376,19 @@ static int ms_write_multiple_pages(struct rtsx_chip *chip, u16 old_blk,
 
 		if (detect_card_cd(chip, MS_CARD) != STATUS_SUCCESS) {
 			ms_set_err_code(chip, MS_NO_CARD);
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
 		if (val & INT_REG_CMDNK) {
 			ms_set_err_code(chip, MS_CMD_NK);
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 		if (val & INT_REG_ERR) {
 			ms_set_err_code(chip, MS_FLASH_WRITE_ERROR);
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 		if (!(val & INT_REG_BREQ)) {
 			ms_set_err_code(chip, MS_BREQ_ERROR);
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
@@ -3682,23 +3422,19 @@ static int ms_write_multiple_pages(struct rtsx_chip *chip, u16 old_blk,
 			rtsx_clear_ms_error(chip);
 
 			if (retval == -ETIMEDOUT) {
-				rtsx_trace(chip);
 				return STATUS_TIMEDOUT;
 			}
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
 		retval = ms_read_bytes(chip, GET_INT, 1, NO_WAIT_INT, &val, 1);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
 		if ((end_page - start_page) == 1) {
 			if (!(val & INT_REG_CED)) {
 				ms_set_err_code(chip, MS_FLASH_WRITE_ERROR);
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 		} else {
@@ -3707,7 +3443,6 @@ static int ms_write_multiple_pages(struct rtsx_chip *chip, u16 old_blk,
 					retval = ms_send_cmd(chip, BLOCK_END,
 							     WAIT_INT);
 					if (retval != STATUS_SUCCESS) {
-						rtsx_trace(chip);
 						return STATUS_FAIL;
 					}
 				}
@@ -3715,7 +3450,6 @@ static int ms_write_multiple_pages(struct rtsx_chip *chip, u16 old_blk,
 				retval = ms_read_bytes(chip, GET_INT, 1,
 						       NO_WAIT_INT, &val, 1);
 				if (retval != STATUS_SUCCESS) {
-					rtsx_trace(chip);
 					return STATUS_FAIL;
 				}
 			}
@@ -3725,7 +3459,6 @@ static int ms_write_multiple_pages(struct rtsx_chip *chip, u16 old_blk,
 				if (!(val & INT_REG_CED)) {
 					ms_set_err_code(chip,
 							MS_FLASH_WRITE_ERROR);
-					rtsx_trace(chip);
 					return STATUS_FAIL;
 				}
 			}
@@ -3747,7 +3480,6 @@ static int ms_finish_write(struct rtsx_chip *chip, u16 old_blk, u16 new_blk,
 	retval = ms_copy_page(chip, old_blk, new_blk, log_blk,
 			      page_off, ms_card->page_off + 1);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -3776,7 +3508,6 @@ static int ms_prepare_write(struct rtsx_chip *chip, u16 old_blk, u16 new_blk,
 		retval = ms_copy_page(chip, old_blk, new_blk, log_blk,
 				      0, start_page);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	}
@@ -3794,7 +3525,6 @@ int ms_delay_write(struct rtsx_chip *chip)
 	if (delay_write->delay_write_flag) {
 		retval = ms_set_init_para(chip);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
@@ -3805,7 +3535,6 @@ int ms_delay_write(struct rtsx_chip *chip)
 					delay_write->logblock,
 					delay_write->pageoff);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	}
@@ -3846,7 +3575,6 @@ static int ms_rw_multi_sector(struct scsi_cmnd *srb, struct rtsx_chip *chip,
 	retval = ms_switch_clock(chip);
 	if (retval != STATUS_SUCCESS) {
 		ms_rw_fail(srb, chip);
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -3863,7 +3591,6 @@ static int ms_rw_multi_sector(struct scsi_cmnd *srb, struct rtsx_chip *chip,
 		if (retval != STATUS_SUCCESS) {
 			chip->card_fail |= MS_CARD;
 			set_sense_type(chip, lun, SENSE_TYPE_MEDIA_NOT_PRESENT);
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	}
@@ -3882,7 +3609,6 @@ static int ms_rw_multi_sector(struct scsi_cmnd *srb, struct rtsx_chip *chip,
 			if (retval != STATUS_SUCCESS) {
 				set_sense_type(chip, lun,
 					       SENSE_TYPE_MEDIA_WRITE_ERR);
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 			old_blk = delay_write->old_phyblock;
@@ -3898,7 +3624,6 @@ static int ms_rw_multi_sector(struct scsi_cmnd *srb, struct rtsx_chip *chip,
 			if (retval != STATUS_SUCCESS) {
 				set_sense_type(chip, lun,
 					       SENSE_TYPE_MEDIA_WRITE_ERR);
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 #endif
@@ -3909,7 +3634,6 @@ static int ms_rw_multi_sector(struct scsi_cmnd *srb, struct rtsx_chip *chip,
 			if ((old_blk == 0xFFFF) || (new_blk == 0xFFFF)) {
 				set_sense_type(chip, lun,
 					       SENSE_TYPE_MEDIA_WRITE_ERR);
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 
@@ -3921,12 +3645,10 @@ static int ms_rw_multi_sector(struct scsi_cmnd *srb, struct rtsx_chip *chip,
 					set_sense_type
 						(chip, lun,
 						SENSE_TYPE_MEDIA_NOT_PRESENT);
-					rtsx_trace(chip);
 					return STATUS_FAIL;
 				}
 				set_sense_type(chip, lun,
 					       SENSE_TYPE_MEDIA_WRITE_ERR);
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 #ifdef MS_DELAY_WRITE
@@ -3939,12 +3661,10 @@ static int ms_rw_multi_sector(struct scsi_cmnd *srb, struct rtsx_chip *chip,
 			if (detect_card_cd(chip, MS_CARD) != STATUS_SUCCESS) {
 				set_sense_type(chip, lun,
 					       SENSE_TYPE_MEDIA_NOT_PRESENT);
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 			set_sense_type(chip, lun,
 				       SENSE_TYPE_MEDIA_UNRECOVER_READ_ERR);
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 #endif
@@ -3953,7 +3673,6 @@ static int ms_rw_multi_sector(struct scsi_cmnd *srb, struct rtsx_chip *chip,
 		if (old_blk == 0xFFFF) {
 			set_sense_type(chip, lun,
 				       SENSE_TYPE_MEDIA_UNRECOVER_READ_ERR);
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	}
@@ -3989,11 +3708,9 @@ static int ms_rw_multi_sector(struct scsi_cmnd *srb, struct rtsx_chip *chip,
 			if (detect_card_cd(chip, MS_CARD) != STATUS_SUCCESS) {
 				set_sense_type(chip, lun,
 					       SENSE_TYPE_MEDIA_NOT_PRESENT);
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 			ms_rw_fail(srb, chip);
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
@@ -4030,7 +3747,6 @@ static int ms_rw_multi_sector(struct scsi_cmnd *srb, struct rtsx_chip *chip,
 				chip->card_fail |= MS_CARD;
 				set_sense_type(chip, lun,
 					       SENSE_TYPE_MEDIA_NOT_PRESENT);
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 		}
@@ -4039,7 +3755,6 @@ static int ms_rw_multi_sector(struct scsi_cmnd *srb, struct rtsx_chip *chip,
 					 log_blk - ms_start_idx[seg_no]);
 		if (old_blk == 0xFFFF) {
 			ms_rw_fail(srb, chip);
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
@@ -4047,7 +3762,6 @@ static int ms_rw_multi_sector(struct scsi_cmnd *srb, struct rtsx_chip *chip,
 			new_blk = ms_get_unused_block(chip, seg_no);
 			if (new_blk == 0xFFFF) {
 				ms_rw_fail(srb, chip);
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 		}
@@ -4075,12 +3789,10 @@ static int ms_rw_multi_sector(struct scsi_cmnd *srb, struct rtsx_chip *chip,
 					set_sense_type
 						(chip, lun,
 						SENSE_TYPE_MEDIA_NOT_PRESENT);
-					rtsx_trace(chip);
 					return STATUS_FAIL;
 				}
 
 				ms_rw_fail(srb, chip);
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 #endif
@@ -4139,13 +3851,11 @@ static int ms_poll_int(struct rtsx_chip *chip)
 
 	retval = rtsx_send_cmd(chip, MS_CARD, 5000);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	val = *rtsx_get_cmd_data(chip);
 	if (val & MS_INT_ERR) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -4211,13 +3921,11 @@ static int mg_send_ex_cmd(struct rtsx_chip *chip, u8 cmd, u8 entry_num)
 			break;
 	}
 	if (i == MS_MAX_RETRY_COUNT) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	if (check_ms_err(chip)) {
 		rtsx_clear_ms_error(chip);
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -4236,7 +3944,6 @@ static int mg_set_tpc_para_sub(struct rtsx_chip *chip, int type,
 		retval = ms_set_rw_reg_addr(chip, 0, 0, Pro_DataCount1, 6);
 
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -4251,7 +3958,6 @@ static int mg_set_tpc_para_sub(struct rtsx_chip *chip, int type,
 	retval = ms_write_bytes(chip, PRO_WRITE_REG, (type == 0) ? 1 : 6,
 				NO_WAIT_INT, buf, 6);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -4267,7 +3973,6 @@ int mg_set_leaf_id(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 	if (scsi_bufflen(srb) < 12) {
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -4275,14 +3980,12 @@ int mg_set_leaf_id(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 	retval = ms_switch_clock(chip);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	retval = mg_send_ex_cmd(chip, MG_SET_LID, 0);
 	if (retval != STATUS_SUCCESS) {
 		set_sense_type(chip, lun, SENSE_TYPE_MG_KEY_FAIL_NOT_ESTAB);
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -4295,13 +3998,11 @@ int mg_set_leaf_id(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 				buf1, 32);
 	if (retval != STATUS_SUCCESS) {
 		set_sense_type(chip, lun, SENSE_TYPE_MG_KEY_FAIL_NOT_ESTAB);
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 	if (check_ms_err(chip)) {
 		set_sense_type(chip, lun, SENSE_TYPE_MG_KEY_FAIL_NOT_ESTAB);
 		rtsx_clear_ms_error(chip);
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -4319,13 +4020,11 @@ int mg_get_local_EKB(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 	retval = ms_switch_clock(chip);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	buf = kmalloc(1540, GFP_KERNEL);
 	if (!buf) {
-		rtsx_trace(chip);
 		return STATUS_ERROR;
 	}
 
@@ -4337,7 +4036,6 @@ int mg_get_local_EKB(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	retval = mg_send_ex_cmd(chip, MG_GET_LEKB, 0);
 	if (retval != STATUS_SUCCESS) {
 		set_sense_type(chip, lun, SENSE_TYPE_MG_KEY_FAIL_NOT_AUTHEN);
-		rtsx_trace(chip);
 		goto free_buffer;
 	}
 
@@ -4346,13 +4044,11 @@ int mg_get_local_EKB(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	if (retval != STATUS_SUCCESS) {
 		set_sense_type(chip, lun, SENSE_TYPE_MG_KEY_FAIL_NOT_AUTHEN);
 		rtsx_clear_ms_error(chip);
-		rtsx_trace(chip);
 		goto free_buffer;
 	}
 	if (check_ms_err(chip)) {
 		set_sense_type(chip, lun, SENSE_TYPE_MG_KEY_FAIL_NOT_AUTHEN);
 		rtsx_clear_ms_error(chip);
-		rtsx_trace(chip);
 		retval = STATUS_FAIL;
 		goto free_buffer;
 	}
@@ -4378,14 +4074,12 @@ int mg_chg(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 	retval = ms_switch_clock(chip);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	retval = mg_send_ex_cmd(chip, MG_GET_ID, 0);
 	if (retval != STATUS_SUCCESS) {
 		set_sense_type(chip, lun, SENSE_TYPE_MG_INCOMPATIBLE_MEDIUM);
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -4393,13 +4087,11 @@ int mg_chg(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 			       buf, 32);
 	if (retval != STATUS_SUCCESS) {
 		set_sense_type(chip, lun, SENSE_TYPE_MG_INCOMPATIBLE_MEDIUM);
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 	if (check_ms_err(chip)) {
 		set_sense_type(chip, lun, SENSE_TYPE_MG_INCOMPATIBLE_MEDIUM);
 		rtsx_clear_ms_error(chip);
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -4409,7 +4101,6 @@ int mg_chg(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	retval = ms_poll_int(chip);
 	if (retval != STATUS_SUCCESS) {
 		set_sense_type(chip, lun, SENSE_TYPE_MG_INCOMPATIBLE_MEDIUM);
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 #endif
@@ -4417,7 +4108,6 @@ int mg_chg(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	retval = mg_send_ex_cmd(chip, MG_SET_RD, 0);
 	if (retval != STATUS_SUCCESS) {
 		set_sense_type(chip, lun, SENSE_TYPE_MG_INCOMPATIBLE_MEDIUM);
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -4434,13 +4124,11 @@ int mg_chg(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 				32, WAIT_INT, buf, 32);
 	if (retval != STATUS_SUCCESS) {
 		set_sense_type(chip, lun, SENSE_TYPE_MG_INCOMPATIBLE_MEDIUM);
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 	if (check_ms_err(chip)) {
 		set_sense_type(chip, lun, SENSE_TYPE_MG_INCOMPATIBLE_MEDIUM);
 		rtsx_clear_ms_error(chip);
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -4461,14 +4149,12 @@ int mg_get_rsp_chg(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 	retval = ms_switch_clock(chip);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	retval = mg_send_ex_cmd(chip, MG_MAKE_RMS, 0);
 	if (retval != STATUS_SUCCESS) {
 		set_sense_type(chip, lun, SENSE_TYPE_MG_KEY_FAIL_NOT_AUTHEN);
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -4476,13 +4162,11 @@ int mg_get_rsp_chg(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 			       buf1, 32);
 	if (retval != STATUS_SUCCESS) {
 		set_sense_type(chip, lun, SENSE_TYPE_MG_KEY_FAIL_NOT_AUTHEN);
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 	if (check_ms_err(chip)) {
 		set_sense_type(chip, lun, SENSE_TYPE_MG_KEY_FAIL_NOT_AUTHEN);
 		rtsx_clear_ms_error(chip);
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -4501,7 +4185,6 @@ int mg_get_rsp_chg(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	retval = ms_poll_int(chip);
 	if (retval != STATUS_SUCCESS) {
 		set_sense_type(chip, lun, SENSE_TYPE_MG_KEY_FAIL_NOT_AUTHEN);
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 #endif
@@ -4522,14 +4205,12 @@ int mg_rsp(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 	retval = ms_switch_clock(chip);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	retval = mg_send_ex_cmd(chip, MG_MAKE_KSE, 0);
 	if (retval != STATUS_SUCCESS) {
 		set_sense_type(chip, lun, SENSE_TYPE_MG_KEY_FAIL_NOT_AUTHEN);
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -4546,13 +4227,11 @@ int mg_rsp(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 				buf, 32);
 	if (retval != STATUS_SUCCESS) {
 		set_sense_type(chip, lun, SENSE_TYPE_MG_KEY_FAIL_NOT_AUTHEN);
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 	if (check_ms_err(chip)) {
 		set_sense_type(chip, lun, SENSE_TYPE_MG_KEY_FAIL_NOT_AUTHEN);
 		rtsx_clear_ms_error(chip);
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -4573,13 +4252,11 @@ int mg_get_ICV(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 	retval = ms_switch_clock(chip);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	buf = kmalloc(1028, GFP_KERNEL);
 	if (!buf) {
-		rtsx_trace(chip);
 		return STATUS_ERROR;
 	}
 
@@ -4591,7 +4268,6 @@ int mg_get_ICV(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	retval = mg_send_ex_cmd(chip, MG_GET_IBD, ms_card->mg_entry_num);
 	if (retval != STATUS_SUCCESS) {
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_UNRECOVER_READ_ERR);
-		rtsx_trace(chip);
 		goto free_buffer;
 	}
 
@@ -4600,13 +4276,11 @@ int mg_get_ICV(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	if (retval != STATUS_SUCCESS) {
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_UNRECOVER_READ_ERR);
 		rtsx_clear_ms_error(chip);
-		rtsx_trace(chip);
 		goto free_buffer;
 	}
 	if (check_ms_err(chip)) {
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_UNRECOVER_READ_ERR);
 		rtsx_clear_ms_error(chip);
-		rtsx_trace(chip);
 		retval = STATUS_FAIL;
 		goto free_buffer;
 	}
@@ -4634,13 +4308,11 @@ int mg_set_ICV(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 	retval = ms_switch_clock(chip);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	buf = kmalloc(1028, GFP_KERNEL);
 	if (!buf) {
-		rtsx_trace(chip);
 		return STATUS_ERROR;
 	}
 
@@ -4660,7 +4332,6 @@ int mg_set_ICV(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 		} else {
 			set_sense_type(chip, lun, SENSE_TYPE_MG_WRITE_ERR);
 		}
-		rtsx_trace(chip);
 		goto SetICVFinish;
 	}
 
@@ -4702,7 +4373,6 @@ int mg_set_ICV(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 					       SENSE_TYPE_MG_WRITE_ERR);
 			}
 			retval = STATUS_FAIL;
-			rtsx_trace(chip);
 			goto SetICVFinish;
 		}
 	}
@@ -4722,7 +4392,6 @@ int mg_set_ICV(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 		} else {
 			set_sense_type(chip, lun, SENSE_TYPE_MG_WRITE_ERR);
 		}
-		rtsx_trace(chip);
 		goto SetICVFinish;
 	}
 #endif
@@ -4765,14 +4434,12 @@ int ms_power_off_card3v3(struct rtsx_chip *chip)
 
 	retval = disable_card_clock(chip, MS_CARD);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	if (chip->asic_code) {
 		retval = ms_pull_ctl_disable(chip);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	} else {
@@ -4780,19 +4447,16 @@ int ms_power_off_card3v3(struct rtsx_chip *chip)
 					     FPGA_MS_PULL_CTL_BIT | 0x20,
 					     FPGA_MS_PULL_CTL_BIT);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 	}
 	retval = rtsx_write_register(chip, CARD_OE, MS_OUTPUT_EN, 0);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 	if (!chip->ft2_fast_mode) {
 		retval = card_power_off(chip, MS_CARD);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	}
@@ -4823,7 +4487,6 @@ int release_ms_card(struct rtsx_chip *chip)
 
 	retval = ms_power_off_card3v3(chip);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
diff --git a/drivers/staging/rts5208/rtsx.h b/drivers/staging/rts5208/rtsx.h
index 62e467c5a6d7..514536a6f92b 100644
--- a/drivers/staging/rts5208/rtsx.h
+++ b/drivers/staging/rts5208/rtsx.h
@@ -139,28 +139,6 @@ static inline struct rtsx_dev *host_to_rtsx(struct Scsi_Host *host)
 	return (struct rtsx_dev *)host->hostdata;
 }
 
-static inline void get_current_time(u8 *timeval_buf, int buf_len)
-{
-	struct timespec64 ts64;
-	u32 tv_usec;
-
-	if (!timeval_buf || (buf_len < 8))
-		return;
-
-	getnstimeofday64(&ts64);
-
-	tv_usec = ts64.tv_nsec / NSEC_PER_USEC;
-
-	timeval_buf[0] = (u8)(ts64.tv_sec >> 24);
-	timeval_buf[1] = (u8)(ts64.tv_sec >> 16);
-	timeval_buf[2] = (u8)(ts64.tv_sec >> 8);
-	timeval_buf[3] = (u8)(ts64.tv_sec);
-	timeval_buf[4] = (u8)(tv_usec >> 24);
-	timeval_buf[5] = (u8)(tv_usec >> 16);
-	timeval_buf[6] = (u8)(tv_usec >> 8);
-	timeval_buf[7] = (u8)(tv_usec);
-}
-
 /*
  * The scsi_lock() and scsi_unlock() macros protect the sm_state and the
  * single queue element srb for write access
@@ -174,9 +152,6 @@ static inline void get_current_time(u8 *timeval_buf, int buf_len)
 /* struct scsi_cmnd transfer buffer access utilities */
 enum xfer_buf_dir	{TO_XFER_BUF, FROM_XFER_BUF};
 
-#define _MSG_TRACE
-
-#include "trace.h"
 #include "rtsx_chip.h"
 #include "rtsx_transport.h"
 #include "rtsx_scsi.h"
diff --git a/drivers/staging/rts5208/rtsx_card.c b/drivers/staging/rts5208/rtsx_card.c
index a6b7bffc6714..d26a8e372fce 100644
--- a/drivers/staging/rts5208/rtsx_card.c
+++ b/drivers/staging/rts5208/rtsx_card.c
@@ -648,7 +648,6 @@ int switch_ssc_clock(struct rtsx_chip *chip, int clk)
 		clk, chip->cur_clk);
 
 	if ((clk <= 2) || (n > max_n)) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -690,14 +689,12 @@ int switch_ssc_clock(struct rtsx_chip *chip, int clk)
 
 	retval = rtsx_send_cmd(chip, 0, WAIT_TIME);
 	if (retval < 0) {
-		rtsx_trace(chip);
 		return STATUS_ERROR;
 	}
 
 	udelay(10);
 	retval = rtsx_write_register(chip, CLK_CTL, CLK_LOW_FREQ, 0);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 
@@ -789,38 +786,32 @@ int switch_normal_clock(struct rtsx_chip *chip, int clk)
 	default:
 		dev_dbg(rtsx_dev(chip), "Try to switch to an illegal clock (%d)\n",
 			clk);
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	retval = rtsx_write_register(chip, CLK_CTL, 0xFF, CLK_LOW_FREQ);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 	if (sd_vpclk_phase_reset) {
 		retval = rtsx_write_register(chip, SD_VPCLK0_CTL,
 					     PHASE_NOT_RESET, 0);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 		retval = rtsx_write_register(chip, SD_VPCLK1_CTL,
 					     PHASE_NOT_RESET, 0);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 	}
 	retval = rtsx_write_register(chip, CLK_DIV, 0xFF,
 				     (div << 4) | mcu_cnt);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 	retval = rtsx_write_register(chip, CLK_SEL, 0xFF, sel);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 
@@ -829,20 +820,17 @@ int switch_normal_clock(struct rtsx_chip *chip, int clk)
 		retval = rtsx_write_register(chip, SD_VPCLK0_CTL,
 					     PHASE_NOT_RESET, PHASE_NOT_RESET);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 		retval = rtsx_write_register(chip, SD_VPCLK1_CTL,
 					     PHASE_NOT_RESET, PHASE_NOT_RESET);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 		udelay(200);
 	}
 	retval = rtsx_write_register(chip, CLK_CTL, 0xFF, 0);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 
@@ -891,7 +879,6 @@ int enable_card_clock(struct rtsx_chip *chip, u8 card)
 
 	retval = rtsx_write_register(chip, CARD_CLK_EN, clk_en, clk_en);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 
@@ -912,7 +899,6 @@ int disable_card_clock(struct rtsx_chip *chip, u8 card)
 
 	retval = rtsx_write_register(chip, CARD_CLK_EN, clk_en, 0);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 
@@ -939,7 +925,6 @@ int card_power_on(struct rtsx_chip *chip, u8 card)
 
 	retval = rtsx_send_cmd(chip, 0, 100);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -950,7 +935,6 @@ int card_power_on(struct rtsx_chip *chip, u8 card)
 
 	retval = rtsx_send_cmd(chip, 0, 100);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -972,7 +956,6 @@ int card_power_off(struct rtsx_chip *chip, u8 card)
 
 	retval = rtsx_write_register(chip, CARD_PWR_CTL, mask, val);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 
@@ -987,7 +970,6 @@ int card_rw(struct scsi_cmnd *srb, struct rtsx_chip *chip,
 	int i;
 
 	if (!chip->rw_card[lun]) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -998,12 +980,10 @@ int card_rw(struct scsi_cmnd *srb, struct rtsx_chip *chip,
 		if (retval != STATUS_SUCCESS) {
 			if (rtsx_check_chip_exist(chip) != STATUS_SUCCESS) {
 				rtsx_release_chip(chip);
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 			if (detect_card_cd(chip, chip->cur_card) !=
 							STATUS_SUCCESS) {
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 
@@ -1036,7 +1016,6 @@ int card_share_mode(struct rtsx_chip *chip, int card)
 		} else if (card == XD_CARD) {
 			value = CARD_SHARE_48_XD;
 		} else {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
@@ -1049,18 +1028,15 @@ int card_share_mode(struct rtsx_chip *chip, int card)
 		} else if (card == XD_CARD) {
 			value = CARD_SHARE_BAROSSA_XD;
 		} else {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
 	} else {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	retval = rtsx_write_register(chip, CARD_SHARE_MODE, mask, value);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 
@@ -1083,20 +1059,17 @@ int select_card(struct rtsx_chip *chip, int card)
 		} else if (card == SPI_CARD) {
 			mod = SPI_MOD_SEL;
 		} else {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
 		retval = rtsx_write_register(chip, CARD_SELECT, 0x07, mod);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 		chip->cur_card = card;
 
 		retval =  card_share_mode(chip, card);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	}
@@ -1143,13 +1116,11 @@ int detect_card_cd(struct rtsx_chip *chip, int card)
 		card_cd = XD_EXIST;
 	} else {
 		dev_dbg(rtsx_dev(chip), "Wrong card type: 0x%x\n", card);
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	status = rtsx_readl(chip, RTSX_BIPR);
 	if (!(status & card_cd)) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
diff --git a/drivers/staging/rts5208/rtsx_card.h b/drivers/staging/rts5208/rtsx_card.h
index aa37705bae39..ac165d8a081c 100644
--- a/drivers/staging/rts5208/rtsx_card.h
+++ b/drivers/staging/rts5208/rtsx_card.h
@@ -1063,7 +1063,6 @@ static inline int card_power_off_all(struct rtsx_chip *chip)
 
 	retval = rtsx_write_register(chip, CARD_PWR_CTL, 0x0F, 0x0F);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 
diff --git a/drivers/staging/rts5208/rtsx_chip.c b/drivers/staging/rts5208/rtsx_chip.c
index 8a823466ca2b..6b1234bff09c 100644
--- a/drivers/staging/rts5208/rtsx_chip.c
+++ b/drivers/staging/rts5208/rtsx_chip.c
@@ -117,7 +117,6 @@ static int rtsx_pre_handle_sdio_old(struct rtsx_chip *chip)
 						     MS_INS_PU | SD_WP_PU |
 						     SD_CD_PU | SD_CMD_PU);
 			if (retval) {
-				rtsx_trace(chip);
 				return retval;
 			}
 		} else {
@@ -125,28 +124,24 @@ static int rtsx_pre_handle_sdio_old(struct rtsx_chip *chip)
 						     0xFF,
 						     FPGA_SD_PULL_CTL_EN);
 			if (retval) {
-				rtsx_trace(chip);
 				return retval;
 			}
 		}
 		retval = rtsx_write_register(chip, CARD_SHARE_MODE, 0xFF,
 					     CARD_SHARE_48_SD);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 
 		/* Enable SDIO internal clock */
 		retval = rtsx_write_register(chip, 0xFF2C, 0x01, 0x01);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 
 		retval = rtsx_write_register(chip, SDIO_CTRL, 0xFF,
 					     SDIO_BUS_CTRL | SDIO_CD_CTRL);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 
@@ -170,7 +165,6 @@ static int rtsx_pre_handle_sdio_new(struct rtsx_chip *chip)
 		if (CHECK_PID(chip, 0x5288)) {
 			retval = rtsx_read_register(chip, 0xFE5A, &tmp);
 			if (retval) {
-				rtsx_trace(chip);
 				return retval;
 			}
 			if (tmp & 0x08)
@@ -178,7 +172,6 @@ static int rtsx_pre_handle_sdio_new(struct rtsx_chip *chip)
 		} else if (CHECK_PID(chip, 0x5208)) {
 			retval = rtsx_read_register(chip, 0xFE70, &tmp);
 			if (retval) {
-				rtsx_trace(chip);
 				return retval;
 			}
 			if (tmp & 0x80)
@@ -200,7 +193,6 @@ static int rtsx_pre_handle_sdio_new(struct rtsx_chip *chip)
 
 		retval = rtsx_read_register(chip, TLPTISTAT, &tmp);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 		cd_toggle_mask = 0x08;
@@ -211,14 +203,12 @@ static int rtsx_pre_handle_sdio_new(struct rtsx_chip *chip)
 				retval = rtsx_write_register(chip, 0xFE5A,
 							     0x08, 0x00);
 				if (retval) {
-					rtsx_trace(chip);
 					return retval;
 				}
 			} else if (CHECK_PID(chip, 0x5208)) {
 				retval = rtsx_write_register(chip, 0xFE70,
 							     0x80, 0x00);
 				if (retval) {
-					rtsx_trace(chip);
 					return retval;
 				}
 			}
@@ -226,7 +216,6 @@ static int rtsx_pre_handle_sdio_new(struct rtsx_chip *chip)
 			retval = rtsx_write_register(chip, TLPTISTAT, 0xFF,
 						     tmp);
 			if (retval) {
-				rtsx_trace(chip);
 				return retval;
 			}
 
@@ -237,7 +226,6 @@ static int rtsx_pre_handle_sdio_new(struct rtsx_chip *chip)
 			if (chip->asic_code) {
 				retval = sd_pull_ctl_enable(chip);
 				if (retval != STATUS_SUCCESS) {
-					rtsx_trace(chip);
 					return STATUS_FAIL;
 				}
 			} else {
@@ -246,13 +234,11 @@ static int rtsx_pre_handle_sdio_new(struct rtsx_chip *chip)
 						 FPGA_SD_PULL_CTL_BIT | 0x20,
 						 0);
 				if (retval) {
-					rtsx_trace(chip);
 					return retval;
 				}
 			}
 			retval = card_share_mode(chip, SD_CARD);
 			if (retval != STATUS_SUCCESS) {
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 
@@ -261,14 +247,12 @@ static int rtsx_pre_handle_sdio_new(struct rtsx_chip *chip)
 				retval = rtsx_write_register(chip, 0xFE5A,
 							     0x08, 0x08);
 				if (retval) {
-					rtsx_trace(chip);
 					return retval;
 				}
 			} else if (CHECK_PID(chip, 0x5208)) {
 				retval = rtsx_write_register(chip, 0xFE70,
 							     0x80, 0x80);
 				if (retval) {
-					rtsx_trace(chip);
 					return retval;
 				}
 			}
@@ -279,7 +263,6 @@ static int rtsx_pre_handle_sdio_new(struct rtsx_chip *chip)
 	} else {
 		retval = rtsx_write_register(chip, TLPTISTAT, 0x08, 0x08);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 
@@ -301,7 +284,6 @@ static int rtsx_reset_aspm(struct rtsx_chip *chip)
 		ret = rtsx_write_cfg_dw(chip, 2, 0xC0, 0xFF,
 					chip->aspm_l0s_l1_en);
 		if (ret != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
@@ -311,13 +293,11 @@ static int rtsx_reset_aspm(struct rtsx_chip *chip)
 	if (CHECK_PID(chip, 0x5208)) {
 		ret = rtsx_write_register(chip, ASPM_FORCE_CTL, 0xFF, 0x3F);
 		if (ret) {
-			rtsx_trace(chip);
 			return ret;
 		}
 	}
 	ret = rtsx_write_config_byte(chip, LCTLR, chip->aspm_l0s_l1_en);
 	if (ret != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -327,7 +307,6 @@ static int rtsx_reset_aspm(struct rtsx_chip *chip)
 		ret = rtsx_write_cfg_dw(chip, CHECK_PID(chip, 0x5288) ? 2 : 1,
 					0xC0, 0xFF, chip->aspm_l0s_l1_en);
 		if (ret != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	}
@@ -349,7 +328,6 @@ static int rtsx_enable_pcie_intr(struct rtsx_chip *chip)
 	if (chip->phy_debug_mode) {
 		ret = rtsx_write_register(chip, CDRESUMECTL, 0x77, 0);
 		if (ret) {
-			rtsx_trace(chip);
 			return ret;
 		}
 		rtsx_disable_bus_int(chip);
@@ -362,7 +340,6 @@ static int rtsx_enable_pcie_intr(struct rtsx_chip *chip)
 
 		ret = rtsx_read_phy_register(chip, 0x00, &reg);
 		if (ret != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
@@ -370,20 +347,17 @@ static int rtsx_enable_pcie_intr(struct rtsx_chip *chip)
 		reg |= 0x80;
 		ret = rtsx_write_phy_register(chip, 0x00, reg);
 		if (ret != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
 		ret = rtsx_read_phy_register(chip, 0x1C, &reg);
 		if (ret != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
 		reg &= 0xFFF7;
 		ret = rtsx_write_phy_register(chip, 0x1C, reg);
 		if (ret != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	}
@@ -404,14 +378,12 @@ int rtsx_reset_chip(struct rtsx_chip *chip)
 
 	retval = rtsx_write_register(chip, HOST_SLEEP_STATE, 0x03, 0x00);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 
 	/* Disable card clock */
 	retval = rtsx_write_register(chip, CARD_CLK_EN, 0x1E, 0);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 
@@ -420,14 +392,12 @@ int rtsx_reset_chip(struct rtsx_chip *chip)
 	if (CHECK_LUN_MODE(chip, SD_MS_2LUN)) {
 		retval = rtsx_write_register(chip, FPDCTL, OC_POWER_DOWN, 0);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 	} else {
 		retval = rtsx_write_register(chip, FPDCTL, OC_POWER_DOWN,
 					     MS_OC_POWER_DOWN);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 	}
@@ -435,19 +405,16 @@ int rtsx_reset_chip(struct rtsx_chip *chip)
 	retval = rtsx_write_register(chip, OCPPARA1, OCP_TIME_MASK,
 				     OCP_TIME_800);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 	retval = rtsx_write_register(chip, OCPPARA2, OCP_THD_MASK,
 				     OCP_THD_244_946);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 	retval = rtsx_write_register(chip, OCPCTL, 0xFF,
 				     CARD_OC_INT_EN | CARD_DETECT_EN);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 #else
@@ -455,7 +422,6 @@ int rtsx_reset_chip(struct rtsx_chip *chip)
 	retval = rtsx_write_register(chip, FPDCTL, OC_POWER_DOWN,
 				     OC_POWER_DOWN);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 #endif
@@ -463,7 +429,6 @@ int rtsx_reset_chip(struct rtsx_chip *chip)
 	if (!CHECK_PID(chip, 0x5288)) {
 		retval = rtsx_write_register(chip, CARD_GPIO_DIR, 0xFF, 0x03);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 	}
@@ -471,14 +436,12 @@ int rtsx_reset_chip(struct rtsx_chip *chip)
 	/* Turn off LED */
 	retval = rtsx_write_register(chip, CARD_GPIO, 0xFF, 0x03);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 
 	/* Reset delink mode */
 	retval = rtsx_write_register(chip, CHANGE_LINK_STATE, 0x0A, 0);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 
@@ -486,7 +449,6 @@ int rtsx_reset_chip(struct rtsx_chip *chip)
 	retval = rtsx_write_register(chip, CARD_DRIVE_SEL, 0xFF,
 				     chip->card_drive_sel);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 
@@ -494,7 +456,6 @@ int rtsx_reset_chip(struct rtsx_chip *chip)
 	retval = rtsx_write_register(chip, CARD_AUTO_BLINK, 0xFF,
 				     LED_BLINK_SPEED | BLINK_EN | LED_GPIO0);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 #endif
@@ -504,12 +465,10 @@ int rtsx_reset_chip(struct rtsx_chip *chip)
 		retval = rtsx_write_register(chip, SSC_CTL1, 0xFF,
 					     SSC_8X_EN | SSC_SEL_4M);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 		retval = rtsx_write_register(chip, SSC_CTL2, 0xFF, 0x12);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 	}
@@ -524,7 +483,6 @@ int rtsx_reset_chip(struct rtsx_chip *chip)
 	 */
 	retval = rtsx_write_register(chip, CHANGE_LINK_STATE, 0x16, 0x10);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 
@@ -532,28 +490,24 @@ int rtsx_reset_chip(struct rtsx_chip *chip)
 	if (chip->aspm_l0s_l1_en) {
 		retval = rtsx_reset_aspm(chip);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	} else {
 		if (chip->asic_code && CHECK_PID(chip, 0x5208)) {
 			retval = rtsx_write_phy_register(chip, 0x07, 0x0129);
 			if (retval != STATUS_SUCCESS) {
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 		}
 		retval = rtsx_write_config_byte(chip, LCTLR,
 						chip->aspm_l0s_l1_en);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	}
 
 	retval = rtsx_write_config_byte(chip, 0x81, 1);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -563,7 +517,6 @@ int rtsx_reset_chip(struct rtsx_chip *chip)
 					   0xC0, 0xFF00, 0x0100);
 
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	}
@@ -571,13 +524,11 @@ int rtsx_reset_chip(struct rtsx_chip *chip)
 	if (CHECK_PID(chip, 0x5288) && !CHK_SDIO_EXIST(chip)) {
 		retval = rtsx_write_cfg_dw(chip, 2, 0xC0, 0xFFFF, 0x0103);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
 		retval = rtsx_write_cfg_dw(chip, 2, 0x84, 0xFF, 0x03);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	}
@@ -585,19 +536,16 @@ int rtsx_reset_chip(struct rtsx_chip *chip)
 	retval = rtsx_write_register(chip, IRQSTAT0, LINK_RDY_INT,
 				     LINK_RDY_INT);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 
 	retval = rtsx_write_register(chip, PERST_GLITCH_WIDTH, 0xFF, 0x80);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 
 	retval = rtsx_enable_pcie_intr(chip);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -622,7 +570,6 @@ int rtsx_reset_chip(struct rtsx_chip *chip)
 		retval = rtsx_pre_handle_sdio_old(chip);
 #endif  /* HW_AUTO_SWITCH_SD_BUS */
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
@@ -631,7 +578,6 @@ int rtsx_reset_chip(struct rtsx_chip *chip)
 		retval = rtsx_write_register(chip, SDIO_CTRL,
 					     SDIO_BUS_CTRL | SDIO_CD_CTRL, 0);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 	}
@@ -645,7 +591,6 @@ int rtsx_reset_chip(struct rtsx_chip *chip)
 		retval = rtsx_write_register(chip, SSC_CTL1, SSC_RSTB,
 					     SSC_RSTB);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 	}
@@ -655,7 +600,6 @@ int rtsx_reset_chip(struct rtsx_chip *chip)
 
 	retval = rtsx_write_register(chip, RCCTL, 0x01, 0x00);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 
@@ -664,7 +608,6 @@ int rtsx_reset_chip(struct rtsx_chip *chip)
 		retval = rtsx_write_register(chip, MAIN_PWR_OFF_CTL, 0x03,
 					     0x03);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 	}
@@ -672,26 +615,22 @@ int rtsx_reset_chip(struct rtsx_chip *chip)
 	if (chip->remote_wakeup_en && !chip->auto_delink_en) {
 		retval = rtsx_write_register(chip, WAKE_SEL_CTL, 0x07, 0x07);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 		if (chip->aux_pwr_exist) {
 			retval = rtsx_write_register(chip, PME_FORCE_CTL,
 						     0xFF, 0x33);
 			if (retval) {
-				rtsx_trace(chip);
 				return retval;
 			}
 		}
 	} else {
 		retval = rtsx_write_register(chip, WAKE_SEL_CTL, 0x07, 0x04);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 		retval = rtsx_write_register(chip, PME_FORCE_CTL, 0xFF, 0x30);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 	}
@@ -699,7 +638,6 @@ int rtsx_reset_chip(struct rtsx_chip *chip)
 	if (CHECK_PID(chip, 0x5208) && (chip->ic_version >= IC_VER_D)) {
 		retval = rtsx_write_register(chip, PETXCFG, 0x1C, 0x14);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 	}
@@ -707,7 +645,6 @@ int rtsx_reset_chip(struct rtsx_chip *chip)
 	if (chip->asic_code && CHECK_PID(chip, 0x5208)) {
 		retval = rtsx_clr_phy_reg_bit(chip, 0x1C, 2);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	}
@@ -717,14 +654,12 @@ int rtsx_reset_chip(struct rtsx_chip *chip)
 					     MS_PARTIAL_POWER_ON |
 					     SD_PARTIAL_POWER_ON);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 		udelay(chip->pmos_pwr_on_interval);
 		retval = rtsx_write_register(chip, CARD_PWR_CTL, 0xFF,
 					     MS_POWER_ON | SD_POWER_ON);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 
@@ -781,12 +716,10 @@ static int rts5208_init(struct rtsx_chip *chip)
 
 	retval = rtsx_write_register(chip, CLK_SEL, 0x03, 0x03);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 	retval = rtsx_read_register(chip, CLK_SEL, &val);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 	chip->asic_code = val == 0 ? 1 : 0;
@@ -794,7 +727,6 @@ static int rts5208_init(struct rtsx_chip *chip)
 	if (chip->asic_code) {
 		retval = rtsx_read_phy_register(chip, 0x1C, &reg);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
@@ -806,7 +738,6 @@ static int rts5208_init(struct rtsx_chip *chip)
 	} else {
 		retval = rtsx_read_register(chip, 0xFE80, &val);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 		chip->ic_version = val;
@@ -815,7 +746,6 @@ static int rts5208_init(struct rtsx_chip *chip)
 
 	retval = rtsx_read_register(chip, PDINFO, &val);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 	dev_dbg(rtsx_dev(chip), "PDINFO: 0x%x\n", val);
@@ -823,7 +753,6 @@ static int rts5208_init(struct rtsx_chip *chip)
 
 	retval = rtsx_read_register(chip, 0xFE50, &val);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 	chip->hw_bypass_sd = val & 0x01 ? 1 : 0;
@@ -837,7 +766,6 @@ static int rts5208_init(struct rtsx_chip *chip)
 	if (chip->use_hw_setting) {
 		retval = rtsx_read_register(chip, CHANGE_LINK_STATE, &val);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 		chip->auto_delink_en = val & 0x80 ? 1 : 0;
@@ -854,12 +782,10 @@ static int rts5288_init(struct rtsx_chip *chip)
 
 	retval = rtsx_write_register(chip, CLK_SEL, 0x03, 0x03);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 	retval = rtsx_read_register(chip, CLK_SEL, &val);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 	chip->asic_code = val == 0 ? 1 : 0;
@@ -869,7 +795,6 @@ static int rts5288_init(struct rtsx_chip *chip)
 
 	retval = rtsx_read_register(chip, PDINFO, &val);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 	dev_dbg(rtsx_dev(chip), "PDINFO: 0x%x\n", val);
@@ -877,7 +802,6 @@ static int rts5288_init(struct rtsx_chip *chip)
 
 	retval = rtsx_read_register(chip, CARD_SHARE_MODE, &val);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 	dev_dbg(rtsx_dev(chip), "CARD_SHARE_MODE: 0x%x\n", val);
@@ -885,14 +809,12 @@ static int rts5288_init(struct rtsx_chip *chip)
 
 	retval = rtsx_read_register(chip, 0xFE5A, &val);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 	chip->hw_bypass_sd = val & 0x10 ? 1 : 0;
 
 	retval = rtsx_read_cfg_dw(chip, 0, 0x718, &lval);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -906,7 +828,6 @@ static int rts5288_init(struct rtsx_chip *chip)
 	if (chip->use_hw_setting) {
 		retval = rtsx_read_register(chip, CHANGE_LINK_STATE, &val);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 		chip->auto_delink_en = val & 0x80 ? 1 : 0;
@@ -933,10 +854,6 @@ int rtsx_init_chip(struct rtsx_chip *chip)
 
 	chip->ic_version = 0;
 
-#ifdef _MSG_TRACE
-	chip->msg_idx = 0;
-#endif
-
 	memset(xd_card, 0, sizeof(struct xd_info));
 	memset(sd_card, 0, sizeof(struct sd_info));
 	memset(ms_card, 0, sizeof(struct ms_info));
@@ -989,13 +906,11 @@ int rtsx_init_chip(struct rtsx_chip *chip)
 
 	retval = rtsx_write_register(chip, FPDCTL, SSC_POWER_DOWN, 0);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 	wait_timeout(200);
 	retval = rtsx_write_register(chip, CLK_DIV, 0x07, 0x07);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 	dev_dbg(rtsx_dev(chip), "chip->use_hw_setting = %d\n",
@@ -1004,14 +919,12 @@ int rtsx_init_chip(struct rtsx_chip *chip)
 	if (CHECK_PID(chip, 0x5208)) {
 		retval = rts5208_init(chip);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
 	} else if (CHECK_PID(chip, 0x5288)) {
 		retval = rts5288_init(chip);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	}
@@ -1061,7 +974,6 @@ int rtsx_init_chip(struct rtsx_chip *chip)
 
 	retval = rtsx_reset_chip(chip);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -1492,7 +1404,6 @@ int rtsx_write_register(struct rtsx_chip *chip, u16 addr, u8 mask, u8 data)
 		val = rtsx_readl(chip, RTSX_HAIMR);
 		if ((val & BIT(31)) == 0) {
 			if (data != (u8)val) {
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 
@@ -1500,7 +1411,6 @@ int rtsx_write_register(struct rtsx_chip *chip, u16 addr, u8 mask, u8 data)
 		}
 	}
 
-	rtsx_trace(chip);
 	return STATUS_TIMEDOUT;
 }
 
@@ -1523,7 +1433,6 @@ int rtsx_read_register(struct rtsx_chip *chip, u16 addr, u8 *data)
 	}
 
 	if (i >= MAX_RW_REG_CNT) {
-		rtsx_trace(chip);
 		return STATUS_TIMEDOUT;
 	}
 
@@ -1546,7 +1455,6 @@ int rtsx_write_cfg_dw(struct rtsx_chip *chip, u8 func_no, u16 addr, u32 mask,
 						     0xFF,
 						     (u8)(val & mask & 0xFF));
 			if (retval) {
-				rtsx_trace(chip);
 				return retval;
 			}
 			mode |= (1 << i);
@@ -1558,13 +1466,11 @@ int rtsx_write_cfg_dw(struct rtsx_chip *chip, u8 func_no, u16 addr, u32 mask,
 	if (mode) {
 		retval = rtsx_write_register(chip, CFGADDR0, 0xFF, (u8)addr);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 		retval = rtsx_write_register(chip, CFGADDR1, 0xFF,
 					     (u8)(addr >> 8));
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 
@@ -1572,14 +1478,12 @@ int rtsx_write_cfg_dw(struct rtsx_chip *chip, u8 func_no, u16 addr, u32 mask,
 					     0x80 | mode |
 					     ((func_no & 0x03) << 4));
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 
 		for (i = 0; i < MAX_RW_REG_CNT; i++) {
 			retval = rtsx_read_register(chip, CFGRWCTL, &tmp);
 			if (retval) {
-				rtsx_trace(chip);
 				return retval;
 			}
 			if ((tmp & 0x80) == 0)
@@ -1599,25 +1503,21 @@ int rtsx_read_cfg_dw(struct rtsx_chip *chip, u8 func_no, u16 addr, u32 *val)
 
 	retval = rtsx_write_register(chip, CFGADDR0, 0xFF, (u8)addr);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 	retval = rtsx_write_register(chip, CFGADDR1, 0xFF, (u8)(addr >> 8));
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 	retval = rtsx_write_register(chip, CFGRWCTL, 0xFF,
 				     0x80 | ((func_no & 0x03) << 4));
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 
 	for (i = 0; i < MAX_RW_REG_CNT; i++) {
 		retval = rtsx_read_register(chip, CFGRWCTL, &tmp);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 		if ((tmp & 0x80) == 0)
@@ -1627,7 +1527,6 @@ int rtsx_read_cfg_dw(struct rtsx_chip *chip, u8 func_no, u16 addr, u32 *val)
 	for (i = 0; i < 4; i++) {
 		retval = rtsx_read_register(chip, CFGDATA0 + i, &tmp);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 		data |= (u32)tmp << (i * 8);
@@ -1649,7 +1548,6 @@ int rtsx_write_cfg_seq(struct rtsx_chip *chip, u8 func, u16 addr, u8 *buf,
 	int retval;
 
 	if (!buf) {
-		rtsx_trace(chip);
 		return STATUS_NOMEM;
 	}
 
@@ -1662,14 +1560,12 @@ int rtsx_write_cfg_seq(struct rtsx_chip *chip, u8 func, u16 addr, u8 *buf,
 
 	data = vzalloc(array_size(dw_len, 4));
 	if (!data) {
-		rtsx_trace(chip);
 		return STATUS_NOMEM;
 	}
 
 	mask = vzalloc(array_size(dw_len, 4));
 	if (!mask) {
 		vfree(data);
-		rtsx_trace(chip);
 		return STATUS_NOMEM;
 	}
 
@@ -1694,7 +1590,6 @@ int rtsx_write_cfg_seq(struct rtsx_chip *chip, u8 func, u16 addr, u8 *buf,
 		if (retval != STATUS_SUCCESS) {
 			vfree(data);
 			vfree(mask);
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	}
@@ -1723,7 +1618,6 @@ int rtsx_read_cfg_seq(struct rtsx_chip *chip, u8 func, u16 addr, u8 *buf,
 
 	data = vmalloc(array_size(dw_len, 4));
 	if (!data) {
-		rtsx_trace(chip);
 		return STATUS_NOMEM;
 	}
 
@@ -1732,7 +1626,6 @@ int rtsx_read_cfg_seq(struct rtsx_chip *chip, u8 func, u16 addr, u8 *buf,
 					  data + i);
 		if (retval != STATUS_SUCCESS) {
 			vfree(data);
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	}
@@ -1763,29 +1656,24 @@ int rtsx_write_phy_register(struct rtsx_chip *chip, u8 addr, u16 val)
 
 	retval = rtsx_write_register(chip, PHYDATA0, 0xFF, (u8)val);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 	retval = rtsx_write_register(chip, PHYDATA1, 0xFF, (u8)(val >> 8));
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 	retval = rtsx_write_register(chip, PHYADDR, 0xFF, addr);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 	retval = rtsx_write_register(chip, PHYRWCTL, 0xFF, 0x81);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 
 	for (i = 0; i < 100000; i++) {
 		retval = rtsx_read_register(chip, PHYRWCTL, &tmp);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 		if (!(tmp & 0x80)) {
@@ -1795,7 +1683,6 @@ int rtsx_write_phy_register(struct rtsx_chip *chip, u8 addr, u16 val)
 	}
 
 	if (!finished) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -1812,19 +1699,16 @@ int rtsx_read_phy_register(struct rtsx_chip *chip, u8 addr, u16 *val)
 
 	retval = rtsx_write_register(chip, PHYADDR, 0xFF, addr);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 	retval = rtsx_write_register(chip, PHYRWCTL, 0xFF, 0x80);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 
 	for (i = 0; i < 100000; i++) {
 		retval = rtsx_read_register(chip, PHYRWCTL, &tmp);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 		if (!(tmp & 0x80)) {
@@ -1834,19 +1718,16 @@ int rtsx_read_phy_register(struct rtsx_chip *chip, u8 addr, u16 *val)
 	}
 
 	if (!finished) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	retval = rtsx_read_register(chip, PHYDATA0, &tmp);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 	data = tmp;
 	retval = rtsx_read_register(chip, PHYDATA1, &tmp);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 	data |= (u16)tmp << 8;
@@ -1865,14 +1746,12 @@ int rtsx_read_efuse(struct rtsx_chip *chip, u8 addr, u8 *val)
 
 	retval = rtsx_write_register(chip, EFUSE_CTRL, 0xFF, 0x80 | addr);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 
 	for (i = 0; i < 100; i++) {
 		retval = rtsx_read_register(chip, EFUSE_CTRL, &data);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 		if (!(data & 0x80))
@@ -1881,13 +1760,11 @@ int rtsx_read_efuse(struct rtsx_chip *chip, u8 addr, u8 *val)
 	}
 
 	if (data & 0x80) {
-		rtsx_trace(chip);
 		return STATUS_TIMEDOUT;
 	}
 
 	retval = rtsx_read_register(chip, EFUSE_DATA, &data);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 	if (val)
@@ -1911,20 +1788,17 @@ int rtsx_write_efuse(struct rtsx_chip *chip, u8 addr, u8 val)
 
 		retval = rtsx_write_register(chip, EFUSE_DATA, 0xFF, tmp);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 		retval = rtsx_write_register(chip, EFUSE_CTRL, 0xFF,
 					     0xA0 | addr);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 
 		for (j = 0; j < 100; j++) {
 			retval = rtsx_read_register(chip, EFUSE_CTRL, &data);
 			if (retval) {
-				rtsx_trace(chip);
 				return retval;
 			}
 			if (!(data & 0x80))
@@ -1933,7 +1807,6 @@ int rtsx_write_efuse(struct rtsx_chip *chip, u8 addr, u8 val)
 		}
 
 		if (data & 0x80) {
-			rtsx_trace(chip);
 			return STATUS_TIMEDOUT;
 		}
 
@@ -1950,7 +1823,6 @@ int rtsx_clr_phy_reg_bit(struct rtsx_chip *chip, u8 reg, u8 bit)
 
 	retval = rtsx_read_phy_register(chip, reg, &value);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -1958,7 +1830,6 @@ int rtsx_clr_phy_reg_bit(struct rtsx_chip *chip, u8 reg, u8 bit)
 		value &= ~(1 << bit);
 		retval = rtsx_write_phy_register(chip, reg, value);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	}
@@ -1973,7 +1844,6 @@ int rtsx_set_phy_reg_bit(struct rtsx_chip *chip, u8 reg, u8 bit)
 
 	retval = rtsx_read_phy_register(chip, reg, &value);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -1981,7 +1851,6 @@ int rtsx_set_phy_reg_bit(struct rtsx_chip *chip, u8 reg, u8 bit)
 		value |= (1 << bit);
 		retval = rtsx_write_phy_register(chip, reg, value);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	}
@@ -2285,7 +2154,6 @@ int rtsx_read_ppbuf(struct rtsx_chip *chip, u8 *buf, int buf_len)
 	u8 *ptr;
 
 	if (!buf) {
-		rtsx_trace(chip);
 		return STATUS_ERROR;
 	}
 
@@ -2299,7 +2167,6 @@ int rtsx_read_ppbuf(struct rtsx_chip *chip, u8 *buf, int buf_len)
 
 		retval = rtsx_send_cmd(chip, 0, 250);
 		if (retval < 0) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
@@ -2315,7 +2182,6 @@ int rtsx_read_ppbuf(struct rtsx_chip *chip, u8 *buf, int buf_len)
 
 		retval = rtsx_send_cmd(chip, 0, 250);
 		if (retval < 0) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	}
@@ -2333,7 +2199,6 @@ int rtsx_write_ppbuf(struct rtsx_chip *chip, u8 *buf, int buf_len)
 	u8 *ptr;
 
 	if (!buf) {
-		rtsx_trace(chip);
 		return STATUS_ERROR;
 	}
 
@@ -2350,7 +2215,6 @@ int rtsx_write_ppbuf(struct rtsx_chip *chip, u8 *buf, int buf_len)
 
 		retval = rtsx_send_cmd(chip, 0, 250);
 		if (retval < 0) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	}
@@ -2366,7 +2230,6 @@ int rtsx_write_ppbuf(struct rtsx_chip *chip, u8 *buf, int buf_len)
 
 		retval = rtsx_send_cmd(chip, 0, 250);
 		if (retval < 0) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	}
@@ -2377,7 +2240,6 @@ int rtsx_write_ppbuf(struct rtsx_chip *chip, u8 *buf, int buf_len)
 int rtsx_check_chip_exist(struct rtsx_chip *chip)
 {
 	if (rtsx_readl(chip, 0) == 0xFFFFFFFF) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -2403,7 +2265,6 @@ int rtsx_force_power_on(struct rtsx_chip *chip, u8 ctl)
 	if (mask) {
 		retval = rtsx_write_register(chip, FPDCTL, mask, 0);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
@@ -2434,7 +2295,6 @@ int rtsx_force_power_down(struct rtsx_chip *chip, u8 ctl)
 		val = mask;
 		retval = rtsx_write_register(chip, FPDCTL, mask, val);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	}
diff --git a/drivers/staging/rts5208/rtsx_chip.h b/drivers/staging/rts5208/rtsx_chip.h
index 8a8cd5d3cf7e..ec1c3d96d31a 100644
--- a/drivers/staging/rts5208/rtsx_chip.h
+++ b/drivers/staging/rts5208/rtsx_chip.h
@@ -644,19 +644,6 @@ struct spi_info {
 	int spi_clock;
 };
 
-#ifdef _MSG_TRACE
-struct trace_msg_t {
-	u16 line;
-#define MSG_FUNC_LEN 64
-	char func[MSG_FUNC_LEN];
-#define MSG_FILE_LEN 32
-	char file[MSG_FILE_LEN];
-#define TIME_VAL_LEN 16
-	u8 timeval_buf[TIME_VAL_LEN];
-	u8 valid;
-};
-#endif
-
 /************/
 /* LUN mode */
 /************/
@@ -798,11 +785,6 @@ struct rtsx_chip {
 
 	struct spi_info		spi;
 
-#ifdef _MSG_TRACE
-	struct trace_msg_t	trace_msg[TRACE_ITEM_CNT];
-	int			msg_idx;
-#endif
-
 	int			auto_delink_cnt;
 	int			auto_delink_allowed;
 
diff --git a/drivers/staging/rts5208/rtsx_scsi.c b/drivers/staging/rts5208/rtsx_scsi.c
index a401b13f5f5e..c9a6d97938f6 100644
--- a/drivers/staging/rts5208/rtsx_scsi.c
+++ b/drivers/staging/rts5208/rtsx_scsi.c
@@ -508,7 +508,6 @@ static int inquiry(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 	buf = vmalloc(scsi_bufflen(srb));
 	if (!buf) {
-		rtsx_trace(chip);
 		return TRANSPORT_ERROR;
 	}
 
@@ -583,13 +582,11 @@ static int start_stop_unit(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 		if (check_card_ready(chip, lun))
 			return TRANSPORT_GOOD;
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_NOT_PRESENT);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 
 		break;
 	}
 
-	rtsx_trace(chip);
 	return TRANSPORT_ERROR;
 }
 
@@ -604,7 +601,6 @@ static int allow_medium_removal(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	if (prevent) {
 		set_sense_type(chip, SCSI_LUN(srb),
 			       SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
@@ -642,7 +638,6 @@ static int request_sense(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 	buf = vmalloc(scsi_bufflen(srb));
 	if (!buf) {
-		rtsx_trace(chip);
 		return TRANSPORT_ERROR;
 	}
 
@@ -764,7 +759,6 @@ static int mode_sense(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	if (!check_card_ready(chip, lun)) {
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_NOT_PRESENT);
 		scsi_set_resid(srb, scsi_bufflen(srb));
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 #endif
@@ -790,7 +784,6 @@ static int mode_sense(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 	buf = kmalloc(data_size, GFP_KERNEL);
 	if (!buf) {
-		rtsx_trace(chip);
 		return TRANSPORT_ERROR;
 	}
 
@@ -871,7 +864,6 @@ static int read_write(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 	if (!check_card_ready(chip, lun) || (get_card_size(chip, lun) == 0)) {
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_NOT_PRESENT);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
@@ -888,7 +880,6 @@ static int read_write(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 		 */
 		dev_dbg(rtsx_dev(chip), "SD card being erased!\n");
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_READ_FORBIDDEN);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
@@ -897,7 +888,6 @@ static int read_write(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 			dev_dbg(rtsx_dev(chip), "SD card locked!\n");
 			set_sense_type(chip, lun,
 				       SENSE_TYPE_MEDIA_READ_FORBIDDEN);
-			rtsx_trace(chip);
 			return TRANSPORT_FAILED;
 		}
 	}
@@ -923,7 +913,6 @@ static int read_write(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 		sec_cnt = ((u16)(srb->cmnd[9]) << 8) | srb->cmnd[10];
 	} else {
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
@@ -934,7 +923,6 @@ static int read_write(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	if ((start_sec > get_card_size(chip, lun)) ||
 	    ((start_sec + sec_cnt) > get_card_size(chip, lun))) {
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_LBA_OVER_RANGE);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
@@ -951,7 +939,6 @@ static int read_write(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 		else
 			set_sense_type(chip, lun, SENSE_TYPE_MEDIA_WRITE_ERR);
 
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
@@ -960,7 +947,6 @@ static int read_write(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 			dev_dbg(rtsx_dev(chip), "Write protected card!\n");
 			set_sense_type(chip, lun,
 				       SENSE_TYPE_MEDIA_WRITE_PROTECT);
-			rtsx_trace(chip);
 			return TRANSPORT_FAILED;
 		}
 	}
@@ -981,7 +967,6 @@ static int read_write(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 					       SENSE_TYPE_MEDIA_WRITE_ERR);
 		}
 		retval = TRANSPORT_FAILED;
-		rtsx_trace(chip);
 		goto exit;
 	} else {
 		chip->rw_fail_cnt[lun] = 0;
@@ -1007,7 +992,6 @@ static int read_format_capacity(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	if (!check_card_ready(chip, lun)) {
 		if (!chip->mspro_formatter_enable) {
 			set_sense_type(chip, lun, SENSE_TYPE_MEDIA_NOT_PRESENT);
-			rtsx_trace(chip);
 			return TRANSPORT_FAILED;
 		}
 	}
@@ -1016,7 +1000,6 @@ static int read_format_capacity(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 	buf = kmalloc(buf_len, GFP_KERNEL);
 	if (!buf) {
-		rtsx_trace(chip);
 		return TRANSPORT_ERROR;
 	}
 
@@ -1083,7 +1066,6 @@ static int read_capacity(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 	if (!check_card_ready(chip, lun)) {
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_NOT_PRESENT);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
@@ -1095,7 +1077,6 @@ static int read_capacity(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 	buf = kmalloc(8, GFP_KERNEL);
 	if (!buf) {
-		rtsx_trace(chip);
 		return TRANSPORT_ERROR;
 	}
 
@@ -1136,7 +1117,6 @@ static int read_eeprom(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 	buf = vmalloc(len);
 	if (!buf) {
-		rtsx_trace(chip);
 		return TRANSPORT_ERROR;
 	}
 
@@ -1145,7 +1125,6 @@ static int read_eeprom(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 		vfree(buf);
 		set_sense_type(chip, SCSI_LUN(srb),
 			       SENSE_TYPE_MEDIA_UNRECOVER_READ_ERR);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
@@ -1155,7 +1134,6 @@ static int read_eeprom(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 			vfree(buf);
 			set_sense_type(chip, SCSI_LUN(srb),
 				       SENSE_TYPE_MEDIA_UNRECOVER_READ_ERR);
-			rtsx_trace(chip);
 			return TRANSPORT_FAILED;
 		}
 	}
@@ -1188,7 +1166,6 @@ static int write_eeprom(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	retval = rtsx_force_power_on(chip, SSC_PDCTL);
 	if (retval != STATUS_SUCCESS) {
 		set_sense_type(chip, SCSI_LUN(srb), SENSE_TYPE_MEDIA_WRITE_ERR);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
@@ -1197,7 +1174,6 @@ static int write_eeprom(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 		if (retval != STATUS_SUCCESS) {
 			set_sense_type(chip, SCSI_LUN(srb),
 				       SENSE_TYPE_MEDIA_WRITE_ERR);
-			rtsx_trace(chip);
 			return TRANSPORT_FAILED;
 		}
 	} else {
@@ -1205,7 +1181,6 @@ static int write_eeprom(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 					len);
 		buf = vmalloc(len);
 		if (!buf) {
-			rtsx_trace(chip);
 			return TRANSPORT_ERROR;
 		}
 
@@ -1218,7 +1193,6 @@ static int write_eeprom(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 				vfree(buf);
 				set_sense_type(chip, SCSI_LUN(srb),
 					       SENSE_TYPE_MEDIA_WRITE_ERR);
-				rtsx_trace(chip);
 				return TRANSPORT_FAILED;
 			}
 		}
@@ -1249,13 +1223,11 @@ static int read_mem(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	if (addr < 0xFC00) {
 		set_sense_type(chip, SCSI_LUN(srb),
 			       SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
 	buf = vmalloc(len);
 	if (!buf) {
-		rtsx_trace(chip);
 		return TRANSPORT_ERROR;
 	}
 
@@ -1263,7 +1235,6 @@ static int read_mem(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	if (retval != STATUS_SUCCESS) {
 		vfree(buf);
 		set_sense_type(chip, SCSI_LUN(srb), SENSE_TYPE_MEDIA_WRITE_ERR);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
@@ -1273,7 +1244,6 @@ static int read_mem(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 			vfree(buf);
 			set_sense_type(chip, SCSI_LUN(srb),
 				       SENSE_TYPE_MEDIA_UNRECOVER_READ_ERR);
-			rtsx_trace(chip);
 			return TRANSPORT_FAILED;
 		}
 	}
@@ -1307,14 +1277,12 @@ static int write_mem(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	if (addr < 0xFC00) {
 		set_sense_type(chip, SCSI_LUN(srb),
 			       SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
 	len = (unsigned short)min_t(unsigned int, scsi_bufflen(srb), len);
 	buf = vmalloc(len);
 	if (!buf) {
-		rtsx_trace(chip);
 		return TRANSPORT_ERROR;
 	}
 
@@ -1325,7 +1293,6 @@ static int write_mem(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	if (retval != STATUS_SUCCESS) {
 		vfree(buf);
 		set_sense_type(chip, SCSI_LUN(srb), SENSE_TYPE_MEDIA_WRITE_ERR);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
@@ -1335,7 +1302,6 @@ static int write_mem(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 			vfree(buf);
 			set_sense_type(chip, SCSI_LUN(srb),
 				       SENSE_TYPE_MEDIA_WRITE_ERR);
-			rtsx_trace(chip);
 			return TRANSPORT_FAILED;
 		}
 	}
@@ -1352,13 +1318,11 @@ static int get_sd_csd(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 	if (!check_card_ready(chip, lun)) {
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_NOT_PRESENT);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
 	if (get_lun_card(chip, lun) != SD_CARD) {
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_UNRECOVER_READ_ERR);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
@@ -1387,77 +1351,6 @@ static int toggle_gpio_cmd(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	return TRANSPORT_GOOD;
 }
 
-#ifdef _MSG_TRACE
-static int trace_msg_cmd(struct scsi_cmnd *srb, struct rtsx_chip *chip)
-{
-	unsigned char *ptr, *buf = NULL;
-	int i, msg_cnt;
-	u8 clear;
-	unsigned int buf_len;
-
-	buf_len = 4 + ((2 + MSG_FUNC_LEN + MSG_FILE_LEN + TIME_VAL_LEN) *
-		TRACE_ITEM_CNT);
-
-	if ((scsi_bufflen(srb) < buf_len) || !scsi_sglist(srb)) {
-		set_sense_type(chip, SCSI_LUN(srb),
-			       SENSE_TYPE_MEDIA_UNRECOVER_READ_ERR);
-		rtsx_trace(chip);
-		return TRANSPORT_FAILED;
-	}
-
-	clear = srb->cmnd[2];
-
-	buf = vmalloc(scsi_bufflen(srb));
-	if (!buf) {
-		rtsx_trace(chip);
-		return TRANSPORT_ERROR;
-	}
-	ptr = buf;
-
-	if (chip->trace_msg[chip->msg_idx].valid)
-		msg_cnt = TRACE_ITEM_CNT;
-	else
-		msg_cnt = chip->msg_idx;
-
-	*(ptr++) = (u8)(msg_cnt >> 24);
-	*(ptr++) = (u8)(msg_cnt >> 16);
-	*(ptr++) = (u8)(msg_cnt >> 8);
-	*(ptr++) = (u8)msg_cnt;
-	dev_dbg(rtsx_dev(chip), "Trace message count is %d\n", msg_cnt);
-
-	for (i = 1; i <= msg_cnt; i++) {
-		int j, idx;
-
-		idx = chip->msg_idx - i;
-		if (idx < 0)
-			idx += TRACE_ITEM_CNT;
-
-		*(ptr++) = (u8)(chip->trace_msg[idx].line >> 8);
-		*(ptr++) = (u8)(chip->trace_msg[idx].line);
-		for (j = 0; j < MSG_FUNC_LEN; j++)
-			*(ptr++) = chip->trace_msg[idx].func[j];
-
-		for (j = 0; j < MSG_FILE_LEN; j++)
-			*(ptr++) = chip->trace_msg[idx].file[j];
-
-		for (j = 0; j < TIME_VAL_LEN; j++)
-			*(ptr++) = chip->trace_msg[idx].timeval_buf[j];
-	}
-
-	rtsx_stor_set_xfer_buf(buf, scsi_bufflen(srb), srb);
-	vfree(buf);
-
-	if (clear) {
-		chip->msg_idx = 0;
-		for (i = 0; i < TRACE_ITEM_CNT; i++)
-			chip->trace_msg[i].valid = 0;
-	}
-
-	scsi_set_resid(srb, 0);
-	return TRANSPORT_GOOD;
-}
-#endif
-
 static int read_host_reg(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 {
 	u8 addr, buf[4];
@@ -1543,7 +1436,6 @@ static int set_variable(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 		default:
 			set_sense_type(chip, lun,
 				       SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
-			rtsx_trace(chip);
 			return TRANSPORT_FAILED;
 		}
 	} else if (srb->cmnd[3] == 2) {
@@ -1567,7 +1459,6 @@ static int set_variable(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 			if (retval != STATUS_SUCCESS) {
 				set_sense_type(chip, SCSI_LUN(srb),
 					       SENSE_TYPE_MEDIA_WRITE_ERR);
-				rtsx_trace(chip);
 				return TRANSPORT_FAILED;
 			}
 
@@ -1575,7 +1466,6 @@ static int set_variable(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 		}
 	} else {
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
@@ -1608,7 +1498,6 @@ static int get_variable(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 		default:
 			set_sense_type(chip, lun,
 				       SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
-			rtsx_trace(chip);
 			return TRANSPORT_FAILED;
 		}
 
@@ -1619,7 +1508,6 @@ static int get_variable(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 		rtsx_stor_set_xfer_buf(&tmp, 1, srb);
 	} else {
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
@@ -1659,7 +1547,6 @@ static int dma_access_ring_buffer(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 			set_sense_type(chip, lun,
 				       SENSE_TYPE_MEDIA_WRITE_ERR);
 
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 	scsi_set_resid(srb, 0);
@@ -1807,7 +1694,6 @@ static int set_chip_mode(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	if (!CHECK_PID(chip, 0x5208)) {
 		set_sense_type(chip, SCSI_LUN(srb),
 			       SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
@@ -1817,7 +1703,6 @@ static int set_chip_mode(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 		chip->phy_debug_mode = 1;
 		retval = rtsx_write_register(chip, CDRESUMECTL, 0x77, 0);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return TRANSPORT_FAILED;
 		}
 
@@ -1825,21 +1710,18 @@ static int set_chip_mode(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 		retval = rtsx_read_phy_register(chip, 0x1C, &reg);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return TRANSPORT_FAILED;
 		}
 
 		reg |= 0x0001;
 		retval = rtsx_write_phy_register(chip, 0x1C, reg);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return TRANSPORT_FAILED;
 		}
 	} else {
 		chip->phy_debug_mode = 0;
 		retval = rtsx_write_register(chip, CDRESUMECTL, 0x77, 0x77);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return TRANSPORT_FAILED;
 		}
 
@@ -1847,14 +1729,12 @@ static int set_chip_mode(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 		retval = rtsx_read_phy_register(chip, 0x1C, &reg);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return TRANSPORT_FAILED;
 		}
 
 		reg &= 0xFFFE;
 		retval = rtsx_write_phy_register(chip, 0x1C, reg);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return TRANSPORT_FAILED;
 		}
 	}
@@ -1887,7 +1767,6 @@ static int rw_mem_cmd_buf(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 		if (cmd_type > 2) {
 			set_sense_type(chip, lun,
 				       SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
-			rtsx_trace(chip);
 			return TRANSPORT_FAILED;
 		}
 		addr = (srb->cmnd[5] << 8) | srb->cmnd[6];
@@ -1906,7 +1785,6 @@ static int rw_mem_cmd_buf(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 		if (scsi_bufflen(srb) < 1) {
 			set_sense_type(chip, lun,
 				       SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
-			rtsx_trace(chip);
 			return TRANSPORT_FAILED;
 		}
 		rtsx_stor_set_xfer_buf(&value, 1, srb);
@@ -1915,13 +1793,11 @@ static int rw_mem_cmd_buf(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 	default:
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
 	if (retval != STATUS_SUCCESS) {
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_WRITE_ERR);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
@@ -1965,7 +1841,6 @@ static int read_phy_register(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	if (len) {
 		buf = vmalloc(len);
 		if (!buf) {
-			rtsx_trace(chip);
 			return TRANSPORT_ERROR;
 		}
 
@@ -1974,7 +1849,6 @@ static int read_phy_register(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 			vfree(buf);
 			set_sense_type(chip, SCSI_LUN(srb),
 				       SENSE_TYPE_MEDIA_UNRECOVER_READ_ERR);
-			rtsx_trace(chip);
 			return TRANSPORT_FAILED;
 		}
 
@@ -1985,7 +1859,6 @@ static int read_phy_register(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 				set_sense_type
 					(chip, SCSI_LUN(srb),
 					 SENSE_TYPE_MEDIA_UNRECOVER_READ_ERR);
-				rtsx_trace(chip);
 				return TRANSPORT_FAILED;
 			}
 
@@ -2031,7 +1904,6 @@ static int write_phy_register(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 		buf = vmalloc(len);
 		if (!buf) {
-			rtsx_trace(chip);
 			return TRANSPORT_ERROR;
 		}
 
@@ -2043,7 +1915,6 @@ static int write_phy_register(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 			vfree(buf);
 			set_sense_type(chip, SCSI_LUN(srb),
 				       SENSE_TYPE_MEDIA_WRITE_ERR);
-			rtsx_trace(chip);
 			return TRANSPORT_FAILED;
 		}
 
@@ -2054,7 +1925,6 @@ static int write_phy_register(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 				vfree(buf);
 				set_sense_type(chip, SCSI_LUN(srb),
 					       SENSE_TYPE_MEDIA_WRITE_ERR);
-				rtsx_trace(chip);
 				return TRANSPORT_FAILED;
 			}
 		}
@@ -2082,7 +1952,6 @@ static int erase_eeprom2(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	retval = rtsx_force_power_on(chip, SSC_PDCTL);
 	if (retval != STATUS_SUCCESS) {
 		set_sense_type(chip, SCSI_LUN(srb), SENSE_TYPE_MEDIA_WRITE_ERR);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
@@ -2094,7 +1963,6 @@ static int erase_eeprom2(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 		if (retval != STATUS_SUCCESS) {
 			set_sense_type(chip, SCSI_LUN(srb),
 				       SENSE_TYPE_MEDIA_WRITE_ERR);
-			rtsx_trace(chip);
 			return TRANSPORT_FAILED;
 		}
 	} else if (mode == 1) {
@@ -2102,13 +1970,11 @@ static int erase_eeprom2(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 		if (retval != STATUS_SUCCESS) {
 			set_sense_type(chip, SCSI_LUN(srb),
 				       SENSE_TYPE_MEDIA_WRITE_ERR);
-			rtsx_trace(chip);
 			return TRANSPORT_FAILED;
 		}
 	} else {
 		set_sense_type(chip, SCSI_LUN(srb),
 			       SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
@@ -2134,7 +2000,6 @@ static int read_eeprom2(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 	buf = vmalloc(len);
 	if (!buf) {
-		rtsx_trace(chip);
 		return TRANSPORT_ERROR;
 	}
 
@@ -2143,7 +2008,6 @@ static int read_eeprom2(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 		vfree(buf);
 		set_sense_type(chip, SCSI_LUN(srb),
 			       SENSE_TYPE_MEDIA_UNRECOVER_READ_ERR);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
@@ -2153,7 +2017,6 @@ static int read_eeprom2(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 			vfree(buf);
 			set_sense_type(chip, SCSI_LUN(srb),
 				       SENSE_TYPE_MEDIA_UNRECOVER_READ_ERR);
-			rtsx_trace(chip);
 			return TRANSPORT_FAILED;
 		}
 	}
@@ -2187,7 +2050,6 @@ static int write_eeprom2(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	len = (unsigned short)min_t(unsigned int, scsi_bufflen(srb), len);
 	buf = vmalloc(len);
 	if (!buf) {
-		rtsx_trace(chip);
 		return TRANSPORT_ERROR;
 	}
 
@@ -2198,7 +2060,6 @@ static int write_eeprom2(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	if (retval != STATUS_SUCCESS) {
 		vfree(buf);
 		set_sense_type(chip, SCSI_LUN(srb), SENSE_TYPE_MEDIA_WRITE_ERR);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
@@ -2208,7 +2069,6 @@ static int write_eeprom2(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 			vfree(buf);
 			set_sense_type(chip, SCSI_LUN(srb),
 				       SENSE_TYPE_MEDIA_WRITE_ERR);
-			rtsx_trace(chip);
 			return TRANSPORT_FAILED;
 		}
 	}
@@ -2237,7 +2097,6 @@ static int read_efuse(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 	buf = vmalloc(len);
 	if (!buf) {
-		rtsx_trace(chip);
 		return TRANSPORT_ERROR;
 	}
 
@@ -2246,7 +2105,6 @@ static int read_efuse(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 		vfree(buf);
 		set_sense_type(chip, SCSI_LUN(srb),
 			       SENSE_TYPE_MEDIA_UNRECOVER_READ_ERR);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
@@ -2256,7 +2114,6 @@ static int read_efuse(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 			vfree(buf);
 			set_sense_type(chip, SCSI_LUN(srb),
 				       SENSE_TYPE_MEDIA_UNRECOVER_READ_ERR);
-			rtsx_trace(chip);
 			return TRANSPORT_FAILED;
 		}
 	}
@@ -2291,7 +2148,6 @@ static int write_efuse(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	len = (u8)min_t(unsigned int, scsi_bufflen(srb), len);
 	buf = vmalloc(len);
 	if (!buf) {
-		rtsx_trace(chip);
 		return TRANSPORT_ERROR;
 	}
 
@@ -2301,7 +2157,6 @@ static int write_efuse(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	retval = rtsx_force_power_on(chip, SSC_PDCTL);
 	if (retval != STATUS_SUCCESS) {
 		vfree(buf);
-		rtsx_trace(chip);
 		return TRANSPORT_ERROR;
 	}
 
@@ -2309,7 +2164,6 @@ static int write_efuse(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 		retval = rtsx_read_phy_register(chip, 0x08, &val);
 		if (retval != STATUS_SUCCESS) {
 			vfree(buf);
-			rtsx_trace(chip);
 			return TRANSPORT_ERROR;
 		}
 
@@ -2317,7 +2171,6 @@ static int write_efuse(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 					     LDO3318_PWR_MASK, LDO_OFF);
 		if (retval != STATUS_SUCCESS) {
 			vfree(buf);
-			rtsx_trace(chip);
 			return TRANSPORT_ERROR;
 		}
 
@@ -2327,7 +2180,6 @@ static int write_efuse(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 						 0x4C00 | chip->phy_voltage);
 		if (retval != STATUS_SUCCESS) {
 			vfree(buf);
-			rtsx_trace(chip);
 			return TRANSPORT_ERROR;
 		}
 
@@ -2335,7 +2187,6 @@ static int write_efuse(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 					     LDO3318_PWR_MASK, LDO_ON);
 		if (retval != STATUS_SUCCESS) {
 			vfree(buf);
-			rtsx_trace(chip);
 			return TRANSPORT_ERROR;
 		}
 
@@ -2345,7 +2196,6 @@ static int write_efuse(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	retval = card_power_on(chip, SPI_CARD);
 	if (retval != STATUS_SUCCESS) {
 		vfree(buf);
-		rtsx_trace(chip);
 		return TRANSPORT_ERROR;
 	}
 
@@ -2357,7 +2207,6 @@ static int write_efuse(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 			set_sense_type(chip, SCSI_LUN(srb),
 				       SENSE_TYPE_MEDIA_WRITE_ERR);
 			result = TRANSPORT_FAILED;
-			rtsx_trace(chip);
 			goto exit;
 		}
 	}
@@ -2367,7 +2216,6 @@ static int write_efuse(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 	retval = card_power_off(chip, SPI_CARD);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return TRANSPORT_ERROR;
 	}
 
@@ -2375,7 +2223,6 @@ static int write_efuse(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 		retval = rtsx_write_register(chip, PWR_GATE_CTRL,
 					     LDO3318_PWR_MASK, LDO_OFF);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return TRANSPORT_ERROR;
 		}
 
@@ -2383,14 +2230,12 @@ static int write_efuse(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 		retval = rtsx_write_phy_register(chip, 0x08, val);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return TRANSPORT_ERROR;
 		}
 
 		retval = rtsx_write_register(chip, PWR_GATE_CTRL,
 					     LDO3318_PWR_MASK, LDO_ON);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return TRANSPORT_ERROR;
 		}
 	}
@@ -2429,13 +2274,11 @@ static int read_cfg_byte(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	if (func > func_max) {
 		set_sense_type(chip, SCSI_LUN(srb),
 			       SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
 	buf = vmalloc(len);
 	if (!buf) {
-		rtsx_trace(chip);
 		return TRANSPORT_ERROR;
 	}
 
@@ -2444,7 +2287,6 @@ static int read_cfg_byte(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 		set_sense_type(chip, SCSI_LUN(srb),
 			       SENSE_TYPE_MEDIA_UNRECOVER_READ_ERR);
 		vfree(buf);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
@@ -2488,14 +2330,12 @@ static int write_cfg_byte(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	if (func > func_max) {
 		set_sense_type(chip, SCSI_LUN(srb),
 			       SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
 	len = (unsigned short)min_t(unsigned int, scsi_bufflen(srb), len);
 	buf = vmalloc(len);
 	if (!buf) {
-		rtsx_trace(chip);
 		return TRANSPORT_ERROR;
 	}
 
@@ -2506,7 +2346,6 @@ static int write_cfg_byte(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	if (retval != STATUS_SUCCESS) {
 		set_sense_type(chip, SCSI_LUN(srb), SENSE_TYPE_MEDIA_WRITE_ERR);
 		vfree(buf);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
@@ -2597,7 +2436,6 @@ static int app_cmd(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	default:
 		set_sense_type(chip, SCSI_LUN(srb),
 			       SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
@@ -2740,7 +2578,6 @@ static int get_card_bus_width(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 	if (!check_card_ready(chip, lun)) {
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_NOT_PRESENT);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
@@ -2749,7 +2586,6 @@ static int get_card_bus_width(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 		bus_width = chip->card_bus_width[lun];
 	} else {
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_UNRECOVER_READ_ERR);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
@@ -2767,7 +2603,6 @@ static int spi_vendor_cmd(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 	if (CHECK_PID(chip, 0x5208) || CHECK_PID(chip, 0x5288)) {
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
@@ -2817,14 +2652,12 @@ static int spi_vendor_cmd(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 		rtsx_write_register(chip, CARD_GPIO_DIR, 0x07, gpio_dir);
 
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
 	rtsx_write_register(chip, CARD_GPIO_DIR, 0x07, gpio_dir);
 
 	if (result != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
@@ -2868,12 +2701,6 @@ static int vendor_cmnd(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 		result = get_card_bus_width(srb, chip);
 		break;
 
-#ifdef _MSG_TRACE
-	case TRACE_MSG:
-		result = trace_msg_cmd(srb, chip);
-		break;
-#endif
-
 	case SCSI_APP_CMD:
 		result = app_cmd(srb, chip);
 		break;
@@ -2885,7 +2712,6 @@ static int vendor_cmnd(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	default:
 		set_sense_type(chip, SCSI_LUN(srb),
 			       SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
@@ -2926,7 +2752,6 @@ static int ms_format_cmnd(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 	if (get_lun_card(chip, lun) != MS_CARD) {
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_LUN_NOT_SUPPORT);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
@@ -2934,7 +2759,6 @@ static int ms_format_cmnd(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	    (srb->cmnd[5] != 0x66) || (srb->cmnd[6] != 0x6D) ||
 		(srb->cmnd[7] != 0x74)) {
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
@@ -2947,7 +2771,6 @@ static int ms_format_cmnd(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 		if (!check_card_ready(chip, lun) ||
 		    (get_card_size(chip, lun) == 0)) {
 			set_sense_type(chip, lun, SENSE_TYPE_MEDIA_NOT_PRESENT);
-			rtsx_trace(chip);
 			return TRANSPORT_FAILED;
 		}
 	}
@@ -2960,26 +2783,22 @@ static int ms_format_cmnd(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 	if (!(chip->card_ready & MS_CARD)) {
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_NOT_PRESENT);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
 	if (chip->card_wp & MS_CARD) {
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_WRITE_PROTECT);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
 	if (!CHK_MSPRO(ms_card)) {
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_LUN_NOT_SUPPORT);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
 	retval = mspro_format(srb, chip, MS_SHORT_DATA_LEN, quick_format);
 	if (retval != STATUS_SUCCESS) {
 		set_sense_type(chip, lun, SENSE_TYPE_FORMAT_CMD_FAILED);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
@@ -2999,12 +2818,10 @@ static int get_ms_information(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 	if (!check_card_ready(chip, lun)) {
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_NOT_PRESENT);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 	if (get_lun_card(chip, lun) != MS_CARD) {
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_LUN_NOT_SUPPORT);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
@@ -3012,7 +2829,6 @@ static int get_ms_information(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	    (srb->cmnd[5] != 0x53) || (srb->cmnd[6] != 0x49) ||
 	    (srb->cmnd[7] != 0x44)) {
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
@@ -3021,7 +2837,6 @@ static int get_ms_information(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	    (!CHK_MSXC(ms_card) && (dev_info_id == 0x13)) ||
 	    !CHK_MSPRO(ms_card)) {
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
@@ -3035,7 +2850,6 @@ static int get_ms_information(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 	buf = kmalloc(buf_len, GFP_KERNEL);
 	if (!buf) {
-		rtsx_trace(chip);
 		return TRANSPORT_ERROR;
 	}
 
@@ -3124,12 +2938,10 @@ static int sd_extension_cmnd(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 	if (!check_card_ready(chip, lun)) {
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_NOT_PRESENT);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 	if (get_lun_card(chip, lun) != SD_CARD) {
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_LUN_NOT_SUPPORT);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
@@ -3160,7 +2972,6 @@ static int sd_extension_cmnd(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 	default:
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
@@ -3188,24 +2999,20 @@ static int mg_report_key(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 	if (!check_card_ready(chip, lun)) {
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_NOT_PRESENT);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 	if (get_lun_card(chip, lun) != MS_CARD) {
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_LUN_NOT_SUPPORT);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
 	if (srb->cmnd[7] != KC_MG_R_PRO) {
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
 	if (!CHK_MSPRO(ms_card)) {
 		set_sense_type(chip, lun, SENSE_TYPE_MG_INCOMPATIBLE_MEDIUM);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
@@ -3219,14 +3026,12 @@ static int mg_report_key(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 		    (srb->cmnd[9] == 0x1C)) {
 			retval = mg_get_local_EKB(srb, chip);
 			if (retval != STATUS_SUCCESS) {
-				rtsx_trace(chip);
 				return TRANSPORT_FAILED;
 			}
 
 		} else {
 			set_sense_type(chip, lun,
 				       SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
-			rtsx_trace(chip);
 			return TRANSPORT_FAILED;
 		}
 		break;
@@ -3237,14 +3042,12 @@ static int mg_report_key(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 		    (srb->cmnd[9] == 0x24)) {
 			retval = mg_get_rsp_chg(srb, chip);
 			if (retval != STATUS_SUCCESS) {
-				rtsx_trace(chip);
 				return TRANSPORT_FAILED;
 			}
 
 		} else {
 			set_sense_type(chip, lun,
 				       SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
-			rtsx_trace(chip);
 			return TRANSPORT_FAILED;
 		}
 		break;
@@ -3260,21 +3063,18 @@ static int mg_report_key(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 		    (srb->cmnd[5] < 32)) {
 			retval = mg_get_ICV(srb, chip);
 			if (retval != STATUS_SUCCESS) {
-				rtsx_trace(chip);
 				return TRANSPORT_FAILED;
 			}
 
 		} else {
 			set_sense_type(chip, lun,
 				       SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
-			rtsx_trace(chip);
 			return TRANSPORT_FAILED;
 		}
 		break;
 
 	default:
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
@@ -3301,29 +3101,24 @@ static int mg_send_key(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 	if (!check_card_ready(chip, lun)) {
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_NOT_PRESENT);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 	if (check_card_wp(chip, lun)) {
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_WRITE_PROTECT);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 	if (get_lun_card(chip, lun) != MS_CARD) {
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_LUN_NOT_SUPPORT);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
 	if (srb->cmnd[7] != KC_MG_R_PRO) {
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
 	if (!CHK_MSPRO(ms_card)) {
 		set_sense_type(chip, lun, SENSE_TYPE_MG_INCOMPATIBLE_MEDIUM);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
@@ -3337,14 +3132,12 @@ static int mg_send_key(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 		    (srb->cmnd[9] == 0x0C)) {
 			retval = mg_set_leaf_id(srb, chip);
 			if (retval != STATUS_SUCCESS) {
-				rtsx_trace(chip);
 				return TRANSPORT_FAILED;
 			}
 
 		} else {
 			set_sense_type(chip, lun,
 				       SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
-			rtsx_trace(chip);
 			return TRANSPORT_FAILED;
 		}
 		break;
@@ -3355,14 +3148,12 @@ static int mg_send_key(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 		    (srb->cmnd[9] == 0x0C)) {
 			retval = mg_chg(srb, chip);
 			if (retval != STATUS_SUCCESS) {
-				rtsx_trace(chip);
 				return TRANSPORT_FAILED;
 			}
 
 		} else {
 			set_sense_type(chip, lun,
 				       SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
-			rtsx_trace(chip);
 			return TRANSPORT_FAILED;
 		}
 		break;
@@ -3373,14 +3164,12 @@ static int mg_send_key(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 		    (srb->cmnd[9] == 0x0C)) {
 			retval = mg_rsp(srb, chip);
 			if (retval != STATUS_SUCCESS) {
-				rtsx_trace(chip);
 				return TRANSPORT_FAILED;
 			}
 
 		} else {
 			set_sense_type(chip, lun,
 				       SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
-			rtsx_trace(chip);
 			return TRANSPORT_FAILED;
 		}
 		break;
@@ -3396,21 +3185,18 @@ static int mg_send_key(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 		    (srb->cmnd[5] < 32)) {
 			retval = mg_set_ICV(srb, chip);
 			if (retval != STATUS_SUCCESS) {
-				rtsx_trace(chip);
 				return TRANSPORT_FAILED;
 			}
 
 		} else {
 			set_sense_type(chip, lun,
 				       SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
-			rtsx_trace(chip);
 			return TRANSPORT_FAILED;
 		}
 		break;
 
 	default:
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
@@ -3440,7 +3226,6 @@ int rtsx_scsi_handler(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 			/* Logical Unit Not Ready Format in Progress */
 			set_sense_data(chip, lun, CUR_ERR,
 				       0x02, 0, 0x04, 0x04, 0, 0);
-			rtsx_trace(chip);
 			return TRANSPORT_FAILED;
 		}
 	}
@@ -3453,7 +3238,6 @@ int rtsx_scsi_handler(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 			/* Logical Unit Not Ready Format in Progress */
 			set_sense_data(chip, lun, CUR_ERR, 0x02, 0, 0x04, 0x04,
 				       0, (u16)(ms_card->progress));
-			rtsx_trace(chip);
 			return TRANSPORT_FAILED;
 		}
 	}
diff --git a/drivers/staging/rts5208/rtsx_transport.c b/drivers/staging/rts5208/rtsx_transport.c
index 716cce2bd7f0..b4a796c570c2 100644
--- a/drivers/staging/rts5208/rtsx_transport.c
+++ b/drivers/staging/rts5208/rtsx_transport.c
@@ -275,7 +275,6 @@ int rtsx_send_cmd(struct rtsx_chip *chip, u8 card, int timeout)
 		dev_dbg(rtsx_dev(chip), "chip->int_reg = 0x%x\n",
 			chip->int_reg);
 		err = -ETIMEDOUT;
-		rtsx_trace(chip);
 		goto finish_send_cmd;
 	}
 
diff --git a/drivers/staging/rts5208/sd.c b/drivers/staging/rts5208/sd.c
index d548bc695f9e..f2778abf10c0 100644
--- a/drivers/staging/rts5208/sd.c
+++ b/drivers/staging/rts5208/sd.c
@@ -110,13 +110,11 @@ static int sd_check_data0_status(struct rtsx_chip *chip)
 
 	retval = rtsx_read_register(chip, REG_SD_STAT1, &stat);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 
 	if (!(stat & SD_DAT0_STATUS)) {
 		sd_set_err_code(chip, SD_BUSY);
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -191,7 +189,6 @@ static int sd_send_cmd_get_rsp(struct rtsx_chip *chip, u8 cmd_idx,
 				retval = sd_check_data0_status(chip);
 				if (retval != STATUS_SUCCESS) {
 					rtsx_clear_sd_error(chip);
-					rtsx_trace(chip);
 					return retval;
 				}
 			} else {
@@ -203,7 +200,6 @@ static int sd_send_cmd_get_rsp(struct rtsx_chip *chip, u8 cmd_idx,
 		}
 		rtsx_clear_sd_error(chip);
 
-		rtsx_trace(chip);
 		return retval;
 	}
 
@@ -214,7 +210,6 @@ static int sd_send_cmd_get_rsp(struct rtsx_chip *chip, u8 cmd_idx,
 
 	if ((ptr[0] & 0xC0) != 0) {
 		sd_set_err_code(chip, SD_STS_ERR);
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -222,7 +217,6 @@ static int sd_send_cmd_get_rsp(struct rtsx_chip *chip, u8 cmd_idx,
 		if (ptr[stat_idx] & SD_CRC7_ERR) {
 			if (cmd_idx == WRITE_MULTIPLE_BLOCK) {
 				sd_set_err_code(chip, SD_CRC_ERR);
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 			if (rty_cnt < SD_MAX_RETRY_COUNT) {
@@ -231,7 +225,6 @@ static int sd_send_cmd_get_rsp(struct rtsx_chip *chip, u8 cmd_idx,
 				goto RTY_SEND_CMD;
 			} else {
 				sd_set_err_code(chip, SD_CRC_ERR);
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 		}
@@ -242,7 +235,6 @@ static int sd_send_cmd_get_rsp(struct rtsx_chip *chip, u8 cmd_idx,
 		    (cmd_idx != SEND_IF_COND)) {
 			if (cmd_idx != STOP_TRANSMISSION) {
 				if (ptr[1] & 0x80) {
-					rtsx_trace(chip);
 					return STATUS_FAIL;
 				}
 			}
@@ -253,19 +245,16 @@ static int sd_send_cmd_get_rsp(struct rtsx_chip *chip, u8 cmd_idx,
 #endif
 				dev_dbg(rtsx_dev(chip), "ptr[1]: 0x%02x\n",
 					ptr[1]);
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 			if (ptr[2] & 0xFF) {
 				dev_dbg(rtsx_dev(chip), "ptr[2]: 0x%02x\n",
 					ptr[2]);
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 			if (ptr[3] & 0x80) {
 				dev_dbg(rtsx_dev(chip), "ptr[3]: 0x%02x\n",
 					ptr[3]);
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 			if (ptr[3] & 0x01)
@@ -296,7 +285,6 @@ static int sd_read_data(struct rtsx_chip *chip,
 		buf_len = 0;
 
 	if (buf_len > 512) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -338,14 +326,12 @@ static int sd_read_data(struct rtsx_chip *chip,
 					    SD_RSP_TYPE_R1, NULL, 0);
 		}
 
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	if (buf && buf_len) {
 		retval = rtsx_read_ppbuf(chip, buf, buf_len);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	}
@@ -368,14 +354,12 @@ static int sd_write_data(struct rtsx_chip *chip, u8 trans_mode,
 
 	if (buf_len > 512) {
 		/* This function can't write data more than one page */
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	if (buf && buf_len) {
 		retval = rtsx_write_ppbuf(chip, buf, buf_len);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	}
@@ -416,7 +400,6 @@ static int sd_write_data(struct rtsx_chip *chip, u8 trans_mode,
 					    SD_RSP_TYPE_R1, NULL, 0);
 		}
 
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -434,7 +417,6 @@ static int sd_check_csd(struct rtsx_chip *chip, char check_wp)
 	for (i = 0; i < 6; i++) {
 		if (detect_card_cd(chip, SD_CARD) != STATUS_SUCCESS) {
 			sd_set_err_code(chip, SD_NO_CARD);
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
@@ -445,7 +427,6 @@ static int sd_check_csd(struct rtsx_chip *chip, char check_wp)
 	}
 
 	if (i == 6) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -489,11 +470,9 @@ static int sd_check_csd(struct rtsx_chip *chip, char check_wp)
 			else
 				sd_card->sd_clock = CLK_20;
 		} else {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	} else {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -565,7 +544,6 @@ static int sd_set_sample_push_timing(struct rtsx_chip *chip)
 
 	retval = rtsx_write_register(chip, REG_SD_CFG1, 0x1C, val);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 
@@ -629,7 +607,6 @@ static int sd_set_clock_divider(struct rtsx_chip *chip, u8 clk_div)
 
 	retval = rtsx_write_register(chip, REG_SD_CFG1, mask, val);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 
@@ -643,7 +620,6 @@ static int sd_set_init_para(struct rtsx_chip *chip)
 
 	retval = sd_set_sample_push_timing(chip);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -651,7 +627,6 @@ static int sd_set_init_para(struct rtsx_chip *chip)
 
 	retval = switch_clock(chip, sd_card->sd_clock);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -677,7 +652,6 @@ int sd_select_card(struct rtsx_chip *chip, int select)
 
 	retval = sd_send_cmd_get_rsp(chip, cmd_idx, addr, cmd_type, NULL, 0);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -694,7 +668,6 @@ static int sd_update_lock_status(struct rtsx_chip *chip)
 	retval = sd_send_cmd_get_rsp(chip, SEND_STATUS, sd_card->sd_addr,
 				     SD_RSP_TYPE_R1, rsp, 5);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -707,7 +680,6 @@ static int sd_update_lock_status(struct rtsx_chip *chip)
 		sd_card->sd_lock_status);
 
 	if (rsp[1] & 0x01) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -727,7 +699,6 @@ static int sd_wait_state_data_ready(struct rtsx_chip *chip, u8 state,
 					     sd_card->sd_addr, SD_RSP_TYPE_R1,
 					     rsp, 5);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
@@ -736,7 +707,6 @@ static int sd_wait_state_data_ready(struct rtsx_chip *chip, u8 state,
 			return STATUS_SUCCESS;
 	}
 
-	rtsx_trace(chip);
 	return STATUS_FAIL;
 }
 
@@ -750,14 +720,12 @@ static int sd_change_bank_voltage(struct rtsx_chip *chip, u8 voltage)
 							 0x4FC0 |
 							 chip->phy_voltage);
 			if (retval != STATUS_SUCCESS) {
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 		} else {
 			retval = rtsx_write_register(chip, SD_PAD_CTL,
 						     SD_IO_USING_1V8, 0);
 			if (retval) {
-				rtsx_trace(chip);
 				return retval;
 			}
 		}
@@ -767,7 +735,6 @@ static int sd_change_bank_voltage(struct rtsx_chip *chip, u8 voltage)
 							 0x4C40 |
 							 chip->phy_voltage);
 			if (retval != STATUS_SUCCESS) {
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 		} else {
@@ -775,12 +742,10 @@ static int sd_change_bank_voltage(struct rtsx_chip *chip, u8 voltage)
 						     SD_IO_USING_1V8,
 						     SD_IO_USING_1V8);
 			if (retval) {
-				rtsx_trace(chip);
 				return retval;
 			}
 		}
 	} else {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -796,14 +761,12 @@ static int sd_voltage_switch(struct rtsx_chip *chip)
 				     SD_CLK_TOGGLE_EN | SD_CLK_FORCE_STOP,
 				     SD_CLK_TOGGLE_EN);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 
 	retval = sd_send_cmd_get_rsp(chip, VOLTAGE_SWITCH, 0, SD_RSP_TYPE_R1,
 				     NULL, 0);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -811,24 +774,20 @@ static int sd_voltage_switch(struct rtsx_chip *chip)
 
 	retval = rtsx_read_register(chip, SD_BUS_STAT, &stat);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 	if (stat & (SD_CMD_STATUS | SD_DAT3_STATUS | SD_DAT2_STATUS |
 				SD_DAT1_STATUS | SD_DAT0_STATUS)) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	retval = rtsx_write_register(chip, SD_BUS_STAT, 0xFF,
 				     SD_CLK_FORCE_STOP);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 	retval = sd_change_bank_voltage(chip, SD_IO_1V8);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -837,14 +796,12 @@ static int sd_voltage_switch(struct rtsx_chip *chip)
 	retval = rtsx_write_register(chip, SD_BUS_STAT, 0xFF,
 				     SD_CLK_TOGGLE_EN);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 	wait_timeout(10);
 
 	retval = rtsx_read_register(chip, SD_BUS_STAT, &stat);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 	if ((stat & (SD_CMD_STATUS | SD_DAT3_STATUS | SD_DAT2_STATUS |
@@ -855,14 +812,12 @@ static int sd_voltage_switch(struct rtsx_chip *chip)
 		rtsx_write_register(chip, SD_BUS_STAT, SD_CLK_TOGGLE_EN |
 				    SD_CLK_FORCE_STOP, 0);
 		rtsx_write_register(chip, CARD_CLK_EN, 0xFF, 0);
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	retval = rtsx_write_register(chip, SD_BUS_STAT,
 				     SD_CLK_TOGGLE_EN | SD_CLK_FORCE_STOP, 0);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 
@@ -877,24 +832,20 @@ static int sd_reset_dcm(struct rtsx_chip *chip, u8 tune_dir)
 		retval = rtsx_write_register(chip, DCM_DRP_CTL, 0xFF,
 					     DCM_RESET | DCM_RX);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 		retval = rtsx_write_register(chip, DCM_DRP_CTL, 0xFF, DCM_RX);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 	} else {
 		retval = rtsx_write_register(chip, DCM_DRP_CTL, 0xFF,
 					     DCM_RESET | DCM_TX);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 		retval = rtsx_write_register(chip, DCM_DRP_CTL, 0xFF, DCM_TX);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 	}
@@ -927,30 +878,25 @@ static int sd_change_phase(struct rtsx_chip *chip, u8 sample_point, u8 tune_dir)
 		retval = rtsx_write_register(chip, CLK_CTL, CHANGE_CLK,
 					     CHANGE_CLK);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 		retval = rtsx_write_register(chip, SD_VP_CTL, 0x1F,
 					     sample_point);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 		retval = rtsx_write_register(chip, SD_VPCLK0_CTL,
 					     PHASE_NOT_RESET, 0);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 		retval = rtsx_write_register(chip, SD_VPCLK0_CTL,
 					     PHASE_NOT_RESET, PHASE_NOT_RESET);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 		retval = rtsx_write_register(chip, CLK_CTL, CHANGE_CLK, 0);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 	} else {
@@ -964,7 +910,6 @@ static int sd_change_phase(struct rtsx_chip *chip, u8 sample_point, u8 tune_dir)
 						     PHASE_CHANGE,
 						     PHASE_CHANGE);
 			if (retval) {
-				rtsx_trace(chip);
 				return retval;
 			}
 			udelay(50);
@@ -973,14 +918,12 @@ static int sd_change_phase(struct rtsx_chip *chip, u8 sample_point, u8 tune_dir)
 						     PHASE_NOT_RESET |
 						     sample_point);
 			if (retval) {
-				rtsx_trace(chip);
 				return retval;
 			}
 		} else {
 			retval = rtsx_write_register(chip, CLK_CTL,
 						     CHANGE_CLK, CHANGE_CLK);
 			if (retval) {
-				rtsx_trace(chip);
 				return retval;
 			}
 			udelay(50);
@@ -988,7 +931,6 @@ static int sd_change_phase(struct rtsx_chip *chip, u8 sample_point, u8 tune_dir)
 						     PHASE_NOT_RESET |
 						     sample_point);
 			if (retval) {
-				rtsx_trace(chip);
 				return retval;
 			}
 		}
@@ -1001,39 +943,33 @@ static int sd_change_phase(struct rtsx_chip *chip, u8 sample_point, u8 tune_dir)
 			     DCMPS_CHANGE_DONE, DCMPS_CHANGE_DONE);
 		retval = rtsx_send_cmd(chip, SD_CARD, 100);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			goto fail;
 		}
 
 		val = *rtsx_get_cmd_data(chip);
 		if (val & DCMPS_ERROR) {
-			rtsx_trace(chip);
 			goto fail;
 		}
 
 		if ((val & DCMPS_CURRENT_PHASE) != sample_point) {
-			rtsx_trace(chip);
 			goto fail;
 		}
 
 		retval = rtsx_write_register(chip, SD_DCMPS_CTL,
 					     DCMPS_CHANGE, 0);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 		if (ddr_rx) {
 			retval = rtsx_write_register(chip, SD_VP_CTL,
 						     PHASE_CHANGE, 0);
 			if (retval) {
-				rtsx_trace(chip);
 				return retval;
 			}
 		} else {
 			retval = rtsx_write_register(chip, CLK_CTL,
 						     CHANGE_CLK, 0);
 			if (retval) {
-				rtsx_trace(chip);
 				return retval;
 			}
 		}
@@ -1043,7 +979,6 @@ static int sd_change_phase(struct rtsx_chip *chip, u8 sample_point, u8 tune_dir)
 
 	retval = rtsx_write_register(chip, SD_CFG1, SD_ASYNC_FIFO_NOT_RST, 0);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 
@@ -1071,7 +1006,6 @@ static int sd_check_spec(struct rtsx_chip *chip, u8 bus_width)
 	retval = sd_send_cmd_get_rsp(chip, APP_CMD, sd_card->sd_addr,
 				     SD_RSP_TYPE_R1, NULL, 0);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -1085,14 +1019,12 @@ static int sd_check_spec(struct rtsx_chip *chip, u8 bus_width)
 			      buf, 8, 250);
 	if (retval != STATUS_SUCCESS) {
 		rtsx_clear_sd_error(chip);
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	memcpy(sd_card->raw_scr, buf, 8);
 
 	if ((buf[0] & 0x0F) == 0) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -1136,7 +1068,6 @@ static int sd_query_switch_result(struct rtsx_chip *chip, u8 func_group,
 			break;
 
 		default:
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	} else if (func_group == SD_FUNC_GROUP_3) {
@@ -1164,7 +1095,6 @@ static int sd_query_switch_result(struct rtsx_chip *chip, u8 func_group,
 			break;
 
 		default:
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	} else if (func_group == SD_FUNC_GROUP_4) {
@@ -1192,18 +1122,15 @@ static int sd_query_switch_result(struct rtsx_chip *chip, u8 func_group,
 			break;
 
 		default:
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	} else {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	if (func_group == SD_FUNC_GROUP_1) {
 		if (!(buf[support_offset] & support_mask) ||
 		    ((buf[query_switch_offset] & 0x0F) != query_switch)) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	}
@@ -1211,7 +1138,6 @@ static int sd_query_switch_result(struct rtsx_chip *chip, u8 func_group,
 	/* Check 'Busy Status' */
 	if ((buf[DATA_STRUCTURE_VER_OFFSET] == 0x01) &&
 	    ((buf[check_busy_offset] & switch_busy) == switch_busy)) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -1254,7 +1180,6 @@ static int sd_check_switch_mode(struct rtsx_chip *chip, u8 mode, u8 func_group,
 			      buf, 64, 250);
 	if (retval != STATUS_SUCCESS) {
 		rtsx_clear_sd_error(chip);
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -1283,14 +1208,12 @@ static int sd_check_switch_mode(struct rtsx_chip *chip, u8 mode, u8 func_group,
 		dev_dbg(rtsx_dev(chip), "Maximum current consumption: %dmA\n",
 			cc);
 		if ((cc == 0) || (cc > 800)) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
 		retval = sd_query_switch_result(chip, func_group,
 						func_to_switch, buf, 64);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
@@ -1299,14 +1222,12 @@ static int sd_check_switch_mode(struct rtsx_chip *chip, u8 mode, u8 func_group,
 						     SD_OCP_THD_MASK,
 						     chip->sd_800mA_ocp_thd);
 			if (retval) {
-				rtsx_trace(chip);
 				return retval;
 			}
 			retval = rtsx_write_register(chip, CARD_PWR_CTL,
 						     PMOS_STRG_MASK,
 						     PMOS_STRG_800mA);
 			if (retval) {
-				rtsx_trace(chip);
 				return retval;
 			}
 		}
@@ -1339,7 +1260,6 @@ static int sd_check_switch(struct rtsx_chip *chip,
 	for (i = 0; i < 3; i++) {
 		if (detect_card_cd(chip, SD_CARD) != STATUS_SUCCESS) {
 			sd_set_err_code(chip, SD_NO_CARD);
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
@@ -1359,12 +1279,10 @@ static int sd_check_switch(struct rtsx_chip *chip,
 
 			retval = rtsx_read_register(chip, SD_STAT1, &stat);
 			if (retval) {
-				rtsx_trace(chip);
 				return retval;
 			}
 			if (stat & SD_CRC16_ERR) {
 				dev_dbg(rtsx_dev(chip), "SD CRC16 error when switching mode\n");
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 		}
@@ -1376,7 +1294,6 @@ static int sd_check_switch(struct rtsx_chip *chip,
 	}
 
 	if (!switch_good) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -1394,7 +1311,6 @@ static int sd_switch_function(struct rtsx_chip *chip, u8 bus_width)
 	retval = sd_check_switch_mode(chip, SD_CHECK_MODE, NO_ARGUMENT,
 				      NO_ARGUMENT, bus_width);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -1462,7 +1378,6 @@ static int sd_switch_function(struct rtsx_chip *chip, u8 bus_width)
 				sd_card->sd_switch_fail = SDR104_SUPPORT_MASK |
 					DDR50_SUPPORT_MASK | SDR50_SUPPORT_MASK;
 			}
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
@@ -1480,12 +1395,10 @@ static int sd_switch_function(struct rtsx_chip *chip, u8 bus_width)
 		retval = rtsx_write_register(chip, SD_PUSH_POINT_CTL, 0x06,
 					     0x04);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 		retval = sd_set_sample_push_timing(chip);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	}
@@ -1542,7 +1455,6 @@ static int sd_switch_function(struct rtsx_chip *chip, u8 bus_width)
 					 bus_width);
 		if (retval != STATUS_SUCCESS) {
 			if (sd_check_err_code(chip, SD_NO_CARD)) {
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 		}
@@ -1553,7 +1465,6 @@ static int sd_switch_function(struct rtsx_chip *chip, u8 bus_width)
 	if (CHK_SD_DDR50(sd_card)) {
 		retval = rtsx_write_register(chip, SD_PUSH_POINT_CTL, 0x06, 0);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 	}
@@ -1570,7 +1481,6 @@ static int sd_wait_data_idle(struct rtsx_chip *chip)
 	for (i = 0; i < 100; i++) {
 		retval = rtsx_read_register(chip, SD_DATA_STATE, &val);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 		if (val & SD_DATA_IDLE) {
@@ -1591,7 +1501,6 @@ static int sd_sdr_tuning_rx_cmd(struct rtsx_chip *chip, u8 sample_point)
 
 	retval = sd_change_phase(chip, sample_point, TUNE_RX);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -1607,7 +1516,6 @@ static int sd_sdr_tuning_rx_cmd(struct rtsx_chip *chip, u8 sample_point)
 		(void)sd_wait_data_idle(chip);
 
 		rtsx_clear_sd_error(chip);
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -1622,7 +1530,6 @@ static int sd_ddr_tuning_rx_cmd(struct rtsx_chip *chip, u8 sample_point)
 
 	retval = sd_change_phase(chip, sample_point, TUNE_RX);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -1631,7 +1538,6 @@ static int sd_ddr_tuning_rx_cmd(struct rtsx_chip *chip, u8 sample_point)
 	retval = sd_send_cmd_get_rsp(chip, APP_CMD, sd_card->sd_addr,
 				     SD_RSP_TYPE_R1, NULL, 0);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -1647,7 +1553,6 @@ static int sd_ddr_tuning_rx_cmd(struct rtsx_chip *chip, u8 sample_point)
 		(void)sd_wait_data_idle(chip);
 
 		rtsx_clear_sd_error(chip);
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -1669,7 +1574,6 @@ static int mmc_ddr_tuning_rx_cmd(struct rtsx_chip *chip, u8 sample_point)
 
 	retval = sd_change_phase(chip, sample_point, TUNE_RX);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -1687,7 +1591,6 @@ static int mmc_ddr_tuning_rx_cmd(struct rtsx_chip *chip, u8 sample_point)
 		(void)sd_wait_data_idle(chip);
 
 		rtsx_clear_sd_error(chip);
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -1701,14 +1604,12 @@ static int sd_sdr_tuning_tx_cmd(struct rtsx_chip *chip, u8 sample_point)
 
 	retval = sd_change_phase(chip, sample_point, TUNE_TX);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	retval = rtsx_write_register(chip, SD_CFG3, SD_RSP_80CLK_TIMEOUT_EN,
 				     SD_RSP_80CLK_TIMEOUT_EN);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 
@@ -1718,7 +1619,6 @@ static int sd_sdr_tuning_tx_cmd(struct rtsx_chip *chip, u8 sample_point)
 		if (sd_check_err_code(chip, SD_RSP_TIMEOUT)) {
 			rtsx_write_register(chip, SD_CFG3,
 					    SD_RSP_80CLK_TIMEOUT_EN, 0);
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	}
@@ -1726,7 +1626,6 @@ static int sd_sdr_tuning_tx_cmd(struct rtsx_chip *chip, u8 sample_point)
 	retval = rtsx_write_register(chip, SD_CFG3, SD_RSP_80CLK_TIMEOUT_EN,
 				     0);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 
@@ -1741,7 +1640,6 @@ static int sd_ddr_tuning_tx_cmd(struct rtsx_chip *chip, u8 sample_point)
 
 	retval = sd_change_phase(chip, sample_point, TUNE_TX);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -1758,14 +1656,12 @@ static int sd_ddr_tuning_tx_cmd(struct rtsx_chip *chip, u8 sample_point)
 
 	retval = sd_wait_state_data_ready(chip, 0x08, 1, 1000);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	retval = rtsx_write_register(chip, SD_CFG3, SD_RSP_80CLK_TIMEOUT_EN,
 				     SD_RSP_80CLK_TIMEOUT_EN);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 
@@ -1780,14 +1676,12 @@ static int sd_ddr_tuning_tx_cmd(struct rtsx_chip *chip, u8 sample_point)
 	if (retval != STATUS_SUCCESS) {
 		rtsx_clear_sd_error(chip);
 		rtsx_write_register(chip, SD_CFG3, SD_RSP_80CLK_TIMEOUT_EN, 0);
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	retval = rtsx_write_register(chip, SD_CFG3, SD_RSP_80CLK_TIMEOUT_EN,
 				     0);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 
@@ -1935,7 +1829,6 @@ static int sd_tuning_rx(struct rtsx_chip *chip)
 		if (CHK_MMC_DDR52(sd_card)) {
 			tuning_cmd = mmc_ddr_tuning_rx_cmd;
 		} else {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	}
@@ -1945,7 +1838,6 @@ static int sd_tuning_rx(struct rtsx_chip *chip)
 		for (j = MAX_PHASE; j >= 0; j--) {
 			if (detect_card_cd(chip, SD_CARD) != STATUS_SUCCESS) {
 				sd_set_err_code(chip, SD_NO_CARD);
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 
@@ -1964,13 +1856,11 @@ static int sd_tuning_rx(struct rtsx_chip *chip)
 
 	final_phase = sd_search_final_phase(chip, phase_map, TUNE_RX);
 	if (final_phase == 0xFF) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	retval = sd_change_phase(chip, final_phase, TUNE_RX);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -1988,7 +1878,6 @@ static int sd_ddr_pre_tuning_tx(struct rtsx_chip *chip)
 	retval = rtsx_write_register(chip, SD_CFG3, SD_RSP_80CLK_TIMEOUT_EN,
 				     SD_RSP_80CLK_TIMEOUT_EN);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 
@@ -1998,7 +1887,6 @@ static int sd_ddr_pre_tuning_tx(struct rtsx_chip *chip)
 			sd_set_err_code(chip, SD_NO_CARD);
 			rtsx_write_register(chip, SD_CFG3,
 					    SD_RSP_80CLK_TIMEOUT_EN, 0);
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
@@ -2017,7 +1905,6 @@ static int sd_ddr_pre_tuning_tx(struct rtsx_chip *chip)
 	retval = rtsx_write_register(chip, SD_CFG3, SD_RSP_80CLK_TIMEOUT_EN,
 				     0);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 
@@ -2026,13 +1913,11 @@ static int sd_ddr_pre_tuning_tx(struct rtsx_chip *chip)
 
 	final_phase = sd_search_final_phase(chip, phase_map, TUNE_TX);
 	if (final_phase == 0xFF) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	retval = sd_change_phase(chip, final_phase, TUNE_TX);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -2061,7 +1946,6 @@ static int sd_tuning_tx(struct rtsx_chip *chip)
 		if (CHK_MMC_DDR52(sd_card)) {
 			tuning_cmd = sd_ddr_tuning_tx_cmd;
 		} else {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	}
@@ -2073,7 +1957,6 @@ static int sd_tuning_tx(struct rtsx_chip *chip)
 				sd_set_err_code(chip, SD_NO_CARD);
 				rtsx_write_register(chip, SD_CFG3,
 						    SD_RSP_80CLK_TIMEOUT_EN, 0);
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 
@@ -2092,13 +1975,11 @@ static int sd_tuning_tx(struct rtsx_chip *chip)
 
 	final_phase = sd_search_final_phase(chip, phase_map, TUNE_TX);
 	if (final_phase == 0xFF) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	retval = sd_change_phase(chip, final_phase, TUNE_TX);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -2111,13 +1992,11 @@ static int sd_sdr_tuning(struct rtsx_chip *chip)
 
 	retval = sd_tuning_tx(chip);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	retval = sd_tuning_rx(chip);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -2131,28 +2010,24 @@ static int sd_ddr_tuning(struct rtsx_chip *chip)
 	if (!(chip->sd_ctl & SD_DDR_TX_PHASE_SET_BY_USER)) {
 		retval = sd_ddr_pre_tuning_tx(chip);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	} else {
 		retval = sd_change_phase(chip, (u8)chip->sd_ddr_tx_phase,
 					 TUNE_TX);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	}
 
 	retval = sd_tuning_rx(chip);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	if (!(chip->sd_ctl & SD_DDR_TX_PHASE_SET_BY_USER)) {
 		retval = sd_tuning_tx(chip);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	}
@@ -2167,28 +2042,24 @@ static int mmc_ddr_tuning(struct rtsx_chip *chip)
 	if (!(chip->sd_ctl & MMC_DDR_TX_PHASE_SET_BY_USER)) {
 		retval = sd_ddr_pre_tuning_tx(chip);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	} else {
 		retval = sd_change_phase(chip, (u8)chip->mmc_ddr_tx_phase,
 					 TUNE_TX);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	}
 
 	retval = sd_tuning_rx(chip);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	if (!(chip->sd_ctl & MMC_DDR_TX_PHASE_SET_BY_USER)) {
 		retval = sd_tuning_tx(chip);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	}
@@ -2204,13 +2075,11 @@ int sd_switch_clock(struct rtsx_chip *chip)
 
 	retval = select_card(chip, SD_CARD);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	retval = switch_clock(chip, sd_card->sd_clock);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -2226,7 +2095,6 @@ int sd_switch_clock(struct rtsx_chip *chip)
 		}
 
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	}
@@ -2259,26 +2127,22 @@ static int sd_prepare_reset(struct rtsx_chip *chip)
 
 	retval = sd_set_init_para(chip);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return retval;
 	}
 
 	retval = rtsx_write_register(chip, REG_SD_CFG1, 0xFF, 0x40);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 
 	retval = rtsx_write_register(chip, CARD_STOP, SD_STOP | SD_CLR_ERR,
 				     SD_STOP | SD_CLR_ERR);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 
 	retval = select_card(chip, SD_CARD);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -2294,41 +2158,35 @@ static int sd_pull_ctl_disable(struct rtsx_chip *chip)
 					     XD_D3_PD | SD_D7_PD | SD_CLK_PD |
 					     SD_D5_PD);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 		retval = rtsx_write_register(chip, CARD_PULL_CTL2, 0xFF,
 					     SD_D6_PD | SD_D0_PD | SD_D1_PD |
 					     XD_D5_PD);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 		retval = rtsx_write_register(chip, CARD_PULL_CTL3, 0xFF,
 					     SD_D4_PD | XD_CE_PD | XD_CLE_PD |
 					     XD_CD_PU);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 		retval = rtsx_write_register(chip, CARD_PULL_CTL4, 0xFF,
 					     XD_RDY_PD | SD_D3_PD | SD_D2_PD |
 					     XD_ALE_PD);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 		retval = rtsx_write_register(chip, CARD_PULL_CTL5, 0xFF,
 					     MS_INS_PU | SD_WP_PD | SD_CD_PU |
 					     SD_CMD_PD);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 		retval = rtsx_write_register(chip, CARD_PULL_CTL6, 0xFF,
 					     MS_D5_PD | MS_D4_PD);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 	} else if (CHECK_PID(chip, 0x5288)) {
@@ -2336,25 +2194,21 @@ static int sd_pull_ctl_disable(struct rtsx_chip *chip)
 			retval = rtsx_write_register(chip, CARD_PULL_CTL1,
 						     0xFF, 0x55);
 			if (retval) {
-				rtsx_trace(chip);
 				return retval;
 			}
 			retval = rtsx_write_register(chip, CARD_PULL_CTL2,
 						     0xFF, 0x55);
 			if (retval) {
-				rtsx_trace(chip);
 				return retval;
 			}
 			retval = rtsx_write_register(chip, CARD_PULL_CTL3,
 						     0xFF, 0x4B);
 			if (retval) {
-				rtsx_trace(chip);
 				return retval;
 			}
 			retval = rtsx_write_register(chip, CARD_PULL_CTL4,
 						     0xFF, 0x69);
 			if (retval) {
-				rtsx_trace(chip);
 				return retval;
 			}
 		}
@@ -2397,7 +2251,6 @@ int sd_pull_ctl_enable(struct rtsx_chip *chip)
 
 	retval = rtsx_send_cmd(chip, SD_CARD, 100);
 	if (retval < 0) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -2410,7 +2263,6 @@ static int sd_init_power(struct rtsx_chip *chip)
 
 	retval = sd_power_off_card3v3(chip);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -2419,21 +2271,18 @@ static int sd_init_power(struct rtsx_chip *chip)
 
 	retval = enable_card_clock(chip, SD_CARD);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	if (chip->asic_code) {
 		retval = sd_pull_ctl_enable(chip);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	} else {
 		retval = rtsx_write_register(chip, FPGA_PULL_CTL,
 					     FPGA_SD_PULL_CTL_BIT | 0x20, 0);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 	}
@@ -2441,7 +2290,6 @@ static int sd_init_power(struct rtsx_chip *chip)
 	if (!chip->ft2_fast_mode) {
 		retval = card_power_on(chip, SD_CARD);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
@@ -2451,7 +2299,6 @@ static int sd_init_power(struct rtsx_chip *chip)
 		if (chip->ocp_stat & (SD_OC_NOW | SD_OC_EVER)) {
 			dev_dbg(rtsx_dev(chip), "Over current, OCPSTAT is 0x%x\n",
 				chip->ocp_stat);
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 #endif
@@ -2460,7 +2307,6 @@ static int sd_init_power(struct rtsx_chip *chip)
 	retval = rtsx_write_register(chip, CARD_OE, SD_OUTPUT_EN,
 				     SD_OUTPUT_EN);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 
@@ -2473,13 +2319,11 @@ static int sd_dummy_clock(struct rtsx_chip *chip)
 
 	retval = rtsx_write_register(chip, REG_SD_CFG3, 0x01, 0x01);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 	wait_timeout(5);
 	retval = rtsx_write_register(chip, REG_SD_CFG3, 0x01, 0);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 
@@ -2513,7 +2357,6 @@ static int sd_read_lba0(struct rtsx_chip *chip)
 			      bus_width, NULL, 0, 100);
 	if (retval != STATUS_SUCCESS) {
 		rtsx_clear_sd_error(chip);
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -2531,7 +2374,6 @@ static int sd_check_wp_state(struct rtsx_chip *chip)
 	retval = sd_send_cmd_get_rsp(chip, APP_CMD, sd_card->sd_addr,
 				     SD_RSP_TYPE_R1, NULL, 0);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -2548,7 +2390,6 @@ static int sd_check_wp_state(struct rtsx_chip *chip)
 
 		sd_send_cmd_get_rsp(chip, SEND_STATUS, sd_card->sd_addr,
 				    SD_RSP_TYPE_R1, NULL, 0);
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -2849,7 +2690,6 @@ static int reset_sd(struct rtsx_chip *chip)
 		retval = rtsx_write_register(chip, SD30_DRIVE_SEL, 0x07,
 					     chip->sd30_drive_sel_1v8);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 
@@ -2914,13 +2754,11 @@ static int reset_sd(struct rtsx_chip *chip)
 		retval = rtsx_write_register(chip, REG_SD_BLOCK_CNT_H, 0xFF,
 					     0x02);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 		retval = rtsx_write_register(chip, REG_SD_BLOCK_CNT_L, 0xFF,
 					     0x00);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 	}
@@ -2929,7 +2767,6 @@ static int reset_sd(struct rtsx_chip *chip)
 	return STATUS_SUCCESS;
 
 status_fail:
-	rtsx_trace(chip);
 	return STATUS_FAIL;
 }
 
@@ -2944,7 +2781,6 @@ static int mmc_test_switch_bus(struct rtsx_chip *chip, u8 width)
 	retval = sd_send_cmd_get_rsp(chip, BUSTEST_W, 0, SD_RSP_TYPE_R1, NULL,
 				     0);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return SWITCH_FAIL;
 	}
 
@@ -2963,7 +2799,6 @@ static int mmc_test_switch_bus(struct rtsx_chip *chip, u8 width)
 
 	retval = rtsx_write_register(chip, REG_SD_CFG3, 0x02, 0x02);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return SWITCH_ERR;
 	}
 
@@ -2972,13 +2807,11 @@ static int mmc_test_switch_bus(struct rtsx_chip *chip, u8 width)
 	if (retval != STATUS_SUCCESS) {
 		rtsx_clear_sd_error(chip);
 		rtsx_write_register(chip, REG_SD_CFG3, 0x02, 0);
-		rtsx_trace(chip);
 		return SWITCH_ERR;
 	}
 
 	retval = rtsx_write_register(chip, REG_SD_CFG3, 0x02, 0);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return SWITCH_ERR;
 	}
 
@@ -3015,7 +2848,6 @@ static int mmc_test_switch_bus(struct rtsx_chip *chip, u8 width)
 	retval = rtsx_send_cmd(chip, SD_CARD, 100);
 	if (retval < 0) {
 		rtsx_clear_sd_error(chip);
-		rtsx_trace(chip);
 		return SWITCH_ERR;
 	}
 
@@ -3058,7 +2890,6 @@ static int mmc_test_switch_bus(struct rtsx_chip *chip, u8 width)
 		}
 	}
 
-	rtsx_trace(chip);
 	return SWITCH_FAIL;
 }
 
@@ -3109,7 +2940,6 @@ static int mmc_switch_timing_bus(struct rtsx_chip *chip, bool switch_ddr)
 			sd_send_cmd_get_rsp(chip, SEND_STATUS, sd_card->sd_addr,
 					    SD_RSP_TYPE_R1, NULL, 0);
 		}
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -3117,7 +2947,6 @@ static int mmc_switch_timing_bus(struct rtsx_chip *chip, bool switch_ddr)
 	if (ptr[0] & SD_TRANSFER_ERR) {
 		sd_send_cmd_get_rsp(chip, SEND_STATUS, sd_card->sd_addr,
 				    SD_RSP_TYPE_R1, NULL, 0);
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -3151,7 +2980,6 @@ static int mmc_switch_timing_bus(struct rtsx_chip *chip, bool switch_ddr)
 	sd_choose_proper_clock(chip);
 	retval = switch_clock(chip, sd_card->sd_clock);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -3175,11 +3003,9 @@ static int mmc_switch_timing_bus(struct rtsx_chip *chip, bool switch_ddr)
 			CLR_MMC_8BIT(sd_card);
 			CLR_MMC_4BIT(sd_card);
 		} else {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	} else {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -3203,7 +3029,6 @@ static int reset_mmc(struct rtsx_chip *chip)
 switch_fail:
 	retval = sd_prepare_reset(chip);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return retval;
 	}
 
@@ -3213,14 +3038,12 @@ static int reset_mmc(struct rtsx_chip *chip)
 	retval = sd_send_cmd_get_rsp(chip, GO_IDLE_STATE, 0, SD_RSP_TYPE_R0,
 				     NULL, 0);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	do {
 		if (detect_card_cd(chip, SD_CARD) != STATUS_SUCCESS) {
 			sd_set_err_code(chip, SD_NO_CARD);
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
@@ -3235,7 +3058,6 @@ static int reset_mmc(struct rtsx_chip *chip)
 					sd_clr_err_code(chip);
 					goto RTY_MMC_RST;
 				} else {
-					rtsx_trace(chip);
 					return STATUS_FAIL;
 				}
 			} else {
@@ -3244,7 +3066,6 @@ static int reset_mmc(struct rtsx_chip *chip)
 					sd_clr_err_code(chip);
 					goto RTY_MMC_RST;
 				} else {
-					rtsx_trace(chip);
 					return STATUS_FAIL;
 				}
 			}
@@ -3255,7 +3076,6 @@ static int reset_mmc(struct rtsx_chip *chip)
 	} while (!(rsp[1] & 0x80) && (i < 255));
 
 	if (i == 255) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -3267,7 +3087,6 @@ static int reset_mmc(struct rtsx_chip *chip)
 	retval = sd_send_cmd_get_rsp(chip, ALL_SEND_CID, 0, SD_RSP_TYPE_R2,
 				     NULL, 0);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -3275,13 +3094,11 @@ static int reset_mmc(struct rtsx_chip *chip)
 	retval = sd_send_cmd_get_rsp(chip, SET_RELATIVE_ADDR, sd_card->sd_addr,
 				     SD_RSP_TYPE_R6, rsp, 5);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	retval = sd_check_csd(chip, 1);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -3289,14 +3106,12 @@ static int reset_mmc(struct rtsx_chip *chip)
 
 	retval = sd_select_card(chip, 1);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	retval = sd_send_cmd_get_rsp(chip, SET_BLOCKLEN, 0x200, SD_RSP_TYPE_R1,
 				     NULL, 0);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -3304,14 +3119,12 @@ static int reset_mmc(struct rtsx_chip *chip)
 MMC_UNLOCK_ENTRY:
 	retval = sd_update_lock_status(chip);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 #endif
 
 	retval = sd_set_clock_divider(chip, SD_CLK_DIVIDE_0);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -3324,24 +3137,20 @@ static int reset_mmc(struct rtsx_chip *chip)
 			if (retval != STATUS_SUCCESS) {
 				retval = sd_init_power(chip);
 				if (retval != STATUS_SUCCESS) {
-					rtsx_trace(chip);
 					return STATUS_FAIL;
 				}
 				sd_card->mmc_dont_switch_bus = 1;
-				rtsx_trace(chip);
 				goto switch_fail;
 			}
 		}
 
 		if (CHK_MMC_SECTOR_MODE(sd_card) && (sd_card->capacity == 0)) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
 		if (switch_ddr && CHK_MMC_DDR52(sd_card)) {
 			retval = sd_set_init_para(chip);
 			if (retval != STATUS_SUCCESS) {
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 
@@ -3349,12 +3158,10 @@ static int reset_mmc(struct rtsx_chip *chip)
 			if (retval != STATUS_SUCCESS) {
 				retval = sd_init_power(chip);
 				if (retval != STATUS_SUCCESS) {
-					rtsx_trace(chip);
 					return STATUS_FAIL;
 				}
 
 				switch_ddr = false;
-				rtsx_trace(chip);
 				goto switch_fail;
 			}
 
@@ -3364,12 +3171,10 @@ static int reset_mmc(struct rtsx_chip *chip)
 				if (retval != STATUS_SUCCESS) {
 					retval = sd_init_power(chip);
 					if (retval != STATUS_SUCCESS) {
-						rtsx_trace(chip);
 						return STATUS_FAIL;
 					}
 
 					switch_ddr = false;
-					rtsx_trace(chip);
 					goto switch_fail;
 				}
 			}
@@ -3381,13 +3186,11 @@ static int reset_mmc(struct rtsx_chip *chip)
 		retval = rtsx_write_register(chip, REG_SD_BLOCK_CNT_H, 0xFF,
 					     0x02);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 		retval = rtsx_write_register(chip, REG_SD_BLOCK_CNT_L, 0xFF,
 					     0x00);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 	}
@@ -3412,7 +3215,6 @@ int reset_sd_card(struct rtsx_chip *chip)
 
 	retval = enable_card_clock(chip, SD_CARD);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -3421,7 +3223,6 @@ int reset_sd_card(struct rtsx_chip *chip)
 		if (chip->asic_code) {
 			retval = sd_pull_ctl_enable(chip);
 			if (retval != STATUS_SUCCESS) {
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 		} else {
@@ -3429,24 +3230,20 @@ int reset_sd_card(struct rtsx_chip *chip)
 						     FPGA_SD_PULL_CTL_BIT |
 						     0x20, 0);
 			if (retval != STATUS_SUCCESS) {
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 		}
 		retval = card_share_mode(chip, SD_CARD);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
 		chip->sd_io = 1;
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	retval = sd_init_power(chip);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -3454,13 +3251,11 @@ int reset_sd_card(struct rtsx_chip *chip)
 		retval = reset_mmc(chip);
 		if (retval != STATUS_SUCCESS) {
 			if (sd_check_err_code(chip, SD_NO_CARD)) {
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 
 			retval = reset_sd(chip);
 			if (retval != STATUS_SUCCESS) {
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 		}
@@ -3468,17 +3263,14 @@ int reset_sd_card(struct rtsx_chip *chip)
 		retval = reset_sd(chip);
 		if (retval != STATUS_SUCCESS) {
 			if (sd_check_err_code(chip, SD_NO_CARD)) {
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 
 			if (chip->sd_io) {
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 			retval = reset_mmc(chip);
 			if (retval != STATUS_SUCCESS) {
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 		}
@@ -3486,18 +3278,15 @@ int reset_sd_card(struct rtsx_chip *chip)
 
 	retval = sd_set_clock_divider(chip, SD_CLK_DIVIDE_0);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	retval = rtsx_write_register(chip, REG_SD_BYTE_CNT_L, 0xFF, 0);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 	retval = rtsx_write_register(chip, REG_SD_BYTE_CNT_H, 0xFF, 2);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 
@@ -3505,7 +3294,6 @@ int reset_sd_card(struct rtsx_chip *chip)
 
 	retval = sd_set_init_para(chip);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -3534,36 +3322,30 @@ static int reset_mmc_only(struct rtsx_chip *chip)
 
 	retval = enable_card_clock(chip, SD_CARD);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	retval = sd_init_power(chip);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	retval = reset_mmc(chip);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	retval = sd_set_clock_divider(chip, SD_CLK_DIVIDE_0);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	retval = rtsx_write_register(chip, REG_SD_BYTE_CNT_L, 0xFF, 0);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 	retval = rtsx_write_register(chip, REG_SD_BYTE_CNT_H, 0xFF, 2);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 
@@ -3571,7 +3353,6 @@ static int reset_mmc_only(struct rtsx_chip *chip)
 
 	retval = sd_set_init_para(chip);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -3591,7 +3372,6 @@ static int wait_data_buf_ready(struct rtsx_chip *chip)
 	for (i = 0; i < WAIT_DATA_READY_RTY_CNT; i++) {
 		if (detect_card_cd(chip, SD_CARD) != STATUS_SUCCESS) {
 			sd_set_err_code(chip, SD_NO_CARD);
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
@@ -3601,7 +3381,6 @@ static int wait_data_buf_ready(struct rtsx_chip *chip)
 					     sd_card->sd_addr, SD_RSP_TYPE_R1,
 					     NULL, 0);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
@@ -3613,7 +3392,6 @@ static int wait_data_buf_ready(struct rtsx_chip *chip)
 
 	sd_set_err_code(chip, SD_TO_ERR);
 
-	rtsx_trace(chip);
 	return STATUS_FAIL;
 }
 
@@ -3683,7 +3461,6 @@ static inline int sd_auto_tune_clock(struct rtsx_chip *chip)
 
 	retval = sd_switch_clock(chip);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -3722,7 +3499,6 @@ int sd_rw(struct scsi_cmnd *srb, struct rtsx_chip *chip, u32 start_sector,
 			chip->card_fail |= SD_CARD;
 			chip->capacity[chip->card2lun[SD_CARD]] = 0;
 			chip->rw_need_retry = 1;
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	}
@@ -3737,7 +3513,6 @@ int sd_rw(struct scsi_cmnd *srb, struct rtsx_chip *chip, u32 start_sector,
 	retval = sd_switch_clock(chip);
 	if (retval != STATUS_SUCCESS) {
 		sd_set_err_code(chip, SD_IO_ERR);
-		rtsx_trace(chip);
 		goto RW_FAIL;
 	}
 
@@ -3759,7 +3534,6 @@ int sd_rw(struct scsi_cmnd *srb, struct rtsx_chip *chip, u32 start_sector,
 		if (retval != STATUS_SUCCESS) {
 			chip->rw_need_retry = 1;
 			sd_set_err_code(chip, SD_STS_ERR);
-			rtsx_trace(chip);
 			goto RW_FAIL;
 		}
 
@@ -3768,7 +3542,6 @@ int sd_rw(struct scsi_cmnd *srb, struct rtsx_chip *chip, u32 start_sector,
 		retval = rtsx_write_register(chip, RBCTL, RB_FLUSH, RB_FLUSH);
 		if (retval != STATUS_SUCCESS) {
 			sd_set_err_code(chip, SD_IO_ERR);
-			rtsx_trace(chip);
 			goto RW_FAIL;
 		}
 
@@ -3860,7 +3633,6 @@ int sd_rw(struct scsi_cmnd *srb, struct rtsx_chip *chip, u32 start_sector,
 
 				chip->rw_need_retry = 1;
 				sd_set_err_code(chip, SD_TO_ERR);
-				rtsx_trace(chip);
 				goto RW_FAIL;
 			}
 
@@ -3868,7 +3640,6 @@ int sd_rw(struct scsi_cmnd *srb, struct rtsx_chip *chip, u32 start_sector,
 			if (retval != STATUS_SUCCESS) {
 				chip->rw_need_retry = 1;
 				sd_set_err_code(chip, SD_TO_ERR);
-				rtsx_trace(chip);
 				goto RW_FAIL;
 			}
 
@@ -3877,7 +3648,6 @@ int sd_rw(struct scsi_cmnd *srb, struct rtsx_chip *chip, u32 start_sector,
 						     NULL, 0);
 			if (retval != STATUS_SUCCESS) {
 				chip->rw_need_retry = 1;
-				rtsx_trace(chip);
 				goto RW_FAIL;
 			}
 
@@ -3923,7 +3693,6 @@ int sd_rw(struct scsi_cmnd *srb, struct rtsx_chip *chip, u32 start_sector,
 			chip->rw_need_retry = 0;
 			dev_dbg(rtsx_dev(chip), "No card exist, exit %s\n",
 				__func__);
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
@@ -3933,24 +3702,20 @@ int sd_rw(struct scsi_cmnd *srb, struct rtsx_chip *chip, u32 start_sector,
 					     SD_RSP_TYPE_R1b, NULL, 0);
 		if (retval != STATUS_SUCCESS) {
 			sd_set_err_code(chip, SD_STS_ERR);
-			rtsx_trace(chip);
 			goto RW_FAIL;
 		}
 
 		if (stat & (SD_CRC7_ERR | SD_CRC16_ERR | SD_CRC_WRITE_ERR)) {
 			dev_dbg(rtsx_dev(chip), "SD CRC error, tune clock!\n");
 			sd_set_err_code(chip, SD_CRC_ERR);
-			rtsx_trace(chip);
 			goto RW_FAIL;
 		}
 
 		if (err == STATUS_TIMEDOUT) {
 			sd_set_err_code(chip, SD_TO_ERR);
-			rtsx_trace(chip);
 			goto RW_FAIL;
 		}
 
-		rtsx_trace(chip);
 		return err;
 	}
 
@@ -3966,7 +3731,6 @@ int sd_rw(struct scsi_cmnd *srb, struct rtsx_chip *chip, u32 start_sector,
 	if (detect_card_cd(chip, SD_CARD) != STATUS_SUCCESS) {
 		chip->rw_need_retry = 0;
 		dev_dbg(rtsx_dev(chip), "No card exist, exit %s\n", __func__);
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -3988,7 +3752,6 @@ int sd_rw(struct scsi_cmnd *srb, struct rtsx_chip *chip, u32 start_sector,
 		}
 	}
 
-	rtsx_trace(chip);
 	return STATUS_FAIL;
 }
 
@@ -4057,14 +3820,12 @@ int ext_sd_send_cmd_get_rsp(struct rtsx_chip *chip, u8 cmd_idx, u32 arg,
 			if (rsp_type & SD_WAIT_BUSY_END) {
 				retval = sd_check_data0_status(chip);
 				if (retval != STATUS_SUCCESS) {
-					rtsx_trace(chip);
 					return retval;
 				}
 			} else {
 				sd_set_err_code(chip, SD_TO_ERR);
 			}
 		}
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -4075,7 +3836,6 @@ int ext_sd_send_cmd_get_rsp(struct rtsx_chip *chip, u8 cmd_idx, u32 arg,
 
 	if ((ptr[0] & 0xC0) != 0) {
 		sd_set_err_code(chip, SD_STS_ERR);
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -4083,7 +3843,6 @@ int ext_sd_send_cmd_get_rsp(struct rtsx_chip *chip, u8 cmd_idx, u32 arg,
 		if (ptr[stat_idx] & SD_CRC7_ERR) {
 			if (cmd_idx == WRITE_MULTIPLE_BLOCK) {
 				sd_set_err_code(chip, SD_CRC_ERR);
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 			if (rty_cnt < SD_MAX_RETRY_COUNT) {
@@ -4092,7 +3851,6 @@ int ext_sd_send_cmd_get_rsp(struct rtsx_chip *chip, u8 cmd_idx, u32 arg,
 				goto RTY_SEND_CMD;
 			} else {
 				sd_set_err_code(chip, SD_CRC_ERR);
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 		}
@@ -4102,7 +3860,6 @@ int ext_sd_send_cmd_get_rsp(struct rtsx_chip *chip, u8 cmd_idx, u32 arg,
 	    (cmd_idx == SEND_STATUS) || (cmd_idx == STOP_TRANSMISSION)) {
 		if ((cmd_idx != STOP_TRANSMISSION) && !special_check) {
 			if (ptr[1] & 0x80) {
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 		}
@@ -4111,18 +3868,15 @@ int ext_sd_send_cmd_get_rsp(struct rtsx_chip *chip, u8 cmd_idx, u32 arg,
 #else
 		if (ptr[1] & 0x7F) {
 #endif
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 		if (ptr[2] & 0xF8) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
 		if (cmd_idx == SELECT_CARD) {
 			if (rsp_type == SD_RSP_TYPE_R2) {
 				if ((ptr[3] & 0x1E) != 0x04) {
-					rtsx_trace(chip);
 					return STATUS_FAIL;
 				}
 			}
@@ -4162,7 +3916,6 @@ int ext_sd_get_rsp(struct rtsx_chip *chip, int len, u8 *rsp, u8 rsp_type)
 
 	retval = rtsx_send_cmd(chip, SD_CARD, 100);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -4210,7 +3963,6 @@ int sd_pass_thru_mode(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	if (!(CHK_BIT(chip->lun_mc, lun))) {
 		SET_BIT(chip->lun_mc, lun);
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_CHANGE);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
@@ -4219,7 +3971,6 @@ int sd_pass_thru_mode(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	    (srb->cmnd[6] != 0x61) || (srb->cmnd[7] != 0x72) ||
 	    (srb->cmnd[8] != 0x64)) {
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
@@ -4234,7 +3985,6 @@ int sd_pass_thru_mode(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 	default:
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
@@ -4303,20 +4053,17 @@ int sd_execute_no_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 	if (!sd_card->sd_pass_thru_en) {
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
 	retval = sd_switch_clock(chip);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
 	if (sd_card->pre_cmd_err) {
 		sd_card->pre_cmd_err = 0;
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_CHANGE);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
@@ -4333,14 +4080,12 @@ int sd_execute_no_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	retval = get_rsp_type(srb, &rsp_type, &rsp_len);
 	if (retval != STATUS_SUCCESS) {
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 	sd_card->last_rsp_type = rsp_type;
 
 	retval = sd_switch_clock(chip);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
@@ -4350,7 +4095,6 @@ int sd_execute_no_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 			retval = rtsx_write_register(chip, REG_SD_CFG1, 0x03,
 						     SD_BUS_WIDTH_8);
 			if (retval != STATUS_SUCCESS) {
-				rtsx_trace(chip);
 				return TRANSPORT_FAILED;
 			}
 
@@ -4358,7 +4102,6 @@ int sd_execute_no_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 			retval = rtsx_write_register(chip, REG_SD_CFG1, 0x03,
 						     SD_BUS_WIDTH_4);
 			if (retval != STATUS_SUCCESS) {
-				rtsx_trace(chip);
 				return TRANSPORT_FAILED;
 			}
 		}
@@ -4366,7 +4109,6 @@ int sd_execute_no_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 #else
 	retval = rtsx_write_register(chip, REG_SD_CFG1, 0x03, SD_BUS_WIDTH_4);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 #endif
@@ -4374,7 +4116,6 @@ int sd_execute_no_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	if (standby) {
 		retval = sd_select_card(chip, 0);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			goto sd_execute_cmd_failed;
 		}
 	}
@@ -4385,7 +4126,6 @@ int sd_execute_no_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 						 SD_RSP_TYPE_R1, NULL, 0,
 						 false);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			goto sd_execute_cmd_failed;
 		}
 	}
@@ -4393,14 +4133,12 @@ int sd_execute_no_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	retval = ext_sd_send_cmd_get_rsp(chip, cmd_idx, arg, rsp_type,
 					 sd_card->rsp, rsp_len, false);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		goto sd_execute_cmd_failed;
 	}
 
 	if (standby) {
 		retval = sd_select_card(chip, 1);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			goto sd_execute_cmd_failed;
 		}
 	}
@@ -4408,7 +4146,6 @@ int sd_execute_no_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 #ifdef SUPPORT_SD_LOCK
 	retval = sd_update_lock_status(chip);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		goto sd_execute_cmd_failed;
 	}
 #endif
@@ -4424,7 +4161,6 @@ int sd_execute_no_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	if (!(chip->card_ready & SD_CARD))
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_NOT_PRESENT);
 
-	rtsx_trace(chip);
 	return TRANSPORT_FAILED;
 }
 
@@ -4440,20 +4176,17 @@ int sd_execute_read_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 	if (!sd_card->sd_pass_thru_en) {
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
 	if (sd_card->pre_cmd_err) {
 		sd_card->pre_cmd_err = 0;
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_CHANGE);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
 	retval = sd_switch_clock(chip);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
@@ -4473,14 +4206,12 @@ int sd_execute_read_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	retval = get_rsp_type(srb, &rsp_type, &rsp_len);
 	if (retval != STATUS_SUCCESS) {
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 	sd_card->last_rsp_type = rsp_type;
 
 	retval = sd_switch_clock(chip);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
@@ -4505,7 +4236,6 @@ int sd_execute_read_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 						 SD_RSP_TYPE_R1, NULL, 0,
 						 false);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			goto sd_execute_read_cmd_failed;
 		}
 	}
@@ -4513,7 +4243,6 @@ int sd_execute_read_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	if (standby) {
 		retval = sd_select_card(chip, 0);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			goto sd_execute_read_cmd_failed;
 		}
 	}
@@ -4524,7 +4253,6 @@ int sd_execute_read_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 						 SD_RSP_TYPE_R1, NULL, 0,
 						 false);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			goto sd_execute_read_cmd_failed;
 		}
 	}
@@ -4546,7 +4274,6 @@ int sd_execute_read_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 		buf = kmalloc(data_len, GFP_KERNEL);
 		if (!buf) {
-			rtsx_trace(chip);
 			return TRANSPORT_ERROR;
 		}
 
@@ -4556,7 +4283,6 @@ int sd_execute_read_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 			read_err = true;
 			kfree(buf);
 			rtsx_clear_sd_error(chip);
-			rtsx_trace(chip);
 			goto sd_execute_read_cmd_failed;
 		}
 
@@ -4606,25 +4332,21 @@ int sd_execute_read_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 		if (retval < 0) {
 			read_err = true;
 			rtsx_clear_sd_error(chip);
-			rtsx_trace(chip);
 			goto sd_execute_read_cmd_failed;
 		}
 
 	} else {
-		rtsx_trace(chip);
 		goto sd_execute_read_cmd_failed;
 	}
 
 	retval = ext_sd_get_rsp(chip, rsp_len, sd_card->rsp, rsp_type);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		goto sd_execute_read_cmd_failed;
 	}
 
 	if (standby) {
 		retval = sd_select_card(chip, 1);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			goto sd_execute_read_cmd_failed;
 		}
 	}
@@ -4634,7 +4356,6 @@ int sd_execute_read_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 						 SD_RSP_TYPE_R1b, NULL, 0,
 						 false);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			goto sd_execute_read_cmd_failed;
 		}
 	}
@@ -4644,19 +4365,16 @@ int sd_execute_read_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 						 SD_RSP_TYPE_R1, NULL, 0,
 						 false);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			goto sd_execute_read_cmd_failed;
 		}
 
 		retval = rtsx_write_register(chip, SD_BYTE_CNT_H, 0xFF, 0x02);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			goto sd_execute_read_cmd_failed;
 		}
 
 		retval = rtsx_write_register(chip, SD_BYTE_CNT_L, 0xFF, 0x00);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			goto sd_execute_read_cmd_failed;
 		}
 	}
@@ -4673,7 +4391,6 @@ int sd_execute_read_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 			break;
 	}
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		goto sd_execute_read_cmd_failed;
 	}
 
@@ -4691,7 +4408,6 @@ int sd_execute_read_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	if (!(chip->card_ready & SD_CARD))
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_NOT_PRESENT);
 
-	rtsx_trace(chip);
 	return TRANSPORT_FAILED;
 }
 
@@ -4712,20 +4428,17 @@ int sd_execute_write_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 	if (!sd_card->sd_pass_thru_en) {
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
 	if (sd_card->pre_cmd_err) {
 		sd_card->pre_cmd_err = 0;
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_CHANGE);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
 	retval = sd_switch_clock(chip);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
@@ -4754,14 +4467,12 @@ int sd_execute_write_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	retval = get_rsp_type(srb, &rsp_type, &rsp_len);
 	if (retval != STATUS_SUCCESS) {
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 	sd_card->last_rsp_type = rsp_type;
 
 	retval = sd_switch_clock(chip);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
@@ -4771,7 +4482,6 @@ int sd_execute_write_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 			retval = rtsx_write_register(chip, REG_SD_CFG1, 0x03,
 						     SD_BUS_WIDTH_8);
 			if (retval != STATUS_SUCCESS) {
-				rtsx_trace(chip);
 				return TRANSPORT_FAILED;
 			}
 
@@ -4779,7 +4489,6 @@ int sd_execute_write_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 			retval = rtsx_write_register(chip, REG_SD_CFG1, 0x03,
 						     SD_BUS_WIDTH_4);
 			if (retval != STATUS_SUCCESS) {
-				rtsx_trace(chip);
 				return TRANSPORT_FAILED;
 			}
 		}
@@ -4787,7 +4496,6 @@ int sd_execute_write_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 #else
 	retval = rtsx_write_register(chip, REG_SD_CFG1, 0x03, SD_BUS_WIDTH_4);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 #endif
@@ -4797,7 +4505,6 @@ int sd_execute_write_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 						 SD_RSP_TYPE_R1, NULL, 0,
 						 false);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			goto sd_execute_write_cmd_failed;
 		}
 	}
@@ -4805,7 +4512,6 @@ int sd_execute_write_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	if (standby) {
 		retval = sd_select_card(chip, 0);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			goto sd_execute_write_cmd_failed;
 		}
 	}
@@ -4816,7 +4522,6 @@ int sd_execute_write_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 						 SD_RSP_TYPE_R1, NULL, 0,
 						 false);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			goto sd_execute_write_cmd_failed;
 		}
 	}
@@ -4824,7 +4529,6 @@ int sd_execute_write_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	retval = ext_sd_send_cmd_get_rsp(chip, cmd_idx, arg, rsp_type,
 					 sd_card->rsp, rsp_len, false);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		goto sd_execute_write_cmd_failed;
 	}
 
@@ -4834,7 +4538,6 @@ int sd_execute_write_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 		buf = kmalloc(data_len, GFP_KERNEL);
 		if (!buf) {
-			rtsx_trace(chip);
 			return TRANSPORT_ERROR;
 		}
 
@@ -4854,7 +4557,6 @@ int sd_execute_write_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 			retval = rtsx_send_cmd(chip, 0, 250);
 			if (retval != STATUS_SUCCESS) {
 				kfree(buf);
-				rtsx_trace(chip);
 				goto sd_execute_write_cmd_failed;
 			}
 
@@ -4866,7 +4568,6 @@ int sd_execute_write_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 			retval = rtsx_send_cmd(chip, 0, 250);
 			if (retval != STATUS_SUCCESS) {
 				kfree(buf);
-				rtsx_trace(chip);
 				goto sd_execute_write_cmd_failed;
 			}
 		} else {
@@ -4878,7 +4579,6 @@ int sd_execute_write_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 			retval = rtsx_send_cmd(chip, 0, 250);
 			if (retval != STATUS_SUCCESS) {
 				kfree(buf);
-				rtsx_trace(chip);
 				goto sd_execute_write_cmd_failed;
 			}
 		}
@@ -4931,14 +4631,12 @@ int sd_execute_write_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 					    DMA_TO_DEVICE, 10000);
 
 	} else {
-		rtsx_trace(chip);
 		goto sd_execute_write_cmd_failed;
 	}
 
 	if (retval < 0) {
 		write_err = true;
 		rtsx_clear_sd_error(chip);
-		rtsx_trace(chip);
 		goto sd_execute_write_cmd_failed;
 	}
 
@@ -4966,7 +4664,6 @@ int sd_execute_write_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	if (standby) {
 		retval = sd_select_card(chip, 1);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			goto sd_execute_write_cmd_failed;
 		}
 	}
@@ -4976,7 +4673,6 @@ int sd_execute_write_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 						 SD_RSP_TYPE_R1b, NULL, 0,
 						 false);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			goto sd_execute_write_cmd_failed;
 		}
 	}
@@ -4986,19 +4682,16 @@ int sd_execute_write_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 						 SD_RSP_TYPE_R1, NULL, 0,
 						 false);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			goto sd_execute_write_cmd_failed;
 		}
 
 		retval = rtsx_write_register(chip, SD_BYTE_CNT_H, 0xFF, 0x02);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			goto sd_execute_write_cmd_failed;
 		}
 
 		rtsx_write_register(chip, SD_BYTE_CNT_L, 0xFF, 0x00);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			goto sd_execute_write_cmd_failed;
 		}
 	}
@@ -5015,7 +4708,6 @@ int sd_execute_write_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 			break;
 	}
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		goto sd_execute_write_cmd_failed;
 	}
 
@@ -5043,7 +4735,6 @@ int sd_execute_write_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 						retval = reset_sd(chip);
 						if (retval != STATUS_SUCCESS) {
 							sd_card->sd_lock_status &= ~(SD_UNLOCK_POW_ON | SD_SDR_RST);
-							rtsx_trace(chip);
 							goto sd_execute_write_cmd_failed;
 						}
 					}
@@ -5057,7 +4748,6 @@ int sd_execute_write_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	if (lock_cmd_fail) {
 		scsi_set_resid(srb, 0);
 		set_sense_type(chip, lun, SENSE_TYPE_NO_SENSE);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 #endif  /* SUPPORT_SD_LOCK */
@@ -5076,7 +4766,6 @@ int sd_execute_write_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	if (!(chip->card_ready & SD_CARD))
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_NOT_PRESENT);
 
-	rtsx_trace(chip);
 	return TRANSPORT_FAILED;
 }
 
@@ -5089,14 +4778,12 @@ int sd_get_cmd_rsp(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 	if (!sd_card->sd_pass_thru_en) {
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
 	if (sd_card->pre_cmd_err) {
 		sd_card->pre_cmd_err = 0;
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_CHANGE);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
@@ -5104,7 +4791,6 @@ int sd_get_cmd_rsp(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 	if (sd_card->last_rsp_type == SD_RSP_TYPE_R0) {
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	} else if (sd_card->last_rsp_type == SD_RSP_TYPE_R2) {
 		count = (data_len < 17) ? data_len : 17;
@@ -5130,14 +4816,12 @@ int sd_hw_rst(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 	if (!sd_card->sd_pass_thru_en) {
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
 	if (sd_card->pre_cmd_err) {
 		sd_card->pre_cmd_err = 0;
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_CHANGE);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
@@ -5146,7 +4830,6 @@ int sd_hw_rst(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	    (srb->cmnd[6] != 0x61) || (srb->cmnd[7] != 0x72) ||
 	    (srb->cmnd[8] != 0x64)) {
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
@@ -5163,7 +4846,6 @@ int sd_hw_rst(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 #endif
 			set_sense_type(chip, lun, SENSE_TYPE_MEDIA_NOT_PRESENT);
 			sd_card->pre_cmd_err = 1;
-			rtsx_trace(chip);
 			return TRANSPORT_FAILED;
 		}
 #ifdef SUPPORT_SD_LOCK
@@ -5176,14 +4858,12 @@ int sd_hw_rst(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 		if (retval != STATUS_SUCCESS) {
 			set_sense_type(chip, lun, SENSE_TYPE_MEDIA_NOT_PRESENT);
 			sd_card->pre_cmd_err = 1;
-			rtsx_trace(chip);
 			return TRANSPORT_FAILED;
 		}
 		break;
 
 	default:
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
-		rtsx_trace(chip);
 		return TRANSPORT_FAILED;
 	}
 
@@ -5209,20 +4889,17 @@ int sd_power_off_card3v3(struct rtsx_chip *chip)
 
 	retval = disable_card_clock(chip, SD_CARD);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	retval = rtsx_write_register(chip, CARD_OE, SD_OUTPUT_EN, 0);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 
 	if (!chip->ft2_fast_mode) {
 		retval = card_power_off(chip, SD_CARD);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
@@ -5232,7 +4909,6 @@ int sd_power_off_card3v3(struct rtsx_chip *chip)
 	if (chip->asic_code) {
 		retval = sd_pull_ctl_disable(chip);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	} else {
@@ -5240,7 +4916,6 @@ int sd_power_off_card3v3(struct rtsx_chip *chip)
 					     FPGA_SD_PULL_CTL_BIT | 0x20,
 					     FPGA_SD_PULL_CTL_BIT);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 	}
@@ -5270,7 +4945,6 @@ int release_sd_card(struct rtsx_chip *chip)
 
 	retval = sd_power_off_card3v3(chip);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
diff --git a/drivers/staging/rts5208/spi.c b/drivers/staging/rts5208/spi.c
index b5646b62ec9e..4675668ad977 100644
--- a/drivers/staging/rts5208/spi.c
+++ b/drivers/staging/rts5208/spi.c
@@ -42,13 +42,11 @@ static int spi_init(struct rtsx_chip *chip)
 				     CS_POLARITY_LOW | DTO_MSB_FIRST
 				     | SPI_MASTER | SPI_MODE0 | SPI_AUTO);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 	retval = rtsx_write_register(chip, SPI_TCTL, EDO_TIMING_MASK,
 				     SAMPLE_DELAY_HALF);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 
@@ -63,38 +61,32 @@ static int spi_set_init_para(struct rtsx_chip *chip)
 	retval = rtsx_write_register(chip, SPI_CLK_DIVIDER1, 0xFF,
 				     (u8)(spi->clk_div >> 8));
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 	retval = rtsx_write_register(chip, SPI_CLK_DIVIDER0, 0xFF,
 				     (u8)(spi->clk_div));
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 
 	retval = switch_clock(chip, spi->spi_clock);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	retval = select_card(chip, SPI_CARD);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	retval = rtsx_write_register(chip, CARD_CLK_EN, SPI_CLK_EN,
 				     SPI_CLK_EN);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 	retval = rtsx_write_register(chip, CARD_OE, SPI_OUTPUT_EN,
 				     SPI_OUTPUT_EN);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 
@@ -102,7 +94,6 @@ static int spi_set_init_para(struct rtsx_chip *chip)
 
 	retval = spi_init(chip);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -125,7 +116,6 @@ static int sf_polling_status(struct rtsx_chip *chip, int msec)
 	if (retval < 0) {
 		rtsx_clear_spi_error(chip);
 		spi_set_err_code(chip, SPI_BUSY_ERR);
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -154,7 +144,6 @@ static int sf_enable_write(struct rtsx_chip *chip, u8 ins)
 	if (retval < 0) {
 		rtsx_clear_spi_error(chip);
 		spi_set_err_code(chip, SPI_HW_ERR);
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -183,7 +172,6 @@ static int sf_disable_write(struct rtsx_chip *chip, u8 ins)
 	if (retval < 0) {
 		rtsx_clear_spi_error(chip);
 		spi_set_err_code(chip, SPI_HW_ERR);
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -242,7 +230,6 @@ static int sf_erase(struct rtsx_chip *chip, u8 ins, u8 addr_mode, u32 addr)
 	if (retval < 0) {
 		rtsx_clear_spi_error(chip);
 		spi_set_err_code(chip, SPI_HW_ERR);
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -261,37 +248,31 @@ static int spi_init_eeprom(struct rtsx_chip *chip)
 
 	retval = rtsx_write_register(chip, SPI_CLK_DIVIDER1, 0xFF, 0x00);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 	retval = rtsx_write_register(chip, SPI_CLK_DIVIDER0, 0xFF, 0x27);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 
 	retval = switch_clock(chip, clk);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	retval = select_card(chip, SPI_CARD);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	retval = rtsx_write_register(chip, CARD_CLK_EN, SPI_CLK_EN,
 				     SPI_CLK_EN);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 	retval = rtsx_write_register(chip, CARD_OE, SPI_OUTPUT_EN,
 				     SPI_OUTPUT_EN);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 
@@ -300,13 +281,11 @@ static int spi_init_eeprom(struct rtsx_chip *chip)
 	retval = rtsx_write_register(chip, SPI_CONTROL, 0xFF,
 				     CS_POLARITY_HIGH | SPI_EEPROM_AUTO);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 	retval = rtsx_write_register(chip, SPI_TCTL, EDO_TIMING_MASK,
 				     SAMPLE_DELAY_HALF);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 
@@ -328,7 +307,6 @@ static int spi_eeprom_program_enable(struct rtsx_chip *chip)
 
 	retval = rtsx_send_cmd(chip, 0, 100);
 	if (retval < 0) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -341,13 +319,11 @@ int spi_erase_eeprom_chip(struct rtsx_chip *chip)
 
 	retval = spi_init_eeprom(chip);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	retval = spi_eeprom_program_enable(chip);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -364,13 +340,11 @@ int spi_erase_eeprom_chip(struct rtsx_chip *chip)
 
 	retval = rtsx_send_cmd(chip, 0, 100);
 	if (retval < 0) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	retval = rtsx_write_register(chip, CARD_GPIO_DIR, 0x01, 0x01);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 
@@ -383,13 +357,11 @@ int spi_erase_eeprom_byte(struct rtsx_chip *chip, u16 addr)
 
 	retval = spi_init_eeprom(chip);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	retval = spi_eeprom_program_enable(chip);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -408,13 +380,11 @@ int spi_erase_eeprom_byte(struct rtsx_chip *chip, u16 addr)
 
 	retval = rtsx_send_cmd(chip, 0, 100);
 	if (retval < 0) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	retval = rtsx_write_register(chip, CARD_GPIO_DIR, 0x01, 0x01);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 
@@ -428,7 +398,6 @@ int spi_read_eeprom(struct rtsx_chip *chip, u16 addr, u8 *val)
 
 	retval = spi_init_eeprom(chip);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -448,14 +417,12 @@ int spi_read_eeprom(struct rtsx_chip *chip, u16 addr, u8 *val)
 
 	retval = rtsx_send_cmd(chip, 0, 100);
 	if (retval < 0) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	wait_timeout(5);
 	retval = rtsx_read_register(chip, SPI_DATA, &data);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 
@@ -464,7 +431,6 @@ int spi_read_eeprom(struct rtsx_chip *chip, u16 addr, u8 *val)
 
 	retval = rtsx_write_register(chip, CARD_GPIO_DIR, 0x01, 0x01);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 
@@ -477,13 +443,11 @@ int spi_write_eeprom(struct rtsx_chip *chip, u16 addr, u8 val)
 
 	retval = spi_init_eeprom(chip);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	retval = spi_eeprom_program_enable(chip);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -503,13 +467,11 @@ int spi_write_eeprom(struct rtsx_chip *chip, u16 addr, u8 val)
 
 	retval = rtsx_send_cmd(chip, 0, 100);
 	if (retval < 0) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	retval = rtsx_write_register(chip, CARD_GPIO_DIR, 0x01, 0x01);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 
@@ -562,14 +524,12 @@ int spi_read_flash_id(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	len = ((u16)(srb->cmnd[7]) << 8) | srb->cmnd[8];
 	if (len > 512) {
 		spi_set_err_code(chip, SPI_INVALID_COMMAND);
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	retval = spi_set_init_para(chip);
 	if (retval != STATUS_SUCCESS) {
 		spi_set_err_code(chip, SPI_HW_ERR);
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -612,14 +572,12 @@ int spi_read_flash_id(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	if (retval < 0) {
 		rtsx_clear_spi_error(chip);
 		spi_set_err_code(chip, SPI_HW_ERR);
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	if (len) {
 		buf = kmalloc(len, GFP_KERNEL);
 		if (!buf) {
-			rtsx_trace(chip);
 			return STATUS_ERROR;
 		}
 
@@ -627,7 +585,6 @@ int spi_read_flash_id(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 		if (retval != STATUS_SUCCESS) {
 			spi_set_err_code(chip, SPI_READ_ERR);
 			kfree(buf);
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
@@ -660,13 +617,11 @@ int spi_read_flash(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	retval = spi_set_init_para(chip);
 	if (retval != STATUS_SUCCESS) {
 		spi_set_err_code(chip, SPI_HW_ERR);
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	buf = kmalloc(SF_PAGE_LEN, GFP_KERNEL);
 	if (!buf) {
-		rtsx_trace(chip);
 		return STATUS_ERROR;
 	}
 
@@ -720,7 +675,6 @@ int spi_read_flash(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 			kfree(buf);
 			rtsx_clear_spi_error(chip);
 			spi_set_err_code(chip, SPI_HW_ERR);
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
@@ -757,14 +711,12 @@ int spi_write_flash(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	retval = spi_set_init_para(chip);
 	if (retval != STATUS_SUCCESS) {
 		spi_set_err_code(chip, SPI_HW_ERR);
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	if (program_mode == BYTE_PROGRAM) {
 		buf = kmalloc(4, GFP_KERNEL);
 		if (!buf) {
-			rtsx_trace(chip);
 			return STATUS_ERROR;
 		}
 
@@ -772,7 +724,6 @@ int spi_write_flash(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 			retval = sf_enable_write(chip, SPI_WREN);
 			if (retval != STATUS_SUCCESS) {
 				kfree(buf);
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 
@@ -792,14 +743,12 @@ int spi_write_flash(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 				kfree(buf);
 				rtsx_clear_spi_error(chip);
 				spi_set_err_code(chip, SPI_HW_ERR);
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 
 			retval = sf_polling_status(chip, 100);
 			if (retval != STATUS_SUCCESS) {
 				kfree(buf);
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 
@@ -814,13 +763,11 @@ int spi_write_flash(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 		retval = sf_enable_write(chip, SPI_WREN);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
 		buf = kmalloc(4, GFP_KERNEL);
 		if (!buf) {
-			rtsx_trace(chip);
 			return STATUS_ERROR;
 		}
 
@@ -846,14 +793,12 @@ int spi_write_flash(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 				kfree(buf);
 				rtsx_clear_spi_error(chip);
 				spi_set_err_code(chip, SPI_HW_ERR);
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 
 			retval = sf_polling_status(chip, 100);
 			if (retval != STATUS_SUCCESS) {
 				kfree(buf);
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 
@@ -864,19 +809,16 @@ int spi_write_flash(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 		retval = sf_disable_write(chip, SPI_WRDI);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
 		retval = sf_polling_status(chip, 100);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	} else if (program_mode == PAGE_PROGRAM) {
 		buf = kmalloc(SF_PAGE_LEN, GFP_KERNEL);
 		if (!buf) {
-			rtsx_trace(chip);
 			return STATUS_NOMEM;
 		}
 
@@ -889,7 +831,6 @@ int spi_write_flash(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 			retval = sf_enable_write(chip, SPI_WREN);
 			if (retval != STATUS_SUCCESS) {
 				kfree(buf);
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 
@@ -909,14 +850,12 @@ int spi_write_flash(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 				kfree(buf);
 				rtsx_clear_spi_error(chip);
 				spi_set_err_code(chip, SPI_HW_ERR);
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 
 			retval = sf_polling_status(chip, 100);
 			if (retval != STATUS_SUCCESS) {
 				kfree(buf);
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 
@@ -927,7 +866,6 @@ int spi_write_flash(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 		kfree(buf);
 	} else {
 		spi_set_err_code(chip, SPI_INVALID_COMMAND);
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -950,37 +888,31 @@ int spi_erase_flash(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	retval = spi_set_init_para(chip);
 	if (retval != STATUS_SUCCESS) {
 		spi_set_err_code(chip, SPI_HW_ERR);
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	if (erase_mode == PAGE_ERASE) {
 		retval = sf_enable_write(chip, SPI_WREN);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
 		retval = sf_erase(chip, ins, 1, addr);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	} else if (erase_mode == CHIP_ERASE) {
 		retval = sf_enable_write(chip, SPI_WREN);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
 		retval = sf_erase(chip, ins, 0, 0);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	} else {
 		spi_set_err_code(chip, SPI_INVALID_COMMAND);
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -999,13 +931,11 @@ int spi_write_flash_status(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	retval = spi_set_init_para(chip);
 	if (retval != STATUS_SUCCESS) {
 		spi_set_err_code(chip, SPI_HW_ERR);
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	retval = sf_enable_write(chip, ewsr);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -1029,7 +959,6 @@ int spi_write_flash_status(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	if (retval != STATUS_SUCCESS) {
 		rtsx_clear_spi_error(chip);
 		spi_set_err_code(chip, SPI_HW_ERR);
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
diff --git a/drivers/staging/rts5208/trace.c b/drivers/staging/rts5208/trace.c
deleted file mode 100644
index c878e75293f7..000000000000
--- a/drivers/staging/rts5208/trace.c
+++ /dev/null
@@ -1,27 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/kernel.h>
-#include <linux/string.h>
-
-#include "rtsx.h"
-
-#ifdef _MSG_TRACE
-
-void _rtsx_trace(struct rtsx_chip *chip, const char *file, const char *func,
-		 int line)
-{
-	struct trace_msg_t *msg = &chip->trace_msg[chip->msg_idx];
-
-	file = kbasename(file);
-	dev_dbg(rtsx_dev(chip), "[%s][%s]:[%d]\n", file, func, line);
-
-	strncpy(msg->file, file, MSG_FILE_LEN - 1);
-	strncpy(msg->func, func, MSG_FUNC_LEN - 1);
-	msg->line = (u16)line;
-	get_current_time(msg->timeval_buf, TIME_VAL_LEN);
-	msg->valid = 1;
-
-	chip->msg_idx++;
-	if (chip->msg_idx >= TRACE_ITEM_CNT)
-		chip->msg_idx = 0;
-}
-#endif
diff --git a/drivers/staging/rts5208/trace.h b/drivers/staging/rts5208/trace.h
deleted file mode 100644
index 5b807874c1d7..000000000000
--- a/drivers/staging/rts5208/trace.h
+++ /dev/null
@@ -1,40 +0,0 @@
-/* Driver for Realtek PCI-Express card reader
- * Header file
- *
- * Copyright(c) 2009-2013 Realtek Semiconductor Corp. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the
- * Free Software Foundation; either version 2, or (at your option) any
- * later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, see <http://www.gnu.org/licenses/>.
- *
- * Author:
- *   Wei WANG (wei_wang@realsil.com.cn)
- *   Micky Ching (micky_ching@realsil.com.cn)
- */
-
-#ifndef __REALTEK_RTSX_TRACE_H
-#define __REALTEK_RTSX_TRACE_H
-
-struct rtsx_chip;
-
-#ifdef _MSG_TRACE
-void _rtsx_trace(struct rtsx_chip *chip, const char *file, const char *func,
-		 int line);
-#define rtsx_trace(chip)						\
-	_rtsx_trace(chip, __FILE__, __func__, __LINE__)
-#else
-static inline void rtsx_trace(struct rtsx_chip *chip)
-{
-}
-#endif
-
-#endif  /* __REALTEK_RTSX_TRACE_H */
diff --git a/drivers/staging/rts5208/xd.c b/drivers/staging/rts5208/xd.c
index 11ea0c658e28..667dfe1d76bc 100644
--- a/drivers/staging/rts5208/xd.c
+++ b/drivers/staging/rts5208/xd.c
@@ -61,7 +61,6 @@ static int xd_set_init_para(struct rtsx_chip *chip)
 
 	retval = switch_clock(chip, xd_card->xd_clock);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -75,13 +74,11 @@ static int xd_switch_clock(struct rtsx_chip *chip)
 
 	retval = select_card(chip, XD_CARD);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	retval = switch_clock(chip, xd_card->xd_clock);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -106,7 +103,6 @@ static int xd_read_id(struct rtsx_chip *chip, u8 id_cmd, u8 *id_buf, u8 buf_len)
 
 	retval = rtsx_send_cmd(chip, XD_CARD, 20);
 	if (retval < 0) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -178,7 +174,6 @@ static int xd_read_redundant(struct rtsx_chip *chip, u32 page_addr,
 
 	retval = rtsx_send_cmd(chip, XD_CARD, 500);
 	if (retval < 0) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -199,7 +194,6 @@ static int xd_read_data_from_ppb(struct rtsx_chip *chip, int offset,
 	int retval, i;
 
 	if (!buf || (buf_len < 0)) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -212,7 +206,6 @@ static int xd_read_data_from_ppb(struct rtsx_chip *chip, int offset,
 	retval = rtsx_send_cmd(chip, 0, 250);
 	if (retval < 0) {
 		rtsx_clear_xd_error(chip);
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -228,7 +221,6 @@ static int xd_read_cis(struct rtsx_chip *chip, u32 page_addr, u8 *buf,
 	u8 reg;
 
 	if (!buf || (buf_len < 10)) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -250,30 +242,25 @@ static int xd_read_cis(struct rtsx_chip *chip, u32 page_addr, u8 *buf,
 	retval = rtsx_send_cmd(chip, XD_CARD, 250);
 	if (retval == -ETIMEDOUT) {
 		rtsx_clear_xd_error(chip);
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	retval = rtsx_read_register(chip, XD_PAGE_STATUS, &reg);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 	if (reg != XD_GPG) {
 		rtsx_clear_xd_error(chip);
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	retval = rtsx_read_register(chip, XD_CTL, &reg);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 	if (!(reg & XD_ECC1_ERROR) || !(reg & XD_ECC1_UNCORRECTABLE)) {
 		retval = xd_read_data_from_ppb(chip, 0, buf, buf_len);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 		if (reg & XD_ECC1_ERROR) {
@@ -282,13 +269,11 @@ static int xd_read_cis(struct rtsx_chip *chip, u32 page_addr, u8 *buf,
 			retval = rtsx_read_register(chip, XD_ECC_BIT1,
 						    &ecc_bit);
 			if (retval) {
-				rtsx_trace(chip);
 				return retval;
 			}
 			retval = rtsx_read_register(chip, XD_ECC_BYTE1,
 						    &ecc_byte);
 			if (retval) {
-				rtsx_trace(chip);
 				return retval;
 			}
 
@@ -307,7 +292,6 @@ static int xd_read_cis(struct rtsx_chip *chip, u32 page_addr, u8 *buf,
 
 		retval = xd_read_data_from_ppb(chip, 256, buf, buf_len);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 		if (reg & XD_ECC2_ERROR) {
@@ -316,13 +300,11 @@ static int xd_read_cis(struct rtsx_chip *chip, u32 page_addr, u8 *buf,
 			retval = rtsx_read_register(chip, XD_ECC_BIT2,
 						    &ecc_bit);
 			if (retval) {
-				rtsx_trace(chip);
 				return retval;
 			}
 			retval = rtsx_read_register(chip, XD_ECC_BYTE2,
 						    &ecc_byte);
 			if (retval) {
-				rtsx_trace(chip);
 				return retval;
 			}
 
@@ -338,7 +320,6 @@ static int xd_read_cis(struct rtsx_chip *chip, u32 page_addr, u8 *buf,
 		}
 	} else {
 		rtsx_clear_xd_error(chip);
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -424,7 +405,6 @@ static int xd_pull_ctl_disable(struct rtsx_chip *chip)
 					     XD_D1_PD |
 					     XD_D0_PD);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 		retval = rtsx_write_register(chip, CARD_PULL_CTL2, 0xFF,
@@ -433,7 +413,6 @@ static int xd_pull_ctl_disable(struct rtsx_chip *chip)
 					     XD_D5_PD |
 					     XD_D4_PD);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 		retval = rtsx_write_register(chip, CARD_PULL_CTL3, 0xFF,
@@ -442,7 +421,6 @@ static int xd_pull_ctl_disable(struct rtsx_chip *chip)
 					     XD_CLE_PD |
 					     XD_CD_PU);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 		retval = rtsx_write_register(chip, CARD_PULL_CTL4, 0xFF,
@@ -451,7 +429,6 @@ static int xd_pull_ctl_disable(struct rtsx_chip *chip)
 					     XD_RE_PD |
 					     XD_ALE_PD);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 		retval = rtsx_write_register(chip, CARD_PULL_CTL5, 0xFF,
@@ -460,13 +437,11 @@ static int xd_pull_ctl_disable(struct rtsx_chip *chip)
 					     SD_CD_PU |
 					     SD_CMD_PD);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 		retval = rtsx_write_register(chip, CARD_PULL_CTL6, 0xFF,
 					     MS_D5_PD | MS_D4_PD);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 	} else if (CHECK_PID(chip, 0x5288)) {
@@ -474,25 +449,21 @@ static int xd_pull_ctl_disable(struct rtsx_chip *chip)
 			retval = rtsx_write_register(chip, CARD_PULL_CTL1,
 						     0xFF, 0x55);
 			if (retval) {
-				rtsx_trace(chip);
 				return retval;
 			}
 			retval = rtsx_write_register(chip, CARD_PULL_CTL2,
 						     0xFF, 0x55);
 			if (retval) {
-				rtsx_trace(chip);
 				return retval;
 			}
 			retval = rtsx_write_register(chip, CARD_PULL_CTL3,
 						     0xFF, 0x4B);
 			if (retval) {
-				rtsx_trace(chip);
 				return retval;
 			}
 			retval = rtsx_write_register(chip, CARD_PULL_CTL4,
 						     0xFF, 0x69);
 			if (retval) {
-				rtsx_trace(chip);
 				return retval;
 			}
 		}
@@ -509,7 +480,6 @@ static int reset_xd(struct rtsx_chip *chip)
 
 	retval = select_card(chip, XD_CARD);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -536,14 +506,12 @@ static int reset_xd(struct rtsx_chip *chip)
 
 	retval = rtsx_send_cmd(chip, XD_CARD, 100);
 	if (retval < 0) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	if (!chip->ft2_fast_mode) {
 		retval = card_power_off(chip, XD_CARD);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
@@ -562,13 +530,11 @@ static int reset_xd(struct rtsx_chip *chip)
 
 		retval = rtsx_send_cmd(chip, XD_CARD, 100);
 		if (retval < 0) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
 		retval = card_power_on(chip, XD_CARD);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
@@ -577,7 +543,6 @@ static int reset_xd(struct rtsx_chip *chip)
 		if (chip->ocp_stat & (SD_OC_NOW | SD_OC_EVER)) {
 			dev_dbg(rtsx_dev(chip), "Over current, OCPSTAT is 0x%x\n",
 				chip->ocp_stat);
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 #endif
@@ -601,7 +566,6 @@ static int reset_xd(struct rtsx_chip *chip)
 
 	retval = rtsx_send_cmd(chip, XD_CARD, 100);
 	if (retval < 0) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -610,7 +574,6 @@ static int reset_xd(struct rtsx_chip *chip)
 
 	retval = xd_set_init_para(chip);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -636,7 +599,6 @@ static int reset_xd(struct rtsx_chip *chip)
 
 		retval = rtsx_send_cmd(chip, XD_CARD, 100);
 		if (retval < 0) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
@@ -651,7 +613,6 @@ static int reset_xd(struct rtsx_chip *chip)
 
 		retval = xd_read_id(chip, READ_ID, id_buf, 4);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
@@ -734,7 +695,6 @@ static int reset_xd(struct rtsx_chip *chip)
 		for (j = 0; j < 10; j++) {
 			retval = xd_read_id(chip, READ_ID, id_buf, 4);
 			if (retval != STATUS_SUCCESS) {
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 
@@ -752,19 +712,16 @@ static int reset_xd(struct rtsx_chip *chip)
 		xd_card->addr_cycle = 0;
 		xd_card->capacity = 0;
 
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	retval = xd_read_id(chip, READ_xD_ID, id_buf, 4);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 	dev_dbg(rtsx_dev(chip), "READ_xD_ID: 0x%x 0x%x 0x%x 0x%x\n",
 		id_buf[0], id_buf[1], id_buf[2], id_buf[3]);
 	if (id_buf[2] != XD_ID_CODE) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -773,7 +730,6 @@ static int reset_xd(struct rtsx_chip *chip)
 		u32 page_addr;
 
 		if (detect_card_cd(chip, XD_CARD) != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
@@ -814,7 +770,6 @@ static int reset_xd(struct rtsx_chip *chip)
 
 			retval = xd_read_cis(chip, page_addr, buf, 10);
 			if (retval != STATUS_SUCCESS) {
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 
@@ -833,7 +788,6 @@ static int reset_xd(struct rtsx_chip *chip)
 
 	dev_dbg(rtsx_dev(chip), "CIS block: 0x%x\n", xd_card->cis_block);
 	if (xd_card->cis_block == 0xFFFF) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -889,7 +843,6 @@ static int xd_init_l2p_tbl(struct rtsx_chip *chip)
 		xd_card->zone_cnt);
 
 	if (xd_card->zone_cnt < 1) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -898,7 +851,6 @@ static int xd_init_l2p_tbl(struct rtsx_chip *chip)
 
 	xd_card->zone = vmalloc(size);
 	if (!xd_card->zone) {
-		rtsx_trace(chip);
 		return STATUS_ERROR;
 	}
 
@@ -1078,19 +1030,16 @@ int reset_xd_card(struct rtsx_chip *chip)
 
 	retval = enable_card_clock(chip, XD_CARD);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	retval = reset_xd(chip);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	retval = xd_init_l2p_tbl(chip);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -1107,7 +1056,6 @@ static int xd_mark_bad_block(struct rtsx_chip *chip, u32 phy_blk)
 	dev_dbg(rtsx_dev(chip), "mark block 0x%x as bad block\n", phy_blk);
 
 	if (phy_blk == BLK_NOT_FOUND) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -1144,7 +1092,6 @@ static int xd_mark_bad_block(struct rtsx_chip *chip, u32 phy_blk)
 			xd_set_err_code(chip, XD_PRG_ERROR);
 		else
 			xd_set_err_code(chip, XD_TO_ERROR);
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -1162,11 +1109,9 @@ static int xd_init_page(struct rtsx_chip *chip, u32 phy_blk,
 	dev_dbg(rtsx_dev(chip), "Init block 0x%x\n", phy_blk);
 
 	if (start_page > end_page) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 	if (phy_blk == BLK_NOT_FOUND) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -1203,7 +1148,6 @@ static int xd_init_page(struct rtsx_chip *chip, u32 phy_blk,
 		} else {
 			xd_set_err_code(chip, XD_TO_ERROR);
 		}
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -1222,12 +1166,10 @@ static int xd_copy_page(struct rtsx_chip *chip, u32 old_blk, u32 new_blk,
 		old_blk, new_blk);
 
 	if (start_page > end_page) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	if ((old_blk == BLK_NOT_FOUND) || (new_blk == BLK_NOT_FOUND)) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -1239,7 +1181,6 @@ static int xd_copy_page(struct rtsx_chip *chip, u32 old_blk, u32 new_blk,
 	retval = rtsx_write_register(chip, CARD_DATA_SOURCE, 0x01,
 				     PINGPONG_BUFFER);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 
@@ -1247,7 +1188,6 @@ static int xd_copy_page(struct rtsx_chip *chip, u32 old_blk, u32 new_blk,
 		if (detect_card_cd(chip, XD_CARD) != STATUS_SUCCESS) {
 			rtsx_clear_xd_error(chip);
 			xd_set_err_code(chip, XD_NO_CARD);
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
@@ -1274,7 +1214,6 @@ static int xd_copy_page(struct rtsx_chip *chip, u32 old_blk, u32 new_blk,
 				if (detect_card_cd(chip,
 						   XD_CARD) != STATUS_SUCCESS) {
 					xd_set_err_code(chip, XD_NO_CARD);
-					rtsx_trace(chip);
 					return STATUS_FAIL;
 				}
 
@@ -1296,7 +1235,6 @@ static int xd_copy_page(struct rtsx_chip *chip, u32 old_blk, u32 new_blk,
 				}
 			} else {
 				xd_set_err_code(chip, XD_TO_ERROR);
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 		}
@@ -1325,7 +1263,6 @@ static int xd_copy_page(struct rtsx_chip *chip, u32 old_blk, u32 new_blk,
 			} else {
 				xd_set_err_code(chip, XD_TO_ERROR);
 			}
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
@@ -1352,7 +1289,6 @@ static int xd_reset_cmd(struct rtsx_chip *chip)
 
 	retval = rtsx_send_cmd(chip, XD_CARD, 100);
 	if (retval < 0) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -1360,7 +1296,6 @@ static int xd_reset_cmd(struct rtsx_chip *chip)
 	if (((ptr[0] & READY_FLAG) == READY_STATE) && (ptr[1] & XD_RDY))
 		return STATUS_SUCCESS;
 
-	rtsx_trace(chip);
 	return STATUS_FAIL;
 }
 
@@ -1372,7 +1307,6 @@ static int xd_erase_block(struct rtsx_chip *chip, u32 phy_blk)
 	int i, retval;
 
 	if (phy_blk == BLK_NOT_FOUND) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -1396,13 +1330,11 @@ static int xd_erase_block(struct rtsx_chip *chip, u32 phy_blk)
 			if (reg & PROGRAM_ERROR) {
 				xd_mark_bad_block(chip, phy_blk);
 				xd_set_err_code(chip, XD_PRG_ERROR);
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 			xd_set_err_code(chip, XD_ERASE_FAIL);
 			retval = xd_reset_cmd(chip);
 			if (retval != STATUS_SUCCESS) {
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 			continue;
@@ -1412,7 +1344,6 @@ static int xd_erase_block(struct rtsx_chip *chip, u32 phy_blk)
 		if (*ptr & PROGRAM_ERROR) {
 			xd_mark_bad_block(chip, phy_blk);
 			xd_set_err_code(chip, XD_PRG_ERROR);
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
@@ -1421,7 +1352,6 @@ static int xd_erase_block(struct rtsx_chip *chip, u32 phy_blk)
 
 	xd_mark_bad_block(chip, phy_blk);
 	xd_set_err_code(chip, XD_ERASE_FAIL);
-	rtsx_trace(chip);
 	return STATUS_FAIL;
 }
 
@@ -1454,7 +1384,6 @@ static int xd_build_l2p_tbl(struct rtsx_chip *chip, int zone_no)
 	if (!zone->l2p_table) {
 		zone->l2p_table = vmalloc(2000);
 		if (!zone->l2p_table) {
-			rtsx_trace(chip);
 			goto build_fail;
 		}
 	}
@@ -1463,7 +1392,6 @@ static int xd_build_l2p_tbl(struct rtsx_chip *chip, int zone_no)
 	if (!zone->free_table) {
 		zone->free_table = vmalloc(XD_FREE_TABLE_CNT * 2);
 		if (!zone->free_table) {
-			rtsx_trace(chip);
 			goto build_fail;
 		}
 	}
@@ -1629,7 +1557,6 @@ static int xd_send_cmd(struct rtsx_chip *chip, u8 cmd)
 
 	retval = rtsx_send_cmd(chip, XD_CARD, 200);
 	if (retval < 0) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -1702,7 +1629,6 @@ static int xd_read_multiple_pages(struct rtsx_chip *chip, u32 phy_blk,
 			xd_set_err_code(chip, XD_TO_ERROR);
 			goto status_fail;
 		} else {
-			rtsx_trace(chip);
 			goto fail;
 		}
 	}
@@ -1712,7 +1638,6 @@ static int xd_read_multiple_pages(struct rtsx_chip *chip, u32 phy_blk,
 fail:
 	retval = rtsx_read_register(chip, XD_PAGE_STATUS, &reg_val);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 
@@ -1721,7 +1646,6 @@ static int xd_read_multiple_pages(struct rtsx_chip *chip, u32 phy_blk,
 
 	retval = rtsx_read_register(chip, XD_CTL, &reg_val);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 
@@ -1764,7 +1688,6 @@ static int xd_read_multiple_pages(struct rtsx_chip *chip, u32 phy_blk,
 	}
 
 status_fail:
-	rtsx_trace(chip);
 	return STATUS_FAIL;
 }
 
@@ -1781,7 +1704,6 @@ static int xd_finish_write(struct rtsx_chip *chip,
 	dev_dbg(rtsx_dev(chip), "log_blk = 0x%x\n", log_blk);
 
 	if (page_off > xd_card->page_off) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -1795,7 +1717,6 @@ static int xd_finish_write(struct rtsx_chip *chip,
 			retval = xd_erase_block(chip, new_blk);
 			if (retval == STATUS_SUCCESS)
 				xd_set_unused_block(chip, new_blk);
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	} else {
@@ -1808,7 +1729,6 @@ static int xd_finish_write(struct rtsx_chip *chip,
 					xd_set_unused_block(chip, new_blk);
 			}
 			XD_CLR_BAD_NEWBLK(xd_card);
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
@@ -1842,7 +1762,6 @@ static int xd_prepare_write(struct rtsx_chip *chip,
 	if (page_off) {
 		retval = xd_copy_page(chip, old_blk, new_blk, 0, page_off);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	}
@@ -1912,7 +1831,6 @@ static int xd_write_multiple_pages(struct rtsx_chip *chip, u32 old_blk,
 			xd_set_err_code(chip, XD_TO_ERROR);
 			goto status_fail;
 		} else {
-			rtsx_trace(chip);
 			goto fail;
 		}
 	}
@@ -1942,7 +1860,6 @@ static int xd_write_multiple_pages(struct rtsx_chip *chip, u32 old_blk,
 fail:
 	retval = rtsx_read_register(chip, XD_DAT, &reg_val);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 	if (reg_val & PROGRAM_ERROR) {
@@ -1951,7 +1868,6 @@ static int xd_write_multiple_pages(struct rtsx_chip *chip, u32 old_blk,
 	}
 
 status_fail:
-	rtsx_trace(chip);
 	return STATUS_FAIL;
 }
 
@@ -1966,7 +1882,6 @@ int xd_delay_write(struct rtsx_chip *chip)
 		dev_dbg(rtsx_dev(chip), "%s\n", __func__);
 		retval = xd_switch_clock(chip);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
@@ -1977,7 +1892,6 @@ int xd_delay_write(struct rtsx_chip *chip)
 					 delay_write->logblock,
 					 delay_write->pageoff);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	}
@@ -2012,14 +1926,12 @@ int xd_rw(struct scsi_cmnd *srb, struct rtsx_chip *chip,
 
 	retval = xd_switch_clock(chip);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	if (detect_card_cd(chip, XD_CARD) != STATUS_SUCCESS) {
 		chip->card_fail |= XD_CARD;
 		set_sense_type(chip, lun, SENSE_TYPE_MEDIA_NOT_PRESENT);
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
@@ -2033,7 +1945,6 @@ int xd_rw(struct scsi_cmnd *srb, struct rtsx_chip *chip,
 		if (retval != STATUS_SUCCESS) {
 			chip->card_fail |= XD_CARD;
 			set_sense_type(chip, lun, SENSE_TYPE_MEDIA_NOT_PRESENT);
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	}
@@ -2053,7 +1964,6 @@ int xd_rw(struct scsi_cmnd *srb, struct rtsx_chip *chip,
 				if (retval != STATUS_SUCCESS) {
 					set_sense_type(chip, lun,
 						       SENSE_TYPE_MEDIA_WRITE_ERR);
-					rtsx_trace(chip);
 					return STATUS_FAIL;
 				}
 			}
@@ -2070,7 +1980,6 @@ int xd_rw(struct scsi_cmnd *srb, struct rtsx_chip *chip,
 			if (retval != STATUS_SUCCESS) {
 				set_sense_type(chip, lun,
 					       SENSE_TYPE_MEDIA_WRITE_ERR);
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 #endif
@@ -2080,7 +1989,6 @@ int xd_rw(struct scsi_cmnd *srb, struct rtsx_chip *chip,
 			    (new_blk == BLK_NOT_FOUND)) {
 				set_sense_type(chip, lun,
 					       SENSE_TYPE_MEDIA_WRITE_ERR);
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 
@@ -2091,12 +1999,10 @@ int xd_rw(struct scsi_cmnd *srb, struct rtsx_chip *chip,
 					STATUS_SUCCESS) {
 					set_sense_type(chip, lun,
 						       SENSE_TYPE_MEDIA_NOT_PRESENT);
-					rtsx_trace(chip);
 					return STATUS_FAIL;
 				}
 				set_sense_type(chip, lun,
 					       SENSE_TYPE_MEDIA_WRITE_ERR);
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 #ifdef XD_DELAY_WRITE
@@ -2109,12 +2015,10 @@ int xd_rw(struct scsi_cmnd *srb, struct rtsx_chip *chip,
 			if (detect_card_cd(chip, XD_CARD) != STATUS_SUCCESS) {
 				set_sense_type(chip, lun,
 					       SENSE_TYPE_MEDIA_NOT_PRESENT);
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 			set_sense_type(chip, lun,
 				       SENSE_TYPE_MEDIA_UNRECOVER_READ_ERR);
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 #endif
@@ -2123,7 +2027,6 @@ int xd_rw(struct scsi_cmnd *srb, struct rtsx_chip *chip,
 		if (old_blk == BLK_NOT_FOUND) {
 			set_sense_type(chip, lun,
 				       SENSE_TYPE_MEDIA_UNRECOVER_READ_ERR);
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	}
@@ -2134,7 +2037,6 @@ int xd_rw(struct scsi_cmnd *srb, struct rtsx_chip *chip,
 		if (detect_card_cd(chip, XD_CARD) != STATUS_SUCCESS) {
 			chip->card_fail |= XD_CARD;
 			set_sense_type(chip, lun, SENSE_TYPE_MEDIA_NOT_PRESENT);
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
@@ -2151,7 +2053,6 @@ int xd_rw(struct scsi_cmnd *srb, struct rtsx_chip *chip,
 			if (retval != STATUS_SUCCESS) {
 				set_sense_type(chip, lun,
 					       SENSE_TYPE_MEDIA_UNRECOVER_READ_ERR);
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 		} else {
@@ -2162,7 +2063,6 @@ int xd_rw(struct scsi_cmnd *srb, struct rtsx_chip *chip,
 			if (retval != STATUS_SUCCESS) {
 				set_sense_type(chip, lun,
 					       SENSE_TYPE_MEDIA_WRITE_ERR);
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 		}
@@ -2184,7 +2084,6 @@ int xd_rw(struct scsi_cmnd *srb, struct rtsx_chip *chip,
 				chip->card_fail |= XD_CARD;
 				set_sense_type(chip, lun,
 					       SENSE_TYPE_MEDIA_NOT_PRESENT);
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 		}
@@ -2198,7 +2097,6 @@ int xd_rw(struct scsi_cmnd *srb, struct rtsx_chip *chip,
 				set_sense_type(chip, lun,
 					       SENSE_TYPE_MEDIA_WRITE_ERR);
 
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
@@ -2207,7 +2105,6 @@ int xd_rw(struct scsi_cmnd *srb, struct rtsx_chip *chip,
 			if (new_blk == BLK_NOT_FOUND) {
 				set_sense_type(chip, lun,
 					       SENSE_TYPE_MEDIA_WRITE_ERR);
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 		}
@@ -2227,7 +2124,6 @@ int xd_rw(struct scsi_cmnd *srb, struct rtsx_chip *chip,
 		if (detect_card_cd(chip, XD_CARD) != STATUS_SUCCESS) {
 			chip->card_fail |= XD_CARD;
 			set_sense_type(chip, lun, SENSE_TYPE_MEDIA_NOT_PRESENT);
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
@@ -2237,11 +2133,9 @@ int xd_rw(struct scsi_cmnd *srb, struct rtsx_chip *chip,
 			if (detect_card_cd(chip, XD_CARD) != STATUS_SUCCESS) {
 				set_sense_type(chip, lun,
 					       SENSE_TYPE_MEDIA_NOT_PRESENT);
-				rtsx_trace(chip);
 				return STATUS_FAIL;
 			}
 			set_sense_type(chip, lun, SENSE_TYPE_MEDIA_WRITE_ERR);
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 #endif
@@ -2288,20 +2182,17 @@ int xd_power_off_card3v3(struct rtsx_chip *chip)
 
 	retval = disable_card_clock(chip, XD_CARD);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
 	retval = rtsx_write_register(chip, CARD_OE, XD_OUTPUT_EN, 0);
 	if (retval) {
-		rtsx_trace(chip);
 		return retval;
 	}
 
 	if (!chip->ft2_fast_mode) {
 		retval = card_power_off(chip, XD_CARD);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 
@@ -2311,13 +2202,11 @@ int xd_power_off_card3v3(struct rtsx_chip *chip)
 	if (chip->asic_code) {
 		retval = xd_pull_ctl_disable(chip);
 		if (retval != STATUS_SUCCESS) {
-			rtsx_trace(chip);
 			return STATUS_FAIL;
 		}
 	} else {
 		retval = rtsx_write_register(chip, FPGA_PULL_CTL, 0xFF, 0xDF);
 		if (retval) {
-			rtsx_trace(chip);
 			return retval;
 		}
 	}
@@ -2340,7 +2229,6 @@ int release_xd_card(struct rtsx_chip *chip)
 
 	retval = xd_power_off_card3v3(chip);
 	if (retval != STATUS_SUCCESS) {
-		rtsx_trace(chip);
 		return STATUS_FAIL;
 	}
 
-- 
2.9.0

