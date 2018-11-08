Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787EFC43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15A3620857
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TqLbwAY5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15A3620857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731438AbeKIHmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:42:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:33970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727288AbeKIHmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:42:16 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EC722086C;
        Thu,  8 Nov 2018 22:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714685;
        bh=beK/tlhzC4MsaoUBbU6rXzKD/UpyEZvbHFNgv7k6Wu8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TqLbwAY5uM5AJcXJpdv3Z5iTIS1Tvg8Wt2l4uuFXNQQvfGP1nqIMVw7qVCKxudeGk
         qMjp1M5No18NusG4bT07mokWwdUYPS8ChXzeR+7E0Q+KGgRIPyyE9DmUi+x3M8V6tU
         AZw6AJBo8Kn6Y1OHwvdNZu6GmAG6mLRPCobQ6w/0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jouni Malinen <j@w1.fi>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 062/171] mac80211: fix TX aggregation start/stop callback race
Date:   Thu,  8 Nov 2018 13:50:32 -0800
Message-Id: <20181108215132.040901446@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 7a7c0a6438b8e7636d5a22e572892cc234f68297 ]

When starting or stopping an aggregation session, one of the steps
is that the driver calls back to mac80211 that the start/stop can
proceed. This is handled by queueing up a fake SKB and processing
it from the normal iface/sdata work. Since this isn't flushed when
disassociating, the following race is possible:

 * associate
 * start aggregation session
 * driver callback
 * disassociate
 * associate again to the same AP
 * callback processing runs, leading to a WARN_ON() that
   the TID hadn't requested aggregation

If the second association isn't to the same AP, there would only
be a message printed ("Could not find station: <addr>"), but the
same race could happen.

Fix this by not going the whole detour with a fake SKB etc. but
simply looking up the aggregation session in the driver callback,
marking it with a START_CB/STOP_CB bit and then scheduling the
regular aggregation work that will now process these bits as well.
This also simplifies the code and gets rid of the whole problem
with allocation failures of said skb, which could have left the
session in limbo.

Reported-by: Jouni Malinen <j@w1.fi>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/agg-tx.c      | 128 +++++++++++++++----------------------
 net/mac80211/ht.c          |  16 +++--
 net/mac80211/ieee80211_i.h |  14 ++--
 net/mac80211/iface.c       |  11 +---
 net/mac80211/sta_info.h    |   2 +
 5 files changed, 71 insertions(+), 100 deletions(-)

diff --git a/net/mac80211/agg-tx.c b/net/mac80211/agg-tx.c
index 45319cc01121..80c45567ee3a 100644
--- a/net/mac80211/agg-tx.c
+++ b/net/mac80211/agg-tx.c
@@ -7,7 +7,7 @@
  * Copyright 2006-2007	Jiri Benc <jbenc@suse.cz>
  * Copyright 2007, Michael Wu <flamingice@sourmilk.net>
  * Copyright 2007-2010, Intel Corporation
- * Copyright(c) 2015 Intel Deutschland GmbH
+ * Copyright(c) 2015-2017 Intel Deutschland GmbH
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -741,46 +741,43 @@ static void ieee80211_agg_tx_operational(struct ieee80211_local *local,
 	ieee80211_agg_start_txq(sta, tid, true);
 }
 
