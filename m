Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752260AbeDJCmJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 22:42:09 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:60795 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752200AbeDJCmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 22:42:07 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID w3A2fvdH026293, This message is accepted by code: ctloc85258
From: <pkshih@realtek.com>
To: <kvalo@codeaurora.org>
CC: <Larry.Finger@lwfinger.net>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 8/9] rtlwifi: btcoex: Add struct members to replace global varaibles
Date: Tue, 10 Apr 2018 10:41:43 +0800
Message-ID: <20180410024144.5027-9-pkshih@realtek.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180410024144.5027-1-pkshih@realtek.com>
References: <20180410024144.5027-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.69.140]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ping-Ke Shih <pkshih@realtek.com>

Chip specific context plays as global variables that will not support
multiple devices simultaneously. This patch adds 'union' fields to hold
the variables, and next patch will remove all of them.

To use the declaration of fields in halbtcoutsrc.h, I move the including
order in header file halbt_precomp.h, and declare two struct terms for
chip specific header files.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 .../realtek/rtlwifi/btcoexist/halbt_precomp.h      |  6 +++++-
 .../realtek/rtlwifi/btcoexist/halbtcoutsrc.h       | 24 ++++++++++++++++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbt_precomp.h b/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbt_precomp.h
index 858318fd3d63..e21222b48c2c 100644
--- a/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbt_precomp.h
+++ b/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbt_precomp.h
@@ -35,7 +35,6 @@
 #include "../ps.h"
 #include "../pci.h"
 
-#include "halbtcoutsrc.h"
 
 /* Interface type */
 #define RT_PCI_INTERFACE	1
@@ -43,6 +42,9 @@
 #define RT_SDIO_INTERFACE	3
 #define DEV_BUS_TYPE		RT_PCI_INTERFACE
 
+struct btc_coexist;
+struct wifi_only_cfg;
+
 #include "halbtc8192e2ant.h"
 #include "halbtc8723b1ant.h"
 #include "halbtc8723b2ant.h"
@@ -52,6 +54,8 @@
 #include "halbtc8822b2ant.h"
 #include "halbtc8822bwifionly.h"
 
+#include "halbtcoutsrc.h"
+
 #define GetDefaultAdapter(padapter)	padapter
 
 #define BIT0	0x00000001
diff --git a/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.h b/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.h
index 9eae87d19120..46355ce32f1b 100644
--- a/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.h
+++ b/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.h
@@ -693,6 +693,30 @@ struct btc_coexist {
 	enum btc_chip_interface	chip_interface;
 	struct btc_bt_link_info bt_link_info;
 
+	/* context for each chip */
+	union {
+		struct coex_dm_8192e_2ant coex_dm_8192e_2ant;
+		struct coex_dm_8723b_1ant coex_dm_8723b_1ant;
+		struct coex_dm_8723b_2ant coex_dm_8723b_2ant;
+		struct coex_dm_8821a_1ant coex_dm_8821a_1ant;
+		struct coex_dm_8821a_2ant coex_dm_8821a_2ant;
+		struct coex_dm_8822b_1ant coex_dm_8822b_1ant;
+		struct coex_dm_8822b_2ant coex_dm_8822b_2ant;
+	};
+	union {
+		struct coex_sta_8192e_2ant coex_sta_8192e_2ant;
+		struct coex_sta_8723b_1ant coex_sta_8723b_1ant;
+		struct coex_sta_8723b_2ant coex_sta_8723b_2ant;
+		struct coex_sta_8821a_1ant coex_sta_8821a_1ant;
+		struct coex_sta_8821a_2ant coex_sta_8821a_2ant;
+		struct coex_sta_8822b_1ant coex_sta_8822b_1ant;
+		struct coex_sta_8822b_2ant coex_sta_8822b_2ant;
+	};
+	union {
+		struct rfe_type_8822b_1ant rfe_type_8822b_1ant;
+		struct rfe_type_8822b_2ant rfe_type_8822b_2ant;
+	};
+
 	/* boolean variables to replace BT_AUTO_REPORT_ONLY_XXXXY_ZANT
 	 * configuration parameters
 	 */
-- 
2.15.1
