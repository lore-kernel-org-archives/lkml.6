Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFCBC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABD9B2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:12:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABD9B2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbeLCXM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 18:12:57 -0500
Received: from muru.com ([72.249.23.125]:56174 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725858AbeLCXM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 18:12:57 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 553B780BF;
        Mon,  3 Dec 2018 23:12:57 +0000 (UTC)
Date:   Mon, 3 Dec 2018 15:12:51 -0800
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
Message-ID: <20181203231251.GB39861@atomide.com>
References: <20181203012933.6647-1-tony@atomide.com>
 <20181203012933.6647-2-tony@atomide.com>
 <20181203192351.GB257010@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203192351.GB257010@dtor-ws>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Dmitry Torokhov <dmitry.torokhov@gmail.com> [181203 19:24]:
> On Sun, Dec 02, 2018 at 05:29:33PM -0800, Tony Lindgren wrote:
...
> > Note that we now must also disable OMAP4_DEF_IRQENABLE_LONGKEY as it
> > should not be used together with debounce according to the TRM.

The above statement is no longer true, it's left over from an
earlier version of this fix, so will drop it.

> > --- a/drivers/input/keyboard/omap4-keypad.c
> > +++ b/drivers/input/keyboard/omap4-keypad.c
> > @@ -127,9 +128,11 @@ static irqreturn_t omap4_keypad_irq_handler(int irq, void *dev_id)
> >  	struct omap4_keypad *keypad_data = dev_id;
> >  
> >  	if (kbd_read_irqreg(keypad_data, OMAP4_KBD_IRQSTATUS)) {
> > -		/* Disable interrupts */
> > +		/* Disable interrupts and wake-up events */
> >  		kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQENABLE,
> >  				 OMAP4_VAL_IRQDISABLE);
> 
> I wonder, do we need to turn off interrupts at keyboard controller
> level, or we should simply use IRQF_ONESHOT?

Oh that's a good idea and seems to work nicely :)

> > +		kbd_writel(keypad_data, OMAP4_KBD_WAKEUPENABLE, 0);
> 
> So we are saying that disabling wakeup for the time between hard
> interrupt firing, and when interrupt thread runs, makes much difference?
> It is surprising to me... How long does it take to schedule interrupt
> thread?

Nope, you're right. Updated patch below.

Regards,

Tony

8< --------------------
From tony Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Mon, 3 Dec 2018 14:12:39 -0800
Subject: [PATCH] Input: omap-keypad: Fix idle configration to not block
 SoC idle states

With PM enabled, I noticed that pressing a key on the droid4 keyboard will
block deeper idle states for the SoC. Looks like we can fix this by
managing the idle register to gether with the interrupt similar to what
we already do for the GPIO controller.

And there's no need to keep enabling and disabling interrupts and
wake-up events for normal use if we use IRQF_ONESHOT as suggested by
Dmitry Torokhov <dmitry.torokhov@gmail.com> so let's do that too.

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
 drivers/input/keyboard/omap4-keypad.c | 30 ++++++++++-----------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/keyboard/omap4-keypad.c
--- a/drivers/input/keyboard/omap4-keypad.c
+++ b/drivers/input/keyboard/omap4-keypad.c
@@ -53,11 +53,12 @@
 /* OMAP4 bit definitions */
 #define OMAP4_DEF_IRQENABLE_EVENTEN	BIT(0)
 #define OMAP4_DEF_IRQENABLE_LONGKEY	BIT(1)
-#define OMAP4_DEF_WUP_EVENT_ENA		BIT(0)
-#define OMAP4_DEF_WUP_LONG_KEY_ENA	BIT(1)
 #define OMAP4_DEF_CTRL_NOSOFTMODE	BIT(1)
 #define OMAP4_DEF_CTRL_PTV_SHIFT	2
 
+#define OMAP4_KBD_IRQ_MASK		(OMAP4_DEF_IRQENABLE_LONGKEY | \
+					 OMAP4_DEF_IRQENABLE_EVENTEN)
+
 /* OMAP4 values */
 #define OMAP4_VAL_IRQDISABLE		0x0
 
@@ -126,12 +127,8 @@ static irqreturn_t omap4_keypad_irq_handler(int irq, void *dev_id)
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
@@ -173,11 +170,6 @@ static irqreturn_t omap4_keypad_irq_thread_fn(int irq, void *dev_id)
 	kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQSTATUS,
 			 kbd_read_irqreg(keypad_data, OMAP4_KBD_IRQSTATUS));
 
-	/* enable interrupts */
-	kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQENABLE,
-		OMAP4_DEF_IRQENABLE_EVENTEN |
-				OMAP4_DEF_IRQENABLE_LONGKEY);
-
 	return IRQ_HANDLED;
 }
 
@@ -197,11 +189,10 @@ static int omap4_keypad_open(struct input_dev *input)
 	/* clear pending interrupts */
 	kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQSTATUS,
 			 kbd_read_irqreg(keypad_data, OMAP4_KBD_IRQSTATUS));
-	kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQENABLE,
-			OMAP4_DEF_IRQENABLE_EVENTEN |
-				OMAP4_DEF_IRQENABLE_LONGKEY);
-	kbd_writel(keypad_data, OMAP4_KBD_WAKEUPENABLE,
-			OMAP4_DEF_WUP_EVENT_ENA | OMAP4_DEF_WUP_LONG_KEY_ENA);
+
+	/* enable interrupts and wake-up events */
+	kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQENABLE, OMAP4_KBD_IRQ_MASK);
+	kbd_writel(keypad_data, OMAP4_KBD_WAKEUPENABLE, OMAP4_KBD_IRQ_MASK);
 
 	enable_irq(keypad_data->irq);
 
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
