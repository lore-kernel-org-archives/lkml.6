Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753064AbeBSOzu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 09:55:50 -0500
Received: from foss.arm.com ([217.140.101.70]:60256 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753010AbeBSOzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 09:55:47 -0500
From: Will Deacon <will.deacon@arm.com>
To: linux-fsdevel@vger.kernel.org
Cc: peterz@infradead.org, viro@zeniv.linux.org.uk, willy@infradead.org,
        linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>
Subject: [PATCH v2 1/2] fs: dcache: Avoid livelock between d_alloc_parallel and __d_add
Date: Mon, 19 Feb 2018 14:55:54 +0000
Message-Id: <1519052155-6361-2-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1519052155-6361-1-git-send-email-will.deacon@arm.com>
References: <1519052155-6361-1-git-send-email-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If d_alloc_parallel runs concurrently with __d_add, it is possible for
d_alloc_parallel to continuously retry whilst i_dir_seq has been
incremented to an odd value by __d_add:

CPU0:
__d_add
	n = start_dir_add(dir);
		cmpxchg(&dir->i_dir_seq, n, n + 1) == n

CPU1:
d_alloc_parallel
retry:
	seq = smp_load_acquire(&parent->d_inode->i_dir_seq) & ~1;
	hlist_bl_lock(b);
		bit_spin_lock(0, (unsigned long *)b); // Always succeeds

CPU0:
	__d_lookup_done(dentry)
		hlist_bl_lock
			bit_spin_lock(0, (unsigned long *)b); // Never succeeds

CPU1:
	if (unlikely(parent->d_inode->i_dir_seq != seq)) {
		hlist_bl_unlock(b);
		goto retry;
	}

Since the simple bit_spin_lock used to implement hlist_bl_lock does not
provide any fairness guarantees, then CPU1 can starve CPU0 of the lock
and prevent it from reaching end_dir_add(dir), therefore CPU1 cannot
exit its retry loop because the sequence number always has the bottom
bit set.

This patch resolves the livelock by not taking hlist_bl_lock in
d_alloc_parallel if the sequence counter is odd, since any subsequent
masked comparison with i_dir_seq will fail anyway.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Reported-by: Naresh Madhusudana <naresh.madhusudana@arm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 fs/dcache.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 7c38f39958bc..b243deec298c 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2474,7 +2474,7 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 
 retry:
 	rcu_read_lock();
-	seq = smp_load_acquire(&parent->d_inode->i_dir_seq) & ~1;
+	seq = smp_load_acquire(&parent->d_inode->i_dir_seq);
 	r_seq = read_seqbegin(&rename_lock);
 	dentry = __d_lookup_rcu(parent, name, &d_seq);
 	if (unlikely(dentry)) {
@@ -2495,6 +2495,12 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 		rcu_read_unlock();
 		goto retry;
 	}
+
+	if (unlikely(seq & 1)) {
+		rcu_read_unlock();
+		goto retry;
+	}
+
 	hlist_bl_lock(b);
 	if (unlikely(parent->d_inode->i_dir_seq != seq)) {
 		hlist_bl_unlock(b);
-- 
2.1.4
