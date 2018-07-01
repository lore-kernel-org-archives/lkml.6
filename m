Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE87FC6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3B63255EC
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:30:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3B63255EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031107AbeGARaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 13:30:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36072 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031310AbeGAQgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:36:42 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 86261ACD;
        Sun,  1 Jul 2018 16:36:41 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4.14 157/157] xhci: Fix use-after-free in xhci_free_virt_device
Date:   Sun,  1 Jul 2018 18:23:49 +0200
Message-Id: <20180701160901.122853343@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160852.287307684@linuxfoundation.org>
References: <20180701160852.287307684@linuxfoundation.org>
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
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/xhci.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -3551,6 +3551,7 @@ static void xhci_free_dev(struct usb_hcd
 		del_timer_sync(&virt_dev->eps[i].stop_cmd_timer);
 	}
 
+	virt_dev->udev = NULL;
 	xhci_disable_slot(xhci, udev->slot_id);
 	/*
 	 * Event command completion handler will free any data structures


