Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9002C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5930420821
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NtT1GhgM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbfBEGTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 01:19:20 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43374 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbfBEGTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 01:19:20 -0500
Received: by mail-ed1-f67.google.com with SMTP id f9so1885853eds.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 22:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2joTHd/qfxG2VDYCb9Jw7yy8c8PzPgqLNKek+stZxME=;
        b=NtT1GhgM5wYXPv49A+7GW1Z+JN+NPHkPIB1FJLBYrGJM6x8hhR2jQuCpbLDZMT3FUv
         WcWCYkFd7HyAeEfI/xH750iW4rwT3gylgtYUk6srb08HYeZde+tS1VXjUSW8PJ5iCGp5
         VpydCrsiTB2CHDW9PotfZuYPCNce8y7paEdnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2joTHd/qfxG2VDYCb9Jw7yy8c8PzPgqLNKek+stZxME=;
        b=OyVf+qKkeoqI3FJ9jUDeXfw2S8P/D2KArdBt6Xe/2F/49b3GPswV4O+eIlP9C4ppVY
         AyUid9RbtMks8K5VDQEsLu3lO1oXvubT0e0jv2bA8l3AxHqhBdyeXloIKgcaVERMxSng
         w4TgPf0mn9qIC2zwn8Zi7CUpK/q6PbMFRcr8Ri75ChySRaQzMjdMp3ntybDDjAsPb8pI
         Wcb1CuB7J+4FMvwNwXx3PvwsbbBxA1ZLHsMYaeVSGPXBwQ5ejSmsbKMFECUz0tSbT3ID
         U70q2NMuYEuZl/cZWGwgCZ2e65lQd1hLMg65xbqY3l5iUHMhXvRLoRkoO/wWgU25o0J6
         13sA==
X-Gm-Message-State: AHQUAuYyvkfrw8NUAWRsop8sZcWJnbd1HxA6hvHLJ3NFwu7JSvLUqmPE
        H2hyFozLi9OgBwoMiSMKgtb+Nw==
X-Google-Smtp-Source: AHgI3IavOc2gOjrPjzXbFOmPpl7yHLjTFQy7iGDHobTicrYKYeBPeOvKSUInVCCEsCAyDEBjgTYrQQ==
X-Received: by 2002:a17:906:4f84:: with SMTP id o4mr1033156eju.227.1549347558364;
        Mon, 04 Feb 2019 22:19:18 -0800 (PST)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id t26sm2835120ejs.48.2019.02.04.22.19.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Feb 2019 22:19:17 -0800 (PST)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH 2/2] drivers: xhci: Add quirk to reset xHCI port PHY
Date:   Tue,  5 Feb 2019 11:48:54 +0530
Message-Id: <1549347534-11320-3-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549347534-11320-1-git-send-email-srinath.mannam@broadcom.com>
References: <1549347534-11320-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a quirk to reset xHCI port PHY on port disconnect event.
Stingray USB HS PHY has an issue, that USB High Speed device detected
at Full Speed after the same port has connected to Full speed device.
This problem can be resolved with that port PHY reset on disconnect.

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
---
 drivers/usb/core/hcd.c       |  6 ++++++
 drivers/usb/core/phy.c       | 21 +++++++++++++++++++++
 drivers/usb/core/phy.h       |  1 +
 drivers/usb/host/xhci-plat.c |  3 +++
 drivers/usb/host/xhci-ring.c |  9 ++++++---
 drivers/usb/host/xhci.h      |  1 +
 include/linux/usb/hcd.h      |  1 +
 7 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 015b126..e2b87a6 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -2663,6 +2663,12 @@ int usb_hcd_find_raw_port_number(struct usb_hcd *hcd, int port1)
 	return hcd->driver->find_raw_port_number(hcd, port1);
 }
 
+int usb_hcd_phy_port_reset(struct usb_hcd *hcd, int port)
+{
+	return usb_phy_roothub_port_reset(hcd->phy_roothub, port);
+}
+EXPORT_SYMBOL_GPL(usb_hcd_phy_port_reset);
+
 static int usb_hcd_request_irqs(struct usb_hcd *hcd,
 		unsigned int irqnum, unsigned long irqflags)
 {
diff --git a/drivers/usb/core/phy.c b/drivers/usb/core/phy.c
index 38b2c77..c64767d 100644
--- a/drivers/usb/core/phy.c
+++ b/drivers/usb/core/phy.c
@@ -162,6 +162,27 @@ void usb_phy_roothub_power_off(struct usb_phy_roothub *phy_roothub)
 }
 EXPORT_SYMBOL_GPL(usb_phy_roothub_power_off);
 
