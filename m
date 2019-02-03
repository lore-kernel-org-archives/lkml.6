Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204E5C282DA
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE2FC2084A
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730912AbfBCO0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:26:12 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55628 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730213AbfBCOU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:20:57 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIdj-0006NM-Qy; Sun, 03 Feb 2019 14:20:56 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9e-00078N-89; Sun, 03 Feb 2019 14:49:50 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Marc Kleine-Budde" <mkl@pengutronix.de>,
        "Oliver Hartkopp" <socketcan@hartkopp.net>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.975986609@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 174/305] can: raw: check for CAN FD capable netdev in
 raw_sendmsg()
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

From: Oliver Hartkopp <socketcan@hartkopp.net>

commit a43608fa77213ad5ac5f75994254b9f65d57cfa0 upstream.

When the socket is CAN FD enabled it can handle CAN FD frame
transmissions.  Add an additional check in raw_sendmsg() as a CAN2.0 CAN
driver (non CAN FD) should never see a CAN FD frame. Due to the commonly
used can_dropped_invalid_skb() function the CAN 2.0 driver would drop
that CAN FD frame anyway - but with this patch the user gets a proper
-EINVAL return code.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
[bwh: Backported to 3.16: Keep looking up devices in init_net]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/can/raw.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -686,18 +686,19 @@ static int raw_sendmsg(struct kiocb *ioc
 	} else
 		ifindex = ro->ifindex;
 
-	if (ro->fd_frames) {
+	dev = dev_get_by_index(&init_net, ifindex);
+	if (!dev)
+		return -ENXIO;
+
+	err = -EINVAL;
+	if (ro->fd_frames && dev->mtu == CANFD_MTU) {
 		if (unlikely(size != CANFD_MTU && size != CAN_MTU))
-			return -EINVAL;
+			goto put_dev;
 	} else {
 		if (unlikely(size != CAN_MTU))
-			return -EINVAL;
+			goto put_dev;
 	}
 
-	dev = dev_get_by_index(&init_net, ifindex);
-	if (!dev)
-		return -ENXIO;
-
 	skb = sock_alloc_send_skb(sk, size + sizeof(struct can_skb_priv),
 				  msg->msg_flags & MSG_DONTWAIT, &err);
 	if (!skb)

