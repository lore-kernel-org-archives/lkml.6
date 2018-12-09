Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC88C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16F7620661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:01:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16F7620661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbeLIWBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:01:45 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35938 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726675AbeLIVzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:33 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72w-0002pr-Ox; Sun, 09 Dec 2018 21:55:31 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72j-0003bw-F5; Sun, 09 Dec 2018 21:55:17 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Coly Li" <colyli@suse.de>,
        "Guoju Fang" <fangguoju@gmail.com>, "Jens Axboe" <axboe@kernel.dk>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.547842377@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 269/328] bcache: add separate workqueue for
 journal_write to avoid deadlock
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Guoju Fang <fangguoju@gmail.com>

commit 0f843e65d9eef4936929bb036c5f771fb261eea4 upstream.

After write SSD completed, bcache schedules journal_write work to
system_wq, which is a public workqueue in system, without WQ_MEM_RECLAIM
flag. system_wq is also a bound wq, and there may be no idle kworker on
current processor. Creating a new kworker may unfortunately need to
reclaim memory first, by shrinking cache and slab used by vfs, which
depends on bcache device. That's a deadlock.

This patch create a new workqueue for journal_write with WQ_MEM_RECLAIM
flag. It's rescuer thread will work to avoid the deadlock.

Signed-off-by: Guoju Fang <fangguoju@gmail.com>
Signed-off-by: Coly Li <colyli@suse.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/md/bcache/bcache.h  | 1 +
 drivers/md/bcache/journal.c | 6 +++---
 drivers/md/bcache/super.c   | 8 ++++++++
 3 files changed, 12 insertions(+), 3 deletions(-)

--- a/drivers/md/bcache/bcache.h
+++ b/drivers/md/bcache/bcache.h
@@ -898,6 +898,7 @@ void bch_prio_write(struct cache *);
 void bch_write_bdev_super(struct cached_dev *, struct closure *);
 
 extern struct workqueue_struct *bcache_wq;
+extern struct workqueue_struct *bch_journal_wq;
 extern const char * const bch_cache_modes[];
 extern struct mutex bch_register_lock;
 extern struct list_head bch_cache_sets;
--- a/drivers/md/bcache/journal.c
+++ b/drivers/md/bcache/journal.c
@@ -454,7 +454,7 @@ static void do_journal_discard(struct ca
 
 		closure_get(&ca->set->cl);
 		INIT_WORK(&ja->discard_work, journal_discard_work);
-		schedule_work(&ja->discard_work);
+		queue_work(bch_journal_wq, &ja->discard_work);
 	}
 }
 
@@ -559,7 +559,7 @@ static void journal_write_done(struct cl
 		: &j->w[0];
 
 	__closure_wake_up(&w->wait);
-	continue_at_nobarrier(cl, journal_write, system_wq);
+	continue_at_nobarrier(cl, journal_write, bch_journal_wq);
 }
 
 static void journal_write_unlock(struct closure *cl)
@@ -592,7 +592,7 @@ static void journal_write_unlocked(struc
 		spin_unlock(&c->journal.lock);
 
 		btree_flush_write(c);
-		continue_at(cl, journal_write, system_wq);
+		continue_at(cl, journal_write, bch_journal_wq);
 		return;
 	}
 
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -56,6 +56,7 @@ static int bcache_major;
 static DEFINE_IDA(bcache_minor);
 static wait_queue_head_t unregister_wait;
 struct workqueue_struct *bcache_wq;
+struct workqueue_struct *bch_journal_wq;
 
 #define BTREE_MAX_PAGES		(256 * 1024 / PAGE_SIZE)
 
@@ -2112,6 +2113,9 @@ static void bcache_exit(void)
 		kobject_put(bcache_kobj);
 	if (bcache_wq)
 		destroy_workqueue(bcache_wq);
+	if (bch_journal_wq)
+		destroy_workqueue(bch_journal_wq);
+
 	if (bcache_major)
 		unregister_blkdev(bcache_major, "bcache");
 	unregister_reboot_notifier(&reboot);
@@ -2142,6 +2146,10 @@ static int __init bcache_init(void)
 	if (!bcache_wq)
 		goto err;
 
+	bch_journal_wq = alloc_workqueue("bch_journal", WQ_MEM_RECLAIM, 0);
+	if (!bch_journal_wq)
+		goto err;
+
 	bcache_kobj = kobject_create_and_add("bcache", fs_kobj);
 	if (!bcache_kobj)
 		goto err;

