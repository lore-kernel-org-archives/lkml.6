Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758273AbeDXNua (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:50:30 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36717 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933634AbeDXNQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:16:15 -0400
X-Google-Smtp-Source: AIpwx4/4xM7kAb/zyrr3hqJIMuBrxWgwcB1c+N6WBvuXP7fj0MX0+z0vITptwSsU1lB5y2eFxDItpQ==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] can: sun4i: fix sun4ican_start_xmit()'s return type
Date: Tue, 24 Apr 2018 15:16:11 +0200
Message-Id: <20180424131611.3307-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
which is a typedef for an enum type, but the implementation in this
driver returns an 'int'.

Fix this by returning 'netdev_tx_t' in this driver too.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 drivers/net/can/sun4i_can.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/sun4i_can.c b/drivers/net/can/sun4i_can.c
index 1ac2090a1..093fc9a52 100644
--- a/drivers/net/can/sun4i_can.c
+++ b/drivers/net/can/sun4i_can.c
@@ -409,7 +409,7 @@ static int sun4ican_set_mode(struct net_device *dev, enum can_mode mode)
  * xx xx xx xx         ff         ll 00 11 22 33 44 55 66 77
  * [ can_id ] [flags] [len] [can data (up to 8 bytes]
  */
-static int sun4ican_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t sun4ican_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct sun4ican_priv *priv = netdev_priv(dev);
 	struct can_frame *cf = (struct can_frame *)skb->data;
-- 
2.17.0