+int usb_phy_roothub_port_reset(struct usb_phy_roothub *phy_roothub, int port)
+{
+	struct usb_phy_roothub *roothub_entry;
+	struct list_head *head;
+	int i = 0;
+
+	if (!phy_roothub)
+		return -EINVAL;
+
+	head = &phy_roothub->list;
+
+	list_for_each_entry(roothub_entry, head, list) {
+		if (i == port)
+			return phy_reset(roothub_entry->phy);
+		i++;
+	}
+
+	return -ENODEV;
+}
+EXPORT_SYMBOL_GPL(usb_phy_roothub_port_reset);
+
 int usb_phy_roothub_suspend(struct device *controller_dev,
 			    struct usb_phy_roothub *phy_roothub)
 {
diff --git a/drivers/usb/core/phy.h b/drivers/usb/core/phy.h
index 88a3c03..e8be444 100644
--- a/drivers/usb/core/phy.h
+++ b/drivers/usb/core/phy.h
@@ -18,6 +18,7 @@ int usb_phy_roothub_exit(struct usb_phy_roothub *phy_roothub);
 
 int usb_phy_roothub_power_on(struct usb_phy_roothub *phy_roothub);
 void usb_phy_roothub_power_off(struct usb_phy_roothub *phy_roothub);
+int usb_phy_roothub_port_reset(struct usb_phy_roothub *phy_roothub, int port);
 
 int usb_phy_roothub_suspend(struct device *controller_dev,
 			    struct usb_phy_roothub *phy_roothub);
diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index ef09cb0..5a3b486 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -289,6 +289,9 @@ static int xhci_plat_probe(struct platform_device *pdev)
 		if (device_property_read_bool(tmpdev, "quirk-broken-port-ped"))
 			xhci->quirks |= XHCI_BROKEN_PORT_PED;
 
+		if (device_property_read_bool(tmpdev, "usb-phy-port-reset"))
+			xhci->quirks |= XHCI_RESET_PHY_ON_DISCONNECT;
+
 		device_property_read_u32(tmpdev, "imod-interval-ns",
 					 &xhci->imod_interval);
 	}
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 40fa25c..2dc3116 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1685,9 +1685,12 @@ static void handle_port_status(struct xhci_hcd *xhci,
 
 	if (hcd->speed < HCD_USB3) {
 		xhci_test_and_clear_bit(xhci, port, PORT_PLC);
-		if ((xhci->quirks & XHCI_RESET_PLL_ON_DISCONNECT) &&
-		    (portsc & PORT_CSC) && !(portsc & PORT_CONNECT))
-			xhci_cavium_reset_phy_quirk(xhci);
+		if ((portsc & PORT_CSC) && !(portsc & PORT_CONNECT)) {
+			if (xhci->quirks & XHCI_RESET_PLL_ON_DISCONNECT)
+				xhci_cavium_reset_phy_quirk(xhci);
+			else if (xhci->quirks & XHCI_RESET_PHY_ON_DISCONNECT)
+				usb_hcd_phy_port_reset(hcd, port_id - 1);
+		}
 	}
 
 cleanup:
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 652dc36..530c5ff 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1846,6 +1846,7 @@ struct xhci_hcd {
 #define XHCI_DEFAULT_PM_RUNTIME_ALLOW	BIT_ULL(33)
 #define XHCI_RESET_PLL_ON_DISCONNECT	BIT_ULL(34)
 #define XHCI_SNPS_BROKEN_SUSPEND    BIT_ULL(35)
+#define XHCI_RESET_PHY_ON_DISCONNECT	BIT_ULL(36)
 
 	unsigned int		num_active_eps;
 	unsigned int		limit_active_eps;
diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
index 7dc3a41..a5ea26f 100644
--- a/include/linux/usb/hcd.h
+++ b/include/linux/usb/hcd.h
@@ -456,6 +456,7 @@ extern int usb_add_hcd(struct usb_hcd *hcd,
 		unsigned int irqnum, unsigned long irqflags);
 extern void usb_remove_hcd(struct usb_hcd *hcd);
 extern int usb_hcd_find_raw_port_number(struct usb_hcd *hcd, int port1);
+extern int usb_hcd_phy_port_reset(struct usb_hcd *hcd, int port);
 
 struct platform_device;
 extern void usb_hcd_platform_shutdown(struct platform_device *dev);
-- 
2.7.4

