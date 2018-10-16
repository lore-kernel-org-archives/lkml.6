Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11F4C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67F192098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bv7wJGY9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67F192098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730913AbeJQBM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:12:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:58594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729207AbeJQBM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:12:56 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6A5E2098A;
        Tue, 16 Oct 2018 17:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710491;
        bh=KBBg/pwq/cHPduqYJg2e7WH/ar/jgz9Gxg0cvFHa4Ak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bv7wJGY9dQGwJ8thJwo3YO3buNf/NYJZ3QgMF6BoHfTLx5IGZmingwhzE+f1yZLBu
         jouycfgw6cFMb+EQGomThsmPZN1kF0A8rKc4BUq3NUlo3zvXpqRr8mRSHvayp9qJs3
         PrU2KKzNWAVbQdvuSzaOqfdFQzXSqDL93tUb5tSQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Ross Zwisler <zwisler@google.com>
Subject: [PATCH 4.14 079/109] xhci: Dont print a warning when setting link state for disabled ports
Date:   Tue, 16 Oct 2018 19:05:47 +0200
Message-Id: <20181016170529.224364265@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170524.530541524@linuxfoundation.org>
References: <20181016170524.530541524@linuxfoundation.org>
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

commit 1208d8a84fdcae6b395c57911cdf907450d30e70 upstream.

When disabling a USB3 port the hub driver will set the port link state to
U3 to prevent "ejected" or "safely removed" devices that are still
physically connected from immediately re-enumerating.

If the device was really unplugged, then error messages were printed
as the hub tries to set the U3 link state for a port that is no longer
enabled.

xhci-hcd ee000000.usb: Cannot set link state.
usb usb8-port1: cannot disable (err = -32)

Don't print error message in xhci-hub if hub tries to set port link state
for a disabled port. Return -ENODEV instead which also silences hub driver.

Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Ross Zwisler <zwisler@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/xhci-hub.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -1236,17 +1236,17 @@ int xhci_hub_control(struct usb_hcd *hcd
 				temp = readl(port_array[wIndex]);
 				break;
 			}
-
-			/* Software should not attempt to set
-			 * port link state above '3' (U3) and the port
-			 * must be enabled.
-			 */
-			if ((temp & PORT_PE) == 0 ||
-				(link_state > USB_SS_PORT_LS_U3)) {
-				xhci_warn(xhci, "Cannot set link state.\n");
+			/* Port must be enabled */
+			if (!(temp & PORT_PE)) {
+				retval = -ENODEV;
+				break;
+			}
+			/* Can't set port link state above '3' (U3) */
+			if (link_state > USB_SS_PORT_LS_U3) {
+				xhci_warn(xhci, "Cannot set port %d link state %d\n",
+					 wIndex, link_state);
 				goto error;
 			}
-
 			if (link_state == USB_SS_PORT_LS_U3) {
 				slot_id = xhci_find_slot_id_by_port(hcd, xhci,
 						wIndex + 1);


