Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D07C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8E6C213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVAsgUe5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8E6C213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732977AbeK3Ba4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:30:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:58224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731601AbeK3Baz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:30:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C42A0205C9;
        Thu, 29 Nov 2018 14:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501523;
        bh=sa41xx+QN/cRI6ajeSa6LxtjAH26uIkBZAvQ1hQNDyg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MVAsgUe5tfvNXrhPukIrGXZD7IofIqWVx1te14tyJWkT9NehIJTdrE6TzHo7Gn+N0
         6HrdjIlGBhNcSlS+gI6tNrv0hRtn6SgyFhpRC+wQ8lH2jXS76tGiA65yVFFQGdyqg/
         OdaysiUhz4r6PzfuOwpT6L7DmH5Rer9cSrXY8LcI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 4.14 032/100] usb: xhci: Prevent bus suspend if a port connect change or polling state is detected
Date:   Thu, 29 Nov 2018 15:12:02 +0100
Message-Id: <20181129140101.578328748@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140058.768942700@linuxfoundation.org>
References: <20181129140058.768942700@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1481,13 +1481,16 @@ int xhci_bus_suspend(struct usb_hcd *hcd
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
@@ -1495,26 +1498,36 @@ int xhci_bus_suspend(struct usb_hcd *hcd
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
@@ -1523,7 +1536,7 @@ int xhci_bus_suspend(struct usb_hcd *hcd
 		 * including the USB 3.0 roothub, but only if CONFIG_PM
 		 * is enabled, so also enable remote wake here.
 		 */
-		if (hcd->self.root_hub->do_remote_wakeup) {
+		if (wake_enabled) {
 			if (t1 & PORT_CONNECT) {
 				t2 |= PORT_WKOC_E | PORT_WKDISC_E;
 				t2 &= ~PORT_WKCONN_E;
@@ -1543,7 +1556,26 @@ int xhci_bus_suspend(struct usb_hcd *hcd
 
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


