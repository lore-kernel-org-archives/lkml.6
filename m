Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78872C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 10:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38E502054F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 10:21:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38E502054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osadl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbeH3OWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 10:22:31 -0400
Received: from www.osadl.org ([62.245.132.105]:38981 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728098AbeH3OWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 10:22:30 -0400
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59])
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id w7UAITmK015957;
        Thu, 30 Aug 2018 12:18:29 +0200
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH 1/2] usb: gadget: fsl_udc_core: check allocation return value and cleanup on failure
Date:   Thu, 30 Aug 2018 12:16:58 +0200
Message-Id: <1535624219-17854-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The allocation with fsl_alloc_request() and kmalloc() were unchecked
fixed this up with a NULL check and appropriate cleanup.

Additionally udc->ep_qh_size was reset to 0 on failure of allocation.
Similar udc->phy_mode is initially 0 (as udc_controller was
allocated with kzalloc in fsl_udc_probe()) so reset it to 0 as well
so that this function is side-effect free on failure. Not clear if
this is necessary or sensible as fsl_udc_release() probably can not
be called if fsl_udc_probe() failed - but it should not hurt.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: b504882da5 ("USB: add Freescale high-speed USB SOC device controller driver")
---

Problem located with experimental coccinelle script

Patch was compile tested with: imx_v6_v7_defconfig (implies USB_FSL_USB2=y)
(with a large number of sparse warnings not related to the proposed change
 and one smatch warning)

Patch is against 4.19-rc1 (localversion-next is next-20180830)

 drivers/usb/gadget/udc/fsl_udc_core.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/udc/fsl_udc_core.c b/drivers/usb/gadget/udc/fsl_udc_core.c
index be59309..e637afb 100644
--- a/drivers/usb/gadget/udc/fsl_udc_core.c
+++ b/drivers/usb/gadget/udc/fsl_udc_core.c
@@ -2247,8 +2247,10 @@ static int struct_udc_setup(struct fsl_udc *udc,
 	udc->phy_mode = pdata->phy_mode;
 
 	udc->eps = kcalloc(udc->max_ep, sizeof(struct fsl_ep), GFP_KERNEL);
-	if (!udc->eps)
-		return -1;
+	if (!udc->eps) {
+		ERR("kmalloc udc endpoint status failed\n");
+		goto eps_alloc_failed;
+	}
 
 	/* initialized QHs, take care of alignment */
 	size = udc->max_ep * sizeof(struct ep_queue_head);
@@ -2262,8 +2264,7 @@ static int struct_udc_setup(struct fsl_udc *udc,
 					&udc->ep_qh_dma, GFP_KERNEL);
 	if (!udc->ep_qh) {
 		ERR("malloc QHs for udc failed\n");
-		kfree(udc->eps);
-		return -1;
+		goto ep_queue_alloc_failed;
 	}
 
 	udc->ep_qh_size = size;
@@ -2272,8 +2273,17 @@ static int struct_udc_setup(struct fsl_udc *udc,
 	/* FIXME: fsl_alloc_request() ignores ep argument */
 	udc->status_req = container_of(fsl_alloc_request(NULL, GFP_KERNEL),
 			struct fsl_req, req);
+	if (!udc->status_req) {
+		ERR("kzalloc for udc status request failed\n");
+		goto udc_status_alloc_failed;
+	}
+
 	/* allocate a small amount of memory to get valid address */
 	udc->status_req->req.buf = kmalloc(8, GFP_KERNEL);
+	if (!udc->status_req->req.buf) {
+		ERR("kzalloc for udc request buffer failed\n");
+		goto udc_req_buf_alloc_failed;
+	}
 
 	udc->resume_state = USB_STATE_NOTATTACHED;
 	udc->usb_state = USB_STATE_POWERED;
@@ -2281,6 +2291,18 @@ static int struct_udc_setup(struct fsl_udc *udc,
 	udc->remote_wakeup = 0;	/* default to 0 on reset */
 
 	return 0;
+
+udc_req_buf_alloc_failed:
+	kfree(udc->status_req);
+udc_status_alloc_failed:
+	kfree(udc->ep_qh);
+	udc->ep_qh_size = 0;
+ep_queue_alloc_failed:
+	kfree(udc->eps);
+eps_alloc_failed:
+	udc->phy_mode = 0;
+	return -1;
+
 }
 
 /*----------------------------------------------------------------
-- 
2.1.4

