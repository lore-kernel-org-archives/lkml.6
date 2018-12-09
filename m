Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99207C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6973220837
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:57:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6973220837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbeLIVzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 16:55:42 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35394 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726545AbeLIVzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:24 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72n-0002pp-K7; Sun, 09 Dec 2018 21:55:21 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72l-0003g3-0x; Sun, 09 Dec 2018 21:55:19 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Shuah Khan (Samsung OSG)" <shuah@kernel.org>,
        syzbot+bccc1fe10b70fadc78d0@syzkaller.appspotmail.com,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.725643657@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 305/328] usb: usbip: Fix BUG: KASAN: slab-out-of-bounds
 in vhci_hub_control()
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Shuah Khan (Samsung OSG)" <shuah@kernel.org>

commit 81f7567c51ad97668d1c3a48e8ecc482e64d4161 upstream.

vhci_hub_control() accesses port_status array with out of bounds port
value. Fix it to reference port_status[] only with a valid rhport value
when invalid_rhport flag is true.

The invalid_rhport flag is set early on after detecting in port value
is within the bounds or not.

The following is used reproduce the problem and verify the fix:
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14ed8ab6400000

Reported-by: syzbot+bccc1fe10b70fadc78d0@syzkaller.appspotmail.com
Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16:
 - s/VHCI_HC_PORTS/VHCI_NPORTS/
 - Mask wIndex before using it, as done upstream in commit 1c9de5bf4286
   "usbip: vhci-hcd: Add USB3 SuperSpeed support"
 - Drop inapplicable changes
 - Adjust filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/staging/usbip/vhci_hcd.c
+++ b/drivers/staging/usbip/vhci_hcd.c
@@ -234,7 +234,8 @@ static int vhci_hub_control(struct usb_h
 {
 	struct vhci_hcd	*dum;
 	int             retval = 0;
-	int		rhport;
+	int		rhport = -1;
+	bool invalid_rhport = false;
 
 	u32 prev_port_status[VHCI_NPORTS];
 
@@ -245,11 +246,23 @@ static int vhci_hub_control(struct usb_h
 	 * NOTE:
 	 * wIndex shows the port number and begins from 1.
 	 */
+	wIndex = ((__u8)(wIndex & 0x00ff));
 	usbip_dbg_vhci_rh("typeReq %x wValue %x wIndex %x\n", typeReq, wValue,
 			  wIndex);
-	if (wIndex > VHCI_NPORTS)
-		pr_err("invalid port number %d\n", wIndex);
-	rhport = ((__u8)(wIndex & 0x00ff)) - 1;
+
+	/*
+	 * wIndex can be 0 for some request types (typeReq). rhport is
+	 * in valid range when wIndex >= 1 and < VHCI_HC_PORTS.
+	 *
+	 * Reference port_status[] only with valid rhport when
+	 * invalid_rhport is false.
+	 */
+	if (wIndex < 1 || wIndex > VHCI_NPORTS) {
+		invalid_rhport = true;
+		if (wIndex > VHCI_NPORTS)
+			pr_err("invalid port number %d\n", wIndex);
+	} else
+		rhport = wIndex - 1;
 
 	dum = hcd_to_vhci(hcd);
 
@@ -257,8 +270,9 @@ static int vhci_hub_control(struct usb_h
 
 	/* store old status and compare now and old later */
 	if (usbip_dbg_flag_vhci_rh) {
-		memcpy(prev_port_status, dum->port_status,
-			sizeof(prev_port_status));
+		if (!invalid_rhport)
+			memcpy(prev_port_status, dum->port_status,
+				sizeof(prev_port_status));
 	}
 
 	switch (typeReq) {
@@ -266,8 +280,10 @@ static int vhci_hub_control(struct usb_h
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
 			if (dum->port_status[rhport] & USB_PORT_STAT_SUSPEND) {
@@ -315,9 +331,10 @@ static int vhci_hub_control(struct usb_h
 		break;
 	case GetPortStatus:
 		usbip_dbg_vhci_rh(" GetPortStatus port %x\n", wIndex);
-		if (wIndex > VHCI_NPORTS || wIndex < 1) {
+		if (invalid_rhport) {
 			pr_err("invalid port number %d\n", wIndex);
 			retval = -EPIPE;
+			goto error;
 		}
 
 		/* we do not care about resume. */
@@ -372,8 +389,10 @@ static int vhci_hub_control(struct usb_h
 		case USB_PORT_FEAT_RESET:
 			usbip_dbg_vhci_rh(
 				" SetPortFeature: USB_PORT_FEAT_RESET\n");
-			if (rhport < 0)
+			if (invalid_rhport) {
+				pr_err("invalid port number %d\n", wIndex);
 				goto error;
+			}
 			/* if it's already running, disconnect first */
 			if (dum->port_status[rhport] & USB_PORT_STAT_ENABLE) {
 				dum->port_status[rhport] &=
@@ -389,8 +408,10 @@ static int vhci_hub_control(struct usb_h
 		default:
 			usbip_dbg_vhci_rh(" SetPortFeature: default %d\n",
 					  wValue);
-			if (rhport < 0)
+			if (invalid_rhport) {
+				pr_err("invalid port number %d\n", wIndex);
 				goto error;
+			}
 			dum->port_status[rhport] |= (1 << wValue);
 			break;
 		}
@@ -406,7 +427,7 @@ error:
 	if (usbip_dbg_flag_vhci_rh) {
 		pr_debug("port %d\n", rhport);
 		/* Only dump valid port status */
-		if (rhport >= 0) {
+		if (!invalid_rhport) {
 			dump_port_status_diff(prev_port_status[rhport],
 					      dum->port_status[rhport]);
 		}

