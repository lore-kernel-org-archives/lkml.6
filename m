Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31C4C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFA4F20645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:43:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFA4F20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729104AbeJNXXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:23:47 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36184 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728019AbeJNXMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:12:00 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLo-0004cW-7S; Sun, 14 Oct 2018 16:30:40 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLY-0000Zt-56; Sun, 14 Oct 2018 16:30:24 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Chris Mason" <clm@fb.com>,
        "Filipe Manana" <fdmanana@suse.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.84278653@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 281/366] Btrfs: ensure tmpfile inode is always
 persisted with link count of 0
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Filipe Manana <fdmanana@suse.com>

commit 5762b5c958abbecb7fb9f4596a6476d1ce91ecf6 upstream.

If we open a file with O_TMPFILE, don't do any further operation on
it (so that the inode item isn't updated) and then force a transaction
commit, we get a persisted inode item with a link count of 1, and not 0
as it should be.

Steps to reproduce it (requires a modern xfs_io with -T support):

    $ mkfs.btrfs -f /dev/sdd
    $ mount -o /dev/sdd /mnt
    $ xfs_io -T /mnt &
    $ sync

Then btrfs-debug-tree shows the inode item with a link count of 1:

    $ btrfs-debug-tree /dev/sdd
    (...)
    fs tree key (FS_TREE ROOT_ITEM 0)
    leaf 29556736 items 4 free space 15851 generation 6 owner 5
    fs uuid f164d01b-1b92-481d-a4e4-435fb0f843d0
    chunk uuid 0e3d0e56-bcca-4a1c-aa5f-cec2c6f4f7a6
    	item 0 key (256 INODE_ITEM 0) itemoff 16123 itemsize 160
		inode generation 3 transid 6 size 0 block group 0 mode 40755 links 1
    	item 1 key (256 INODE_REF 256) itemoff 16111 itemsize 12
    		inode ref index 0 namelen 2 name: ..
    	item 2 key (257 INODE_ITEM 0) itemoff 15951 itemsize 160
    		inode generation 6 transid 6 size 0 block group 0 mode 100600 links 1
    	item 3 key (ORPHAN ORPHAN_ITEM 257) itemoff 15951 itemsize 0
		orphan item
    checksum tree key (CSUM_TREE ROOT_ITEM 0)
    (...)

Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Chris Mason <clm@fb.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/btrfs/inode.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5731,6 +5731,13 @@ static struct inode *btrfs_new_inode(str
 	}
 
 	/*
+	 * O_TMPFILE, set link count to 0, so that after this point,
+	 * we fill in an inode item with the correct link count.
+	 */
+	if (!name)
+		set_nlink(inode, 0);
+
+	/*
 	 * we have to initialize this early, so we can reclaim the inode
 	 * number if we fail afterwards in this function.
 	 */
@@ -9096,6 +9103,14 @@ static int btrfs_tmpfile(struct inode *d
 	if (ret)
 		goto out;
 
+	/*
+	 * We set number of links to 0 in btrfs_new_inode(), and here we set
+	 * it to 1 because d_tmpfile() will issue a warning if the count is 0,
+	 * through:
+	 *
+	 *    d_tmpfile() -> inode_dec_link_count() -> drop_nlink()
+	 */
+	set_nlink(inode, 1);
 	d_tmpfile(dentry, inode);
 	mark_inode_dirty(inode);
 

