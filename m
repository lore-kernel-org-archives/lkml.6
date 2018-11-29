Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B427C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FA4D21104
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFhYHV9t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FA4D21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbeK3BTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:19:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:40612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728198AbeK3BTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:19:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B693E205C9;
        Thu, 29 Nov 2018 14:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543500864;
        bh=nCX6YI9VgXdh1Ycmx+q7bYr5WW+z1JwKH07dgTOX/Ks=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TFhYHV9tpmuWyCJnE/ZgbgzLewuoT7I6QrqymAIfo1oxlRtwGdGtzceRsLc9zo2Qv
         /VroEma0ikwVBrijQA8iQI6OP5TKcJ69Xzdb35BtWL7zoN9U6YHUMEzY/anUBREEiY
         YOT60CGRKMXv5BkWVaNVRGRs6vj1W6PzW5fhcJDg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Rojtberg <rojtberg@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 29/83] Input: xpad - factor out URB submission in xpad_play_effect
Date:   Thu, 29 Nov 2018 15:11:47 +0100
Message-Id: <20181129140139.611525601@linuxfoundation.org>
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

[ Upstream commit 060081529c64cfa9baa2748a4b949159e700da0d ]

Move submission logic to a single point at the end of the function.
This makes it easy to add locking/ queuing code later on.

