Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164206AbeE1NCW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:02:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:42542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164117AbeE1KxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:53:20 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Avraham Stern <avraham.stern@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 268/496] iwlwifi: mvm: clear tx queue id when unreserving aggregation queue
Date: Mon, 28 May 2018 12:00:53 +0200
Message-Id: <20180528100331.148530445@linuxfoundation.org>
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

[ Upstream commit 4b387906b1c3692bb790388c335515c0cf098a23 ]

When a queue is reserved for aggregation, the queue id is assigned
to the tid_data. This is fine since iwl_mvm_sta_tx_agg_oper()
takes care of allocating the queue before actual tx starts.
When the reservation is cancelled (e.g. when the AP declined the
aggregation request) the tid_data is not cleared. As a result,
following tx for this tid was trying to use an unallocated queue.

Fix this by setting the txq_id for the tid to invalid when unreserving
the queue.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -2645,8 +2645,10 @@ out:
 
 static void iwl_mvm_unreserve_agg_queue(struct iwl_mvm *mvm,
 					struct iwl_mvm_sta *mvmsta,
-					u16 txq_id)
+					struct iwl_mvm_tid_data *tid_data)
 {
+	u16 txq_id = tid_data->txq_id;
+
 	if (iwl_mvm_has_new_tx_api(mvm))
 		return;
 
@@ -2658,8 +2660,10 @@ static void iwl_mvm_unreserve_agg_queue(
 	 * allocated through iwl_mvm_enable_txq, so we can just mark it back as
 	 * free.
 	 */
-	if (mvm->queue_info[txq_id].status == IWL_MVM_QUEUE_RESERVED)
+	if (mvm->queue_info[txq_id].status == IWL_MVM_QUEUE_RESERVED) {
 		mvm->queue_info[txq_id].status = IWL_MVM_QUEUE_FREE;
+		tid_data->txq_id = IWL_MVM_INVALID_QUEUE;
+	}
 
 	spin_unlock_bh(&mvm->queue_info_lock);
 }
@@ -2690,7 +2694,7 @@ int iwl_mvm_sta_tx_agg_stop(struct iwl_m
 
 	mvmsta->agg_tids &= ~BIT(tid);
 
-	iwl_mvm_unreserve_agg_queue(mvm, mvmsta, txq_id);
+	iwl_mvm_unreserve_agg_queue(mvm, mvmsta, tid_data);
 
 	switch (tid_data->state) {
 	case IWL_AGG_ON:
@@ -2757,7 +2761,7 @@ int iwl_mvm_sta_tx_agg_flush(struct iwl_
 	mvmsta->agg_tids &= ~BIT(tid);
 	spin_unlock_bh(&mvmsta->lock);
 
-	iwl_mvm_unreserve_agg_queue(mvm, mvmsta, txq_id);
+	iwl_mvm_unreserve_agg_queue(mvm, mvmsta, tid_data);
 
 	if (old_state >= IWL_AGG_ON) {
 		iwl_mvm_drain_sta(mvm, mvmsta, true);
