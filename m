Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424598AbeE1Ljl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:39:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:60082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938099AbeE1LMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:12:21 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Coly Li <colyli@suse.de>,
        Junhui Tang <tang.junhui@zte.com.cn>, Michael Lyle <mlyle@lyle.org>,
        Hannes Reinecke <hare@suse.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 153/272] bcache: stop dc->writeback_rate_update properly
Date: Mon, 28 May 2018 12:03:06 +0200
Message-Id: <20180528100253.769262031@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Coly Li <colyli@suse.de>

[ Upstream commit 3fd47bfe55b00d5ac7b0a44c9301c07be39b1082 ]

struct delayed_work writeback_rate_update in struct cache_dev is a delayed
worker to call function update_writeback_rate() in period (the interval is
defined by dc->writeback_rate_update_seconds).

When a metadate I/O error happens on cache device, bcache error handling
routine bch_cache_set_error() will call bch_cache_set_unregister() to
retire whole cache set. On the unregister code path, this delayed work is
stopped by calling cancel_delayed_work_sync(&dc->writeback_rate_update).

dc->writeback_rate_update is a special delayed work from others in bcache.
In its routine update_writeback_rate(), this delayed work is re-armed
itself. That means when cancel_delayed_work_sync() returns, this delayed
work can still be executed after several seconds defined by
dc->writeback_rate_update_seconds.

The problem is, after cancel_delayed_work_sync() returns, the cache set
unregister code path will continue and release memory of struct cache set.
Then the delayed work is scheduled to run, __update_writeback_rate()
will reference the already released cache_set memory, and trigger a NULL
pointer deference fault.

This patch introduces two more bcache device flags,
- BCACHE_DEV_WB_RUNNING
  bit set:  bcache device is in writeback mode and running, it is OK for
            dc->writeback_rate_update to re-arm itself.
  bit clear:bcache device is trying to stop dc->writeback_rate_update,
            this delayed work should not re-arm itself and quit.
- BCACHE_DEV_RATE_DW_RUNNING
  bit set:  routine update_writeback_rate() is executing.
  bit clear: routine update_writeback_rate() quits.

This patch also adds a function cancel_writeback_rate_update_dwork() to
wait for dc->writeback_rate_update quits before cancel it by calling
cancel_delayed_work_sync(). In order to avoid a deadlock by unexpected
quit dc->writeback_rate_update, after time_out seconds this function will
give up and continue to call cancel_delayed_work_sync().

And here I explain how this patch stops self re-armed delayed work properly
with the above stuffs.

update_writeback_rate() sets BCACHE_DEV_RATE_DW_RUNNING at its beginning
and clears BCACHE_DEV_RATE_DW_RUNNING at its end. Before calling
cancel_writeback_rate_update_dwork() clear flag BCACHE_DEV_WB_RUNNING.

Before calling cancel_delayed_work_sync() wait utill flag
BCACHE_DEV_RATE_DW_RUNNING is clear. So when calling
cancel_delayed_work_sync(), dc->writeback_rate_update must be already re-
armed, or quite by seeing BCACHE_DEV_WB_RUNNING cleared. In both cases
delayed work routine update_writeback_rate() won't be executed after
cancel_delayed_work_sync() returns.

Inside update_writeback_rate() before calling schedule_delayed_work(), flag
BCACHE_DEV_WB_RUNNING is checked before. If this flag is cleared, it means
someone is about to stop the delayed work. Because flag
BCACHE_DEV_RATE_DW_RUNNING is set already and cancel_delayed_work_sync()
has to wait for this flag to be cleared, we don't need to worry about race
condition here.

If update_writeback_rate() is scheduled to run after checking
BCACHE_DEV_RATE_DW_RUNNING and before calling cancel_delayed_work_sync()
in cancel_writeback_rate_update_dwork(), it is also safe. Because at this
moment BCACHE_DEV_WB_RUNNING is cleared with memory barrier. As I mentioned
previously, update_writeback_rate() will see BCACHE_DEV_WB_RUNNING is clear
and quit immediately.

Because there are more dependences inside update_writeback_rate() to struct
cache_set memory, dc->writeback_rate_update is not a simple self re-arm
delayed work. After trying many different methods (e.g. hold dc->count, or
use locks), this is the only way I can find which works to properly stop
dc->writeback_rate_update delayed work.

