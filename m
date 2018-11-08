Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E07ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE0BE2148E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7YBj8k3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE0BE2148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732702AbeKIHqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:46:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:39900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731252AbeKIHqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:46:10 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E9CA20989;
        Thu,  8 Nov 2018 22:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714917;
        bh=dvhuCKYoaWQThf4untb1SkYA2WbDjv238oq21zD9ETc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W7YBj8k3G8ppxCpDzkcMgimHXMPcsyjcCDifvhPWSdIYFVB+T74SFTDColOiwmTAf
         JLeF2Pmd3Tp0+aEDUQge+y05doOXfUmtp6uWEkPuVyr2ZbUybm+lIMFPTKHoTJt8u+
         osLqFTVKoHy+7GwlQcqyXy/9zHN5II/k5wlLTlIU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+bccc1fe10b70fadc78d0@syzkaller.appspotmail.com,
        "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
Subject: [PATCH 4.14 21/31] usb: usbip: Fix BUG: KASAN: slab-out-of-bounds in vhci_hub_control()
Date:   Thu,  8 Nov 2018 13:52:45 -0800
Message-Id: <20181108215131.435297475@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215129.641434673@linuxfoundation.org>
References: <20181108215129.641434673@linuxfoundation.org>
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

From: Shuah Khan (Samsung OSG) <shuah@kernel.org>

commit 81f7567c51ad97668d1c3a48e8ecc482e64d4161 upstream.

vhci_hub_control() accesses port_status array with out of bounds port
value. Fix it to reference port_status[] only with a valid rhport value
when invalid_rhport flag is true.

The invalid_rhport flag is set early on after detecting in port value
is within the bounds or not.

The following is used reproduce the problem and verify the fix:
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14ed8ab6400000

Reported-by: syzbot+bccc1fe10b70fadc78d0@syzkaller.appspotmail.com
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/usbip/vhci_hcd.c |   57 +++++++++++++++++++++++++++++++------------
 1 file changed, 42 insertions(+), 15 deletions(-)

--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -332,8 +332,9 @@ static int vhci_hub_control(struct usb_h
 	struct vhci_hcd	*vhci_hcd;
 	struct vhci	*vhci;
 	int             retval = 0;
-	int		rhport;
+	int		rhport = -1;
 	unsigned long	flags;
+	bool invalid_rhport = false;
 
 	u32 prev_port_status[VHCI_HC_PORTS];
 
@@ -348,9 +349,19 @@ static int vhci_hub_control(struct usb_h
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
@@ -359,8 +370,9 @@ static int vhci_hub_control(struct usb_h
 
 	/* store old status and compare now and old later */
 	if (usbip_dbg_flag_vhci_rh) {
-		memcpy(prev_port_status, vhci_hcd->port_status,
-			sizeof(prev_port_status));
+		if (!invalid_rhport)
+			memcpy(prev_port_status, vhci_hcd->port_status,
+				sizeof(prev_port_status));
 	}
 
 	switch (typeReq) {
@@ -368,8 +380,10 @@ static int vhci_hub_control(struct usb_h
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
@@ -429,9 +443,10 @@ static int vhci_hub_control(struct usb_h
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
@@ -527,16 +542,20 @@ static int vhci_hub_control(struct usb_h
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
@@ -545,8 +564,10 @@ static int vhci_hub_control(struct usb_h
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
@@ -557,8 +578,10 @@ static int vhci_hub_control(struct usb_h
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
@@ -579,8 +602,10 @@ static int vhci_hub_control(struct usb_h
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
@@ -622,7 +647,7 @@ error:
 	if (usbip_dbg_flag_vhci_rh) {
 		pr_debug("port %d\n", rhport);
 		/* Only dump valid port status */
-		if (rhport >= 0) {
+		if (!invalid_rhport) {
 			dump_port_status_diff(prev_port_status[rhport],
 					      vhci_hcd->port_status[rhport],
 					      hcd->speed == HCD_USB3);
@@ -632,8 +657,10 @@ error:
 
 	spin_unlock_irqrestore(&vhci->lock, flags);
 
-	if ((vhci_hcd->port_status[rhport] & PORT_C_MASK) != 0)
+	if (!invalid_rhport &&
+	    (vhci_hcd->port_status[rhport] & PORT_C_MASK) != 0) {
 		usb_hcd_poll_rh_status(hcd);
+	}
 
 	return retval;
 }


