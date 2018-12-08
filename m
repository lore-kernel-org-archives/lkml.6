Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F088EC64EB1
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 00:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7C96208E7
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 00:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Oc9KzfhW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7C96208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbeLHAsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 19:48:02 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44123 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbeLHAsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 19:48:00 -0500
Received: by mail-qt1-f193.google.com with SMTP id n32so6508781qte.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 16:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NRkbgoAqHLBXEpXwn4nVEYMfs9jWYNDOZepIs2hElB8=;
        b=Oc9KzfhWC3PqPIseWX5ytSqyfD4ysuNYv0HOKyu7la8rPFf0aqmJ/tpD5xEMgjKGob
         l/wBeD84lm9duF01JwQRf9yuQKDIajQDQ7w/e5IbDAeOtx1e4wHGFj866d9TKBzZnTzb
         N8SB0+yJSRzGFEsUMb8TurR0w7wqY25XtPeSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NRkbgoAqHLBXEpXwn4nVEYMfs9jWYNDOZepIs2hElB8=;
        b=s/2yFnkN3SQJofn8oxZakO7a0aqec/qoDanl9uePzT0l05PJ+wDz5zr3ONmBk/xv8I
         cJ4X1UBAFcr3zeJ8zq6yGFy1LzPbrEW1hNr6VZ/gcerE8DHDRkWJ9rCo+X6+AOwT683x
         8yehw+vx+td5theDpWca8fjdTEJJDmdJIyKfrZulgR1ASGv6W4zgRvm2MGBvUXJOEBCS
         Gpr0sncWOqJePX9zn54tgY9A7005rwtZLvP198qx0TcznVbT7kg5uSZB2U8/kBXRRwcR
         oT9PbIC25Vp65n9BVUAyy5QFuvck40OE0Xj+lHEPTRynRwG7urhLhkwzVOCmvVGeuns5
         hcoQ==
X-Gm-Message-State: AA+aEWaFEHq3nOmMNWTc3hfr+vmKOsMgMaR42lYrbpk0g5rMHAFjPoex
        U+rzWW9u5xEQrB6Coemw591quBmOOQpxoA==
X-Google-Smtp-Source: AFSGD/Xl2nfJsuwj3xkJpCGt6CN0gZTpAOoQDaZFXdbPv46oJocBTTOemNKdPceddbP4tzdLiiQsxA==
X-Received: by 2002:a0c:d174:: with SMTP id c49mr3954918qvh.231.1544230079305;
        Fri, 07 Dec 2018 16:47:59 -0800 (PST)
Received: from kdgwill07.nyc.corp.google.com ([2620:0:1003:510:59af:10e9:2d49:6b0a])
        by smtp.googlemail.com with ESMTPSA id u50sm3528231qta.23.2018.12.07.16.47.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 16:47:58 -0800 (PST)
From:   Kyle Williams <kdgwill@chromium.org>
X-Google-Original-From: Kyle Williams <kdgwill@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     kdgwill@chromium.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Jon Flatley <jflat@chromium.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Danilo Krummrich <danilokrummrich@dk-develop.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        =?UTF-8?q?Maxence=20Dupr=C3=A8s?= <xpros64@hotmail.fr>,
        Kamil Lulko <kamilx.lulko@intel.com>,
        Emmanuel Pescosta <emmanuelpescosta099@gmail.com>,
        linux-usb@vger.kernel.org
Subject: [PATCH v2] USB: quirks: disable LPM for Logitech UVC devices
Date:   Fri,  7 Dec 2018 19:46:38 -0500
Message-Id: <20181208004641.240699-1-kdgwill@google.com>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
In-Reply-To: <20181207222138.GB161210@google.com>
References: <20181207222138.GB161210@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kyle Williams <kdgwill@chromium.org>

Description: Some USB device / host controller combinations seem to have
problems with Link Power management. In particular it is described that
the combination of certain Logitech uvc devices and other powered media
devices such causes 'not enough bandwidth for new device state' error.

This patch enables the USB_QUIRK_NO_LPM quirk entries for all connected
Logitech UVC devices indicating LPM should remain disabled for the device.

Signed-off-by: Kyle Williams <kdgwill@chromium.org>
---

Changes in v2:
- changed commit message
- disble lpm for all logitech uvc devices instead of listing manually
- changes to allow the lpm to correctly be disabled after enumeration

 drivers/usb/core/hub.c    | 87 +++++++++++++++++++++------------------
 drivers/usb/core/quirks.c |  2 +-
 2 files changed, 49 insertions(+), 40 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 0f9381b69a3b..8f366ec4d21b 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -365,6 +365,51 @@ static void usb_set_lpm_parameters(struct usb_device *udev)
 	usb_set_lpm_sel(udev, &udev->u2_params);
 }
 