-void ieee80211_start_tx_ba_cb(struct ieee80211_vif *vif, u8 *ra, u16 tid)
+void ieee80211_start_tx_ba_cb(struct sta_info *sta, int tid,
+			      struct tid_ampdu_tx *tid_tx)
 {
-	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
+	struct ieee80211_sub_if_data *sdata = sta->sdata;
 	struct ieee80211_local *local = sdata->local;
-	struct sta_info *sta;
-	struct tid_ampdu_tx *tid_tx;
 
-	trace_api_start_tx_ba_cb(sdata, ra, tid);
+	if (WARN_ON(test_and_set_bit(HT_AGG_STATE_DRV_READY, &tid_tx->state)))
+		return;
+
+	if (test_bit(HT_AGG_STATE_RESPONSE_RECEIVED, &tid_tx->state))
+		ieee80211_agg_tx_operational(local, sta, tid);
+}
+
+static struct tid_ampdu_tx *
+ieee80211_lookup_tid_tx(struct ieee80211_sub_if_data *sdata,
+			const u8 *ra, u16 tid, struct sta_info **sta)
+{
+	struct tid_ampdu_tx *tid_tx;
 
 	if (tid >= IEEE80211_NUM_TIDS) {
 		ht_dbg(sdata, "Bad TID value: tid = %d (>= %d)\n",
 		       tid, IEEE80211_NUM_TIDS);
-		return;
+		return NULL;
 	}
 
-	mutex_lock(&local->sta_mtx);
-	sta = sta_info_get_bss(sdata, ra);
-	if (!sta) {
-		mutex_unlock(&local->sta_mtx);
+	*sta = sta_info_get_bss(sdata, ra);
+	if (!*sta) {
 		ht_dbg(sdata, "Could not find station: %pM\n", ra);
-		return;
+		return NULL;
 	}
 
-	mutex_lock(&sta->ampdu_mlme.mtx);
-	tid_tx = rcu_dereference_protected_tid_tx(sta, tid);
+	tid_tx = rcu_dereference((*sta)->ampdu_mlme.tid_tx[tid]);
 
-	if (WARN_ON(!tid_tx)) {
+	if (WARN_ON(!tid_tx))
 		ht_dbg(sdata, "addBA was not requested!\n");
-		goto unlock;
-	}
 
-	if (WARN_ON(test_and_set_bit(HT_AGG_STATE_DRV_READY, &tid_tx->state)))
-		goto unlock;
-
-	if (test_bit(HT_AGG_STATE_RESPONSE_RECEIVED, &tid_tx->state))
-		ieee80211_agg_tx_operational(local, sta, tid);
-
- unlock:
-	mutex_unlock(&sta->ampdu_mlme.mtx);
-	mutex_unlock(&local->sta_mtx);
+	return tid_tx;
 }
 
 void ieee80211_start_tx_ba_cb_irqsafe(struct ieee80211_vif *vif,
@@ -788,19 +785,20 @@ void ieee80211_start_tx_ba_cb_irqsafe(struct ieee80211_vif *vif,
 {
 	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
 	struct ieee80211_local *local = sdata->local;
-	struct ieee80211_ra_tid *ra_tid;
-	struct sk_buff *skb = dev_alloc_skb(0);
+	struct sta_info *sta;
+	struct tid_ampdu_tx *tid_tx;
 
-	if (unlikely(!skb))
-		return;
+	trace_api_start_tx_ba_cb(sdata, ra, tid);
 
-	ra_tid = (struct ieee80211_ra_tid *) &skb->cb;
-	memcpy(&ra_tid->ra, ra, ETH_ALEN);
-	ra_tid->tid = tid;
+	rcu_read_lock();
+	tid_tx = ieee80211_lookup_tid_tx(sdata, ra, tid, &sta);
+	if (!tid_tx)
+		goto out;
 
-	skb->pkt_type = IEEE80211_SDATA_QUEUE_AGG_START;
-	skb_queue_tail(&sdata->skb_queue, skb);
-	ieee80211_queue_work(&local->hw, &sdata->work);
+	set_bit(HT_AGG_STATE_START_CB, &tid_tx->state);
+	ieee80211_queue_work(&local->hw, &sta->ampdu_mlme.work);
+ out:
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL(ieee80211_start_tx_ba_cb_irqsafe);
 
@@ -860,37 +858,18 @@ int ieee80211_stop_tx_ba_session(struct ieee80211_sta *pubsta, u16 tid)
 }
 EXPORT_SYMBOL(ieee80211_stop_tx_ba_session);
 
-void ieee80211_stop_tx_ba_cb(struct ieee80211_vif *vif, u8 *ra, u8 tid)
+void ieee80211_stop_tx_ba_cb(struct sta_info *sta, int tid,
+			     struct tid_ampdu_tx *tid_tx)
 {
-	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
-	struct ieee80211_local *local = sdata->local;
-	struct sta_info *sta;
-	struct tid_ampdu_tx *tid_tx;
+	struct ieee80211_sub_if_data *sdata = sta->sdata;
 	bool send_delba = false;
 
-	trace_api_stop_tx_ba_cb(sdata, ra, tid);
-
-	if (tid >= IEEE80211_NUM_TIDS) {
-		ht_dbg(sdata, "Bad TID value: tid = %d (>= %d)\n",
-		       tid, IEEE80211_NUM_TIDS);
-		return;
-	}
-
-	ht_dbg(sdata, "Stopping Tx BA session for %pM tid %d\n", ra, tid);
-
-	mutex_lock(&local->sta_mtx);
-
-	sta = sta_info_get_bss(sdata, ra);
-	if (!sta) {
-		ht_dbg(sdata, "Could not find station: %pM\n", ra);
-		goto unlock;
-	}
+	ht_dbg(sdata, "Stopping Tx BA session for %pM tid %d\n",
+	       sta->sta.addr, tid);
 
-	mutex_lock(&sta->ampdu_mlme.mtx);
 	spin_lock_bh(&sta->lock);
-	tid_tx = rcu_dereference_protected_tid_tx(sta, tid);
 
-	if (!tid_tx || !test_bit(HT_AGG_STATE_STOPPING, &tid_tx->state)) {
+	if (!test_bit(HT_AGG_STATE_STOPPING, &tid_tx->state)) {
 		ht_dbg(sdata,
 		       "unexpected callback to A-MPDU stop for %pM tid %d\n",
 		       sta->sta.addr, tid);
@@ -906,12 +885,8 @@ void ieee80211_stop_tx_ba_cb(struct ieee80211_vif *vif, u8 *ra, u8 tid)
 	spin_unlock_bh(&sta->lock);
 
 	if (send_delba)
-		ieee80211_send_delba(sdata, ra, tid,
+		ieee80211_send_delba(sdata, sta->sta.addr, tid,
 			WLAN_BACK_INITIATOR, WLAN_REASON_QSTA_NOT_USE);
-
-	mutex_unlock(&sta->ampdu_mlme.mtx);
- unlock:
-	mutex_unlock(&local->sta_mtx);
 }
 
 void ieee80211_stop_tx_ba_cb_irqsafe(struct ieee80211_vif *vif,
@@ -919,19 +894,20 @@ void ieee80211_stop_tx_ba_cb_irqsafe(struct ieee80211_vif *vif,
 {
 	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
 	struct ieee80211_local *local = sdata->local;
-	struct ieee80211_ra_tid *ra_tid;
-	struct sk_buff *skb = dev_alloc_skb(0);
+	struct sta_info *sta;
+	struct tid_ampdu_tx *tid_tx;
 
-	if (unlikely(!skb))
-		return;
+	trace_api_stop_tx_ba_cb(sdata, ra, tid);
 
-	ra_tid = (struct ieee80211_ra_tid *) &skb->cb;
-	memcpy(&ra_tid->ra, ra, ETH_ALEN);
-	ra_tid->tid = tid;
+	rcu_read_lock();
+	tid_tx = ieee80211_lookup_tid_tx(sdata, ra, tid, &sta);
+	if (!tid_tx)
+		goto out;
 
-	skb->pkt_type = IEEE80211_SDATA_QUEUE_AGG_STOP;
-	skb_queue_tail(&sdata->skb_queue, skb);
-	ieee80211_queue_work(&local->hw, &sdata->work);
+	set_bit(HT_AGG_STATE_STOP_CB, &tid_tx->state);
+	ieee80211_queue_work(&local->hw, &sta->ampdu_mlme.work);
+ out:
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL(ieee80211_stop_tx_ba_cb_irqsafe);
 
diff --git a/net/mac80211/ht.c b/net/mac80211/ht.c
index f4a528773563..6ca5442b1e03 100644
--- a/net/mac80211/ht.c
+++ b/net/mac80211/ht.c
@@ -7,6 +7,7 @@
  * Copyright 2006-2007	Jiri Benc <jbenc@suse.cz>
  * Copyright 2007, Michael Wu <flamingice@sourmilk.net>
  * Copyright 2007-2010, Intel Corporation
+ * Copyright 2017	Intel Deutschland GmbH
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -289,8 +290,6 @@ void ieee80211_sta_tear_down_BA_sessions(struct sta_info *sta,
 {
 	int i;
 
-	cancel_work_sync(&sta->ampdu_mlme.work);
-
 	for (i = 0; i <  IEEE80211_NUM_TIDS; i++) {
 		__ieee80211_stop_tx_ba_session(sta, i, reason);
 		__ieee80211_stop_rx_ba_session(sta, i, WLAN_BACK_RECIPIENT,
@@ -298,6 +297,9 @@ void ieee80211_sta_tear_down_BA_sessions(struct sta_info *sta,
 					       reason != AGG_STOP_DESTROY_STA &&
 					       reason != AGG_STOP_PEER_REQUEST);
 	}
+
+	/* stopping might queue the work again - so cancel only afterwards */
+	cancel_work_sync(&sta->ampdu_mlme.work);
 }
 
 void ieee80211_ba_session_work(struct work_struct *work)
@@ -352,10 +354,16 @@ void ieee80211_ba_session_work(struct work_struct *work)
 		spin_unlock_bh(&sta->lock);
 
 		tid_tx = rcu_dereference_protected_tid_tx(sta, tid);
-		if (tid_tx && test_and_clear_bit(HT_AGG_STATE_WANT_STOP,
-						 &tid_tx->state))
+		if (!tid_tx)
+			continue;
+
+		if (test_and_clear_bit(HT_AGG_STATE_START_CB, &tid_tx->state))
+			ieee80211_start_tx_ba_cb(sta, tid, tid_tx);
+		if (test_and_clear_bit(HT_AGG_STATE_WANT_STOP, &tid_tx->state))
 			___ieee80211_stop_tx_ba_session(sta, tid,
 							AGG_STOP_LOCAL_REQUEST);
+		if (test_and_clear_bit(HT_AGG_STATE_STOP_CB, &tid_tx->state))
+			ieee80211_stop_tx_ba_cb(sta, tid, tid_tx);
 	}
 	mutex_unlock(&sta->ampdu_mlme.mtx);
 }
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 7fd544d970d9..8a690ebd7374 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1026,8 +1026,6 @@ struct ieee80211_rx_agg {
 
 enum sdata_queue_type {
 	IEEE80211_SDATA_QUEUE_TYPE_FRAME	= 0,
-	IEEE80211_SDATA_QUEUE_AGG_START		= 1,
-	IEEE80211_SDATA_QUEUE_AGG_STOP		= 2,
 	IEEE80211_SDATA_QUEUE_RX_AGG_START	= 3,
 	IEEE80211_SDATA_QUEUE_RX_AGG_STOP	= 4,
 };
@@ -1416,12 +1414,6 @@ ieee80211_get_sband(struct ieee80211_sub_if_data *sdata)
 	return local->hw.wiphy->bands[band];
 }
 
-/* this struct represents 802.11n's RA/TID combination */
-struct ieee80211_ra_tid {
-	u8 ra[ETH_ALEN];
-	u16 tid;
-};
-
 /* this struct holds the value parsing from channel switch IE  */
 struct ieee80211_csa_ie {
 	struct cfg80211_chan_def chandef;
@@ -1765,8 +1757,10 @@ int __ieee80211_stop_tx_ba_session(struct sta_info *sta, u16 tid,
 				   enum ieee80211_agg_stop_reason reason);
 int ___ieee80211_stop_tx_ba_session(struct sta_info *sta, u16 tid,
 				    enum ieee80211_agg_stop_reason reason);
-void ieee80211_start_tx_ba_cb(struct ieee80211_vif *vif, u8 *ra, u16 tid);
-void ieee80211_stop_tx_ba_cb(struct ieee80211_vif *vif, u8 *ra, u8 tid);
+void ieee80211_start_tx_ba_cb(struct sta_info *sta, int tid,
+			      struct tid_ampdu_tx *tid_tx);
+void ieee80211_stop_tx_ba_cb(struct sta_info *sta, int tid,
+			     struct tid_ampdu_tx *tid_tx);
 void ieee80211_ba_session_work(struct work_struct *work);
 void ieee80211_tx_ba_session_handle_start(struct sta_info *sta, int tid);
 void ieee80211_release_reorder_timeout(struct sta_info *sta, int tid);
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index fa7d757fef95..760ba8ec2944 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1248,7 +1248,6 @@ static void ieee80211_iface_work(struct work_struct *work)
 	struct ieee80211_local *local = sdata->local;
 	struct sk_buff *skb;
 	struct sta_info *sta;
-	struct ieee80211_ra_tid *ra_tid;
 	struct ieee80211_rx_agg *rx_agg;
 
 	if (!ieee80211_sdata_running(sdata))
@@ -1264,15 +1263,7 @@ static void ieee80211_iface_work(struct work_struct *work)
 	while ((skb = skb_dequeue(&sdata->skb_queue))) {
 		struct ieee80211_mgmt *mgmt = (void *)skb->data;
 
-		if (skb->pkt_type == IEEE80211_SDATA_QUEUE_AGG_START) {
-			ra_tid = (void *)&skb->cb;
-			ieee80211_start_tx_ba_cb(&sdata->vif, ra_tid->ra,
-						 ra_tid->tid);
-		} else if (skb->pkt_type == IEEE80211_SDATA_QUEUE_AGG_STOP) {
-			ra_tid = (void *)&skb->cb;
-			ieee80211_stop_tx_ba_cb(&sdata->vif, ra_tid->ra,
-						ra_tid->tid);
-		} else if (skb->pkt_type == IEEE80211_SDATA_QUEUE_RX_AGG_START) {
+		if (skb->pkt_type == IEEE80211_SDATA_QUEUE_RX_AGG_START) {
 			rx_agg = (void *)&skb->cb;
 			mutex_lock(&local->sta_mtx);
 			sta = sta_info_get_bss(sdata, rx_agg->addr);
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 15599c70a38f..cc808ac783e5 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -115,6 +115,8 @@ enum ieee80211_sta_info_flags {
 #define HT_AGG_STATE_STOPPING		3
 #define HT_AGG_STATE_WANT_START		4
 #define HT_AGG_STATE_WANT_STOP		5
+#define HT_AGG_STATE_START_CB		6
+#define HT_AGG_STATE_STOP_CB		7
 
 enum ieee80211_agg_stop_reason {
 	AGG_STOP_DECLINED,
-- 
2.17.1



