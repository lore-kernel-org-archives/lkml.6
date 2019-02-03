Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17918C282DB
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2A5A20815
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbfBCN6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 08:58:53 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53716 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728333AbfBCNt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:49:59 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9k-0003wN-UT; Sun, 03 Feb 2019 13:49:57 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9e-000791-Pu; Sun, 03 Feb 2019 14:49:50 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Marc Kleine-Budde" <mkl@pengutronix.de>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.449856107@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 178/305] can: dev: __can_get_echo_skb(): print error
 message, if trying to echo non existing skb
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Kleine-Budde <mkl@pengutronix.de>

commit 7da11ba5c5066dadc2e96835a6233d56d7b7764a upstream.

Prior to echoing a successfully transmitted CAN frame (by calling
can_get_echo_skb()), CAN drivers have to put the CAN frame (by calling
can_put_echo_skb() in the transmit function). These put and get function
take an index as parameter, which is used to identify the CAN frame.

A driver calling can_get_echo_skb() with a index not pointing to a skb
is a BUG, so add an appropriate error message.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/can/dev.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -425,6 +425,8 @@ EXPORT_SYMBOL_GPL(can_put_echo_skb);
 struct sk_buff *__can_get_echo_skb(struct net_device *dev, unsigned int idx, u8 *len_ptr)
 {
 	struct can_priv *priv = netdev_priv(dev);
+	struct sk_buff *skb = priv->echo_skb[idx];
+	struct canfd_frame *cf;
 
 	if (idx >= priv->echo_skb_max) {
 		netdev_err(dev, "%s: BUG! Trying to access can_priv::echo_skb out of bounds (%u/max %u)\n",
@@ -432,21 +434,20 @@ struct sk_buff *__can_get_echo_skb(struc
 		return NULL;
 	}
 
-	if (priv->echo_skb[idx]) {
-		/* Using "struct canfd_frame::len" for the frame
-		 * length is supported on both CAN and CANFD frames.
-		 */
-		struct sk_buff *skb = priv->echo_skb[idx];
-		struct canfd_frame *cf = (struct canfd_frame *)skb->data;
-		u8 len = cf->len;
-
-		*len_ptr = len;
-		priv->echo_skb[idx] = NULL;
-
-		return skb;
+	if (!skb) {
+		netdev_err(dev, "%s: BUG! Trying to echo non existing skb: can_priv::echo_skb[%u]\n",
+			   __func__, idx);
+		return NULL;
 	}
 
-	return NULL;
+	/* Using "struct canfd_frame::len" for the frame
+	 * length is supported on both CAN and CANFD frames.
+	 */
+	cf = (struct canfd_frame *)skb->data;
+	*len_ptr = cf->len;
+	priv->echo_skb[idx] = NULL;
+
+	return skb;
 }
 
 /*

