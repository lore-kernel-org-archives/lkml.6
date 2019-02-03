Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B82C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 802A1218D8
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbfBCNyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 08:54:46 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:54470 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728595AbfBCNym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:54:42 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIEK-0003te-8x; Sun, 03 Feb 2019 13:54:40 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9r-0007Oo-Im; Sun, 03 Feb 2019 14:50:03 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Mathias Nyman" <mathias.nyman@linux.intel.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.374541494@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 269/305] xhci: Prevent U1/U2 link pm states if exit
 latency is too long
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

commit 0472bf06c6fd33c1a18aaead4c8f91e5a03d8d7b upstream.

Don't allow USB3 U1 or U2 if the latency to wake up from the U-state
reaches the service interval for a periodic endpoint.

This is according to xhci 1.1 specification section 4.23.5.2 extra note:

"Software shall ensure that a device is prevented from entering a U-state
 where its worst case exit latency approaches the ESIT."

Allowing too long exit latencies for periodic endpoint confuses xHC
internal scheduling, and new devices may fail to enumerate with a
"Not enough bandwidth for new device state" error from the host.

Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16: adjust context, indentation]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/host/xhci.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -4466,9 +4466,25 @@ static u16 xhci_call_host_update_timeout
 		u16 *timeout)
 {
 	if (state == USB3_LPM_U1) {
+		/* Prevent U1 if service interval is shorter than U1 exit latency */
+		if (usb_endpoint_xfer_int(desc) || usb_endpoint_xfer_isoc(desc)) {
+			if (xhci_service_interval_to_ns(desc) <= udev->u1_params.mel) {
+				dev_dbg(&udev->dev, "Disable U1, ESIT shorter than exit latency\n");
+				return USB3_LPM_DISABLED;
+			}
+		}
+
 		if (xhci->quirks & XHCI_INTEL_HOST)
 			return xhci_calculate_intel_u1_timeout(udev, desc);
 	} else {
+		/* Prevent U2 if service interval is shorter than U2 exit latency */
+		if (usb_endpoint_xfer_int(desc) || usb_endpoint_xfer_isoc(desc)) {
+			if (xhci_service_interval_to_ns(desc) <= udev->u2_params.mel) {
+				dev_dbg(&udev->dev, "Disable U2, ESIT shorter than exit latency\n");
+				return USB3_LPM_DISABLED;
+			}
+		}
+
 		if (xhci->quirks & XHCI_INTEL_HOST)
 			return xhci_calculate_intel_u2_timeout(udev, desc);
 	}

