Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id nCE4BDpWGVsePQAAmS7hNA
	; Thu, 07 Jun 2018 16:00:17 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id DAC79601D2; Thu,  7 Jun 2018 16:00:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5A05560590;
	Thu,  7 Jun 2018 16:00:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5A05560590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933871AbeFGQAB (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:00:01 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39331 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933048AbeFGOJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:09:07 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb7-0005dI-KS; Thu, 07 Jun 2018 15:09:05 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb3-0002vF-Mn; Thu, 07 Jun 2018 15:09:01 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Benjamin West" <bewest@gmail.com>,
        "Johan Hovold" <johan@kernel.org>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.348965573@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 154/410] USB: serial: add Medtronic CareLink USB driver
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit cff9c2339a6d5105d7f6b1f9a96dd1d239cc76ac upstream.

Add simple driver for Medtronic CareLink USB devices.

Reported-by: Benjamin West <bewest@gmail.com>
Tested-by: Benjamin West <bewest@gmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/serial/Kconfig             | 1 +
 drivers/usb/serial/usb-serial-simple.c | 7 +++++++
 2 files changed, 8 insertions(+)

--- a/drivers/usb/serial/Kconfig
+++ b/drivers/usb/serial/Kconfig
@@ -58,6 +58,7 @@ config USB_SERIAL_SIMPLE
 	  handles a wide range of very simple devices, all in one
 	  driver.  Specifically, it supports:
 		- Suunto ANT+ USB device.
+		- Medtronic CareLink USB device
 		- Fundamental Software dongle.
 		- Google USB serial devices
 		- HP4x calculators
--- a/drivers/usb/serial/usb-serial-simple.c
+++ b/drivers/usb/serial/usb-serial-simple.c
@@ -36,6 +36,11 @@ static struct usb_serial_driver vendor##
 
 #define DEVICE(vendor, IDS)	DEVICE_N(vendor, IDS, 1)
 
+/* Medtronic CareLink USB driver */
+#define CARELINK_IDS()			\
+	{ USB_DEVICE(0x0a21, 0x8001) }	/* MMT-7305WW */
+DEVICE(carelink, CARELINK_IDS);
+
 /* ZIO Motherboard USB driver */
 #define ZIO_IDS()			\
 	{ USB_DEVICE(0x1CBE, 0x0103) }
@@ -98,6 +103,7 @@ DEVICE(siemens_mpi, SIEMENS_IDS);
 
 /* All of the above structures mushed into two lists */
 static struct usb_serial_driver * const serial_drivers[] = {
+	&carelink_device,
 	&zio_device,
 	&funsoft_device,
 	&flashloader_device,
@@ -112,6 +118,7 @@ static struct usb_serial_driver * const
 };
 
 static const struct usb_device_id id_table[] = {
+	CARELINK_IDS(),
 	ZIO_IDS(),
 	FUNSOFT_IDS(),
 	FLASHLOADER_IDS(),
