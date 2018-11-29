Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC12C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A76D721019
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="b252pILb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A76D721019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731375AbeK3B7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:59:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:53442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731041AbeK3B2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:28:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23A59205C9;
        Thu, 29 Nov 2018 14:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501353;
        bh=JDL/wEQ5rKu/5iIsx1dCSkoOi4SqdOeuzFPaHXmBEik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b252pILb2ktLFNXxoNzkMQfDkV9fSdQ5i8QQWfC70ijAlPQfjEXIR0/mms33uUT9L
         P8g4qJlUqwS5EH6mUiHQJF4+QF4yv9CWvRIC2AIQNZuIWo/HxcVSJttyQkw7UxEUPu
         mDToiz1VhvQPJryA1Q+dtZZavN2FW0eUwtj/1OdE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Cameron Gutman <aicommander@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 54/92] Input: xpad - support some quirky Xbox One pads
Date:   Thu, 29 Nov 2018 15:12:23 +0100
Message-Id: <20181129140110.781475133@linuxfoundation.org>
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

[ Upstream commit 81093c9848a781b85163d06de92ef8f84528cf6a ]

There are several quirky Xbox One pads that depend on initialization
packets that the Microsoft pads don't require. To deal with these,
I've added a mechanism for issuing device-specific initialization
packets using a VID/PID-based quirks list.

For the initial set of init quirks, I have added quirk handling from
Valve's Steam Link xpad driver[0] and the 360Controller project[1] for
macOS to enable some new pads to work properly.

This should enable full functionality on the following quirky pads:
0x0e6f:0x0165 - Titanfall 2 gamepad (previously fully non-functional)
0x0f0d:0x0067 - Hori Horipad (analog sticks previously non-functional)
0x24c6:0x541a - PowerA Xbox One pad (previously fully non-functional)
0x24c6:0x542a - PowerA Xbox One pad (previously fully non-functional)
0x24c6:0x543a - PowerA Xbox One pad (previously fully non-functional)

[0]: https://github.com/ValveSoftware/steamlink-sdk/blob/master/kernel/drivers/input/joystick/xpad.c
[1]: https://github.com/360Controller/360Controller