Changelog:
v3: change values of BCACHE_DEV_WB_RUNNING and BCACHE_DEV_RATE_DW_RUNNING
    to bit index, for test_bit().
v2: Try to fix the race issue which is pointed out by Junhui.
v1: The initial version for review

Signed-off-by: Coly Li <colyli@suse.de>
Reviewed-by: Junhui Tang <tang.junhui@zte.com.cn>
Reviewed-by: Michael Lyle <mlyle@lyle.org>
Cc: Michael Lyle <mlyle@lyle.org>
Cc: Hannes Reinecke <hare@suse.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/bcache/bcache.h    |    9 +++++----
 drivers/md/bcache/super.c     |   38 ++++++++++++++++++++++++++++++++++----
 drivers/md/bcache/sysfs.c     |    3 ++-
 drivers/md/bcache/writeback.c |   29 ++++++++++++++++++++++++++++-
 4 files changed, 69 insertions(+), 10 deletions(-)

--- a/drivers/md/bcache/bcache.h
+++ b/drivers/md/bcache/bcache.h
@@ -258,10 +258,11 @@ struct bcache_device {
 	struct gendisk		*disk;
 
 	unsigned long		flags;
-#define BCACHE_DEV_CLOSING	0
-#define BCACHE_DEV_DETACHING	1
-#define BCACHE_DEV_UNLINK_DONE	2
-
+#define BCACHE_DEV_CLOSING		0
+#define BCACHE_DEV_DETACHING		1
+#define BCACHE_DEV_UNLINK_DONE		2
+#define BCACHE_DEV_WB_RUNNING		3
+#define BCACHE_DEV_RATE_DW_RUNNING	4
 	unsigned		nr_stripes;
 	unsigned		stripe_size;
 	atomic_t		*stripe_sectors_dirty;
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -899,6 +899,31 @@ void bch_cached_dev_run(struct cached_de
 		pr_debug("error creating sysfs link");
 }
 
+/*
+ * If BCACHE_DEV_RATE_DW_RUNNING is set, it means routine of the delayed
+ * work dc->writeback_rate_update is running. Wait until the routine
+ * quits (BCACHE_DEV_RATE_DW_RUNNING is clear), then continue to
+ * cancel it. If BCACHE_DEV_RATE_DW_RUNNING is not clear after time_out
+ * seconds, give up waiting here and continue to cancel it too.
+ */
+static void cancel_writeback_rate_update_dwork(struct cached_dev *dc)
+{
+	int time_out = WRITEBACK_RATE_UPDATE_SECS_MAX * HZ;
+
+	do {
+		if (!test_bit(BCACHE_DEV_RATE_DW_RUNNING,
+			      &dc->disk.flags))
+			break;
+		time_out--;
+		schedule_timeout_interruptible(1);
+	} while (time_out > 0);
+
+	if (time_out == 0)
+		pr_warn("give up waiting for dc->writeback_write_update to quit");
+
+	cancel_delayed_work_sync(&dc->writeback_rate_update);
+}
+
 static void cached_dev_detach_finish(struct work_struct *w)
 {
 	struct cached_dev *dc = container_of(w, struct cached_dev, detach);
@@ -911,7 +936,9 @@ static void cached_dev_detach_finish(str
 
 	mutex_lock(&bch_register_lock);
 
-	cancel_delayed_work_sync(&dc->writeback_rate_update);
+	if (test_and_clear_bit(BCACHE_DEV_WB_RUNNING, &dc->disk.flags))
+		cancel_writeback_rate_update_dwork(dc);
+
 	if (!IS_ERR_OR_NULL(dc->writeback_thread)) {
 		kthread_stop(dc->writeback_thread);
 		dc->writeback_thread = NULL;
@@ -954,6 +981,7 @@ void bch_cached_dev_detach(struct cached
 	closure_get(&dc->disk.cl);
 
 	bch_writeback_queue(dc);
+
 	cached_dev_put(dc);
 }
 
@@ -1092,14 +1120,16 @@ static void cached_dev_free(struct closu
 {
 	struct cached_dev *dc = container_of(cl, struct cached_dev, disk.cl);
 
-	cancel_delayed_work_sync(&dc->writeback_rate_update);
+	mutex_lock(&bch_register_lock);
+
+	if (test_and_clear_bit(BCACHE_DEV_WB_RUNNING, &dc->disk.flags))
+		cancel_writeback_rate_update_dwork(dc);
+
 	if (!IS_ERR_OR_NULL(dc->writeback_thread))
 		kthread_stop(dc->writeback_thread);
 	if (dc->writeback_write_wq)
 		destroy_workqueue(dc->writeback_write_wq);
 
-	mutex_lock(&bch_register_lock);
-
 	if (atomic_read(&dc->running))
 		bd_unlink_disk_holder(dc->bdev, dc->disk.disk);
 	bcache_device_free(&dc->disk);
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -309,7 +309,8 @@ STORE(bch_cached_dev)
 		bch_writeback_queue(dc);
 
 	if (attr == &sysfs_writeback_percent)
-		schedule_delayed_work(&dc->writeback_rate_update,
+		if (!test_and_set_bit(BCACHE_DEV_WB_RUNNING, &dc->disk.flags))
+			schedule_delayed_work(&dc->writeback_rate_update,
 				      dc->writeback_rate_update_seconds * HZ);
 
 	mutex_unlock(&bch_register_lock);
--- a/drivers/md/bcache/writeback.c
+++ b/drivers/md/bcache/writeback.c
@@ -115,6 +115,21 @@ static void update_writeback_rate(struct
 					     struct cached_dev,
 					     writeback_rate_update);
 
+	/*
+	 * should check BCACHE_DEV_RATE_DW_RUNNING before calling
+	 * cancel_delayed_work_sync().
+	 */
+	set_bit(BCACHE_DEV_RATE_DW_RUNNING, &dc->disk.flags);
+	/* paired with where BCACHE_DEV_RATE_DW_RUNNING is tested */
+	smp_mb();
+
+	if (!test_bit(BCACHE_DEV_WB_RUNNING, &dc->disk.flags)) {
+		clear_bit(BCACHE_DEV_RATE_DW_RUNNING, &dc->disk.flags);
+		/* paired with where BCACHE_DEV_RATE_DW_RUNNING is tested */
+		smp_mb();
+		return;
+	}
+
 	down_read(&dc->writeback_lock);
 
 	if (atomic_read(&dc->has_dirty) &&
@@ -123,8 +138,18 @@ static void update_writeback_rate(struct
 
 	up_read(&dc->writeback_lock);
 
-	schedule_delayed_work(&dc->writeback_rate_update,
+	if (test_bit(BCACHE_DEV_WB_RUNNING, &dc->disk.flags)) {
+		schedule_delayed_work(&dc->writeback_rate_update,
 			      dc->writeback_rate_update_seconds * HZ);
+	}
+
+	/*
+	 * should check BCACHE_DEV_RATE_DW_RUNNING before calling
+	 * cancel_delayed_work_sync().
+	 */
+	clear_bit(BCACHE_DEV_RATE_DW_RUNNING, &dc->disk.flags);
+	/* paired with where BCACHE_DEV_RATE_DW_RUNNING is tested */
+	smp_mb();
 }
 
 static unsigned writeback_delay(struct cached_dev *dc, unsigned sectors)
@@ -675,6 +700,7 @@ void bch_cached_dev_writeback_init(struc
 	dc->writeback_rate_p_term_inverse = 40;
 	dc->writeback_rate_i_term_inverse = 10000;
 
+	WARN_ON(test_and_clear_bit(BCACHE_DEV_WB_RUNNING, &dc->disk.flags));
 	INIT_DELAYED_WORK(&dc->writeback_rate_update, update_writeback_rate);
 }
 
@@ -693,6 +719,7 @@ int bch_cached_dev_writeback_start(struc
 		return PTR_ERR(dc->writeback_thread);
 	}
 
+	WARN_ON(test_and_set_bit(BCACHE_DEV_WB_RUNNING, &dc->disk.flags));
 	schedule_delayed_work(&dc->writeback_rate_update,
 			      dc->writeback_rate_update_seconds * HZ);
 
