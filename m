Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937622AbeE1Knr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:43:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:34632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937415AbeE1Knl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:43:41 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Oh <peter.oh@bowerswilkins.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 058/496] mac80211: mesh: fix wrong mesh TTL offset calculation
Date: Mon, 28 May 2018 11:57:23 +0200
Message-Id: <20180528100322.244313412@linuxfoundation.org>
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

From: Peter Oh <peter.oh@bowerswilkins.com>

[ Upstream commit c4de37ee2b55deac7d6aeac33e02e3d6be243898 ]

mesh TTL offset in Mesh Channel Switch Parameters element depends on
not only Secondary Channel Offset element, but also affected by
HT Control field and Wide Bandwidth Channel Switch element.
So use element structure to manipulate mesh channel swich param IE
after removing its constant attribution to correct the miscalculation.

Signed-off-by: Peter Oh <peter.oh@bowerswilkins.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mac80211/ieee80211_i.h |    2 +-
 net/mac80211/mesh.c        |   17 ++++++-----------
 2 files changed, 7 insertions(+), 12 deletions(-)

--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1466,7 +1466,7 @@ struct ieee802_11_elems {
 	const struct ieee80211_timeout_interval_ie *timeout_int;
 	const u8 *opmode_notif;
 	const struct ieee80211_sec_chan_offs_ie *sec_chan_offs;
-	const struct ieee80211_mesh_chansw_params_ie *mesh_chansw_params_ie;
+	struct ieee80211_mesh_chansw_params_ie *mesh_chansw_params_ie;
 	const struct ieee80211_bss_max_idle_period_ie *max_idle_period_ie;
 
 	/* length of them, respectively */
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -1253,13 +1253,12 @@ int ieee80211_mesh_csa_beacon(struct iee
 }
 
 static int mesh_fwd_csa_frame(struct ieee80211_sub_if_data *sdata,
-			       struct ieee80211_mgmt *mgmt, size_t len)
+			       struct ieee80211_mgmt *mgmt, size_t len,
+			       struct ieee802_11_elems *elems)
 {
 	struct ieee80211_mgmt *mgmt_fwd;
 	struct sk_buff *skb;
 	struct ieee80211_local *local = sdata->local;
-	u8 *pos = mgmt->u.action.u.chan_switch.variable;
-	size_t offset_ttl;
 
 	skb = dev_alloc_skb(local->tx_headroom + len);
 	if (!skb)
@@ -1267,13 +1266,9 @@ static int mesh_fwd_csa_frame(struct iee
 	skb_reserve(skb, local->tx_headroom);
 	mgmt_fwd = skb_put(skb, len);
 
-	/* offset_ttl is based on whether the secondary channel
-	 * offset is available or not. Subtract 1 from the mesh TTL
-	 * and disable the initiator flag before forwarding.
-	 */
-	offset_ttl = (len < 42) ? 7 : 10;
-	*(pos + offset_ttl) -= 1;
-	*(pos + offset_ttl + 1) &= ~WLAN_EID_CHAN_SWITCH_PARAM_INITIATOR;
+	elems->mesh_chansw_params_ie->mesh_ttl--;
+	elems->mesh_chansw_params_ie->mesh_flags &=
+		~WLAN_EID_CHAN_SWITCH_PARAM_INITIATOR;
 
 	memcpy(mgmt_fwd, mgmt, len);
 	eth_broadcast_addr(mgmt_fwd->da);
@@ -1321,7 +1316,7 @@ static void mesh_rx_csa_frame(struct iee
 
 	/* forward or re-broadcast the CSA frame */
 	if (fwd_csa) {
-		if (mesh_fwd_csa_frame(sdata, mgmt, len) < 0)
+		if (mesh_fwd_csa_frame(sdata, mgmt, len, &elems) < 0)
 			mcsa_dbg(sdata, "Failed to forward the CSA frame");
 	}
 }
