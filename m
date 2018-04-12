Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752763AbeDLBsc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 21:48:32 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:35041 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751633AbeDLBsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 21:48:31 -0400
X-Google-Smtp-Source: AIpwx48Dsz0GjBMKEKdXGKtAJYAGzbwbHc8avXc1lwJ5RxxTljX0g8l9MtS8dU16zgx/m4es1XfCiw==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: f.fainelli@gmail.com, andrew@lunn.ch,
        vivien.didelot@savoirfairelinux.com, preid@electromag.com.au
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH v2] net: dsa: b53: Using sleep-able operations in b53_switch_reset_gpio
Date: Thu, 12 Apr 2018 09:48:22 +0800
Message-Id: <1523497702-7200-1-git-send-email-baijiaju1990@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

b53_switch_reset_gpio() is never called in atomic context.

The call chain ending up at b53_switch_reset_gpio() is:
[1] b53_switch_reset_gpio() <- b53_switch_reset() <-
    b53_reset_switch() <- b53_setup()

b53_switch_reset_gpio() is set as ".setup" in struct dsa_switch_ops.
This function is not called in atomic context.

Despite never getting called from atomic context, b53_switch_reset_gpio()
calls non-sleep operations mdelay() and gpio_set_value().
They are not necessary and can be replaced with msleep() 
and gpio_set_value_cansleep().

This is found by a static analysis tool named DCNS written by myself.
And I also manually check it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
v2:
* Use gpio_set_value_cansleep() to replace gpio_set_value() additionally.
  Thanks for Florian and Phil for good advice.
---
 drivers/net/dsa/b53/b53_common.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 274f367..36cc60d 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -596,11 +596,11 @@ static void b53_switch_reset_gpio(struct b53_device *dev)
 
 	/* Reset sequence: RESET low(50ms)->high(20ms)
 	 */
-	gpio_set_value(gpio, 0);
-	mdelay(50);
+	gpio_set_value_cansleep(gpio, 0);
+	msleep(50);
 
-	gpio_set_value(gpio, 1);
-	mdelay(20);
+	gpio_set_value_cansleep(gpio, 1);
+	msleep(20);
 
 	dev->current_page = 0xff;
 }
-- 
1.9.1
