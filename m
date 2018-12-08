Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C00C07E85
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 01:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF81120857
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 01:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UMS4cpoS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF81120857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbeLHBrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 20:47:52 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44112 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbeLHBrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 20:47:52 -0500
Received: by mail-qt1-f196.google.com with SMTP id n32so6599961qte.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 17:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sFhVeAi7iY+UOG3wtwxTXo49ZgqvorZCSv35bV1qeMY=;
        b=UMS4cpoST60G6mrh0UTfrRs2NNM3+eLo3gRw1q0JybRTuhidGtYuZJumI9YpCUWYcm
         aEN2kyN8MHucC4EHOcMNkaNEUj5h4TBh6wS4hNTaAm/18uPO+BEXxma1szPcslcy5P4k
         IE7HyoDHFl5qniIKRS9rcXvUtXSmihvWJdCC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sFhVeAi7iY+UOG3wtwxTXo49ZgqvorZCSv35bV1qeMY=;
        b=OPvuRGP3kaW2xi3A00AbVpMHFxNKhyAATACq1LaT7zQ2Y2VYdtznkKI+VA7w5UvL7i
         n0haoD+FyOYpY2uEKl/0mdaqiLz6l44DYW5ywa8+rKXHaPJe1j1J8C4M+jxwUsOil812
         f6ZVBr8pxgez3cM0Vmupj/2GrTEiG3pK9OgIjxRdo7+BmHfUiFyfTXcpL+hu51N8lClA
         GWWOKeHz69CBP0V9BZgNCIzKQ1/yp1McCywiSkg6ImZ9MV+FKdKjLTfd1D6DzRu3KeO7
         mLeGpXOvnlA6VBIsejEp1tkJVdA2r4mXUBsRbGX1et5Yau9kUAaySAOaYvD/29TdCrTQ
         X0Ug==
X-Gm-Message-State: AA+aEWbQSMIBk/jjEfsq10kL2HdjZXRRa525LFkY7IZxsbcXVkLSA+vI
        AWgcpovJo1LV2DgK4Nt6J8S6+2JUXe5BQQ==
X-Google-Smtp-Source: AFSGD/WxoFWT5htkc9hsohM3MVpc/T2iWOCJ5Jny3Gr7uEyxvls5hxjywTDfv7j14U9KLhiXxt/GnQ==
X-Received: by 2002:ac8:254c:: with SMTP id 12mr4071312qtn.88.1544233670635;
        Fri, 07 Dec 2018 17:47:50 -0800 (PST)
Received: from kdgwill07.nyc.corp.google.com ([2620:0:1003:510:59af:10e9:2d49:6b0a])
        by smtp.googlemail.com with ESMTPSA id 94sm5604597qks.8.2018.12.07.17.47.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 17:47:50 -0800 (PST)
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
        linux-usb@vger.kernel.org
Subject: [PATCH v3 1/2] USB: quirks: Check device interface LPM capability
Date:   Fri,  7 Dec 2018 20:47:21 -0500
Message-Id: <20181208014724.951-2-kdgwill@google.com>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
In-Reply-To: <20181208014724.951-1-kdgwill@google.com>
References: <20181205093902.GA18633@kroah.com>
 <20181208014724.951-1-kdgwill@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kyle Williams <kdgwill@chromium.org>

Description: enable the ability to disable LPM for all devices matched
by interface information

Signed-off-by: Kyle Williams <kdgwill@chromium.org>
---
 drivers/usb/core/hub.c | 87 +++++++++++++++++++++++-------------------
 1 file changed, 48 insertions(+), 39 deletions(-)

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
-- 
2.20.0.rc2.403.gdbc3b29805-goog

