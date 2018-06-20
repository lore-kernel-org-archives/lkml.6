Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A82C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92C6D20846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:35:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92C6D20846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754153AbeFTOfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 10:35:11 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:52403 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753202AbeFTOfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 10:35:10 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue103 [212.227.15.145]) with ESMTPA (Nemesis) id
 0M3dNR-1gMn0s1RQH-00rDit; Wed, 20 Jun 2018 16:34:51 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
        David Sterba <dsterba@suse.com>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Qu Wenruo <wqu@suse.com>, Nikolay Borisov <nborisov@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        Liu Bo <bo.liu@linux.alibaba.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] btrfs: use monotonic time for transaction handling
Date:   Wed, 20 Jun 2018 16:34:32 +0200
Message-Id: <20180620143448.44388-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:MtvJ2iFA9/LaYZd1ruuHDxsLXAOCr+xAiDICHrxoScZxVLigjuM
 sosnnngWe5MtmRv21mB1rybde/V8XsTaVO6retjpOUQisaav+U49EVeTlRuU8DCfuINulCy
 lCqGmA+nsE174ZEHbECaMBcs0270OuVIGuKJ7c5J6wEdW6DfXyI/v9wFE9099h4TSdveySz
 E8HcsaZTAndvMTwoyIx3A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5HUJBgJCYTw=:/J/KS3M5coxrRiZ/V+QM41
 563/SwIgYY30v+0PIYzrqyWEfykJbf9VKRgCDDMPSYE5O/+h3OIDE4+AyQMvwTnUm9YBvhEWZ
 Y2CrPzk4ru9z2gNLSLwwutuSugDNsZzzHrT1qUCKQtz5eNp8WaRPI4WvM7pSa65FUdUMOtUHz
 6ulN4nZECmO1R+ALqcmSOd0SHZ1ogoB82uqvvLglC+LI4bn9yug3gt3kivlBxnQDCnGKgIJIL
 0r17Exq3ap8c5G4rLN5Xk4mBZ4od2YSZtYFxhys5/jcNyWyqCVbgNYjyAPZnKm3YekXpI+t6Z
 unpndKUXl46tYeraToRV1WE/h8sqz2JIb22r1jVlkXK9V+gGz95QcmcbZ5KTFqTGyZXDtbVZx
 cF2xGqcpfpkjWCmmelxLhjIFWKCqMLqCHOlhBt0+5BOFJuevI534OfDc9hVFKTX1+ve/dJS4q
 1c3Ikv6wFsv9FCqgLmnEWlHYUUILBF98TLHUM7eABWzPrhx+ISWzarjSj2/CgcMTtmlP3YTXJ
 KV37v3KlbXpEXSlh5Fr2G3g6KI/gB3OQevuxvNqTqKc4DqiPEGzEMXXqMgiXJjp68b4DOKPSw
 kIteuOPAo52Ax6zWWDVNtU894/Etx3lO2jFuTVS6bYTde7e2djloVZUEbAfLWhJ5Lz9MwpkA5
 BlROkHkKJm60GsdirUK5HgVRMjVyy1Oi/oPLfXtw+owMpx7HPJgYbh0qLN5z/NaFLf4U=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_seconds() is deprecated because of the overflow of 32-bit times,
and it's not the best choice for measuring time intervals because it
can go backwards or jump due to settimeofday() or leap seconds.

This changes the transaction handling to instead use ktime_get_seconds(),
which returns a CLOCK_MONOTONIC timestamp that has neither of those
problems.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/btrfs/disk-io.c     | 4 ++--
 fs/btrfs/transaction.c | 2 +-
 fs/btrfs/transaction.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 205092dc9390..bf0717f2824d 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1803,7 +1803,7 @@ static int transaction_kthread(void *arg)
 	struct btrfs_trans_handle *trans;
 	struct btrfs_transaction *cur;
 	u64 transid;
-	unsigned long now;
+	time64_t now;
 	unsigned long delay;
 	bool cannot_commit;
 
@@ -1819,7 +1819,7 @@ static int transaction_kthread(void *arg)
 			goto sleep;
 		}
 
-		now = get_seconds();
+		now = ktime_get_seconds();
 		if (cur->state < TRANS_STATE_BLOCKED &&
 		    !test_bit(BTRFS_FS_NEED_ASYNC_COMMIT, &fs_info->flags) &&
 		    (now < cur->start_time ||
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index ff5f6c719976..ebe50dfb8947 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -241,7 +241,7 @@ static noinline int join_transaction(struct btrfs_fs_info *fs_info,
 	refcount_set(&cur_trans->use_count, 2);
 	atomic_set(&cur_trans->pending_ordered, 0);
 	cur_trans->flags = 0;
-	cur_trans->start_time = get_seconds();
+	cur_trans->start_time = ktime_get_seconds();
 
 	memset(&cur_trans->delayed_refs, 0, sizeof(cur_trans->delayed_refs));
 
diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
index 94439482a0ec..4cbb1b55387d 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -48,7 +48,7 @@ struct btrfs_transaction {
 	int aborted;
 	struct list_head list;
 	struct extent_io_tree dirty_pages;
-	unsigned long start_time;
+	time64_t start_time;
 	wait_queue_head_t writer_wait;
 	wait_queue_head_t commit_wait;
 	wait_queue_head_t pending_wait;
-- 
2.9.0

