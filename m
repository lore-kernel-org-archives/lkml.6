Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673F9C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E4782080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vgLnqBfB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E4782080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728577AbeJ3WVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:21:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:52556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726925AbeJ3WVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 18:21:39 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9BD020870;
        Tue, 30 Oct 2018 13:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540906091;
        bh=6l4kBxfM1QevW2eFNSUJRSzvNlUyfJzzxGEZpdvi7Us=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vgLnqBfBB81Lz2kNEknZRfS5JsTxE92+vNykNQVIYpn6Nogpxja6Syw9JOiSH9ipl
         QWcAtKldRIXXJO5MqLCh/tGPt21D+CfOtaZjzGGiY36obQX8uEquRGXIr7j00LZGD2
         Ctnl0pgNSGL+e2Nu6HYyWdr7LlZ4OLa3DkJ6C1mY=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 27/33] r8169: re-enable MSI-X on RTL8168g
Date:   Tue, 30 Oct 2018 09:26:51 -0400
Message-Id: <20181030132657.217970-27-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181030132657.217970-1-sashal@kernel.org>
References: <20181030132657.217970-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiner Kallweit <hkallweit1@gmail.com>

[ Upstream commit 9675931e6b65d160d16bcc9472c1acef15524def ]

Similar to d49c88d7677b ("r8169: Enable MSI-X on RTL8106e") after
e9d0ba506ea8 ("PCI: Reprogram bridge prefetch registers on resume")
we can safely assume that this also fixes the root cause of
the issue worked around by 7c53a722459c ("r8169: don't use MSI-X on
RTL8168g"). So let's revert it.

Fixes: 7c53a722459c ("r8169: don't use MSI-X on RTL8168g")
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/realtek/r8169.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/realtek/r8169.c
index 36422f783fe7..2eea2b66d970 100644
--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -7546,11 +7546,6 @@ static int rtl_alloc_irq(struct rtl8169_private *tp)
 		RTL_W8(tp, Config2, RTL_R8(tp, Config2) & ~MSIEnable);
 		RTL_W8(tp, Cfg9346, Cfg9346_Lock);
 		flags = PCI_IRQ_LEGACY;
-	} else if (tp->mac_version == RTL_GIGA_MAC_VER_40) {
-		/* This version was reported to have issues with resume
-		 * from suspend when using MSI-X
-		 */
-		flags = PCI_IRQ_LEGACY | PCI_IRQ_MSI;
 	} else {
 		flags = PCI_IRQ_ALL_TYPES;
 	}
-- 
2.17.1

