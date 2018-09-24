Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CB4C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC3EF20685
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:40:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC3EF20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbeIXRly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 13:41:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50746 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729053AbeIXRlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 13:41:52 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6E7D21071;
        Mon, 24 Sep 2018 11:40:12 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 3.18 059/105] xhci: Fix use-after-free in xhci_free_virt_device
Date:   Mon, 24 Sep 2018 13:33:45 +0200
Message-Id: <20180924113119.491292892@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113113.268650190@linuxfoundation.org>
References: <20180924113113.268650190@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3630,6 +3630,9 @@ void xhci_free_dev(struct usb_hcd *hcd,
 	}
 
 	spin_lock_irqsave(&xhci->lock, flags);
+
+	virt_dev->udev = NULL;
+
 	/* Don't disable the slot if the host controller is dead. */
 	state = readl(&xhci->op_regs->status);
 	if (state == 0xffffffff || (xhci->xhc_state & XHCI_STATE_DYING) ||


