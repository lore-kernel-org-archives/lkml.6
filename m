Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752563AbeDKBvh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 21:51:37 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35678 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752016AbeDKBvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 21:51:35 -0400
X-Google-Smtp-Source: AIpwx4/eybQ3agahYySq6xAnbt+uKAR62C2OXkllxru5woyKAgmQiMrcZ04PsiDIGm1cdKMU0ISlgw==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: f.fainelli@gmail.com, andrew@lunn.ch,
        vivien.didelot@savoirfairelinux.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] net: dsa: b53: Replace mdelay with msleep in b53_switch_reset_gpio
Date: Wed, 11 Apr 2018 09:51:25 +0800
Message-Id: <1523411485-2030-1-git-send-email-baijiaju1990@gmail.com>
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
calls mdelay() to busily wait.
This is not necessary and can be replaced with msleep() to
avoid busy waiting.

This is found by a static analysis tool named DCNS written by myself.
And I also manually check it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 274f367..e070ff6 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -597,10 +597,10 @@ static void b53_switch_reset_gpio(struct b53_device *dev)
 	/* Reset sequence: RESET low(50ms)->high(20ms)
 	 */
 	gpio_set_value(gpio, 0);
-	mdelay(50);
+	msleep(50);
 
 	gpio_set_value(gpio, 1);
-	mdelay(20);
+	msleep(20);
 
 	dev->current_page = 0xff;
 }
-- 
1.9.1
