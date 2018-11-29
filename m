Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3935C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B743221104
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHq+VMV4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B743221104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbeK3BT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:19:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:40734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729176AbeK3BT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:19:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB5A9205C9;
        Thu, 29 Nov 2018 14:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543500869;
        bh=UbytQRzln1U3xmF0DZm98P9qOSr8QIOtUKJoFn29eD0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XHq+VMV4AqaCH6ftj9SBEOy7BCV+eaTAX/f+6gtd/WPc4uLjbONZA8JdHLqdzIebM
         /OSA8DDzRoukGxLpGGPpi/8BEGQxGudpSI9ewWP7g0C3RLfQR0xjIlIXmCZfHgoFG7
         8g/rCUFS7gOCAR0JE+CXUqCiCff3rXgJRYDECmV4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Rojtberg <rojtberg@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 30/83] Input: xpad - x360w: report dpad as buttons and axes
Date:   Thu, 29 Nov 2018 15:11:48 +0100
Message-Id: <20181129140139.661352785@linuxfoundation.org>
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

[ Upstream commit 5ee8bda943de20017636845a5c8d7069a4a283b8 ]

as discussed here[0], x360w is the only pad that maps dpad_to_button.
This is bad for downstream developers as they have to differ between
x360 and x360w which is not intuitive.

This patch implements the suggested solution of exposing the dpad both
as axes and as buttons. This retains backward compatibility with software
already dealing with the difference while makes new software work as
expected across x360/ x360w pads.

[0] http://www.spinics.net/lists/linux-input/msg34421.html

Signed-off-by: Pavel Rojtberg <rojtberg@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/joystick/xpad.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index fc81473b6e35..f6e96741ff0e 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -437,7 +437,16 @@ static void xpad360_process_packet(struct usb_xpad *xpad,
 		input_report_key(dev, BTN_TRIGGER_HAPPY2, data[2] & 0x08);
 		input_report_key(dev, BTN_TRIGGER_HAPPY3, data[2] & 0x01);
 		input_report_key(dev, BTN_TRIGGER_HAPPY4, data[2] & 0x02);
-	} else {
+	}
+
+	/*
+	 * This should be a simple else block. However historically
+	 * xbox360w has mapped DPAD to buttons while xbox360 did not. This
+	 * made no sense, but now we can not just switch back and have to
+	 * support both behaviors.
+	 */
+	if (!(xpad->mapping & MAP_DPAD_TO_BUTTONS) ||
+	    xpad->xtype == XTYPE_XBOX360W) {
 		input_report_abs(dev, ABS_HAT0X,
 				 !!(data[2] & 0x08) - !!(data[2] & 0x04));
 		input_report_abs(dev, ABS_HAT0Y,
@@ -1163,7 +1172,16 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 	if (xpad->mapping & MAP_DPAD_TO_BUTTONS) {
 		for (i = 0; xpad_btn_pad[i] >= 0; i++)
 			__set_bit(xpad_btn_pad[i], input_dev->keybit);
-	} else {
+	}
+
+	/*
+	 * This should be a simple else block. However historically
+	 * xbox360w has mapped DPAD to buttons while xbox360 did not. This
+	 * made no sense, but now we can not just switch back and have to
+	 * support both behaviors.
+	 */
+	if (!(xpad->mapping & MAP_DPAD_TO_BUTTONS) ||
+	    xpad->xtype == XTYPE_XBOX360W) {
 		for (i = 0; xpad_abs_pad[i] >= 0; i++)
 			xpad_set_up_abs(input_dev, xpad_abs_pad[i]);
 	}
-- 
2.17.1



