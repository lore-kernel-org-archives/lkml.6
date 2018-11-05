Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FA2C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 08:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89B5020862
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 08:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sZL/5KSr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89B5020862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbeKESIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 13:08:51 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40528 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbeKESIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 13:08:50 -0500
Received: by mail-pf1-f196.google.com with SMTP id x2-v6so7878pfm.7;
        Mon, 05 Nov 2018 00:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RwBEMOKOuHN5wEinLokxK+u2mLgDIRVcnZMuwO4S6is=;
        b=sZL/5KSrAee3zSajmSMMcHphz3bGhsiCGSvSO/gXZHI2Lv395oTezIop4WY+SXK6W0
         iFvTrbMBvx/E0azGI+jTc8SITu8zNo8X8srvfnXZCkj1iYWYzlRuURlV4O3hYqVza9yb
         UctfTGDMHp7n3tL2kf220sgPuiCqQeMhEQMag4Ksz8xmnUAPnTWSZ2IQAXbmpdsmJbQg
         2cDSms95CFuK1L8p5SAV7yLScFHhI5LGVmNUjm4N80KitV2XTD+yiQCD4oDSNSj+h2Cb
         0IEJx7eEeu7s7JxYHOUlMC0V6K17lsMZAMSgnrPDD4aYBOwVa2jmCeLZKyFQGdI97w8R
         UCMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RwBEMOKOuHN5wEinLokxK+u2mLgDIRVcnZMuwO4S6is=;
        b=mHQ41EPIs+cXFWDLNSChp5fuq4QJfACQU0iuC/oxFtChGprMIgQyiur5XtN42R7CxJ
         dolApmfBW7oHtqXS1tZsrzrzHptWhZThRzOcV5bZXLD6VpTjgV/5zEK0OkI0owJJHi4s
         8k+1dlIqZc/lXoNewJG52i1wVLV71wGNb4ICODKGTo68tTQWm8uH0u6h59w3Cu0uYAz+
         41umAKUES5MZKXknSSOzCypC8XDMWr3lt0drDiMVsR4ztHa4js6DQEpkeq8Dvz5oF78o
         EpeF6TVtSbxIvWRfmvC/LmEOWZlBN2mk9w7fzZW7V34kLjkKxeHXAhq5nZHxdI9S/bA6
         dP9g==
X-Gm-Message-State: AGRZ1gLSJL2+c+tmcr8CNG3dUWV/T2Gu3dnyHp5Fl5dcgwAdrTPTA3AJ
        oci0NeCZPDWPvrReWGUh17o=
X-Google-Smtp-Source: AJdET5cNWhqLLO1OsUxRDcNs+Awj6gpzEb/izbRb8SIGyuWGbQ5am5KMczy9ydjaIPlDlxFe8vpoNA==
X-Received: by 2002:a62:a218:: with SMTP id m24-v6mr20691523pff.99.1541407813403;
        Mon, 05 Nov 2018 00:50:13 -0800 (PST)
Received: from localhost.localdomain ([2605:e000:180c:c593:a139:e092:8805:6ff6])
        by smtp.gmail.com with ESMTPSA id w66-v6sm48662672pfb.51.2018.11.05.00.50.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 00:50:12 -0800 (PST)
From:   Ivan Roman <mr.ivanroman@gmail.com>
To:     johan@kernel.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ivan Roman <mr.ivanroman@gmail.com>
Subject: [PATCH] USB: serial: io_ti: Replaced simple_strtoul with kstrtoul + Formatting issues
Date:   Mon,  5 Nov 2018 00:50:09 -0800
Message-Id: <20181105085009.25512-1-mr.ivanroman@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replaced simple_strtoul with kstrtoul since simple_strtoul is obsolete. 
Also fixed several formatting issues.

Signed-off-by: Ivan Roman <mr.ivanroman@gmail.com>
---
 drivers/usb/serial/io_ti.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/drivers/usb/serial/io_ti.c b/drivers/usb/serial/io_ti.c
