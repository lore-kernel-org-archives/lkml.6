Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CF3C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AAED2087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFYn/18p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AAED2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732535AbeJICFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:05:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:55650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727260AbeJICFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:05:33 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5378204FD;
        Mon,  8 Oct 2018 18:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024745;
        bh=9xffiSMTodUJjcO54gQ3DOSR8zQkHAkqUFO+j4bCyXY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UFYn/18pIKo6tgoEUx7frfrXng3pT8gqAV1y7Xe8QYQuuORNdio8TR9uXvF/ueyz/
         P1pPgfjXAgElnBqAEpadQrM8WEGMJPWUymaAFi2206vw9k7i6KAqtx7IXxEvKKQoHJ
         6uWB9q5113aOTl3LjT/y6ctGKVRLgYQCeXBHlEps=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 116/168] r8169: set TxConfig register after TX / RX is enabled, just like RxConfig
Date:   Mon,  8 Oct 2018 20:31:36 +0200
Message-Id: <20181008175624.455342059@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
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

From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>

[ Upstream commit f74dd480cf4e31e12971c58a1d832044db945670 ]

Commit 3559d81e76bf ("r8169: simplify rtl_hw_start_8169") changed order of
two register writes:
1) Caused RxConfig to be written before TX / RX is enabled,
2) Caused TxConfig to be written before TX / RX is enabled.

At least on XIDs 10000000 ("RTL8169sb/8110sb") and
18000000 ("RTL8169sc/8110sc") such writes are ignored by the chip, leaving
values in these registers intact.

Change 1) was reverted by
commit 05212ba8132b42 ("r8169: set RxConfig after tx/rx is enabled for RTL8169sb/8110sb devices"),
however change 2) wasn't.

In practice, this caused TxConfig's "InterFrameGap time" and "Max DMA Burst
Size per Tx DMA Burst" bits to be zero dramatically reducing TX performance
(in my tests it dropped from around 500Mbps to around 50Mbps).

This patch fixes the issue by moving TxConfig register write a bit later in
the code so it happens after TX / RX is already enabled.

Fixes: 05212ba8132b42 ("r8169: set RxConfig after tx/rx is enabled for RTL8169sb/8110sb devices")
Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/realtek/r8169.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -5150,13 +5150,13 @@ static void rtl_hw_start(struct  rtl8169
 
 	rtl_set_rx_max_size(tp);
 	rtl_set_rx_tx_desc_registers(tp);
-	rtl_set_tx_config_registers(tp);
 	RTL_W8(tp, Cfg9346, Cfg9346_Lock);
 
 	/* Initially a 10 us delay. Turned it into a PCI commit. - FR */
 	RTL_R8(tp, IntrMask);
 	RTL_W8(tp, ChipCmd, CmdTxEnb | CmdRxEnb);
 	rtl_init_rxcfg(tp);
+	rtl_set_tx_config_registers(tp);
 
 	rtl_set_rx_mode(tp->dev);
 	/* no early-rx interrupts */


