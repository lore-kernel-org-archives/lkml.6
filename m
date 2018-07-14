Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B449ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 17:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26E5220871
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 17:44:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26E5220871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osadl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731086AbeGNSD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 14:03:27 -0400
Received: from www.osadl.org ([62.245.132.105]:37008 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727193AbeGNSD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 14:03:27 -0400
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59] (may be forged))
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id w6EHdBWi006211;
        Sat, 14 Jul 2018 19:39:11 +0200
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] ath10k: htt_tx: move lock into id_get function
Date:   Sat, 14 Jul 2018 19:38:20 +0200
Message-Id: <1531589900-29220-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 This is only code refactoring as all call sites of 
ath10k_htt_tx_alloc_msdu_id() take the same lock it can be moved into the
id_get function and the assertion dropped.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---
Found during code review

Patch was compile tested with: x86_64_defconfig + CONFIG_ATH10K=y
(with a number of sparse warnings "expression using sizeof(void)")

Patch is against 4.18-rc4 (localversion-next is next-20180713)

 drivers/net/wireless/ath/ath10k/htt_tx.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/htt_tx.c b/drivers/net/wireless/ath/ath10k/htt_tx.c
index 89157c5..8a2aa2d 100644
--- a/drivers/net/wireless/ath/ath10k/htt_tx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_tx.c
@@ -208,10 +208,10 @@ int ath10k_htt_tx_alloc_msdu_id(struct ath10k_htt *htt, struct sk_buff *skb)
 	struct ath10k *ar = htt->ar;
 	int ret;
 
-	lockdep_assert_held(&htt->tx_lock);
-
+	spin_lock_bh(&htt->tx_lock);
 	ret = idr_alloc(&htt->pending_tx, skb, 0,
 			htt->max_num_pending_tx, GFP_ATOMIC);
+	spin_unlock_bh(&htt->tx_lock);
 
 	ath10k_dbg(ar, ATH10K_DBG_HTT, "htt tx alloc msdu_id %d\n", ret);
 
@@ -1077,9 +1077,7 @@ int ath10k_htt_mgmt_tx(struct ath10k_htt *htt, struct sk_buff *msdu)
 	len += sizeof(cmd->hdr);
 	len += sizeof(cmd->mgmt_tx);
 
-	spin_lock_bh(&htt->tx_lock);
 	res = ath10k_htt_tx_alloc_msdu_id(htt, msdu);
-	spin_unlock_bh(&htt->tx_lock);
 	if (res < 0)
 		goto err;
 
@@ -1161,9 +1159,7 @@ static int ath10k_htt_tx_32(struct ath10k_htt *htt,
 	struct htt_msdu_ext_desc *ext_desc = NULL;
 	struct htt_msdu_ext_desc *ext_desc_t = NULL;
 
-	spin_lock_bh(&htt->tx_lock);
 	res = ath10k_htt_tx_alloc_msdu_id(htt, msdu);
-	spin_unlock_bh(&htt->tx_lock);
 	if (res < 0)
 		goto err;
 
@@ -1363,9 +1359,7 @@ static int ath10k_htt_tx_64(struct ath10k_htt *htt,
 	struct htt_msdu_ext_desc_64 *ext_desc = NULL;
 	struct htt_msdu_ext_desc_64 *ext_desc_t = NULL;
 
-	spin_lock_bh(&htt->tx_lock);
 	res = ath10k_htt_tx_alloc_msdu_id(htt, msdu);
-	spin_unlock_bh(&htt->tx_lock);
 	if (res < 0)
 		goto err;
 
-- 
2.1.4

