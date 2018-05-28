Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164156AbeE1Kxd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:53:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:42580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164144AbeE1Kx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:53:26 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Avraham Stern <avraham.stern@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 270/496] iwlwifi: mvm: fix array out of bounds reference
Date: Mon, 28 May 2018 12:00:55 +0200
Message-Id: <20180528100331.236720365@linuxfoundation.org>
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

From: Avraham Stern <avraham.stern@intel.com>

[ Upstream commit 4a6d2e525b43eba5870ea7e360f59aa65de00705 ]

When starting aggregation, the code checks the status of the queue
allocated to the aggregation tid, which might not yet be allocated
and thus the queue index may be invalid.
Fix this by reserving a new queue in case the queue id is invalid.

While at it, clean up some unreachable code (a condition that is
already handled earlier) and remove all the non-DQA comments since
non-DQA mode is no longer supported.

Fixes: cf961e16620f ("iwlwifi: mvm: support dqa-mode agg on non-shared queue")
Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c |   38 +++++++--------------------
 1 file changed, 11 insertions(+), 27 deletions(-)

--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -2436,28 +2436,12 @@ int iwl_mvm_sta_tx_agg_start(struct iwl_
 
 	/*
 	 * Note the possible cases:
-	 *  1. In DQA mode with an enabled TXQ - TXQ needs to become agg'ed
-	 *  2. Non-DQA mode: the TXQ hasn't yet been enabled, so find a free
-	 *	one and mark it as reserved
-	 *  3. In DQA mode, but no traffic yet on this TID: same treatment as in
-	 *	non-DQA mode, since the TXQ hasn't yet been allocated
-	 * Don't support case 3 for new TX path as it is not expected to happen
-	 * and aggregation will be offloaded soon anyway
+	 *  1. An enabled TXQ - TXQ needs to become agg'ed
+	 *  2. The TXQ hasn't yet been enabled, so find a free one and mark
+	 *	it as reserved
 	 */
 	txq_id = mvmsta->tid_data[tid].txq_id;
-	if (iwl_mvm_has_new_tx_api(mvm)) {
-		if (txq_id == IWL_MVM_INVALID_QUEUE) {
-			ret = -ENXIO;
-			goto release_locks;
-		}
-	} else if (unlikely(mvm->queue_info[txq_id].status ==
-			    IWL_MVM_QUEUE_SHARED)) {
-		ret = -ENXIO;
-		IWL_DEBUG_TX_QUEUES(mvm,
-				    "Can't start tid %d agg on shared queue!\n",
-				    tid);
-		goto release_locks;
-	} else if (mvm->queue_info[txq_id].status != IWL_MVM_QUEUE_READY) {
+	if (txq_id == IWL_MVM_INVALID_QUEUE) {
 		txq_id = iwl_mvm_find_free_queue(mvm, mvmsta->sta_id,
 						 IWL_MVM_DQA_MIN_DATA_QUEUE,
 						 IWL_MVM_DQA_MAX_DATA_QUEUE);
@@ -2466,16 +2450,16 @@ int iwl_mvm_sta_tx_agg_start(struct iwl_
 			IWL_ERR(mvm, "Failed to allocate agg queue\n");
 			goto release_locks;
 		}
-		/*
-		 * TXQ shouldn't be in inactive mode for non-DQA, so getting
-		 * an inactive queue from iwl_mvm_find_free_queue() is
-		 * certainly a bug
-		 */
-		WARN_ON(mvm->queue_info[txq_id].status ==
-			IWL_MVM_QUEUE_INACTIVE);
 
 		/* TXQ hasn't yet been enabled, so mark it only as reserved */
 		mvm->queue_info[txq_id].status = IWL_MVM_QUEUE_RESERVED;
+	} else if (unlikely(mvm->queue_info[txq_id].status ==
+			    IWL_MVM_QUEUE_SHARED)) {
+		ret = -ENXIO;
+		IWL_DEBUG_TX_QUEUES(mvm,
+				    "Can't start tid %d agg on shared queue!\n",
+				    tid);
+		goto release_locks;
 	}
 
 	spin_unlock(&mvm->queue_info_lock);
