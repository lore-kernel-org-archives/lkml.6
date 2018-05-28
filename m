Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424942AbeE1Lya (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:54:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:56346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423309AbeE1LIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:08:47 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Paul Menzel <pmenzel+linux-wireless@molgen.mpg.de>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 106/272] iwlwifi: mvm: check if mac80211_queue is valid in iwl_mvm_disable_txq
Date: Mon, 28 May 2018 12:02:19 +0200
Message-Id: <20180528100250.008518285@linuxfoundation.org>
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

From: Luca Coelho <luciano.coelho@intel.com>

[ Upstream commit 9a233bb8025105db9a60b5d761005cc5a6c77f3d ]

Sometimes iwl_mvm_disable_txq() may be called with mac80211_queue ==
IEEE80211_INVAL_HW_QUEUE, and this would cause us to use BIT(0xFF)
which is way too large for the u16 we used to store it in
hw_queue_to_mac820211.  If this happens the following UBSAN warning
will be generated:

[  167.185167] UBSAN: Undefined behaviour in drivers/net/wireless/intel/iwlwifi/mvm/utils.c:838:5
[  167.185171] shift exponent 255 is too large for 64-bit type 'long unsigned int'

Fix that by checking that it is not IEEE80211_INVAL_HW_QUEUE and,
while at it, add a warning if the queue number is larger than
IEEE80211_MAX_QUEUES.

Fixes: 34e10860ae8d ("iwlwifi: mvm: remove references to queue_info in new TX path")
Reported-by: Paul Menzel <pmenzel+linux-wireless@molgen.mpg.de>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -800,12 +800,19 @@ int iwl_mvm_disable_txq(struct iwl_mvm *
 		.scd_queue = queue,
 		.action = SCD_CFG_DISABLE_QUEUE,
 	};
-	bool remove_mac_queue = true;
+	bool remove_mac_queue = mac80211_queue != IEEE80211_INVAL_HW_QUEUE;
 	int ret;
 
+	if (WARN_ON(remove_mac_queue && mac80211_queue >= IEEE80211_MAX_QUEUES))
+		return -EINVAL;
+
 	if (iwl_mvm_has_new_tx_api(mvm)) {
 		spin_lock_bh(&mvm->queue_info_lock);
-		mvm->hw_queue_to_mac80211[queue] &= ~BIT(mac80211_queue);
+
+		if (remove_mac_queue)
+			mvm->hw_queue_to_mac80211[queue] &=
+				~BIT(mac80211_queue);
+
 		spin_unlock_bh(&mvm->queue_info_lock);
 
 		iwl_trans_txq_free(mvm->trans, queue);
