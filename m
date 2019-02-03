Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1D9C282DA
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 527C22084A
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730429AbfBCOVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:21:15 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55716 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730408AbfBCOVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:21:12 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIdy-0006P4-Pz; Sun, 03 Feb 2019 14:21:10 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9d-00076n-9d; Sun, 03 Feb 2019 14:49:49 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Jiri Kosina" <jkosina@suse.cz>,
        "Sebastian Parschauer" <sparschauer@suse.de>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.133140919@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 163/305] HID: Add quirk for Microsoft PIXART OEM mouse
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Sebastian Parschauer <sparschauer@suse.de>

commit e82e62e390d39c3819641cd721695702180d54fb upstream.

The PixArt OEM mice are known for disconnecting every minute in
runlevel 1 or 3 if they are not always polled. So add quirk
ALWAYS_POLL for this one as well.

References:
https://www.spinics.net/lists/linux-usb/msg88965.html
http://linet.gr.jp/~kojima/PlamoWeb/ML/htdocs/201808/msg00019.html

Signed-off-by: Sebastian Parschauer <sparschauer@suse.de>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
[bwh: Backported to 3.16:
 - Don't use HID_USB_DEVICE
 - Adjust filename, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/hid/hid-ids.h           | 1 +
 drivers/hid/usbhid/hid-quirks.c | 1 +
 2 files changed, 2 insertions(+)

--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -704,6 +704,7 @@
 #define USB_DEVICE_ID_MS_TYPE_COVER_PRO_4_JP 0x07e9
 #define USB_DEVICE_ID_MS_TYPE_COVER_3    0x07de
 #define USB_DEVICE_ID_MS_POWER_COVER     0x07da
+#define USB_DEVICE_ID_MS_PIXART_MOUSE    0x00cb
 
 #define USB_VENDOR_ID_MOJO		0x8282
 #define USB_DEVICE_ID_RETRO_ADAPTER	0x3201
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -117,6 +117,7 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_4_JP, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_POWER_COVER, HID_QUIRK_NO_INIT_REPORTS },
+	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_PIXART_MOUSE, HID_QUIRK_ALWAYS_POLL },
 	{ USB_VENDOR_ID_MSI, USB_DEVICE_ID_MSI_GX680R_LED_PANEL, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_NEXIO, USB_DEVICE_ID_NEXIO_MULTITOUCH_PTI0750, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_NOVATEK, USB_DEVICE_ID_NOVATEK_MOUSE, HID_QUIRK_NO_INIT_REPORTS },

