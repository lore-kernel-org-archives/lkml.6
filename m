Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165164AbeE1NFJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:05:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:41960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164014AbeE1Kwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:52:42 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Beni Lev <beni.lev@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 255/496] iwlwifi: mvm: Correctly set IGTK for AP
Date: Mon, 28 May 2018 12:00:40 +0200
Message-Id: <20180528100330.628939274@linuxfoundation.org>
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

From: Beni Lev <beni.lev@intel.com>

[ Upstream commit e829b17caf96c2da34620e335fb777592990906c ]

Currently when an IGTK is set for an AP, it is set as a regular key.
Since the cipher is set to CMAC, the STA_KEY_FLG_EXT flag is added to
the host command, which causes assert 0x253D on NICs that do not support
this.

Fixes: 85aeb58cec1a ("iwlwifi: mvm: Enable security on new TX API")
Signed-off-by: Beni Lev <beni.lev@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c |   21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -3182,17 +3182,9 @@ int iwl_mvm_set_sta_key(struct iwl_mvm *
 		}
 		sta_id = mvm_sta->sta_id;
 
-		if (keyconf->cipher == WLAN_CIPHER_SUITE_AES_CMAC ||
-		    keyconf->cipher == WLAN_CIPHER_SUITE_BIP_GMAC_128 ||
-		    keyconf->cipher == WLAN_CIPHER_SUITE_BIP_GMAC_256) {
-			ret = iwl_mvm_send_sta_igtk(mvm, keyconf, sta_id,
-						    false);
-			goto end;
-		}
-
 		/*
 		 * It is possible that the 'sta' parameter is NULL, and thus
-		 * there is a need to retrieve  the sta from the local station
+		 * there is a need to retrieve the sta from the local station
 		 * table.
 		 */
 		if (!sta) {
@@ -3207,6 +3199,17 @@ int iwl_mvm_set_sta_key(struct iwl_mvm *
 
 		if (WARN_ON_ONCE(iwl_mvm_sta_from_mac80211(sta)->vif != vif))
 			return -EINVAL;
+	} else {
+		struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+
+		sta_id = mvmvif->mcast_sta.sta_id;
+	}
+
+	if (keyconf->cipher == WLAN_CIPHER_SUITE_AES_CMAC ||
+	    keyconf->cipher == WLAN_CIPHER_SUITE_BIP_GMAC_128 ||
+	    keyconf->cipher == WLAN_CIPHER_SUITE_BIP_GMAC_256) {
+		ret = iwl_mvm_send_sta_igtk(mvm, keyconf, sta_id, false);
+		goto end;
 	}
 
 	/* If the key_offset is not pre-assigned, we need to find a
