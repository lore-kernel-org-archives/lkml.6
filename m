Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E8FDEC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 09:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D5C92087E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 09:58:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D5C92087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932635AbeFLJ6R (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 05:58:17 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35062 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752077AbeFLJ6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 05:58:12 -0400
Received: from 2.general.khfeng.us.vpn ([10.172.68.175] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1fSg3z-0007iO-U7; Tue, 12 Jun 2018 09:58:08 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     davem@davemloft.net
Cc:     ryankao@realtek.com, hayeswang@realtek.com, hau@realtek.com,
        hkallweit1@gmail.com, romieu@fr.zoreil.com, bhelgaas@google.com,
        netdev@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH 2/2] r8169: Reinstate ASPM Support
Date:   Tue, 12 Jun 2018 17:57:59 +0800
Message-Id: <20180612095759.6828-2-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180612095759.6828-1-kai.heng.feng@canonical.com>
References: <20180612095759.6828-1-kai.heng.feng@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On newer Intel platforms, ASPM support in r8169 is the last missing
puzzle to let Package C-State achieves PC8. Without ASPM support, the
deepest Package C-State can hit is PC3.
PC8 can save additional ~3W in comparison with PC3 on my testing
platform.

The original patch is from Realtek.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v2:
- Remove module parameter.
- Remove pci_disable_link_state().

 drivers/net/ethernet/realtek/r8169.c | 41 +++++++++++++++++++---------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/realtek/r8169.c
index 9b55ce513a36..85f4e746b040 100644
--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -5289,6 +5289,18 @@ static void rtl_pcie_state_l2l3_enable(struct rtl8169_private *tp, bool enable)
 	RTL_W8(tp, Config3, data);
 }
 
+static void rtl_hw_internal_aspm_clkreq_enable(struct rtl8169_private *tp,
+					       bool enable)
+{
+	if (enable) {
+		RTL_W8(tp, Config2, RTL_R8(tp, Config2) | ClkReqEn);
+		RTL_W8(tp, Config5, RTL_R8(tp, Config5) | ASPM_en);
+	} else {
+		RTL_W8(tp, Config2, RTL_R8(tp, Config2) & ~ClkReqEn);
+		RTL_W8(tp, Config5, RTL_R8(tp, Config5) & ~ASPM_en);
+	}
+}
+
 static void rtl_hw_start_8168bb(struct rtl8169_private *tp)
 {
 	RTL_W8(tp, Config3, RTL_R8(tp, Config3) & ~Beacon_en);
@@ -5645,9 +5657,9 @@ static void rtl_hw_start_8168g_1(struct rtl8169_private *tp)
 	rtl_hw_start_8168g(tp);
 
 	/* disable aspm and clock request before access ephy */
-	RTL_W8(tp, Config2, RTL_R8(tp, Config2) & ~ClkReqEn);
-	RTL_W8(tp, Config5, RTL_R8(tp, Config5) & ~ASPM_en);
+	rtl_hw_internal_aspm_clkreq_enable(tp, false);
 	rtl_ephy_init(tp, e_info_8168g_1, ARRAY_SIZE(e_info_8168g_1));
+	rtl_hw_internal_aspm_clkreq_enable(tp, true);
 }
 
 static void rtl_hw_start_8168g_2(struct rtl8169_private *tp)
@@ -5680,9 +5692,9 @@ static void rtl_hw_start_8411_2(struct rtl8169_private *tp)
 	rtl_hw_start_8168g(tp);
 
 	/* disable aspm and clock request before access ephy */
-	RTL_W8(tp, Config2, RTL_R8(tp, Config2) & ~ClkReqEn);
-	RTL_W8(tp, Config5, RTL_R8(tp, Config5) & ~ASPM_en);
+	rtl_hw_internal_aspm_clkreq_enable(tp, false);
 	rtl_ephy_init(tp, e_info_8411_2, ARRAY_SIZE(e_info_8411_2));
+	rtl_hw_internal_aspm_clkreq_enable(tp, true);
 }
 
 static void rtl_hw_start_8168h_1(struct rtl8169_private *tp)
@@ -5699,8 +5711,7 @@ static void rtl_hw_start_8168h_1(struct rtl8169_private *tp)
 	};
 
 	/* disable aspm and clock request before access ephy */
