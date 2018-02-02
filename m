Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751993AbeBBQFs (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 11:05:48 -0500
Received: from m15-59.126.com ([220.181.15.59]:49057 "EHLO m15-59.126.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751651AbeBBQFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 11:05:40 -0500
X-Originating-IP: [123.139.75.126]
Date: Sat, 3 Feb 2018 00:05:39 +0800 (CST)
From: =?UTF-8?B?5byg5rOi?= <zbsdta@126.com>
To: linux-kernel@vger.kernel.org
Subject: Fix matrix keypad does not response with matrix_keypad driver in
 specific condition.
X-Priority: 3
X-Mailer: Coremail Webmail Server Version SP_ntes V3.5 build
 20160729(86883.8884) Copyright (c) 2002-2018 www.mailtech.cn 126com
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <69331bab.9854.161574424f2.Coremail.zbsdta@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: O8qowADXcgBTjHRaCSmPAA--.36950W
X-CM-SenderInfo: h2evv3bd6rjloofrz/1tbiTgHgSVpD4frczgABs3
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w12G5qJj026669


in matrix_keypad.c, the function disable_row_irqs() may be called by matrix_keypad_interrupt() or matrix_keypad_stop(), there is race condition to disble irqs.


If while matrix_keypad_stop() is calling, and the keypad interrupt is triggered, disable_row_irqs() is called by matrix_keypad_interrupt() and matrix_keypad_stop() at the same time. then disable_row_irqs() is called twice, and the device enter suspend state before keypad->work is executed. At this condition the device will start keypad and enable irq once after resume. and irqs are disabled yet because irqs are disabled twice and only enable once.
then the device can't trigger keypad interrupts.
this problem could reproduce easily by change code to add time delay in matrix_keypad_interrupt() just before calling schedule_delayed_work.




diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
index 1f316d66e6f7..03224ae9eedb 100644
--- a/drivers/input/keyboard/matrix_keypad.c
+++ b/drivers/input/keyboard/matrix_keypad.c
@@ -36,6 +36,7 @@ struct matrix_keypad {
  uint32_t last_key_state[MATRIX_MAX_COLS];
  struct delayed_work work;
  spinlock_t lock;
+ int irq_enabled;
  bool scan_pending;
  bool stopped;
  bool gpio_all_disabled;
@@ -90,6 +91,12 @@ static void enable_row_irqs(struct matrix_keypad *keypad)
 {
  const struct matrix_keypad_platform_data *pdata = keypad->pdata;
  int i;
+ unsigned long flags;
+
+ spin_lock_irqsave(&keypad->lock, flags);
+
+ if (keypad->irq_enabled == 1)
+ goto out;
 
  if (pdata->clustered_irq > 0)
  enable_irq(pdata->clustered_irq);
@@ -97,19 +104,31 @@ static void enable_row_irqs(struct matrix_keypad *keypad)
  for (i = 0; i < pdata->num_row_gpios; i++)
  enable_irq(gpio_to_irq(pdata->row_gpios[i]));
  }
+ keypad->irq_enabled = 1;
+
+out:
+ spin_unlock_irqrestore(&keypad->lock, flags);
 }
 
 static void disable_row_irqs(struct matrix_keypad *keypad)
 {
  const struct matrix_keypad_platform_data *pdata = keypad->pdata;
  int i;
+ unsigned long flags;
 
+ spin_lock_irqsave(&keypad->lock, flags);
+ if (keypad->irq_enabled == 0)
+ goto out;
  if (pdata->clustered_irq > 0)
  disable_irq_nosync(pdata->clustered_irq);
  else {
  for (i = 0; i < pdata->num_row_gpios; i++)
  disable_irq_nosync(gpio_to_irq(pdata->row_gpios[i]));
  }
+ keypad->irq_enabled = 0;
+
+out:
+ spin_unlock_irqrestore(&keypad->lock, flags);
 }
 
 /*
@@ -167,18 +186,13 @@ static void matrix_keypad_scan(struct work_struct *work)
  activate_all_cols(pdata, true);
 
  /* Enable IRQs again */
- spin_lock_irq(&keypad->lock);
  keypad->scan_pending = false;
  enable_row_irqs(keypad);
- spin_unlock_irq(&keypad->lock);
 }
 
 static irqreturn_t matrix_keypad_interrupt(int irq, void *id)
 {
  struct matrix_keypad *keypad = id;
- unsigned long flags;
-
- spin_lock_irqsave(&keypad->lock, flags);
 
  /*
  * See if another IRQ beaten us to it and scheduled the
@@ -194,7 +208,6 @@ static irqreturn_t matrix_keypad_interrupt(int irq, void *id)
  msecs_to_jiffies(keypad->pdata->debounce_ms));
 
 out:
- spin_unlock_irqrestore(&keypad->lock, flags);
  return IRQ_HANDLED;
 }
