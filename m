Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860A7C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 08:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 340D320831
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 08:00:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 340D320831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=asix.com.tw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392827AbeKVSip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 13:38:45 -0500
Received: from asix.com.tw ([113.196.140.82]:60695 "EHLO freebsd2.asix.com.tw"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726761AbeKVSip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 13:38:45 -0500
Received: from JACKYCHOU ([10.1.2.56])
        by freebsd2.asix.com.tw (8.15.2/8.15.2) with ESMTPS id wAM7wPDu098440
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 22 Nov 2018 15:58:26 +0800 (CST)
        (envelope-from jackychou@asix.com.tw)
Authentication-Results: freebsd2.asix.com.tw; sender-id=permerror header.from=jackychou@asix.com.tw; spf=permerror smtp.mfrom=jackychou@asix.com.tw
X-Authentication-Warning: freebsd2.asix.com.tw: Host [10.1.2.56] claimed to be JACKYCHOU
From:   "JackyChou" <jackychou@asix.com.tw>
To:     <johan@kernel.org>
Cc:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <louis@asix.com.tw>,
        <jackychou@asix.com.tw>
Subject: [PATCHv3] USB: serial: mos7840: Add a product ID for the new product
Date:   Thu, 22 Nov 2018 16:00:17 +0800
Message-ID: <000a01d48239$68dda550$3a98eff0$@asix.com.tw>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AdSCOSSSP3LcYWixTkSyw08G9k60hQ==
Content-Language: zh-tw
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: JackyChou <jackychou@asix.com.tw>

For now, pause to add PID 0x7843 in the driver.

Simplify the processes of some functions.
Such modifications will not affect the old devices and will make
the addition of new product (0x7843) more flexible in the future.

Signed-off-by: JackyChou <jackychou@asix.com.tw>
---
 drivers/usb/serial/mos7840.c | 48 ++++++++++++------------------------
 1 file changed, 16 insertions(+), 32 deletions(-)

diff --git a/drivers/usb/serial/mos7840.c b/drivers/usb/serial/mos7840.c
index b42bad85097a..0ca945dce377 100644
--- a/drivers/usb/serial/mos7840.c
+++ b/drivers/usb/serial/mos7840.c
@@ -298,15 +298,10 @@ static int mos7840_set_uart_reg(struct usb_serial_port
*port, __u16 reg,
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
@@ -332,15 +327,10 @@ static int mos7840_get_uart_reg(struct usb_serial_port
*port, __u16 reg,
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
 	dev_dbg(&port->dev, "%s application number is %x\n", __func__,
Wval);
 	ret = usb_control_msg(dev, usb_rcvctrlpipe(dev, 0), MCS_RDREQ,
 			      MCS_RD_RTYPE, Wval, reg, buf,
VENDOR_READ_LENGTH,
@@ -2146,22 +2136,16 @@ static int mos7840_port_probe(struct usb_serial_port
*port)
 		mos7840_port->SpRegOffset = 0x0;
 		mos7840_port->ControlRegOffset = 0x1;
 		mos7840_port->DcrRegOffset = 0x4;
-	} else if ((mos7840_port->port_num == 2) && (serial->num_ports ==
4)) {
-		mos7840_port->SpRegOffset = 0x8;
-		mos7840_port->ControlRegOffset = 0x9;
-		mos7840_port->DcrRegOffset = 0x16;
-	} else if ((mos7840_port->port_num == 2) && (serial->num_ports ==
2)) {
-		mos7840_port->SpRegOffset = 0xa;
-		mos7840_port->ControlRegOffset = 0xb;
-		mos7840_port->DcrRegOffset = 0x19;
-	} else if ((mos7840_port->port_num == 3) && (serial->num_ports ==
4)) {
-		mos7840_port->SpRegOffset = 0xa;
-		mos7840_port->ControlRegOffset = 0xb;
-		mos7840_port->DcrRegOffset = 0x19;
-	} else if ((mos7840_port->port_num == 4) && (serial->num_ports ==
4)) {
-		mos7840_port->SpRegOffset = 0xc;
-		mos7840_port->ControlRegOffset = 0xd;
-		mos7840_port->DcrRegOffset = 0x1c;
+	} else {
+		u8 port_offset;
+
+		if ((mos7840_port->port_num == 2) && (serial->num_ports ==
2))
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