Signed-off-by: Pavel Rojtberg <rojtberg@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/joystick/xpad.c | 140 +++++++++++++++++-----------------
 1 file changed, 69 insertions(+), 71 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index afa232b415a5..fc81473b6e35 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -764,80 +764,78 @@ static void xpad_deinit_output(struct usb_xpad *xpad)
 static int xpad_play_effect(struct input_dev *dev, void *data, struct ff_effect *effect)
 {
 	struct usb_xpad *xpad = input_get_drvdata(dev);
+	__u16 strong;
+	__u16 weak;
 
-	if (effect->type == FF_RUMBLE) {
-		__u16 strong = effect->u.rumble.strong_magnitude;
-		__u16 weak = effect->u.rumble.weak_magnitude;
-
-		switch (xpad->xtype) {
-
-		case XTYPE_XBOX:
-			xpad->odata[0] = 0x00;
-			xpad->odata[1] = 0x06;
-			xpad->odata[2] = 0x00;
-			xpad->odata[3] = strong / 256;	/* left actuator */
-			xpad->odata[4] = 0x00;
-			xpad->odata[5] = weak / 256;	/* right actuator */
-			xpad->irq_out->transfer_buffer_length = 6;
-
-			return usb_submit_urb(xpad->irq_out, GFP_ATOMIC);
-
-		case XTYPE_XBOX360:
-			xpad->odata[0] = 0x00;
-			xpad->odata[1] = 0x08;
-			xpad->odata[2] = 0x00;
-			xpad->odata[3] = strong / 256;  /* left actuator? */
-			xpad->odata[4] = weak / 256;	/* right actuator? */
-			xpad->odata[5] = 0x00;
-			xpad->odata[6] = 0x00;
-			xpad->odata[7] = 0x00;
-			xpad->irq_out->transfer_buffer_length = 8;
-
-			return usb_submit_urb(xpad->irq_out, GFP_ATOMIC);
-
-		case XTYPE_XBOX360W:
-			xpad->odata[0] = 0x00;
-			xpad->odata[1] = 0x01;
-			xpad->odata[2] = 0x0F;
-			xpad->odata[3] = 0xC0;
-			xpad->odata[4] = 0x00;
-			xpad->odata[5] = strong / 256;
-			xpad->odata[6] = weak / 256;
-			xpad->odata[7] = 0x00;
-			xpad->odata[8] = 0x00;
-			xpad->odata[9] = 0x00;
-			xpad->odata[10] = 0x00;
-			xpad->odata[11] = 0x00;
-			xpad->irq_out->transfer_buffer_length = 12;
-
-			return usb_submit_urb(xpad->irq_out, GFP_ATOMIC);
-
-		case XTYPE_XBOXONE:
-			xpad->odata[0] = 0x09; /* activate rumble */
-			xpad->odata[1] = 0x08;
-			xpad->odata[2] = 0x00;
-			xpad->odata[3] = 0x08; /* continuous effect */
-			xpad->odata[4] = 0x00; /* simple rumble mode */
-			xpad->odata[5] = 0x03; /* L and R actuator only */
-			xpad->odata[6] = 0x00; /* TODO: LT actuator */
-			xpad->odata[7] = 0x00; /* TODO: RT actuator */
-			xpad->odata[8] = strong / 256;	/* left actuator */
-			xpad->odata[9] = weak / 256;	/* right actuator */
-			xpad->odata[10] = 0x80;	/* length of pulse */
-			xpad->odata[11] = 0x00;	/* stop period of pulse */
-			xpad->irq_out->transfer_buffer_length = 12;
-
-			return usb_submit_urb(xpad->irq_out, GFP_ATOMIC);
-
-		default:
-			dev_dbg(&xpad->dev->dev,
-				"%s - rumble command sent to unsupported xpad type: %d\n",
-				__func__, xpad->xtype);
-			return -1;
-		}
+	if (effect->type != FF_RUMBLE)
+		return 0;
+
+	strong = effect->u.rumble.strong_magnitude;
+	weak = effect->u.rumble.weak_magnitude;
+
+	switch (xpad->xtype) {
+	case XTYPE_XBOX:
+		xpad->odata[0] = 0x00;
+		xpad->odata[1] = 0x06;
+		xpad->odata[2] = 0x00;
+		xpad->odata[3] = strong / 256;	/* left actuator */
+		xpad->odata[4] = 0x00;
+		xpad->odata[5] = weak / 256;	/* right actuator */
+		xpad->irq_out->transfer_buffer_length = 6;
+		break;
+
+	case XTYPE_XBOX360:
+		xpad->odata[0] = 0x00;
+		xpad->odata[1] = 0x08;
+		xpad->odata[2] = 0x00;
+		xpad->odata[3] = strong / 256;  /* left actuator? */
+		xpad->odata[4] = weak / 256;	/* right actuator? */
+		xpad->odata[5] = 0x00;
+		xpad->odata[6] = 0x00;
+		xpad->odata[7] = 0x00;
+		xpad->irq_out->transfer_buffer_length = 8;
+		break;
+
+	case XTYPE_XBOX360W:
+		xpad->odata[0] = 0x00;
+		xpad->odata[1] = 0x01;
+		xpad->odata[2] = 0x0F;
+		xpad->odata[3] = 0xC0;
+		xpad->odata[4] = 0x00;
+		xpad->odata[5] = strong / 256;
+		xpad->odata[6] = weak / 256;
+		xpad->odata[7] = 0x00;
+		xpad->odata[8] = 0x00;
+		xpad->odata[9] = 0x00;
+		xpad->odata[10] = 0x00;
+		xpad->odata[11] = 0x00;
+		xpad->irq_out->transfer_buffer_length = 12;
+		break;
+
+	case XTYPE_XBOXONE:
+		xpad->odata[0] = 0x09; /* activate rumble */
+		xpad->odata[1] = 0x08;
+		xpad->odata[2] = 0x00;
+		xpad->odata[3] = 0x08; /* continuous effect */
+		xpad->odata[4] = 0x00; /* simple rumble mode */
+		xpad->odata[5] = 0x03; /* L and R actuator only */
+		xpad->odata[6] = 0x00; /* TODO: LT actuator */
+		xpad->odata[7] = 0x00; /* TODO: RT actuator */
+		xpad->odata[8] = strong / 256;	/* left actuator */
+		xpad->odata[9] = weak / 256;	/* right actuator */
+		xpad->odata[10] = 0x80;	/* length of pulse */
+		xpad->odata[11] = 0x00;	/* stop period of pulse */
+		xpad->irq_out->transfer_buffer_length = 12;
+		break;
+
+	default:
+		dev_dbg(&xpad->dev->dev,
+			"%s - rumble command sent to unsupported xpad type: %d\n",
+			__func__, xpad->xtype);
+		return -EINVAL;
 	}
 
-	return 0;
+	return usb_submit_urb(xpad->irq_out, GFP_ATOMIC);
 }
 
 static int xpad_init_ff(struct usb_xpad *xpad)
-- 
2.17.1



