Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA94ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06DC32088F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:51:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06DC32088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbeIREVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:21:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45176 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbeIREVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:21:18 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 85E49CAC;
        Mon, 17 Sep 2018 22:51:53 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 4.4 46/56] xhci: Fix use-after-free in xhci_free_virt_device
Date:   Tue, 18 Sep 2018 00:42:19 +0200
Message-Id: <20180917213829.820612990@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917213827.913122591@linuxfoundation.org>
References: <20180917213827.913122591@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mathias Nyman <mathias.nyman@linux.intel.com>

commit 44a182b9d17765514fa2b1cc911e4e65134eef93 upstream.

KASAN found a use-after-free in xhci_free_virt_device+0x33b/0x38e
where xhci_free_virt_device() sets slot id to 0 if udev exists:
if (dev->udev && dev->udev->slot_id)
	dev->udev->slot_id = 0;

dev->udev will be true even if udev is freed because dev->udev is
not set to NULL.

set dev->udev pointer to NULL in xhci_free_dev()

The original patch went to stable so this fix needs to be applied
there as well.

Fixes: a400efe455f7 ("xhci: zero usb device slot_id member when disabling and freeing a xhci slot")
Cc: <stable@vger.kernel.org>
Reported-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/xhci.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -3675,6 +3675,9 @@ void xhci_free_dev(struct usb_hcd *hcd,
 	}
 
 	spin_lock_irqsave(&xhci->lock, flags);
+
+	virt_dev->udev = NULL;
+
 	/* Don't disable the slot if the host controller is dead. */
 	state = readl(&xhci->op_regs->status);
 	if (state == 0xffffffff || (xhci->xhc_state & XHCI_STATE_DYING) ||


