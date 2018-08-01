Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E21C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 648072083D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:07:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 648072083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732843AbeHATyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:54:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49886 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405801AbeHATIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:08:36 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 55DDC1179;
        Wed,  1 Aug 2018 17:06:41 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 244/336] mt76: add rcu locking around tx scheduling
Date:   Wed,  1 Aug 2018 18:49:39 +0200
Message-Id: <20180801165038.400611391@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Fietkau <nbd@nbd.name>

[ Upstream commit 1d868b70e06a2319fdda46cc46ec7c6762557543 ]

Fixes a reported lockdep error in mac80211:

[  179.867321] =============================
[  179.871510] WARNING: suspicious RCU usage
[  179.875528] 4.14.32 #0 Not tainted
[  179.878924] -----------------------------
[  179.882981] backports-2017-11-01/net/mac80211/tx.c:594 suspicious rcu_dereference_check() usage!
[  179.891785]
[  179.891785] other info that might help us debug this:
[  179.891785]
[  179.899824]
[  179.899824] rcu_scheduler_active = 2, debug_locks = 1
[  179.906343] 2 locks held by ksoftirqd/0/7:
[  179.910479]  #0:  (&(&q->lock)->rlock){+.-.}, at: [<86b207a4>] mt76_dma_tx_cleanup+0x64/0x354 [mt76]
[  179.919734]  #1:  (&(&fq->lock)->rlock){+.-.}, at: [<87238410>] ieee80211_tx_dequeue+0x54/0xc3c [mac80211]
[  179.929890]
[  179.929890] stack backtrace:
[  179.934257] CPU: 0 PID: 7 Comm: ksoftirqd/0 Not tainted 4.14.32 #0
[  179.940421] Stack : 00000000 00000000 00000000 00000000 80e0fce2 00000036 00000000 00000000
[  179.948864]         87c3d24c 80696377 8061039c 00000000 00000007 00000001 87c5db78 6534689d
[  179.957306]         00000000 00000000 80e10000 87c5da74 00000001 0000015a 00000007 00000000
[  179.965748]         00000000 806a0000 000e4171 00000000 00000000 00000000 ffffffff 00000001
[  179.974189]         806c0000 8692b240 86b000d0 87316fe4 00000001 802c9a68 00000000 80700000
[  179.982632]         ...
[  179.985104] Call Trace:
[  179.987582] [<80010a48>] show_stack+0x58/0x100
[  179.992040] [<804c2c58>] dump_stack+0xe8/0x170
[  179.996868] [<87234a04>] ieee80211_tx_h_select_key+0xa8/0x5b8 [mac80211]
[  180.004299] [<87238d44>] ieee80211_tx_dequeue+0x988/0xc3c [mac80211]
[  180.011048] [<86b230dc>] mt76_txq_schedule+0x110/0x3a4 [mt76]
[  180.016821] [<86b209d0>] mt76_dma_tx_cleanup+0x290/0x354 [mt76]
[  180.022777] [<86be2e60>] mt7603_tx_tasklet+0x40/0x6c [mt7603e]
[  180.028637] [<80037058>] tasklet_action+0x110/0x1ec
[  180.033532] [<804e1dac>] __do_softirq+0x164/0x35c
[  180.038235] [<80037174>] run_ksoftirqd+0x40/0x84
[  180.042870] [<800580c8>] smpboot_thread_fn+0x1a8/0x1d8
[  180.048023] [<800542e8>] kthread+0x130/0x144
[  180.052297] [<8000b1f8>] ret_from_kernel_thread+0x14/0x1c

Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/mediatek/mt76/tx.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -422,12 +422,14 @@ void mt76_txq_schedule(struct mt76_dev *
 {
 	int len;
 
+	rcu_read_lock();
 	do {
 		if (hwq->swq_queued >= 4 || list_empty(&hwq->swq))
 			break;
 
 		len = mt76_txq_schedule_list(dev, hwq);
 	} while (len > 0);
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL_GPL(mt76_txq_schedule);
 


