Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F114C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9C1421726
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548359558;
	bh=Hwsqr6xwgajuC0KrIpqZ0MvqVLDJ8D9bueNwv5Vrk1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eGiLSRAQr3DOLsnGc0fzEsz0mvHlYmBhYeKA8ocNclqvkDrxf9wIE7IEFJrq1Y3GG
	 kTiI85CoYuqOLE2qkUuS01unzUgNHhUD0KsBY7tUYdVKeT/VllvQex6n693X0FmR+V
	 zyXIPB7vcxxEBCrJgIcevEpKJ9sYLhw4FJV/yTPg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732633AbfAXTwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:52:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:39092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732927AbfAXTi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:38:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C131320663;
        Thu, 24 Jan 2019 19:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358735;
        bh=Hwsqr6xwgajuC0KrIpqZ0MvqVLDJ8D9bueNwv5Vrk1o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uvg51BaT12zcolYYHYjEW+bZ9i08PBQtTOhqTHyGUL5d+QoUjiVyw3T3uoDRrgewM
         TQZPKQ0qtejxXN/8eI3duotFlXGbl4g6SXyQqJP+stetSlRGUUUfGNwlcCO6FXR40k
         d2AmN5+MUb0rz1D74hhAxAF28EMLUhFrR4SWoEjA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Avraham Stern <avraham.stern@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 4.19 100/106] iwlwifi: mvm: Send LQ command as async when necessary
Date:   Thu, 24 Jan 2019 20:20:57 +0100
Message-Id: <20190124190212.285898996@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190206.342411005@linuxfoundation.org>
References: <20190124190206.342411005@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Avraham Stern <avraham.stern@intel.com>

commit 3baf7528d6f832b28622d1ddadd2e47f6c2b5e08 upstream.

The parameter that indicated whether the LQ command should be sent
as sync or async was removed, causing the LQ command to be sent as
sync from interrupt context (e.g. from the RX path). This resulted
in a kernel warning: "scheduling while atomic" and failing to send
the LQ command, which ultimately leads to a queue hang.

Fix it by adding back the required parameter to send the command as
sync only when it is allowed.

Fixes: d94c5a820d10 ("iwlwifi: mvm: open BA session only when sta is authorized")
Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c |    6 ++++--
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h      |    2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c       |   18 ++++++++----------
 drivers/net/wireless/intel/iwlwifi/mvm/rs.h       |    2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c    |    7 +++----
 5 files changed, 17 insertions(+), 18 deletions(-)

--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -2938,7 +2938,8 @@ static int iwl_mvm_mac_sta_state(struct
 			iwl_mvm_mac_ctxt_changed(mvm, vif, false, NULL);
 		}
 
