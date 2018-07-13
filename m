Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13D6ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 20:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE9CF20875
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 20:09:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE9CF20875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731962AbeGMUZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 16:25:39 -0400
Received: from mail.ispras.ru ([83.149.199.45]:49490 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731342AbeGMUZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 16:25:39 -0400
Received: from localhost.localdomain (ppp85-140-182-44.pppoe.mtu-net.ru [85.140.182.44])
        by mail.ispras.ru (Postfix) with ESMTPSA id 53B83540094;
        Fri, 13 Jul 2018 23:09:30 +0300 (MSK)
From:   Alexey Khoroshilov <khoroshilov@ispras.ru>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: [PATCH] Input: pxrc - fix leak of usb_device
Date:   Fri, 13 Jul 2018 23:07:57 +0300
Message-Id: <1531512477-31981-1-git-send-email-khoroshilov@ispras.ru>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pxrc_probe() calls usb_get_dev(), but there is no usb_put_dev()
anywhere in the driver.

The patch adds one to error handling code and to pxrc_disconnect().

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/input/joystick/pxrc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/joystick/pxrc.c b/drivers/input/joystick/pxrc.c
index 07a0dbd3ced2..0a31de63ac8e 100644
--- a/drivers/input/joystick/pxrc.c
+++ b/drivers/input/joystick/pxrc.c
@@ -221,6 +221,7 @@ static int pxrc_probe(struct usb_interface *intf,
 	usb_free_urb(pxrc->urb);
 
 error:
+	usb_put_dev(pxrc->udev);
 	return retval;
 }
 
@@ -229,6 +230,7 @@ static void pxrc_disconnect(struct usb_interface *intf)
 	struct pxrc *pxrc = usb_get_intfdata(intf);
 
 	usb_free_urb(pxrc->urb);
+	usb_put_dev(pxrc->udev);
 	usb_set_intfdata(intf, NULL);
 }
 
-- 
2.7.4

