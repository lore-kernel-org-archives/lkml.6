Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id VHyuGCJJGVsaTgAAmS7hNA
	; Thu, 07 Jun 2018 15:03:00 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 04987608CE; Thu,  7 Jun 2018 15:03:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 92824608B8;
	Thu,  7 Jun 2018 15:02:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 92824608B8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935115AbeFGPCy (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:02:54 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41461 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S964940AbeFGPCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 11:02:51 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbG-0005Zq-7I; Thu, 07 Jun 2018 15:09:14 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbC-0003ET-IW; Thu, 07 Jun 2018 15:09:10 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Andri Yngvason" <andri.yngvason@marel.com>,
        "Richard Weinberger" <richard@nod.at>,
        "Marc Kleine-Budde" <mkl@pengutronix.de>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.260416309@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 348/410] can: cc770: Fix stalls on rt-linux, remove
 redundant IRQ ack
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Andri Yngvason <andri.yngvason@marel.com>

commit f4353daf4905c0099fd25fa742e2ffd4a4bab26a upstream.

This has been reported to cause stalls on rt-linux.

Suggested-by: Richard Weinberger <richard@nod.at>
Tested-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Andri Yngvason <andri.yngvason@marel.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/can/cc770/cc770.c | 15 ---------------
 1 file changed, 15 deletions(-)

--- a/drivers/net/can/cc770/cc770.c
+++ b/drivers/net/can/cc770/cc770.c
@@ -447,15 +447,6 @@ static netdev_tx_t cc770_start_xmit(stru
 
 	stats->tx_bytes += dlc;
 
-
-	/*
-	 * HM: We had some cases of repeated IRQs so make sure the
-	 * INT is acknowledged I know it's already further up, but
-	 * doing again fixed the issue
-	 */
-	cc770_write_reg(priv, msgobj[mo].ctrl0,
-			MSGVAL_UNC | TXIE_UNC | RXIE_UNC | INTPND_RES);
-
 	return NETDEV_TX_OK;
 }
 
@@ -683,12 +674,6 @@ static void cc770_tx_interrupt(struct ne
 	/* Nothing more to send, switch off interrupts */
 	cc770_write_reg(priv, msgobj[mo].ctrl0,
 			MSGVAL_RES | TXIE_RES | RXIE_RES | INTPND_RES);
-	/*
-	 * We had some cases of repeated IRQ so make sure the
-	 * INT is acknowledged
-	 */
-	cc770_write_reg(priv, msgobj[mo].ctrl0,
-			MSGVAL_UNC | TXIE_UNC | RXIE_UNC | INTPND_RES);
 
 	stats->tx_packets++;
 	can_get_echo_skb(dev, 0);
