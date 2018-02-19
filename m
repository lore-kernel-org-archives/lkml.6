Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753091AbeBSOzw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 09:55:52 -0500
Received: from foss.arm.com ([217.140.101.70]:60258 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753011AbeBSOzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 09:55:47 -0500
From: Will Deacon <will.deacon@arm.com>
To: linux-fsdevel@vger.kernel.org
Cc: peterz@infradead.org, viro@zeniv.linux.org.uk, willy@infradead.org,
        linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>
Subject: [PATCH v2 2/2] fs: dcache: Use READ_ONCE when accessing i_dir_seq
Date: Mon, 19 Feb 2018 14:55:55 +0000
Message-Id: <1519052155-6361-3-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1519052155-6361-1-git-send-email-will.deacon@arm.com>
References: <1519052155-6361-1-git-send-email-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i_dir_seq is subject to concurrent modification by a cmpxchg or
store-release operation, so ensure that the relaxed access in
d_alloc_parallel uses READ_ONCE.

Reported-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 fs/dcache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index b243deec298c..5716ab04e1db 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2502,7 +2502,7 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 	}
 
 	hlist_bl_lock(b);
-	if (unlikely(parent->d_inode->i_dir_seq != seq)) {
+	if (unlikely(READ_ONCE(parent->d_inode->i_dir_seq) != seq)) {
 		hlist_bl_unlock(b);
 		rcu_read_unlock();
 		goto retry;
-- 
2.1.4
