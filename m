Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163702AbeE1Kuj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:50:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:40020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163689AbeE1Kub (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:50:31 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 207/496] iwlwifi: mvm: Correctly set the tid for mcast queue
Date: Mon, 28 May 2018 11:59:52 +0200
Message-Id: <20180528100328.662223226@linuxfoundation.org>
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

[ Upstream commit 6508de0305d560235b366cc2cc98f7bcfb029e92 ]

In the scheduler config command, the meaning of tid == 0xf was intended
to indicate the configuration is for management frames. However,
tid == 0xf was also used for the multicast queue that was meant only
for multicast data frames, which resulted with the FW not encrypting
multicast data frames.

As multicast frames do not have a QoS header, fix this by setting
tid == 0, to indicate that this is a data queue and not management
one.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -2023,7 +2023,7 @@ int iwl_mvm_add_mcast_sta(struct iwl_mvm
 	struct iwl_trans_txq_scd_cfg cfg = {
 		.fifo = IWL_MVM_TX_FIFO_MCAST,
 		.sta_id = msta->sta_id,
-		.tid = IWL_MAX_TID_COUNT,
+		.tid = 0,
 		.aggregate = false,
 		.frame_limit = IWL_FRAME_LIMIT,
 	};
@@ -2074,7 +2074,7 @@ int iwl_mvm_add_mcast_sta(struct iwl_mvm
 	if (iwl_mvm_has_new_tx_api(mvm)) {
 		int queue = iwl_mvm_tvqm_enable_txq(mvm, vif->cab_queue,
 						    msta->sta_id,
-						    IWL_MAX_TID_COUNT,
+						    0,
 						    timeout);
 		mvmvif->cab_queue = queue;
 	} else if (!fw_has_api(&mvm->fw->ucode_capa,
@@ -2099,7 +2099,7 @@ int iwl_mvm_rm_mcast_sta(struct iwl_mvm
 	iwl_mvm_flush_sta(mvm, &mvmvif->mcast_sta, true, 0);
 
 	iwl_mvm_disable_txq(mvm, mvmvif->cab_queue, vif->cab_queue,
-			    IWL_MAX_TID_COUNT, 0);
+			    0, 0);
 
 	ret = iwl_mvm_rm_sta_common(mvm, mvmvif->mcast_sta.sta_id);
 	if (ret)
