Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF271ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 10:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73AAB208B4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 10:08:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73AAB208B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729323AbeGMKWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 06:22:32 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59854 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbeGMKWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 06:22:32 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fdv03-0008KG-Ru; Fri, 13 Jul 2018 10:08:31 +0000
From:   Colin King <colin.king@canonical.com>
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: serial: mos7720: remove redundant variables iflag, mask and serial
Date:   Fri, 13 Jul 2018 11:08:31 +0100
Message-Id: <20180713100831.29120-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variables iflag, mask and serial are being assigned but ar never used
hence are redundant and can be removed.

Cleans up clang warnings:
warning: variable 'iflag' set but not used [-Wunused-but-set-variable]
warning: variable 'mask' set but not used [-Wunused-but-set-variable]
warning: variable 'serial' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/usb/serial/mos7720.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/usb/serial/mos7720.c b/drivers/usb/serial/mos7720.c
index 8f11e759ad61..27109522fd8b 100644
--- a/drivers/usb/serial/mos7720.c
+++ b/drivers/usb/serial/mos7720.c
@@ -1527,8 +1527,6 @@ static void change_port_settings(struct tty_struct *tty,
 	struct usb_serial *serial;
 	int baud;
 	unsigned cflag;
-	unsigned iflag;
-	__u8 mask = 0xff;
 	__u8 lData;
 	__u8 lParity;
 	__u8 lStop;
@@ -1552,23 +1550,19 @@ static void change_port_settings(struct tty_struct *tty,
 	lParity = 0x00;	/* No parity */
 
 	cflag = tty->termios.c_cflag;
-	iflag = tty->termios.c_iflag;
 
 	/* Change the number of bits */
 	switch (cflag & CSIZE) {
 	case CS5:
 		lData = UART_LCR_WLEN5;
-		mask = 0x1f;
 		break;
 
 	case CS6:
 		lData = UART_LCR_WLEN6;
-		mask = 0x3f;
 		break;
 
 	case CS7:
 		lData = UART_LCR_WLEN7;
-		mask = 0x7f;
 		break;
 	default:
 	case CS8:
@@ -1686,11 +1680,8 @@ static void mos7720_set_termios(struct tty_struct *tty,
 		struct usb_serial_port *port, struct ktermios *old_termios)
 {
 	int status;
-	struct usb_serial *serial;
 	struct moschip_port *mos7720_port;
 
-	serial = port->serial;
-
 	mos7720_port = usb_get_serial_port_data(port);
 
 	if (mos7720_port == NULL)
-- 
2.17.1

