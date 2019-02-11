Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45AC4C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13C4E20838
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895518;
	bh=J/PGS4QtCJRmZwvkxxHS8zu1o9NPE7gcdXg1esxE6pI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QtCElgmd9Jf8kmu6nNfiMebC9HaAJpUfXLsAOvJvqtkaqVKbOyoNy5jdBkojn3DIF
	 qIs/7WyEuGpTx45vwcJo5zZ2CcOywV+CGVTRDfLTdQtNObKjECSsb4jyD0TQodc2Yd
	 u9nr2Iw9HzjvooP0YxEWfN6S3krKS9YV572cejkw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730390AbfBKOb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:31:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:38972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730371AbfBKObu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:31:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49E9620838;
        Mon, 11 Feb 2019 14:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895509;
        bh=J/PGS4QtCJRmZwvkxxHS8zu1o9NPE7gcdXg1esxE6pI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IVO1bbBhfB4ooq/PMNYgrGRzEpy6Zf2DkwUHK9sKM58Nh3jZ+PnOQrhjcQwII1mvF
         bmg2ryt66tOPaE/nxGKt7OnvVXZsRKoaP90J4g7UVI6admkQZKkgY+vfVM+7DDuk2Z
         YslaIfxONul3KEccnjSauaRAk+kxcz+6B8igGWKc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Karthikeyan Periyasamy <periyasa@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 229/352] ath10k: fix kernel panic due to use after free
Date:   Mon, 11 Feb 2019 15:17:36 +0100
Message-Id: <20190211141901.799812058@linuxfoundation.org>
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

[ Upstream commit 553a7cca769d551f1317186760631487c47e23bf ]

This issue arise in a race condition between ath10k_sta_state() and
ath10k_htt_fetch_peer_stats(), explained in below scenario

Steps:
1. In ath10k_sta_state(), arsta->tx_stats get deallocated before peer deletion
   when the station moves from IEEE80211_STA_NONE to IEEE80211_STA_NOTEXIST
   state.
2. Meanwhile ath10k receive HTT_T2H_MSG_TYPE_PEER_STATS message.
   In ath10k_htt_fetch_peer_stats(), arsta->tx_stats get accessed after
   the peer validation check.

Since arsta->tx_stats get freed before the peer deletion [1].
ath10k_htt_fetch_peer_stats() ended up in "use after free" situation.

Fixed this issue by moving the arsta->tx_stats free handling after the
peer deletion. so that ath10k_htt_fetch_peer_stats() will not end up in
"use after free" situation.

Kernel Panic:

Unable to handle kernel NULL pointer dereference at virtual address 00000286
pgd = d8754000
[00000286] *pgd=00000000
Internal error: Oops: 5 [#1] PREEMPT SMP ARM
...
CPU: 0 PID: 6245 Comm: hostapd Not tainted
task: dc44cac0 ti: d4a38000 task.ti: d4a38000
PC is at kmem_cache_alloc+0x7c/0x114
LR is at ath10k_sta_state+0x190/0xd58 [ath10k_core]
pc : [<c02bdc50>]    lr : [<bf916b78>]    psr: 20000013
sp : d4a39b88  ip : 00000000  fp : 00000001
r10: 00000000  r9 : 1d3bc000  r8 : 00000dc0
r7 : 000080d0  r6 : d4a38000  r5 : dd401b00  r4 : 00000286
r3 : 00000000  r2 : d4a39ba0  r1 : 000080d0  r0 : dd401b00
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 10c5787d  Table: 5a75406a  DAC: 00000015
Process hostapd (pid: 6245, stack limit = 0xd4a38238)
Stack: (0xd4a39b88 to 0xd4a3a000)
...
[<c02bdc50>] (kmem_cache_alloc) from [<bf916b78>] (ath10k_sta_state+0x190/0xd58 [ath10k_core])
[<bf916b78>] (ath10k_sta_state [ath10k_core]) from [<bf870d4c>] (sta_info_insert_rcu+0x418/0x61c [mac80211])
[<bf870d4c>] (sta_info_insert_rcu [mac80211]) from [<bf88634c>] (ieee80211_add_station+0xf0/0x134 [mac80211])
[<bf88634c>] (ieee80211_add_station [mac80211]) from [<bf83f3c4>] (nl80211_new_station+0x330/0x36c [cfg80211])
[<bf83f3c4>] (nl80211_new_station [cfg80211]) from [<bf6c4040>] (extack_doit+0x2c/0x74 [compat])
[<bf6c4040>] (extack_doit [compat]) from [<c05c285c>] (genl_rcv_msg+0x274/0x30c)
[<c05c285c>] (genl_rcv_msg) from [<c05c1d98>] (netlink_rcv_skb+0x58/0xac)
[<c05c1d98>] (netlink_rcv_skb) from [<c05c25d4>] (genl_rcv+0x20/0x34)
[<c05c25d4>] (genl_rcv) from [<c05c1750>] (netlink_unicast+0x11c/0x204)
[<c05c1750>] (netlink_unicast) from [<c05c1be0>] (netlink_sendmsg+0x30c/0x370)
[<c05c1be0>] (netlink_sendmsg) from [<c0587e90>] (sock_sendmsg+0x70/0x84)
[<c0587e90>] (sock_sendmsg) from [<c058970c>] (___sys_sendmsg.part.3+0x188/0x228)
[<c058970c>] (___sys_sendmsg.part.3) from [<c058a594>] (__sys_sendmsg+0x4c/0x70)
[<c058a594>] (__sys_sendmsg) from [<c0208c80>] (ret_fast_syscall+0x0/0x44)
Code: ebfffec1 e1a04000 ea00001b e5953014 (e7940003)
ath10k_pci 0000:01:00.0: SWBA overrun on vdev 0, skipped old beacon

Hardware tested: QCA9984
Firmware tested: 10.4-3.6.0.1-00004

Fixes: a904417fc ("ath10k: add extended per sta tx statistics support")
Signed-off-by: Karthikeyan Periyasamy <periyasa@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath10k/mac.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index b4764fee4751..6436dc229be5 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -6387,11 +6387,6 @@ static int ath10k_sta_state(struct ieee80211_hw *hw,
 			   "mac vdev %d peer delete %pM sta %pK (sta gone)\n",
 			   arvif->vdev_id, sta->addr, sta);
 
-		if (ath10k_debug_is_extd_tx_stats_enabled(ar)) {
-			kfree(arsta->tx_stats);
-			arsta->tx_stats = NULL;
-		}
-
 		if (sta->tdls) {
 			ret = ath10k_mac_tdls_peer_update(ar, arvif->vdev_id,
 							  sta,
@@ -6431,6 +6426,11 @@ static int ath10k_sta_state(struct ieee80211_hw *hw,
 		}
 		spin_unlock_bh(&ar->data_lock);
 
+		if (ath10k_debug_is_extd_tx_stats_enabled(ar)) {
+			kfree(arsta->tx_stats);
+			arsta->tx_stats = NULL;
+		}
+
 		for (i = 0; i < ARRAY_SIZE(sta->txq); i++)
 			ath10k_mac_txq_unref(ar, sta->txq[i]);
 
-- 
2.19.1



