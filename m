Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F916ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3760E20664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+t3yU2O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3760E20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730458AbeKAIgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:36:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:58720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730129AbeKAIJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:09:07 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42BB020847;
        Wed, 31 Oct 2018 23:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027335;
        bh=PDjINacEU4tSOsCAzbtoGLoQJRD2SNX0ZZ2K7PFHhFs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G+t3yU2OkmxS7OO6TwJ9N/mjVACeECObUpU4+Dto5NUHSb5//zLa5Z3FzAaxaB0yE
         fMkzRhriOmF7dY/suRx5KLQQKF7ylGF2M1JHW55dxOU0oUb3AxhM22xs8pOonLkqfH
         JgL6NRsXB1K6BxyaoHFkr/Ahfypw+Kj/FotmECMU=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sara Sharon <sara.sharon@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 066/126] iwlwifi: mvm: fix BAR seq ctrl reporting
Date:   Wed, 31 Oct 2018 19:06:54 -0400
Message-Id: <20181031230754.29029-66-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230754.29029-1-sashal@kernel.org>
References: <20181031230754.29029-1-sashal@kernel.org>
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
index cf2591f2ac23..2d35b70de2ab 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -1385,6 +1385,7 @@ static void iwl_mvm_rx_tx_cmd_single(struct iwl_mvm *mvm,
 	while (!skb_queue_empty(&skbs)) {
 		struct sk_buff *skb = __skb_dequeue(&skbs);
 		struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+		struct ieee80211_hdr *hdr = (void *)skb->data;
 		bool flushed = false;
 
 		skb_freed++;
@@ -1429,11 +1430,11 @@ static void iwl_mvm_rx_tx_cmd_single(struct iwl_mvm *mvm,
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

