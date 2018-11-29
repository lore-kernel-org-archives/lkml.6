Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34C3C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E1732145D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ys1U5qjS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E1732145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388122AbeK3BeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:34:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:35140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731958AbeK3BeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:34:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CCD021479;
        Thu, 29 Nov 2018 14:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501714;
        bh=+S7wsRgb91DyrrJi3Q/BL7r/ZfcIEWV1aqFTTyLkUoM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ys1U5qjSY240rOiD9xeH+GcqNL6FiJEFk2XcwRCNxL4jDjJPxgCilLyaKtXppEMir
         VccadBJWIkkVY6oKmQkubTp6XODwdUOXo3HYFKuFsbbRxrQQ50rA292QHpVRB0P9Fk
         2GGOJ4FSHhL46d+y+MzP5aHVY9Yx1IWtpWIY/4Us=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aaron Ma <aaron.ma@canonical.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 4.19 011/110] usb: xhci: fix uninitialized completion when USB3 port got wrong status
Date:   Thu, 29 Nov 2018 15:11:42 +0100
Message-Id: <20181129135921.699733671@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129135921.231283053@linuxfoundation.org>
References: <20181129135921.231283053@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aaron Ma <aaron.ma@canonical.com>

commit 958c0bd86075d4ef1c936998deefe1947e539240 upstream.

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
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/xhci-hub.c  |    2 +-
 drivers/usb/host/xhci-ring.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -876,7 +876,7 @@ static u32 xhci_get_port_status(struct u
 			status |= USB_PORT_STAT_SUSPEND;
 	}
 	if ((raw_port_status & PORT_PLS_MASK) == XDEV_RESUME &&
-		!DEV_SUPERSPEED_ANY(raw_port_status)) {
+		!DEV_SUPERSPEED_ANY(raw_port_status) && hcd->speed < HCD_USB3) {
 		if ((raw_port_status & PORT_RESET) ||
 				!(raw_port_status & PORT_PE))
 			return 0xffffffff;
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1642,7 +1642,7 @@ static void handle_port_status(struct xh
 	 * RExit to a disconnect state).  If so, let the the driver know it's
 	 * out of the RExit state.
 	 */
-	if (!DEV_SUPERSPEED_ANY(portsc) &&
+	if (!DEV_SUPERSPEED_ANY(portsc) && hcd->speed < HCD_USB3 &&
 			test_and_clear_bit(hcd_portnum,
 				&bus_state->rexit_ports)) {
 		complete(&bus_state->rexit_done[hcd_portnum]);


