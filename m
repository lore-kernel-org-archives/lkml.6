Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162988AbeE1Nj5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:39:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:35466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937693AbeE1Koq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:44:46 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sara Sharon <sara.sharon@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 083/496] iwlwifi: mvm: fix IBSS for devices that support station type API
Date: Mon, 28 May 2018 11:57:48 +0200
Message-Id: <20180528100323.289146303@linuxfoundation.org>
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

From: Sara Sharon <sara.sharon@intel.com>

[ Upstream commit fc07bd8ce19bff9e7479c04077ddb5957d1a27be ]

In IBSS, the mac80211 sets the cab_queue to be invalid.

However, the multicast station uses it, so we need to override it.

A previous patch did it, but it was nested inside the if's and was
applied only for legacy FWs that don't support the new station type
API, instead of being applied for all paths.

In addition, add a missing NL80211_IFTYPE_ADHOC to the initialization
of the queues in iwl_mvm_mac_ctxt_init()

Fixes: ee48b72211f8 ("iwlwifi: mvm: support ibss in dqa mode")
Signed-off-by: Sara Sharon <sara.sharon@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |    3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c      |   24 +++++++++++-----------
 2 files changed, 14 insertions(+), 13 deletions(-)

--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -438,7 +438,8 @@ int iwl_mvm_mac_ctxt_init(struct iwl_mvm
 	}
 
 	/* Allocate the CAB queue for softAP and GO interfaces */
-	if (vif->type == NL80211_IFTYPE_AP) {
+	if (vif->type == NL80211_IFTYPE_AP ||
+	    vif->type == NL80211_IFTYPE_ADHOC) {
 		/*
 		 * For TVQM this will be overwritten later with the FW assigned
 		 * queue value (when queue is enabled).
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -2037,6 +2037,17 @@ int iwl_mvm_add_mcast_sta(struct iwl_mvm
 		return -ENOTSUPP;
 
 	/*
+	 * In IBSS, ieee80211_check_queues() sets the cab_queue to be
+	 * invalid, so make sure we use the queue we want.
+	 * Note that this is done here as we want to avoid making DQA
+	 * changes in mac80211 layer.
+	 */
+	if (vif->type == NL80211_IFTYPE_ADHOC) {
+		vif->cab_queue = IWL_MVM_DQA_GCAST_QUEUE;
+		mvmvif->cab_queue = vif->cab_queue;
+	}
+
+	/*
 	 * While in previous FWs we had to exclude cab queue from TFD queue
 	 * mask, now it is needed as any other queue.
 	 */
@@ -2067,20 +2078,9 @@ int iwl_mvm_add_mcast_sta(struct iwl_mvm
 						    timeout);
 		mvmvif->cab_queue = queue;
 	} else if (!fw_has_api(&mvm->fw->ucode_capa,
-			       IWL_UCODE_TLV_API_STA_TYPE)) {
-		/*
-		 * In IBSS, ieee80211_check_queues() sets the cab_queue to be
-		 * invalid, so make sure we use the queue we want.
-		 * Note that this is done here as we want to avoid making DQA
-		 * changes in mac80211 layer.
-		 */
-		if (vif->type == NL80211_IFTYPE_ADHOC) {
-			vif->cab_queue = IWL_MVM_DQA_GCAST_QUEUE;
-			mvmvif->cab_queue = vif->cab_queue;
-		}
+			       IWL_UCODE_TLV_API_STA_TYPE))
 		iwl_mvm_enable_txq(mvm, vif->cab_queue, vif->cab_queue, 0,
 				   &cfg, timeout);
-	}
 
 	return 0;
 }
