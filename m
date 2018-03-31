Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753396AbeCaHHM (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 03:07:12 -0400
Received: from smtprelay0103.hostedemail.com ([216.40.44.103]:46881 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752967AbeCaHF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 03:05:57 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:355:379:541:800:960:968:973:981:988:989:1260:1345:1359:1437:1534:1542:1711:1730:1747:1777:1792:2393:2559:2562:3138:3139:3140:3141:3142:3353:3865:3866:3867:3868:4321:4419:5007:6117:6261:9592:10004:10848:11026:11473:11657:11658:11914:12043:12114:12296:12438:12555:12683:12699:12737:12895:12986:13255:13869:14181:14394:14721:21080:21451:21627:30005:30012:30054:30055,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:19,LUA_SUMMARY:none
X-HE-Tag: field84_8af788809fd60
X-Filterd-Recvd-Size: 3750
From: Joe Perches <joe@perches.com>
To: Stanislaw Gruszka <sgruszka@redhat.com>
Cc: Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/12] iwlegacy: Remove EXPORT_SYMBOL(il_bcast_addr) and use ether_broadcast_addr
Date: Sat, 31 Mar 2018 00:05:23 -0700
Message-Id: <f73cf3f9dc183157573a13736b6178d5ecbc8d9d.1522479608.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <cover.1522479607.git.joe@perches.com>
References: <cover.1522479607.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the local array and use the new global instead to save some small
amount of object code.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/net/wireless/intel/iwlegacy/3945-mac.c | 2 +-
 drivers/net/wireless/intel/iwlegacy/4965-mac.c | 2 +-
 drivers/net/wireless/intel/iwlegacy/common.c   | 3 ---
 drivers/net/wireless/intel/iwlegacy/common.h   | 1 -
 4 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlegacy/3945-mac.c b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
index 62a9794f952b..770c7aa13434 100644
--- a/drivers/net/wireless/intel/iwlegacy/3945-mac.c
+++ b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
@@ -2352,7 +2352,7 @@ il3945_alloc_bcast_station(struct il_priv *il)
 	u8 sta_id;
 
 	spin_lock_irqsave(&il->sta_lock, flags);
-	sta_id = il_prep_station(il, il_bcast_addr, false, NULL);
+	sta_id = il_prep_station(il, ether_broadcast_addr, false, NULL);
 	if (sta_id == IL_INVALID_STATION) {
 		IL_ERR("Unable to prepare broadcast station\n");
 		spin_unlock_irqrestore(&il->sta_lock, flags);
diff --git a/drivers/net/wireless/intel/iwlegacy/4965-mac.c b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
index 562e94870a9c..5772cbd9291c 100644
--- a/drivers/net/wireless/intel/iwlegacy/4965-mac.c
+++ b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
@@ -3536,7 +3536,7 @@ il4965_alloc_bcast_station(struct il_priv *il)
 	u8 sta_id;
 
 	spin_lock_irqsave(&il->sta_lock, flags);
-	sta_id = il_prep_station(il, il_bcast_addr, false, NULL);
+	sta_id = il_prep_station(il, ether_broadcast_addr, false, NULL);
 	if (sta_id == IL_INVALID_STATION) {
 		IL_ERR("Unable to prepare broadcast station\n");
 		spin_unlock_irqrestore(&il->sta_lock, flags);
diff --git a/drivers/net/wireless/intel/iwlegacy/common.c b/drivers/net/wireless/intel/iwlegacy/common.c
index 063e19ced7c8..5853b1dedea1 100644
--- a/drivers/net/wireless/intel/iwlegacy/common.c
+++ b/drivers/net/wireless/intel/iwlegacy/common.c
@@ -3378,9 +3378,6 @@ MODULE_PARM_DESC(bt_coex_active, "enable wifi/bluetooth co-exist");
 u32 il_debug_level;
 EXPORT_SYMBOL(il_debug_level);
 
-const u8 il_bcast_addr[ETH_ALEN] = { 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF };
-EXPORT_SYMBOL(il_bcast_addr);
-
 #define MAX_BIT_RATE_40_MHZ 150	/* Mbps */
 #define MAX_BIT_RATE_20_MHZ 72	/* Mbps */
 static void
diff --git a/drivers/net/wireless/intel/iwlegacy/common.h b/drivers/net/wireless/intel/iwlegacy/common.h
index dc6a74a05983..6a6b43c5e4d7 100644
--- a/drivers/net/wireless/intel/iwlegacy/common.h
+++ b/drivers/net/wireless/intel/iwlegacy/common.h
@@ -860,7 +860,6 @@ struct il_hw_params {
  *
  ****************************************************************************/
 void il4965_update_chain_flags(struct il_priv *il);
-extern const u8 il_bcast_addr[ETH_ALEN];
 int il_queue_space(const struct il_queue *q);
 static inline int
 il_queue_used(const struct il_queue *q, int i)
-- 
2.15.0
