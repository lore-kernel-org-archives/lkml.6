Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163328AbeE1KsQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:48:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:38166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163313AbeE1KsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:48:12 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alex Wu <alexwu@synology.com>,
        Chung-Chiang Cheng <cccheng@synology.com>,
        BingJing Chang <bingjingc@synology.com>,
        Shaohua Li <sh.li@alibaba-inc.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 140/496] md: fix a potential deadlock of raid5/raid10 reshape
Date: Mon, 28 May 2018 11:58:45 +0200
Message-Id: <20180528100325.824843394@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: BingJing Chang <bingjingc@synology.com>

[ Upstream commit 8876391e440ba615b10eef729576e111f0315f87 ]

There is a potential deadlock if mount/umount happens when
raid5_finish_reshape() tries to grow the size of emulated disk.

How the deadlock happens?
1) The raid5 resync thread finished reshape (expanding array).
2) The mount or umount thread holds VFS sb->s_umount lock and tries to
   write through critical data into raid5 emulated block device. So it
   waits for raid5 kernel thread handling stripes in order to finish it
   I/Os.
3) In the routine of raid5 kernel thread, md_check_recovery() will be
   called first in order to reap the raid5 resync thread. That is,
   raid5_finish_reshape() will be called. In this function, it will try
   to update conf and call VFS revalidate_disk() to grow the raid5
   emulated block device. It will try to acquire VFS sb->s_umount lock.
The raid5 kernel thread cannot continue, so no one can handle mount/
umount I/Os (stripes). Once the write-through I/Os cannot be finished,
mount/umount will not release sb->s_umount lock. The deadlock happens.

The raid5 kernel thread is an emulated block device. It is responible to
handle I/Os (stripes) from upper layers. The emulated block device
should not request any I/Os on itself. That is, it should not call VFS
layer functions. (If it did, it will try to acquire VFS locks to
guarantee the I/Os sequence.) So we have the resync thread to send
resync I/O requests and to wait for the results.

For solving this potential deadlock, we can put the size growth of the
emulated block device as the final step of reshape thread.

2017/12/29:
Thanks to Guoqing Jiang <gqjiang@suse.com>,
we confirmed that there is the same deadlock issue in raid10. It's
reproducible and can be fixed by this patch. For raid10.c, we can remove
the similar code to prevent deadlock as well since they has been called
before.

Reported-by: Alex Wu <alexwu@synology.com>
Reviewed-by: Alex Wu <alexwu@synology.com>
Reviewed-by: Chung-Chiang Cheng <cccheng@synology.com>
Signed-off-by: BingJing Chang <bingjingc@synology.com>
Signed-off-by: Shaohua Li <sh.li@alibaba-inc.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/md.c     |   13 +++++++++++++
 drivers/md/raid10.c |    8 +-------
 drivers/md/raid5.c  |    8 +-------
 3 files changed, 15 insertions(+), 14 deletions(-)

--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -8522,6 +8522,19 @@ void md_do_sync(struct md_thread *thread
 	set_mask_bits(&mddev->sb_flags, 0,
 		      BIT(MD_SB_CHANGE_PENDING) | BIT(MD_SB_CHANGE_DEVS));
 
+	if (test_bit(MD_RECOVERY_RESHAPE, &mddev->recovery) &&
+			!test_bit(MD_RECOVERY_INTR, &mddev->recovery) &&
+			mddev->delta_disks > 0 &&
+			mddev->pers->finish_reshape &&
+			mddev->pers->size &&
+			mddev->queue) {
+		mddev_lock_nointr(mddev);
+		md_set_array_sectors(mddev, mddev->pers->size(mddev, 0, 0));
+		mddev_unlock(mddev);
+		set_capacity(mddev->gendisk, mddev->array_sectors);
+		revalidate_disk(mddev->gendisk);
+	}
+
 	spin_lock(&mddev->lock);
 	if (!test_bit(MD_RECOVERY_INTR, &mddev->recovery)) {
 		/* We completed so min/max setting can be forgotten if used. */
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -4693,17 +4693,11 @@ static void raid10_finish_reshape(struct
 		return;
 
 	if (mddev->delta_disks > 0) {
-		sector_t size = raid10_size(mddev, 0, 0);
-		md_set_array_sectors(mddev, size);
 		if (mddev->recovery_cp > mddev->resync_max_sectors) {
 			mddev->recovery_cp = mddev->resync_max_sectors;
 			set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
 		}
-		mddev->resync_max_sectors = size;
-		if (mddev->queue) {
-			set_capacity(mddev->gendisk, mddev->array_sectors);
-			revalidate_disk(mddev->gendisk);
-		}
+		mddev->resync_max_sectors = mddev->array_sectors;
 	} else {
 		int d;
 		rcu_read_lock();
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -8001,13 +8001,7 @@ static void raid5_finish_reshape(struct
 
 	if (!test_bit(MD_RECOVERY_INTR, &mddev->recovery)) {
 
-		if (mddev->delta_disks > 0) {
-			md_set_array_sectors(mddev, raid5_size(mddev, 0, 0));
-			if (mddev->queue) {
-				set_capacity(mddev->gendisk, mddev->array_sectors);
-				revalidate_disk(mddev->gendisk);
-			}
-		} else {
+		if (mddev->delta_disks <= 0) {
 			int d;
 			spin_lock_irq(&conf->device_lock);
 			mddev->degraded = raid5_calc_degraded(conf);
