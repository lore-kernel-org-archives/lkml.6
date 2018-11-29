Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DC2C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E2CD21104
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z1oLLvFK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E2CD21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732609AbeK3B3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:29:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:56524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731464AbeK3B3u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:29:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9F9B21104;
        Thu, 29 Nov 2018 14:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501458;
        bh=b/hs+YFynVpcg5hnH1mJxHBmNsrq2yNVMZ/EOWwthcM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z1oLLvFKD7RHRh3EC4XrWd1+BIwwpTpZmq5pYLWw0DFl5tzJW5dpYe+yR6Nx7HrNi
         lbqRVF2pNqX4qOqibKjucb/MijHvirdzlygx99xF7R5sCsK5Y/jBG7aViufd7jQKjw
         g0t4zXVM5vFa8+mzj+Jr7iLjMHdDi8v3doR7jyLY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 66/92] Input: xpad - avoid using __set_bit() for capabilities
Date:   Thu, 29 Nov 2018 15:12:35 +0100
Message-Id: <20181129140111.650471639@linuxfoundation.org>
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

[ Upstream commit a01308031c2647ed5f1c845104b73a8820a958a9 ]

input_set_capability() and input_set_abs_param() will do it for you.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/joystick/xpad.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index b6e172f22c16..5bf85c43e6d9 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -1579,8 +1579,6 @@ static void xpad_set_up_abs(struct input_dev *input_dev, signed short abs)
 {
 	struct usb_xpad *xpad = input_get_drvdata(input_dev);
 
-	set_bit(abs, input_dev->absbit);
-
 	switch (abs) {
 	case ABS_X:
 	case ABS_Y:
@@ -1599,6 +1597,9 @@ static void xpad_set_up_abs(struct input_dev *input_dev, signed short abs)
 	case ABS_HAT0Y:	/* the d-pad (only if dpad is mapped to axes */
 		input_set_abs_params(input_dev, abs, -1, 1, 0, 0);
 		break;
+	default:
+		input_set_abs_params(input_dev, abs, 0, 0, 0, 0);
+		break;
 	}
 }
 
@@ -1639,10 +1640,7 @@ static int xpad_init_input(struct usb_xpad *xpad)
 		input_dev->close = xpad_close;
 	}
 
-	__set_bit(EV_KEY, input_dev->evbit);
-
 	if (!(xpad->mapping & MAP_STICKS_TO_NULL)) {
-		__set_bit(EV_ABS, input_dev->evbit);
 		/* set up axes */
 		for (i = 0; xpad_abs[i] >= 0; i++)
 			xpad_set_up_abs(input_dev, xpad_abs[i]);
@@ -1650,21 +1648,22 @@ static int xpad_init_input(struct usb_xpad *xpad)
 
 	/* set up standard buttons */
 	for (i = 0; xpad_common_btn[i] >= 0; i++)
-		__set_bit(xpad_common_btn[i], input_dev->keybit);
+		input_set_capability(input_dev, EV_KEY, xpad_common_btn[i]);
 
 	/* set up model-specific ones */
 	if (xpad->xtype == XTYPE_XBOX360 || xpad->xtype == XTYPE_XBOX360W ||
 	    xpad->xtype == XTYPE_XBOXONE) {
 		for (i = 0; xpad360_btn[i] >= 0; i++)
-			__set_bit(xpad360_btn[i], input_dev->keybit);
+			input_set_capability(input_dev, EV_KEY, xpad360_btn[i]);
 	} else {
 		for (i = 0; xpad_btn[i] >= 0; i++)
-			__set_bit(xpad_btn[i], input_dev->keybit);
+			input_set_capability(input_dev, EV_KEY, xpad_btn[i]);
 	}
 
 	if (xpad->mapping & MAP_DPAD_TO_BUTTONS) {
 		for (i = 0; xpad_btn_pad[i] >= 0; i++)
-			__set_bit(xpad_btn_pad[i], input_dev->keybit);
+			input_set_capability(input_dev, EV_KEY,
+					     xpad_btn_pad[i]);
 	}
 
 	/*
@@ -1681,7 +1680,8 @@ static int xpad_init_input(struct usb_xpad *xpad)
 
 	if (xpad->mapping & MAP_TRIGGERS_TO_BUTTONS) {
 		for (i = 0; xpad_btn_triggers[i] >= 0; i++)
-			__set_bit(xpad_btn_triggers[i], input_dev->keybit);
+			input_set_capability(input_dev, EV_KEY,
+					     xpad_btn_triggers[i]);
 	} else {
 		for (i = 0; xpad_abs_triggers[i] >= 0; i++)
 			xpad_set_up_abs(input_dev, xpad_abs_triggers[i]);
-- 
2.17.1



