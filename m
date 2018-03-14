Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752060AbeCNLMG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 07:12:06 -0400
Received: from de-deferred2.bosch-org.com ([139.15.180.217]:44044 "EHLO
        de-deferred2.bosch-org.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750751AbeCNLMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 07:12:03 -0400
X-AuditID: 0a3aad15-083ff700000062e5-7c-5aa901802c9b
From: Mark Jonas <mark.jonas@de.bosch.com>
To: Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
CC: <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hs@denx.de>,
        Zhu Yi <yi.zhu5@cn.bosch.com>, Mark Jonas <mark.jonas@de.bosch.com>
Subject: [PATCH] can: enable multi-queue for SocketCAN devices
Date: Wed, 14 Mar 2018 11:33:16 +0100
Message-ID: <1521023596-30108-1-git-send-email-mark.jonas@de.bosch.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Brightmail-Tracker: H4sIAAAAAAAAA22Sa0xTZxzGeXsO5bT0mMMphb+Vgp64KCa6snnp5iUkmtjsixpvsermYT3S
        Km1JTyGU+aFbBooaFagxdgQLCkGMuOCFWk0amoy0EKeibGNsujBcOsA5RVYULzuHgu0Hv/3z
        PP/f+7zvk5fA6HMpasJsdXB2K1vESOW4/NOLmsUudN6g7euep/P99hDTtUZPYrp7/jqp7lKj
        G9d1eTN0TQ+uJ+dL9fWeEK5/2juA9Mdfa/Vj7dkbcYN8lZErMpdy9g/X7JGbWl7fQMXts8u+
        7VzlQkdUh5GMAGopVL+qQ4eRnKCpUxIY66qRigZN3UTw3z/m2NyBoMZrEWcptQj6Qz5MnNOp
        rfDdo0pchDHqe2Fn8LZENJTUGqi61oyLM059AC09LVM6Sa2H1ju/4rHkbOj/sQqL6WkQPj00
        pWMUQGckgp1ApCfB8iRYXiRpRaq9nLbUkrdiad4SewHHl2vzlnxps7SjWG0qH2po2BZEFIEY
        BVmfdN5AJ7OlvNMSRMsICaMiA+4WAz2rwGZ0mlje9IW9pIjjGTWJkpKSaOU7mS8psJh53myz
        BhEQGJNOXs0SONLIOss5uy2GBdEcAmcyyaPGAwaaKmQd3H6OK+bsM+5KgmCAvP1WANPsXCFX
        ttdc5JixGU0sMyPRSYyVELIg+phQCNlR8QiSL2YtvLlwGp8dw+kZNY52o7XEL5GRSozGrTYr
        p84ktSJPiZumEuu7G6izyN2KZgOtSjDipwyjfiR0qCR5sUOF8Dvj2UD6lHU76LRpMQ591CQw
        1EAq1PvGEYR8B3GYcNXi0Bbpw+FF9V84hKIdyfD88WQy9Po9KVA1WimDu4eeyOD5ZCAVxj1v
        U6H2ZoCEiZN1FNy/+7MSJtpH06H6jisDxir8mTB6wa8Wlrs0cP9WRAM/XenOhqGvXTkwFIjm
        wPgf43NhqPMbBhpbjy2A8MiDhdD57N+FEP7bmwsR15VcCLtf5g4LxUqEYs3Xpop1sI73FDut
        xl+ndqFUZ7Q5R4P0HT3uMw99g8ayufv61rYNnygtl88fGVBHt7ibenZWkdGarImXvwf2pdxS
        bO3NX+3xju7f4CpUWvhTO52RQ7X3Ahcuvwg0HA09erN88597tle417FZbT+cqeDnfNK/+MlZ
        52TF4Ff+4U35ssvbtoRXt7FvbjTv+uzzI427GZw3sXmLMDvP/g9Z97mVNwQAAA==
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
the network subsystem. The commit makes it possible to use multi-queue in
the CAN subsystem in the same way it is used in the Ethernet subsystem
by adding an alloc_candev_mqs() call and accompanying macros. With this
support a CAN device can use multi-queue qdisc (e.g. mqprio) to avoid
the aforementioned priority inversion.

The existing functionality of alloc_candev() is the same as before.

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
index b177956..636f853 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -703,7 +703,8 @@ EXPORT_SYMBOL_GPL(alloc_can_err_skb);
 /*
  * Allocate and setup space for the CAN network device
  */
-struct net_device *alloc_candev(int sizeof_priv, unsigned int echo_skb_max)
+struct net_device *alloc_candev_mqs(int sizeof_priv, unsigned int echo_skb_max,
+				    unsigned int txqs, unsigned int rxqs)
 {
 	struct net_device *dev;
 	struct can_priv *priv;
@@ -715,7 +716,8 @@ struct net_device *alloc_candev(int sizeof_priv, unsigned int echo_skb_max)
 	else
 		size = sizeof_priv;
 
-	dev = alloc_netdev(size, "can%d", NET_NAME_UNKNOWN, can_setup);
+	dev = alloc_netdev_mqs(size, "can%d", NET_NAME_UNKNOWN, can_setup,
+			       txqs, rxqs);
 	if (!dev)
 		return NULL;
 
@@ -734,7 +736,7 @@ struct net_device *alloc_candev(int sizeof_priv, unsigned int echo_skb_max)
 
 	return dev;
 }
-EXPORT_SYMBOL_GPL(alloc_candev);
+EXPORT_SYMBOL_GPL(alloc_candev_mqs);
 
 /*
  * Free space of the CAN network device
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 055aaf5..a83e1f6 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -143,7 +143,12 @@ u8 can_dlc2len(u8 can_dlc);
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
