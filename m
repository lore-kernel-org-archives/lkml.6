Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87EDC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 867692084A
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730937AbfBCOZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:25:10 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55720 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730417AbfBCOVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:21:14 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIe0-0006PG-OU; Sun, 03 Feb 2019 14:21:12 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9h-0007D3-Mm; Sun, 03 Feb 2019 14:49:53 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Mathias Nyman" <mathias.nyman@linux.intel.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Dennis Wassenberg" <dennis.wassenberg@secunet.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.917262800@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 202/305] usb: core: Fix hub port connection events lost
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

From: Dennis Wassenberg <dennis.wassenberg@secunet.com>

commit 22454b79e6de05fa61a2a72d00d2eed798abbb75 upstream.

This will clear the USB_PORT_FEAT_C_CONNECTION bit in case of a hub port reset
only if a device is was attached to the hub port before resetting the hub port.

Using a Lenovo T480s attached to the ultra dock it was not possible to detect
some usb-c devices at the dock usb-c ports because the hub_port_reset code
will clear the USB_PORT_FEAT_C_CONNECTION bit after the actual hub port reset.
Using this device combo the USB_PORT_FEAT_C_CONNECTION bit was set between the
actual hub port reset and the clear of the USB_PORT_FEAT_C_CONNECTION bit.
This ends up with clearing the USB_PORT_FEAT_C_CONNECTION bit after the
new device was attached such that it was not detected.

This patch will not clear the USB_PORT_FEAT_C_CONNECTION bit if there is
currently no device attached to the port before the hub port reset.
This will avoid clearing the connection bit for new attached devices.

Signed-off-by: Dennis Wassenberg <dennis.wassenberg@secunet.com>
Acked-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/core/hub.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2725,7 +2725,9 @@ static int hub_port_reset(struct usb_hub
 					USB_PORT_FEAT_C_BH_PORT_RESET);
 			usb_clear_port_feature(hub->hdev, port1,
 					USB_PORT_FEAT_C_PORT_LINK_STATE);
-			usb_clear_port_feature(hub->hdev, port1,
+
+			if (udev)
+				usb_clear_port_feature(hub->hdev, port1,
 					USB_PORT_FEAT_C_CONNECTION);
 
 			/*

