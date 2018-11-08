Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F29EFECDE4C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA4832089F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hlgSY8IZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA4832089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729373AbeKIHec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:34:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:51068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729348AbeKIHec (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:34:32 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1C4F2089A;
        Thu,  8 Nov 2018 21:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714225;
        bh=vBRQdCydZxg9hRPHlxxEuM2HFMxMeKN7n+i8TcyYrq4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hlgSY8IZVTHitSR2nSUE+aUFwGoSpdUr+Sip6cGkD6hiPym3xR2Td2+IAZKW02itv
         Pc+hDEjr8itYNaKUgRkeDjzvmS6ThZouqeS4W19efTPkbfeEyRS6rdwyMNR20IfpHJ
         LAPN2uWA1aU/yiJOa0nZ7O7wbHjxBH4mC6FnzjBg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Larry Finger <Larry.Finger@lwfinger.net>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 105/144] rtlwifi: rtl8821ae: Fix lockups on boot
Date:   Thu,  8 Nov 2018 13:51:16 -0800
Message-Id: <20181108215105.464824899@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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



