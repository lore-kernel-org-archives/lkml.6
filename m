Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936731AbeE1KMV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:12:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:60304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936718AbeE1KMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:12:10 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mathias Nyman <mathias.nyman@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 147/185] xhci: zero usb device slot_id member when disabling and freeing a xhci slot
Date: Mon, 28 May 2018 12:03:08 +0200
Message-Id: <20180528100108.667025238@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100050.700971285@linuxfoundation.org>
References: <20180528100050.700971285@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mathias Nyman <mathias.nyman@linux.intel.com>

[ Upstream commit a400efe455f7b61ac9a801ac8d0d01f8c8d82dd5 ]

set udev->slot_id to zero when disabling and freeing the xhci slot.
Prevents usb core from calling xhci with a stale slot id.

xHC controller may be reset during resume to recover from some error.
All slots are unusable as they are disabled and freed.
xhci driver starts slot enumeration again from 1 in the order they are
enabled. In the worst case a stale udev->slot_id for one device matches
a newly enabled slot_id for a different device, causing us to
perform a action on the wrong device.

Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/host/xhci-mem.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -962,6 +962,8 @@ void xhci_free_virt_device(struct xhci_h
 	if (dev->out_ctx)
 		xhci_free_container_ctx(xhci, dev->out_ctx);
 
+	if (dev->udev && dev->udev->slot_id)
+		dev->udev->slot_id = 0;
 	kfree(xhci->devs[slot_id]);
 	xhci->devs[slot_id] = NULL;
 }
