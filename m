Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE5EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68CE8205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjwzqg3D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68CE8205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730783AbeK3BYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:24:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:46574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729264AbeK3BYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:24:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94A55208E7;
        Thu, 29 Nov 2018 14:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501112;
        bh=0oZ5M1I8EJEDDbBqG6UbEwpw2Q/7ZMJv02jBVGBhUMQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bjwzqg3DaEAxlaAKUKDN1d1NYZrOF8B+CdrttTcGu+40VfohLf9Ul+NU8jy9mFhlO
         nYV/HGhO0MYXDsEGQ/W51uUhw9Lx8n4qiFwyuA14z7r9koiSD9eE9Dr9zFFjmu0S4W
         utyld+Wg6CJkPp46QIOS2HYlpEXemy6lwkXddLhc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Rojtberg <rojtberg@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 48/86] Input: xpad - move reporting xbox one home button to common function
Date:   Thu, 29 Nov 2018 15:12:13 +0100
Message-Id: <20181129140114.239467954@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140109.832117862@linuxfoundation.org>
References: <20181129140109.832117862@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 4f88476c75429ba9ab71c428b4cd2f67575bc9c1 ]

xbox one was the only device that has a *_process_buttons routine.

Signed-off-by: Pavel Rojtberg <rojtberg@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/joystick/xpad.c | 52 +++++++++++++----------------------
 1 file changed, 19 insertions(+), 33 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 8b7fc47f7ffb..b06f4b0785f7 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -610,14 +610,28 @@ static void xpad360w_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned cha
 }
 
 /*
- *	xpadone_process_buttons
+ *	xpadone_process_packet
  *
- *	Process a button update packet from an Xbox one controller.
+ *	Completes a request by converting the data into events for the
+ *	input subsystem. This version is for the Xbox One controller.
+ *
+ *	The report format was gleaned from
+ *	https://github.com/kylelemons/xbox/blob/master/xbox.go
  */
-static void xpadone_process_buttons(struct usb_xpad *xpad,
-				struct input_dev *dev,
-				unsigned char *data)
+static void xpadone_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char *data)
 {
+	struct input_dev *dev = xpad->dev;
+
+	/* the xbox button has its own special report */
+	if (data[0] == 0X07) {
+		input_report_key(dev, BTN_MODE, data[4] & 0x01);
+		input_sync(dev);
+		return;
+	}
+	/* check invalid packet */
+	else if (data[0] != 0X20)
+		return;
+
 	/* menu/view buttons */
 	input_report_key(dev, BTN_START,  data[4] & 0x04);
 	input_report_key(dev, BTN_SELECT, data[4] & 0x08);
@@ -680,34 +694,6 @@ static void xpadone_process_buttons(struct usb_xpad *xpad,
 	input_sync(dev);
 }
 
-/*
- *	xpadone_process_packet
- *
- *	Completes a request by converting the data into events for the
- *	input subsystem. This version is for the Xbox One controller.
- *
- *	The report format was gleaned from
- *	https://github.com/kylelemons/xbox/blob/master/xbox.go
- */
-
-static void xpadone_process_packet(struct usb_xpad *xpad,
-				u16 cmd, unsigned char *data)
-{
-	struct input_dev *dev = xpad->dev;
-
-	switch (data[0]) {
-	case 0x20:
-		xpadone_process_buttons(xpad, dev, data);
-		break;
-
-	case 0x07:
-		/* the xbox button has its own special report */
-		input_report_key(dev, BTN_MODE, data[4] & 0x01);
-		input_sync(dev);
-		break;
-	}
-}
-
 static void xpad_irq_in(struct urb *urb)
 {
 	struct usb_xpad *xpad = urb->context;
-- 
2.17.1



