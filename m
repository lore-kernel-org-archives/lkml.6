Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91316C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 441E22083D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:24:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 441E22083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732998AbeHAULC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:11:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46078 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404356AbeHATDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:03:38 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8E666F4F;
        Wed,  1 Aug 2018 16:56:53 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        "Shuah Khan (Samsung OSG)" <shuah@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 078/336] usbip: dynamically allocate idev by nports found in sysfs
Date:   Wed,  1 Aug 2018 18:46:53 +0200
Message-Id: <20180801165032.117363702@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Grzeschik <m.grzeschik@pengutronix.de>

[ Upstream commit de19ca6fd72c7dd45ad82403e7b3fe9c74ef6767 ]

As the amount of available ports varies by the kernels build
configuration. To remove the limitation of the fixed 128 ports
we allocate the amount of idevs by using the number we get
from the kernel.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
Acked-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/usb/usbip/libsrc/vhci_driver.c |   32 +++++++++++++++++++-------------
 tools/usb/usbip/libsrc/vhci_driver.h |    3 +--
 2 files changed, 20 insertions(+), 15 deletions(-)

--- a/tools/usb/usbip/libsrc/vhci_driver.c
+++ b/tools/usb/usbip/libsrc/vhci_driver.c
@@ -135,11 +135,11 @@ static int refresh_imported_device_list(
 	return 0;
 }
 
-static int get_nports(void)
+static int get_nports(struct udev_device *hc_device)
 {
 	const char *attr_nports;
 
-	attr_nports = udev_device_get_sysattr_value(vhci_driver->hc_device, "nports");
+	attr_nports = udev_device_get_sysattr_value(hc_device, "nports");
 	if (!attr_nports) {
 		err("udev_device_get_sysattr_value nports failed");
 		return -1;
@@ -242,35 +242,41 @@ static int read_record(int rhport, char
 
 int usbip_vhci_driver_open(void)
 {
+	int nports;
+	struct udev_device *hc_device;
+
 	udev_context = udev_new();
 	if (!udev_context) {
 		err("udev_new failed");
 		return -1;
 	}
 
-	vhci_driver = calloc(1, sizeof(struct usbip_vhci_driver));
-
 	/* will be freed in usbip_driver_close() */
-	vhci_driver->hc_device =
+	hc_device =
 		udev_device_new_from_subsystem_sysname(udev_context,
 						       USBIP_VHCI_BUS_TYPE,
 						       USBIP_VHCI_DEVICE_NAME);
-	if (!vhci_driver->hc_device) {
+	if (!hc_device) {
 		err("udev_device_new_from_subsystem_sysname failed");
 		goto err;
 	}
 
-	vhci_driver->nports = get_nports();
-	dbg("available ports: %d", vhci_driver->nports);
-
-	if (vhci_driver->nports <= 0) {
+	nports = get_nports(hc_device);
+	if (nports <= 0) {
 		err("no available ports");
 		goto err;
-	} else if (vhci_driver->nports > MAXNPORT) {
-		err("port number exceeds %d", MAXNPORT);
+	}
+	dbg("available ports: %d", nports);
+
+	vhci_driver = calloc(1, sizeof(struct usbip_vhci_driver) +
+			nports * sizeof(struct usbip_imported_device));
+	if (!vhci_driver) {
+		err("vhci_driver allocation failed");
 		goto err;
 	}
 
+	vhci_driver->nports = nports;
+	vhci_driver->hc_device = hc_device;
 	vhci_driver->ncontrollers = get_ncontrollers();
 	dbg("available controllers: %d", vhci_driver->ncontrollers);
 
@@ -285,7 +291,7 @@ int usbip_vhci_driver_open(void)
 	return 0;
 
 err:
-	udev_device_unref(vhci_driver->hc_device);
+	udev_device_unref(hc_device);
 
 	if (vhci_driver)
 		free(vhci_driver);
--- a/tools/usb/usbip/libsrc/vhci_driver.h
+++ b/tools/usb/usbip/libsrc/vhci_driver.h
@@ -13,7 +13,6 @@
 
 #define USBIP_VHCI_BUS_TYPE "platform"
 #define USBIP_VHCI_DEVICE_NAME "vhci_hcd.0"
-#define MAXNPORT 128
 
 enum hub_speed {
 	HUB_SPEED_HIGH = 0,
@@ -41,7 +40,7 @@ struct usbip_vhci_driver {
 
 	int ncontrollers;
 	int nports;
-	struct usbip_imported_device idev[MAXNPORT];
+	struct usbip_imported_device idev[];
 };
 
 