-	RTL_W8(tp, Config2, RTL_R8(tp, Config2) & ~ClkReqEn);
-	RTL_W8(tp, Config5, RTL_R8(tp, Config5) & ~ASPM_en);
+	rtl_hw_internal_aspm_clkreq_enable(tp, false);
 	rtl_ephy_init(tp, e_info_8168h_1, ARRAY_SIZE(e_info_8168h_1));
 
 	RTL_W32(tp, TxConfig, RTL_R32(tp, TxConfig) | TXCFG_AUTO_FIFO);
@@ -5779,6 +5790,8 @@ static void rtl_hw_start_8168h_1(struct rtl8169_private *tp)
 	r8168_mac_ocp_write(tp, 0xe63e, 0x0000);
 	r8168_mac_ocp_write(tp, 0xc094, 0x0000);
 	r8168_mac_ocp_write(tp, 0xc09e, 0x0000);
+
+	rtl_hw_internal_aspm_clkreq_enable(tp, true);
 }
 
 static void rtl_hw_start_8168ep(struct rtl8169_private *tp)
@@ -5830,11 +5843,12 @@ static void rtl_hw_start_8168ep_1(struct rtl8169_private *tp)
 	};
 
 	/* disable aspm and clock request before access ephy */
-	RTL_W8(tp, Config2, RTL_R8(tp, Config2) & ~ClkReqEn);
-	RTL_W8(tp, Config5, RTL_R8(tp, Config5) & ~ASPM_en);
+	rtl_hw_internal_aspm_clkreq_enable(tp, false);
 	rtl_ephy_init(tp, e_info_8168ep_1, ARRAY_SIZE(e_info_8168ep_1));
 
 	rtl_hw_start_8168ep(tp);
+
+	rtl_hw_internal_aspm_clkreq_enable(tp, true);
 }
 
 static void rtl_hw_start_8168ep_2(struct rtl8169_private *tp)
@@ -5846,14 +5860,15 @@ static void rtl_hw_start_8168ep_2(struct rtl8169_private *tp)
 	};
 
 	/* disable aspm and clock request before access ephy */
-	RTL_W8(tp, Config2, RTL_R8(tp, Config2) & ~ClkReqEn);
-	RTL_W8(tp, Config5, RTL_R8(tp, Config5) & ~ASPM_en);
+	rtl_hw_internal_aspm_clkreq_enable(tp, false);
 	rtl_ephy_init(tp, e_info_8168ep_2, ARRAY_SIZE(e_info_8168ep_2));
 
 	rtl_hw_start_8168ep(tp);
 
 	RTL_W8(tp, DLLPR, RTL_R8(tp, DLLPR) & ~PFM_EN);
 	RTL_W8(tp, MISC_1, RTL_R8(tp, MISC_1) & ~PFM_D3COLD_EN);
+
+	rtl_hw_internal_aspm_clkreq_enable(tp, true);
 }
 
 static void rtl_hw_start_8168ep_3(struct rtl8169_private *tp)
@@ -5867,8 +5882,7 @@ static void rtl_hw_start_8168ep_3(struct rtl8169_private *tp)
 	};
 
 	/* disable aspm and clock request before access ephy */
-	RTL_W8(tp, Config2, RTL_R8(tp, Config2) & ~ClkReqEn);
-	RTL_W8(tp, Config5, RTL_R8(tp, Config5) & ~ASPM_en);
+	rtl_hw_internal_aspm_clkreq_enable(tp, false);
 	rtl_ephy_init(tp, e_info_8168ep_3, ARRAY_SIZE(e_info_8168ep_3));
 
 	rtl_hw_start_8168ep(tp);
@@ -5888,6 +5902,8 @@ static void rtl_hw_start_8168ep_3(struct rtl8169_private *tp)
 	data = r8168_mac_ocp_read(tp, 0xe860);
 	data |= 0x0080;
 	r8168_mac_ocp_write(tp, 0xe860, data);
+
+	rtl_hw_internal_aspm_clkreq_enable(tp, true);
 }
 
 static void rtl_hw_start_8168(struct rtl8169_private *tp)
@@ -7646,7 +7662,6 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	mii->reg_num_mask = 0x1f;
 	mii->supports_gmii = cfg->has_gmii;
 
-
 	/* enable device (incl. PCI PM wakeup and hotplug setup) */
 	rc = pcim_enable_device(pdev);
 	if (rc < 0) {
-- 
2.17.0

