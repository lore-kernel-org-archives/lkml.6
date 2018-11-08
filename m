Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLACK,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD51DC43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A17D20857
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYq9M3yY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A17D20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbeKIIQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 03:16:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:51040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729324AbeKIHec (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:34:32 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F95020989;
        Thu,  8 Nov 2018 21:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714224;
        bh=px/Y1+kY3sGhpFiEnsgbIDx3EqtNzYMmggkA9mmTFs0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hYq9M3yYnQ903ugzu0Y0x0vimC28V6qwbhjGyqRv2+xkWEank7xTzdJZLqWi3wJAI
         0a2O0ZurhFVPUU0EShgwzPpvz899YK60z/LrVW9QQFpOUJdNd0pjaFcVjbH5qY+eqb
         K/KEjEVYOzmm8i/VP2WOheGO52KjT2YlDi4ENdNo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Larry Finger <Larry.Finger@lwfinger.net>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 104/144] rtlwifi: rtl8821ae: Fix system lockups on boot
Date:   Thu,  8 Nov 2018 13:51:15 -0800
Message-Id: <20181108215105.368938802@linuxfoundation.org>
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

[ Upstream commit 54328e64047a54b8fc2362c2e1f0fa16c90f739f ]

In commit 1277fa2ab2f9 ("rtlwifi: Remove the clear interrupt routine from all
drivers"), the code that cleared all interrupt enable bits before setting them
was removed for all PCI drivers. This fixed an issue that caused TX to be
blocked for 3-5 seconds. On some RTL8821AE units, this change causes soft
lockups to occur on boot. For that reason, the portion of the earlier commit
that applied to rtl8821ae is reverted. Kernels 4.1 and newer are affected.

See http://marc.info/?l=linux-wireless&m=144373370103285&w=2 and
https://bugzilla.opensuse.org/show_bug.cgi?id=944978 for two cases where
this regression affected user systems. Note that this bug does not appear on
any of the developer's setups. For those users whose systems are affected
by the TX blockage, but do not lock up on boot, a module parameter is added
to disable the interrupt clear

Fixes: 1277fa2ab2f9 ("rtlwifi: Remove the clear interrupt routine from all drivers")
Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Stable <stable@vger.kernel.org> [V4.1+]
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/rtlwifi/pci.h          |  2 ++
 drivers/net/wireless/rtlwifi/rtl8821ae/hw.c | 17 +++++++++++++++++
 drivers/net/wireless/rtlwifi/rtl8821ae/sw.c |  5 +++++
 drivers/net/wireless/rtlwifi/wifi.h         |  3 +++
 4 files changed, 27 insertions(+)

diff --git a/drivers/net/wireless/rtlwifi/pci.h b/drivers/net/wireless/rtlwifi/pci.h
index d4567d12e07e..5da6703942d9 100644
--- a/drivers/net/wireless/rtlwifi/pci.h
+++ b/drivers/net/wireless/rtlwifi/pci.h
@@ -247,6 +247,8 @@ struct rtl_pci {
 	/* MSI support */
 	bool msi_support;
 	bool using_msi;
+	/* interrupt clear before set */
+	bool int_clear;
 };
 
 struct mp_adapter {
diff --git a/drivers/net/wireless/rtlwifi/rtl8821ae/hw.c b/drivers/net/wireless/rtlwifi/rtl8821ae/hw.c
index e17b728a21aa..28b8b6a25f6d 100644
--- a/drivers/net/wireless/rtlwifi/rtl8821ae/hw.c
+++ b/drivers/net/wireless/rtlwifi/rtl8821ae/hw.c
@@ -2253,11 +2253,28 @@ void rtl8821ae_set_qos(struct ieee80211_hw *hw, int aci)
 	}
 }
 
+static void rtl8821ae_clear_interrupt(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	u32 tmp = rtl_read_dword(rtlpriv, REG_HISR);
+
+	rtl_write_dword(rtlpriv, REG_HISR, tmp);
+
+	tmp = rtl_read_dword(rtlpriv, REG_HISRE);
+	rtl_write_dword(rtlpriv, REG_HISRE, tmp);
+
+	tmp = rtl_read_dword(rtlpriv, REG_HSISR);
+	rtl_write_dword(rtlpriv, REG_HSISR, tmp);
+}
+
 void rtl8821ae_enable_interrupt(struct ieee80211_hw *hw)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
 
