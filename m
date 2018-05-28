Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163070AbeE1Kox (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:44:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:35486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163048AbeE1Kot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:44:49 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Naftali Goldstein <naftali.goldstein@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 084/496] iwlwifi: mvm: always init rs with 20mhz bandwidth rates
Date: Mon, 28 May 2018 11:57:49 +0200
Message-Id: <20180528100323.335987345@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Naftali Goldstein <naftali.goldstein@intel.com>

[ Upstream commit 6b7a5aea71b342ec0593d23b08383e1f33da4c9a ]

In AP mode, when a new station associates, rs is initialized immediately
upon association completion, before the phy context is updated with the
association parameters, so the sta bandwidth might be wider than the phy
context allows.
To avoid this issue, always initialize rs with 20mhz bandwidth rate, and
after authorization, when the phy context is already up-to-date, re-init
rs with the correct bw.

Signed-off-by: Naftali Goldstein <naftali.goldstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c |    4 +++
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c       |   28 +++++++++++++++-------
 2 files changed, 24 insertions(+), 8 deletions(-)

--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -2703,6 +2703,10 @@ static int iwl_mvm_mac_sta_state(struct
 
 		/* enable beacon filtering */
 		WARN_ON(iwl_mvm_enable_beacon_filter(mvm, vif, 0));
+
+		iwl_mvm_rs_rate_init(mvm, sta, mvmvif->phy_ctxt->channel->band,
+				     false);
+
 		ret = 0;
 	} else if (old_state == IEEE80211_STA_AUTHORIZED &&
 		   new_state == IEEE80211_STA_ASSOC) {
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
@@ -2690,7 +2690,8 @@ static void rs_get_initial_rate(struct i
 				struct ieee80211_sta *sta,
 				struct iwl_lq_sta *lq_sta,
 				enum nl80211_band band,
-				struct rs_rate *rate)
+				struct rs_rate *rate,
+				bool init)
 {
 	int i, nentries;
 	unsigned long active_rate;
@@ -2744,14 +2745,25 @@ static void rs_get_initial_rate(struct i
 	 */
 	if (sta->vht_cap.vht_supported &&
 	    best_rssi > IWL_RS_LOW_RSSI_THRESHOLD) {
-		switch (sta->bandwidth) {
-		case IEEE80211_STA_RX_BW_160:
-		case IEEE80211_STA_RX_BW_80:
-		case IEEE80211_STA_RX_BW_40:
+		/*
+		 * In AP mode, when a new station associates, rs is initialized
+		 * immediately upon association completion, before the phy
+		 * context is updated with the association parameters, so the
+		 * sta bandwidth might be wider than the phy context allows.
+		 * To avoid this issue, always initialize rs with 20mhz
+		 * bandwidth rate, and after authorization, when the phy context
+		 * is already up-to-date, re-init rs with the correct bw.
+		 */
+		u32 bw = init ? RATE_MCS_CHAN_WIDTH_20 : rs_bw_from_sta_bw(sta);
+
+		switch (bw) {
+		case RATE_MCS_CHAN_WIDTH_40:
+		case RATE_MCS_CHAN_WIDTH_80:
+		case RATE_MCS_CHAN_WIDTH_160:
 			initial_rates = rs_optimal_rates_vht;
 			nentries = ARRAY_SIZE(rs_optimal_rates_vht);
 			break;
-		case IEEE80211_STA_RX_BW_20:
+		case RATE_MCS_CHAN_WIDTH_20:
 			initial_rates = rs_optimal_rates_vht_20mhz;
 			nentries = ARRAY_SIZE(rs_optimal_rates_vht_20mhz);
 			break;
@@ -2762,7 +2774,7 @@ static void rs_get_initial_rate(struct i
 
 		active_rate = lq_sta->active_siso_rate;
 		rate->type = LQ_VHT_SISO;
-		rate->bw = rs_bw_from_sta_bw(sta);
+		rate->bw = bw;
 	} else if (sta->ht_cap.ht_supported &&
 		   best_rssi > IWL_RS_LOW_RSSI_THRESHOLD) {
 		initial_rates = rs_optimal_rates_ht;
@@ -2844,7 +2856,7 @@ static void rs_initialize_lq(struct iwl_
 	tbl = &(lq_sta->lq_info[active_tbl]);
 	rate = &tbl->rate;
 
-	rs_get_initial_rate(mvm, sta, lq_sta, band, rate);
+	rs_get_initial_rate(mvm, sta, lq_sta, band, rate, init);
 	rs_init_optimal_rate(mvm, sta, lq_sta);
 
 	WARN_ONCE(rate->ant != ANT_A && rate->ant != ANT_B,
