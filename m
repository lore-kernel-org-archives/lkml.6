Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965708AbeEXNcp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 09:32:45 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33065 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965572AbeEXNcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 09:32:41 -0400
X-Google-Smtp-Source: AB8JxZqDmBwSrRfCaSDPEG3pDPrbuQT2ByIgQNNFHbGziV2q5rwQg3AjsIEmutL1LAHxuT0wlVVZEw==
From: Oleg Keri <ezhi99@gmail.com>
Cc: Oleg Keri <ezhi99@gmail.com>, Ike Panhc <ike.pan@canonical.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: ideapad-laptop: Fix rfkill invert
Date: Thu, 24 May 2018 16:32:31 +0300
Message-Id: <20180524133231.8433-1-ezhi99@gmail.com>
X-Mailer: git-send-email 2.17.0
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a lot of reports on the Internet about rfkill lock on
modern Yoga Ideapad laptops while loading ideapad_laptop platform module.
This patch offers the fix. Obviously it's impossible for me
to test this patch on all ideapad laptops, so i've made an module
parameter init_rfkill_inverted to keep old behavior. Comments are
welcome.

Signed-off-by: Oleg Keri <ezhi99@gmail.com>
---
 drivers/platform/x86/ideapad-laptop.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index 535199c9e6bc..1eeda7bc74a3 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -110,6 +110,10 @@ static bool no_bt_rfkill;
 module_param(no_bt_rfkill, bool, 0444);
 MODULE_PARM_DESC(no_bt_rfkill, "No rfkill for bluetooth.");
 
+static bool init_rfkill_inverted;
+module_param(init_rfkill_inverted, bool, 0444);
+MODULE_PARM_DESC(init_rfkill_inverted, "Invert rfkill on initialization");
+
 /*
  * ACPI Helpers
  */
@@ -604,7 +608,9 @@ static int ideapad_register_rfkill(struct ideapad_private *priv, int dev)
 			 &sw_blocked)) {
 		rfkill_init_sw_state(priv->rfk[dev], 0);
 	} else {
-		sw_blocked = !sw_blocked;
+		/* Do not apply invert for ideapads which haven't hw switch */
+		if (priv->has_hw_rfkill_switch || init_rfkill_inverted)
+			sw_blocked = !sw_blocked;
 		rfkill_init_sw_state(priv->rfk[dev], sw_blocked);
 	}
 
-- 
2.17.0
