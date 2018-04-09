Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752172AbeDIHDT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 03:03:19 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:42754 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751767AbeDIHDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 03:03:17 -0400
X-Google-Smtp-Source: AIpwx4/QlWsDA7lgKPHFXYKsi5A3gosvl7KWeUddsOvID4kgyG7yBKFx2xwkhE4372zsvhNt4qYtyg==
From: Richard Cochran <richardcochran@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        David Miller <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Subject: [PATCH net] net: dsa: mv88e6xxx: Fix receive time stamp race condition.
Date: Mon,  9 Apr 2018 00:03:14 -0700
Message-Id: <20180409070314.12409-1-richardcochran@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DSA stack passes received PTP frames to this driver via
mv88e6xxx_port_rxtstamp() for deferred delivery.  The driver then
queues the frame and kicks the worker thread.  The work callback reads
out the latched receive time stamp and then works through the queue,
delivering any non-matching frames without a time stamp.

If a new frame arrives after the worker thread has read out the time
stamp register but enters the queue before the worker finishes
processing the queue, that frame will be delivered without a time
stamp.

This patch fixes the race by moving the queue onto a list on the stack
before reading out the latched time stamp value.

Fixes: c6fe0ad2c3499 ("net: dsa: mv88e6xxx: add rx/tx timestamping support")

Signed-off-by: Richard Cochran <richardcochran@gmail.com>
---
 drivers/net/dsa/mv88e6xxx/hwtstamp.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/hwtstamp.c b/drivers/net/dsa/mv88e6xxx/hwtstamp.c
index ac7694c71266..a036c490b7ce 100644
--- a/drivers/net/dsa/mv88e6xxx/hwtstamp.c
+++ b/drivers/net/dsa/mv88e6xxx/hwtstamp.c
@@ -285,10 +285,18 @@ static void mv88e6xxx_get_rxts(struct mv88e6xxx_chip *chip,
 			       struct sk_buff_head *rxq)
 {
 	u16 buf[4] = { 0 }, status, seq_id;
-	u64 ns, timelo, timehi;
 	struct skb_shared_hwtstamps *shwt;
+	struct sk_buff_head received;
+	u64 ns, timelo, timehi;
+	unsigned long flags;
 	int err;
 
+	/* The latched timestamp belongs to one of the received frames. */
+	__skb_queue_head_init(&received);
+	spin_lock_irqsave(&rxq->lock, flags);
+	skb_queue_splice_tail_init(rxq, &received);
+	spin_unlock_irqrestore(&rxq->lock, flags);
+
 	mutex_lock(&chip->reg_lock);
 	err = mv88e6xxx_port_ptp_read(chip, ps->port_id,
 				      reg, buf, ARRAY_SIZE(buf));
@@ -311,7 +319,7 @@ static void mv88e6xxx_get_rxts(struct mv88e6xxx_chip *chip,
 	/* Since the device can only handle one time stamp at a time,
 	 * we purge any extra frames from the queue.
 	 */
-	for ( ; skb; skb = skb_dequeue(rxq)) {
+	for ( ; skb; skb = __skb_dequeue(&received)) {
 		if (mv88e6xxx_ts_valid(status) && seq_match(skb, seq_id)) {
 			ns = timehi << 16 | timelo;
 
-- 
2.11.0
