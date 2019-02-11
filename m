Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF8EC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 097A2218D8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549900796;
	bh=kYaegojv1mYe31QyiQefdE9ThACyYSqoiTsRdzbkuO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0jvOgQ2fT15zz8HbB8sskQW2YoWkQ45ds77YoSQ8FILGBNp5ojpK2df/Wnvvs4/o8
	 nRPwx3mMwN3TexLGqOr5k/V533vxe1iq5MOWltNW2u3f+Myv8FPrIpSBzMgpR1S/Z3
	 y2mkfKjmd8VJnTbxTWj2AixOBEi+1q3ydzzuyiBg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730400AbfBKOcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:32:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:39100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730389AbfBKOb4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:31:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40C5A20838;
        Mon, 11 Feb 2019 14:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895515;
        bh=kYaegojv1mYe31QyiQefdE9ThACyYSqoiTsRdzbkuO4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jtsRyQ7GrTpUTwyCIxAiRk3naXij2HunZKJNYw/oSo1p5Md/Olc+3uJURpOKPfmVi
         pKoIRMSdkxTvdLLBWhLooZjff9O819v/S7iFPIin5weqhIBc6xq/LJKYPGjQ98NgSZ
         vD2nbuc7b7ipIbVwdvL17B6xrhs1SvMMIlDdyr+c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhi Chen <zhichen@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 230/352] ath10k: fix tx_stats memory leak
Date:   Mon, 11 Feb 2019 15:17:37 +0100
Message-Id: <20190211141901.859926316@linuxfoundation.org>
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

[ Upstream commit 386f97e3b201d18578abb0e7037b85a1ae50c0a3 ]

Memory of tx_stats was allocated when a STA was added. But it's not freed
if the STA failed to be added to driver. This issue could be seen in MDK3
attack case when STA number reached the limit.

Tested: QCA9984 with firmware ver 10.4-3.9.0.1-00005
Signed-off-by: Zhi Chen <zhichen@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath10k/mac.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 6436dc229be5..400495858e4e 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -6293,15 +6293,6 @@ static int ath10k_sta_state(struct ieee80211_hw *hw,
 			   ar->num_stations + 1, ar->max_num_stations,
 			   ar->num_peers + 1, ar->max_num_peers);
 
-		if (ath10k_debug_is_extd_tx_stats_enabled(ar)) {
-			arsta->tx_stats = kzalloc(sizeof(*arsta->tx_stats),
-						  GFP_KERNEL);
-			if (!arsta->tx_stats) {
-				ret = -ENOMEM;
-				goto exit;
-			}
-		}
-
 		num_tdls_stations = ath10k_mac_tdls_vif_stations_count(hw, vif);
 		num_tdls_vifs = ath10k_mac_tdls_vifs_count(hw);
 
@@ -6323,12 +6314,22 @@ static int ath10k_sta_state(struct ieee80211_hw *hw,
 			goto exit;
 		}
 
+		if (ath10k_debug_is_extd_tx_stats_enabled(ar)) {
+			arsta->tx_stats = kzalloc(sizeof(*arsta->tx_stats),
+						  GFP_KERNEL);
+			if (!arsta->tx_stats) {
+				ret = -ENOMEM;
+				goto exit;
+			}
+		}
+
 		ret = ath10k_peer_create(ar, vif, sta, arvif->vdev_id,
 					 sta->addr, peer_type);
 		if (ret) {
 			ath10k_warn(ar, "failed to add peer %pM for vdev %d when adding a new sta: %i\n",
 				    sta->addr, arvif->vdev_id, ret);
 			ath10k_mac_dec_num_stations(arvif, sta);
+			kfree(arsta->tx_stats);
 			goto exit;
 		}
 
@@ -6341,6 +6342,7 @@ static int ath10k_sta_state(struct ieee80211_hw *hw,
 			spin_unlock_bh(&ar->data_lock);
 			ath10k_peer_delete(ar, arvif->vdev_id, sta->addr);
 			ath10k_mac_dec_num_stations(arvif, sta);
+			kfree(arsta->tx_stats);
 			ret = -ENOENT;
 			goto exit;
 		}
@@ -6361,6 +6363,7 @@ static int ath10k_sta_state(struct ieee80211_hw *hw,
 			ath10k_peer_delete(ar, arvif->vdev_id,
 					   sta->addr);
 			ath10k_mac_dec_num_stations(arvif, sta);
+			kfree(arsta->tx_stats);
 			goto exit;
 		}
 
@@ -6372,6 +6375,7 @@ static int ath10k_sta_state(struct ieee80211_hw *hw,
 				    sta->addr, arvif->vdev_id, ret);
 			ath10k_peer_delete(ar, arvif->vdev_id, sta->addr);
 			ath10k_mac_dec_num_stations(arvif, sta);
+			kfree(arsta->tx_stats);
 
 			if (num_tdls_stations != 0)
 				goto exit;
-- 
2.19.1



