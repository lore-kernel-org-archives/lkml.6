Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C532C282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CA97217D6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549276915;
	bh=MLqL2HM/St5VGW8nN1j/0B1d6MEQ3tm6T7XDWNqmq8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MpPm9k3hHvqmg+LQ29kUCDmeZNG6AJ3/f4f5Svx6jJIjaCFkdhun8+hW+TOxAtiJi
	 kbY9aGXuEC05MnXC7DdlePOCnGGsA3IxFbvtA3YFEf80H+6uksYWNsFhOa6m/0JAMW
	 pLCRq7aAcgXTbGWKqCeb2eRQbLvghKpxuds6ALLQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730407AbfBDKlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:41:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:39752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729759AbfBDKlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:41:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71FFB217F9;
        Mon,  4 Feb 2019 10:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549276907;
        bh=MLqL2HM/St5VGW8nN1j/0B1d6MEQ3tm6T7XDWNqmq8I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qAx5AdEa3/VX2mbwaQqZyO7P0Qwg+kr9wuNxqXw5ezuSKXtN9Ra45LzyfdO8fWZIV
         LKsHsXXLadrB/HHDaZwlEDubwDOF/ZgkwCQlwav7XGoPErIsoXW0a4b5txhemzLvjD
         R65xY+uuWf7etwLKN2xneApjCQD+tWrLkmQSTjb4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, stable@kernel.org,
        Dave Chinner <dchinner@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Aaron Lu <aaron.lu@linux.alibaba.com>
Subject: [PATCH 4.4 55/65] fs: dont scan the inode cache before SB_BORN is set
Date:   Mon,  4 Feb 2019 11:36:48 +0100
Message-Id: <20190204103619.707605776@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103610.583715954@linuxfoundation.org>
References: <20190204103610.583715954@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Aaron Lu <aaron.lu@linux.alibaba.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/super.c |   30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

--- a/fs/super.c
+++ b/fs/super.c
@@ -118,13 +118,23 @@ static unsigned long super_cache_count(s
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
+	 * is dangerous to access it.  trylock_super() uses a MS_BORN check to
+	 * avoid this situation, so do the same here. The memory barrier is
+	 * matched with the one in mount_fs() as we don't hold locks here.
 	 */
+	if (!(sb->s_flags & MS_BORN))
+		return 0;
+	smp_rmb();
+
 	if (sb->s_op && sb->s_op->nr_cached_objects)
 		total_objects = sb->s_op->nr_cached_objects(sb, sc);
 
@@ -1133,6 +1143,14 @@ mount_fs(struct file_system_type *type,
 	sb = root->d_sb;
 	BUG_ON(!sb);
 	WARN_ON(!sb->s_bdi);
+
+	/*
+	 * Write barrier is for super_cache_count(). We place it before setting
+	 * MS_BORN as the data dependency between the two functions is the
+	 * superblock structure contents that we just set up, not the MS_BORN
+	 * flag.
+	 */
+	smp_wmb();
 	sb->s_flags |= MS_BORN;
 
 	error = security_sb_kern_mount(sb, flags, secdata);


