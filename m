Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B97C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 07:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF7D22145D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 07:05:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF7D22145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=asix.com.tw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389356AbeKPRQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 12:16:10 -0500
Received: from asix.com.tw ([210.243.224.51]:18195 "EHLO freebsd2.asix.com.tw"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727438AbeKPRQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 12:16:10 -0500
X-Greylist: delayed 1680 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Nov 2018 12:16:09 EST
Received: from JACKYCHOU ([10.1.2.56])
        by freebsd2.asix.com.tw (8.15.2/8.15.2) with ESMTPS id wAG6ZLDd068327
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 16 Nov 2018 14:35:21 +0800 (CST)
        (envelope-from jackychou@asix.com.tw)
Authentication-Results: freebsd2.asix.com.tw; sender-id=permerror header.from=jackychou@asix.com.tw; spf=permerror smtp.mfrom=jackychou@asix.com.tw
X-Authentication-Warning: freebsd2.asix.com.tw: Host [10.1.2.56] claimed to be JACKYCHOU
From:   "JackyChou" <jackychou@asix.com.tw>
To:     <johan@kernel.org>
Cc:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <louis@asix.com.tw>,
        <jackychou@asix.com.tw>
References: <20181116063016.10360-1-jackychou@asix.com.tw>
In-Reply-To: <20181116063016.10360-1-jackychou@asix.com.tw>
Subject: [PATCH] USB: serial: mos7840: Add a product ID for the new product
Date:   Fri, 16 Nov 2018 14:36:56 +0800
Message-ID: <002201d47d76$c5a45080$50ecf180$@asix.com.tw>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQI1Bgq9TKrJ8B3Xn2OH4bCWb0FHsqSQ38Rw
Content-Language: zh-tw
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: JackyChou <jackychou@asix.com.tw>

Add a new PID 0x7843 to the driver.
Let the new products be able to set up 3 serial ports with the driver.

Because the development of new product is based on 4 serial ports, 
but some users only need 3 serial ports. There is no way to set it from 
the hardware, so let the driver set 3 serial ports with PID 0x7843.

Signed-off-by: JackyChou <jackychou@asix.com.tw>
---
 drivers/usb/serial/mos7840.c | 45 ++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/drivers/usb/serial/mos7840.c b/drivers/usb/serial/mos7840.c
index b42bad85097a..57ef25a2f7bb 100644
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
@@ -298,15 +300,10 @@ static int mos7840_set_uart_reg(struct usb_serial_port
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
@@ -332,15 +329,10 @@ static int mos7840_get_uart_reg(struct usb_serial_port
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
@@ -2071,12 +2063,16 @@ static int mos7840_probe(struct usb_serial *serial,
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
+	} else if (mos7810_check(serial)) {
 		device_type = MOSCHIP_DEVICE_ID_7810;
-	else
+	} else {
 		device_type = MOSCHIP_DEVICE_ID_7820;
+	}
 
 	kfree(buf);
 out:
@@ -2091,7 +2087,10 @@ static int mos7840_calc_num_ports(struct usb_serial
*serial,
 	int device_type = (unsigned long)usb_get_serial_data(serial);
 	int num_ports;
 
-	num_ports = (device_type >> 4) & 0x000F;
+	if (device_type == MOSCHIP_DEVICE_ID_7843)
+		num_ports = 3;
+	else
+		num_ports = (device_type >> 4) & 0x000F;
 
 	/*
 	 * num_ports is currently never zero as device_type is one of 
@@ -2146,7 +2145,7 @@ static int mos7840_port_probe(struct usb_serial_port
*port)
 		mos7840_port->SpRegOffset = 0x0;
 		mos7840_port->ControlRegOffset = 0x1;
 		mos7840_port->DcrRegOffset = 0x4;
-	} else if ((mos7840_port->port_num == 2) && (serial->num_ports ==
4)) {
+	} else if ((mos7840_port->port_num == 2) && (serial->num_ports > 2))
{
 		mos7840_port->SpRegOffset = 0x8;
 		mos7840_port->ControlRegOffset = 0x9;
 		mos7840_port->DcrRegOffset = 0x16;
@@ -2154,7 +2153,7 @@ static int mos7840_port_probe(struct usb_serial_port
*port)
 		mos7840_port->SpRegOffset = 0xa;
 		mos7840_port->ControlRegOffset = 0xb;
 		mos7840_port->DcrRegOffset = 0x19;
-	} else if ((mos7840_port->port_num == 3) && (serial->num_ports ==
4)) {
+	} else if ((mos7840_port->port_num == 3) && (serial->num_ports > 2))
{
 		mos7840_port->SpRegOffset = 0xa;
 		mos7840_port->ControlRegOffset = 0xb;
 		mos7840_port->DcrRegOffset = 0x19;
--
2.17.1

