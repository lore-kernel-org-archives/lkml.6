Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D7DC282DA
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6C1720821
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729200AbfBCN7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 08:59:23 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53642 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728305AbfBCNt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:49:56 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9i-0003te-Ja; Sun, 03 Feb 2019 13:49:54 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9e-00078Y-Gr; Sun, 03 Feb 2019 14:49:50 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Marc Kleine-Budde" <mkl@pengutronix.de>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.122638819@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 176/305] can: dev: __can_get_echo_skb(): replace
 struct can_frame by canfd_frame to access frame length
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

commit 200f5c49f7a2cd694436bfc6cb0662b794c96736 upstream.

This patch replaces the use of "struct can_frame::can_dlc" by "struct
canfd_frame::len" to access the frame's length. As it is ensured that
both structures have a compatible memory layout for this member this is
no functional change. Futher, this compatibility is documented in a
comment.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/can/dev.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -429,11 +429,14 @@ struct sk_buff *__can_get_echo_skb(struc
 	BUG_ON(idx >= priv->echo_skb_max);
 
 	if (priv->echo_skb[idx]) {
+		/* Using "struct canfd_frame::len" for the frame
+		 * length is supported on both CAN and CANFD frames.
+		 */
 		struct sk_buff *skb = priv->echo_skb[idx];
-		struct can_frame *cf = (struct can_frame *)skb->data;
-		u8 dlc = cf->can_dlc;
+		struct canfd_frame *cf = (struct canfd_frame *)skb->data;
+		u8 len = cf->len;
 
-		*len_ptr = dlc;
+		*len_ptr = len;
 		priv->echo_skb[idx] = NULL;
 
 		return skb;

