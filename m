Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0A9C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46C3920866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="J07jetwj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46C3920866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbeJPMBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:01:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:48966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727174AbeJPMBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:01:42 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6551520869;
        Tue, 16 Oct 2018 04:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663200;
        bh=v/SGF82MQK6EqfSw8XEiENglgJSyadVMn/OYj8+1XhE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J07jetwjXIymFOid7T3WyBJyC/IJX0O689f9LFaxyzq1z2pyuSJk68Z4YvDcnaCwg
         fGUUz7Y7Abe/5PzILC3WAjLfL+ovRIIAR/UUK/jrJmQnGdXAjw9fqoW/BQfQHh7NMz
         j6X0KDU/qZHQjrFLFqF7yDzyzdUJQJNsdqNZinIk=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 064/100] r8169: fix network stalls due to missing bit TXCFG_AUTO_FIFO
Date:   Tue, 16 Oct 2018 00:11:45 -0400
Message-Id: <20181016041221.135528-64-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041221.135528-1-sashal@kernel.org>
References: <20181016041221.135528-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiner Kallweit <hkallweit1@gmail.com>

[ Upstream commit ad5f97faff4231e72b96bd96adbe1b6e977a9b86 ]

Some of the chip-specific hw_start functions set bit TXCFG_AUTO_FIFO
in register TxConfig. The original patch changed the order of some
calls resulting in these changes being overwritten by
rtl_set_tx_config_registers() in rtl_hw_start(). This eventually
resulted in network stalls especially under high load.

Analyzing the chip-specific hw_start functions all chip version from
34, with the exception of version 39, need this bit set.
This patch moves setting this bit to rtl_set_tx_config_registers().

Fixes: 4fd48c4ac0a0 ("r8169: move common initializations to tp->hw_start")
Reported-by: Ortwin Glück <odi@odi.ch>
Reported-by: David Arendt <admin@prnet.org>
Root-caused-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Tested-by: Tony Atkinson <tatkinson@linux.com>
Tested-by: David Arendt <admin@prnet.org>
Tested-by: Ortwin Glück <odi@odi.ch>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/realtek/r8169.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/realtek/r8169.c
index 1d1e66002232..92a932c88dde 100644
--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -5041,9 +5041,14 @@ static void rtl8169_hw_reset(struct rtl8169_private *tp)
 
 static void rtl_set_tx_config_registers(struct rtl8169_private *tp)
 {
-	/* Set DMA burst size and Interframe Gap Time */
-	RTL_W32(tp, TxConfig, (TX_DMA_BURST << TxDMAShift) |
-		(InterFrameGap << TxInterFrameGapShift));
+	u32 val = TX_DMA_BURST << TxDMAShift |
+		  InterFrameGap << TxInterFrameGapShift;
+
+	if (tp->mac_version >= RTL_GIGA_MAC_VER_34 &&
+	    tp->mac_version != RTL_GIGA_MAC_VER_39)
+		val |= TXCFG_AUTO_FIFO;
+
+	RTL_W32(tp, TxConfig, val);
 }
 
 static void rtl_set_rx_max_size(struct rtl8169_private *tp)
@@ -5530,7 +5535,6 @@ static void rtl_hw_start_8168e_2(struct rtl8169_private *tp)
 
 	rtl_disable_clock_request(tp);
 
-	RTL_W32(tp, TxConfig, RTL_R32(tp, TxConfig) | TXCFG_AUTO_FIFO);
 	RTL_W8(tp, MCU, RTL_R8(tp, MCU) & ~NOW_IS_OOB);
 
 	/* Adjust EEE LED frequency */
@@ -5562,7 +5566,6 @@ static void rtl_hw_start_8168f(struct rtl8169_private *tp)
 
 	rtl_disable_clock_request(tp);
 
-	RTL_W32(tp, TxConfig, RTL_R32(tp, TxConfig) | TXCFG_AUTO_FIFO);
 	RTL_W8(tp, MCU, RTL_R8(tp, MCU) & ~NOW_IS_OOB);
 	RTL_W8(tp, DLLPR, RTL_R8(tp, DLLPR) | PFM_EN);
 	RTL_W32(tp, MISC, RTL_R32(tp, MISC) | PWM_EN);
@@ -5607,8 +5610,6 @@ static void rtl_hw_start_8411(struct rtl8169_private *tp)
 
 static void rtl_hw_start_8168g(struct rtl8169_private *tp)
 {
-	RTL_W32(tp, TxConfig, RTL_R32(tp, TxConfig) | TXCFG_AUTO_FIFO);
-
 	rtl_eri_write(tp, 0xc8, ERIAR_MASK_0101, 0x080002, ERIAR_EXGMAC);
 	rtl_eri_write(tp, 0xcc, ERIAR_MASK_0001, 0x38, ERIAR_EXGMAC);
 	rtl_eri_write(tp, 0xd0, ERIAR_MASK_0001, 0x48, ERIAR_EXGMAC);
@@ -5707,8 +5708,6 @@ static void rtl_hw_start_8168h_1(struct rtl8169_private *tp)
 	RTL_W8(tp, Config5, RTL_R8(tp, Config5) & ~ASPM_en);
 	rtl_ephy_init(tp, e_info_8168h_1, ARRAY_SIZE(e_info_8168h_1));
 
-	RTL_W32(tp, TxConfig, RTL_R32(tp, TxConfig) | TXCFG_AUTO_FIFO);
-
 	rtl_eri_write(tp, 0xc8, ERIAR_MASK_0101, 0x00080002, ERIAR_EXGMAC);
 	rtl_eri_write(tp, 0xcc, ERIAR_MASK_0001, 0x38, ERIAR_EXGMAC);
 	rtl_eri_write(tp, 0xd0, ERIAR_MASK_0001, 0x48, ERIAR_EXGMAC);
@@ -5789,8 +5788,6 @@ static void rtl_hw_start_8168ep(struct rtl8169_private *tp)
 {
 	rtl8168ep_stop_cmac(tp);
 
-	RTL_W32(tp, TxConfig, RTL_R32(tp, TxConfig) | TXCFG_AUTO_FIFO);
-
 	rtl_eri_write(tp, 0xc8, ERIAR_MASK_0101, 0x00080002, ERIAR_EXGMAC);
 	rtl_eri_write(tp, 0xcc, ERIAR_MASK_0001, 0x2f, ERIAR_EXGMAC);
 	rtl_eri_write(tp, 0xd0, ERIAR_MASK_0001, 0x5f, ERIAR_EXGMAC);
@@ -6108,7 +6105,6 @@ static void rtl_hw_start_8402(struct rtl8169_private *tp)
 	/* Force LAN exit from ASPM if Rx/Tx are not idle */
 	RTL_W32(tp, FuncEvent, RTL_R32(tp, FuncEvent) | 0x002800);
 
-	RTL_W32(tp, TxConfig, RTL_R32(tp, TxConfig) | TXCFG_AUTO_FIFO);
 	RTL_W8(tp, MCU, RTL_R8(tp, MCU) & ~NOW_IS_OOB);
 
 	rtl_ephy_init(tp, e_info_8402, ARRAY_SIZE(e_info_8402));
-- 
2.17.1

