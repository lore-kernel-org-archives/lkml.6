Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752442AbeEPJSV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 05:18:21 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36370 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751859AbeEPJRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 05:17:54 -0400
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: shli@kernel.org
Cc: robert.butera@oracle.com, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] md: zero the original position of sb for 0.90 and 1.0
Date: Wed, 16 May 2018 17:18:39 +0800
Message-Id: <1526462319-14222-1-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8894 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=631
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805160094
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For sb version 0.90 and 1.0 which locates after data, when we increase
the spindle volume size and grow the raid arry size, the older sb which is
different between spindles will be left there. Due to this left sb, the
spindle volume cannot be grown with zero filled part with  --asume-clean.
applications have to take some workarounds such as sync_min/max to avoid
resync.

It is easy and convevient for md to zero the older sb position after
write sb to new position, so do it here.

Cc: robert.butera@oracle.com
Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 drivers/md/md.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index c208c01..a042add 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -1020,6 +1020,23 @@ int md_check_no_bitmap(struct mddev *mddev)
 }
 EXPORT_SYMBOL(md_check_no_bitmap);
 
+static void md_zero_original_sb_position(struct md_rdev *rdev, sector_t old_pos)
+{
+	struct page *zero_pg;
+
+	zero_pg = alloc_pages(GFP_KERNEL | __GFP_ZERO, 0);
+	if (!zero_pg) {
+		pr_warn("%s: failed to get page for zero original sb position",
+				mdname(rdev->mddev));
+		return;
+	}
+	md_super_write(rdev->mddev, rdev, old_pos, rdev->sb_size,
+		       zero_pg);
+	wait_event(rdev->mddev->sb_wait,
+			(atomic_read(&rdev->mddev->pending_writes) == 0));
+	__free_pages(zero_pg, 0);
+}
+
 /*
  * load_super for 0.90.0
  */
@@ -1394,6 +1411,8 @@ static void super_90_sync(struct mddev *mddev, struct md_rdev *rdev)
 static unsigned long long
 super_90_rdev_size_change(struct md_rdev *rdev, sector_t num_sectors)
 {
+	sector_t old_pos = rdev->sb_start;
+
 	if (num_sectors && num_sectors < rdev->mddev->dev_sectors)
 		return 0; /* component must fit device */
 	if (rdev->mddev->bitmap_info.offset)
@@ -1411,6 +1430,8 @@ super_90_rdev_size_change(struct md_rdev *rdev, sector_t num_sectors)
 		md_super_write(rdev->mddev, rdev, rdev->sb_start, rdev->sb_size,
 		       rdev->sb_page);
 	} while (md_super_wait(rdev->mddev) < 0);
+
+	md_zero_original_sb_position(rdev, old_pos);
 	return num_sectors;
 }
 
@@ -1953,6 +1974,8 @@ super_1_rdev_size_change(struct md_rdev *rdev, sector_t num_sectors)
 {
 	struct mdp_superblock_1 *sb;
 	sector_t max_sectors;
+	sector_t old_pos = 0;
+
 	if (num_sectors && num_sectors < rdev->mddev->dev_sectors)
 		return 0; /* component must fit device */
 	if (rdev->data_offset != rdev->new_data_offset)
@@ -1969,6 +1992,7 @@ super_1_rdev_size_change(struct md_rdev *rdev, sector_t num_sectors)
 	} else {
 		/* minor version 0; superblock after data */
 		sector_t sb_start;
+		old_pos = rdev->sb_start;
 		sb_start = (i_size_read(rdev->bdev->bd_inode) >> 9) - 8*2;
 		sb_start &= ~(sector_t)(4*2 - 1);
 		max_sectors = rdev->sectors + sb_start - rdev->sb_start;
@@ -1984,6 +2008,9 @@ super_1_rdev_size_change(struct md_rdev *rdev, sector_t num_sectors)
 		md_super_write(rdev->mddev, rdev, rdev->sb_start, rdev->sb_size,
 			       rdev->sb_page);
 	} while (md_super_wait(rdev->mddev) < 0);
+
+	if (old_pos)
+		md_zero_original_sb_position(rdev, old_pos);
 	return num_sectors;
 
 }
-- 
2.7.4
