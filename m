Return-Path: <00moses.alexander00@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523027217; cv=none;
        d=google.com; s=arc-20160816;
        b=OCQboJYWz3Nffy2ZnGvfvPV2SRYWNAHcG0dzOUr1RNwlHGtO32RuxJgHNU3BoVukxI
         3p7qTIXlTFv4rV7nKmHoW0w1lkDFyiBi0O0wCc4Fc0D/0AyRj1s8AHZxwyxxJEMveRkQ
         bnxxADdAA1spld1cfPxf7FdzWHmfhQhby257pm6BbhaUvkT6XD+LFtjhFP7PGLhX2R7f
         3ZnEukDCO+uBT/9s0HhlMQzUUqDQ+ZH6n+YHqVJOOgrSLSVrxao+/EigSlw6PUvugLmY
         7uzDDCcVc+rcUrOpWYNOhuPOWXHibK7X2RBhEvLEslsUnAIoHPpByx5bcda/OkYrHbnh
         lQgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:to
         :from:date:dkim-signature:arc-authentication-results;
        bh=j41Ybz+SujReRFFrtA2hus3batPBhCeTThVsguqDTO8=;
        b=B6Ek1hESkk/HSYFTYt1oT+5qjoxDPChdX8UbKEJr4wHE0efXyk/CU11jCMC1jtsrET
         SBvk/1EVbwH8RFuOxAXMuYkNiyD3nBkcbDu3gSe1hiHBVRtKkrsc7XjIbCGX8M6o1sfm
         j5t5Rql7L80jOCnhy+m7qfz55FLcMQ4U2cvamO9ijBX/uIOcxxGOn2OPusghXHZMKi86
         E7jLNgiI3yY/natYEHzKAhCX7c6mhoOzg0mNAjBMFHIKELL62CmsVjTfQrynpziWONpX
         HHPilk+JhmuxgO+z4hecJ01+rXFF9pZtrDFSr13WCaQ+i5nbR6MVlwGunE8qqJTRIBPp
         LniQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=WG2rFGZ1;
       spf=pass (google.com: domain of 00moses.alexander00@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=00moses.alexander00@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=WG2rFGZ1;
       spf=pass (google.com: domain of 00moses.alexander00@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=00moses.alexander00@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4/49ENuP/tYNGnvHSogUcuoqpzpnuhP5FxrQ/vulThpcy6BPFy2FOMGQSJbHpC8DTLqbHJKeQ==
Date: Fri, 6 Apr 2018 17:06:50 +0200
From: Alexandru Moise <00moses.alexander00@gmail.com>
To: axboe@kernel.dk, tj@kernel.org, shli@fb.com, pombredanne@nexb.com,
	gregkh@linuxfoundation.org, joseph.qi@linux.alibaba.com,
	nborisov@suse.com, arnd@arndb.de, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] blk-cgroup: remove entries in blkg_tree before queue release
Message-ID: <20180406150648.GA6378@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597009788051642180?=
X-GMAIL-MSGID: =?utf-8?q?1597009788051642180?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The q->id is used as an index within the blkg_tree radix tree.

If the entry is not released before reclaiming the blk_queue_ida's id
blkcg_init_queue() within a different driver from which this id
was originally for can fail due to the entry at that index within
the radix tree already existing.

Signed-off-by: Alexandru Moise <00moses.alexander00@gmail.com>
---
 block/blk-cgroup.c         | 2 +-
 block/blk-sysfs.c          | 4 ++++
 include/linux/blk-cgroup.h | 2 ++
 3 files changed, 7 insertions(+), 1 deletion(-)

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
index 6c666fd7de3c..4470fdb6ea8f 100644
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
-- 
2.16.3
