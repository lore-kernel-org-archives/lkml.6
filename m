Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4504C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 831DA2084A
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="w85TkHvx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 831DA2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730021AbeKCDwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:52:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:47736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726849AbeKCDwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:52:25 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD40120847;
        Fri,  2 Nov 2018 18:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184252;
        bh=OILLLUehxy56+HzHGnMuEfNKM9SLg+zJJvlhY7BjHLw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w85TkHvxejcJYLhvI7N7B5tqfeavRVrVpXfRgStRIgKlNDGGtHEFYXJXeFGZx6mwM
         NjLLFFg1Q/qfpOssGi+JvlWVC/r16b4XzjQjHnjiepMh5QUnErd+jsBWOw3QhbruuW
         0PBS+t7/iC/ap3vVcpU9uozP1N7RLRCb60oaPL5o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 115/150] r8169: fix NAPI handling under high load
Date:   Fri,  2 Nov 2018 19:34:37 +0100
Message-Id: <20181102182911.135331069@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182902.250560510@linuxfoundation.org>
References: <20181102182902.250560510@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/realtek/r8169.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -7044,17 +7044,15 @@ static int rtl8169_poll(struct napi_stru
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


