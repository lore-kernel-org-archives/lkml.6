Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531D8C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 07:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25D0822353
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 07:34:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25D0822353
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=asix.com.tw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbeKLR0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 12:26:52 -0500
Received: from asix.com.tw ([113.196.140.82]:28897 "EHLO freebsd2.asix.com.tw"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727721AbeKLR0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 12:26:52 -0500
X-Greylist: delayed 1107 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Nov 2018 12:26:51 EST
Received: from localhost.localdomain ([10.1.2.57])
        (authenticated bits=0)
        by freebsd2.asix.com.tw (8.15.2/8.15.2) with ESMTPA id wAC7EoFb026779;
        Mon, 12 Nov 2018 15:14:55 +0800 (CST)
        (envelope-from jackychou@asix.com.tw)
Authentication-Results: freebsd2.asix.com.tw; sender-id=permerror header.from=jackychou@asix.com.tw; auth=pass (LOGIN); spf=permerror smtp.mfrom=jackychou@asix.com.tw
X-Authentication-Warning: freebsd2.asix.com.tw: Host [10.1.2.57] claimed to be localhost.localdomain
From:   Jackychou <jackychou@asix.com.tw>
To:     johan@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, louis@asix.com.tw,
        jackychou@asix.com.tw
Subject: [PATCH] USB: serial: mos7840: Add a product ID for the new product
Date:   Mon, 12 Nov 2018 15:16:05 +0800
Message-Id: <20181112071605.7014-1-jackychou@asix.com.tw>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: JackyChou <jackychou@asix.com.tw>

Add a new PID 0x7843 to the driver.
Let the new products be able to set up 3 serial ports with the driver.

Signed-off-by: JackyChou <jackychou@asix.com.tw>
---
 drivers/usb/serial/mos7840.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/serial/mos7840.c b/drivers/usb/serial/mos7840.c
index b42bad85097a..7667b22fa2f7 100644
--- a/drivers/usb/serial/mos7840.c
+++ b/drivers/usb/serial/mos7840.c
@@ -94,6 +94,7 @@
 /* The native mos7840/7820 component */
 #define USB_VENDOR_ID_MOSCHIP           0x9710
 #define MOSCHIP_DEVICE_ID_7840          0x7840
+#define MOSCHIP_DEVICE_ID_7843          0x7843
 #define MOSCHIP_DEVICE_ID_7820          0x7820
 #define MOSCHIP_DEVICE_ID_7810          0x7810
 /* The native component can have its vendor/device id's overridden
@@ -176,6 +177,7 @@ enum mos7840_flag {
 
 static const struct usb_device_id id_table[] = {
 	{USB_DEVICE(USB_VENDOR_ID_MOSCHIP, MOSCHIP_DEVICE_ID_7840)},
+	{USB_DEVICE(USB_VENDOR_ID_MOSCHIP, MOSCHIP_DEVICE_ID_7843)},
 	{USB_DEVICE(USB_VENDOR_ID_MOSCHIP, MOSCHIP_DEVICE_ID_7820)},
 	{USB_DEVICE(USB_VENDOR_ID_MOSCHIP, MOSCHIP_DEVICE_ID_7810)},
 	{USB_DEVICE(USB_VENDOR_ID_BANDB, BANDB_DEVICE_ID_USO9ML2_2)},
@@ -298,7 +300,7 @@ static int mos7840_set_uart_reg(struct usb_serial_port *port, __u16 reg,
 	val = val & 0x00ff;
 	/* For the UART control registers, the application number need
 	   to be Or'ed */
-	if (port->serial->num_ports == 4) {
+	if (port->serial->num_ports == 4 || port->serial->num_ports == 3) {
 		val |= ((__u16)port->port_number + 1) << 8;
 	} else {
 		if (port->port_number == 0) {
@@ -332,7 +334,7 @@ static int mos7840_get_uart_reg(struct usb_serial_port *port, __u16 reg,
 		return -ENOMEM;
 
 	/* Wval  is same as application number */
-	if (port->serial->num_ports == 4) {
+	if (port->serial->num_ports == 4 || port->serial->num_ports == 3) {
 		Wval = ((__u16)port->port_number + 1) << 8;
 	} else {
 		if (port->port_number == 0) {
@@ -2071,9 +2073,12 @@ static int mos7840_probe(struct usb_serial *serial,
 			VENDOR_READ_LENGTH, MOS_WDR_TIMEOUT);
 
 	/* For a MCS7840 device GPIO0 must be set to 1 */
-	if (buf[0] & 0x01)
-		device_type = MOSCHIP_DEVICE_ID_7840;
-	else if (mos7810_check(serial))
+	if (buf[0] & 0x01) {
+		if (product == MOSCHIP_DEVICE_ID_7843)
+			device_type = MOSCHIP_DEVICE_ID_7843;
+		else
+			device_type = MOSCHIP_DEVICE_ID_7840;
+	} else if (mos7810_check(serial))
 		device_type = MOSCHIP_DEVICE_ID_7810;
 	else
 		device_type = MOSCHIP_DEVICE_ID_7820;
@@ -2091,7 +2096,10 @@ static int mos7840_calc_num_ports(struct usb_serial *serial,
 	int device_type = (unsigned long)usb_get_serial_data(serial);
 	int num_ports;
 
-	num_ports = (device_type >> 4) & 0x000F;
+	if (device_type == MOSCHIP_DEVICE_ID_7843)
+		num_ports = 3;
+	else
+		num_ports = (device_type >> 4) & 0x000F;
 
 	/*
 	 * num_ports is currently never zero as device_type is one of
@@ -2146,7 +2154,8 @@ static int mos7840_port_probe(struct usb_serial_port *port)
 		mos7840_port->SpRegOffset = 0x0;
 		mos7840_port->ControlRegOffset = 0x1;
 		mos7840_port->DcrRegOffset = 0x4;
-	} else if ((mos7840_port->port_num == 2) && (serial->num_ports == 4)) {
+	} else if ((mos7840_port->port_num == 2) &&
+		   ((serial->num_ports == 4) || (serial->num_ports == 3))) {
 		mos7840_port->SpRegOffset = 0x8;
 		mos7840_port->ControlRegOffset = 0x9;
 		mos7840_port->DcrRegOffset = 0x16;
@@ -2154,7 +2163,8 @@ static int mos7840_port_probe(struct usb_serial_port *port)
 		mos7840_port->SpRegOffset = 0xa;
 		mos7840_port->ControlRegOffset = 0xb;
 		mos7840_port->DcrRegOffset = 0x19;
-	} else if ((mos7840_port->port_num == 3) && (serial->num_ports == 4)) {
+	} else if ((mos7840_port->port_num == 3) &&
+		   ((serial->num_ports == 4) || (serial->num_ports == 3))) {
 		mos7840_port->SpRegOffset = 0xa;
 		mos7840_port->ControlRegOffset = 0xb;
 		mos7840_port->DcrRegOffset = 0x19;
-- 
2.17.1

