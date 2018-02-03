Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752444AbeBCOFU (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 09:05:20 -0500
Received: from m50-111.126.com ([123.125.50.111]:60106 "EHLO m50-111.126.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751638AbeBCOFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 09:05:14 -0500
From: Zhang Bo <zbsdta@126.com>
To: dmitry.torokhov@gmail.com
Cc: robh@kernel.org, DRivshin@allworx.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhang.bo19@zte.com.cn, zbsdta@126.com
Subject: [PATCH] Input: matrix_keypad - fix keypad does not response
Date: Sat,  3 Feb 2018 22:03:34 +0800
Message-Id: <20180203140334.14552-1-zbsdta@126.com>
X-Mailer: git-send-email 2.14.3
X-CM-TRANSID: jtKowABHdwZqwXVa9OxbAA--.187S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw1rXF4UGFWfAw1fZw1fZwb_yoW5JF17pr
        W3J3Wqyr4UJ3Wjg3yvqrWku3Z8Gw4kZry2grn5W348Jrn0vr1UGrn3K3ySga4UArW0yanr
        ZF4kZw15G3WqyF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uf3ktUUUUU=
X-Originating-IP: [123.139.75.126]
X-CM-SenderInfo: h2evv3bd6rjloofrz/1tbiOwDhSVpD4XcXXwAAsU
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
