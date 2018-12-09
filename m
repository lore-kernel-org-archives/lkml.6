Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A86C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 142F720661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:03:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 142F720661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbeLIWDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:03:24 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35682 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726602AbeLIVz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:28 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72q-0002ia-UQ; Sun, 09 Dec 2018 21:55:25 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72l-0003h8-IG; Sun, 09 Dec 2018 21:55:19 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "Heiner Kallweit" <hkallweit1@gmail.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.322765002@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 318/328] r8169: fix NAPI handling under high load
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Heiner Kallweit <hkallweit1@gmail.com>

commit 6b839b6cf9eada30b086effb51e5d6076bafc761 upstream.

rtl_rx() and rtl_tx() are called only if the respective bits are set
in the interrupt status register. Under high load NAPI may not be
able to process all data (work_done == budget) and it will schedule
subsequent calls to the poll callback.
rtl_ack_events() however resets the bits in the interrupt status
register, therefore subsequent calls to rtl8169_poll() won't call
rtl_rx() and rtl_tx() - chip interrupts are still disabled.

Fix this by calling rtl_rx() and rtl_tx() independent of the bits
set in the interrupt status register. Both functions will detect
if there's nothing to do for them.

Fixes: da78dbff2e05 ("r8169: remove work from irq handler.")
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/ethernet/realtek/r8169.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -6417,17 +6417,15 @@ static int rtl8169_poll(struct napi_stru
 	struct rtl8169_private *tp = container_of(napi, struct rtl8169_private, napi);
 	struct net_device *dev = tp->dev;
 	u16 enable_mask = RTL_EVENT_NAPI | tp->event_slow;
-	int work_done= 0;
+	int work_done;
 	u16 status;
 
 	status = rtl_get_events(tp);
 	rtl_ack_events(tp, status & ~tp->event_slow);
 
-	if (status & RTL_EVENT_NAPI_RX)
-		work_done = rtl_rx(dev, tp, (u32) budget);
+	work_done = rtl_rx(dev, tp, (u32) budget);
 
-	if (status & RTL_EVENT_NAPI_TX)
-		rtl_tx(dev, tp);
+	rtl_tx(dev, tp);
 
 	if (status & tp->event_slow) {
 		enable_mask &= ~tp->event_slow;

