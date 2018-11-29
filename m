Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19490C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6CC721019
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iq/LQfbx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6CC721019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729429AbeK3BUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:20:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:41432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729379AbeK3BU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:20:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EADA221104;
        Thu, 29 Nov 2018 14:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543500899;
        bh=SuavPrg/c5YMZmK4yL/YNVzmx8brJayaetYepH3of6I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iq/LQfbxMEiBzXxyp662aZ3vp1Da3l+lJHyLM8tIUarc4293x4OF1AsA2vQ3gWG4G
         leGmN+LojV1f0wxZ0ER4JDpzz0Tt1srt2o93UF4k6oVMtAVRvNxIHcE4bfqsx7dOrH
         wIl4QgJl9Fmef2c6sDfr3ppoJh+oaBHFjYEPruEM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Cameron Gutman <aicommander@gmail.com>,
        Pavel Rojtberg <rojtberg@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 44/83] Input: xpad - prevent spurious input from wired Xbox 360 controllers
Date:   Thu, 29 Nov 2018 15:12:02 +0100
Message-Id: <20181129140140.237998470@linuxfoundation.org>
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
index c8add0e425b5..43b09dbacee6 100644
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



