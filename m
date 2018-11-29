Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B563C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12F25208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="chKcyN+4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12F25208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729586AbeK3BUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:20:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:41946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728241AbeK3BUv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:20:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E887208E7;
        Thu, 29 Nov 2018 14:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543500921;
        bh=kXfcLxMJRZk7uEO8YAmgqWDXsvIGtItcSYUq5kmaVJE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=chKcyN+4JnwqUu4vzB1CZHail6VhVP7IEkG0suoGO6O0jxc1nj9AWmXkR3hrZf1C2
         x4Y6oY0Eeo6RRFzg/HHW2fOsGO2Z3xvdlNLkfXQtKPFedMl3uaymlUjNsbVCXVtQCI
         ImJxXJQC4L5mPQ50HZoPO0ehmz6lPBO8oi8iSbUw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Rojtberg <rojtberg@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 52/83] Input: xpad - use correct product id for x360w controllers
Date:   Thu, 29 Nov 2018 15:12:10 +0100
Message-Id: <20181129140140.590308290@linuxfoundation.org>
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

[ Upstream commit b6fc513da50c5dbc457a8ad6b58b046a6a68fd9d ]

currently the controllers get the same product id as the wireless
receiver. However the controllers actually have their own product id.

The patch makes the driver expose the same product id as the windows
driver.

This improves compatibility when running applications with WINE.

see https://github.com/paroj/xpad/issues/54

Signed-off-by: Pavel Rojtberg <rojtberg@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/joystick/xpad.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index fa6c72657f96..b9f48d4e155a 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -1379,6 +1379,12 @@ static int xpad_init_input(struct usb_xpad *xpad)
 	input_dev->name = xpad->name;
 	input_dev->phys = xpad->phys;
 	usb_to_input_id(xpad->udev, &input_dev->id);
+
+	if (xpad->xtype == XTYPE_XBOX360W) {
+		/* x360w controllers and the receiver have different ids */
+		input_dev->id.product = 0x02a1;
+	}
+
 	input_dev->dev.parent = &xpad->intf->dev;
 
 	input_set_drvdata(input_dev, xpad);
-- 
2.17.1



