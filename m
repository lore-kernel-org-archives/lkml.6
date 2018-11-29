Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A836C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12274205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="acLlAvE3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12274205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731976AbeK3B16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:27:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:53256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731259AbeK3B14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:27:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF69A205C9;
        Thu, 29 Nov 2018 14:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501345;
        bh=9cggRxTwxnfGISkLIpMgjiuroqzD/sayQWkfR4doazY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=acLlAvE3LKJCxRngty8liaw8Qk236gx4kKT57lBEA1SRfjNdKNCxdPrOPF7R1IfIH
         KPaAz8tgSfKrIkGvIPYKu+zhJ58wbjHq76TXvQOIHhGbh/kkAsOvNhwgmSMU8tVAPI
         6BwGsPS5KusZQ4H+lfSfn/OLvDiXpY2ZGROEVl74=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Cameron Gutman <aicommander@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 51/92] Input: xpad - dont depend on endpoint order
Date:   Thu, 29 Nov 2018 15:12:20 +0100
Message-Id: <20181129140110.529408729@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140106.520639693@linuxfoundation.org>
References: <20181129140106.520639693@linuxfoundation.org>
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

[ Upstream commit c01b5e7464f0cf20936d7467c7528163c4e2782d ]

The order of endpoints is well defined on official Xbox pads, but
we have found at least one 3rd-party pad that doesn't follow the
standard ("Titanfall 2 Xbox One controller" 0e6f:0165).

Fortunately, we get lucky with this specific pad because it uses
endpoint addresses that differ only by direction. We know that
there are other pads out where this is not true, so let's go
ahead and fix this.

Signed-off-by: Cameron Gutman <aicommander@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/joystick/xpad.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index d837900d609e..dd0503562b1c 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -838,10 +838,9 @@ static void xpad_irq_out(struct urb *urb)
 	spin_unlock_irqrestore(&xpad->odata_lock, flags);
 }
 
-static int xpad_init_output(struct usb_interface *intf, struct usb_xpad *xpad)
+static int xpad_init_output(struct usb_interface *intf, struct usb_xpad *xpad,
+			struct usb_endpoint_descriptor *ep_irq_out)
 {
-	struct usb_endpoint_descriptor *ep_irq_out;
-	int ep_irq_out_idx;
 	int error;
 
 	if (xpad->xtype == XTYPE_UNKNOWN)
@@ -862,10 +861,6 @@ static int xpad_init_output(struct usb_interface *intf, struct usb_xpad *xpad)
 		goto err_free_coherent;
 	}
 
-	/* Xbox One controller has in/out endpoints swapped. */
-	ep_irq_out_idx = xpad->xtype == XTYPE_XBOXONE ? 0 : 1;
-	ep_irq_out = &intf->cur_altsetting->endpoint[ep_irq_out_idx].desc;
-
 	usb_fill_int_urb(xpad->irq_out, xpad->udev,
 			 usb_sndintpipe(xpad->udev, ep_irq_out->bEndpointAddress),
 			 xpad->odata, XPAD_PKT_LEN,
@@ -1455,8 +1450,7 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 {
 	struct usb_device *udev = interface_to_usbdev(intf);
 	struct usb_xpad *xpad;
-	struct usb_endpoint_descriptor *ep_irq_in;
-	int ep_irq_in_idx;
+	struct usb_endpoint_descriptor *ep_irq_in, *ep_irq_out;
 	int i, error;
 
 	if (intf->cur_altsetting->desc.bNumEndpoints != 2)
@@ -1526,13 +1520,26 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 		goto err_free_in_urb;
 	}
 
-	error = xpad_init_output(intf, xpad);
-	if (error)
+	ep_irq_in = ep_irq_out = NULL;
+
+	for (i = 0; i < 2; i++) {
+		struct usb_endpoint_descriptor *ep =
+				&intf->cur_altsetting->endpoint[i].desc;
+
+		if (usb_endpoint_dir_in(ep))
+			ep_irq_in = ep;
+		else
+			ep_irq_out = ep;
+	}
+
+	if (!ep_irq_in || !ep_irq_out) {
+		error = -ENODEV;
 		goto err_free_in_urb;
+	}
 
-	/* Xbox One controller has in/out endpoints swapped. */
-	ep_irq_in_idx = xpad->xtype == XTYPE_XBOXONE ? 1 : 0;
-	ep_irq_in = &intf->cur_altsetting->endpoint[ep_irq_in_idx].desc;
+	error = xpad_init_output(intf, xpad, ep_irq_out);
+	if (error)
+		goto err_free_in_urb;
 
 	usb_fill_int_urb(xpad->irq_in, udev,
 			 usb_rcvintpipe(udev, ep_irq_in->bEndpointAddress),
-- 
2.17.1



