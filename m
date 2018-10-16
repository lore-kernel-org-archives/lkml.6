Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E46DC070C3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4881620869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3sB6h8o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4881620869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729768AbeJPMND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:13:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:51406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729434AbeJPMDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:03:05 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBD482145D;
        Tue, 16 Oct 2018 04:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663282;
        bh=2ni26Gm3lDrgz1i5JAKkzCWP9Q2UjZCn98Wn1nvpqug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b3sB6h8oQuiNHGvADDqryZ9KEvba9yFs9Zilxip+1qTHKByywoYBxp9N3Mho0FggD
         YTa0/Q84j1j/hykbk0HiElfthVOwK2Ty04g7buZ5vsRb4U2nAfbJVMWJTSmyv51ZhS
         WK0256Q6EbafuEZXR0Hnb1uj6YAgHPMWf7SAAMoo=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yu Zhao <yuzhao@google.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 43/61] cfg80211: fix use-after-free in reg_process_hint()
Date:   Tue, 16 Oct 2018 00:13:45 -0400
Message-Id: <20181016041403.135678-43-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041403.135678-1-sashal@kernel.org>
References: <20181016041403.135678-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Zhao <yuzhao@google.com>

[ Upstream commit 1db58529454742f67ebd96e3588315e880b72837 ]

reg_process_hint_country_ie() can free regulatory_request and return
REG_REQ_ALREADY_SET. We shouldn't use regulatory_request after it's
called. KASAN error was observed when this happens.

BUG: KASAN: use-after-free in reg_process_hint+0x839/0x8aa [cfg80211]
Read of size 4 at addr ffff8800c430d434 by task kworker/1:3/89
<snipped>
Workqueue: events reg_todo [cfg80211]
Call Trace:
 dump_stack+0xc1/0x10c
 ? _atomic_dec_and_lock+0x1ad/0x1ad
 ? _raw_spin_lock_irqsave+0xa0/0xd2
 print_address_description+0x86/0x26f
 ? reg_process_hint+0x839/0x8aa [cfg80211]
 kasan_report+0x241/0x29b
 reg_process_hint+0x839/0x8aa [cfg80211]
 reg_todo+0x204/0x5b9 [cfg80211]
 process_one_work+0x55f/0x8d0
 ? worker_detach_from_pool+0x1b5/0x1b5
 ? _raw_spin_unlock_irq+0x65/0xdd
 ? _raw_spin_unlock_irqrestore+0xf3/0xf3
 worker_thread+0x5dd/0x841
 ? kthread_parkme+0x1d/0x1d
 kthread+0x270/0x285
 ? pr_cont_work+0xe3/0xe3
 ? rcu_read_unlock_sched_notrace+0xca/0xca
 ret_from_fork+0x22/0x40

Allocated by task 2718:
 set_track+0x63/0xfa
 __kmalloc+0x119/0x1ac
 regulatory_hint_country_ie+0x38/0x329 [cfg80211]
 __cfg80211_connect_result+0x854/0xadd [cfg80211]
 cfg80211_rx_assoc_resp+0x3bc/0x4f0 [cfg80211]
smsc95xx v1.0.6
 ieee80211_sta_rx_queued_mgmt+0x1803/0x7ed5 [mac80211]
 ieee80211_iface_work+0x411/0x696 [mac80211]
 process_one_work+0x55f/0x8d0
 worker_thread+0x5dd/0x841
 kthread+0x270/0x285
 ret_from_fork+0x22/0x40

Freed by task 89:
 set_track+0x63/0xfa
 kasan_slab_free+0x6a/0x87
 kfree+0xdc/0x470
 reg_process_hint+0x31e/0x8aa [cfg80211]
 reg_todo+0x204/0x5b9 [cfg80211]
 process_one_work+0x55f/0x8d0
 worker_thread+0x5dd/0x841
 kthread+0x270/0x285
 ret_from_fork+0x22/0x40
<snipped>

Signed-off-by: Yu Zhao <yuzhao@google.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/reg.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 6f032c7b8732..bd91de416035 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -2170,11 +2170,12 @@ static void reg_process_hint(struct regulatory_request *reg_request)
 {
 	struct wiphy *wiphy = NULL;
 	enum reg_request_treatment treatment;
+	enum nl80211_reg_initiator initiator = reg_request->initiator;
 
 	if (reg_request->wiphy_idx != WIPHY_IDX_INVALID)
 		wiphy = wiphy_idx_to_wiphy(reg_request->wiphy_idx);
 
-	switch (reg_request->initiator) {
+	switch (initiator) {
 	case NL80211_REGDOM_SET_BY_CORE:
 		treatment = reg_process_hint_core(reg_request);
 		break;
@@ -2192,7 +2193,7 @@ static void reg_process_hint(struct regulatory_request *reg_request)
 		treatment = reg_process_hint_country_ie(wiphy, reg_request);
 		break;
 	default:
-		WARN(1, "invalid initiator %d\n", reg_request->initiator);
+		WARN(1, "invalid initiator %d\n", initiator);
 		goto out_free;
 	}
 
@@ -2207,7 +2208,7 @@ static void reg_process_hint(struct regulatory_request *reg_request)
 	 */
 	if (treatment == REG_REQ_ALREADY_SET && wiphy &&
 	    wiphy->regulatory_flags & REGULATORY_STRICT_REG) {
-		wiphy_update_regulatory(wiphy, reg_request->initiator);
+		wiphy_update_regulatory(wiphy, initiator);
 		wiphy_all_share_dfs_chan_state(wiphy);
 		reg_check_channels();
 	}
-- 
2.17.1

