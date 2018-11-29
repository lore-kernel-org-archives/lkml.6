Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9253DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58A1F208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sGhK44gN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58A1F208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729681AbeK3BVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:21:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:42274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728241AbeK3BVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:21:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FCB3208E7;
        Thu, 29 Nov 2018 14:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543500935;
        bh=e9NJlbHe/xhdbyY7v9w+45TkH3HG/M47KHi95nwDxOE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sGhK44gNkqpCszfibdOtLyoUIYzpseMjTnEKAawk1CzpjB+PYaYTsiji5gQDZUfxI
         5sYe3fQJ214RhHIewCpXQJhLwGT9o2eY248rLTRz/TP5q+MU3DkDm7+BgH2HK8Ktgt
         HOjbyZgSUCM3+PdlxrtEuuU4/hNo2Aybxo3FT0nU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Cameron Gutman <aicommander@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 58/83] Input: xpad - restore LED state after device resume
Date:   Thu, 29 Nov 2018 15:12:16 +0100
Message-Id: <20181129140140.948151230@linuxfoundation.org>
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

[ Upstream commit a1fbf5bbef025b4844162b3b8868888003a7ee9c ]

Set the LED_CORE_SUSPENDRESUME flag on our LED device so the
LED state will be automatically restored by LED core on resume.

Since Xbox One pads stop flashing only when reinitialized, we'll
send them the initialization packet so they calm down too.

Signed-off-by: Cameron Gutman <aicommander@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/joystick/xpad.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 14da79ead653..153b1ee13e03 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -1213,6 +1213,7 @@ static int xpad_led_probe(struct usb_xpad *xpad)
 	led_cdev = &led->led_cdev;
 	led_cdev->name = led->name;
 	led_cdev->brightness_set = xpad_led_set;
+	led_cdev->flags = LED_CORE_SUSPENDRESUME;
 
 	error = led_classdev_register(&xpad->udev->dev, led_cdev);
 	if (error)
@@ -1689,8 +1690,16 @@ static int xpad_resume(struct usb_interface *intf)
 		retval = xpad360w_start_input(xpad);
 	} else {
 		mutex_lock(&input->mutex);
-		if (input->users)
+		if (input->users) {
 			retval = xpad_start_input(xpad);
+		} else if (xpad->xtype == XTYPE_XBOXONE) {
+			/*
+			 * Even if there are no users, we'll send Xbox One pads
+			 * the startup sequence so they don't sit there and
+			 * blink until somebody opens the input device again.
+			 */
+			retval = xpad_start_xbox_one(xpad);
+		}
 		mutex_unlock(&input->mutex);
 	}
 
-- 
2.17.1



