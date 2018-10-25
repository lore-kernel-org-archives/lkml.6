Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AADAC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0288320856
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="e6Gs2UTC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0288320856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731216AbeJYWxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:53:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:36470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731163AbeJYWxr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:53:47 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57CA120870;
        Thu, 25 Oct 2018 14:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477249;
        bh=AAkThiCPCa2sfeqlFUFs44Umn5ceDgl8EZe+4C576IQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e6Gs2UTC/F53uRU5c5OA8A96SH+7LwXDNrJs32VJioTvmRCP78RBF3ODPubp3W2ah
         gw4qHk02dUCKIhxipYiDTH0+F/lTZ/BIpYjGfqyFfaCi7BMUTFAsa8ZeuWLgJeNfOf
         MSbZ+wSMq4KNU8C+/ZV2d28Ez4BLbmmy2Sz/2mro=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 76/98] rtlwifi: rtl8821ae: Fix lockups on boot
Date:   Thu, 25 Oct 2018 10:18:31 -0400
Message-Id: <20181025141853.214051-76-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Larry Finger <Larry.Finger@lwfinger.net>

[ Upstream commit eeec5d0ef7ee54a75e09e861c3cc44177b8752c7 ]

In commit 54328e64047a5 ("rtlwifi: rtl8821ae: Fix system lockups on boot"),
an attempt was made to fix a regression introduced in commit 1277fa2ab2f9
("rtlwifi: Remove the clear interrupt routine from all drivers").
Unfortunately, there were logic errors in that patch that prevented
affected boxes from booting even after that patch was applied.

The actual cause of the original problem is unknown as none of the
developers have systems that are affected.

Fixes: 54328e64047a ("rtlwifi: rtl8821ae: Fix system lockups on boot")
Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Stable <stable@vger.kernel.org> [V4.1+]
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/rtlwifi/rtl8821ae/hw.c | 2 +-
 drivers/net/wireless/rtlwifi/rtl8821ae/sw.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/rtlwifi/rtl8821ae/hw.c b/drivers/net/wireless/rtlwifi/rtl8821ae/hw.c
index 28b8b6a25f6d..3639398f3c71 100644
--- a/drivers/net/wireless/rtlwifi/rtl8821ae/hw.c
+++ b/drivers/net/wireless/rtlwifi/rtl8821ae/hw.c
@@ -2272,7 +2272,7 @@ void rtl8821ae_enable_interrupt(struct ieee80211_hw *hw)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
 
-	if (!rtlpci->int_clear)
+	if (rtlpci->int_clear)
 		rtl8821ae_clear_interrupt(hw);/*clear it here first*/
 
 	rtl_write_dword(rtlpriv, REG_HIMR, rtlpci->irq_mask[0] & 0xFFFFFFFF);
diff --git a/drivers/net/wireless/rtlwifi/rtl8821ae/sw.c b/drivers/net/wireless/rtlwifi/rtl8821ae/sw.c
index 80307d187c0a..71cf8120a95e 100644
--- a/drivers/net/wireless/rtlwifi/rtl8821ae/sw.c
+++ b/drivers/net/wireless/rtlwifi/rtl8821ae/sw.c
@@ -474,7 +474,7 @@ MODULE_PARM_DESC(fwlps, "Set to 1 to use FW control power save (default 1)\n");
 MODULE_PARM_DESC(msi, "Set to 1 to use MSI interrupts mode (default 1)\n");
 MODULE_PARM_DESC(debug, "Set debug level (0-5) (default 0)");
 MODULE_PARM_DESC(disable_watchdog, "Set to 1 to disable the watchdog (default 0)\n");
-MODULE_PARM_DESC(int_clear, "Set to 1 to disable interrupt clear before set (default 0)\n");
+MODULE_PARM_DESC(int_clear, "Set to 0 to disable interrupt clear before set (default 1)\n");
 
 static SIMPLE_DEV_PM_OPS(rtlwifi_pm_ops, rtl_pci_suspend, rtl_pci_resume);
 
-- 
2.17.1

