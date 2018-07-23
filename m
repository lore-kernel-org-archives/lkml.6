Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BA2ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1776420854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:28:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1776420854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388912AbeGWN3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:29:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45658 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387998AbeGWN3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:29:30 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 97178C19;
        Mon, 23 Jul 2018 12:28:31 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH 4.17 63/63] xhci: Fix perceived dead host due to runtime suspend race with event handler
Date:   Mon, 23 Jul 2018 14:25:09 +0200
Message-Id: <20180723122448.737717865@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723122446.351334162@linuxfoundation.org>
References: <20180723122446.351334162@linuxfoundation.org>
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

From: Mathias Nyman <mathias.nyman@linux.intel.com>

commit 229bc19fd7aca4f37964af06e3583c1c8f36b5d6 upstream.

Don't rely on event interrupt (EINT) bit alone to detect pending port
change in resume. If no change event is detected the host may be suspended
again, oterwise roothubs are resumed.

There is a lag in xHC setting EINT. If we don't notice the pending change
in resume, and the controller is runtime suspeded again, it causes the
event handler to assume host is dead as it will fail to read xHC registers
once PCI puts the controller to D3 state.

[  268.520969] xhci_hcd: xhci_resume: starting port polling.
[  268.520985] xhci_hcd: xhci_hub_status_data: stopping port polling.
[  268.521030] xhci_hcd: xhci_suspend: stopping port polling.
[  268.521040] xhci_hcd: // Setting command ring address to 0x349bd001
[  268.521139] xhci_hcd: Port Status Change Event for port 3
[  268.521149] xhci_hcd: resume root hub
[  268.521163] xhci_hcd: port resume event for port 3
[  268.521168] xhci_hcd: xHC is not running.
[  268.521174] xhci_hcd: handle_port_status: starting port polling.
[  268.596322] xhci_hcd: xhci_hc_died: xHCI host controller not responding, assume dead

The EINT lag is described in a additional note in xhci specs 4.19.2:

"Due to internal xHC scheduling and system delays, there will be a lag
between a change bit being set and the Port Status Change Event that it
generated being written to the Event Ring. If SW reads the PORTSC and
sees a change bit set, there is no guarantee that the corresponding Port
Status Change Event has already been written into the Event Ring."

Cc: <stable@vger.kernel.org>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/xhci.c |   40 +++++++++++++++++++++++++++++++++++++---
 drivers/usb/host/xhci.h |    4 ++++
 2 files changed, 41 insertions(+), 3 deletions(-)

--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -844,6 +844,41 @@ static void xhci_disable_port_wake_on_bi
 	spin_unlock_irqrestore(&xhci->lock, flags);
 }
 
+static bool xhci_pending_portevent(struct xhci_hcd *xhci)
+{
+	__le32 __iomem		**port_array;
+	int			port_index;
+	u32			status;
+	u32			portsc;
+
+	status = readl(&xhci->op_regs->status);
+	if (status & STS_EINT)
+		return true;
+	/*
+	 * Checking STS_EINT is not enough as there is a lag between a change
+	 * bit being set and the Port Status Change Event that it generated
+	 * being written to the Event Ring. See note in xhci 1.1 section 4.19.2.
+	 */
+
+	port_index = xhci->num_usb2_ports;
+	port_array = xhci->usb2_ports;
+	while (port_index--) {
+		portsc = readl(port_array[port_index]);
+		if (portsc & PORT_CHANGE_MASK ||
+		    (portsc & PORT_PLS_MASK) == XDEV_RESUME)
+			return true;
+	}
+	port_index = xhci->num_usb3_ports;
+	port_array = xhci->usb3_ports;
+	while (port_index--) {
+		portsc = readl(port_array[port_index]);
+		if (portsc & PORT_CHANGE_MASK ||
+		    (portsc & PORT_PLS_MASK) == XDEV_RESUME)
+			return true;
+	}
+	return false;
+}
+
 /*
  * Stop HC (not bus-specific)
  *
@@ -945,7 +980,7 @@ EXPORT_SYMBOL_GPL(xhci_suspend);
  */
 int xhci_resume(struct xhci_hcd *xhci, bool hibernated)
 {
-	u32			command, temp = 0, status;
+	u32			command, temp = 0;
 	struct usb_hcd		*hcd = xhci_to_hcd(xhci);
 	struct usb_hcd		*secondary_hcd;
 	int			retval = 0;
@@ -1069,8 +1104,7 @@ int xhci_resume(struct xhci_hcd *xhci, b
  done:
 	if (retval == 0) {
 		/* Resume root hubs only when have pending events. */
-		status = readl(&xhci->op_regs->status);
-		if (status & STS_EINT) {
+		if (xhci_pending_portevent(xhci)) {
 			usb_hcd_resume_root_hub(xhci->shared_hcd);
 			usb_hcd_resume_root_hub(hcd);
 		}
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -382,6 +382,10 @@ struct xhci_op_regs {
 #define PORT_PLC	(1 << 22)
 /* port configure error change - port failed to configure its link partner */
 #define PORT_CEC	(1 << 23)
+#define PORT_CHANGE_MASK	(PORT_CSC | PORT_PEC | PORT_WRC | PORT_OCC | \
+				 PORT_RC | PORT_PLC | PORT_CEC)
+
+
 /* Cold Attach Status - xHC can set this bit to report device attached during
  * Sx state. Warm port reset should be perfomed to clear this bit and move port
  * to connected state.


