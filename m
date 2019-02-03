Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98745C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67E1C218D8
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbfBCNug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 08:50:36 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53746 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728342AbfBCNt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:49:59 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9l-0003tf-DM; Sun, 03 Feb 2019 13:49:57 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9h-0007DH-Rc; Sun, 03 Feb 2019 14:49:53 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Mathias Nyman" <mathias.nyman@linux.intel.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.853391484@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 204/305] usb: xhci: Prevent bus suspend if a port
 connect change or polling state is detected
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

Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16:
 - Keep  port_array[] to look up port I/O address
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/host/xhci-hub.c | 60 ++++++++++++++++++++++++++++---------
 1 file changed, 46 insertions(+), 14 deletions(-)

--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -1174,13 +1174,16 @@ int xhci_bus_suspend(struct usb_hcd *hcd
 	__le32 __iomem **port_array;
 	struct xhci_bus_state *bus_state;
 	unsigned long flags;
+	u32 portsc_buf[USB_MAXCHILDREN];
+	bool wake_enabled;
 
 	max_ports = xhci_get_ports(hcd, &port_array);
 	bus_state = &xhci->bus_state[hcd_index(hcd)];
+	wake_enabled = hcd->self.root_hub->do_remote_wakeup;
 
 	spin_lock_irqsave(&xhci->lock, flags);
 
-	if (hcd->self.root_hub->do_remote_wakeup) {
+	if (wake_enabled) {
 		if (bus_state->resuming_ports ||	/* USB2 */
 		    bus_state->port_remote_wakeup) {	/* USB3 */
 			spin_unlock_irqrestore(&xhci->lock, flags);
@@ -1188,26 +1191,36 @@ int xhci_bus_suspend(struct usb_hcd *hcd
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
 
 		t1 = readl(port_array[port_index]);
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
@@ -1216,7 +1229,7 @@ int xhci_bus_suspend(struct usb_hcd *hcd
 		 * including the USB 3.0 roothub, but only if CONFIG_PM_RUNTIME
 		 * is enabled, so also enable remote wake here.
 		 */
-		if (hcd->self.root_hub->do_remote_wakeup) {
+		if (wake_enabled) {
 			if (t1 & PORT_CONNECT) {
 				t2 |= PORT_WKOC_E | PORT_WKDISC_E;
 				t2 &= ~PORT_WKCONN_E;
@@ -1232,7 +1245,26 @@ int xhci_bus_suspend(struct usb_hcd *hcd
 
 		t1 = xhci_port_state_to_neutral(t1);
 		if (t1 != t2)
-			writel(t2, port_array[port_index]);
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
+		writel(portsc_buf[port_index], port_array[port_index]);
 	}
 	hcd->state = HC_STATE_SUSPENDED;
 	bus_state->next_statechange = jiffies + msecs_to_jiffies(10);

