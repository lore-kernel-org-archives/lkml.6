Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8ADC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 06:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23F0420833
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 06:58:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23F0420833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbeILMBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 08:01:43 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38277 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbeILMBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 08:01:43 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1fzz6d-0000Ug-ST; Wed, 12 Sep 2018 06:58:32 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     nic_swsd@realtek.com
Cc:     davem@davemloft.net, hkallweit1@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH 2/2] r8169: enable ASPM on RTL8106E
Date:   Wed, 12 Sep 2018 14:58:21 +0800
Message-Id: <20180912065821.7198-2-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180912065821.7198-1-kai.heng.feng@canonical.com>
References: <20180912065821.7198-1-kai.heng.feng@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Intel SoC was prevented from entering lower idle state because
of RTL8106E's ASPM was not enabled.

So enable ASPM on RTL8106E (chip version 39).
Now the Intel SoC can enter lower idle state, power consumption and
temperature are much lower.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/net/ethernet/realtek/r8169.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/realtek/r8169.c
index 5091e9fd601f..3752b1bbe6db 100644
--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -5627,6 +5627,8 @@ static void rtl_hw_start_8402(struct rtl8169_private *tp)
 
 static void rtl_hw_start_8106(struct rtl8169_private *tp)
 {
+	rtl_hw_aspm_clkreq_enable(tp, false);
+
 	/* Force LAN exit from ASPM if Rx/Tx are not idle */
 	RTL_W32(tp, FuncEvent, RTL_R32(tp, FuncEvent) | 0x002800);
 
@@ -5635,6 +5637,7 @@ static void rtl_hw_start_8106(struct rtl8169_private *tp)
 	RTL_W8(tp, DLLPR, RTL_R8(tp, DLLPR) & ~PFM_EN);
 
 	rtl_pcie_state_l2l3_enable(tp, false);
+	rtl_hw_aspm_clkreq_enable(tp, true);
 }
 
 static void rtl_hw_start_8101(struct rtl8169_private *tp)
-- 
2.17.1

