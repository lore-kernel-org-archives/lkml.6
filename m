Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752781AbeEOKIj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 06:08:39 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:32028 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752636AbeEOKIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 06:08:37 -0400
Subject: [PATCH] hfsplus: don't return 0 when fill_super() failed
To: syzbot <syzbot+01ffaf5d9568dd1609f7@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
References: <001a114467485371b605691053fc@google.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <d83ce31a-874c-dd5b-f790-41405983a5be@I-love.SAKURA.ne.jp>
Date: Tue, 15 May 2018 19:08:24 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <001a114467485371b605691053fc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>From f78a5fe168290cb9e009f4d907d04b5bfe277831 Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Tue, 15 May 2018 11:38:38 +0900
Subject: [PATCH] hfsplus: don't return 0 when fill_super() failed

syzbot is reporting NULL pointer dereference at mount_fs() [1].
This is because hfsplus_fill_super() is by error returning 0 when
hfsplus_fill_super() detected invalid filesystem image, and mount_bdev()
is returning NULL because dget(s->s_root) == NULL if s->s_root == NULL,
and mount_fs() is accessing root->d_sb because IS_ERR(root) == false
if root == NULL. Fix this by returning -EINVAL when hfsplus_fill_super()
detected invalid filesystem image.

[1] https://syzkaller.appspot.com/bug?id=21acb6850cecbc960c927229e597158cf35f33d0

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: syzbot <syzbot+01ffaf5d9568dd1609f7@syzkaller.appspotmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/hfsplus/super.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 513c357..9e690ae 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -524,8 +524,10 @@ static int hfsplus_fill_super(struct super_block *sb, void *data, int silent)
 		goto out_put_root;
 	if (!hfs_brec_read(&fd, &entry, sizeof(entry))) {
 		hfs_find_exit(&fd);
-		if (entry.type != cpu_to_be16(HFSPLUS_FOLDER))
+		if (entry.type != cpu_to_be16(HFSPLUS_FOLDER)) {
+			err = -EINVAL;
 			goto out_put_root;
+		}
 		inode = hfsplus_iget(sb, be32_to_cpu(entry.folder.id));
 		if (IS_ERR(inode)) {
 			err = PTR_ERR(inode);
-- 
1.8.3.1
