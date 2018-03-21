Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751961AbeCUKc7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 06:32:59 -0400
Received: from smtprelay0061.hostedemail.com ([216.40.44.61]:38906 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751464AbeCUKc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 06:32:57 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::,RULES_HIT:41:355:379:541:800:960:968:973:988:989:1260:1345:1437:1534:1542:1711:1730:1747:1777:1792:1981:2194:2198:2199:2200:2393:2559:2562:3138:3139:3140:3141:3142:3353:3865:3867:3868:4250:4321:4419:4605:5007:6261:8603:9165:9592:10004:10848:11026:11473:11657:11658:11914:12043:12048:12296:12438:12555:12895:14096:14181:14394:14721:21080:21451:21627:30003:30054,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: tin01_3693de274ce2e
X-Filterd-Recvd-Size: 3408
From: Joe Perches <joe@perches.com>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
        Jiri Slaby <jirislaby@gmail.com>,
        Nick Kossifidis <mickflemm@gmail.com>,
        QCA ath9k Development <ath9k-devel@qca.qualcomm.com>
Cc: Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ath: Remove unnecessary ath_bcast_mac and use eth_broadcast_addr
Date: Wed, 21 Mar 2018 03:32:52 -0700
Message-Id: <3ed8112986ba6f538cb45df6ea67e0c027a3dc12.1521628278.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the static array and use the generic routine to set the
Ethernet broadcast address.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/net/wireless/ath/ath.h                | 2 --
 drivers/net/wireless/ath/ath5k/attach.c       | 2 +-
 drivers/net/wireless/ath/ath9k/htc_drv_init.c | 2 +-
 drivers/net/wireless/ath/ath9k/init.c         | 2 +-
 4 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath.h b/drivers/net/wireless/ath/ath.h
index f3f2784f6ebd..7a364eca46d6 100644
--- a/drivers/net/wireless/ath/ath.h
+++ b/drivers/net/wireless/ath/ath.h
@@ -33,8 +33,6 @@
  */
 #define	ATH_KEYMAX	        128     /* max key cache size we handle */
 
-static const u8 ath_bcast_mac[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
-
 struct ath_ani {
 	bool caldone;
 	unsigned int longcal_timer;
diff --git a/drivers/net/wireless/ath/ath5k/attach.c b/drivers/net/wireless/ath/ath5k/attach.c
index 233054bd6b52..12d3a6c92ba4 100644
--- a/drivers/net/wireless/ath/ath5k/attach.c
+++ b/drivers/net/wireless/ath/ath5k/attach.c
@@ -327,7 +327,7 @@ int ath5k_hw_init(struct ath5k_hw *ah)
 	ath5k_hw_set_lladdr(ah, zero_mac);
 
 	/* Set BSSID to bcast address: ff:ff:ff:ff:ff:ff for now */
-	memcpy(common->curbssid, ath_bcast_mac, ETH_ALEN);
+	eth_broadcast_addr(common->curbssid);
 	ath5k_hw_set_bssid(ah);
 	ath5k_hw_set_opmode(ah, ah->opmode);
 
diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_init.c b/drivers/net/wireless/ath/ath9k/htc_drv_init.c
index e89e5ef2c2a4..bf36bb2821b4 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_init.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_init.c
@@ -591,7 +591,7 @@ static void ath9k_init_misc(struct ath9k_htc_priv *priv)
 {
 	struct ath_common *common = ath9k_hw_common(priv->ah);
 
-	memcpy(common->bssidmask, ath_bcast_mac, ETH_ALEN);
+	eth_broadcast_addr(common->bssidmask);
 
 	common->last_rssi = ATH_RSSI_DUMMY_MARKER;
 	priv->ah->opmode = NL80211_IFTYPE_STATION;
diff --git a/drivers/net/wireless/ath/ath9k/init.c b/drivers/net/wireless/ath/ath9k/init.c
index e479fae5aab9..748becee3ecf 100644
--- a/drivers/net/wireless/ath/ath9k/init.c
+++ b/drivers/net/wireless/ath/ath9k/init.c
@@ -427,7 +427,7 @@ static void ath9k_init_misc(struct ath_softc *sc)
 	timer_setup(&common->ani.timer, ath_ani_calibrate, 0);
 
 	common->last_rssi = ATH_RSSI_DUMMY_MARKER;
-	memcpy(common->bssidmask, ath_bcast_mac, ETH_ALEN);
+	eth_broadcast_addr(common->bssidmask);
 	sc->beacon.slottime = 9;
 
 	for (i = 0; i < ARRAY_SIZE(sc->beacon.bslot); i++)
-- 
2.15.0
