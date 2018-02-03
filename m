Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752633AbeBCP7j (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 10:59:39 -0500
Received: from m50-112.126.com ([123.125.50.112]:57224 "EHLO m50-112.126.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751932AbeBCP7a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 10:59:30 -0500
From: Zhang Bo <zbsdta@126.com>
To: dmitry.torokhov@gmail.com
Cc: robh@kernel.org, DRivshin@allworx.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhang.bo19@zte.com.cn,
        andy.shevchenko@gmail.com, zbsdta@126.com
Subject: [PATCH v2] Input: matrix_keypad - fix keypad does not response
Date: Sat,  3 Feb 2018 23:58:16 +0800
Message-Id: <20180203155816.18221-1-zbsdta@126.com>
X-Mailer: git-send-email 2.14.3
X-CM-TRANSID: j9KowABHJjci3HVaxE+EAA--.4198S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxGryrGFyxKr1UZFW3Jw43Jrb_yoW5Gr1kpr
        W3G3Wqyr4UJ3Wj93yvqrWkuas8Gw4kZry2grn5W348Jrn0vr1UGrn3K3ySga4UArW0yanr
        ZF4kZw15G3WqyF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U5kuxUUUUU=
X-Originating-IP: [123.139.75.126]
X-CM-SenderInfo: h2evv3bd6rjloofrz/1tbikAPhSVpD3+vV1QAAsW
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If matrix_keypad_stop() is calling and the keypad interrupt is triggered,
disable_row_irqs() is called by both matrix_keypad_interrupt() and
matrix_keypad_stop() at the same time. then disable_row_irqs() is called
twice, and the device enter suspend state before keypad->work is executed.
At this condition the device will start keypad and enable irq once after
resume. and then irqs are disabled yet because irqs are disabled twice and
only enable once.

Take lock around keypad->stopped and queue delayed work in
matrix_keypad_start() and matrix_keypad_stop() to ensure irqs operation and
scheduling scan work are in atomic operation.

Signed-off-by: Zhang Bo <zbsdta@126.com>
---
Changes in v2:
  - Change commit message and full name in the signed-off-by tag.

 drivers/input/keyboard/matrix_keypad.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
index 1f316d66e6f7..13fe51824637 100644
--- a/drivers/input/keyboard/matrix_keypad.c
+++ b/drivers/input/keyboard/matrix_keypad.c
@@ -169,7 +169,8 @@ static void matrix_keypad_scan(struct work_struct *work)
 	/* Enable IRQs again */
 	spin_lock_irq(&keypad->lock);
 	keypad->scan_pending = false;
-	enable_row_irqs(keypad);
+	if (keypad->stopped == false)
+		enable_row_irqs(keypad);
 	spin_unlock_irq(&keypad->lock);
 }
 
@@ -202,14 +203,16 @@ static int matrix_keypad_start(struct input_dev *dev)
 {
 	struct matrix_keypad *keypad = input_get_drvdata(dev);
 
+	spin_lock_irq(&keypad->lock);
 	keypad->stopped = false;
-	mb();
 
 	/*
 	 * Schedule an immediate key scan to capture current key state;
 	 * columns will be activated and IRQs be enabled after the scan.
 	 */
-	schedule_delayed_work(&keypad->work, 0);
+	if (keypad->scan_pending == false)
+		schedule_delayed_work(&keypad->work, 0);
+	spin_unlock_irq(&keypad->lock);
 
 	return 0;
 }
@@ -218,14 +221,17 @@ static void matrix_keypad_stop(struct input_dev *dev)
 {
 	struct matrix_keypad *keypad = input_get_drvdata(dev);
 
+	spin_lock_irq(&keypad->lock);
 	keypad->stopped = true;
-	mb();
-	flush_work(&keypad->work.work);
 	/*
 	 * matrix_keypad_scan() will leave IRQs enabled;
 	 * we should disable them now.
 	 */
-	disable_row_irqs(keypad);
+	if (keypad->scan_pending == false)
+		disable_row_irqs(keypad);
+	spin_unlock_irq(&keypad->lock);
+
+	flush_work(&keypad->work.work);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.14.3
