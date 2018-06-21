Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B32C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 16:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48C3A214C1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 16:05:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48C3A214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933477AbeFUQFA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 12:05:00 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:38809 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932858AbeFUQE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 12:04:59 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue002 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MbXro-1foesu1O3o-00IjFn; Thu, 21 Jun 2018 18:04:24 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
        David Sterba <dsterba@suse.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Qu Wenruo <wqu@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        Liu Bo <bo.liu@linux.alibaba.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] [v2] btrfs: use monotonic time for transaction handling
Date:   Thu, 21 Jun 2018 18:04:05 +0200
Message-Id: <20180621160420.139575-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:fV6nzSuXSRbmacKeU+QH9t5xFaNCdZYxLn9F9oVABGxTE+izuNW
 8gdw1Xc6BOpBOWu1ZeyRtERsIBESn2V5hUo/QwTPUZ2UCnWKc2Mkdgcc+kWmQCbgwtxghxh
 4L6CBP1mVMMHpA0t+gZiJ33n9r41XD8rjUG9PKcEM+POGPxxQAojFMm7CcUvugHQnLedjkv
 dwvGMes4GzJaJSRAJb5dQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Twf5/40fyYI=:NQyrRvnIhPbbwckkUsApMO
 vok43N4yeGu6LMjLSXxmg3dik3gbj/cSlP3PYqryHXAcSm6eSC7gifJnplG6UYvE5c5nawr6K
 QR1hxyE6dt4xNQLuPHhtJggeu9tydafvQazA34aBMT6KaNQV/1Cq+to4L5aKA1U4QYZcXNNJc
 Xtjax6AmPUpP90UVL9XyTU/Hnahndzl2QdAJCYyA6aSNOFXq0lIxWLmNQ6I/xXrkfYYko6kiZ
 9Yk040fgFIaL2trIveIgssPPsmTjKqLiYzfyQ2t3gbuNYA8msTI9vu+BNRL+CYD4I5xD6gRyP
 sZFJ5mNe1VAvZjxfY976PfR0Ur6CZAwXt1AgP5tzOI4lZcLWs+pqFOKeTJFnPsGTUKEPyLQnD
 X61LztHvoeRjWbrFd9UrEyWJLuCbpPnoBCiVtvBGTdmUISpVMOa2S2fav/O3UNvhO7Ea/5xFy
 PavgPabk4mxSOiN3v1ThIPSO9nOTzpWXY7j8VRX6jlAAUlpjxITvBo8rfCEhPVs3yPWMG5YyV
 KOtucRMQgtabqg2IZcod0/zbOGwNzugnQljv3S12qY3BTjxLW7JTTICSE3CXLKWrs1Lx08X5A
 ebHVKfWrvu3GYgmsR48/i9UwiuTmHpajl8zC9xaKlLefaD9u7ZXx+pMJZC8NNKkaseNln79x2
 9sefOGfVjUNb6dMxc+0+O4Ips0Rn5AnIW8FJzzKQEgaGpQ8MKSagMsFTAYrBogp5YDJg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The transaction times were changed to ktime_get_real_seconds to avoid
the y2038 overflow, but they still have a minor problem when they go
backwards or jump due to settimeofday() or leap seconds.

This changes the transaction handling to instead use ktime_get_seconds(),
which returns a CLOCK_MONOTONIC timestamp that has neither of those
problems.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: Rebased on top of an earlier patch by Allen Pais, which
    also obsoleted the original patch 2/3
---
 fs/btrfs/disk-io.c     | 2 +-
 fs/btrfs/transaction.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index f3224e23d5fa..bf0717f2824d 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1819,7 +1819,7 @@ static int transaction_kthread(void *arg)
 			goto sleep;
 		}
 
-		now = ktime_get_real_seconds();
+		now = ktime_get_seconds();
 		if (cur->state < TRANS_STATE_BLOCKED &&
 		    !test_bit(BTRFS_FS_NEED_ASYNC_COMMIT, &fs_info->flags) &&
 		    (now < cur->start_time ||
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 56c8bab0b816..ebe50dfb8947 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -241,7 +241,7 @@ static noinline int join_transaction(struct btrfs_fs_info *fs_info,
 	refcount_set(&cur_trans->use_count, 2);
 	atomic_set(&cur_trans->pending_ordered, 0);
 	cur_trans->flags = 0;
-	cur_trans->start_time = ktime_get_real_seconds();
+	cur_trans->start_time = ktime_get_seconds();
 
 	memset(&cur_trans->delayed_refs, 0, sizeof(cur_trans->delayed_refs));
 
-- 
2.9.0

