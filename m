Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751082AbeDSIuD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 04:50:03 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47705 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbeDSIuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 04:50:01 -0400
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH v2] Input: i8042 - Fix KBD port cannot wake up system from suspend-to-idle
Date: Thu, 19 Apr 2018 16:49:51 +0800
Message-Id: <20180419084951.25130-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai Heng Feng <kai.heng.feng@canonical.com>

Commit f13b2065de81 ("Input: i8042 - allow KBD and AUX ports to wake up
from suspend-to-idle") make system in s2idle can be woken up by i8042
keyboard, but it's disabled by default.

In commit 3e6e15a862a0 ("Input: enable remote wakeup for PNP i8042
keyboard ports") states that "Keyboard ports are always supposed to be
wakeup-enabled", it should be enabled by default. Keyboard wakeup from
s2idles is also the default behavior for other x86 OSes.

In addition to PNP port, enable keyboard wakeup from serio port by
default for x86 systems.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v2:
Keep the PNP wakeup part.
Only enable for x86 systems.
Update commit message.

 drivers/input/serio/i8042.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
index 824f4c1c1f31..0b6878e8037b 100644
--- a/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -1400,6 +1400,12 @@ static void __init i8042_register_ports(void)
 				i8042_ports[i].irq);
 			serio_register_port(serio);
 			device_set_wakeup_capable(&serio->dev, true);
+
+#ifdef CONFIG_X86
+			/* Keyboard ports are always supposed to be wakeup-enabled */
+			if (i == I8042_KBD_PORT_NO)
+				device_wakeup_enable(&serio->dev);
+#endif
 		}
 	}
 }
-- 
2.17.0
