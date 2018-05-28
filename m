Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163690AbeE1Kub (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:50:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:39680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163660AbeE1KuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:50:20 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sara Sharon <sara.sharon@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 203/496] iwlwifi: mvm: fix assert 0x2B00 on older FWs
Date: Mon, 28 May 2018 11:59:48 +0200
Message-Id: <20180528100328.490239029@linuxfoundation.org>
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

[ Upstream commit 63dd5d022f4766e6b05ee611124afcc7cbfbb953 ]

We should add the multicast station before adding the
broadcast station.

However, in older FW, the firmware will start beaconing
when we add the multicast station, and since the broadcast
station is not added at this point so the transmission
of the beacon will fail on assert 0x2b00.

This is fixed in later firmware, so make the order
of addition depend on the TLV.

Fixes: 26d6c16bed53 ("iwlwifi: mvm: add multicast station")
Signed-off-by: Sara Sharon <sara.sharon@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c |   45 +++++++++++++++++-----
 1 file changed, 35 insertions(+), 10 deletions(-)

--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -8,6 +8,7 @@
  * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
+ * Copyright(c) 2018        Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -2127,15 +2128,40 @@ static int iwl_mvm_start_ap_ibss(struct
 	if (ret)
 		goto out_remove;
 
-	ret = iwl_mvm_add_mcast_sta(mvm, vif);
-	if (ret)
-		goto out_unbind;
-
-	/* Send the bcast station. At this stage the TBTT and DTIM time events
-	 * are added and applied to the scheduler */
-	ret = iwl_mvm_send_add_bcast_sta(mvm, vif);
-	if (ret)
-		goto out_rm_mcast;
+	/*
+	 * This is not very nice, but the simplest:
+	 * For older FWs adding the mcast sta before the bcast station may
+	 * cause assert 0x2b00.
+	 * This is fixed in later FW so make the order of removal depend on
+	 * the TLV
+	 */
+	if (fw_has_api(&mvm->fw->ucode_capa, IWL_UCODE_TLV_API_STA_TYPE)) {
+		ret = iwl_mvm_add_mcast_sta(mvm, vif);
+		if (ret)
+			goto out_unbind;
+		/*
+		 * Send the bcast station. At this stage the TBTT and DTIM time
+		 * events are added and applied to the scheduler
+		 */
+		ret = iwl_mvm_send_add_bcast_sta(mvm, vif);
+		if (ret) {
+			iwl_mvm_rm_mcast_sta(mvm, vif);
+			goto out_unbind;
+		}
+	} else {
+		/*
+		 * Send the bcast station. At this stage the TBTT and DTIM time
+		 * events are added and applied to the scheduler
+		 */
+		iwl_mvm_send_add_bcast_sta(mvm, vif);
+		if (ret)
+			goto out_unbind;
+		iwl_mvm_add_mcast_sta(mvm, vif);
+		if (ret) {
+			iwl_mvm_send_rm_bcast_sta(mvm, vif);
+			goto out_unbind;
+		}
+	}
 
 	/* must be set before quota calculations */
 	mvmvif->ap_ibss_active = true;
@@ -2165,7 +2191,6 @@ out_quota_failed:
 	iwl_mvm_power_update_mac(mvm);
 	mvmvif->ap_ibss_active = false;
 	iwl_mvm_send_rm_bcast_sta(mvm, vif);
-out_rm_mcast:
 	iwl_mvm_rm_mcast_sta(mvm, vif);
 out_unbind:
 	iwl_mvm_binding_remove_vif(mvm, vif);
