Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77623C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 06:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BEF620833
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 06:58:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BEF620833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbeILMBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 08:01:38 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38271 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbeILMBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 08:01:38 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1fzz6Z-0000UZ-4a; Wed, 12 Sep 2018 06:58:27 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     nic_swsd@realtek.com
Cc:     davem@davemloft.net, hkallweit1@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH 1/2] r8169: Align ASPM/CLKREQ setting function with vendor driver
Date:   Wed, 12 Sep 2018 14:58:20 +0800
Message-Id: <20180912065821.7198-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a small delay after setting ASPM in vendor drivers, r8101 and
r8168.
In addition, those drivers enable ASPM before ClkReq, also change that
to align with vendor driver.

I haven't seen anything bad becasue of this, but I think it's better to
keep in sync with vendor driver.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/net/ethernet/realtek/r8169.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/realtek/r8169.c
index b08d51bf7a20..5091e9fd601f 100644
--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -4775,12 +4775,14 @@ static void rtl_pcie_state_l2l3_enable(struct rtl8169_private *tp, bool enable)
 static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
 {
 	if (enable) {
-		RTL_W8(tp, Config2, RTL_R8(tp, Config2) | ClkReqEn);
 		RTL_W8(tp, Config5, RTL_R8(tp, Config5) | ASPM_en);
+		RTL_W8(tp, Config2, RTL_R8(tp, Config2) | ClkReqEn);
 	} else {
 		RTL_W8(tp, Config2, RTL_R8(tp, Config2) & ~ClkReqEn);
 		RTL_W8(tp, Config5, RTL_R8(tp, Config5) & ~ASPM_en);
 	}
+
+	udelay(10);
 }
 
 static void rtl_hw_start_8168bb(struct rtl8169_private *tp)
-- 
2.17.1

