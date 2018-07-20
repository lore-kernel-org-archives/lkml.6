Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5795CECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1484520652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:39:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1484520652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389537AbeGTN1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:27:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48018 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388500AbeGTN1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:27:18 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C003BC19;
        Fri, 20 Jul 2018 12:35:28 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jordan Glover <Golden_Miller83@protonmail.ch>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4.14 53/92] xhci: Fix USB3 NULL pointer dereference at logical disconnect.
Date:   Fri, 20 Jul 2018 14:13:57 +0200
Message-Id: <20180720121421.025671627@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121417.206337808@linuxfoundation.org>
References: <20180720121417.206337808@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mathias Nyman <mathias.nyman@linux.intel.com>

commit 2278446e2b7cd33ad894b32e7eb63afc7db6c86e upstream.

Hub driver will try to disable a USB3 device twice at logical disconnect,
racing with xhci_free_dev() callback from the first port disable.

This can be triggered with "udisksctl power-off --block-device <disk>"
or by writing "1" to the "remove" sysfs file for a USB3 device
in 4.17-rc4.

USB3 devices don't have a similar disabled link state as USB2 devices,
and use a U3 suspended link state instead. In this state the port
is still enabled and connected.

hub_port_connect() first disconnects the device, then later it notices
that device is still enabled (due to U3 states) it will try to disable
the port again (set to U3).

The xhci_free_dev() called during device disable is async, so checking
for existing xhci->devs[i] when setting link state to U3 the second time
was successful, even if device was being freed.

The regression was caused by, and whole thing revealed by,
Commit 44a182b9d177 ("xhci: Fix use-after-free in xhci_free_virt_device")
which sets xhci->devs[i]->udev to NULL before xhci_virt_dev() returned.
and causes a NULL pointer dereference the second time we try to set U3.

Fix this by checking xhci->devs[i]->udev exists before setting link state.

The original patch went to stable so this fix needs to be applied there as
well.

Fixes: 44a182b9d177 ("xhci: Fix use-after-free in xhci_free_virt_device")
Cc: <stable@vger.kernel.org>
Reported-by: Jordan Glover <Golden_Miller83@protonmail.ch>
Tested-by: Jordan Glover <Golden_Miller83@protonmail.ch>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/xhci-hub.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -366,7 +366,7 @@ int xhci_find_slot_id_by_port(struct usb
 
 	slot_id = 0;
 	for (i = 0; i < MAX_HC_SLOTS; i++) {
-		if (!xhci->devs[i])
+		if (!xhci->devs[i] || !xhci->devs[i]->udev)
 			continue;
 		speed = xhci->devs[i]->udev->speed;
 		if (((speed >= USB_SPEED_SUPER) == (hcd->speed >= HCD_USB3))