+/*
+ * There are reports of USB 3.0 devices that say they support USB 2.0 Link PM
+ * when they're plugged into a USB 2.0 port, but they don't work when LPM is
+ * enabled.
+ *
+ * Only enable USB 2.0 Link PM if the port is internal (hardwired), or the
+ * device says it supports the new USB 2.0 Link PM errata by setting the BESL
+ * support bit in the BOS descriptor.
+ */
+static void hub_set_initial_usb2_lpm_policy(struct usb_device *udev)
+{
+	struct usb_hub *hub = usb_hub_to_struct_hub(udev->parent);
+	int connect_type = USB_PORT_CONNECT_TYPE_UNKNOWN;
+
+	if (!udev->usb2_hw_lpm_capable || !udev->bos)
+		return;
+
+	if (hub)
+		connect_type = hub->ports[udev->portnum - 1]->connect_type;
+
+	if ((udev->bos->ext_cap->bmAttributes & cpu_to_le32(USB_BESL_SUPPORT))
+			|| connect_type == USB_PORT_CONNECT_TYPE_HARD_WIRED) {
+		udev->usb2_hw_lpm_allowed = 1;
+		usb_set_usb2_hardware_lpm(udev, 1);
+	}
+}
+
+void usb_update_device_lpm(struct usb_hcd *hcd, struct usb_device *udev)
+{
+	int retval;
+
+	if (udev->wusb == 0 && le16_to_cpu(udev->descriptor.bcdUSB) >= 0x0201) {
+		retval = usb_get_bos_descriptor(udev);
+		if (!retval) {
+			udev->lpm_capable = usb_device_supports_lpm(udev);
+			usb_set_lpm_parameters(udev);
+		}
+	}
+
+	/* notify HCD that we have a device connected and addressed */
+	if (hcd->driver->update_device)
+		hcd->driver->update_device(hcd, udev);
+	hub_set_initial_usb2_lpm_policy(udev);
+}
+
 /* USB 2.0 spec Section 11.24.4.5 */
 static int get_hub_descriptor(struct usb_device *hdev,
 		struct usb_hub_descriptor *desc)
@@ -2295,7 +2340,6 @@ static int usb_enumerate_device_otg(struct usb_device *udev)
 	return err;
 }
 
-
 /**
  * usb_enumerate_device - Read device configs/intfs/otg (usbcore-internal)
  * @udev: newly addressed device (in ADDRESS state)
@@ -2351,6 +2395,8 @@ static int usb_enumerate_device(struct usb_device *udev)
 
 	usb_detect_interface_quirks(udev);
 
+	usb_update_device_lpm(hcd, udev);
+
 	return 0;
 }
 
@@ -4402,33 +4448,6 @@ static int hub_set_address(struct usb_device *udev, int devnum)
 	return retval;
 }
 
-/*
- * There are reports of USB 3.0 devices that say they support USB 2.0 Link PM
- * when they're plugged into a USB 2.0 port, but they don't work when LPM is
- * enabled.
- *
- * Only enable USB 2.0 Link PM if the port is internal (hardwired), or the
- * device says it supports the new USB 2.0 Link PM errata by setting the BESL
- * support bit in the BOS descriptor.
- */
-static void hub_set_initial_usb2_lpm_policy(struct usb_device *udev)
-{
-	struct usb_hub *hub = usb_hub_to_struct_hub(udev->parent);
-	int connect_type = USB_PORT_CONNECT_TYPE_UNKNOWN;
-
-	if (!udev->usb2_hw_lpm_capable || !udev->bos)
-		return;
-
-	if (hub)
-		connect_type = hub->ports[udev->portnum - 1]->connect_type;
-
-	if ((udev->bos->ext_cap->bmAttributes & cpu_to_le32(USB_BESL_SUPPORT)) ||
-			connect_type == USB_PORT_CONNECT_TYPE_HARD_WIRED) {
-		udev->usb2_hw_lpm_allowed = 1;
-		usb_set_usb2_hardware_lpm(udev, 1);
-	}
-}
-
 static int hub_enable_device(struct usb_device *udev)
 {
 	struct usb_hcd *hcd = bus_to_hcd(udev->bus);
@@ -4779,19 +4798,9 @@ hub_port_init(struct usb_hub *hub, struct usb_device *udev, int port1,
 
 	usb_detect_quirks(udev);
 
-	if (udev->wusb == 0 && le16_to_cpu(udev->descriptor.bcdUSB) >= 0x0201) {
-		retval = usb_get_bos_descriptor(udev);
-		if (!retval) {
-			udev->lpm_capable = usb_device_supports_lpm(udev);
-			usb_set_lpm_parameters(udev);
-		}
-	}
+	usb_update_device_lpm(hcd, udev);
 
 	retval = 0;
-	/* notify HCD that we have a device connected and addressed */
-	if (hcd->driver->update_device)
-		hcd->driver->update_device(hcd, udev);
-	hub_set_initial_usb2_lpm_policy(udev);
 fail:
 	if (retval) {
 		hub_port_disable(hub, port1, 0);
diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 0690fcff0ea2..bbbb7e6df958 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -440,7 +440,7 @@ static const struct usb_device_id usb_quirk_list[] = {
 static const struct usb_device_id usb_interface_quirk_list[] = {
 	/* Logitech UVC Cameras */
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x046d, USB_CLASS_VIDEO, 1, 0),
-	  .driver_info = USB_QUIRK_RESET_RESUME },
+	  .driver_info = USB_QUIRK_RESET_RESUME | USB_QUIRK_NO_LPM },
 
 	{ }  /* terminating entry must be last */
 };
-- 
2.20.0.rc2.403.gdbc3b29805-goog

