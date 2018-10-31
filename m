Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31AEECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8834F20847
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="faCSA+8e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8834F20847
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731091AbeKAIKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:10:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:33168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731072AbeKAIKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:10:33 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E243C20838;
        Wed, 31 Oct 2018 23:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027421;
        bh=Qy4VKV5WideHusplge3nKbXSwgXp597H/IP1bkNUcd4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=faCSA+8eJP00gmKm05a9q2kM773MkrS4q/sfyiI+Gr2oo4UVcksg8pdlY+aCsimVs
         ukZSTedwFoBmoMOhYBoWiYoa64Li4yncPqiUpreny3G6SIIJJUtfUyB/1P2D7Cb9mI
         X1wiJHtKC8tJOTC7cRFjC+14XsfyIp181h+AtGwc=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sara Sharon <sara.sharon@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 36/73] iwlwifi: mvm: fix BAR seq ctrl reporting
Date:   Wed, 31 Oct 2018 19:09:11 -0400
Message-Id: <20181031230948.29203-36-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230948.29203-1-sashal@kernel.org>
References: <20181031230948.29203-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sara Sharon <sara.sharon@intel.com>

[ Upstream commit 941ab4eb66c10bc5c7234e83a7a858b2806ed151 ]

There is a bug in FW where the sequence control may be
incorrect, and the driver overrides it with the value
of the ieee80211 header.

However, in BAR there is no sequence control in the header,
which result with arbitrary sequence.

This access to an unknown location is bad and it makes the
logs very confusing - so fix it.

Signed-off-by: Sara Sharon <sara.sharon@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 6c014c273922..62a6e293cf12 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -1345,6 +1345,7 @@ static void iwl_mvm_rx_tx_cmd_single(struct iwl_mvm *mvm,
 	while (!skb_queue_empty(&skbs)) {
 		struct sk_buff *skb = __skb_dequeue(&skbs);
 		struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+		struct ieee80211_hdr *hdr = (void *)skb->data;
 		bool flushed = false;
 
 		skb_freed++;
@@ -1389,11 +1390,11 @@ static void iwl_mvm_rx_tx_cmd_single(struct iwl_mvm *mvm,
 			info->flags |= IEEE80211_TX_STAT_AMPDU_NO_BACK;
 		info->flags &= ~IEEE80211_TX_CTL_AMPDU;
 
-		/* W/A FW bug: seq_ctl is wrong when the status isn't success */
-		if (status != TX_STATUS_SUCCESS) {
-			struct ieee80211_hdr *hdr = (void *)skb->data;
+		/* W/A FW bug: seq_ctl is wrong upon failure / BAR frame */
+		if (ieee80211_is_back_req(hdr->frame_control))
+			seq_ctl = 0;
+		else if (status != TX_STATUS_SUCCESS)
 			seq_ctl = le16_to_cpu(hdr->seq_ctrl);
-		}
 
 		if (unlikely(!seq_ctl)) {
 			struct ieee80211_hdr *hdr = (void *)skb->data;
-- 
2.17.1

