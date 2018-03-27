Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752197AbeC0BvA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 21:51:00 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:40555 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751714AbeC0Bu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 21:50:59 -0400
To: Andrew Morton <akpm@linux-foundation.org>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>, Latchesar Ionkov <lucho@ionkov.net>
CC: <linux-kernel@vger.kernel.org>, <v9fs-developer@lists.sourceforge.net>,
        Greg Kurz <groug@kaod.org>
From: jiangyiwen <jiangyiwen@huawei.com>
Subject: [V9fs-developer] [PATCH] fs/9p: don't set SB_NOATIME by default
Message-ID: <5AB9A377.6080906@huawei.com>
Date: Tue, 27 Mar 2018 09:50:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.16.168]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

User use some syscall, for example mmap(v9fs_file_mmap), it will not
update atime even if user's mnt_flags without MNT_NOATIME, because
v9fs default set SB_NOATIME in v9fs_set_super.

For supporting access time is updated when user mount with relatime,
we should not set SB_NOATIME by default.

Signed-off-by: Yiwen Jiang <jiangyiwen@huawei.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 fs/9p/vfs_super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index af03c2a..48ce504 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -94,7 +94,7 @@ static int v9fs_set_super(struct super_block *s, void *data)
 	if (v9ses->cache)
 		sb->s_bdi->ra_pages = (VM_MAX_READAHEAD * 1024)/PAGE_SIZE;

-	sb->s_flags |= SB_ACTIVE | SB_DIRSYNC | SB_NOATIME;
+	sb->s_flags |= SB_ACTIVE | SB_DIRSYNC;
 	if (!v9ses->cache)
 		sb->s_flags |= SB_SYNCHRONOUS;

-- 
1.8.3.1
