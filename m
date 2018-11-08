Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C2DECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 407EC2086C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qJuyGOzk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 407EC2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbeKIHcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:32:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:46888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728247AbeKIHcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:32:06 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E52C2089A;
        Thu,  8 Nov 2018 21:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714079;
        bh=8amLbs7YRojqTwzPBX7Xy+U4PcOF/99tig2RE4ZyNic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qJuyGOzk2+cK+UH3blwNpfYg+ySCOwW2d/S0TvDgmNkVXReoySurSa/KsSloNAinY
         c64BbFjF1SZapAIEaX+rTPIaKh2j697Q8JkET9v/5QD8aeGPkGhfmp7AvEqWgtHd2u
         0rT/LfgmriiYdzj4RltEfLR3AcBuDR+HvrjwvXUU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Zimmerman <paulz@synopsys.com>,
        Robert Baldyga <r.baldyga@samsung.com>,
        Felipe Balbi <balbi@ti.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 048/144] usb: dwc2: gadget: kill requests with force in s3c_hsotg_udc_stop()
Date:   Thu,  8 Nov 2018 13:50:19 -0800
Message-Id: <20181108215058.326996998@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
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
@@ -2590,7 +2590,7 @@ error:
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



