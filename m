Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164146AbeE1NOc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:14:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:39990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163677AbeE1Ku3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:50:29 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 206/496] iwlwifi: mvm: Direct multicast frames to the correct station
Date: Mon, 28 May 2018 11:59:51 +0200
Message-Id: <20180528100328.628820278@linuxfoundation.org>
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

From: Ilan Peer <ilan.peer@intel.com>

[ Upstream commit 7c305de2b9548ab6b65fce342c78618bbed5db73 ]

Multicast frames for NL80211_IFTYPE_AP and NL80211_IFTYPE_ADHOC were
directed to the broadcast station, however, as the broadcast station
did not have keys configured, these frames were sent unencrypted.

Fix this by using the multicast station which is the station for which
encryption keys are configured.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -648,7 +648,11 @@ int iwl_mvm_tx_skb_non_sta(struct iwl_mv
 		if (info.control.vif->type == NL80211_IFTYPE_P2P_DEVICE ||
 		    info.control.vif->type == NL80211_IFTYPE_AP ||
 		    info.control.vif->type == NL80211_IFTYPE_ADHOC) {
-			sta_id = mvmvif->bcast_sta.sta_id;
+			if (info.control.vif->type == NL80211_IFTYPE_P2P_DEVICE)
+				sta_id = mvmvif->bcast_sta.sta_id;
+			else
+				sta_id = mvmvif->mcast_sta.sta_id;
+
 			queue = iwl_mvm_get_ctrl_vif_queue(mvm, &info,
 							   hdr->frame_control);
 			if (queue < 0)
