Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65553C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CFB221104
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zh6l6yS/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CFB221104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729111AbeK3BTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:19:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:40480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728198AbeK3BTr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:19:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79B1C208E7;
        Thu, 29 Nov 2018 14:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543500856;
        bh=KXjsSbcaILZE7AuSfoXyyuP3oG4dpxFHZTllPS2ZW4A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zh6l6yS/TzB1T+l5TnnLAs8n6ON7VSQWD8feYK88TGpOGf5XXO6OfcOKNsSG7TXCr
         Fb2hwLEloDmLvS61EnPh4Og9vv81uHu+WnSJWhgh18K2KuknF16tasDNLTLyMqdaBs
         qVSlfjQGKgbu+GD1K7w8Cxw62DssKLeveLN6g1Cs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Rojtberg <rojtberg@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 26/83] Input: xpad - clarify LED enumeration
Date:   Thu, 29 Nov 2018 15:11:44 +0100
Message-Id: <20181129140139.484218666@linuxfoundation.org>
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

[ Upstream commit 1f6f02b728eef0d937d5138ae60dbf8fbd045f3e ]

Rename led_no -> pad_nr: the number stored there is not the LED number - it
gets translated later on to a LED number in xpad_identify_controller;

Signed-off-by: Pavel Rojtberg <rojtberg@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/joystick/xpad.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index e9a2e2d89772..60ebd78a49a6 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -347,7 +347,7 @@ struct usb_xpad {
 
 	int mapping;			/* map d-pad to buttons or to axes */
 	int xtype;			/* type of xbox device */
-	unsigned long led_no;		/* led to lit on xbox360 controllers */
+	unsigned long pad_nr;		/* the order x360 pads were attached */
 };
 
 /*
@@ -359,7 +359,6 @@ struct usb_xpad {
  *	The used report descriptor was taken from ITO Takayukis website:
  *	 http://euc.jp/periphs/xbox-controller.ja.html
  */
-
 static void xpad_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char *data)
 {
 	struct input_dev *dev = xpad->dev;
@@ -508,7 +507,6 @@ static void xpad_identify_controller(struct usb_xpad *xpad);
  * 01.1 - Pad state (Bytes 4+) valid
  *
  */
-
 static void xpad360w_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char *data)
 {
 	/* Presence change */
@@ -893,6 +891,7 @@ struct xpad_led {
 };
 
 /**
+ * set the LEDs on Xbox360 / Wireless Controllers
  * @param command
  *  0: off
  *  1: all blink, then previous setting
@@ -945,10 +944,13 @@ static void xpad_send_led_command(struct usb_xpad *xpad, int command)
 	mutex_unlock(&xpad->odata_mutex);
 }
 
+/*
+ * Light up the segment corresponding to the pad number on
+ * Xbox 360 Controllers.
+ */
 static void xpad_identify_controller(struct usb_xpad *xpad)
 {
-	/* Light up the segment corresponding to controller number */
-	xpad_send_led_command(xpad, (xpad->led_no % 4) + 2);
+	xpad_send_led_command(xpad, (xpad->pad_nr % 4) + 2);
 }
 
 static void xpad_led_set(struct led_classdev *led_cdev,
@@ -974,9 +976,9 @@ static int xpad_led_probe(struct usb_xpad *xpad)
 	if (!led)
 		return -ENOMEM;
 
-	xpad->led_no = atomic_inc_return(&led_seq);
+	xpad->pad_nr = atomic_inc_return(&led_seq);
 
-	snprintf(led->name, sizeof(led->name), "xpad%lu", xpad->led_no);
+	snprintf(led->name, sizeof(led->name), "xpad%lu", xpad->pad_nr);
 	led->xpad = xpad;
 
 	led_cdev = &led->led_cdev;
-- 
2.17.1



