Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FB9C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 15:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CA5D2087A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 15:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4NCTTTv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CA5D2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbeI2WZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 18:25:10 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33089 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728343AbeI2WZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 18:25:09 -0400
Received: by mail-qt1-f195.google.com with SMTP id i10-v6so9906011qtp.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Sep 2018 08:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HKDQowCyraqlONQbxRfdxkoo+v+zZ1LDibaT1Y1q1xo=;
        b=X4NCTTTvyKEprPFgygTrPGsO+0x2hfhdkP0scgBS7hcZntsW//Ky35bo7nG0BV4SzA
         +J8OlmcaRE4OziBdFr4INyBzQ2l7dAnaaKN+hLB9mbmS7by65IPWk+HrC40WFSXiMvik
         +U4Vl+mwjyjE6sNQODchG4uB2Yg6cIA3ekM26QdMKi1MU4YwJ+KgTTE03zaGugnNO3NP
         ZoUWs5KuStS8/1+LI81urBDB/IBMUsuz0dkY9sWn9SEhqE0O+PYc8GKmKqeaczKJ628q
         Q41CGd5C/umdkAeUJUWbz9zr4tqvOka3qN8BX9bp58qe1nz3XVxv20nryz0XQLV3NkPZ
         gjvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HKDQowCyraqlONQbxRfdxkoo+v+zZ1LDibaT1Y1q1xo=;
        b=eNRXG4MMez66dDi7ZxDcWrQJxo1luex3W1B8+geU9RwSkZkioCtbbY8i5a7M9Z+F7Z
         CdYIABdDeoAi8EMoEnvop9uC6iJFufAKq6aN9Et0gRhX3ry/8NNYBi/IaCGDCz1D3CUA
         x8iXVUIz6enb/gc6rEfdHjlNa/vmu0rnoAq/Tp5hiY70E+ICgGqu4WWFYvIVINm4YB7J
         MAu6f/5vD3lcYMBRbitzRCtPOm40dNyC8avQrMrRcUW2WiumVgpJzSJuZV+K8d5gecEq
         N5nlKRg+fCVxcAhhZgHZvD9X/fNJBnPoT+5+qauSHj9aR5O4l3Adosu8jQQw2v0wb8Tv
         Yh/g==
X-Gm-Message-State: ABuFfojKcdr00kLK9o9AXYe5+qWDi/h6v7uB4u3f+YYcdK3TtetocMHy
        y/cb3F0HhjC7m2sd6rBckwI=
X-Google-Smtp-Source: ACcGV634bA8ikbBA0g2GShxUrbu0Zd2eOFCuD17EUQXLc1jkEUPFjf6RuWxkZVYA/0TXLWEcLqj7mg==
X-Received: by 2002:aed:2e24:: with SMTP id j33-v6mr2877341qtd.180.1538236573606;
        Sat, 29 Sep 2018 08:56:13 -0700 (PDT)
Received: from localhost.localdomain (modemcable211.182-179-173.mc.videotron.ca. [173.179.182.211])
        by smtp.gmail.com with ESMTPSA id l2-v6sm4362535qtp.41.2018.09.29.08.56.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Sep 2018 08:56:13 -0700 (PDT)
From:   Maxime Desroches <desroches.maxime@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Maxime Desroches <desroches.maxime@gmail.com>
Subject: [PATCH 3/4] Staging: rts5208: rtsx_scsi.c: Fixed all braces issues of the file
Date:   Sat, 29 Sep 2018 11:56:05 -0400
Message-Id: <20180929155605.18715-1-desroches.maxime@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed all the braces issues of the rtsx_scsi.c file

Signed-off-by: Maxime Desroches <desroches.maxime@gmail.com>
---
 drivers/staging/rts5208/rtsx_scsi.c | 108 ++++++++++------------------
 1 file changed, 36 insertions(+), 72 deletions(-)

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
-- 
2.17.1