+	if (!rtlpci->int_clear)
+		rtl8821ae_clear_interrupt(hw);/*clear it here first*/
+
 	rtl_write_dword(rtlpriv, REG_HIMR, rtlpci->irq_mask[0] & 0xFFFFFFFF);
 	rtl_write_dword(rtlpriv, REG_HIMRE, rtlpci->irq_mask[1] & 0xFFFFFFFF);
 	rtlpci->irq_enabled = true;
diff --git a/drivers/net/wireless/rtlwifi/rtl8821ae/sw.c b/drivers/net/wireless/rtlwifi/rtl8821ae/sw.c
index fc92dd6a0d07..80307d187c0a 100644
--- a/drivers/net/wireless/rtlwifi/rtl8821ae/sw.c
+++ b/drivers/net/wireless/rtlwifi/rtl8821ae/sw.c
@@ -142,6 +142,7 @@ int rtl8821ae_init_sw_vars(struct ieee80211_hw *hw)
 
 	rtl8821ae_bt_reg_init(hw);
 	rtlpci->msi_support = rtlpriv->cfg->mod_params->msi_support;
+	rtlpci->int_clear = rtlpriv->cfg->mod_params->int_clear;
 	rtlpriv->btcoexist.btc_ops = rtl_btc_get_ops_pointer();
 
 	rtlpriv->dm.dm_initialgain_enable = 1;
@@ -213,6 +214,7 @@ int rtl8821ae_init_sw_vars(struct ieee80211_hw *hw)
 	rtlpriv->psc.swctrl_lps = rtlpriv->cfg->mod_params->swctrl_lps;
 	rtlpriv->psc.fwctrl_lps = rtlpriv->cfg->mod_params->fwctrl_lps;
 	rtlpci->msi_support = rtlpriv->cfg->mod_params->msi_support;
+	rtlpci->msi_support = rtlpriv->cfg->mod_params->int_clear;
 	if (rtlpriv->cfg->mod_params->disable_watchdog)
 		pr_info("watchdog disabled\n");
 	rtlpriv->psc.reg_fwctrl_lps = 3;
@@ -334,6 +336,7 @@ static struct rtl_mod_params rtl8821ae_mod_params = {
 	.swctrl_lps = false,
 	.fwctrl_lps = true,
 	.msi_support = true,
+	.int_clear = true,
 	.debug = DBG_EMERG,
 	.disable_watchdog = 0,
 };
@@ -463,6 +466,7 @@ module_param_named(fwlps, rtl8821ae_mod_params.fwctrl_lps, bool, 0444);
 module_param_named(msi, rtl8821ae_mod_params.msi_support, bool, 0444);
 module_param_named(disable_watchdog, rtl8821ae_mod_params.disable_watchdog,
 		   bool, 0444);
+module_param_named(int_clear, rtl8821ae_mod_params.int_clear, bool, 0444);
 MODULE_PARM_DESC(swenc, "Set to 1 for software crypto (default 0)\n");
 MODULE_PARM_DESC(ips, "Set to 0 to not use link power save (default 1)\n");
 MODULE_PARM_DESC(swlps, "Set to 1 to use SW control power save (default 0)\n");
@@ -470,6 +474,7 @@ MODULE_PARM_DESC(fwlps, "Set to 1 to use FW control power save (default 1)\n");
 MODULE_PARM_DESC(msi, "Set to 1 to use MSI interrupts mode (default 1)\n");
 MODULE_PARM_DESC(debug, "Set debug level (0-5) (default 0)");
 MODULE_PARM_DESC(disable_watchdog, "Set to 1 to disable the watchdog (default 0)\n");
+MODULE_PARM_DESC(int_clear, "Set to 1 to disable interrupt clear before set (default 0)\n");
 
 static SIMPLE_DEV_PM_OPS(rtlwifi_pm_ops, rtl_pci_suspend, rtl_pci_resume);
 
diff --git a/drivers/net/wireless/rtlwifi/wifi.h b/drivers/net/wireless/rtlwifi/wifi.h
index 27822fe34d9a..318078645e64 100644
--- a/drivers/net/wireless/rtlwifi/wifi.h
+++ b/drivers/net/wireless/rtlwifi/wifi.h
@@ -2212,6 +2212,9 @@ struct rtl_mod_params {
 
 	/* default 0: 1 means disable */
 	bool disable_watchdog;
+
+	/* default 0: 1 means do not disable interrupts */
+	bool int_clear;
 };
 
 struct rtl_hal_usbint_cfg {
-- 
2.17.1



