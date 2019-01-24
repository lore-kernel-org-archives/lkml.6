Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B43C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE89720663
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548359040;
	bh=mWVZCi1IPpHLwx46Dn4aUJBknwRWWvzTrZoITtwjgk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bV6kUu0doNPphacsgR8H65HM5UCWDUL62trfnY4b/SObgEnjBaoMZKxufleXoHB1z
	 /UqydJ53MmsYyJQStENlptjiQxOtwDhqQwGCkQTcTqjF46EKngcOb1ZRE8RLQ72KFc
	 M9cjfbgErgcvWWq6mEirpVxUoR+9CWptC62qp3T4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732950AbfAXTnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:43:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:44444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733300AbfAXTnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:43:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67FC120663;
        Thu, 24 Jan 2019 19:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548359026;
        bh=mWVZCi1IPpHLwx46Dn4aUJBknwRWWvzTrZoITtwjgk8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d3TrEEuNyEQCDm1jlS0pgsfCc6WVmAydcYDcvqav73yzqkqqvffqbM42yQgWGQwQc
         mM/DLYrXApS2wOsqdHZYhHgm8Qi3KLM2Obl5kT8nc1iCxvJH84mGu16IgvZOjbn1uk
         VYGRWWyPvPAdtzR4zEA3+z/53qZlyA7p5oEuP8pw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhi Chen <zhichen@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 109/127] ath10k: fix peer stats null pointer dereference
Date:   Thu, 24 Jan 2019 20:20:55 +0100
Message-Id: <20190124190216.615532983@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190211.984305387@linuxfoundation.org>
References: <20190124190211.984305387@linuxfoundation.org>
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
index b09cdc699c69..38afbbd9fb44 100644
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
index ffec98f7be50..2c2761d04d01 100644
--- a/drivers/net/wireless/ath/ath10k/htt_rx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_rx.c
@@ -2832,7 +2832,7 @@ static void ath10k_htt_fetch_peer_stats(struct ath10k *ar,
 	rcu_read_lock();
 	spin_lock_bh(&ar->data_lock);
 	peer = ath10k_peer_find_by_id(ar, peer_id);
-	if (!peer) {
+	if (!peer || !peer->sta) {
 		ath10k_warn(ar, "Invalid peer id %d peer stats buffer\n",
 			    peer_id);
 		goto out;
@@ -2885,7 +2885,7 @@ static void ath10k_fetch_10_2_tx_stats(struct ath10k *ar, u8 *data)
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



