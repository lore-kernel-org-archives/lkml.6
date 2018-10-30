Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D49FC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 271052084A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0BLt931i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 271052084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbeJ3WWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:22:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:53480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728046AbeJ3WWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 18:22:45 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 435C520827;
        Tue, 30 Oct 2018 13:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540906156;
        bh=IBIRsEBj950cxbNuzynHZw1u5Y+qZuSzPvK/Vs+TOCM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0BLt931iWnpqOPSYt2s1bxAhN8nL8lgyTJz6ktiG7ejduiQQ2a2BR9miN3qgRQqXt
         N6kPVD3DonMNRtrrHBNHSUKomaHet4xB7CZB0Q4ui21g3jHOVPRTJTtjB6mwKZ+vm7
         C1R5nAaslyLCVhnt/wdyQNw9m9nP7Zbvb+hTAorc=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 16/19] r8169: fix NAPI handling under high load
Date:   Tue, 30 Oct 2018 09:28:21 -0400
Message-Id: <20181030132824.218056-16-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181030132824.218056-1-sashal@kernel.org>
References: <20181030132824.218056-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiner Kallweit <hkallweit1@gmail.com>

[ Upstream commit 6b839b6cf9eada30b086effb51e5d6076bafc761 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/realtek/r8169.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/realtek/r8169.c
index f7e540eeb877..1b61ce310132 100644
--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -7579,17 +7579,15 @@ static int rtl8169_poll(struct napi_struct *napi, int budget)
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
-- 
2.17.1

