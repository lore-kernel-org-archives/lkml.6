Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D107C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1B92214DB
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:09:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1B92214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbeLDTJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 14:09:37 -0500
Received: from muru.com ([72.249.23.125]:56430 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbeLDTJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 14:09:37 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 41F8D80FA;
        Tue,  4 Dec 2018 19:09:38 +0000 (UTC)
Date:   Tue, 4 Dec 2018 11:09:32 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, Axel Haslam <axelhaslam@ti.com>,
        Illia Smyrnov <illia.smyrnov@ti.com>,
        Marcel Partap <mpartap@gmx.net>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Michael Scott <hashcode0f@gmail.com>,
        NeKit <nekit1000@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 2/2] Input: omap-keypad: Fix idle configration to not
 block SoC idle states
Message-ID: <20181204190932.GD6707@atomide.com>
References: <20181203012933.6647-1-tony@atomide.com>
 <20181203012933.6647-2-tony@atomide.com>
 <20181203192351.GB257010@dtor-ws>
 <20181203231251.GB39861@atomide.com>
 <20181204040001.GA239923@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204040001.GA239923@dtor-ws>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Dmitry Torokhov <dmitry.torokhov@gmail.com> [181204 04:00]:
> Hi Tony,
> 
> On Mon, Dec 03, 2018 at 03:12:51PM -0800, Tony Lindgren wrote:
> > 
> > With PM enabled, I noticed that pressing a key on the droid4 keyboard will
> > block deeper idle states for the SoC. Looks like we can fix this by
> > managing the idle register to gether with the interrupt similar to what
> > we already do for the GPIO controller.
> 
> Can you show me where exactly we are doing this? I can't seem to find
> the matching code.

With your change it now becomes the fix, and we're just missing the
clearing of the OMAP4_KBD_WAKEUPENABLE register in omap4_keypad_close.

Does the following minimal version with updated comments make
more sense now?

Regards,

Tony

8< --------------
From tony Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Tue, 4 Dec 2018 11:07:56 -0800
Subject: [PATCH] Input: omap-keypad: Fix idle configration to not block
 SoC idle states

With PM enabled, I noticed that pressing a key on the droid4 keyboard will
block deeper idle states for the SoC. Let's fix this by using IRQF_ONESHOT
and stop constantly toggling the device OMAP4_KBD_IRQENABLE register as
suggested by Dmitry Torokhov <dmitry.torokhov@gmail.com>.

From the hardware point of view, looks like we need to manage the registers
for OMAP4_KBD_IRQENABLE and OMAP4_KBD_WAKEUPENABLE together to avoid
blocking deeper SoC idle states. And with toggling of OMAP4_KBD_IRQENABLE
register now gone with IRQF_ONESHOT, also the SoC idle state problem is
gone during runtime. We still also need to clear OMAP4_KBD_WAKEUPENABLE in
omap4_keypad_close() though to pair it with omap4_keypad_open() to prevent
blocking deeper SoC idle states after rmmod omap4-keypad.

Cc: Axel Haslam <axelhaslam@ti.com>
Cc: Illia Smyrnov <illia.smyrnov@ti.com>
Cc: Marcel Partap <mpartap@gmx.net>
Cc: Merlijn Wajer <merlijn@wizzup.org>
Cc: Michael Scott <hashcode0f@gmail.com>
Cc: NeKit <nekit1000@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>
Reported-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/input/keyboard/omap4-keypad.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/keyboard/omap4-keypad.c
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
@@ -365,7 +357,7 @@ static int omap4_keypad_probe(struct platform_device *pdev)
 	}
 
 	error = request_threaded_irq(keypad_data->irq, omap4_keypad_irq_handler,
-				     omap4_keypad_irq_thread_fn, 0,
+				     omap4_keypad_irq_thread_fn, IRQF_ONESHOT,
 				     "omap4-keypad", keypad_data);
 	if (error) {
 		dev_err(&pdev->dev, "failed to register interrupt\n");
-- 
2.19.2
