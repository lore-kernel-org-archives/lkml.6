Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id kKx5Lw5WGVvgOwAAmS7hNA
	; Thu, 07 Jun 2018 15:58:53 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 116EB6089E; Thu,  7 Jun 2018 15:58:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4B8B360590;
	Thu,  7 Jun 2018 15:58:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4B8B360590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934539AbeFGP57 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:57:59 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39345 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933053AbeFGOJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:09:07 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb7-0005Zw-Jy; Thu, 07 Jun 2018 15:09:05 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb3-0002vL-Nc; Thu, 07 Jun 2018 15:09:01 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Max Schulze" <max.schulze@posteo.de>,
        "Johan Hovold" <johan@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.863680991@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 155/410] USB: serial: simple: add Motorola Tetra driver
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

commit 46fe895e22ab3845515ec06b01eaf1282b342e29 upstream.

Add new Motorola Tetra (simple) driver for Motorola Solutions TETRA PEI
devices.

D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=0cad ProdID=9011 Rev=24.16
S:  Manufacturer=Motorola Solutions Inc.
S:  Product=Motorola Solutions TETRA PEI interface
C:  #Ifs= 2 Cfg#= 1 Atr=80 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=(none)
I:  If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=(none)

Note that these devices do not support the CDC SET_CONTROL_LINE_STATE
request (for any interface).

Reported-by: Max Schulze <max.schulze@posteo.de>
Tested-by: Max Schulze <max.schulze@posteo.de>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/serial/Kconfig             | 1 +
 drivers/usb/serial/usb-serial-simple.c | 7 +++++++
 2 files changed, 8 insertions(+)

--- a/drivers/usb/serial/Kconfig
+++ b/drivers/usb/serial/Kconfig
@@ -63,6 +63,7 @@ config USB_SERIAL_SIMPLE
 		- Google USB serial devices
 		- HP4x calculators
 		- a number of Motorola phones
+		- Motorola Tetra devices
 		- Novatel Wireless GPS receivers
 		- Siemens USB/MPI adapter.
 		- ViVOtech ViVOpay USB device.
--- a/drivers/usb/serial/usb-serial-simple.c
+++ b/drivers/usb/serial/usb-serial-simple.c
@@ -80,6 +80,11 @@ DEVICE(vivopay, VIVOPAY_IDS);
 	{ USB_DEVICE(0x22b8, 0x2c64) }	/* Motorola V950 phone */
 DEVICE(moto_modem, MOTO_IDS);
 
+/* Motorola Tetra driver */
+#define MOTOROLA_TETRA_IDS()			\
+	{ USB_DEVICE(0x0cad, 0x9011) }	/* Motorola Solutions TETRA PEI */
+DEVICE(motorola_tetra, MOTOROLA_TETRA_IDS);
+
 /* Novatel Wireless GPS driver */
 #define NOVATEL_IDS()			\
 	{ USB_DEVICE(0x09d7, 0x0100) }	/* NovAtel FlexPack GPS */
@@ -110,6 +115,7 @@ static struct usb_serial_driver * const
 	&google_device,
 	&vivopay_device,
 	&moto_modem_device,
+	&motorola_tetra_device,
 	&novatel_gps_device,
 	&hp4x_device,
 	&suunto_device,
@@ -125,6 +131,7 @@ static const struct usb_device_id id_tab
 	GOOGLE_IDS(),
 	VIVOPAY_IDS(),
 	MOTO_IDS(),
+	MOTOROLA_TETRA_IDS(),
 	NOVATEL_IDS(),
 	HP4X_IDS(),
 	SUUNTO_IDS(),
