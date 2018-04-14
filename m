Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751087AbeDNG3Q (ORCPT <rfc822;w@1wt.eu>);
        Sat, 14 Apr 2018 02:29:16 -0400
Received: from thorn.bewilderbeest.net ([71.19.156.171]:49820 "EHLO
        thorn.bewilderbeest.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750878AbeDNG3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Apr 2018 02:29:15 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 thorn.bewilderbeest.net 3F775804E8
From: Zev Weiss <zev@bewilderbeest.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zev Weiss <zev@bewilderbeest.net>
Subject: [PATCH] fs: avoid fdput() after failed fdget() in vfs_dedupe_file_range()
Date: Sat, 14 Apr 2018 01:16:58 -0500
Message-Id: <20180414061658.3774-1-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.16.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's a fairly inconsequential bug, since fdput() won't actually try to
fput() the file due to fd.flags (and thus FDPUT_FPUT) being zero in
the failure case, but most other vfs code takes steps to avoid this.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 fs/read_write.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index c4eabbfc90df..e83bd9744b5d 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -2023,7 +2023,7 @@ int vfs_dedupe_file_range(struct file *file, struct file_dedupe_range *same)
 		ret = mnt_want_write_file(dst_file);
 		if (ret) {
 			info->status = ret;
-			goto next_loop;
+			goto next_fdput;
 		}
 
 		dst_off = info->dest_offset;
@@ -2058,9 +2058,9 @@ int vfs_dedupe_file_range(struct file *file, struct file_dedupe_range *same)
 
 next_file:
 		mnt_drop_write_file(dst_file);
-next_loop:
+next_fdput:
 		fdput(dst_fd);
-
+next_loop:
 		if (fatal_signal_pending(current))
 			goto out;
 	}
-- 
2.16.3
