Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF50C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E916021019
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JepuNSyZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E916021019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731187AbeK3BZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:25:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:48512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729806AbeK3BZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:25:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 436C9205C9;
        Thu, 29 Nov 2018 14:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501181;
        bh=croHeKjKpyUxh+VnwS1NDWjhEXXJc+2QpLrDaGz9wcQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JepuNSyZquMYtqNXSFccdv36PaauT9bB79IkXGf+jEgIKhX+I+i7Subml2wUrdklU
         OztTQrDi7gxadMEJpNjAu5Pxa0C0w/xC7ptXrlVK/7GBpxwvEqDi8Ps9hhxGh4MbU6
         MltYxSU/6LXauJ2fN71qDkr0/AFMakXiUkKSOQuE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Cameron Gutman <aicommander@gmail.com>,
        Pavel Rojtberg <rojtberg@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 40/86] Input: xpad - prevent spurious input from wired Xbox 360 controllers
Date:   Thu, 29 Nov 2018 15:12:05 +0100
Message-Id: <20181129140113.493836828@linuxfoundation.org>
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

[ Upstream commit 1ff5fa3c6732f08e01ae12f12286d4728c9e4d86 ]

After initially connecting a wired Xbox 360 controller or sending it
a command to change LEDs, a status/response packet is interpreted as
controller input. This causes the state of buttons represented in
byte 2 of the controller data packet to be incorrect until the next
valid input packet. Wireless Xbox 360 controllers are not affected.

Writing a new value to the LED device while holding the Start button
and running jstest is sufficient to reproduce this bug. An event will
come through with the Start button released.

Xboxdrv also won't attempt to read controller input from a packet
where byte 0 is non-zero. It also checks that byte 1 is 0x14, but
that value differs between wired and wireless controllers and this
code is shared by both. I think just checking byte 0 is enough to
eliminate unwanted packets.

The following are some examples of 3-byte status packets I saw:
01 03 02
02 03 00
03 03 03
08 03 00

Signed-off-by: Cameron Gutman <aicommander@gmail.com>
Signed-off-by: Pavel Rojtberg <rojtberg@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/joystick/xpad.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 5f47e062cada..a49be8bc5819 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -459,6 +459,10 @@ static void xpad_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char *d
 static void xpad360_process_packet(struct usb_xpad *xpad, struct input_dev *dev,
 				   u16 cmd, unsigned char *data)
 {
+	/* valid pad data */
+	if (data[0] != 0x00)
+		return;
+
 	/* digital pad */
 	if (xpad->mapping & MAP_DPAD_TO_BUTTONS) {
 		/* dpad as buttons (left, right, up, down) */
-- 
2.17.1



