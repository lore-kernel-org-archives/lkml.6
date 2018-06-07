Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id IkpFGthVGVubOgAAmS7hNA
	; Thu, 07 Jun 2018 15:58:00 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 3FAC26074D; Thu,  7 Jun 2018 15:58:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B6FB7601D2;
	Thu,  7 Jun 2018 15:57:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B6FB7601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934503AbeFGP56 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:57:58 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39350 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933055AbeFGOJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:09:07 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb7-0005Zp-Jl; Thu, 07 Jun 2018 15:09:05 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb3-0002v7-Lr; Thu, 07 Jun 2018 15:09:01 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Johan Hovold" <johan@kernel.org>,
        "Kirk Madsen" <kirkm@Navsys.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.659234615@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 153/410] USB: serial: add Novatel Wireless GPS driver
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

commit c5cd24d7b179a415df263e5b18b72f6e3aaf81e0 upstream.

Add simple driver for Novatel Wireless GPS receivers.

Reported-by: Kirk Madsen <kirkm@Navsys.com>
Tested-by: Kirk Madsen <kirkm@Navsys.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/serial/Kconfig             | 1 +
 drivers/usb/serial/usb-serial-simple.c | 7 +++++++
 2 files changed, 8 insertions(+)

--- a/drivers/usb/serial/Kconfig
+++ b/drivers/usb/serial/Kconfig
@@ -62,6 +62,7 @@ config USB_SERIAL_SIMPLE
 		- Google USB serial devices
 		- HP4x calculators
 		- a number of Motorola phones
+		- Novatel Wireless GPS receivers
 		- Siemens USB/MPI adapter.
 		- ViVOtech ViVOpay USB device.
 		- Infineon Modem Flashloader USB interface
--- a/drivers/usb/serial/usb-serial-simple.c
+++ b/drivers/usb/serial/usb-serial-simple.c
@@ -75,6 +75,11 @@ DEVICE(vivopay, VIVOPAY_IDS);
 	{ USB_DEVICE(0x22b8, 0x2c64) }	/* Motorola V950 phone */
 DEVICE(moto_modem, MOTO_IDS);
 
+/* Novatel Wireless GPS driver */
+#define NOVATEL_IDS()			\
+	{ USB_DEVICE(0x09d7, 0x0100) }	/* NovAtel FlexPack GPS */
+DEVICE_N(novatel_gps, NOVATEL_IDS, 3);
+
 /* HP4x (48/49) Generic Serial driver */
 #define HP4X_IDS()			\
 	{ USB_DEVICE(0x03f0, 0x0121) }
@@ -99,6 +104,7 @@ static struct usb_serial_driver * const
 	&google_device,
 	&vivopay_device,
 	&moto_modem_device,
+	&novatel_gps_device,
 	&hp4x_device,
 	&suunto_device,
 	&siemens_mpi_device,
@@ -112,6 +118,7 @@ static const struct usb_device_id id_tab
 	GOOGLE_IDS(),
 	VIVOPAY_IDS(),
 	MOTO_IDS(),
+	NOVATEL_IDS(),
 	HP4X_IDS(),
 	SUUNTO_IDS(),
 	SIEMENS_IDS(),
