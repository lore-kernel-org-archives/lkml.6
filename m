Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38AB8C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 11:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0760A2087F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 11:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545997989;
	bh=7xLWbpTNoINnohjSUok0jUwBkUcYyCNmQMx23Lvj1d0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=klYCKrsbPtb7AxUgXDvc69k9GDDjIuQg22iXlEGCRTOE8+00b22AeQIF/j+CmE5WW
	 5Zni/1+svDM4VLV2dJeuC7pJE6zm9mfQcPqny5G84AiYUIXZ2jV+xiYNVo0JS3k07Z
	 DF3q1QhkpP2XuthKg1R4kW5qkQiM0Zu8Fx5I0/Fc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbeL1LxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 06:53:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:52884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbeL1LxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 06:53:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 968F520879;
        Fri, 28 Dec 2018 11:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545997987;
        bh=7xLWbpTNoINnohjSUok0jUwBkUcYyCNmQMx23Lvj1d0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KgVUSNEB2VNpXKybolYAxh5eQTlomfhWdsMfoE/Ng8FYLXnKsMqKRqoi7B2w6FFZh
         PaTY+7lNVMCfor1t9dUV/EUnjYga3dgMPyf9dsQF0qD7Y0pVuP1bAq7ypqcxBsAkgX
         TQwwpjW6oFVaOONle9UhvcNlkSmrLj2z0BkFlmfc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dave Chinner <dchinner@redhat.com>,
        Piotr Jaroszynski <pjaroszynski@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        William Kucharski <william.kucharski@oracle.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Brian Foster <bfoster@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 01/46] iomap: Revert "fs/iomap.c: get/put the page in iomap_page_create/release()"
Date:   Fri, 28 Dec 2018 12:51:55 +0100
Message-Id: <20181228113125.027425649@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181228113124.971620049@linuxfoundation.org>
References: <20181228113124.971620049@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit a837eca2412051628c0529768c9bc4f3580b040e ]

This reverts commit 61c6de667263184125d5ca75e894fcad632b0dd3.

The reverted commit added page reference counting to iomap page
structures that are used to track block size < page size state. This
was supposed to align the code with page migration page accounting
assumptions, but what it has done instead is break XFS filesystems.
Every fstests run I've done on sub-page block size XFS filesystems
has since picking up this commit 2 days ago has failed with bad page
state errors such as:

# ./run_check.sh "-m rmapbt=1,reflink=1 -i sparse=1 -b size=1k" "generic/038"
....
SECTION       -- xfs
FSTYP         -- xfs (debug)
PLATFORM      -- Linux/x86_64 test1 4.20.0-rc6-dgc+
MKFS_OPTIONS  -- -f -m rmapbt=1,reflink=1 -i sparse=1 -b size=1k /dev/sdc
MOUNT_OPTIONS -- /dev/sdc /mnt/scratch

generic/038 454s ...
 run fstests generic/038 at 2018-12-20 18:43:05
 XFS (sdc): Unmounting Filesystem
 XFS (sdc): Mounting V5 Filesystem
 XFS (sdc): Ending clean mount
 BUG: Bad page state in process kswapd0  pfn:3a7fa
 page:ffffea0000ccbeb0 count:0 mapcount:0 mapping:ffff88800d9b6360 index:0x1
 flags: 0xfffffc0000000()
 raw: 000fffffc0000000 dead000000000100 dead000000000200 ffff88800d9b6360
 raw: 0000000000000001 0000000000000000 00000000ffffffff
 page dumped because: non-NULL mapping
 CPU: 0 PID: 676 Comm: kswapd0 Not tainted 4.20.0-rc6-dgc+ #915
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.1-1 04/01/2014
 Call Trace:
  dump_stack+0x67/0x90
  bad_page.cold.116+0x8a/0xbd
  free_pcppages_bulk+0x4bf/0x6a0
  free_unref_page_list+0x10f/0x1f0
  shrink_page_list+0x49d/0xf50
  shrink_inactive_list+0x19d/0x3b0
  shrink_node_memcg.constprop.77+0x398/0x690
  ? shrink_slab.constprop.81+0x278/0x3f0
  shrink_node+0x7a/0x2f0
  kswapd+0x34b/0x6d0
  ? node_reclaim+0x240/0x240
  kthread+0x11f/0x140
  ? __kthread_bind_mask+0x60/0x60
  ret_from_fork+0x24/0x30
 Disabling lock debugging due to kernel taint
....

The failures are from anyway that frees pages and empties the
per-cpu page magazines, so it's not a predictable failure or an easy
to debug failure.

generic/038 is a reliable reproducer of this problem - it has a 9 in
10 failure rate on one of my test machines. Failure on other
machines have been at random points in fstests runs but every run
has ended up tripping this problem. Hence generic/038 was used to
bisect the failure because it was the most reliable failure.

It is too close to the 4.20 release (not to mention holidays) to
try to diagnose, fix and test the underlying cause of the problem,
so reverting the commit is the only option we have right now. The
revert has been tested against a current tot 4.20-rc7+ kernel across
multiple machines running sub-page block size XFs filesystems and
none of the bad page state failures have been seen.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Cc: Piotr Jaroszynski <pjaroszynski@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: William Kucharski <william.kucharski@oracle.com>
Cc: Darrick J. Wong <darrick.wong@oracle.com>
Cc: Brian Foster <bfoster@redhat.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/iomap.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/fs/iomap.c b/fs/iomap.c
index 37da7a61a6c5..ec15cf2ec696 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -117,12 +117,6 @@ iomap_page_create(struct inode *inode, struct page *page)
 	atomic_set(&iop->read_count, 0);
 	atomic_set(&iop->write_count, 0);
 	bitmap_zero(iop->uptodate, PAGE_SIZE / SECTOR_SIZE);
-
-	/*
-	 * migrate_page_move_mapping() assumes that pages with private data have
-	 * their count elevated by 1.
-	 */
-	get_page(page);
 	set_page_private(page, (unsigned long)iop);
 	SetPagePrivate(page);
 	return iop;
@@ -139,7 +133,6 @@ iomap_page_release(struct page *page)
 	WARN_ON_ONCE(atomic_read(&iop->write_count));
 	ClearPagePrivate(page);
 	set_page_private(page, 0);
-	put_page(page);
 	kfree(iop);
 }
 
-- 
2.19.1



