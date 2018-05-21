Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751639AbeEUDt5 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 23:49:57 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:37915 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750836AbeEUDtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 23:49:55 -0400
X-Google-Smtp-Source: AB8JxZq6uJphgwyFGXDAQY9Oe0h0zsn6yvZ401ljCZlamDb5P0V9mvIe775NKxBBJqK8JvwsEaKu1Q==
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: rmk+kernel@armlinux.org.uk, Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: phy: phylink: Don't release NULL GPIO
Date: Sun, 20 May 2018 20:49:47 -0700
Message-Id: <20180521034947.469-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_GPIOLIB is disabled, gpiod_put() becomes a stub that produces a
warning, this helped identify that we could be attempting to release a NULL
pl->link_gpio GPIO descriptor, so guard against that.

Fixes: daab3349ad1a ("net: phy: phylink: Release link GPIO")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/phy/phylink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 581ce93ecaf9..af4dc4425be2 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -624,7 +624,7 @@ void phylink_destroy(struct phylink *pl)
 {
 	if (pl->sfp_bus)
 		sfp_unregister_upstream(pl->sfp_bus);
-	if (!IS_ERR(pl->link_gpio))
+	if (!IS_ERR_OR_NULL(pl->link_gpio))
 		gpiod_put(pl->link_gpio);
 
 	cancel_work_sync(&pl->resolve);
-- 
2.14.1
