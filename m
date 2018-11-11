Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A470CC43610
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DC9C2084C
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ROmcAJut"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DC9C2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731848AbeKLKEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 05:04:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:59904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730389AbeKLIRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:17:13 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6973E223C6;
        Sun, 11 Nov 2018 22:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975237;
        bh=98CafglR/XzTGyJip2Bhq63DAgRzN6suN2XawGtJTWs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ROmcAJutyIgMyXaFsk1c6aMMHVL71ZyxJ1uUxJLB+aBDZdijPgy8J+k4a6CCa+Gbr
         SnlrqqXZZT1evGBQ6xh+jqm6ooH4QfOOkHNZifqM7OOiU8fY3ovM8Qt8dO9LijTXpG
         tHY5vpKsTlogVp6i5TAhKaSobUNOutiqmCqRvjI0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 074/361] iwlwifi: mvm: clear HW_RESTART_REQUESTED when stopping the interface
Date:   Sun, 11 Nov 2018 14:17:01 -0800
Message-Id: <20181111221630.367464168@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1233,12 +1233,15 @@ void __iwl_mvm_mac_stop(struct iwl_mvm *
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
 


