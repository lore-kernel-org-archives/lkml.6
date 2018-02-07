Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753965AbeBGMQ1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 07:16:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:39796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753478AbeBGMQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 07:16:25 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28DC32179F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=chao@kernel.org
Subject: Re: [PATCH] f2fs: add fi->commit_lock to protect commit GCed pages
To: Yunlong Song <yunlong.song@huawei.com>, jaegeuk@kernel.org,
        yuchao0@huawei.com, yunlong.song@icloud.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, shengyong1@huawei.com,
        heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <1517626068-49739-1-git-send-email-yunlong.song@huawei.com>
 <1517888990-96478-1-git-send-email-yunlong.song@huawei.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <4493cbf2-6f37-6c04-a012-4b2516b3b4e7@kernel.org>
Date: Wed, 7 Feb 2018 20:16:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1517888990-96478-1-git-send-email-yunlong.song@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/2/6 11:49, Yunlong Song wrote:
> This patch adds fi->commit_lock to avoid the case that GCed node pages
> are committed but GCed data pages are not committed. This can avoid the
> db file run into inconsistent state when sudden-power-off happens if
> data pages of atomic file is allowed to be GCed before.

do_fsync:				GC:
- mutex_lock(&fi->commit_lock);
					- lock_page()
					 - mutex_lock(&fi->commit_lock);
 - lock_page()


Well, please consider lock dependency & code complexity, IMO, reuse
fi->dio_rwsem[WRITE] will be enough as below:

---
 fs/f2fs/file.c | 3 +++
 fs/f2fs/gc.c   | 5 -----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 672a542e5464..1bdc11feb8d0 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1711,6 +1711,8 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)

 	inode_lock(inode);

+	down_write(&F2FS_I(inode)->dio_rwsem[WRITE]);
+
 	if (f2fs_is_volatile_file(inode))
 		goto err_out;

@@ -1729,6 +1731,7 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
 		ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 1, false);
 	}
 err_out:
+	up_write(&F2FS_I(inode)->dio_rwsem[WRITE]);
 	inode_unlock(inode);
 	mnt_drop_write_file(filp);
 	return ret;
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index b9d93fd532a9..e49416283563 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -622,9 +622,6 @@ static void move_data_block(struct inode *inode, block_t bidx,
 	if (!check_valid_map(F2FS_I_SB(inode), segno, off))
 		goto out;

-	if (f2fs_is_atomic_file(inode))
-		goto out;
-
 	if (f2fs_is_pinned_file(inode)) {
 		f2fs_pin_file_control(inode, true);
 		goto out;
@@ -729,8 +726,6 @@ static void move_data_page(struct inode *inode, block_t bidx, int gc_type,
 	if (!check_valid_map(F2FS_I_SB(inode), segno, off))
 		goto out;

-	if (f2fs_is_atomic_file(inode))
-		goto out;
 	if (f2fs_is_pinned_file(inode)) {
 		if (gc_type == FG_GC)
 			f2fs_pin_file_control(inode, true);
-- 
2.14.1.145.gb3622a4ee

Thanks,
