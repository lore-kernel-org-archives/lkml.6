Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C17C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9A332084A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XnMt5zXd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9A332084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730955AbeKAIKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:10:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:60840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729626AbeKAIKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:10:16 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9CED2081B;
        Wed, 31 Oct 2018 23:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027404;
        bh=31KK907yRR+uKRCFXWXmOLob9UdedGL2ocwGb/DQIlQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XnMt5zXdZdfI5uU290nPYi7hvQwv8brZbFv3+4oF2W887jr3wRuqvaCCRblymUTUN
         ee1ggKGs4emVqwc4YUHPmG0mV4h99Wpz6/CGUAnPex2N1BCT+039eeCL9R9vJK19UD
         52utQwEkQzi3Pmo2+5DJ/RZ/tLCkKaUR4kSwMTas=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 17/73] iwlwifi: mvm: clear HW_RESTART_REQUESTED when stopping the interface
Date:   Wed, 31 Oct 2018 19:08:52 -0400
Message-Id: <20181031230948.29203-17-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230948.29203-1-sashal@kernel.org>
References: <20181031230948.29203-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

[ Upstream commit 155f7e0441cd121b1e673d465a35e99f4b9b2f0b ]

Fix a bug that happens in the following scenario:
1) suspend without WoWLAN
2) mac80211 calls drv_stop because of the suspend
3) __iwl_mvm_mac_stop deallocates the aux station
4) during drv_stop the firmware crashes
5) iwlmvm:
	* sets IWL_MVM_STATUS_HW_RESTART_REQUESTED
	* asks mac80211 to kick the restart flow
6) mac80211 puts the restart worker into a freezable
   queue which means that the worker will not run for now
   since the workqueue is already frozen
7) ...
8) resume
9) mac80211 runs ieee80211_reconfig as part of the resume
10) mac80211 detects that a restart flow has been requested
    and that we are now resuming from suspend and cancels
    the restart worker
11) mac80211 calls drv_start()
12) __iwl_mvm_mac_start checks that IWL_MVM_STATUS_HW_RESTART_REQUESTED
    clears it, sets IWL_MVM_STATUS_IN_HW_RESTART and calls
    iwl_mvm_restart_cleanup()
13) iwl_fw_error_dump gets called and accesses the device
    to get debug data
14) iwl_mvm_up adds the aux station
15) iwl_mvm_add_aux_sta() allocates an internal station for
    the aux station
16) iwl_mvm_allocate_int_sta() tests IWL_MVM_STATUS_IN_HW_RESTART
    and doesn't really allocate a station ID for the aux
    station
17) a new queue is added for the aux station

Note that steps from 5 to 9 aren't really part of the
problem but were described for the sake of completeness.

Once the iwl_mvm_mac_stop() is called, the device is not
accessible, meaning that step 12) can't succeed and we'll
see the following:

drivers/net/wireless/intel/iwlwifi/pcie/trans.c:2122 iwl_trans_pcie_grab_nic_access+0xc0/0x1d6 [iwlwifi]()
Timeout waiting for hardware access (CSR_GP_CNTRL 0x080403d8)
Call Trace:
[<ffffffffc03e6ad3>] iwl_trans_pcie_grab_nic_access+0xc0/0x1d6 [iwlwifi]
[<ffffffffc03e6a13>] iwl_trans_pcie_dump_regs+0x3fd/0x3fd [iwlwifi]
[<ffffffffc03dad42>] iwl_fw_error_dump+0x4f5/0xe8b [iwlwifi]
[<ffffffffc04bd43e>] __iwl_mvm_mac_start+0x5a/0x21a [iwlmvm]
[<ffffffffc04bd6d2>] iwl_mvm_mac_start+0xd4/0x103 [iwlmvm]
[<ffffffffc042d378>] drv_start+0xa1/0xc5 [iwl7000_mac80211]
[<ffffffffc045a339>] ieee80211_reconfig+0x145/0xf50 [mac80211]
[<ffffffffc044788b>] ieee80211_resume+0x62/0x66 [mac80211]
[<ffffffffc0366c5b>] wiphy_resume+0xa9/0xc6 [cfg80211]

The station id of the aux station is set to 0xff in step 3
and because we don't really allocate a new station id for
the auxliary station (as explained in 16), we end up sending
a command to the firmware asking to connect the queue
to station id 0xff. This makes the firmware crash with the
following information:

0x00002093 | ADVANCED_SYSASSERT
0x000002F0 | trm_hw_status0
0x00000000 | trm_hw_status1
0x00000B38 | branchlink2
0x0001978C | interruptlink1
0x00000000 | interruptlink2
0xFF080501 | data1
0xDEADBEEF | data2
0xDEADBEEF | data3
Firmware error during reconfiguration - reprobe!
FW error in SYNC CMD SCD_QUEUE_CFG

Fix this by clearing IWL_MVM_STATUS_HW_RESTART_REQUESTED
in iwl_mvm_mac_stop(). We won't be able to collect debug
data anyway and when we will brought up again, we will
have a clean state from the firmware perspective.
Since we won't have IWL_MVM_STATUS_IN_HW_RESTART set in
step 12) we won't get to the 2093 ASSERT either.

Fixes: bf8b286f86fc ("iwlwifi: mvm: defer setting IWL_MVM_STATUS_IN_HW_RESTART")
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index db1fab9aa1c6..80a653950e86 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1225,12 +1225,15 @@ void __iwl_mvm_mac_stop(struct iwl_mvm *mvm)
 	iwl_mvm_del_aux_sta(mvm);
 
 	/*
-	 * Clear IN_HW_RESTART flag when stopping the hw (as restart_complete()
-	 * won't be called in this case).
+	 * Clear IN_HW_RESTART and HW_RESTART_REQUESTED flag when stopping the
+	 * hw (as restart_complete() won't be called in this case) and mac80211
+	 * won't execute the restart.
 	 * But make sure to cleanup interfaces that have gone down before/during
 	 * HW restart was requested.
 	 */
-	if (test_and_clear_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status))
+	if (test_and_clear_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status) ||
+	    test_and_clear_bit(IWL_MVM_STATUS_HW_RESTART_REQUESTED,
+			       &mvm->status))
 		ieee80211_iterate_interfaces(mvm->hw, 0,
 					     iwl_mvm_cleanup_iterator, mvm);
 
-- 
2.17.1

