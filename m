Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CA5C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29AAA213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OGenz9C9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29AAA213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388149AbeK3BeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:34:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:35272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388123AbeK3BeM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:34:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0F692146F;
        Thu, 29 Nov 2018 14:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501719;
        bh=FYvtuFVyVnk7Uh/7SShkqevQgr7Wtj94MHZy9cS2guo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OGenz9C902Nf0cPOMR8k//LpBCKjb75O9e0OPPPXEalswvjOkb46fCyn/jn/sqC3T
         0qVwuGXLFiAIQbDDZ1uAznTyeE7mGMuMqocWOOrRaWpRZhSMrgdRJ2e+xXSbGhOXqr
         4PdG7mAMAST/SEdy0ppmeVqWOKZ5aLJay3YNe5I8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, George Cherian <george.cherian@cavium.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 4.19 013/110] xhci: Add quirk to workaround the errata seen on Cavium Thunder-X2 Soc
Date:   Thu, 29 Nov 2018 15:11:44 +0100
Message-Id: <20181129135921.778945636@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129135921.231283053@linuxfoundation.org>
References: <20181129135921.231283053@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cherian, George <George.Cherian@cavium.com>

commit 11644a7659529730eaf2f166efaabe7c3dc7af8c upstream.

Implement workaround for ThunderX2 Errata-129 (documented in
CN99XX Known Issues" available at Cavium support site).
As per ThunderX2errata-129, USB 2 device may come up as USB 1
if a connection to a USB 1 device is followed by another connection to
a USB 2 device, the link will come up as USB 1 for the USB 2 device.

Resolution: Reset the PHY after the USB 1 device is disconnected.
The PHY reset sequence is done using private registers in XHCI register
space. After the PHY is reset we check for the PLL lock status and retry
the operation if it fails. From our tests, retrying 4 times is sufficient.

Add a new quirk flag XHCI_RESET_PLL_ON_DISCONNECT to invoke the workaround
in handle_xhci_port_status().

Cc: stable@vger.kernel.org
Signed-off-by: George Cherian <george.cherian@cavium.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/xhci-pci.c  |    5 +++++
 drivers/usb/host/xhci-ring.c |   35 ++++++++++++++++++++++++++++++++++-
 drivers/usb/host/xhci.h      |    1 +
 3 files changed, 40 insertions(+), 1 deletion(-)

--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -231,6 +231,11 @@ static void xhci_pci_quirks(struct devic
 	if (pdev->vendor == PCI_VENDOR_ID_TI && pdev->device == 0x8241)
 		xhci->quirks |= XHCI_LIMIT_ENDPOINT_INTERVAL_7;
 
+	if ((pdev->vendor == PCI_VENDOR_ID_BROADCOM ||
+	     pdev->vendor == PCI_VENDOR_ID_CAVIUM) &&
+	     pdev->device == 0x9026)
+		xhci->quirks |= XHCI_RESET_PLL_ON_DISCONNECT;
+
 	if (xhci->quirks & XHCI_RESET_ON_RESUME)
 		xhci_dbg_trace(xhci, trace_xhci_dbg_quirks,
 				"QUIRK: Resetting on resume");
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1517,6 +1517,35 @@ static void handle_device_notification(s
 		usb_wakeup_notification(udev->parent, udev->portnum);
 }
 
+/*
+ * Quirk hanlder for errata seen on Cavium ThunderX2 processor XHCI
+ * Controller.
+ * As per ThunderX2errata-129 USB 2 device may come up as USB 1
+ * If a connection to a USB 1 device is followed by another connection
+ * to a USB 2 device.
+ *
+ * Reset the PHY after the USB device is disconnected if device speed
+ * is less than HCD_USB3.
+ * Retry the reset sequence max of 4 times checking the PLL lock status.
+ *
+ */
+static void xhci_cavium_reset_phy_quirk(struct xhci_hcd *xhci)
+{
+	struct usb_hcd *hcd = xhci_to_hcd(xhci);
+	u32 pll_lock_check;
+	u32 retry_count = 4;
+
+	do {
+		/* Assert PHY reset */
+		writel(0x6F, hcd->regs + 0x1048);
+		udelay(10);
+		/* De-assert the PHY reset */
+		writel(0x7F, hcd->regs + 0x1048);
+		udelay(200);
+		pll_lock_check = readl(hcd->regs + 0x1070);
+	} while (!(pll_lock_check & 0x1) && --retry_count);
+}
+
 static void handle_port_status(struct xhci_hcd *xhci,
 		union xhci_trb *event)
 {
@@ -1650,8 +1679,12 @@ static void handle_port_status(struct xh
 		goto cleanup;
 	}
 
-	if (hcd->speed < HCD_USB3)
+	if (hcd->speed < HCD_USB3) {
 		xhci_test_and_clear_bit(xhci, port, PORT_PLC);
+		if ((xhci->quirks & XHCI_RESET_PLL_ON_DISCONNECT) &&
+		    (portsc & PORT_CSC) && !(portsc & PORT_CONNECT))
+			xhci_cavium_reset_phy_quirk(xhci);
+	}
 
 cleanup:
 	/* Update event ring dequeue pointer before dropping the lock */
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1846,6 +1846,7 @@ struct xhci_hcd {
 #define XHCI_SUSPEND_DELAY	BIT_ULL(30)
 #define XHCI_INTEL_USB_ROLE_SW	BIT_ULL(31)
 #define XHCI_ZERO_64B_REGS	BIT_ULL(32)
+#define XHCI_RESET_PLL_ON_DISCONNECT	BIT_ULL(34)
 
 	unsigned int		num_active_eps;
 	unsigned int		limit_active_eps;


