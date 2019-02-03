Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF616C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA7FB2084A
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730241AbfBCOUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:20:55 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55590 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730184AbfBCOUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:20:53 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIdf-0006Ml-Vv; Sun, 03 Feb 2019 14:20:52 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9V-0006rP-Ef; Sun, 03 Feb 2019 14:49:41 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Felipe Balbi" <felipe.balbi@linux.intel.com>,
        "Nicholas Mc Guire" <hofrat@osadl.org>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.705358414@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 053/305] usb: gadget: fsl_udc_core: check allocation
 return value and cleanup on failure
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Nicholas Mc Guire <hofrat@osadl.org>

commit 4ab2b48c98f2ec9712452d520a381917f91ac3d2 upstream.

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
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
[bwh: Backported to 3.16: adjust filename, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/gadget/fsl_udc_core.c | 30 +++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

--- a/drivers/usb/gadget/fsl_udc_core.c
+++ b/drivers/usb/gadget/fsl_udc_core.c
@@ -2256,8 +2256,10 @@ static int __init struct_udc_setup(struc
 	udc->phy_mode = pdata->phy_mode;
 
 	udc->eps = kzalloc(sizeof(struct fsl_ep) * udc->max_ep, GFP_KERNEL);
-	if (!udc->eps)
-		return -1;
+	if (!udc->eps) {
+		ERR("kmalloc udc endpoint status failed\n");
+		goto eps_alloc_failed;
+	}
 
 	/* initialized QHs, take care of alignment */
 	size = udc->max_ep * sizeof(struct ep_queue_head);
@@ -2271,8 +2273,7 @@ static int __init struct_udc_setup(struc
 					&udc->ep_qh_dma, GFP_KERNEL);
 	if (!udc->ep_qh) {
 		ERR("malloc QHs for udc failed\n");
-		kfree(udc->eps);
-		return -1;
+		goto ep_queue_alloc_failed;
 	}
 
 	udc->ep_qh_size = size;
@@ -2281,8 +2282,17 @@ static int __init struct_udc_setup(struc
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
@@ -2290,6 +2300,18 @@ static int __init struct_udc_setup(struc
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

