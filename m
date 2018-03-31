Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752989AbeCaHF5 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 03:05:57 -0400
Received: from smtprelay0011.hostedemail.com ([216.40.44.11]:39967 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752422AbeCaHFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 03:05:52 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::,RULES_HIT:2:41:355:379:541:800:960:973:981:988:989:1260:1345:1359:1437:1535:1605:1730:1747:1777:1792:2194:2199:2393:2559:2562:3138:3139:3140:3141:3142:3865:3867:3868:4050:4119:4250:4321:4605:5007:6119:6261:7875:7903:9592:10004:10848:11026:11473:11657:11658:11914:12043:12048:12296:12438:12555:12690:12737:12895:12986:13255:14196:14394:21080:21451:21627:30003:30012:30051:30054:30080,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: print03_8a3075b5d8954
X-Filterd-Recvd-Size: 8660
From: Joe Perches <joe@perches.com>
To: Christian Lamparter <chunkeey@googlemail.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Ganapathi Bhat <gbhat@marvell.com>, Xinming Hu <huxm@marvell.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Jussi Kivilinna <jussi.kivilinna@iki.fi>,
        Kalle Valo <kvalo@codeaurora.org>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, b43-dev@lists.infradead.org
Subject: [PATCH 06/12] wireless: Convert simple uses of a static const Ethernet broadcast address
Date: Sat, 31 Mar 2018 00:05:21 -0700
Message-Id: <79196f134a513d50968e8e208a0e56b3c0236ee3.1522479607.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <cover.1522479607.git.joe@perches.com>
References: <cover.1522479607.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new ether_broadcast_addr global instead to save some object code.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/net/wireless/admtek/adm8211.c           | 3 +--
 drivers/net/wireless/ath/carl9170/mac.c         | 4 +---
 drivers/net/wireless/broadcom/b43/main.c        | 3 +--
 drivers/net/wireless/marvell/mwifiex/cfg80211.c | 3 +--
 drivers/net/wireless/realtek/rtlwifi/core.c     | 5 ++---
 drivers/net/wireless/rndis_wlan.c               | 6 +-----
 drivers/net/wireless/ti/wl1251/main.c           | 5 +----
 drivers/net/wireless/ti/wlcore/main.c           | 5 +----
 8 files changed, 9 insertions(+), 25 deletions(-)

diff --git a/drivers/net/wireless/admtek/adm8211.c b/drivers/net/wireless/admtek/adm8211.c
index 3b0802fc5bf5..0aa2d114d5b3 100644
--- a/drivers/net/wireless/admtek/adm8211.c
+++ b/drivers/net/wireless/admtek/adm8211.c
@@ -1354,7 +1354,6 @@ static void adm8211_configure_filter(struct ieee80211_hw *dev,
 				     unsigned int *total_flags,
 				     u64 multicast)
 {
-	static const u8 bcast[ETH_ALEN] = { 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF };
 	struct adm8211_priv *priv = dev->priv;
 	unsigned int new_flags;
 	u32 mc_filter[2];
@@ -1385,7 +1384,7 @@ static void adm8211_configure_filter(struct ieee80211_hw *dev,
 		__clear_bit(IEEE80211_HW_RX_INCLUDES_FCS, dev->flags);
 
 	if (*total_flags & FIF_BCN_PRBRESP_PROMISC)
-		adm8211_set_bssid(dev, bcast);
+		adm8211_set_bssid(dev, ether_broadcast_addr);
 	else
 		adm8211_set_bssid(dev, priv->bssid);
 
diff --git a/drivers/net/wireless/ath/carl9170/mac.c b/drivers/net/wireless/ath/carl9170/mac.c
index 7d4a72dc98db..b1c608db047c 100644
--- a/drivers/net/wireless/ath/carl9170/mac.c
+++ b/drivers/net/wireless/ath/carl9170/mac.c
@@ -476,10 +476,8 @@ int carl9170_upload_key(struct ar9170 *ar, const u8 id, const u8 *mac,
 			const int keylen)
 {
 	struct carl9170_set_key_cmd key = { };
-	static const u8 bcast[ETH_ALEN] = {
-		0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
 
-	mac = mac ? : bcast;
+	mac = mac ? : ether_broadcast_addr;
 
 	key.user = cpu_to_le16(id);
 	key.keyId = cpu_to_le16(keyidx);
diff --git a/drivers/net/wireless/broadcom/b43/main.c b/drivers/net/wireless/broadcom/b43/main.c
index b37e7391f55d..f23d60064691 100644
--- a/drivers/net/wireless/broadcom/b43/main.c
+++ b/drivers/net/wireless/broadcom/b43/main.c
@@ -4185,7 +4185,6 @@ static int b43_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	u8 algorithm;
 	u8 index;
 	int err;
-	static const u8 bcast_addr[ETH_ALEN] = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
 
 	if (modparam_nohwcrypt)
 		return -ENOSPC; /* User disabled HW-crypto */
@@ -4293,7 +4292,7 @@ static int b43_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 		b43dbg(wl, "%s hardware based encryption for keyidx: %d, "
 		       "mac: %pM\n",
 		       cmd == SET_KEY ? "Using" : "Disabling", key->keyidx,
-		       sta ? sta->addr : bcast_addr);
+		       sta ? sta->addr : ether_broadcast_addr);
 		b43_dump_keymemory(dev);
 	}
 	mutex_unlock(&wl->mutex);
diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index 7f7e9de2db1c..400a4a67d545 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -174,7 +174,6 @@ mwifiex_cfg80211_del_key(struct wiphy *wiphy, struct net_device *netdev,
 static int
 mwifiex_form_mgmt_frame(struct sk_buff *skb, const u8 *buf, size_t len)
 {
-	u8 addr[ETH_ALEN] = {0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF};
 	u16 pkt_len;
 	u32 tx_control = 0, pkt_type = PKT_TYPE_MGMT;
 
@@ -191,7 +190,7 @@ mwifiex_form_mgmt_frame(struct sk_buff *skb, const u8 *buf, size_t len)
 
 	/* Add packet data and address4 */
 	skb_put_data(skb, buf, sizeof(struct ieee80211_hdr_3addr));
-	skb_put_data(skb, addr, ETH_ALEN);
+	skb_put_data(skb, ether_broadcast_addr, ETH_ALEN);
 	skb_put_data(skb, buf + sizeof(struct ieee80211_hdr_3addr),
 		     len - sizeof(struct ieee80211_hdr_3addr));
 
diff --git a/drivers/net/wireless/realtek/rtlwifi/core.c b/drivers/net/wireless/realtek/rtlwifi/core.c
index cfea57efa7f4..8c534a93dad5 100644
--- a/drivers/net/wireless/realtek/rtlwifi/core.c
+++ b/drivers/net/wireless/realtek/rtlwifi/core.c
@@ -1527,7 +1527,6 @@ static int rtl_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	bool wep_only = false;
 	int err = 0;
 	u8 mac_addr[ETH_ALEN];
-	u8 bcast_addr[ETH_ALEN] = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
 
 	rtlpriv->btcoexist.btc_info.in_4way = false;
 
@@ -1544,7 +1543,7 @@ static int rtl_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
 		 "%s hardware based encryption for keyidx: %d, mac: %pM\n",
 		  cmd == SET_KEY ? "Using" : "Disabling", key->keyidx,
-		  sta ? sta->addr : bcast_addr);
+		  sta ? sta->addr : ether_broadcast_addr);
 	rtlpriv->sec.being_setkey = true;
 	rtl_ips_nic_on(hw);
 	mutex_lock(&rtlpriv->locks.conf_mutex);
@@ -1649,7 +1648,7 @@ static int rtl_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 			memcpy(rtlpriv->sec.key_buf[key_idx],
 			       key->key, key->keylen);
 			rtlpriv->sec.key_len[key_idx] = key->keylen;
-			memcpy(mac_addr, bcast_addr, ETH_ALEN);
+			memcpy(mac_addr, ether_broadcast_addr, ETH_ALEN);
 		} else {	/* pairwise key */
 			RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
 				 "set pairwise key\n");
diff --git a/drivers/net/wireless/rndis_wlan.c b/drivers/net/wireless/rndis_wlan.c
index 9935bd09db1f..da0c4f790dd0 100644
--- a/drivers/net/wireless/rndis_wlan.c
+++ b/drivers/net/wireless/rndis_wlan.c
@@ -1021,11 +1021,7 @@ static int set_bssid(struct usbnet *usbdev, const u8 *bssid)
 
 static int clear_bssid(struct usbnet *usbdev)
 {
-	static const u8 broadcast_mac[ETH_ALEN] = {
-		0xff, 0xff, 0xff, 0xff, 0xff, 0xff
-	};
-
-	return set_bssid(usbdev, broadcast_mac);
+	return set_bssid(usbdev, ether_broadcast_addr);
 }
 
 static int get_bssid(struct usbnet *usbdev, u8 bssid[ETH_ALEN])
diff --git a/drivers/net/wireless/ti/wl1251/main.c b/drivers/net/wireless/ti/wl1251/main.c
index bd8641ad953b..442a557ad2e2 100644
--- a/drivers/net/wireless/ti/wl1251/main.c
+++ b/drivers/net/wireless/ti/wl1251/main.c
@@ -887,9 +887,6 @@ static int wl1251_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	const u8 *addr;
 	int ret;
 
-	static const u8 bcast_addr[ETH_ALEN] =
-		{ 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
-
 	wl1251_debug(DEBUG_MAC80211, "mac80211 set key");
 
 	wl_cmd = kzalloc(sizeof(*wl_cmd), GFP_KERNEL);
@@ -898,7 +895,7 @@ static int wl1251_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 		goto out;
 	}
 
-	addr = sta ? sta->addr : bcast_addr;
+	addr = sta ? sta->addr : ether_broadcast_addr;
 
 	wl1251_debug(DEBUG_CRYPT, "CMD: 0x%x", cmd);
 	wl1251_dump(DEBUG_CRYPT, "ADDR: ", addr, ETH_ALEN);
diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
index 3a51ab116e79..a4a408f48eeb 100644
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -3392,11 +3392,8 @@ static int wl1271_set_key(struct wl1271 *wl, struct wl12xx_vif *wlvif,
 			return ret;
 	} else {
 		const u8 *addr;
-		static const u8 bcast_addr[ETH_ALEN] = {
-			0xff, 0xff, 0xff, 0xff, 0xff, 0xff
-		};
 
-		addr = sta ? sta->addr : bcast_addr;
+		addr = sta ? sta->addr : ether_broadcast_addr;
 
 		if (is_zero_ether_addr(addr)) {
 			/* We dont support TX only encryption */
-- 
2.15.0
