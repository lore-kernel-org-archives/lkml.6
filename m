Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165227AbeE1NPv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:15:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:39716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163270AbeE1KuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:50:15 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andrei Otcheretianski <andrei.otcheretianski@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 202/496] iwlwifi: mvm: Fix channel switch for count 0 and 1
Date: Mon, 28 May 2018 11:59:47 +0200
Message-Id: <20180528100328.442738092@linuxfoundation.org>
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

From: Andrei Otcheretianski <andrei.otcheretianski@intel.com>

[ Upstream commit 40d53f4a60c9eb10d4fa58066c23ba1af8a59e39 ]

It was assumed that apply_time==0 implies immediate scheduling, which is
wrong. Instead, the fw expects the START_IMMEDIATELY flag to be set.
Otherwise, this resulted in 0x3063 assert.
Fix that.
While at it rename the T2_V2_START_IMMEDIATELY to
TE_V2_START_IMMEDIATELY.

Fixes: f5d8f50f271d ("iwlwifi: mvm: Fix channel switch in case of count <= 1")
Signed-off-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/time-event.h |    4 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/time-event.c    |    6 ++++--
 2 files changed, 6 insertions(+), 4 deletions(-)

--- a/drivers/net/wireless/intel/iwlwifi/fw/api/time-event.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/time-event.h
@@ -211,7 +211,7 @@ enum {
  * @TE_V2_NOTIF_HOST_FRAG_END:request/receive notification on frag end
  * @TE_V2_NOTIF_INTERNAL_FRAG_START: internal FW use.
  * @TE_V2_NOTIF_INTERNAL_FRAG_END: internal FW use.
- * @T2_V2_START_IMMEDIATELY: start time event immediately
+ * @TE_V2_START_IMMEDIATELY: start time event immediately
  * @TE_V2_DEP_OTHER: depends on another time event
  * @TE_V2_DEP_TSF: depends on a specific time
  * @TE_V2_EVENT_SOCIOPATHIC: can't co-exist with other events of tha same MAC
@@ -230,7 +230,7 @@ enum iwl_time_event_policy {
 	TE_V2_NOTIF_HOST_FRAG_END = BIT(5),
 	TE_V2_NOTIF_INTERNAL_FRAG_START = BIT(6),
 	TE_V2_NOTIF_INTERNAL_FRAG_END = BIT(7),
-	T2_V2_START_IMMEDIATELY = BIT(11),
+	TE_V2_START_IMMEDIATELY = BIT(11),
 
 	/* placement characteristics */
 	TE_V2_DEP_OTHER = BIT(TE_V2_PLACEMENT_POS),
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -621,7 +621,7 @@ void iwl_mvm_protect_session(struct iwl_
 	time_cmd.repeat = 1;
 	time_cmd.policy = cpu_to_le16(TE_V2_NOTIF_HOST_EVENT_START |
 				      TE_V2_NOTIF_HOST_EVENT_END |
-				      T2_V2_START_IMMEDIATELY);
+				      TE_V2_START_IMMEDIATELY);
 
 	if (!wait_for_notif) {
 		iwl_mvm_time_event_send_add(mvm, vif, te_data, &time_cmd);
@@ -814,7 +814,7 @@ int iwl_mvm_start_p2p_roc(struct iwl_mvm
 	time_cmd.repeat = 1;
 	time_cmd.policy = cpu_to_le16(TE_V2_NOTIF_HOST_EVENT_START |
 				      TE_V2_NOTIF_HOST_EVENT_END |
-				      T2_V2_START_IMMEDIATELY);
+				      TE_V2_START_IMMEDIATELY);
 
 	return iwl_mvm_time_event_send_add(mvm, vif, te_data, &time_cmd);
 }
@@ -924,6 +924,8 @@ int iwl_mvm_schedule_csa_period(struct i
 	time_cmd.interval = cpu_to_le32(1);
 	time_cmd.policy = cpu_to_le16(TE_V2_NOTIF_HOST_EVENT_START |
 				      TE_V2_ABSENCE);
+	if (!apply_time)
+		time_cmd.policy |= cpu_to_le16(TE_V2_START_IMMEDIATELY);
 
 	return iwl_mvm_time_event_send_add(mvm, vif, te_data, &time_cmd);
 }
