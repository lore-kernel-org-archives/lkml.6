Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE786C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F91521726
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548359626;
	bh=jTw6x7NZ1T7rD576reZdJ4B7JzRYGWGNMO/R5TGNqEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XFLq20TbL7sorb4bvM1yNLA/FRImVZ3PTZgj5a80MwidxPUQY6dvqiEfHcToNOYW2
	 uUeZuoxQLVyCjp20gWDEtHpV1GJ8uykKG22vih3WB+wnXP6HbKB9R3dtZzQALI5gVS
	 mXutdAc6KRkWcag9OkKIcFtvkJYKFPet7DIQ79Sg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732748AbfAXTh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:37:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:37996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732714AbfAXTh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:37:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3803B218FC;
        Thu, 24 Jan 2019 19:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358675;
        bh=jTw6x7NZ1T7rD576reZdJ4B7JzRYGWGNMO/R5TGNqEU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P6dYPM+3y0QmMq4lpK3jWfIv5ZMJDCftvrBedNhX9X0F6yaq9TeYrCoZtKws9nCMG
         Nuok8a+kZVM8jbFxN2PZUZ+sRQhjMjocQKXwkKizN/6uoeTK0m43O14bF/cW9cxfYC
         IP27wvA16rfEwQxY2rvWlcHJvkN/A4iFPgirznvc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhi Chen <zhichen@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 091/106] ath10k: fix peer stats null pointer dereference
Date:   Thu, 24 Jan 2019 20:20:48 +0100
Message-Id: <20190124190211.826697777@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190206.342411005@linuxfoundation.org>
References: <20190124190206.342411005@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 2d3b55853b123c177037cf534c5aaa2650310094 ]

There was a race condition in SMP that an ath10k_peer was created but its
member sta was null. Following are procedures of ath10k_peer creation and
member sta access in peer statistics path.

    1. Peer creation:
        ath10k_peer_create()
            =>ath10k_wmi_peer_create()
                =>ath10k_wait_for_peer_created()
                ...

        # another kernel path, RX from firmware
        ath10k_htt_t2h_msg_handler()
        =>ath10k_peer_map_event()
                =>wake_up()
                # ar->peer_map[id] = peer //add peer to map

        #wake up original path from waiting
                ...
                # peer->sta = sta //sta assignment

    2.  RX path of statistics
        ath10k_htt_t2h_msg_handler()
            =>ath10k_update_per_peer_tx_stats()
                =>ath10k_htt_fetch_peer_stats()
                # peer->sta //sta accessing

Any access of peer->sta after peer was added to peer_map but before sta was
assigned could cause a null pointer issue. And because these two steps are
asynchronous, no proper lock can protect them. So both peer and sta need to
be checked before access.

Tested: QCA9984 with firmware ver 10.4-3.9.0.1-00005
Signed-off-by: Zhi Chen <zhichen@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath10k/debugfs_sta.c | 2 +-
 drivers/net/wireless/ath/ath10k/htt_rx.c      | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/debugfs_sta.c b/drivers/net/wireless/ath/ath10k/debugfs_sta.c
index a63c97e2c50c..6f10331e986b 100644
--- a/drivers/net/wireless/ath/ath10k/debugfs_sta.c
+++ b/drivers/net/wireless/ath/ath10k/debugfs_sta.c
@@ -71,7 +71,7 @@ void ath10k_sta_update_rx_tid_stats_ampdu(struct ath10k *ar, u16 peer_id, u8 tid
 	spin_lock_bh(&ar->data_lock);
 
 	peer = ath10k_peer_find_by_id(ar, peer_id);
-	if (!peer)
+	if (!peer || !peer->sta)
 		goto out;
 
 	arsta = (struct ath10k_sta *)peer->sta->drv_priv;
diff --git a/drivers/net/wireless/ath/ath10k/htt_rx.c b/drivers/net/wireless/ath/ath10k/htt_rx.c
index 4d1cd90d6d27..03d4cc6f35bc 100644
--- a/drivers/net/wireless/ath/ath10k/htt_rx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_rx.c
@@ -2589,7 +2589,7 @@ static void ath10k_htt_fetch_peer_stats(struct ath10k *ar,
 	rcu_read_lock();
 	spin_lock_bh(&ar->data_lock);
 	peer = ath10k_peer_find_by_id(ar, peer_id);
-	if (!peer) {
+	if (!peer || !peer->sta) {
 		ath10k_warn(ar, "Invalid peer id %d peer stats buffer\n",
 			    peer_id);
 		goto out;
@@ -2642,7 +2642,7 @@ static void ath10k_fetch_10_2_tx_stats(struct ath10k *ar, u8 *data)
 	rcu_read_lock();
 	spin_lock_bh(&ar->data_lock);
 	peer = ath10k_peer_find_by_id(ar, peer_id);
-	if (!peer) {
+	if (!peer || !peer->sta) {
 		ath10k_warn(ar, "Invalid peer id %d in peer stats buffer\n",
 			    peer_id);
 		goto out;
-- 
2.19.1



