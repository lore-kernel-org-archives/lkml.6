Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A3EFECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 10:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F113A208B4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 10:09:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F113A208B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbeGMKXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 06:23:17 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:54365 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbeGMKXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 06:23:17 -0400
Received: from fsav105.sakura.ne.jp (fsav105.sakura.ne.jp [27.133.134.232])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w6DA99KG086135;
        Fri, 13 Jul 2018 19:09:09 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav105.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav105.sakura.ne.jp);
 Fri, 13 Jul 2018 19:09:09 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav105.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w6DA931g086123
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 13 Jul 2018 19:09:09 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: [PATCH] fs: Add to super_blocks list after SB_BORN is set.
To:     viro@zeniv.linux.org.uk
Cc:     syzbot <syzbot+2349f5067b1772c1d8a5@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <000000000000da8a9b0570a29c01@google.com>
 <0145d376-7ef8-3e17-5a24-94de946a01e5@I-love.SAKURA.ne.jp>
 <7dc64116-f43d-3739-7b35-4eef7a80e343@I-love.SAKURA.ne.jp>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <5c3c26a9-c5ac-6f1c-1465-4127db1db9f7@I-love.SAKURA.ne.jp>
Date:   Fri, 13 Jul 2018 19:09:03 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <7dc64116-f43d-3739-7b35-4eef7a80e343@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

More simple version. Is this assumption correct?

From 52f10183f2b921cd946dd4c83d9b1d99bc48914e Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SKAURA.ne.jp>
Date: Fri, 13 Jul 2018 12:15:54 +0900
Subject: [PATCH] fs: Add to super_blocks list after SB_BORN is set.

syzbot is reporting hung tasks at iterate_supers() [1]. This is because
iterate_supers() is calling down_read(&sb->s_umount) on all superblocks
found by traversing super_blocks list while sget_userns() adds "newly
created superblock to super_blocks list with ->s_umount held by
alloc_super() for write" before "mount_fs() sets SB_BORN flag after
returning from type->mount()".

If type->mount() took long time after returning from sget() for some
reason, e.g. sync() request will be blocked on !SB_BORN superblocks.
Also, since security_sb_kern_mount() which is called after SB_BORN is
set might involve GFP_KERNEL memory allocation, we can't guarantee that
up_write(&sb->s_umount) is called as soon as SB_BORN was set.

Therefore, this patch makes sure that newly created superblock is added
to super_blocks list immediately before calling up_write(&sb->s_umount).

[1] https://syzkaller.appspot.com/bug?id=3c0c173ff55822aacb81ce7ae27a6676fba29a5c

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SKAURA.ne.jp>
---
 fs/super.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 50728d9..8b2c8cc 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -236,6 +236,7 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 	s->s_flags = flags;
 	if (s->s_user_ns != &init_user_ns)
 		s->s_iflags |= SB_I_NODEV;
+	INIT_LIST_HEAD(&s->s_list);
 	INIT_HLIST_NODE(&s->s_instances);
 	INIT_HLIST_BL_HEAD(&s->s_roots);
 	mutex_init(&s->s_sync_lock);
@@ -527,8 +528,6 @@ struct super_block *sget_userns(struct file_system_type *type,
 	}
 	s->s_type = type;
 	strlcpy(s->s_id, type->name, sizeof(s->s_id));
-	list_add_tail(&s->s_list, &super_blocks);
-	hlist_add_head(&s->s_instances, &type->fs_supers);
 	spin_unlock(&sb_lock);
 	get_filesystem(type);
 	register_shrinker_prepared(&s->s_shrink);
@@ -1305,6 +1304,12 @@ mount_fs(struct file_system_type *type, int flags, const char *name, void *data)
 	WARN((sb->s_maxbytes < 0), "%s set sb->s_maxbytes to "
 		"negative value (%lld)\n", type->name, sb->s_maxbytes);
 
+	if (list_empty(&sb->s_list)) {
+		spin_lock(&sb_lock);
+		list_add_tail(&sb->s_list, &super_blocks);
+		hlist_add_head(&sb->s_instances, &type->fs_supers);
+		spin_unlock(&sb_lock);
+	}
 	up_write(&sb->s_umount);
 	free_secdata(secdata);
 	return root;
-- 
2.7.4


