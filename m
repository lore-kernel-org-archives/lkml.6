Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58895C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20EDB205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tyWE4RCa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20EDB205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730712AbeK3BXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:23:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:46156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729304AbeK3BXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:23:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A0C821104;
        Thu, 29 Nov 2018 14:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501096;
        bh=lUE29AWK9xaBKInqKEo4xq9tnLFSwCFBIQ7ysw74Lak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tyWE4RCatQZ3Pmd+sJoRDslEwl/reuOpigAzY6ahBR0MyJsV+8wqiycInFBx/3IVh
         Spjy2i6dxiDXqYesP0Y3n8Jv02h3KgDnubad4xR/mBnm5XRN5im7UXmI8OV7+lVoyZ
         D2/cEejPZ9pRgmswI+KwKcVwdzt/O0TFpqcvI1iE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Rojtberg <rojtberg@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 34/86] Input: xpad - update Xbox One Force Feedback Support
Date:   Thu, 29 Nov 2018 15:11:59 +0100
Message-Id: <20181129140112.930836165@linuxfoundation.org>
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
index 88de7b17bf7d..bfe94216621f 100644
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



