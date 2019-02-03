Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00C2C4151A
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACA70218FC
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730604AbfBCOVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:21:40 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55874 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730578AbfBCOVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:21:37 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIeN-0006Sa-Ny; Sun, 03 Feb 2019 14:21:35 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9h-0007CO-68; Sun, 03 Feb 2019 14:49:53 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Nikolay Borisov" <nborisov@suse.com>,
        "David Sterba" <dsterba@suse.com>, "Qu Wenruo" <wqu@suse.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.63255968@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 197/305] btrfs: Always try all copies when reading
 extent buffers
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Nikolay Borisov <nborisov@suse.com>

commit f8397d69daef06d358430d3054662fb597e37c00 upstream.

When a metadata read is served the endio routine btree_readpage_end_io_hook
is called which eventually runs the tree-checker. If tree-checker fails
to validate the read eb then it sets EXTENT_BUFFER_CORRUPT flag. This
leads to btree_read_extent_buffer_pages wrongly assuming that all
available copies of this extent buffer are wrong and failing prematurely.
Fix this modify btree_read_extent_buffer_pages to read all copies of
the data.

This failure was exhibitted in xfstests btrfs/124 which would
spuriously fail its balance operations. The reason was that when balance
was run following re-introduction of the missing raid1 disk
__btrfs_map_block would map the read request to stripe 0, which
corresponded to devid 2 (the disk which is being removed in the test):

    item 2 key (FIRST_CHUNK_TREE CHUNK_ITEM 3553624064) itemoff 15975 itemsize 112
	length 1073741824 owner 2 stripe_len 65536 type DATA|RAID1
	io_align 65536 io_width 65536 sector_size 4096
	num_stripes 2 sub_stripes 1
		stripe 0 devid 2 offset 2156920832
		dev_uuid 8466c350-ed0c-4c3b-b17d-6379b445d5c8
		stripe 1 devid 1 offset 3553624064
		dev_uuid 1265d8db-5596-477e-af03-df08eb38d2ca

This caused read requests for a checksum item that to be routed to the
stale disk which triggered the aforementioned logic involving
EXTENT_BUFFER_CORRUPT flag. This then triggered cascading failures of
the balance operation.

Fixes: a826d6dcb32d ("Btrfs: check items for correctness as we search")
Suggested-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
[bwh: Backported to 3.16:
 - Deleted code is slightly different
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/btrfs/disk-io.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -430,9 +430,9 @@ static int btree_read_extent_buffer_page
 	int mirror_num = 0;
 	int failed_mirror = 0;
 
-	clear_bit(EXTENT_BUFFER_CORRUPT, &eb->bflags);
 	io_tree = &BTRFS_I(root->fs_info->btree_inode)->io_tree;
 	while (1) {
+		clear_bit(EXTENT_BUFFER_CORRUPT, &eb->bflags);
 		ret = read_extent_buffer_pages(io_tree, eb, start,
 					       WAIT_COMPLETE,
 					       btree_get_extent, mirror_num);
@@ -444,14 +444,6 @@ static int btree_read_extent_buffer_page
 				ret = -EIO;
 		}
 
-		/*
-		 * This buffer's crc is fine, but its contents are corrupted, so
-		 * there is no reason to read the other copies, they won't be
-		 * any less wrong.
-		 */
-		if (test_bit(EXTENT_BUFFER_CORRUPT, &eb->bflags))
-			break;
-
 		num_copies = btrfs_num_copies(root->fs_info,
 					      eb->start, eb->len);
 		if (num_copies == 1)

