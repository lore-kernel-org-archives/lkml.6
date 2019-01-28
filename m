Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECBD9C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1DCE20881
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548697946;
	bh=I7pvq7t2LNOlv+qCf0XfWD7FvlCtcake4L0qhz0Dk90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oL5GznIgUY7z2kg+NfzWe3KGaukXuwAykhan1L7RCgk62VFCS1WnAGni7nkLheDav
	 O6eLy/92z6vabtyu2mWC1vHMd3WVAnBuXaWFi7jgh24/EyKeiwiMSUbUcSKbIELQpt
	 FdtzQQQnw8avRlBDO/H7Sb0LvPtdOqE23IMejhzg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbfA1RwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:52:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:57108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726899AbfA1Pnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:43:55 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 490C02173C;
        Mon, 28 Jan 2019 15:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690234;
        bh=I7pvq7t2LNOlv+qCf0XfWD7FvlCtcake4L0qhz0Dk90=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dU6kQF9ItK+WTUn4trtF0cGlnRdnp3vcQch6VaELYBarMimmV7gRsr/T8hx5UGaHG
         Kt2pdPfkK1ZDWF/yJXlDsqPuHcAIyg1o7hbVAlLfx1Ng0J172Ml3+677q8GQA/OjQD
         NaupYNL8LKuET1JtKagofdT+NynnDLb5d8xRoE4M=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 010/304] ath10k: fixup extended per sta tx statistics
Date:   Mon, 28 Jan 2019 10:38:47 -0500
Message-Id: <20190128154341.47195-10-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

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

