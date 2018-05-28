Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164141AbeE1KxZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:53:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:42520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164107AbeE1KxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:53:18 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andrei Otcheretianski <andrei.otcheretianski@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 267/496] iwlwifi: mvm: Increase session protection time after CS
Date: Mon, 28 May 2018 12:00:52 +0200
Message-Id: <20180528100331.110790110@linuxfoundation.org>
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

From: Andrei Otcheretianski <andrei.otcheretianski@intel.com>

[ Upstream commit 19125cb0591ae63cd4591e3dfe4c22058e748518 ]

After switching to a new channel, driver schedules session protection
time event in order to hear the beacon on the new channel.
The duration of the protection is two beacon intervals.
However, since we start to switch slightly before beacon with count 1, in
case we don't hear (or AP doesn't transmit) the very first beacon on the
new channel the protection ends without hearing any beacon at all.
At this stage the switch is not complete, the queues are closed and the
interface doesn't have quota yet or TBTT events. As the result, we are
stuck forever waiting for iwl_mvm_post_channel_switch() to be called.

Fix this by increasing the protection time to be 3 beacon intervals and
in addition drop the connection if the time event ends before we got any
beacon.

Signed-off-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c   |    5 ++++-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h        |    3 +++
 drivers/net/wireless/intel/iwlwifi/mvm/time-event.c |   15 ++++++++-------
 3 files changed, 15 insertions(+), 8 deletions(-)

--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3497,6 +3497,7 @@ static int __iwl_mvm_assign_vif_chanctx(
 		ret = 0;
 		goto out;
 	case NL80211_IFTYPE_STATION:
+		mvmvif->csa_bcn_pending = false;
 		break;
 	case NL80211_IFTYPE_MONITOR:
 		/* always disable PS when a monitor interface is active */
@@ -3540,7 +3541,7 @@ static int __iwl_mvm_assign_vif_chanctx(
 	}
 
 	if (switching_chanctx && vif->type == NL80211_IFTYPE_STATION) {
-		u32 duration = 2 * vif->bss_conf.beacon_int;
+		u32 duration = 3 * vif->bss_conf.beacon_int;
 
 		/* iwl_mvm_protect_session() reads directly from the
 		 * device (the system time), so make sure it is
@@ -3553,6 +3554,7 @@ static int __iwl_mvm_assign_vif_chanctx(
 		/* Protect the session to make sure we hear the first
 		 * beacon on the new channel.
 		 */
+		mvmvif->csa_bcn_pending = true;
 		iwl_mvm_protect_session(mvm, vif, duration, duration,
 					vif->bss_conf.beacon_int / 2,
 					true);
@@ -3996,6 +3998,7 @@ static int iwl_mvm_post_channel_switch(s
 	if (vif->type == NL80211_IFTYPE_STATION) {
 		struct iwl_mvm_sta *mvmsta;
 
+		mvmvif->csa_bcn_pending = false;
 		mvmsta = iwl_mvm_sta_from_staid_protected(mvm,
 							  mvmvif->ap_sta_id);
 
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -434,6 +434,9 @@ struct iwl_mvm_vif {
 	bool csa_failed;
 	u16 csa_target_freq;
 
+	/* Indicates that we are waiting for a beacon on a new channel */
+	bool csa_bcn_pending;
+
 	/* TCP Checksum Offload */
 	netdev_features_t features;
 
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -8,6 +8,7 @@
  * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2017 Intel Deutschland GmbH
+ * Copyright(c) 2018 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -18,11 +19,6 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110,
- * USA
- *
  * The full GNU General Public License is included in this distribution
  * in the file called COPYING.
  *
@@ -35,6 +31,7 @@
  * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2017 Intel Deutschland GmbH
+ * Copyright(c) 2018 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -203,9 +200,13 @@ static bool iwl_mvm_te_check_disconnect(
 					struct ieee80211_vif *vif,
 					const char *errmsg)
 {
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+
 	if (vif->type != NL80211_IFTYPE_STATION)
 		return false;
-	if (vif->bss_conf.assoc && vif->bss_conf.dtim_period)
+
+	if (!mvmvif->csa_bcn_pending && vif->bss_conf.assoc &&
+	    vif->bss_conf.dtim_period)
 		return false;
 	if (errmsg)
 		IWL_ERR(mvm, "%s\n", errmsg);
@@ -349,7 +350,7 @@ static void iwl_mvm_te_handle_notif(stru
 			 * and know the dtim period.
 			 */
 			iwl_mvm_te_check_disconnect(mvm, te_data->vif,
-				"No association and the time event is over already...");
+				"No beacon heard and the time event is over already...");
 			break;
 		default:
 			break;
