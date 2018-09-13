Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143FEC07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4BCB20854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:51:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4BCB20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730880AbeIMTBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:01:21 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33334 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730372AbeIMTBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:01:21 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E5EC0D10;
        Thu, 13 Sep 2018 13:51:45 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Realtek linux nic maintainers <nic_swsd@realtek.com>,
        Azat Khuzhin <a3at.mail@gmail.com>
Subject: [PATCH 4.18 028/197] r8169: set RxConfig after tx/rx is enabled for RTL8169sb/8110sb devices
Date:   Thu, 13 Sep 2018 15:29:37 +0200
Message-Id: <20180913131842.688567279@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
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

From: Azat Khuzhin <a3at.mail@gmail.com>

[ Upstream commit 05212ba8132b42047ab5d63d759c6f9c28e7eab5 ]

I have two Ethernet adapters:
  r8169 0000:03:01.0 eth0: RTL8169sb/8110sb, 00:14:d1:14:2d:49, XID 10000000, IRQ 18
  r8169 0000:01:00.0 eth0: RTL8168e/8111e, 64:66:b3:11:14:5d, XID 2c200000, IRQ 30
And after upgrading from linux 4.15 [1] to linux 4.18+ [2] RTL8169sb failed to
receive any packets. tcpdump shows a lot of checksum mismatch.

  [1]: a0f79386a4968b4925da6db2d1daffd0605a4402
  [2]: 0519359784328bfa92bf0931bf0cff3b58c16932 (4.19 merge window opened)

I started bisecting and the found that [3] breaks it. According to [4]:
  "For 8110S, 8110SB, and 8110SC series, the initial value of RxConfig
  needs to be set after the tx/rx is enabled."
So I moved rtl_init_rxcfg() after enabling tx/rs and now my adapter works
(RTL8168e works too).

  [3]: 3559d81e76bfe3803e89f2e04cf6ef7ab4f3aace
  [4]: e542a2269f232d61270ceddd42b73a4348dee2bb ("r8169: adjust the RxConfig
settings.")

Also drop "rx" from rtl_set_rx_tx_config_registers(), since it does nothing
with it already.

Fixes: 3559d81e76bfe3803e89f2e04cf6ef7ab4f3aace ("r8169: simplify
rtl_hw_start_8169")

Cc: Heiner Kallweit <hkallweit1@gmail.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>
Signed-off-by: Azat Khuzhin <a3at.mail@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/realtek/r8169.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -5039,7 +5039,7 @@ static void rtl8169_hw_reset(struct rtl8
 	rtl_hw_reset(tp);
 }
 
-static void rtl_set_rx_tx_config_registers(struct rtl8169_private *tp)
+static void rtl_set_tx_config_registers(struct rtl8169_private *tp)
 {
 	/* Set DMA burst size and Interframe Gap Time */
 	RTL_W32(tp, TxConfig, (TX_DMA_BURST << TxDMAShift) |
@@ -5150,12 +5150,14 @@ static void rtl_hw_start(struct  rtl8169
 
 	rtl_set_rx_max_size(tp);
 	rtl_set_rx_tx_desc_registers(tp);
-	rtl_set_rx_tx_config_registers(tp);
+	rtl_set_tx_config_registers(tp);
 	RTL_W8(tp, Cfg9346, Cfg9346_Lock);
 
 	/* Initially a 10 us delay. Turned it into a PCI commit. - FR */
 	RTL_R8(tp, IntrMask);
 	RTL_W8(tp, ChipCmd, CmdTxEnb | CmdRxEnb);
+	rtl_init_rxcfg(tp);
+
 	rtl_set_rx_mode(tp->dev);
 	/* no early-rx interrupts */
 	RTL_W16(tp, MultiIntr, RTL_R16(tp, MultiIntr) & 0xf000);


