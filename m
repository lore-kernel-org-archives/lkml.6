Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089ABC43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C016021104
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="13+6ngLt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C016021104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729890AbeK3BVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:21:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:43054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729873AbeK3BVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:21:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEE14205C9;
        Thu, 29 Nov 2018 14:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543500969;
        bh=ePe6se3aIngbGt4c5ZisjZ88TrdZx3R/G+go6mq/juU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=13+6ngLtzEMozHn4nHSy/lX6hhgPe9f4mCDfCteUFJBhT8vBRj6WgBwQUxGd7tdbV
         5FNlOw1DoA8QOR9GHbMFDi5KFuu9l+NXtSw6TlTszN2pJdeWRtrT7RO6HYMNGoquJe
         75IpIS7ks9MWFYRpFp+UAoKcUWis4GYwsCGEsU94=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Rojtberg <rojtberg@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 37/83] Input: xpad - update Xbox One Force Feedback Support
Date:   Thu, 29 Nov 2018 15:11:55 +0100
Message-Id: <20181129140139.950307616@linuxfoundation.org>
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

[ Upstream commit 2a6d7527b35cf987260800807e328d167aef22ac ]

There's apparently a serial number woven into both input and output
packets; neglecting to specify a valid serial number causes the controller
to ignore the rumble packets.

The scale of the rumble was also apparently halved in the packets.

The initialization packet had to be changed to allow force feedback to
work.

see https://github.com/paroj/xpad/issues/7 for details.

Signed-off-by: Pavel Rojtberg <rojtberg@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/joystick/xpad.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index f2af62d18746..68197239e327 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -350,6 +350,7 @@ struct usb_xpad {
 	struct urb *irq_out;		/* urb for interrupt out report */
 	bool irq_out_active;		/* we must not use an active URB */
 	unsigned char *odata;		/* output data */
+	u8 odata_serial;		/* serial number for xbox one protocol */
 	dma_addr_t odata_dma;
 	spinlock_t odata_lock;
 
@@ -925,7 +926,10 @@ static int xpad_start_xbox_one(struct usb_xpad *xpad)
 	/* Xbox one controller needs to be initialized. */
 	packet->data[0] = 0x05;
 	packet->data[1] = 0x20;
-	packet->len = 2;
+	packet->data[2] = xpad->odata_serial++; /* packet serial */
+	packet->data[3] = 0x01; /* rumble bit enable?  */
+	packet->data[4] = 0x00;
+	packet->len = 5;
 	packet->pending = true;
 
 	/* Reset the sequence so we send out start packet first */
@@ -1000,17 +1004,18 @@ static int xpad_play_effect(struct input_dev *dev, void *data, struct ff_effect
 	case XTYPE_XBOXONE:
 		packet->data[0] = 0x09; /* activate rumble */
 		packet->data[1] = 0x08;
-		packet->data[2] = 0x00;
+		packet->data[2] = xpad->odata_serial++;
 		packet->data[3] = 0x08; /* continuous effect */
 		packet->data[4] = 0x00; /* simple rumble mode */
 		packet->data[5] = 0x03; /* L and R actuator only */
 		packet->data[6] = 0x00; /* TODO: LT actuator */
 		packet->data[7] = 0x00; /* TODO: RT actuator */
-		packet->data[8] = strong / 256;	/* left actuator */
-		packet->data[9] = weak / 256;	/* right actuator */
+		packet->data[8] = strong / 512;	/* left actuator */
+		packet->data[9] = weak / 512;	/* right actuator */
 		packet->data[10] = 0x80;	/* length of pulse */
 		packet->data[11] = 0x00;	/* stop period of pulse */
-		packet->len = 12;
+		packet->data[12] = 0x00;
+		packet->len = 13;
 		packet->pending = true;
 		break;
 
-- 
2.17.1



