Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB0D3C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B261921104
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sDbzG5As"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B261921104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729630AbeK3BU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:20:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:42096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728241AbeK3BU6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:20:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1882205C9;
        Thu, 29 Nov 2018 14:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543500928;
        bh=nP6EfemA2vO9kJkGOOPXM8Lg1jMiOfP+vv69z1hIaok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sDbzG5AsNv/XdOlEFVOXeyPkAtuyYanD/p4QQYVQuL2rlE38NQ9cv4Xlrrqvz/SVC
         fxf6qmQp+kT2nDOWcWY7gsrCL3ukboX/SLPtLEKKguM6Y1bwNeDmTFN9nQD0z0VA4K
         8cTbXzt87sAxNU5P3sVt6Wp0oSw3pxPwYa/97Ku0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Rojtberg <rojtberg@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 55/83] Input: xpad - simplify error condition in init_output
Date:   Thu, 29 Nov 2018 15:12:13 +0100
Message-Id: <20181129140140.737903961@linuxfoundation.org>
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