-		iwl_mvm_rs_rate_init(mvm, sta, mvmvif->phy_ctxt->channel->band);
+		iwl_mvm_rs_rate_init(mvm, sta, mvmvif->phy_ctxt->channel->band,
+				     false);
 		ret = iwl_mvm_update_sta(mvm, vif, sta);
 	} else if (old_state == IEEE80211_STA_ASSOC &&
 		   new_state == IEEE80211_STA_AUTHORIZED) {
@@ -2954,7 +2955,8 @@ static int iwl_mvm_mac_sta_state(struct
 		/* enable beacon filtering */
 		WARN_ON(iwl_mvm_enable_beacon_filter(mvm, vif, 0));
 
-		iwl_mvm_rs_rate_init(mvm, sta, mvmvif->phy_ctxt->channel->band);
+		iwl_mvm_rs_rate_init(mvm, sta, mvmvif->phy_ctxt->channel->band,
+				     true);
 
 		ret = 0;
 	} else if (old_state == IEEE80211_STA_AUTHORIZED &&
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1685,7 +1685,7 @@ iwl_mvm_vif_dbgfs_clean(struct iwl_mvm *
 #endif /* CONFIG_IWLWIFI_DEBUGFS */
 
 /* rate scaling */
-int iwl_mvm_send_lq_cmd(struct iwl_mvm *mvm, struct iwl_lq_cmd *lq, bool init);
+int iwl_mvm_send_lq_cmd(struct iwl_mvm *mvm, struct iwl_lq_cmd *lq, bool sync);
 void iwl_mvm_update_frame_stats(struct iwl_mvm *mvm, u32 rate, bool agg);
 int rs_pretty_print_rate(char *buf, int bufsz, const u32 rate);
 void rs_update_last_rssi(struct iwl_mvm *mvm,
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
@@ -1280,7 +1280,7 @@ void iwl_mvm_rs_tx_status(struct iwl_mvm
 		       (unsigned long)(lq_sta->last_tx +
 				       (IWL_MVM_RS_IDLE_TIMEOUT * HZ)))) {
 		IWL_DEBUG_RATE(mvm, "Tx idle for too long. reinit rs\n");
-		iwl_mvm_rs_rate_init(mvm, sta, info->band);
+		iwl_mvm_rs_rate_init(mvm, sta, info->band, true);
 		return;
 	}
 	lq_sta->last_tx = jiffies;
@@ -2870,9 +2870,8 @@ void rs_update_last_rssi(struct iwl_mvm
 static void rs_initialize_lq(struct iwl_mvm *mvm,
 			     struct ieee80211_sta *sta,
 			     struct iwl_lq_sta *lq_sta,
-			     enum nl80211_band band)
+			     enum nl80211_band band, bool update)
 {
-	struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
 	struct iwl_scale_tbl_info *tbl;
 	struct rs_rate *rate;
 	u8 active_tbl = 0;
@@ -2901,8 +2900,7 @@ static void rs_initialize_lq(struct iwl_
 	rs_set_expected_tpt_table(lq_sta, tbl);
 	rs_fill_lq_cmd(mvm, sta, lq_sta, rate);
 	/* TODO restore station should remember the lq cmd */
-	iwl_mvm_send_lq_cmd(mvm, &lq_sta->lq,
-			    mvmsta->sta_state < IEEE80211_STA_AUTHORIZED);
+	iwl_mvm_send_lq_cmd(mvm, &lq_sta->lq, !update);
 }
 
 static void rs_drv_get_rate(void *mvm_r, struct ieee80211_sta *sta,
@@ -3155,7 +3153,7 @@ void iwl_mvm_update_frame_stats(struct i
  * Called after adding a new station to initialize rate scaling
  */
 static void rs_drv_rate_init(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
-			     enum nl80211_band band)
+			     enum nl80211_band band, bool update)
 {
 	int i, j;
 	struct ieee80211_hw *hw = mvm->hw;
@@ -3235,7 +3233,7 @@ static void rs_drv_rate_init(struct iwl_
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 	iwl_mvm_reset_frame_stats(mvm);
 #endif
-	rs_initialize_lq(mvm, sta, lq_sta, band);
+	rs_initialize_lq(mvm, sta, lq_sta, band, update);
 }
 
 static void rs_drv_rate_update(void *mvm_r,
@@ -3255,7 +3253,7 @@ static void rs_drv_rate_update(void *mvm
 	for (tid = 0; tid < IWL_MAX_TID_COUNT; tid++)
 		ieee80211_stop_tx_ba_session(sta, tid);
 
-	iwl_mvm_rs_rate_init(mvm, sta, sband->band);
+	iwl_mvm_rs_rate_init(mvm, sta, sband->band, true);
 }
 
 #ifdef CONFIG_MAC80211_DEBUGFS
@@ -4112,12 +4110,12 @@ static const struct rate_control_ops rs_
 };
 
 void iwl_mvm_rs_rate_init(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
-			  enum nl80211_band band)
+			  enum nl80211_band band, bool update)
 {
 	if (iwl_mvm_has_tlc_offload(mvm))
 		rs_fw_rate_init(mvm, sta, band);
 	else
-		rs_drv_rate_init(mvm, sta, band);
+		rs_drv_rate_init(mvm, sta, band, update);
 }
 
 int iwl_mvm_rate_control_register(void)
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.h
@@ -420,7 +420,7 @@ struct iwl_lq_sta {
 
 /* Initialize station's rate scaling information after adding station */
 void iwl_mvm_rs_rate_init(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
-			  enum nl80211_band band);
+			  enum nl80211_band band, bool init);
 
 /* Notify RS about Tx status */
 void iwl_mvm_rs_tx_status(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -900,20 +900,19 @@ int iwl_mvm_disable_txq(struct iwl_mvm *
 
 /**
  * iwl_mvm_send_lq_cmd() - Send link quality command
- * @init: This command is sent as part of station initialization right
- *        after station has been added.
+ * @sync: This command can be sent synchronously.
  *
  * The link quality command is sent as the last step of station creation.
  * This is the special case in which init is set and we call a callback in
  * this case to clear the state indicating that station creation is in
  * progress.
  */
-int iwl_mvm_send_lq_cmd(struct iwl_mvm *mvm, struct iwl_lq_cmd *lq, bool init)
+int iwl_mvm_send_lq_cmd(struct iwl_mvm *mvm, struct iwl_lq_cmd *lq, bool sync)
 {
 	struct iwl_host_cmd cmd = {
 		.id = LQ_CMD,
 		.len = { sizeof(struct iwl_lq_cmd), },
-		.flags = init ? 0 : CMD_ASYNC,
+		.flags = sync ? 0 : CMD_ASYNC,
 		.data = { lq, },
 	};
 


