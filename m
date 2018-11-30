Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098C8C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C71AD2081C
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:31:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C71AD2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=asix.com.tw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbeK3Rjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 12:39:46 -0500
Received: from asix.com.tw ([113.196.140.82]:21521 "EHLO freebsd2.asix.com.tw"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726386AbeK3Rjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 12:39:46 -0500
Received: from localhost.localdomain ([10.1.2.57])
        (authenticated bits=0)
        by freebsd2.asix.com.tw (8.15.2/8.15.2) with ESMTPA id wAU6T5DT092431;
        Fri, 30 Nov 2018 14:29:09 +0800 (CST)
        (envelope-from jackychou@asix.com.tw)
Authentication-Results: freebsd2.asix.com.tw; sender-id=permerror header.from=jackychou@asix.com.tw; auth=pass (LOGIN); spf=permerror smtp.mfrom=jackychou@asix.com.tw
X-Authentication-Warning: freebsd2.asix.com.tw: Host [10.1.2.57] claimed to be localhost.localdomain
From:   Jackychou <jackychou@asix.com.tw>
To:     johan@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, louis@asix.com.tw,
        jackychou@asix.com.tw
Subject: [PATCH 2/2 v4] USB: serial: mos7840: Add a product ID for the new product
Date:   Fri, 30 Nov 2018 14:31:22 +0800
Message-Id: <20181130063122.24217-2-jackychou@asix.com.tw>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181130063122.24217-1-jackychou@asix.com.tw>
References: <20181130063122.24217-1-jackychou@asix.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: JackyChou <jackychou@asix.com.tw>

Add a new PID 0x7843 to the driver.
Let the new products be able to set up 3 serial ports with the driver.

Signed-off-by: JackyChou <jackychou@asix.com.tw>
---
 drivers/usb/serial/mos7840.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/serial/mos7840.c b/drivers/usb/serial/mos7840.c
index 92ab68ef08ab..b6e7b55fcb7c 100644
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
@@ -2033,7 +2035,8 @@ static int mos7840_probe(struct usb_serial *serial,
 	int device_type;
 
 	if (product == MOSCHIP_DEVICE_ID_7810 ||
-		product == MOSCHIP_DEVICE_ID_7820) {
+		product == MOSCHIP_DEVICE_ID_7820 ||
+		product == MOSCHIP_DEVICE_ID_7843) {
 		device_type = product;
 		goto out;
 	}
@@ -2067,7 +2070,10 @@ static int mos7840_calc_num_ports(struct usb_serial *serial,
 	int device_type = (unsigned long)usb_get_serial_data(serial);
 	int num_ports;
 
-	num_ports = (device_type >> 4) & 0x000F;
+	if (device_type == MOSCHIP_DEVICE_ID_7843)
+		num_ports = 3;
+	else
+		num_ports = (device_type >> 4) & 0x000F;
 
 	/*
 	 * num_ports is currently never zero as device_type is one of
-- 
2.17.1

