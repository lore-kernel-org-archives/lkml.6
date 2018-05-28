Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165473AbeE1Nig (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:38:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:35644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937697AbeE1KpC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:45:02 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heinz Mauelshagen <heinzm@redhat.com>,
        Shaohua Li <sh.li@alibaba-inc.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 088/496] md: fix md_write_start() deadlock w/o metadata devices
Date: Mon, 28 May 2018 11:57:53 +0200
Message-Id: <20180528100323.518567561@linuxfoundation.org>
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

From: Heinz Mauelshagen <heinzm@redhat.com>

[ Upstream commit 4b6c1060eaa6495aa5b0032e8f2d51dd936b1257 ]

If no metadata devices are configured on raid1/4/5/6/10
(e.g. via dm-raid), md_write_start() unconditionally waits
for superblocks to be written thus deadlocking.

Fix introduces mddev->has_superblocks bool, defines it in md_run()
and checks for it in md_write_start() to conditionally avoid waiting.

Once on it, check for non-existing superblocks in md_super_write().

Link: https://bugzilla.kernel.org/show_bug.cgi?id=198647
Fixes: cc27b0c78c796 ("md: fix deadlock between mddev_suspend() and md_write_start()")

Signed-off-by: Heinz Mauelshagen <heinzm@redhat.com>
Signed-off-by: Shaohua Li <sh.li@alibaba-inc.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/md.c |   10 ++++++++++
 drivers/md/md.h |    2 ++
 2 files changed, 12 insertions(+)

--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -779,6 +779,9 @@ void md_super_write(struct mddev *mddev,
 	struct bio *bio;
 	int ff = 0;
 
+	if (!page)
+		return;
+
 	if (test_bit(Faulty, &rdev->flags))
 		return;
 
@@ -5434,6 +5437,7 @@ int md_run(struct mddev *mddev)
 	 * the only valid external interface is through the md
 	 * device.
 	 */
+	mddev->has_superblocks = false;
 	rdev_for_each(rdev, mddev) {
 		if (test_bit(Faulty, &rdev->flags))
 			continue;
@@ -5447,6 +5451,9 @@ int md_run(struct mddev *mddev)
 				set_disk_ro(mddev->gendisk, 1);
 		}
 
+		if (rdev->sb_page)
+			mddev->has_superblocks = true;
+
 		/* perform some consistency tests on the device.
 		 * We don't want the data to overlap the metadata,
 		 * Internal Bitmap issues have been handled elsewhere.
@@ -8022,6 +8029,7 @@ EXPORT_SYMBOL(md_done_sync);
 bool md_write_start(struct mddev *mddev, struct bio *bi)
 {
 	int did_change = 0;
+
 	if (bio_data_dir(bi) != WRITE)
 		return true;
 
@@ -8054,6 +8062,8 @@ bool md_write_start(struct mddev *mddev,
 	rcu_read_unlock();
 	if (did_change)
 		sysfs_notify_dirent_safe(mddev->sysfs_state);
+	if (!mddev->has_superblocks)
+		return true;
 	wait_event(mddev->sb_wait,
 		   !test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags) ||
 		   mddev->suspended);
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -462,6 +462,8 @@ struct mddev {
 	void (*sync_super)(struct mddev *mddev, struct md_rdev *rdev);
 	struct md_cluster_info		*cluster_info;
 	unsigned int			good_device_nr;	/* good device num within cluster raid */
+
+	bool	has_superblocks:1;
 };
 
 enum recovery_flags {
