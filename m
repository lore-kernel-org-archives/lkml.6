Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D781C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 17:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E511820652
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 17:43:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E511820652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbeJWCCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 22:02:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51630 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727330AbeJWCCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 22:02:37 -0400
Received: from [111.196.56.27] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <aaron.ma@canonical.com>)
        id 1gEeEN-0006T5-3c; Mon, 22 Oct 2018 17:43:07 +0000
From:   Aaron Ma <aaron.ma@canonical.com>
To:     aaron.ma@canonical.com, mathias.nyman@intel.com,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] usb: xhci: fix uninitialized completion when USB3 port got wrong status
Date:   Tue, 23 Oct 2018 01:42:46 +0800
Message-Id: <1540230167-12528-1-git-send-email-aaron.ma@canonical.com>
X-Mailer: git-send-email 1.8.5.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Realtek USB3.0 Card Reader [0bda:0328] reports wrong port status on
Cannon lake PCH USB3.1 xHCI [8086:a36d] after resume from S3,
after clear port reset it works fine.

Since this device is registered on USB3 roothub at boot,
when port status reports not superspeed, xhci_get_port_status will call
an uninitialized completion in bus_state[0].
Kernel will hang because of NULL pointer.

Restrict the USB2 resume status check in USB2 roothub to fix hang issue.

Cc: stable@vger.kernel.org
Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
 drivers/usb/host/xhci-hub.c  | 2 +-
 drivers/usb/host/xhci-ring.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index 7e2a531ba321..56a08daa7431 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -876,7 +876,7 @@ static u32 xhci_get_port_status(struct usb_hcd *hcd,
 			status |= USB_PORT_STAT_SUSPEND;
 	}
 	if ((raw_port_status & PORT_PLS_MASK) == XDEV_RESUME &&
-		!DEV_SUPERSPEED_ANY(raw_port_status)) {
+		!DEV_SUPERSPEED_ANY(raw_port_status) && hcd->speed < HCD_USB3) {
 		if ((raw_port_status & PORT_RESET) ||
 				!(raw_port_status & PORT_PE))
 			return 0xffffffff;
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index f0a99aa0ac58..7318fc422b6c 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1634,7 +1634,7 @@ static void handle_port_status(struct xhci_hcd *xhci,
 	 * RExit to a disconnect state).  If so, let the the driver know it's
 	 * out of the RExit state.
 	 */
-	if (!DEV_SUPERSPEED_ANY(portsc) &&
+	if (!DEV_SUPERSPEED_ANY(portsc) && hcd->speed < HCD_USB3 &&
 			test_and_clear_bit(hcd_portnum,
 				&bus_state->rexit_ports)) {
 		complete(&bus_state->rexit_done[hcd_portnum]);
-- 
2.19.1

