Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B72C282DA
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33D1B2082C
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731221AbfBCObe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:31:34 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55246 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729221AbfBCOUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:20:01 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIcq-00064P-1A; Sun, 03 Feb 2019 14:20:00 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqICA-0007lI-SZ; Sun, 03 Feb 2019 14:52:26 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Nicolas Ferre" <nicolas.ferre@microchip.com>,
        "Anssi Hannula" <anssi.hannula@bitwise.fi>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.861186274@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 298/305] net: macb: add missing barriers when reading
 descriptors
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

From: Anssi Hannula <anssi.hannula@bitwise.fi>

commit 6e0af298066f3b6d99f58989bb0dca6f764b4c6d upstream.

When reading buffer descriptors on RX or on TX completion, an
RX_USED/TX_USED bit is checked first to ensure that the descriptors have
been populated, i.e. the ownership has been transferred. However, there
are no memory barriers to ensure that the data protected by the
RX_USED/TX_USED bit is up-to-date with respect to that bit.

Specifically:

- TX timestamp descriptors may be loaded before ctrl is loaded for the
  TX_USED check, which is racy as the descriptors may be updated between
  the loads, causing old timestamp descriptor data to be used.

- RX ctrl may be loaded before addr is loaded for the RX_USED check,
  which is racy as a new frame may be written between the loads, causing
  old ctrl descriptor data to be used.
  This issue exists for both macb_rx() and gem_rx() variants.

Fix the races by adding DMA read memory barriers on those paths and
reordering the reads in macb_rx().

I have not observed any actual problems in practice caused by these
being missing, though.

Tested on a ZynqMP based system.

Fixes: 89e5785fc8a6 ("[PATCH] Atmel MACB ethernet driver")
Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.16:
 - Use rmb() instead of dma_rmb()
 - Drop PTP changes
 - Adjust filename, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/net/ethernet/cadence/macb.c
+++ b/drivers/net/ethernet/cadence/macb.c
@@ -691,11 +691,15 @@ static int gem_rx(struct macb *bp, int b
 		rmb();
 
 		addr = desc->addr;
-		ctrl = desc->ctrl;
 
 		if (!(addr & MACB_BIT(RX_USED)))
 			break;
 
+		/* Ensure ctrl is at least as up-to-date as rxused */
+		rmb();
+
+		ctrl = desc->ctrl;
+
 		bp->rx_tail++;
 		count++;
 
@@ -838,11 +842,15 @@ static int macb_rx(struct macb *bp, int
 		rmb();
 
 		addr = desc->addr;
-		ctrl = desc->ctrl;
 
 		if (!(addr & MACB_BIT(RX_USED)))
 			break;
 
+		/* Ensure ctrl is at least as up-to-date as addr */
+		rmb();
+
+		ctrl = desc->ctrl;
+
 		if (ctrl & MACB_BIT(RX_SOF)) {
 			if (first_frag != -1)
 				discard_partial_frame(bp, first_frag, tail);

