Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164040AbeE1Kwt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:52:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:41994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164027AbeE1Kwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:52:44 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 256/496] iwlwifi: mvm: fix error checking for multi/broadcast sta
Date: Mon, 28 May 2018 12:00:41 +0200
Message-Id: <20180528100330.667440237@linuxfoundation.org>
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

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 75fd4fec3e4c43b131c7c4958adb3ab9f1665513 ]

The earlier patch called the station add functions but didn't
assign their return value to the ret variable, so that the
checks for it were meaningless. Fix that.

Found by smatch:

.../mac80211.c:2560 iwl_mvm_start_ap_ibss() warn: we tested 'ret' before and it was 'false'
.../mac80211.c:2563 iwl_mvm_start_ap_ibss() warn: we tested 'ret' before and it was 'false'

Fixes: 3a89411cd31c ("iwlwifi: mvm: fix assert 0x2B00 on older FWs")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -2153,10 +2153,10 @@ static int iwl_mvm_start_ap_ibss(struct
 		 * Send the bcast station. At this stage the TBTT and DTIM time
 		 * events are added and applied to the scheduler
 		 */
-		iwl_mvm_send_add_bcast_sta(mvm, vif);
+		ret = iwl_mvm_send_add_bcast_sta(mvm, vif);
 		if (ret)
 			goto out_unbind;
-		iwl_mvm_add_mcast_sta(mvm, vif);
+		ret = iwl_mvm_add_mcast_sta(mvm, vif);
 		if (ret) {
 			iwl_mvm_send_rm_bcast_sta(mvm, vif);
 			goto out_unbind;
