Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1A3C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F033621872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547216601;
	bh=pLx8NIYYMGNcvk8v726PvbziVfvDxmV2zj04Ukyk+w0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KRxSfDurwT8d2SPAWUJTFuLxwADz8ZpSbwhueSyuoU1XnJ0i+Eo+GJlc9FR/T4yAH
	 sBTSyXS6eHWinB7cQhcu71lCzeJ3NTuPVy9LR2QpUQEarMexqula2KYMPFNFPxFZB1
	 93f7qZaGqtnDaXxMr3qcylP4UnDeplaCGZVBhN4Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388015AbfAKOXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:23:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:35402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387991AbfAKOSx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:18:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 370E321783;
        Fri, 11 Jan 2019 14:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216332;
        bh=pLx8NIYYMGNcvk8v726PvbziVfvDxmV2zj04Ukyk+w0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=be3pgeOV2eGQKcHvjiU7lcyio5A0avG0fEBWj/GF88h+eewKHgUpIHXwyBtKpSL+J
         HVZJk82DK94RsruItlLhrs45whZLcg4y45+voxD4iYEMwRo6jllSw4wOM84MiYrwGw
         0cz8DNhuy9Pnr6ulmcdQhytQKtkyRL+O00g8zJD8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Tony Lindgren <tony@atomide.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 62/88] Input: omap-keypad - fix idle configuration to not block SoC idle states
Date:   Fri, 11 Jan 2019 15:08:31 +0100
Message-Id: <20190111131056.479781795@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131045.137499039@linuxfoundation.org>
References: <20190111131045.137499039@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit e2ca26ec4f01486661b55b03597c13e2b9c18b73 ]

With PM enabled, I noticed that pressing a key on the droid4 keyboard will
block deeper idle states for the SoC. Let's fix this by using IRQF_ONESHOT
and stop constantly toggling the device OMAP4_KBD_IRQENABLE register as
suggested by Dmitry Torokhov <dmitry.torokhov@gmail.com>.

>From the hardware point of view, looks like we need to manage the registers
for OMAP4_KBD_IRQENABLE and OMAP4_KBD_WAKEUPENABLE together to avoid
blocking deeper SoC idle states. And with toggling of OMAP4_KBD_IRQENABLE
register now gone with IRQF_ONESHOT, also the SoC idle state problem is
gone during runtime. We still also need to clear OMAP4_KBD_WAKEUPENABLE in
omap4_keypad_close() though to pair it with omap4_keypad_open() to prevent
blocking deeper SoC idle states after rmmod omap4-keypad.

Reported-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/keyboard/omap4-keypad.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/keyboard/omap4-keypad.c
index f78c464899db..3d2c60c8de83 100644
--- a/drivers/input/keyboard/omap4-keypad.c
+++ b/drivers/input/keyboard/omap4-keypad.c
@@ -126,12 +126,8 @@ static irqreturn_t omap4_keypad_irq_handler(int irq, void *dev_id)
 {
 	struct omap4_keypad *keypad_data = dev_id;
 
-	if (kbd_read_irqreg(keypad_data, OMAP4_KBD_IRQSTATUS)) {
-		/* Disable interrupts */
-		kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQENABLE,
-				 OMAP4_VAL_IRQDISABLE);
+	if (kbd_read_irqreg(keypad_data, OMAP4_KBD_IRQSTATUS))
 		return IRQ_WAKE_THREAD;
-	}
 
 	return IRQ_NONE;
 }
@@ -173,11 +169,6 @@ static irqreturn_t omap4_keypad_irq_thread_fn(int irq, void *dev_id)
 	kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQSTATUS,
 			 kbd_read_irqreg(keypad_data, OMAP4_KBD_IRQSTATUS));
 
-	/* enable interrupts */
-	kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQENABLE,
-		OMAP4_DEF_IRQENABLE_EVENTEN |
-				OMAP4_DEF_IRQENABLE_LONGKEY);
-
 	return IRQ_HANDLED;
 }
 
@@ -214,9 +205,10 @@ static void omap4_keypad_close(struct input_dev *input)
 
 	disable_irq(keypad_data->irq);
 
-	/* Disable interrupts */
+	/* Disable interrupts and wake-up events */
 	kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQENABLE,
 			 OMAP4_VAL_IRQDISABLE);
+	kbd_writel(keypad_data, OMAP4_KBD_WAKEUPENABLE, 0);
 
 	/* clear pending interrupts */
 	kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQSTATUS,
@@ -364,7 +356,7 @@ static int omap4_keypad_probe(struct platform_device *pdev)
 	}
 
 	error = request_threaded_irq(keypad_data->irq, omap4_keypad_irq_handler,
-				     omap4_keypad_irq_thread_fn, 0,
+				     omap4_keypad_irq_thread_fn, IRQF_ONESHOT,
 				     "omap4-keypad", keypad_data);
 	if (error) {
 		dev_err(&pdev->dev, "failed to register interrupt\n");
-- 
2.19.1



