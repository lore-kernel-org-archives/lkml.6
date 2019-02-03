Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64908C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29D1E2084A
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730924AbfBCOZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:25:07 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55748 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727971AbfBCOVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:21:17 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIe3-0006Pd-Hx; Sun, 03 Feb 2019 14:21:15 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIBG-0007T1-Q4; Sun, 03 Feb 2019 14:51:30 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Punnaiah Choudary Kalluri" <punnaiah.choudary.kalluri@xilinx.com>,
        "Punnaiah Choudary Kalluri" <punnaia@xilinx.com>,
        "David S. Miller" <davem@davemloft.net>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.757376377@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 296/305] net: macb: Fix race condition in driver when
 Rx frame is dropped
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

From: Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri@xilinx.com>

commit d4c216c54197d741ed8b7ca54f13645dfb3eacde upstream.

Under heavy Rx load, observed that the Hw is updating the USED bit
and it is not updating the received frame status to the BD control
field. This could be lack of resources for processing the BDs at high
data rates. Driver drops the frame associated with this BD but not
clearing the USED bit. So, this is causing hang condition as Hw
expects USED bit to be cleared for this BD.

Signed-off-by: Punnaiah Choudary Kalluri <punnaia@xilinx.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/ethernet/cadence/macb.c | 3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/net/ethernet/cadence/macb.c
+++ b/drivers/net/ethernet/cadence/macb.c
@@ -634,6 +634,9 @@ static void gem_rx_refill(struct macb *b
 
 			/* properly align Ethernet header */
 			skb_reserve(skb, NET_IP_ALIGN);
+		} else {
+			bp->rx_ring[entry].addr &= ~MACB_BIT(RX_USED);
+			bp->rx_ring[entry].ctrl = 0;
 		}
 	}
 

