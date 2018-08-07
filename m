Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764EBC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 346552151D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:54:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 346552151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390247AbeHGVKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:10:22 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33504 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388805AbeHGVKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:10:21 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id ABAB3D01;
        Tue,  7 Aug 2018 18:54:37 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4.14 13/21] Btrfs: fix file data corruption after cloning a range and fsync
Date:   Tue,  7 Aug 2018 20:51:27 +0200
Message-Id: <20180807172331.570202527@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180807172330.953888701@linuxfoundation.org>
References: <20180807172330.953888701@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Filipe Manana <fdmanana@suse.com>

commit bd3599a0e142cd73edd3b6801068ac3f48ac771a upstream.

When we clone a range into a file we can end up dropping existing
extent maps (or trimming them) and replacing them with new ones if the
range to be cloned overlaps with a range in the destination inode.
When that happens we add the new extent maps to the list of modified
extents in the inode's extent map tree, so that a "fast" fsync (the flag
BTRFS_INODE_NEEDS_FULL_SYNC not set in the inode) will see the extent maps
and log corresponding extent items. However, at the end of range cloning
operation we do truncate all the pages in the affected range (in order to
ensure future reads will not get stale data). Sometimes this truncation
will release the corresponding extent maps besides the pages from the page
cache. If this happens, then a "fast" fsync operation will miss logging
some extent items, because it relies exclusively on the extent maps being
present in the inode's extent tree, leading to data loss/corruption if
the fsync ends up using the same transaction used by the clone operation
(that transaction was not committed in the meanwhile). An extent map is
released through the callback btrfs_invalidatepage(), which gets called by
truncate_inode_pages_range(), and it calls __btrfs_releasepage(). The
later ends up calling try_release_extent_mapping() which will release the
extent map if some conditions are met, like the file size being greater
than 16Mb, gfp flags allow blocking and the range not being locked (which
is the case during the clone operation) nor being the extent map flagged
as pinned (also the case for cloning).

The following example, turned into a test for fstests, reproduces the
issue:

  $ mkfs.btrfs -f /dev/sdb
  $ mount /dev/sdb /mnt

  $ xfs_io -f -c "pwrite -S 0x18 9000K 6908K" /mnt/foo
  $ xfs_io -f -c "pwrite -S 0x20 2572K 156K" /mnt/bar

  $ xfs_io -c "fsync" /mnt/bar
  # reflink destination offset corresponds to the size of file bar,
  # 2728Kb minus 4Kb.
  $ xfs_io -c ""reflink ${SCRATCH_MNT}/foo 0 2724K 15908K" /mnt/bar
  $ xfs_io -c "fsync" /mnt/bar

  $ md5sum /mnt/bar
  95a95813a8c2abc9aa75a6c2914a077e  /mnt/bar

  <power fail>

  $ mount /dev/sdb /mnt
  $ md5sum /mnt/bar
  207fd8d0b161be8a84b945f0df8d5f8d  /mnt/bar
  # digest should be 95a95813a8c2abc9aa75a6c2914a077e like before the
  # power failure

In the above example, the destination offset of the clone operation
corresponds to the size of the "bar" file minus 4Kb. So during the clone
operation, the extent map covering the range from 2572Kb to 2728Kb gets
trimmed so that it ends at offset 2724Kb, and a new extent map covering
the range from 2724Kb to 11724Kb is created. So at the end of the clone
operation when we ask to truncate the pages in the range from 2724Kb to
2724Kb + 15908Kb, the page invalidation callback ends up removing the new
extent map (through try_release_extent_mapping()) when the page at offset
2724Kb is passed to that callback.

Fix this by setting the bit BTRFS_INODE_NEEDS_FULL_SYNC whenever an extent
map is removed at try_release_extent_mapping(), forcing the next fsync to
search for modified extents in the fs/subvolume tree instead of relying on
the presence of extent maps in memory. This way we can continue doing a
"fast" fsync if the destination range of a clone operation does not
overlap with an existing range or if any of the criteria necessary to
remove an extent map at try_release_extent_mapping() is not met (file
size not bigger then 16Mb or gfp flags do not allow blocking).

CC: stable@vger.kernel.org # 3.16+
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/extent_io.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4280,6 +4280,7 @@ int try_release_extent_mapping(struct ex
 	struct extent_map *em;
 	u64 start = page_offset(page);
 	u64 end = start + PAGE_SIZE - 1;
+	struct btrfs_inode *btrfs_inode = BTRFS_I(page->mapping->host);
 
 	if (gfpflags_allow_blocking(mask) &&
 	    page->mapping->host->i_size > SZ_16M) {
@@ -4302,6 +4303,8 @@ int try_release_extent_mapping(struct ex
 					    extent_map_end(em) - 1,
 					    EXTENT_LOCKED | EXTENT_WRITEBACK,
 					    0, NULL)) {
+				set_bit(BTRFS_INODE_NEEDS_FULL_SYNC,
+					&btrfs_inode->runtime_flags);
 				remove_extent_mapping(map, em);
 				/* once for the rb tree */
 				free_extent_map(em);


