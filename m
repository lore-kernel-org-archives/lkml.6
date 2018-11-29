Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4BDC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F26721019
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="t0NgttqZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F26721019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbeK3BTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:19:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:40164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728198AbeK3BTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:19:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BA36208E7;
        Thu, 29 Nov 2018 14:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543500844;
        bh=nIzj0CN4t/7JfFBgVfE8wPPirb89ADoT9jUonKBQWa4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t0NgttqZ9CAMd35QhzYK7XzVyr431T+WkEaqlwb4kgddr275MvsnR5o0xnN75ESr2
         cfYUFnS2xM+drkHqjWttCebsdP8mj6zkMclopHD0mRPSFkKIw1KzrS/Ar8/Sbxo98o
         1w7ECfsKj4UNlHN93t2QdAgQC77oapaGGxQ/S6sU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ming-ting Yao Wei <mwei@lxde.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 21/83] Input: xpad - add rumble support for Xbox One controller
Date:   Thu, 29 Nov 2018 15:11:39 +0100
Message-Id: <20181129140139.271423898@linuxfoundation.org>
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

[ Upstream commit 0604949ce3b9a59cff419daf706272620a9a0df0 ]

This adds rumble support for Xbox One controller by sending continuous
rumble command. Trigger button rumbling is not yet implemented.

Signed-off-by: Ming-ting Yao Wei <mwei@lxde.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/joystick/xpad.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 9843c8cca2f7..c4205ed022fd 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -31,12 +31,14 @@
  *  - the iForce driver    drivers/char/joystick/iforce.c
  *  - the skeleton-driver  drivers/usb/usb-skeleton.c
  *  - Xbox 360 information http://www.free60.org/wiki/Gamepad
+ *  - Xbox One information https://github.com/quantus/xbox-one-controller-protocol
  *
  * Thanks to:
  *  - ITO Takayuki for providing essential xpad information on his website
  *  - Vojtech Pavlik     - iforce driver / input subsystem
  *  - Greg Kroah-Hartman - usb-skeleton driver
  *  - XBOX Linux project - extra USB id's
+ *  - Pekka Pöyry (quantus) - Xbox One controller reverse engineering
  *
  * TODO:
  *  - fine tune axes (especially trigger axes)
@@ -830,6 +832,23 @@ static int xpad_play_effect(struct input_dev *dev, void *data, struct ff_effect
 
 			return usb_submit_urb(xpad->irq_out, GFP_ATOMIC);
 
+		case XTYPE_XBOXONE:
+			xpad->odata[0] = 0x09; /* activate rumble */
+			xpad->odata[1] = 0x08;
+			xpad->odata[2] = 0x00;
+			xpad->odata[3] = 0x08; /* continuous effect */
+			xpad->odata[4] = 0x00; /* simple rumble mode */
+			xpad->odata[5] = 0x03; /* L and R actuator only */
+			xpad->odata[6] = 0x00; /* TODO: LT actuator */
+			xpad->odata[7] = 0x00; /* TODO: RT actuator */
+			xpad->odata[8] = strong / 256;	/* left actuator */
+			xpad->odata[9] = weak / 256;	/* right actuator */
+			xpad->odata[10] = 0x80;	/* length of pulse */
+			xpad->odata[11] = 0x00;	/* stop period of pulse */
+			xpad->irq_out->transfer_buffer_length = 12;
+
+			return usb_submit_urb(xpad->irq_out, GFP_ATOMIC);
+
 		default:
 			dev_dbg(&xpad->dev->dev,
 				"%s - rumble command sent to unsupported xpad type: %d\n",
@@ -843,7 +862,7 @@ static int xpad_play_effect(struct input_dev *dev, void *data, struct ff_effect
 
 static int xpad_init_ff(struct usb_xpad *xpad)
 {
-	if (xpad->xtype == XTYPE_UNKNOWN || xpad->xtype == XTYPE_XBOXONE)
+	if (xpad->xtype == XTYPE_UNKNOWN)
 		return 0;
 
 	input_set_capability(xpad->dev, EV_FF, FF_RUMBLE);
-- 
2.17.1