Signed-off-by: Cameron Gutman <aicommander@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/joystick/xpad.c | 114 ++++++++++++++++++++++++++++++----
 1 file changed, 101 insertions(+), 13 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 153b1ee13e03..df83fdc6c0e7 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -339,6 +339,64 @@ static struct usb_device_id xpad_table[] = {
 
 MODULE_DEVICE_TABLE(usb, xpad_table);
 
+struct xboxone_init_packet {
+	u16 idVendor;
+	u16 idProduct;
+	const u8 *data;
+	u8 len;
+};
+
+#define XBOXONE_INIT_PKT(_vid, _pid, _data)		\
+	{						\
+		.idVendor	= (_vid),		\
+		.idProduct	= (_pid),		\
+		.data		= (_data),		\
+		.len		= ARRAY_SIZE(_data),	\
+	}
+
+
+/*
+ * This packet is required for all Xbox One pads with 2015
+ * or later firmware installed (or present from the factory).
+ */
+static const u8 xboxone_fw2015_init[] = {
+	0x05, 0x20, 0x00, 0x01, 0x00
+};
+
+/*
+ * This packet is required for the Titanfall 2 Xbox One pads
+ * (0x0e6f:0x0165) to finish initialization and for Hori pads
+ * (0x0f0d:0x0067) to make the analog sticks work.
+ */
+static const u8 xboxone_hori_init[] = {
+	0x01, 0x20, 0x00, 0x09, 0x00, 0x04, 0x20, 0x3a,
+	0x00, 0x00, 0x00, 0x80, 0x00
+};
+
+/*
+ * A rumble packet is required for some PowerA pads to start
+ * sending input reports. One of those pads is (0x24c6:0x543a).
+ */
+static const u8 xboxone_zerorumble_init[] = {
+	0x09, 0x00, 0x00, 0x09, 0x00, 0x0F, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00
+};
+
+/*
+ * This specifies the selection of init packets that a gamepad
+ * will be sent on init *and* the order in which they will be
+ * sent. The correct sequence number will be added when the
+ * packet is going to be sent.
+ */
+static const struct xboxone_init_packet xboxone_init_packets[] = {
+	XBOXONE_INIT_PKT(0x0e6f, 0x0165, xboxone_hori_init),
+	XBOXONE_INIT_PKT(0x0f0d, 0x0067, xboxone_hori_init),
+	XBOXONE_INIT_PKT(0x0000, 0x0000, xboxone_fw2015_init),
+	XBOXONE_INIT_PKT(0x24c6, 0x541a, xboxone_zerorumble_init),
+	XBOXONE_INIT_PKT(0x24c6, 0x542a, xboxone_zerorumble_init),
+	XBOXONE_INIT_PKT(0x24c6, 0x543a, xboxone_zerorumble_init),
+};
+
 struct xpad_output_packet {
 	u8 data[XPAD_PKT_LEN];
 	u8 len;
@@ -375,6 +433,7 @@ struct usb_xpad {
 
 	struct xpad_output_packet out_packets[XPAD_NUM_OUT_PACKETS];
 	int last_out_packet;
+	int init_seq;
 
 #if defined(CONFIG_JOYSTICK_XPAD_LEDS)
 	struct xpad_led *led;
@@ -749,12 +808,48 @@ exit:
 			__func__, retval);
 }
 
+/* Callers must hold xpad->odata_lock spinlock */
+static bool xpad_prepare_next_init_packet(struct usb_xpad *xpad)
+{
+	const struct xboxone_init_packet *init_packet;
+
+	if (xpad->xtype != XTYPE_XBOXONE)
+		return false;
+
+	/* Perform initialization sequence for Xbox One pads that require it */
+	while (xpad->init_seq < ARRAY_SIZE(xboxone_init_packets)) {
+		init_packet = &xboxone_init_packets[xpad->init_seq++];
+
+		if (init_packet->idVendor != 0 &&
+		    init_packet->idVendor != xpad->dev->id.vendor)
+			continue;
+
+		if (init_packet->idProduct != 0 &&
+		    init_packet->idProduct != xpad->dev->id.product)
+			continue;
+
+		/* This packet applies to our device, so prepare to send it */
+		memcpy(xpad->odata, init_packet->data, init_packet->len);
+		xpad->irq_out->transfer_buffer_length = init_packet->len;
+
+		/* Update packet with current sequence number */
+		xpad->odata[2] = xpad->odata_serial++;
+		return true;
+	}
+
+	return false;
+}
+
 /* Callers must hold xpad->odata_lock spinlock */
 static bool xpad_prepare_next_out_packet(struct usb_xpad *xpad)
 {
 	struct xpad_output_packet *pkt, *packet = NULL;
 	int i;
 
+	/* We may have init packets to send before we can send user commands */
+	if (xpad_prepare_next_init_packet(xpad))
+		return true;
+
 	for (i = 0; i < XPAD_NUM_OUT_PACKETS; i++) {
 		if (++xpad->last_out_packet >= XPAD_NUM_OUT_PACKETS)
 			xpad->last_out_packet = 0;
@@ -940,24 +1035,17 @@ static int xpad_inquiry_pad_presence(struct usb_xpad *xpad)
 
 static int xpad_start_xbox_one(struct usb_xpad *xpad)
 {
-	struct xpad_output_packet *packet =
-			&xpad->out_packets[XPAD_OUT_CMD_IDX];
 	unsigned long flags;
 	int retval;
 
 	spin_lock_irqsave(&xpad->odata_lock, flags);
 
-	/* Xbox one controller needs to be initialized. */
-	packet->data[0] = 0x05;
-	packet->data[1] = 0x20;
-	packet->data[2] = xpad->odata_serial++; /* packet serial */
-	packet->data[3] = 0x01; /* rumble bit enable?  */
-	packet->data[4] = 0x00;
-	packet->len = 5;
-	packet->pending = true;
-
-	/* Reset the sequence so we send out start packet first */
-	xpad->last_out_packet = -1;
+	/*
+	 * Begin the init sequence by attempting to send a packet.
+	 * We will cycle through the init packet sequence before
+	 * sending any packets from the output ring.
+	 */
+	xpad->init_seq = 0;
 	retval = xpad_try_sending_next_out_packet(xpad);
 
 	spin_unlock_irqrestore(&xpad->odata_lock, flags);
-- 
2.17.1



