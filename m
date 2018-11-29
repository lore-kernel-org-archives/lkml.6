Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0D2C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5AE021019
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YP+dCf5d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5AE021019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730796AbeK3BYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:24:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:46642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729264AbeK3BYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:24:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01286205C9;
        Thu, 29 Nov 2018 14:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501114;
        bh=VhShQ7dEEAV0SPUFjYZhWVfBTRslI47S7dAPyNMoe98=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YP+dCf5dfcIcyU8v463qID4lnPBi+nMK3P+nUumh7rRfH8MEAT2ljSY2Qf+/MVhnn
         ODTh1HaeGimt8j4UCDcki/06VACT0Hbw/YK7ZKA/uQUvmf6APDPlHyTb9r2J0LZJh6
         Z8GT6Tt+L1J163IGUkrvez4ADoD0cWdWtqtBblWc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Rojtberg <rojtberg@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 49/86] Input: xpad - simplify error condition in init_output
Date:   Thu, 29 Nov 2018 15:12:14 +0100
Message-Id: <20181129140114.301437300@linuxfoundation.org>
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

[ Upstream commit a8c34e27fb1ece928ec728bfe596aa6ca0b1928a ]

Replace first goto with simple returns as we really are just returning
one error code.

Signed-off-by: Pavel Rojtberg <rojtberg@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/joystick/xpad.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index b06f4b0785f7..d837900d609e 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -851,17 +851,15 @@ static int xpad_init_output(struct usb_interface *intf, struct usb_xpad *xpad)
 
 	xpad->odata = usb_alloc_coherent(xpad->udev, XPAD_PKT_LEN,
 					 GFP_KERNEL, &xpad->odata_dma);
-	if (!xpad->odata) {
-		error = -ENOMEM;
-		goto fail1;
-	}
+	if (!xpad->odata)
+		return -ENOMEM;
 
 	spin_lock_init(&xpad->odata_lock);
 
 	xpad->irq_out = usb_alloc_urb(0, GFP_KERNEL);
 	if (!xpad->irq_out) {
 		error = -ENOMEM;
-		goto fail2;
+		goto err_free_coherent;
 	}
 
 	/* Xbox One controller has in/out endpoints swapped. */
@@ -877,8 +875,9 @@ static int xpad_init_output(struct usb_interface *intf, struct usb_xpad *xpad)
 
 	return 0;
 
- fail2:	usb_free_coherent(xpad->udev, XPAD_PKT_LEN, xpad->odata, xpad->odata_dma);
- fail1:	return error;
+err_free_coherent:
+	usb_free_coherent(xpad->udev, XPAD_PKT_LEN, xpad->odata, xpad->odata_dma);
+	return error;
 }
 
 static void xpad_stop_output(struct usb_xpad *xpad)
-- 
2.17.1



