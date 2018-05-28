Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165172AbeE1NFZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:05:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:41936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164005AbeE1Kwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:52:39 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 254/496] iwlwifi: mvm: set the correct tid when we flush the MCAST sta
Date: Mon, 28 May 2018 12:00:39 +0200
Message-Id: <20180528100330.590090443@linuxfoundation.org>
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

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

[ Upstream commit 334167decf98f01a66c91ea84180c278bc4ad290 ]

The tid being used for the queue (cab_queue) for the MCAST
station has been changed recently to be 0 (for BE).
The flush path still flushed only the special tid (15)
which means that the firmware wasn't flushing the right
queue and we could get a firmware crash upon remove
station if we had an MCAST packet on the ring.

The current code that flushes queues for a station only
differentiates between internal stations (stations that
aren't instantiated in mac80211, like the MCAST station)
and the non-internal ones.
Internal stations can be either: BCAST (beacons), MCAST
(for cab_queue), GENERAL_PURPOSE (p2p dev, and sniffer
injection). The internal stations can use different tids.

To make the code simpler, just flush all the tids always
and add the special internal tid (15) for internal
stations. The firmware will know how to handle this even
if we hadn't any queue mapped that that tid.

Fixes: e340c1a6ef4b ("iwlwifi: mvm: Correctly set the tid for mcast queue")
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -1879,14 +1879,12 @@ int iwl_mvm_flush_sta(struct iwl_mvm *mv
 	struct iwl_mvm_int_sta *int_sta = sta;
 	struct iwl_mvm_sta *mvm_sta = sta;
 
-	if (iwl_mvm_has_new_tx_api(mvm)) {
-		if (internal)
-			return iwl_mvm_flush_sta_tids(mvm, int_sta->sta_id,
-						      BIT(IWL_MGMT_TID), flags);
+	BUILD_BUG_ON(offsetof(struct iwl_mvm_int_sta, sta_id) !=
+		     offsetof(struct iwl_mvm_sta, sta_id));
 
+	if (iwl_mvm_has_new_tx_api(mvm))
 		return iwl_mvm_flush_sta_tids(mvm, mvm_sta->sta_id,
-					      0xFF, flags);
-	}
+					      0xff | BIT(IWL_MGMT_TID), flags);
 
 	if (internal)
 		return iwl_mvm_flush_tx_path(mvm, int_sta->tfd_queue_msk,
