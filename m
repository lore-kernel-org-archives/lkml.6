Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753205AbeDKI7O (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 04:59:14 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40664 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751972AbeDKI7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 04:59:11 -0400
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] Input: i8042 - Fix KBD port cannot wake up system from suspend-to-idle
Date: Wed, 11 Apr 2018 16:59:05 +0800
Message-Id: <20180411085905.22272-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f13b2065de81 ("Input: i8042 - allow KBD and AUX ports to wake up
from suspend-to-idle") make system in s2idle can be woken up by i8042
keyboard, but it's disabled by default.

In commit 3e6e15a862a0 ("Input: enable remote wakeup for PNP i8042
keyboard ports") states that "Keyboard ports are always supposed to be
wakeup-enabled", it should be enabled by default. Keyboard wakeup from
s2idles is also the default behavior for other OSes.

But right now we can't wake up the system by keyboard, from s2idle.

In i8042_probe(), device_set_wakeup_enable(), which gets called by
i8042_pnp_kbd_probe(), runs before device_set_wakeup_capable(), which
gets called by i8042_register_ports(). So device_set_wakeup_enable()
doesn't really enable wakeup for keyboard.

We can enable keyboard wakeup in i8042_register_ports() directly.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/input/serio/i8042-x86ia64io.h | 3 ---
 drivers/input/serio/i8042.c           | 4 ++++
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index b353d494ad40..e3def9195c2a 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -925,9 +925,6 @@ static int i8042_pnp_kbd_probe(struct pnp_dev *dev, const struct pnp_device_id *
 	i8042_pnp_id_to_string(dev->id, i8042_kbd_firmware_id,
 			       sizeof(i8042_kbd_firmware_id));
 
-	/* Keyboard ports are always supposed to be wakeup-enabled */
-	device_set_wakeup_enable(&dev->dev, true);
-
 	i8042_pnp_kbd_devices++;
 	return 0;
 }
diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
index 824f4c1c1f31..21a16b757931 100644
--- a/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -1400,6 +1400,10 @@ static void __init i8042_register_ports(void)
 				i8042_ports[i].irq);
 			serio_register_port(serio);
 			device_set_wakeup_capable(&serio->dev, true);
+
+			/* Keyboard ports are always supposed to be wakeup-enabled */
+			if (i == I8042_KBD_PORT_NO)
+				device_wakeup_enable(&serio->dev);
 		}
 	}
 }
-- 
2.17.0
