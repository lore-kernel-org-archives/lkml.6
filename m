Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752352AbeE0WZP (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 18:25:15 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42405 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751582AbeE0WZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 18:25:14 -0400
From: Colin King <colin.king@canonical.com>
To: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] dm writecache: fix missing goto in error handling code
Date: Sun, 27 May 2018 23:25:12 +0100
Message-Id: <20180527222512.25280-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently, the -EFBIG error condition when n_bitmaps_bits is
too large is falling through to the next statement and the
error assignment to r is potentially being ignored.  The code
should be exiting to the error path via label 'bad'. Fix
this by adding the missing goto statement.

Detected by CoverityScan, CID#1469377 ("Unused value")

Fixes: bb15b431d650 ("dm: add writecache target")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/md/dm-writecache.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index 1ef06e738eb6..e61704b6eae1 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -2077,6 +2077,7 @@ static int writecache_ctr(struct dm_target *ti, unsigned argc, char **argv)
 		if (n_bitmap_bits > 1U << 31) {
 			r = -EFBIG;
 			ti->error = "Invalid device size";
+			goto bad;
 		}
 
 		wc->memory_map = vmalloc(n_metadata_blocks << wc->block_size_bits);
-- 
2.17.0
