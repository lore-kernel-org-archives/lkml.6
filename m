Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A85AC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 715BF218F0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbfBCN47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 08:56:59 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53942 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728400AbfBCNuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:50:03 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9q-0003tj-31; Sun, 03 Feb 2019 13:50:02 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9j-0007FG-9H; Sun, 03 Feb 2019 14:49:55 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Sebastian Parschauer" <sparschauer@suse.de>,
        "Jiri Kosina" <jkosina@suse.cz>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.307315539@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 216/305] HID: Add quirk for Primax PIXART OEM mice
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

commit fb862c3b199d28bee238d52e8270eae8650d6cb0 upstream.

The PixArt OEM mice are known for disconnecting every minute in
runlevel 1 or 3 if they are not always polled. So add quirk
ALWAYS_POLL for two Primax mice as well.

0x4e22 is the Dell MS111-P and 0x4d0f is the unbranded HP Portia
mouse HP 697738-001. Both were built until approx. 2014.
Those were the standard mice from those vendors and are still
around - even as new old stock.

Reference: https://github.com/sriemer/fix-linux-mouse/issues/11

Signed-off-by: Sebastian Parschauer <sparschauer@suse.de>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
[bwh: Backported to 3.16:
 - Don't use HID_USB_DEVICE()
 - Adjust filename, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/hid/hid-ids.h           | 2 ++
 drivers/hid/usbhid/hid-quirks.c | 2 ++
 2 files changed, 4 insertions(+)

--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1055,6 +1055,8 @@
 #define USB_VENDOR_ID_PRIMAX	0x0461
 #define USB_DEVICE_ID_PRIMAX_MOUSE_4D22	0x4d22
 #define USB_DEVICE_ID_PRIMAX_KEYBOARD	0x4e05
+#define USB_DEVICE_ID_PRIMAX_PIXART_MOUSE_4D0F	0x4d0f
+#define USB_DEVICE_ID_PRIMAX_PIXART_MOUSE_4E22	0x4e22
 
 
 #define USB_VENDOR_ID_RISO_KAGAKU	0x1294	/* Riso Kagaku Corp. */
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -129,6 +129,8 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_PIXART, USB_DEVICE_ID_PIXART_OPTICAL_TOUCH_SCREEN1, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_PIXART, USB_DEVICE_ID_PIXART_OPTICAL_TOUCH_SCREEN2, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_PRIMAX, USB_DEVICE_ID_PRIMAX_MOUSE_4D22, HID_QUIRK_ALWAYS_POLL },
+	{ USB_VENDOR_ID_PRIMAX, USB_DEVICE_ID_PRIMAX_PIXART_MOUSE_4D0F, HID_QUIRK_ALWAYS_POLL },
+	{ USB_VENDOR_ID_PRIMAX, USB_DEVICE_ID_PRIMAX_PIXART_MOUSE_4E22, HID_QUIRK_ALWAYS_POLL },
 	{ USB_VENDOR_ID_PRODIGE, USB_DEVICE_ID_PRODIGE_CORDLESS, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_QUANTA, USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_3001, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_QUANTA, USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_3003, HID_QUIRK_NOGET },

