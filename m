Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938216AbeE1L0u (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:26:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:41052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932490AbeE1LZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:25:22 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dave Chinner <dchinner@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 4.14 006/496] fs: dont scan the inode cache before SB_BORN is set
Date: Mon, 28 May 2018 11:56:31 +0200
Message-Id: <20180528100319.812996465@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Chinner <dchinner@redhat.com>

commit 79f546a696bff2590169fb5684e23d65f4d9f591 upstream.

We recently had an oops reported on a 4.14 kernel in
xfs_reclaim_inodes_count() where sb->s_fs_info pointed to garbage
and so the m_perag_tree lookup walked into lala land.  It produces
an oops down this path during the failed mount:

  radix_tree_gang_lookup_tag+0xc4/0x130
  xfs_perag_get_tag+0x37/0xf0
  xfs_reclaim_inodes_count+0x32/0x40
  xfs_fs_nr_cached_objects+0x11/0x20
  super_cache_count+0x35/0xc0
  shrink_slab.part.66+0xb1/0x370
  shrink_node+0x7e/0x1a0
  try_to_free_pages+0x199/0x470
  __alloc_pages_slowpath+0x3a1/0xd20
  __alloc_pages_nodemask+0x1c3/0x200
  cache_grow_begin+0x20b/0x2e0
  fallback_alloc+0x160/0x200
  kmem_cache_alloc+0x111/0x4e0

The problem is that the superblock shrinker is running before the
filesystem structures it depends on have been fully set up. i.e.
the shrinker is registered in sget(), before ->fill_super() has been
called, and the shrinker can call into the filesystem before
fill_super() does it's setup work. Essentially we are exposed to
both use-after-free and use-before-initialisation bugs here.

To fix this, add a check for the SB_BORN flag in super_cache_count.
In general, this flag is not set until ->fs_mount() completes
successfully, so we know that it is set after the filesystem
setup has completed. This matches the trylock_super() behaviour
which will not let super_cache_scan() run if SB_BORN is not set, and
hence will not allow the superblock shrinker from entering the
filesystem while it is being set up or after it has failed setup
and is being torn down.

Cc: stable@kernel.org
Signed-Off-By: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/super.c |   30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

--- a/fs/super.c
+++ b/fs/super.c
@@ -120,13 +120,23 @@ static unsigned long super_cache_count(s
 	sb = container_of(shrink, struct super_block, s_shrink);
 
 	/*
-	 * Don't call trylock_super as it is a potential
-	 * scalability bottleneck. The counts could get updated
-	 * between super_cache_count and super_cache_scan anyway.
-	 * Call to super_cache_count with shrinker_rwsem held
-	 * ensures the safety of call to list_lru_shrink_count() and
-	 * s_op->nr_cached_objects().
+	 * We don't call trylock_super() here as it is a scalability bottleneck,
+	 * so we're exposed to partial setup state. The shrinker rwsem does not
+	 * protect filesystem operations backing list_lru_shrink_count() or
+	 * s_op->nr_cached_objects(). Counts can change between
+	 * super_cache_count and super_cache_scan, so we really don't need locks
+	 * here.
+	 *
+	 * However, if we are currently mounting the superblock, the underlying
+	 * filesystem might be in a state of partial construction and hence it
+	 * is dangerous to access it.  trylock_super() uses a SB_BORN check to
+	 * avoid this situation, so do the same here. The memory barrier is
+	 * matched with the one in mount_fs() as we don't hold locks here.
 	 */
+	if (!(sb->s_flags & SB_BORN))
+		return 0;
+	smp_rmb();
+
 	if (sb->s_op && sb->s_op->nr_cached_objects)
 		total_objects = sb->s_op->nr_cached_objects(sb, sc);
 
@@ -1232,6 +1242,14 @@ mount_fs(struct file_system_type *type,
 	sb = root->d_sb;
 	BUG_ON(!sb);
 	WARN_ON(!sb->s_bdi);
+
+	/*
+	 * Write barrier is for super_cache_count(). We place it before setting
+	 * SB_BORN as the data dependency between the two functions is the
+	 * superblock structure contents that we just set up, not the SB_BORN
+	 * flag.
+	 */
+	smp_wmb();
 	sb->s_flags |= SB_BORN;
 
 	error = security_sb_kern_mount(sb, flags, secdata);
