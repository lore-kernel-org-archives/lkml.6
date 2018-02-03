Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752299AbeBCMCJ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 07:02:09 -0500
Received: from m50-111.126.com ([123.125.50.111]:39342 "EHLO m50-111.126.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751789AbeBCMCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 07:02:01 -0500
From: Zhang Bo <zbsdta@126.com>
To: dmitry.torokhov@gmail.com
Cc: DRivshin@allworx.com, robh@kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, zbsdta@126.com, zhang.bo19@zte.com.cn
Subject: [PATCH] Input: matrix_keypad - fix keypad does not response
Date: Sat,  3 Feb 2018 20:00:46 +0800
Message-Id: <20180203120046.10988-1-zbsdta@126.com>
X-Mailer: git-send-email 2.14.3
X-CM-TRANSID: jtKowABH+L6RpHVa8KdTAA--.192S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw1rXF4UGFWfAw1fZw1fZwb_yoW8Kr4xpr
        WfG34qyr4UJ3Wj93yvqr4093Z8Gw4kZry2grn5W34kJrn0vr17Grn3K3ySga4UZrW0yanx
        ZF4kZw15G3WqyF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UfxhLUUUUU=
X-Originating-IP: [123.139.75.126]
X-CM-SenderInfo: h2evv3bd6rjloofrz/1tbiOxbhSVpD4XaxggAAs4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhangbo <zbsdta@126.com>

If matrix_keypad_stop() is calling and the keypad interrupt is triggered,
disable_row_irqs() is called by both matrix_keypad_interrupt() and
matrix_keypad_stop() at the same time. then disable_row_irqs() is called
twice, and the device enter suspend state before keypad->work is executed.
At this condition the device will start keypad and enable irq once after
resume. and then irqs are disabled yet because irqs are disabled twice and
only enable once.

Signed-off-by: zhangbo <zbsdta@126.com>
---
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
