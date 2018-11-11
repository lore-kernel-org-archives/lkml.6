Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FAC0C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1884E20871
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eM11B8RR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1884E20871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731990AbeKLJ76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:59:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:60706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731042AbeKLIR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:17:28 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AE382154B;
        Sun, 11 Nov 2018 22:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975253;
        bh=L/MDf7uArLSmjRMBg9/JzHRjdE4JZGhjjgGeyPYzLM4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eM11B8RRP4B6HMlxBUhthlcMhHNn3FEGACqge3IQaVbHxzlajJeMXElkzoKPmYrU7
         3VvLRlGmrJcv/593ll+p23HXTGoOeL8/E7Rrvs1fAX08+w3cbZLu0CE3KP1idUSFqu
         LUI0I3FO/5/4opaqjwhy+1K/ZQiAVV2tYk85HmI8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sara Sharon <sara.sharon@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 121/361] iwlwifi: mvm: fix BAR seq ctrl reporting
Date:   Sun, 11 Nov 2018 14:17:48 -0800
Message-Id: <20181111221637.022468802@linuxfoundation.org>
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -1405,6 +1405,7 @@ static void iwl_mvm_rx_tx_cmd_single(str
 	while (!skb_queue_empty(&skbs)) {
 		struct sk_buff *skb = __skb_dequeue(&skbs);
 		struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+		struct ieee80211_hdr *hdr = (void *)skb->data;
 		bool flushed = false;
 
 		skb_freed++;
@@ -1449,11 +1450,11 @@ static void iwl_mvm_rx_tx_cmd_single(str
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


