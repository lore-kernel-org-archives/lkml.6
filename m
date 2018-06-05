Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752055AbeFESpT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 14:45:19 -0400
Received: from de-out1.bosch-org.com ([139.15.230.186]:49098 "EHLO
        de-out1.bosch-org.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751879AbeFESpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 14:45:15 -0400
X-AuditID: 0a3aad15-a0bff70000007ca2-d3-5b16da42317e
From: Mark Jonas <mark.jonas@de.bosch.com>
To: Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
CC: <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hs@denx.de>, <yi.zhu5@cn.bosch.com>,
        Mark Jonas <mark.jonas@de.bosch.com>
Subject: [PATCH 1/5] can: enable multi-queue for SocketCAN devices
Date: Tue, 5 Jun 2018 20:43:56 +0200
Message-ID: <1528224240-30786-2-git-send-email-mark.jonas@de.bosch.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528224240-30786-1-git-send-email-mark.jonas@de.bosch.com>
References: <1528224240-30786-1-git-send-email-mark.jonas@de.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Brightmail-Tracker: H4sIAAAAAAAAA22Sa0xTZxzGeXsO7Wnl6MsprX+roDlqFLcpOBe7S6ZhUbsPJG6LGuGDnMqB
        NusFe1oCbMmq8cq8TklqrQzwQsamhkq04gy2W1zrZjOYbmEuzkUkBdlULqOMue0cCrYf9u3/
        Ps//9z55n7wUwbQqdJTZ5uQdNs7CylWk6rVz2S8V/Kwtzhvuna8P/PIroW8ZrSP0P7T75PoL
        TcdI/Y0Grf7MvSvpq+WGem+YNDztuosMh57lGYb8OevJItUbpbzFXMk7lr1ZojJ9da5PVuGf
        VXXt+k7CjT7W1CKKArwCwqeJWqSiGOyRwc7+OyhxuIYgHHFPOpcQXLkalNciJSXHS6A7HCCk
        OQtvgBMPd5PSEoE/Q/Cw+ZZMMtS4AB55PBNLJF4AseFWhRRH43Uw5l8tyYBzoDu6b2JFiQ0w
        vusPhTQz4krUHyWlmcaZEDneMzETGCAYixGH0QxviuVNsRqQrAVpyvi8Smv+yhX5Sx1GXqjJ
        y1+61W71o0SfmgBqbNwYQphCbAY9FtQWM+lcpVBtDaFXKBmroV9sEqXpRntptYkTTFscLgsv
        sDoapaWlMernsuAyWs2CYLbbQggogs2iuS6Ro0u56hreYU9gITSbItmZ9P7SD4sYXM45+fd5
        voJ3TLmvUxQLdGa3CGY6+HK+qsxscU7ZbHYiU5vqpMbKKGUIvUxliNkF0hW0UMFZBXP5JD4r
        gTNTahK9iVbqZtLVEoMl1+SyPU/VzaFPRrKKGU2KkST7UTcSe1PTxyU4Q/yqyTygA2rfZiZz
        UkxCy8+IDP5iGtQHRsQvFdhDQtx9lITzsTskjB3pJSE8ejkdhn8fT4eudq8C9g3sVkLn3sdK
        GPH+Ow2OftlBQ7zOh+F2509qiPsHsuDI924tDHzeroPh8RvZcPtWLBt+bLuZAz3b3XOhp2N0
        LozcH5kHvt/i86AnuIOFppaDiyDy6N5iCA4+WQyRvoZciLnbciFy7K9cGNp76oV+sUyZWGZv
        lVoq08k5/6fMSTX5Op0bfXLxnabHrlUl6BRjjLAXBohXL7q26ZYZ2wyza64e/qhmwYPrDyot
        hQv/Wet5ukj9tvK9hbVrlg816wsbN319cP7WQ87pRYNx8sA340/KOhvfZT5VK/7c7ouOdvx9
        ln2r42zRt63b6lZtKN78ga15Ttp3JYP2HdF1rZ4Z9+8+Y4Psrj3ePpYUTFz+EsIhcP8BdpmM
        WkQEAAA=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhu Yi <yi.zhu5@cn.bosch.com>

The existing SocketCAN implementation provides alloc_candev() to
allocate a CAN device using a single Tx and Rx queue. This can lead to
priority inversion in case the single Tx queue is already full with low
priority messages and a high priority message needs to be sent while the
bus is fully loaded with medium priority messages.

This problem can be solved by using the existing multi-queue support of
the network subsytem. The commit makes it possible to use multi-queue in
the CAN subsystem in the same way it is used in the Ethernet subsystem
by adding an alloc_candev_mqs() call and accompanying macros. With this
support a CAN device can use multi-queue qdisc (e.g. mqprio) to avoid
the aforementioned priority inversion.

The exisiting functionality of alloc_candev() is the same as before.

CAN devices need to have prioritized multiple hardware queues or are
able to abort waiting for arbitration to make sensible use of
multi-queues.

Signed-off-by: Zhu Yi <yi.zhu5@cn.bosch.com>
Signed-off-by: Mark Jonas <mark.jonas@de.bosch.com>
Reviewed-by: Heiko Schocher <hs@denx.de>
---
 drivers/net/can/dev.c   | 8 +++++---
 include/linux/can/dev.h | 7 ++++++-
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index 365a8cc..ac8270c 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -702,7 +702,8 @@ EXPORT_SYMBOL_GPL(alloc_can_err_skb);
 /*
  * Allocate and setup space for the CAN network device
  */
-struct net_device *alloc_candev(int sizeof_priv, unsigned int echo_skb_max)
+struct net_device *alloc_candev_mqs(int sizeof_priv, unsigned int echo_skb_max,
+				    unsigned int txqs, unsigned int rxqs)
 {
 	struct net_device *dev;
 	struct can_priv *priv;
@@ -714,7 +715,8 @@ struct net_device *alloc_candev(int sizeof_priv, unsigned int echo_skb_max)
 	else
 		size = sizeof_priv;
 
-	dev = alloc_netdev(size, "can%d", NET_NAME_UNKNOWN, can_setup);
+	dev = alloc_netdev_mqs(size, "can%d", NET_NAME_UNKNOWN, can_setup,
+			       txqs, rxqs);
 	if (!dev)
 		return NULL;
 
@@ -733,7 +735,7 @@ struct net_device *alloc_candev(int sizeof_priv, unsigned int echo_skb_max)
 
 	return dev;
 }
-EXPORT_SYMBOL_GPL(alloc_candev);
+EXPORT_SYMBOL_GPL(alloc_candev_mqs);
 
 /*
  * Free space of the CAN network device
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 61f1cf2..07b73d2 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -142,7 +142,12 @@ u8 can_dlc2len(u8 can_dlc);
 /* map the sanitized data length to an appropriate data length code */
 u8 can_len2dlc(u8 len);
 
-struct net_device *alloc_candev(int sizeof_priv, unsigned int echo_skb_max);
+struct net_device *alloc_candev_mqs(int sizeof_priv, unsigned int echo_skb_max,
+				    unsigned int txqs, unsigned int rxqs);
+#define alloc_candev(sizeof_priv, echo_skb_max) \
+	alloc_candev_mqs(sizeof_priv, echo_skb_max, 1, 1)
+#define alloc_candev_mq(sizeof_priv, echo_skb_max, count) \
+	alloc_candev_mqs(sizeof_priv, echo_skb_max, count, count)
 void free_candev(struct net_device *dev);
 
 /* a candev safe wrapper around netdev_priv */
-- 
2.7.4
