Return-Path: <00moses.alexander00@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523096515; cv=none;
        d=google.com; s=arc-20160816;
        b=qZBKpDuE/X7tpgnYkvf40e/30N7iAY9NEh6VDOSMKKx9iqUbbotYPC6R+sn6mtH71S
         MGJa8AB0a5uYSk4Mahd/YR5+VIAgjlpqvdXRYOvSUFBBEW8m5KxtXs8MswqcK4sCGnBH
         Y0EGDtp2RHNAVNqky289YC9SOzfi7tdRW8T+n2R6SmFrJR5c/r5GZg8YN/1ob+Xxwclm
         LbsZefXd9yPa5fxaor6SJOdwwZ2bN1/y16X9MSKaanrtmttFE+Kd3J6C6ptaQFoK2TB3
         9wO7F1h8c4j9XNHOdlf7c64szMcTAINUOs4SwPGdOnJLEn3BmazP7OKNcj5i1oZEj/lm
         2oeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:to
         :from:date:dkim-signature:arc-authentication-results;
        bh=YXtHPTQV0900LKoudhELokoLrfSgGbsfUiJQxPid3/8=;
        b=Happ2qCBmAwA37Ywgwqx2nW0KpYYtepEhWoE3tEHs6cFNq7zKsN9DURebbygN0IZmV
         bHxgVrB3PEc47r8vbqLG46hsSW9mosU8jqsmpbySGF24jGDYIF9wo8rChr0Y+eT8sItF
         cFGK1NpJqBs6K7f6BrcUwpQg1IOW8qlUU1hR9KnMIUcV4EFkeBWBRhNFBIe1eB3ttArc
         ezYZYy4QDwMJ0Cj0xlD0mYbWhBL+niYw6AP9N691LALZl5p+gtP0woh3HqXXlwYXsP7L
         vxYL27GsBxeNfYisaDs0Rc9UmHrp7QOREVlC33naOMjbH/6EPT8l9imfmBYPb/7Lhr1k
         wfYQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=DR8NDkYh;
       spf=pass (google.com: domain of 00moses.alexander00@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=00moses.alexander00@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=DR8NDkYh;
       spf=pass (google.com: domain of 00moses.alexander00@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=00moses.alexander00@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4+P0r/Cn1KleXEQV2mH7BVsVBmpi20l5lOuC24U4d7w9B5MWD7p+86yFyw9JPkMYN93KG49BQ==
Date: Sat, 7 Apr 2018 12:21:48 +0200
From: Alexandru Moise <00moses.alexander00@gmail.com>
To: axboe@kernel.dk, tj@kernel.org, shli@fb.com, nborisov@suse.com,
	arnd@arndb.de, gregkh@linuxfoundation.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] blk-cgroup: remove entries in blkg_tree before queue
 release
Message-ID: <20180407102148.GA9729@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597082451728716242?=
X-GMAIL-MSGID: =?utf-8?q?1597082451728716242?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The q->id is used as an index within the blkg_tree radix tree.

If the entry is not released before reclaiming the blk_queue_ida's id
blkcg_init_queue() within a different driver from which this id
was originally for can fail due to the entry at that index within
the radix tree already existing.

Signed-off-by: Alexandru Moise <00moses.alexander00@gmail.com>
---
v2: Added no-op for !CONFIG_BLK_CGROUP

 block/blk-cgroup.c         | 2 +-
 block/blk-sysfs.c          | 4 ++++
 include/linux/blk-cgroup.h | 3 +++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 1c16694ae145..224e937dbb59 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -369,7 +369,7 @@ static void blkg_destroy(struct blkcg_gq *blkg)
  *
  * Destroy all blkgs associated with @q.
  */
-static void blkg_destroy_all(struct request_queue *q)
+void blkg_destroy_all(struct request_queue *q)
 {
 	struct blkcg_gq *blkg, *n;
 
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index d00d1b0ec109..a72866458f22 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -816,6 +816,10 @@ static void __blk_release_queue(struct work_struct *work)
 	if (q->bio_split)
 		bioset_free(q->bio_split);
 
+	spin_lock_irq(q->queue_lock);
+	blkg_destroy_all(q);
+	spin_unlock_irq(q->queue_lock);
+
 	ida_simple_remove(&blk_queue_ida, q->id);
 	call_rcu(&q->rcu_head, blk_free_queue_rcu);
 }
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 6c666fd7de3c..3d60b1d1973d 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -179,6 +179,8 @@ struct blkcg_gq *blkg_lookup_create(struct blkcg *blkcg,
 int blkcg_init_queue(struct request_queue *q);
 void blkcg_drain_queue(struct request_queue *q);
 void blkcg_exit_queue(struct request_queue *q);
+void blkg_destroy_all(struct request_queue *q);
+
 
 /* Blkio controller policy registration */
 int blkcg_policy_register(struct blkcg_policy *pol);
@@ -740,6 +742,7 @@ static inline struct blkcg_gq *blkg_lookup(struct blkcg *blkcg, void *key) { ret
 static inline int blkcg_init_queue(struct request_queue *q) { return 0; }
 static inline void blkcg_drain_queue(struct request_queue *q) { }
 static inline void blkcg_exit_queue(struct request_queue *q) { }
+static inline void blkg_destroy_all(struct request_queue *q) { }
 static inline int blkcg_policy_register(struct blkcg_policy *pol) { return 0; }
 static inline void blkcg_policy_unregister(struct blkcg_policy *pol) { }
 static inline int blkcg_activate_policy(struct request_queue *q,
-- 
2.16.2
