Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283C4C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA81A20892
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0XNhIW60"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA81A20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731155AbeKIH5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:57:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:36360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731902AbeKIHnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:43:52 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5C0B21479;
        Thu,  8 Nov 2018 22:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714781;
        bh=+ld6kpdjAzEzw9IdBt4Zh1UHHCEDSgcHx+V3vvws71k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0XNhIW605St+VtNVEJp/d5nOZZSJ2oRFolXwxhZzPkGgZU+rYxtcsxhM7Tuu4bDKS
         gcMCcucbSjX+DhjGfxRrTg1rVmVRc4w5x+3AyJivh9l/FkRbwK7fidm1uVKaY3KC/3
         dkeSkrr+wg4ngSQk26uY1q2I1WWls8ZkCEtRrtHY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jordan Glover <Golden_Miller83@protonmail.ch>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 124/171] xhci: Fix USB3 NULL pointer dereference at logical disconnect.
Date:   Thu,  8 Nov 2018 13:51:34 -0800
Message-Id: <20181108215136.225961233@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 2278446e2b7cd33ad894b32e7eb63afc7db6c86e ]

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-hub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index 45a03eff4db1..0f09ab5399f4 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -366,7 +366,7 @@ int xhci_find_slot_id_by_port(struct usb_hcd *hcd, struct xhci_hcd *xhci,
 
 	slot_id = 0;
 	for (i = 0; i < MAX_HC_SLOTS; i++) {
-		if (!xhci->devs[i])
+		if (!xhci->devs[i] || !xhci->devs[i]->udev)
 			continue;
 		speed = xhci->devs[i]->udev->speed;
 		if (((speed >= USB_SPEED_SUPER) == (hcd->speed >= HCD_USB3))
-- 
2.17.1



