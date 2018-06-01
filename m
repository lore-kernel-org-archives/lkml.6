Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752629AbeFAOoU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 10:44:20 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:46134 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751777AbeFAOoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 10:44:06 -0400
X-Google-Smtp-Source: ADUXVKIMRfljU0GZV7cwlP28zDA0d/lSIZR7cBwJZPso9HMfjvWCazu7jgnZ9CRVOLWU3KEW3MkHOQ==
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        javier@cnexlabs.com, igor.j.konopko@intel.com,
        marcin.dziegielewski@intel.com,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 09/10] lightnvm: pblk: kick writer on new flush points
Date: Fri,  1 Jun 2018 16:41:13 +0200
Message-Id: <20180601144114.17490-10-mb@lightnvm.io>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180601144114.17490-1-mb@lightnvm.io>
References: <20180601144114.17490-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

Unless we kick the writer directly when setting a new flush point, the
user risks having to wait for up to one second (the default timeout for
the write thread to be kicked) for the IO to complete.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-cache.c | 10 ++++++----
 drivers/lightnvm/pblk-core.c  |  2 +-
 drivers/lightnvm/pblk-rb.c    |  4 ++--
 drivers/lightnvm/pblk.h       |  1 +
 4 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/lightnvm/pblk-cache.c b/drivers/lightnvm/pblk-cache.c
index 29a23111b31c..b1c6d7eb6115 100644
--- a/drivers/lightnvm/pblk-cache.c
+++ b/drivers/lightnvm/pblk-cache.c
@@ -44,13 +44,15 @@ int pblk_write_to_cache(struct pblk *pblk, struct bio *bio, unsigned long flags)
 		goto out;
 	}
 
-	if (unlikely(!bio_has_data(bio)))
-		goto out;
-
 	pblk_ppa_set_empty(&w_ctx.ppa);
 	w_ctx.flags = flags;
-	if (bio->bi_opf & REQ_PREFLUSH)
+	if (bio->bi_opf & REQ_PREFLUSH) {
 		w_ctx.flags |= PBLK_FLUSH_ENTRY;
+		pblk_write_kick(pblk);
+	}
+
+	if (unlikely(!bio_has_data(bio)))
+		goto out;
 
 	for (i = 0; i < nr_entries; i++) {
 		void *data = bio_data(bio);
diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 99036befb571..a5750534efed 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -322,7 +322,7 @@ int pblk_bio_add_pages(struct pblk *pblk, struct bio *bio, gfp_t flags,
 	return -1;
 }
 
-static void pblk_write_kick(struct pblk *pblk)
+void pblk_write_kick(struct pblk *pblk)
 {
 	wake_up_process(pblk->writer_ts);
 	mod_timer(&pblk->wtimer, jiffies + msecs_to_jiffies(1000));
diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
index 1b74ec51a4ad..00cd1f20a196 100644
--- a/drivers/lightnvm/pblk-rb.c
+++ b/drivers/lightnvm/pblk-rb.c
@@ -349,7 +349,7 @@ void pblk_rb_write_entry_gc(struct pblk_rb *rb, void *data,
 }
 
 static int pblk_rb_flush_point_set(struct pblk_rb *rb, struct bio *bio,
-				  unsigned int pos)
+				   unsigned int pos)
 {
 	struct pblk_rb_entry *entry;
 	unsigned int sync, flush_point;
@@ -419,7 +419,7 @@ void pblk_rb_flush(struct pblk_rb *rb)
 	if (pblk_rb_flush_point_set(rb, NULL, mem))
 		return;
 
-	pblk_write_should_kick(pblk);
+	pblk_write_kick(pblk);
 }
 
 static int pblk_rb_may_write_flush(struct pblk_rb *rb, unsigned int nr_entries,
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 725bc1bfa849..34cc1d64a9d4 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -851,6 +851,7 @@ void pblk_map_rq(struct pblk *pblk, struct nvm_rq *rqd, unsigned int sentry,
 int pblk_write_ts(void *data);
 void pblk_write_timer_fn(struct timer_list *t);
 void pblk_write_should_kick(struct pblk *pblk);
+void pblk_write_kick(struct pblk *pblk);
 
 /*
  * pblk read path
-- 
2.11.0
