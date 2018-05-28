Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939082AbeE1NCB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:02:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:42560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164130AbeE1KxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:53:23 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Avraham Stern <avraham.stern@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 269/496] iwlwifi: mvm: make sure internal station has a valid id
Date: Mon, 28 May 2018 12:00:54 +0200
Message-Id: <20180528100331.193845522@linuxfoundation.org>
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

[ Upstream commit df65c8d1728adee2a52c30287d33da83a8c87480 ]

If the driver failed to resume from D3, it is possible that it has
no valid aux station. In such case, fw restart will end up in sending
station related commands with an invalid station id, which will
result in an assert.

Fix this by allocating a new station id for the aux station if it
does not have a valid id even in the case of fw restart.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -1679,7 +1679,8 @@ int iwl_mvm_allocate_int_sta(struct iwl_
 			     u32 qmask, enum nl80211_iftype iftype,
 			     enum iwl_sta_type type)
 {
-	if (!test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status)) {
+	if (!test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status) ||
+	    sta->sta_id == IWL_MVM_INVALID_STA) {
 		sta->sta_id = iwl_mvm_find_free_sta_id(mvm, iftype);
 		if (WARN_ON_ONCE(sta->sta_id == IWL_MVM_INVALID_STA))
 			return -ENOSPC;
