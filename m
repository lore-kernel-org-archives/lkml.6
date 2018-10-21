Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57149ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 17:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FA1C204EC
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 17:09:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FA1C204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbeJVBX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 21:23:56 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58563 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbeJVBXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 21:23:55 -0400
Received: from [111.196.56.27] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <aaron.ma@canonical.com>)
        id 1gEHDj-0005bZ-0C; Sun, 21 Oct 2018 17:08:55 +0000
From:   Aaron Ma <aaron.ma@canonical.com>
To:     aaron.ma@canonical.com, mathias.nyman@intel.com,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] usb: xhci: fix uninitialized completion when USB3 port got wrong status
Date:   Mon, 22 Oct 2018 01:08:44 +0800
Message-Id: <1540141725-13047-1-git-send-email-aaron.ma@canonical.com>
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
No harm to initialize USB3 bus_state[0] in case it is called.

Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
 drivers/usb/host/xhci-hub.c  | 2 +-
 drivers/usb/host/xhci-mem.c  | 1 +
 drivers/usb/host/xhci-ring.c | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index 7e2a531ba321..d30ca6ceffc9 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -876,7 +876,7 @@ static u32 xhci_get_port_status(struct usb_hcd *hcd,
 			status |= USB_PORT_STAT_SUSPEND;
 	}
 	if ((raw_port_status & PORT_PLS_MASK) == XDEV_RESUME &&
-		!DEV_SUPERSPEED_ANY(raw_port_status)) {
+		!DEV_SUPERSPEED_ANY(raw_port_status) && 1 == hcd_index(hcd)) {
 		if ((raw_port_status & PORT_RESET) ||
 				!(raw_port_status & PORT_PE))
 			return 0xffffffff;
diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index b1f27aa38b10..dd2ad50c5289 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -2539,6 +2539,7 @@ int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags)
 		xhci->bus_state[0].resume_done[i] = 0;
 		xhci->bus_state[1].resume_done[i] = 0;
 		/* Only the USB 2.0 completions will ever be used. */
+		init_completion(&xhci->bus_state[0].rexit_done[i]);
 		init_completion(&xhci->bus_state[1].rexit_done[i]);
 	}
 
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index f0a99aa0ac58..894d4625b8b9 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1634,7 +1634,7 @@ static void handle_port_status(struct xhci_hcd *xhci,
 	 * RExit to a disconnect state).  If so, let the the driver know it's
 	 * out of the RExit state.
 	 */
-	if (!DEV_SUPERSPEED_ANY(portsc) &&
+	if (!DEV_SUPERSPEED_ANY(portsc) && 1 == hcd_index(hcd) &&
 			test_and_clear_bit(hcd_portnum,
 				&bus_state->rexit_ports)) {
 		complete(&bus_state->rexit_done[hcd_portnum]);
-- 
2.19.1

