Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BDCC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EB8820818
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549894855;
	bh=xI62sbsWMUW17iABDBaWgqegJfZfBz9LMeDbkmHHxGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D425kilJGGqMF16IRkOiYXz6MqCtZE4Lpqd7ohZVqlQb7bOoXCsEFI8oh2lvlugdY
	 qWWDg+MjfC0O1cHP7hu+xy/SWiV14y6tz1KQ1dLc0g6NIC7XHMqZsoVMt0qcEAZ50x
	 KMO+yEmqEq5b85kNKa9aC1FLoUCRID6OZfW2IQcQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbfBKOUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:20:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:53620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726796AbfBKOUv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:20:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8B8A2073F;
        Mon, 11 Feb 2019 14:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549894851;
        bh=xI62sbsWMUW17iABDBaWgqegJfZfBz9LMeDbkmHHxGU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gLpGbeEFn2CXQITlP5h0xNSUnndi9BzrXqwFDPsp0zLMSrgMoi5YlpCQJbt6hDMDH
         h14cMaqqTbBZCYp4Y4VapM9DgrFl/KMet00ff8fedg12mR04ii35DyWP2u5fNSRJs7
         lh1zLbDu4PL1gWSlrT7K5ltsf4CSCGQVjgHdDIAE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 010/352] ath10k: fixup extended per sta tx statistics
Date:   Mon, 11 Feb 2019 15:13:57 +0100
Message-Id: <20190211141847.088980946@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 539b44e70c5b4ad82d2c0c97a4dfb37523d891f6 ]

I had a couple concerns with this code.  First, we definitely need to
set the error code if the kzalloc() fails.  Secondly, I was worried that
if we didn't set "arsta->tx_stats" to NULL after freeing it, then it
looks to me like it might lead to a use after free.  I can't test that,
but it's harmless to set it to NULL so I did.

Fixes: a904417fc876 ("ath10k: add extended per sta tx statistics support")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath10k/mac.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 7e49342bae38..b4764fee4751 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -6296,8 +6296,10 @@ static int ath10k_sta_state(struct ieee80211_hw *hw,
 		if (ath10k_debug_is_extd_tx_stats_enabled(ar)) {
 			arsta->tx_stats = kzalloc(sizeof(*arsta->tx_stats),
 						  GFP_KERNEL);
-			if (!arsta->tx_stats)
+			if (!arsta->tx_stats) {
+				ret = -ENOMEM;
 				goto exit;
+			}
 		}
 
 		num_tdls_stations = ath10k_mac_tdls_vif_stations_count(hw, vif);
@@ -6385,8 +6387,10 @@ static int ath10k_sta_state(struct ieee80211_hw *hw,
 			   "mac vdev %d peer delete %pM sta %pK (sta gone)\n",
 			   arvif->vdev_id, sta->addr, sta);
 
-		if (ath10k_debug_is_extd_tx_stats_enabled(ar))
+		if (ath10k_debug_is_extd_tx_stats_enabled(ar)) {
 			kfree(arsta->tx_stats);
+			arsta->tx_stats = NULL;
+		}
 
 		if (sta->tdls) {
 			ret = ath10k_mac_tdls_peer_update(ar, arvif->vdev_id,
-- 
2.19.1



