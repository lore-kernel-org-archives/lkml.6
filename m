Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751312AbeDDKyc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 06:54:32 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:55874 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750827AbeDDKya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 06:54:30 -0400
Subject: Re: WARNING in kill_block_super
To: viro@zeniv.linux.org.uk, Michal Hocko <mhocko@suse.com>
References: <001a114043bcfab6ab05689518f9@google.com>
Cc: syzbot <syzbot+5a170e19c963a2e0df79@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, linux-mm <linux-mm@kvack.org>,
        Dmitry Vyukov <dvyukov@google.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <6c95e826-4b9f-fb21-b311-830411e58480@I-love.SAKURA.ne.jp>
Date: Wed, 4 Apr 2018 19:53:07 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <001a114043bcfab6ab05689518f9@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Al and Michal, are you OK with this patch?


>From bbc0d00935ebcb7e287403bae545fae9340830d9 Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Wed, 4 Apr 2018 12:19:42 +0900
Subject: [PATCH] mm,vmscan: Allow preallocating memory for register_shrinker().

syzbot is catching so many bugs triggered by commit 9ee332d99e4d5a97
("sget(): handle failures of register_shrinker()"). That commit expected
that calling kill_sb() from deactivate_locked_super() without successful
fill_super() is safe, but the reality was different; some callers assign
attributes which are needed for kill_sb() after sget() succeeds.

For example, [1] is a report where sb->s_mode (which seems to be either
FMODE_READ | FMODE_EXCL | FMODE_WRITE or FMODE_READ | FMODE_EXCL) is not
assigned unless sget() succeeds. But it does not worth complicate sget()
so that register_shrinker() failure path can safely call
kill_block_super() via kill_sb(). Making alloc_super() fail if memory
allocation for register_shrinker() failed is much simpler. Let's avoid
calling deactivate_locked_super() from sget_userns() by preallocating
memory for the shrinker and making register_shrinker() in sget_userns()
never fail.

[1] https://syzkaller.appspot.com/bug?id=588996a25a2587be2e3a54e8646728fb9cae44e7

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: syzbot <syzbot+5a170e19c963a2e0df79@syzkaller.appspotmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Michal Hocko <mhocko@suse.com>
---
 fs/super.c               |  9 ++++-----
 include/linux/shrinker.h |  6 ++++--
 mm/vmscan.c              | 15 ++++++++++++++-
 3 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 672538c..db00f67 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -166,6 +166,7 @@ static void destroy_unused_super(struct super_block *s)
 	security_sb_free(s);
 	put_user_ns(s->s_user_ns);
 	kfree(s->s_subtype);
+	kfree(s->s_shrink.nr_deferred);
 	/* no delays needed */
 	destroy_super_work(&s->destroy_work);
 }
@@ -251,6 +252,8 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 	s->s_shrink.count_objects = super_cache_count;
 	s->s_shrink.batch = 1024;
 	s->s_shrink.flags = SHRINKER_NUMA_AWARE | SHRINKER_MEMCG_AWARE;
+	if (prepare_shrinker(&s->s_shrink))
+		goto fail;
 	return s;
 
 fail:
@@ -517,11 +520,7 @@ struct super_block *sget_userns(struct file_system_type *type,
 	hlist_add_head(&s->s_instances, &type->fs_supers);
 	spin_unlock(&sb_lock);
 	get_filesystem(type);
-	err = register_shrinker(&s->s_shrink);
-	if (err) {
-		deactivate_locked_super(s);
-		s = ERR_PTR(err);
-	}
+	register_shrinker_prepared(&s->s_shrink);
 	return s;
 }
 
diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index 388ff29..2728918 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -75,6 +75,8 @@ struct shrinker {
 #define SHRINKER_NUMA_AWARE	(1 << 0)
 #define SHRINKER_MEMCG_AWARE	(1 << 1)
 
-extern int register_shrinker(struct shrinker *);
-extern void unregister_shrinker(struct shrinker *);
+extern int prepare_shrinker(struct shrinker *shrinker);
+extern void register_shrinker_prepared(struct shrinker *shrinker);
+extern int register_shrinker(struct shrinker *shrinker);
+extern void unregister_shrinker(struct shrinker *shrinker);
 #endif
diff --git a/mm/vmscan.c b/mm/vmscan.c
index cd5dc3f..a10fe8e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -258,7 +258,7 @@ unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru, int zone
 /*
  * Add a shrinker callback to be called from the vm.
  */
-int register_shrinker(struct shrinker *shrinker)
+int prepare_shrinker(struct shrinker *shrinker)
 {
 	size_t size = sizeof(*shrinker->nr_deferred);
 
@@ -268,10 +268,23 @@ int register_shrinker(struct shrinker *shrinker)
 	shrinker->nr_deferred = kzalloc(size, GFP_KERNEL);
 	if (!shrinker->nr_deferred)
 		return -ENOMEM;
+	return 0;
+}
 
+void register_shrinker_prepared(struct shrinker *shrinker)
+{
 	down_write(&shrinker_rwsem);
 	list_add_tail(&shrinker->list, &shrinker_list);
 	up_write(&shrinker_rwsem);
+}
+
+int register_shrinker(struct shrinker *shrinker)
+{
+	int err = prepare_shrinker(shrinker);
+
+	if (err)
+		return err;
+	register_shrinker_prepared(shrinker);
 	return 0;
 }
 EXPORT_SYMBOL(register_shrinker);
-- 
1.8.3.1
