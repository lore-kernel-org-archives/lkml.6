Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453FCC64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12C9C2081C
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:31:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12C9C2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=asix.com.tw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbeK3Rjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 12:39:46 -0500
Received: from asix.com.tw ([113.196.140.82]:25286 "EHLO freebsd2.asix.com.tw"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726419AbeK3Rjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 12:39:46 -0500
Received: from localhost.localdomain ([10.1.2.57])
        (authenticated bits=0)
        by freebsd2.asix.com.tw (8.15.2/8.15.2) with ESMTPA id wAU6T5DS092431;
        Fri, 30 Nov 2018 14:29:09 +0800 (CST)
        (envelope-from jackychou@asix.com.tw)
Authentication-Results: freebsd2.asix.com.tw; sender-id=permerror header.from=jackychou@asix.com.tw; auth=pass (LOGIN); spf=permerror smtp.mfrom=jackychou@asix.com.tw
X-Authentication-Warning: freebsd2.asix.com.tw: Host [10.1.2.57] claimed to be localhost.localdomain
From:   Jackychou <jackychou@asix.com.tw>
To:     johan@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, louis@asix.com.tw,
        jackychou@asix.com.tw
Subject: [PATCH 1/2 v4] USB: serial: mos7840: Adjust port settings for read and write registers
Date:   Fri, 30 Nov 2018 14:31:21 +0800
Message-Id: <20181130063122.24217-1-jackychou@asix.com.tw>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: JackyChou <jackychou@asix.com.tw>

In the read/write function, set port 2 independently in the 2-port case.

When setting the offset of port registers, the offset between port 1 and
other ports is different, so port 1 is set independently.
Then in the rest of ports, the port 2 between 2-ports case and 4-ports case
is different, so port 2 in 2-ports case is set independently.

Signed-off-by: JackyChou <jackychou@asix.com.tw>
---
 drivers/usb/serial/mos7840.c | 48 ++++++++++++------------------------
 1 file changed, 16 insertions(+), 32 deletions(-)

diff --git a/drivers/usb/serial/mos7840.c b/drivers/usb/serial/mos7840.c
index 88828b4b8c44..92ab68ef08ab 100644
--- a/drivers/usb/serial/mos7840.c
+++ b/drivers/usb/serial/mos7840.c
@@ -298,15 +298,10 @@ static int mos7840_set_uart_reg(struct usb_serial_port *port, __u16 reg,
 	val = val & 0x00ff;
 	/* For the UART control registers, the application number need
 	   to be Or'ed */
-	if (port->serial->num_ports == 4) {
+	if (port->serial->num_ports == 2 && port->port_number != 0)
+		val |= ((__u16)port->port_number + 2) << 8;
+	else
 		val |= ((__u16)port->port_number + 1) << 8;
-	} else {
-		if (port->port_number == 0) {
-			val |= ((__u16)port->port_number + 1) << 8;
-		} else {
-			val |= ((__u16)port->port_number + 2) << 8;
-		}
-	}
 	dev_dbg(&port->dev, "%s application number is %x\n", __func__, val);
 	return usb_control_msg(dev, usb_sndctrlpipe(dev, 0), MCS_WRREQ,
 			       MCS_WR_RTYPE, val, reg, NULL, 0,
@@ -332,15 +327,10 @@ static int mos7840_get_uart_reg(struct usb_serial_port *port, __u16 reg,
 		return -ENOMEM;
 
 	/* Wval  is same as application number */
-	if (port->serial->num_ports == 4) {
+	if (port->serial->num_ports == 2 && port->port_number != 0)
+		Wval = ((__u16)port->port_number + 2) << 8;
+	else
 		Wval = ((__u16)port->port_number + 1) << 8;
-	} else {
-		if (port->port_number == 0) {
-			Wval = ((__u16)port->port_number + 1) << 8;
-		} else {
-			Wval = ((__u16)port->port_number + 2) << 8;
-		}
-	}
 	dev_dbg(&port->dev, "%s application number is %x\n", __func__, Wval);
 	ret = usb_control_msg(dev, usb_rcvctrlpipe(dev, 0), MCS_RDREQ,
 			      MCS_RD_RTYPE, Wval, reg, buf, VENDOR_READ_LENGTH,
@@ -2132,22 +2122,16 @@ static int mos7840_port_probe(struct usb_serial_port *port)
 		mos7840_port->SpRegOffset = 0x0;
 		mos7840_port->ControlRegOffset = 0x1;
 		mos7840_port->DcrRegOffset = 0x4;
-	} else if ((mos7840_port->port_num == 2) && (serial->num_ports == 4)) {
-		mos7840_port->SpRegOffset = 0x8;
-		mos7840_port->ControlRegOffset = 0x9;
-		mos7840_port->DcrRegOffset = 0x16;
-	} else if ((mos7840_port->port_num == 2) && (serial->num_ports == 2)) {
-		mos7840_port->SpRegOffset = 0xa;
-		mos7840_port->ControlRegOffset = 0xb;
-		mos7840_port->DcrRegOffset = 0x19;
-	} else if ((mos7840_port->port_num == 3) && (serial->num_ports == 4)) {
-		mos7840_port->SpRegOffset = 0xa;
-		mos7840_port->ControlRegOffset = 0xb;
-		mos7840_port->DcrRegOffset = 0x19;
-	} else if ((mos7840_port->port_num == 4) && (serial->num_ports == 4)) {
-		mos7840_port->SpRegOffset = 0xc;
-		mos7840_port->ControlRegOffset = 0xd;
-		mos7840_port->DcrRegOffset = 0x1c;
+	} else {
+		u8 port_offset;
+
+		if ((mos7840_port->port_num == 2) && (serial->num_ports == 2))
+			port_offset = 1;
+		else
+			port_offset = mos7840_port->port_num - 2;
+		mos7840_port->SpRegOffset = 0x8 + (2 * port_offset);
+		mos7840_port->ControlRegOffset = 0x9 + (2 * port_offset);
+		mos7840_port->DcrRegOffset = 0x16 + (3 * port_offset);
 	}
 	mos7840_dump_serial_port(port, mos7840_port);
 	mos7840_set_port_private(port, mos7840_port);
-- 
2.17.1