index c327d4cf7928..5c61fb479354 100644
--- a/drivers/usb/serial/io_ti.c
+++ b/drivers/usb/serial/io_ti.c
@@ -341,9 +341,8 @@ static int read_download_mem(struct usb_device *dev, int start_address,
 		else
 			read_length = (__u8)length;
 
-		if (read_length > 1) {
+		if (read_length > 1)
 			dev_dbg(&dev->dev, "%s - @ %x for %d\n", __func__, start_address, read_length);
-		}
 		/*
 		 * NOTE: Must use swab as wIndex is sent in little-endian
 		 *       byte order regardless of host byte order.
@@ -820,7 +819,7 @@ static int build_i2c_fw_hdr(u8 *header, const struct firmware *fw)
 	 * Allocate a 15.5k buffer + 2 bytes for version number (Firmware
 	 * Record)
 	 */
-	buffer_size = (((1024 * 16) - 512 ) +
+	buffer_size = (((1024 * 16) - 512) +
 			sizeof(struct ti_i2c_firmware_rec));
 
 	buffer = kmalloc(buffer_size, GFP_KERNEL);
@@ -843,7 +842,7 @@ static int build_i2c_fw_hdr(u8 *header, const struct firmware *fw)
 		&fw->data[4 + sizeof(struct ti_i2c_image_header)],
 		le16_to_cpu(img_header->Length));
 
-	for (i=0; i < buffer_size; i++) {
+	for (i = 0; i < buffer_size; i++) {
 		cs = (__u8)(cs + buffer[i]);
 	}
 
@@ -851,7 +850,7 @@ static int build_i2c_fw_hdr(u8 *header, const struct firmware *fw)
 
 	/* Build new header */
 	i2c_header =  (struct ti_i2c_desc *)header;
-	firmware_rec =  (struct ti_i2c_firmware_rec*)i2c_header->Data;
+	firmware_rec =  (struct ti_i2c_firmware_rec *)i2c_header->Data;
 
 	i2c_header->Type	= I2C_DESC_TYPE_FIRMWARE_BLANK;
 	i2c_header->Size	= cpu_to_le16(buffer_size);
@@ -2147,9 +2146,8 @@ static void edge_throttle(struct tty_struct *tty)
 	if (I_IXOFF(tty)) {
 		unsigned char stop_char = STOP_CHAR(tty);
 		status = edge_write(tty, port, &stop_char, 1);
-		if (status <= 0) {
+		if (status <= 0)
 			dev_err(&port->dev, "%s - failed to write stop character, %d\n", __func__, status);
-		}
 	}
 
 	/*
@@ -2174,9 +2172,8 @@ static void edge_unthrottle(struct tty_struct *tty)
 	if (I_IXOFF(tty)) {
 		unsigned char start_char = START_CHAR(tty);
 		status = edge_write(tty, port, &start_char, 1);
-		if (status <= 0) {
+		if (status <= 0)
 			dev_err(&port->dev, "%s - failed to write start character, %d\n", __func__, status);
-		}
 	}
 	/*
 	 * if we are implementing RTS/CTS, restart reads
@@ -2231,11 +2228,11 @@ static void change_port_settings(struct tty_struct *tty,
 	struct device *dev = &edge_port->port->dev;
 	struct ump_uart_config *config;
 	int baud;
-	unsigned cflag;
+	unsigned int cflag;
 	int status;
 	int port_number = edge_port->port->port_number;
 
-	config = kmalloc (sizeof (*config), GFP_KERNEL);
+	config = kmalloc(sizeof (*config), GFP_KERNEL);
 	if (!config) {
 		tty->termios = *old_termios;
 		return;
@@ -2423,12 +2420,12 @@ static int edge_tiocmget(struct tty_struct *tty)
 
 	msr = edge_port->shadow_msr;
 	mcr = edge_port->shadow_mcr;
-	result = ((mcr & MCR_DTR)	? TIOCM_DTR: 0)	  /* 0x002 */
-		  | ((mcr & MCR_RTS)	? TIOCM_RTS: 0)   /* 0x004 */
-		  | ((msr & EDGEPORT_MSR_CTS)	? TIOCM_CTS: 0)   /* 0x020 */
-		  | ((msr & EDGEPORT_MSR_CD)	? TIOCM_CAR: 0)   /* 0x040 */
-		  | ((msr & EDGEPORT_MSR_RI)	? TIOCM_RI:  0)   /* 0x080 */
-		  | ((msr & EDGEPORT_MSR_DSR)	? TIOCM_DSR: 0);  /* 0x100 */
+	result = ((mcr & MCR_DTR)	? TIOCM_DTR : 0)	  /* 0x002 */
+		  | ((mcr & MCR_RTS)	? TIOCM_RTS : 0)   /* 0x004 */
+		  | ((msr & EDGEPORT_MSR_CTS)	? TIOCM_CTS : 0)   /* 0x020 */
+		  | ((msr & EDGEPORT_MSR_CD)	? TIOCM_CAR : 0)   /* 0x040 */
+		  | ((msr & EDGEPORT_MSR_RI)	? TIOCM_RI :  0)   /* 0x080 */
+		  | ((msr & EDGEPORT_MSR_DSR)	? TIOCM_DSR : 0);  /* 0x100 */
 
 
 	dev_dbg(&port->dev, "%s -- %x\n", __func__, result);
@@ -2442,7 +2439,7 @@ static int get_serial_info(struct tty_struct *tty,
 {
 	struct usb_serial_port *port = tty->driver_data;
 	struct edgeport_port *edge_port = usb_get_serial_port_data(port);
-	unsigned cwait;
+	unsigned int cwait;
 
 	cwait = edge_port->port->port.closing_wait;
 	if (cwait != ASYNC_CLOSING_WAIT_NONE)
@@ -2656,7 +2653,7 @@ static ssize_t uart_mode_store(struct device *dev,
 {
 	struct usb_serial_port *port = to_usb_serial_port(dev);
 	struct edgeport_port *edge_port = usb_get_serial_port_data(port);
-	unsigned int v = simple_strtoul(valbuf, NULL, 0);
+	unsigned int v = kstrtoul(valbuf, NULL, 0);
 
 	dev_dbg(dev, "%s: setting uart_mode = %d\n", __func__, v);
 
-- 
2.17.1

