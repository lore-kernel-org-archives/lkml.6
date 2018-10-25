Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FCAECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41C2A208A3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTbUue35"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41C2A208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730507AbeJYWwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:52:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:34332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730453AbeJYWwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:52:21 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 418792085B;
        Thu, 25 Oct 2018 14:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477164;
        bh=4sRq+3OM7JQubnwEYoC91IvPebW59OcGzEcOG53zGZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UTbUue35cIbuKyZiOoEQirn48pnyX4n+LwgMptCPMNAnOcPUF63BgkBJA4J1ftKWv
         Zk+0Cg6EZCcx8Gnlfa7SZiaaORDFPRP7WeH/yVnU4c+aK2R3Gx6pPBiFlj34yXn4L+
         h8686ZpnBu16BSeTeUn3QR2eswNsBc+QfN7IEsy8=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Baldyga <r.baldyga@samsung.com>,
        Felipe Balbi <balbi@ti.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 18/98] usb: dwc2: gadget: kill requests with 'force' in s3c_hsotg_udc_stop()
Date:   Thu, 25 Oct 2018 10:17:33 -0400
Message-Id: <20181025141853.214051-18-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert Baldyga <r.baldyga@samsung.com>

[ Upstream commit 62f4f0651ce8ef966a0e5b6db6a7a524c268fdd2 ]

This makes us sure that all requests are completed before we unbind
gadget. There are assumptions in gadget API that all requests have to
be completed and leak of complete can break some usb function drivers.

For example unbind of ECM function can cause NULL pointer dereference:

[   26.396595] configfs-gadget gadget: unbind function
'cdc_ethernet'/e79c4c00
[   26.414999] Unable to handle kernel NULL pointer dereference at
virtual address 00000000
(...)
[   26.452223] PC is at ecm_unbind+0x6c/0x9c
[   26.456209] LR is at ecm_unbind+0x68/0x9c
(...)
[   26.603696] [<c033fdb4>] (ecm_unbind) from [<c033661c>]
(purge_configs_funcs+0x94/0xd8)
[   26.611674] [<c033661c>] (purge_configs_funcs) from [<c0336674>]
(configfs_composite_unbind+0x14/0x34)
[   26.620961] [<c0336674>] (configfs_composite_unbind) from
[<c0337124>] (usb_gadget_remove_driver+0x68/0x9c)
[   26.630683] [<c0337124>] (usb_gadget_remove_driver) from [<c03376c8>]
(usb_gadget_unregister_driver+0x64/0x94)
[   26.640664] [<c03376c8>] (usb_gadget_unregister_driver) from
[<c0336be8>] (unregister_gadget+0x20/0x3c)
[   26.650038] [<c0336be8>] (unregister_gadget) from [<c0336c84>]
(gadget_dev_desc_UDC_store+0x80/0xb8)
[   26.659152] [<c0336c84>] (gadget_dev_desc_UDC_store) from
[<c0335120>] (gadget_info_attr_store+0x1c/0x28)
[   26.668703] [<c0335120>] (gadget_info_attr_store) from [<c012135c>]
(configfs_write_file+0xe8/0x148)
[   26.677818] [<c012135c>] (configfs_write_file) from [<c00c8dd4>]
(vfs_write+0xb0/0x1a0)
[   26.685801] [<c00c8dd4>] (vfs_write) from [<c00c91b8>]
(SyS_write+0x44/0x84)
[   26.692834] [<c00c91b8>] (SyS_write) from [<c000e560>]
(ret_fast_syscall+0x0/0x30)
[   26.700381] Code: e30409f8 e34c0069 eb07b88d e59430a8 (e5930000)
[   26.706485] ---[ end trace f62a082b323838a2 ]---

It's because in some cases request is still running on endpoint during
unbind and kill_all_requests() called from s3c_hsotg_udc_stop() function
doesn't cause call of complete() of request. Missing complete() call
causes ecm->notify_req equals NULL in ecm_unbind() function, and this
is reason of this bug.

Similar breaks can be observed in another usb function drivers.

This patch fixes this bug forcing usb request completion in when
s3c_hsotg_ep_disable() is called from s3c_hsotg_udc_stop().

Acked-by: Paul Zimmerman <paulz@synopsys.com>
Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc2/gadget.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index 8b5c079c7b7d..cb4c925fb87c 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -2590,7 +2590,7 @@ static int s3c_hsotg_ep_enable(struct usb_ep *ep,
  * s3c_hsotg_ep_disable - disable given endpoint
  * @ep: The endpoint to disable.
  */
-static int s3c_hsotg_ep_disable(struct usb_ep *ep)
+static int s3c_hsotg_ep_disable_force(struct usb_ep *ep, bool force)
 {
 	struct s3c_hsotg_ep *hs_ep = our_ep(ep);
 	struct s3c_hsotg *hsotg = hs_ep->parent;
@@ -2611,7 +2611,7 @@ static int s3c_hsotg_ep_disable(struct usb_ep *ep)
 
 	spin_lock_irqsave(&hsotg->lock, flags);
 	/* terminate all requests with shutdown */
-	kill_all_requests(hsotg, hs_ep, -ESHUTDOWN, false);
+	kill_all_requests(hsotg, hs_ep, -ESHUTDOWN, force);
 
 	hsotg->fifo_map &= ~(1<<hs_ep->fifo_index);
 	hs_ep->fifo_index = 0;
@@ -2632,6 +2632,10 @@ static int s3c_hsotg_ep_disable(struct usb_ep *ep)
 	return 0;
 }
 
+static int s3c_hsotg_ep_disable(struct usb_ep *ep)
+{
+	return s3c_hsotg_ep_disable_force(ep, false);
+}
 /**
  * on_list - check request is on the given endpoint
  * @ep: The endpoint to check.
@@ -2933,7 +2937,7 @@ static int s3c_hsotg_udc_stop(struct usb_gadget *gadget,
 
 	/* all endpoints should be shutdown */
 	for (ep = 1; ep < hsotg->num_of_eps; ep++)
-		s3c_hsotg_ep_disable(&hsotg->eps[ep].ep);
+		s3c_hsotg_ep_disable_force(&hsotg->eps[ep].ep, true);
 
 	spin_lock_irqsave(&hsotg->lock, flags);
 
-- 
2.17.1

