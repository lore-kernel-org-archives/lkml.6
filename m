Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069A1C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF22521019
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yuzaAKkx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF22521019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729494AbeK3BUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:20:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:41692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728241AbeK3BUj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:20:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96DBA21019;
        Thu, 29 Nov 2018 14:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543500909;
        bh=09ke7C3qdBawlccInrmcGB+ngRZlvVHAFWticF2xNnU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yuzaAKkxkTfm7GJeldXIXyiINGXHcI156RTDD5KqnX61GQJP2kKCeHXd/Fe7navjv
         5Y8Js4J06oMZ4DG/AhumEskvmQC1I7lBNhv/hV7tPfvG815tB5N66b6OCL5zxnOwbH
         uI817dh0WFl8BI78AMdjQHtGkC5bZOxTba8K5D8Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Cameron Gutman <aicommander@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 48/83] Input: xpad - fix oops when attaching an unknown Xbox One gamepad
Date:   Thu, 29 Nov 2018 15:12:06 +0100
Message-Id: <20181129140140.411763683@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140138.002176596@linuxfoundation.org>
References: <20181129140138.002176596@linuxfoundation.org>
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

[ Upstream commit c7f1429389ec1aa25e042bb13451385fbb596f8c ]

Xbox One controllers have multiple interfaces which all have the
same class, subclass, and protocol. One of the these interfaces
has only a single endpoint. When Xpad attempts to bind to this
interface, it causes an oops when trying initialize the output URB
by trying to access the second endpoint's descriptor.

This situation was avoided for known Xbox One devices by checking
the XTYPE constant associated with the VID and PID tuple. However,
this breaks when new or previously unknown Xbox One controllers
are attached to the system.

This change addresses the problem by deriving the XTYPE for Xbox
One controllers based on the interface protocol before checking
the interface number.

Fixes: 1a48ff81b391 ("Input: xpad - add support for Xbox One controllers")
Signed-off-by: Cameron Gutman <aicommander@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/joystick/xpad.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 6586d7ae0019..05a5c647ed36 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -1442,16 +1442,6 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 			break;
 	}
 
-	if (xpad_device[i].xtype == XTYPE_XBOXONE &&
-	    intf->cur_altsetting->desc.bInterfaceNumber != 0) {
-		/*
-		 * The Xbox One controller lists three interfaces all with the
-		 * same interface class, subclass and protocol. Differentiate by
-		 * interface number.
-		 */
-		return -ENODEV;
-	}
-
 	xpad = kzalloc(sizeof(struct usb_xpad), GFP_KERNEL);
 	if (!xpad)
 		return -ENOMEM;
@@ -1483,6 +1473,8 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 		if (intf->cur_altsetting->desc.bInterfaceClass == USB_CLASS_VENDOR_SPEC) {
 			if (intf->cur_altsetting->desc.bInterfaceProtocol == 129)
 				xpad->xtype = XTYPE_XBOX360W;
+			else if (intf->cur_altsetting->desc.bInterfaceProtocol == 208)
+				xpad->xtype = XTYPE_XBOXONE;
 			else
 				xpad->xtype = XTYPE_XBOX360;
 		} else {
@@ -1497,6 +1489,17 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 			xpad->mapping |= MAP_STICKS_TO_NULL;
 	}
 
+	if (xpad->xtype == XTYPE_XBOXONE &&
+	    intf->cur_altsetting->desc.bInterfaceNumber != 0) {
+		/*
+		 * The Xbox One controller lists three interfaces all with the
+		 * same interface class, subclass and protocol. Differentiate by
+		 * interface number.
+		 */
+		error = -ENODEV;
+		goto err_free_in_urb;
+	}
+
 	error = xpad_init_output(intf, xpad);
 	if (error)
 		goto err_free_in_urb;
-- 
2.17.1



