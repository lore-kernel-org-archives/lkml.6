Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7DDC65BBF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 22:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFF6B208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 22:18:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFF6B208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbeJFFSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 01:18:51 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:36928 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbeJFFSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 01:18:51 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id B9F09C29D6;
        Fri,  5 Oct 2018 22:18:05 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo01-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7jO72bWBMkD1; Fri,  5 Oct 2018 22:18:05 +0000 (UTC)
Received: from localhost.localdomain (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 341CBC299A;
        Fri,  5 Oct 2018 22:17:56 +0000 (UTC)
From:   "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
To:     shuah@kernel.org, gregkh@linuxfoundation.org,
        valentina.manea.m@gmail.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: usbip: Fix BUG: KASAN: slab-out-of-bounds in vhci_hub_control()
Date:   Fri,  5 Oct 2018 16:17:44 -0600
Message-Id: <20181005221744.21605-2-shuah@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005221744.21605-1-shuah@kernel.org>
References: <20181005221744.21605-1-shuah@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vhci_hub_control() accesses port_status array with out of bounds port
value. Fix it to reference port_status[] only with a valid rhport value
when invalid_rhport flag is true.

The invalid_rhport flag is set early on after detecting in port value
is within the bounds or not.

The following is used reproduce the problem and verify the fix:
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14ed8ab6400000

Reported-by: syzbot+bccc1fe10b70fadc78d0@syzkaller.appspotmail.com
Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
---
 drivers/usb/usbip/vhci_hcd.c | 57 ++++++++++++++++++++++++++----------
 1 file changed, 42 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index d11f3f8dad40..1e592ec94ba4 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -318,8 +318,9 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 	struct vhci_hcd	*vhci_hcd;
 	struct vhci	*vhci;
 	int             retval = 0;
-	int		rhport;
+	int		rhport = -1;
 	unsigned long	flags;
+	bool invalid_rhport = false;
 
 	u32 prev_port_status[VHCI_HC_PORTS];
 
@@ -334,9 +335,19 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 	usbip_dbg_vhci_rh("typeReq %x wValue %x wIndex %x\n", typeReq, wValue,
 			  wIndex);
 
-	if (wIndex > VHCI_HC_PORTS)
-		pr_err("invalid port number %d\n", wIndex);
-	rhport = wIndex - 1;
+	/*
+	 * wIndex can be 0 for some request types (typeReq). rhport is
+	 * in valid range when wIndex >= 1 and < VHCI_HC_PORTS.
+	 *
+	 * Reference port_status[] only with valid rhport when
+	 * invalid_rhport is false.
+	 */
+	if (wIndex < 1 || wIndex > VHCI_HC_PORTS) {
+		invalid_rhport = true;
+		if (wIndex > VHCI_HC_PORTS)
+			pr_err("invalid port number %d\n", wIndex);
+	} else
+		rhport = wIndex - 1;
 
 	vhci_hcd = hcd_to_vhci_hcd(hcd);
 	vhci = vhci_hcd->vhci;
@@ -345,8 +356,9 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 
 	/* store old status and compare now and old later */
 	if (usbip_dbg_flag_vhci_rh) {
-		memcpy(prev_port_status, vhci_hcd->port_status,
-			sizeof(prev_port_status));
+		if (!invalid_rhport)
+			memcpy(prev_port_status, vhci_hcd->port_status,
+				sizeof(prev_port_status));
 	}
 
 	switch (typeReq) {
@@ -354,8 +366,10 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 		usbip_dbg_vhci_rh(" ClearHubFeature\n");
 		break;
 	case ClearPortFeature:
-		if (rhport < 0)
+		if (invalid_rhport) {
+			pr_err("invalid port number %d\n", wIndex);
 			goto error;
+		}
 		switch (wValue) {
 		case USB_PORT_FEAT_SUSPEND:
 			if (hcd->speed == HCD_USB3) {
@@ -415,9 +429,10 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 		break;
 	case GetPortStatus:
 		usbip_dbg_vhci_rh(" GetPortStatus port %x\n", wIndex);
-		if (wIndex < 1) {
+		if (invalid_rhport) {
 			pr_err("invalid port number %d\n", wIndex);
 			retval = -EPIPE;
+			goto error;
 		}
 
 		/* we do not care about resume. */
@@ -513,16 +528,20 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 				goto error;
 			}
 
-			if (rhport < 0)
+			if (invalid_rhport) {
+				pr_err("invalid port number %d\n", wIndex);
 				goto error;
+			}
 
 			vhci_hcd->port_status[rhport] |= USB_PORT_STAT_SUSPEND;
 			break;
 		case USB_PORT_FEAT_POWER:
 			usbip_dbg_vhci_rh(
 				" SetPortFeature: USB_PORT_FEAT_POWER\n");
-			if (rhport < 0)
+			if (invalid_rhport) {
+				pr_err("invalid port number %d\n", wIndex);
 				goto error;
+			}
 			if (hcd->speed == HCD_USB3)
 				vhci_hcd->port_status[rhport] |= USB_SS_PORT_STAT_POWER;
 			else
@@ -531,8 +550,10 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 		case USB_PORT_FEAT_BH_PORT_RESET:
 			usbip_dbg_vhci_rh(
 				" SetPortFeature: USB_PORT_FEAT_BH_PORT_RESET\n");
-			if (rhport < 0)
+			if (invalid_rhport) {
+				pr_err("invalid port number %d\n", wIndex);
 				goto error;
+			}
 			/* Applicable only for USB3.0 hub */
 			if (hcd->speed != HCD_USB3) {
 				pr_err("USB_PORT_FEAT_BH_PORT_RESET req not "
@@ -543,8 +564,10 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 		case USB_PORT_FEAT_RESET:
 			usbip_dbg_vhci_rh(
 				" SetPortFeature: USB_PORT_FEAT_RESET\n");
-			if (rhport < 0)
+			if (invalid_rhport) {
+				pr_err("invalid port number %d\n", wIndex);
 				goto error;
+			}
 			/* if it's already enabled, disable */
 			if (hcd->speed == HCD_USB3) {
 				vhci_hcd->port_status[rhport] = 0;
@@ -565,8 +588,10 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 		default:
 			usbip_dbg_vhci_rh(" SetPortFeature: default %d\n",
 					  wValue);
-			if (rhport < 0)
+			if (invalid_rhport) {
+				pr_err("invalid port number %d\n", wIndex);
 				goto error;
+			}
 			if (hcd->speed == HCD_USB3) {
 				if ((vhci_hcd->port_status[rhport] &
 				     USB_SS_PORT_STAT_POWER) != 0) {
@@ -608,7 +633,7 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 	if (usbip_dbg_flag_vhci_rh) {
 		pr_debug("port %d\n", rhport);
 		/* Only dump valid port status */
-		if (rhport >= 0) {
+		if (!invalid_rhport) {
 			dump_port_status_diff(prev_port_status[rhport],
 					      vhci_hcd->port_status[rhport],
 					      hcd->speed == HCD_USB3);
@@ -618,8 +643,10 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 
 	spin_unlock_irqrestore(&vhci->lock, flags);
 
-	if ((vhci_hcd->port_status[rhport] & PORT_C_MASK) != 0)
+	if (!invalid_rhport &&
+	    (vhci_hcd->port_status[rhport] & PORT_C_MASK) != 0) {
 		usb_hcd_poll_rh_status(hcd);
+	}
 
 	return retval;
 }
-- 
2.17.0

