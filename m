Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AFCCC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B427E2156B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6gZ0i0j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B427E2156B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbeJHWj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:39:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:59456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727836AbeJHWj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:39:56 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D454721531;
        Mon,  8 Oct 2018 15:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539012461;
        bh=S34kyZAKiyhY+RnYNCLvJcaVMoEV3jmaQ6l+KeZQG2I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E6gZ0i0j/tZJF7VA7WWq8uvy6XaTI7wv9vd+v/AJMwlbONJCc6256S3cbb3gnxhM1
         GPghzG9sFfTcFC5MnLUSBFtz89Vfa69XUz7E+rqdfqUdpqE1nZTARqT0LgZS/QwYDY
         reJNZZd6oqYp+25odllR4v9pwa2x/2MIazROqzYg=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 5/9] Input: atakbd - fix Atari CapsLock behaviour
Date:   Mon,  8 Oct 2018 11:27:30 -0400
Message-Id: <20181008152734.70962-5-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008152734.70962-1-sashal@kernel.org>
References: <20181008152734.70962-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Schmitz <schmitzmic@gmail.com>

[ Upstream commit 52d2c7bf7c90217fbe875d2d76f310979c48eb83 ]

The CapsLock key on Atari keyboards is not a toggle, it does send the
normal make and break scancodes.

Drop the CapsLock toggle handling code, which did cause the CapsLock
key to merely act as a Shift key.

Tested-by: Michael Schmitz <schmitzmic@gmail.com>
Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/input/keyboard/atakbd.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/input/keyboard/atakbd.c b/drivers/input/keyboard/atakbd.c
index 524a72bee55a..fdeda0b0fbd6 100644
--- a/drivers/input/keyboard/atakbd.c
+++ b/drivers/input/keyboard/atakbd.c
@@ -189,14 +189,8 @@ static void atakbd_interrupt(unsigned char scancode, char down)
 
 		scancode = atakbd_keycode[scancode];
 
-		if (scancode == KEY_CAPSLOCK) {	/* CapsLock is a toggle switch key on Amiga */
-			input_report_key(atakbd_dev, scancode, 1);
-			input_report_key(atakbd_dev, scancode, 0);
-			input_sync(atakbd_dev);
-		} else {
-			input_report_key(atakbd_dev, scancode, down);
-			input_sync(atakbd_dev);
-		}
+		input_report_key(atakbd_dev, scancode, down);
+		input_sync(atakbd_dev);
 	} else				/* scancodes >= 0xf3 are mouse data, most likely */
 		printk(KERN_INFO "atakbd: unhandled scancode %x\n", scancode);
 
-- 
2.17.1

