Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0911BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFC5221019
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mDyMMuir"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFC5221019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729512AbeK3BUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:20:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:41742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728241AbeK3BUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:20:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05F3A205C9;
        Thu, 29 Nov 2018 14:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543500911;
        bh=abKbIPimvKHsyQrPd4X+tY+21E09YkM58iVzatPYGF8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mDyMMuirlf/TnDcZ4EX4tIWrOv5Y5u+7Fx94SrLL/amuYcyCVk6/Zq9hBG+pxypIz
         henyz30tZz/fqQnJn/YvybOT98Y4DDOXW4TgNFYDTqP9r1OcExRTKD/J7rByIUI9Su
         dt9FMcRypgyKAWqyCduC384rQj9Cr+O+VvbA5uSg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Cameron Gutman <aicommander@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 49/83] Input: xpad - power off wireless 360 controllers on suspend
Date:   Thu, 29 Nov 2018 15:12:07 +0100
Message-Id: <20181129140140.464684304@linuxfoundation.org>
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

[ Upstream commit f712a5a05228058f6b74635546549d4a46e117fc ]

When the USB wireless adapter is suspended, the controllers
lose their connection. This causes them to start flashing
their LED rings and searching for the wireless adapter
again, wasting the controller's battery power.

Instead, we will tell the controllers to power down when
we suspend. This mirrors the behavior of the controllers
when connected to the console itself and how the official
Xbox One wireless adapter behaves on Windows.

Signed-off-by: Cameron Gutman <aicommander@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/joystick/xpad.c | 43 +++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 05a5c647ed36..9cbd485c0f73 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -115,6 +115,10 @@ static bool sticks_to_null;
 module_param(sticks_to_null, bool, S_IRUGO);
 MODULE_PARM_DESC(sticks_to_null, "Do not map sticks at all for unknown pads");
 
+static bool auto_poweroff = true;
+module_param(auto_poweroff, bool, S_IWUSR | S_IRUGO);
+MODULE_PARM_DESC(auto_poweroff, "Power off wireless controllers on suspend");
+
 static const struct xpad_device {
 	u16 idVendor;
 	u16 idProduct;
@@ -1250,6 +1254,36 @@ static void xpad_stop_input(struct usb_xpad *xpad)
 	usb_kill_urb(xpad->irq_in);
 }
 
+static void xpad360w_poweroff_controller(struct usb_xpad *xpad)
+{
+	unsigned long flags;
+	struct xpad_output_packet *packet =
+			&xpad->out_packets[XPAD_OUT_CMD_IDX];
+
+	spin_lock_irqsave(&xpad->odata_lock, flags);
+
+	packet->data[0] = 0x00;
+	packet->data[1] = 0x00;
+	packet->data[2] = 0x08;
+	packet->data[3] = 0xC0;
+	packet->data[4] = 0x00;
+	packet->data[5] = 0x00;
+	packet->data[6] = 0x00;
+	packet->data[7] = 0x00;
+	packet->data[8] = 0x00;
+	packet->data[9] = 0x00;
+	packet->data[10] = 0x00;
+	packet->data[11] = 0x00;
+	packet->len = 12;
+	packet->pending = true;
+
+	/* Reset the sequence so we send out poweroff now */
+	xpad->last_out_packet = -1;
+	xpad_try_sending_next_out_packet(xpad);
+
+	spin_unlock_irqrestore(&xpad->odata_lock, flags);
+}
+
 static int xpad360w_start_input(struct usb_xpad *xpad)
 {
 	int error;
@@ -1592,6 +1626,15 @@ static int xpad_suspend(struct usb_interface *intf, pm_message_t message)
 		 * or goes away.
 		 */
 		xpad360w_stop_input(xpad);
+
+		/*
+		 * The wireless adapter is going off now, so the
+		 * gamepads are going to become disconnected.
+		 * Unless explicitly disabled, power them down
+		 * so they don't just sit there flashing.
+		 */
+		if (auto_poweroff && xpad->pad_present)
+			xpad360w_poweroff_controller(xpad);
 	} else {
 		mutex_lock(&input->mutex);
 		if (input->users)
-- 
2.17.1



