Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754349AbeE1JCl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 05:02:41 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35500 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754210AbeE1I7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 04:59:16 -0400
X-Google-Smtp-Source: AB8JxZor8mJAxODaC05XgxIJk1TqDk6O0yigSTI9FA5gh56PhtO1nJOR06ZD2bseaA0biFeUFBhxAA==
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Igor Konopko <igor.j.konopko@intel.com>,
        Marcin Dziegielewski <marcin.dziegielewski@intel.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 20/20] lightnvm: pblk: sync RB and RL states during GC
Date: Mon, 28 May 2018 10:58:41 +0200
Message-Id: <20180528085841.26684-21-mb@lightnvm.io>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180528085841.26684-1-mb@lightnvm.io>
References: <20180528085841.26684-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Igor Konopko <igor.j.konopko@intel.com>

During sequential workloads we can met the case when almost all the
lines are fully written with data. In that case rate limiter will
significantly reduce the max number of requests for user IOs.

Unfortunately in the case when round buffer is flushed to drive and
the entries are not yet removed (which is ok, since there is still
enough free entries in round buffer for user IO) we hang on user
IO due to not enough entries in rate limiter. The reason is that
rate limiter user entries are decreased after freeing the round
buffer entries, which does not happen if there is still plenty of
space in round buffer.

This patch forces freeing the round buffer by calling
pblk_rb_sync_l2p and thus making new free entries in rate limiter,
when there is no enough of them for user IO.

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
Signed-off-by: Marcin Dziegielewski <marcin.dziegielewski@intel.com>
Reworded description.
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-init.c | 2 ++
 drivers/lightnvm/pblk-rb.c   | 7 +++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 25aa1e73984f..9d7d9e3b8506 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -1159,7 +1159,9 @@ static void pblk_tear_down(struct pblk *pblk, bool graceful)
 		__pblk_pipeline_flush(pblk);
 	__pblk_pipeline_stop(pblk);
 	pblk_writer_stop(pblk);
+	spin_lock(&pblk->rwb.w_lock);
 	pblk_rb_sync_l2p(&pblk->rwb);
+	spin_unlock(&pblk->rwb.w_lock);
 	pblk_rl_free(&pblk->rl);
 
 	pr_debug("pblk: consistent tear down (graceful:%d)\n", graceful);
diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
index 1b74ec51a4ad..91824cd3e8d8 100644
--- a/drivers/lightnvm/pblk-rb.c
+++ b/drivers/lightnvm/pblk-rb.c
@@ -266,21 +266,18 @@ static int pblk_rb_update_l2p(struct pblk_rb *rb, unsigned int nr_entries,
  * Update the l2p entry for all sectors stored on the write buffer. This means
  * that all future lookups to the l2p table will point to a device address, not
  * to the cacheline in the write buffer.
+ * Caller must ensure that rb->w_lock is taken.
  */
 void pblk_rb_sync_l2p(struct pblk_rb *rb)
 {
 	unsigned int sync;
 	unsigned int to_update;
 
-	spin_lock(&rb->w_lock);
-
 	/* Protect from reads and writes */
 	sync = smp_load_acquire(&rb->sync);
 
 	to_update = pblk_rb_ring_count(sync, rb->l2p_update, rb->nr_entries);
 	__pblk_rb_update_l2p(rb, to_update);
-
-	spin_unlock(&rb->w_lock);
 }
 
 /*
@@ -462,6 +459,8 @@ int pblk_rb_may_write_user(struct pblk_rb *rb, struct bio *bio,
 	spin_lock(&rb->w_lock);
 	io_ret = pblk_rl_user_may_insert(&pblk->rl, nr_entries);
 	if (io_ret) {
+		/* Sync RB & L2P in order to update rate limiter values */
+		pblk_rb_sync_l2p(rb);
 		spin_unlock(&rb->w_lock);
 		return io_ret;
 	}
-- 
2.11.0
