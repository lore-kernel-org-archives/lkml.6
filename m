Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77745C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 329EE2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="grnliOzi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 329EE2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388161AbeK3BeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:34:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:35344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388123AbeK3BeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:34:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48A882145D;
        Thu, 29 Nov 2018 14:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501721;
        bh=OrNYUHpdQj6lcfKIT3GQCHk42xkIspMjInbHV8UIRvk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=grnliOzirqDu0O1k93WgRtS95CiQdgbmcje2SE+3Tq/DkiaG0k67vLXMsv7nf4X4J
         exlEBtTYzMA8oeQaL4E0YD1DYH05pJvkk5umoZCr1eMByOEvPuGAGrbwPFsTmfk5UB
         c6DrJfka5upMtyKombT/ICPGFzk7/uydKd1c8cxc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 4.19 014/110] usb: xhci: Prevent bus suspend if a port connect change or polling state is detected
Date:   Thu, 29 Nov 2018 15:11:45 +0100
Message-Id: <20181129135921.817957465@linuxfoundation.org>
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

From: Mathias Nyman <mathias.nyman@linux.intel.com>

commit 2f31a67f01a8beb22cae754c53522cb61a005750 upstream.

USB3 roothub might autosuspend before a plugged USB3 device is detected,
causing USB3 device enumeration failure.

USB3 devices don't show up as connected and enabled until USB3 link trainig
completes. On a fast booting platform with a slow USB3 link training the
link might reach the connected enabled state just as the bus is suspending.

If this device is discovered first time by the xhci_bus_suspend() routine
it will be put to U3 suspended state like the other ports which failed to
suspend earlier.

The hub thread will notice the connect change and resume the bus,
moving the port back to U0

This U0 -> U3 -> U0 transition right after being connected seems to be
too much for some devices, causing them to first go to SS.Inactive state,
and finally end up stuck in a polling state with reset asserted

Fix this by failing the bus suspend if a port has a connect change or is
in a polling state in xhci_bus_suspend().

Don't do any port changes until all ports are checked, buffer all port
changes and only write them in the end if suspend can proceed

Cc: stable@vger.kernel.org
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/xhci-hub.c |   60 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 46 insertions(+), 14 deletions(-)

--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -1474,15 +1474,18 @@ int xhci_bus_suspend(struct usb_hcd *hcd
 	unsigned long flags;
 	struct xhci_hub *rhub;
 	struct xhci_port **ports;
+	u32 portsc_buf[USB_MAXCHILDREN];
+	bool wake_enabled;
 
 	rhub = xhci_get_rhub(hcd);
 	ports = rhub->ports;
 	max_ports = rhub->num_ports;
 	bus_state = &xhci->bus_state[hcd_index(hcd)];
+	wake_enabled = hcd->self.root_hub->do_remote_wakeup;
 
 	spin_lock_irqsave(&xhci->lock, flags);
 
-	if (hcd->self.root_hub->do_remote_wakeup) {
+	if (wake_enabled) {
 		if (bus_state->resuming_ports ||	/* USB2 */
 		    bus_state->port_remote_wakeup) {	/* USB3 */
 			spin_unlock_irqrestore(&xhci->lock, flags);
@@ -1490,26 +1493,36 @@ int xhci_bus_suspend(struct usb_hcd *hcd
 			return -EBUSY;
 		}
 	}
-
-	port_index = max_ports;
+	/*
+	 * Prepare ports for suspend, but don't write anything before all ports
+	 * are checked and we know bus suspend can proceed
+	 */
 	bus_state->bus_suspended = 0;
+	port_index = max_ports;
 	while (port_index--) {
-		/* suspend the port if the port is not suspended */
 		u32 t1, t2;
-		int slot_id;
 
 		t1 = readl(ports[port_index]->addr);
 		t2 = xhci_port_state_to_neutral(t1);
+		portsc_buf[port_index] = 0;
 
-		if ((t1 & PORT_PE) && !(t1 & PORT_PLS_MASK)) {
-			xhci_dbg(xhci, "port %d not suspended\n", port_index);
-			slot_id = xhci_find_slot_id_by_port(hcd, xhci,
-					port_index + 1);
-			if (slot_id) {
+		/* Bail out if a USB3 port has a new device in link training */
+		if ((t1 & PORT_PLS_MASK) == XDEV_POLLING) {
+			bus_state->bus_suspended = 0;
+			spin_unlock_irqrestore(&xhci->lock, flags);
+			xhci_dbg(xhci, "Bus suspend bailout, port in polling\n");
+			return -EBUSY;
+		}
+
+		/* suspend ports in U0, or bail out for new connect changes */
+		if ((t1 & PORT_PE) && (t1 & PORT_PLS_MASK) == XDEV_U0) {
+			if ((t1 & PORT_CSC) && wake_enabled) {
+				bus_state->bus_suspended = 0;
 				spin_unlock_irqrestore(&xhci->lock, flags);
-				xhci_stop_device(xhci, slot_id, 1);
-				spin_lock_irqsave(&xhci->lock, flags);
+				xhci_dbg(xhci, "Bus suspend bailout, port connect change\n");
+				return -EBUSY;
 			}
+			xhci_dbg(xhci, "port %d not suspended\n", port_index);
 			t2 &= ~PORT_PLS_MASK;
 			t2 |= PORT_LINK_STROBE | XDEV_U3;
 			set_bit(port_index, &bus_state->bus_suspended);
@@ -1518,7 +1531,7 @@ int xhci_bus_suspend(struct usb_hcd *hcd
 		 * including the USB 3.0 roothub, but only if CONFIG_PM
 		 * is enabled, so also enable remote wake here.
 		 */
-		if (hcd->self.root_hub->do_remote_wakeup) {
+		if (wake_enabled) {
 			if (t1 & PORT_CONNECT) {
 				t2 |= PORT_WKOC_E | PORT_WKDISC_E;
 				t2 &= ~PORT_WKCONN_E;
@@ -1538,7 +1551,26 @@ int xhci_bus_suspend(struct usb_hcd *hcd
 
 		t1 = xhci_port_state_to_neutral(t1);
 		if (t1 != t2)
-			writel(t2, ports[port_index]->addr);
+			portsc_buf[port_index] = t2;
+	}
+
+	/* write port settings, stopping and suspending ports if needed */
+	port_index = max_ports;
+	while (port_index--) {
+		if (!portsc_buf[port_index])
+			continue;
+		if (test_bit(port_index, &bus_state->bus_suspended)) {
+			int slot_id;
+
+			slot_id = xhci_find_slot_id_by_port(hcd, xhci,
+							    port_index + 1);
+			if (slot_id) {
+				spin_unlock_irqrestore(&xhci->lock, flags);
+				xhci_stop_device(xhci, slot_id, 1);
+				spin_lock_irqsave(&xhci->lock, flags);
+			}
+		}
+		writel(portsc_buf[port_index], ports[port_index]->addr);
 	}
 	hcd->state = HC_STATE_SUSPENDED;
 	bus_state->next_statechange = jiffies + msecs_to_jiffies(10);


