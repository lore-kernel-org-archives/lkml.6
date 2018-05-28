Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423687AbeE1LI6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:08:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:56428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423667AbeE1LIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:08:50 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sara Sharon <sara.sharon@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 107/272] iwlwifi: mvm: take RCU lock before dereferencing
Date: Mon, 28 May 2018 12:02:20 +0200
Message-Id: <20180528100250.083569842@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sara Sharon <sara.sharon@intel.com>

[ Upstream commit f4f155e5ec04d381b2f0870817d93dbdc259aa63 ]

RCU isn't properly locked.

Fixes: 46d372af9935 ("iwlwifi: mvm: rs: new rate scale API - add FW notifications")
Signed-off-by: Sara Sharon <sara.sharon@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
@@ -234,13 +234,15 @@ void iwl_mvm_tlc_update_notif(struct iwl
 	struct iwl_mvm_sta *mvmsta;
 	struct iwl_lq_sta_rs_fw *lq_sta;
 
+	rcu_read_lock();
+
 	notif = (void *)pkt->data;
 	mvmsta = iwl_mvm_sta_from_staid_rcu(mvm, notif->sta_id);
 
 	if (!mvmsta) {
 		IWL_ERR(mvm, "Invalid sta id (%d) in FW TLC notification\n",
 			notif->sta_id);
-		return;
+		goto out;
 	}
 
 	lq_sta = &mvmsta->lq_sta.rs_fw;
@@ -251,6 +253,8 @@ void iwl_mvm_tlc_update_notif(struct iwl
 		IWL_DEBUG_RATE(mvm, "new rate_n_flags: 0x%X\n",
 			       lq_sta->last_rate_n_flags);
 	}
+out:
+	rcu_read_unlock();
 }
 
 void rs_fw_rate_init(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
