Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D769BC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A69742081B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896479;
	bh=lTMg3THqA2CkbKsfXZo5gpi/LcUlwtmTlJpslO3MT/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jb1UHrD2WVD1UzMljn+2EjSV2MjRpBWwUKKJo4Wcglg8gZxBVlRNkI7o4DxWUlvKf
	 4t99VxCJL1lqaZwkGWcfcYU9wP3jdXO5dwXCilwJo/4ocffiztI62HJWm5WncXiMxH
	 T1K9FUZfwzV2Ep130kAUCzLyMR+B4mTmqcvx05lM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387614AbfBKOr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:47:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:33046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732411AbfBKOrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:47:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B53C206BA;
        Mon, 11 Feb 2019 14:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896472;
        bh=lTMg3THqA2CkbKsfXZo5gpi/LcUlwtmTlJpslO3MT/Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iqieq3D6xv09sIdmAojU2ivdMsZWXpnT7XkJDQJZpqO99N+hWypqhxQpxDd5Lb/UY
         0I+KotoKdilr1y+g0FjUD+3bzYiFcwZY3OPLn68qLd4ZT25wh3T9O1f5VBwaTO2fdx
         YuKSu8LP0Go92301kYPstLl/apxJ13SyhWreANws=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guoqing Jiang <gqjiang@suse.com>,
        Shaohua Li <shli@fb.com>, Sasha Levin <sashal@kernel.org>,
        =?UTF-8?q?Sini=C5=A1a=20Bandin?= <sinisa@4net.rs>
Subject: [PATCH 4.19 196/313] md: fix raid10 hang issue caused by barrier
Date:   Mon, 11 Feb 2019 15:17:56 +0100
Message-Id: <20190211141906.319504867@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

[ Upstream commit e820d55cb99dd93ac2dc949cf486bb187e5cd70d ]

When both regular IO and resync IO happen at the same time,
and if we also need to split regular. Then we can see tasks
hang due to barrier.

1. resync thread
[ 1463.757205] INFO: task md1_resync:5215 blocked for more than 480 seconds.
[ 1463.757207]       Not tainted 4.19.5-1-default #1
[ 1463.757209] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1463.757212] md1_resync      D    0  5215      2 0x80000000
[ 1463.757216] Call Trace:
[ 1463.757223]  ? __schedule+0x29a/0x880
[ 1463.757231]  ? raise_barrier+0x8d/0x140 [raid10]
[ 1463.757236]  schedule+0x78/0x110
[ 1463.757243]  raise_barrier+0x8d/0x140 [raid10]
[ 1463.757248]  ? wait_woken+0x80/0x80
[ 1463.757257]  raid10_sync_request+0x1f6/0x1e30 [raid10]
[ 1463.757265]  ? _raw_spin_unlock_irq+0x22/0x40
[ 1463.757284]  ? is_mddev_idle+0x125/0x137 [md_mod]
[ 1463.757302]  md_do_sync.cold.78+0x404/0x969 [md_mod]
[ 1463.757311]  ? wait_woken+0x80/0x80
[ 1463.757336]  ? md_rdev_init+0xb0/0xb0 [md_mod]
[ 1463.757351]  md_thread+0xe9/0x140 [md_mod]
[ 1463.757358]  ? _raw_spin_unlock_irqrestore+0x2e/0x60
[ 1463.757364]  ? __kthread_parkme+0x4c/0x70
[ 1463.757369]  kthread+0x112/0x130
[ 1463.757374]  ? kthread_create_worker_on_cpu+0x40/0x40
[ 1463.757380]  ret_from_fork+0x3a/0x50

2. regular IO
[ 1463.760679] INFO: task kworker/0:8:5367 blocked for more than 480 seconds.
[ 1463.760683]       Not tainted 4.19.5-1-default #1
[ 1463.760684] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1463.760687] kworker/0:8     D    0  5367      2 0x80000000
[ 1463.760718] Workqueue: md submit_flushes [md_mod]
[ 1463.760721] Call Trace:
[ 1463.760731]  ? __schedule+0x29a/0x880
[ 1463.760741]  ? wait_barrier+0xdd/0x170 [raid10]
[ 1463.760746]  schedule+0x78/0x110
[ 1463.760753]  wait_barrier+0xdd/0x170 [raid10]
[ 1463.760761]  ? wait_woken+0x80/0x80
[ 1463.760768]  raid10_write_request+0xf2/0x900 [raid10]
[ 1463.760774]  ? wait_woken+0x80/0x80
[ 1463.760778]  ? mempool_alloc+0x55/0x160
[ 1463.760795]  ? md_write_start+0xa9/0x270 [md_mod]
[ 1463.760801]  ? try_to_wake_up+0x44/0x470
[ 1463.760810]  raid10_make_request+0xc1/0x120 [raid10]
[ 1463.760816]  ? wait_woken+0x80/0x80
[ 1463.760831]  md_handle_request+0x121/0x190 [md_mod]
[ 1463.760851]  md_make_request+0x78/0x190 [md_mod]
[ 1463.760860]  generic_make_request+0x1c6/0x470
[ 1463.760870]  raid10_write_request+0x77a/0x900 [raid10]
[ 1463.760875]  ? wait_woken+0x80/0x80
[ 1463.760879]  ? mempool_alloc+0x55/0x160
[ 1463.760895]  ? md_write_start+0xa9/0x270 [md_mod]
[ 1463.760904]  raid10_make_request+0xc1/0x120 [raid10]
[ 1463.760910]  ? wait_woken+0x80/0x80
[ 1463.760926]  md_handle_request+0x121/0x190 [md_mod]
[ 1463.760931]  ? _raw_spin_unlock_irq+0x22/0x40
[ 1463.760936]  ? finish_task_switch+0x74/0x260
[ 1463.760954]  submit_flushes+0x21/0x40 [md_mod]

So resync io is waiting for regular write io to complete to
decrease nr_pending (conf->barrier++ is called before waiting).
The regular write io splits another bio after call wait_barrier
which call nr_pending++, then the splitted bio would continue
with raid10_write_request -> wait_barrier, so the splitted bio
has to wait for barrier to be zero, then deadlock happens as
follows.

	resync io		regular io

	raise_barrier
				wait_barrier
				generic_make_request
				wait_barrier

To resolve the issue, we need to call allow_barrier to decrease
nr_pending before generic_make_request since regular IO is not
issued to underlying devices, and wait_barrier is called again
to ensure no internal IO happening.

Fixes: fc9977dd069e ("md/raid10: simplify the splitting of requests.")
Reported-and-tested-by: Siniša Bandin <sinisa@4net.rs>
Signed-off-by: Guoqing Jiang <gqjiang@suse.com>
Signed-off-by: Shaohua Li <shli@fb.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/raid10.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 811427e53126..7033a2880771 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -1208,7 +1208,9 @@ static void raid10_read_request(struct mddev *mddev, struct bio *bio,
 		struct bio *split = bio_split(bio, max_sectors,
 					      gfp, &conf->bio_split);
 		bio_chain(split, bio);
+		allow_barrier(conf);
 		generic_make_request(bio);
+		wait_barrier(conf);
 		bio = split;
 		r10_bio->master_bio = bio;
 		r10_bio->sectors = max_sectors;
@@ -1513,7 +1515,9 @@ retry_write:
 		struct bio *split = bio_split(bio, r10_bio->sectors,
 					      GFP_NOIO, &conf->bio_split);
 		bio_chain(split, bio);
+		allow_barrier(conf);
 		generic_make_request(bio);
+		wait_barrier(conf);
 		bio = split;
 		r10_bio->master_bio = bio;
 	}
-- 
2.19.1



