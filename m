Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36AEDC71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09EC920876
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:51:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09EC920876
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbeJNXcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:32:31 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36183 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728016AbeJNXMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:12:00 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLo-0004cJ-8d; Sun, 14 Oct 2018 16:30:40 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLY-0000aH-99; Sun, 14 Oct 2018 16:30:24 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Filipe Manana" <fdmanana@suse.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.484349219@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 283/366] Btrfs: don't leave dangling dentry if
 symlink creation failed
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

commit d50866d00fb39fcf72307001763ee9cc92625a43 upstream.

When we are creating a symlink we might fail with an error after we
created its inode and added the corresponding directory indexes to its
parent inode. In this case we end up never removing the directory indexes
because the inode eviction handler, called for our symlink inode on the
final iput(), only removes items associated with the symlink inode and
not with the parent inode.

Example:

  $ mkfs.btrfs -f /dev/sdi
  $ mount /dev/sdi /mnt
  $ touch /mnt/foo
  $ ln -s /mnt/foo /mnt/bar
  ln: failed to create symbolic link ‘bar’: Cannot allocate memory
  $ umount /mnt
  $ btrfsck /dev/sdi
  Checking filesystem on /dev/sdi
  UUID: d5acb5ba-31bd-42da-b456-89dca2e716e1
  checking extents
  checking free space cache
  checking fs roots
  root 5 inode 258 errors 2001, no inode item, link count wrong
	unresolved ref dir 256 index 3 namelen 3 name bar filetype 7 errors 4, no inode ref
  found 131073 bytes used err is 1
  total csum bytes: 0
  total tree bytes: 131072
  total fs tree bytes: 32768
  total extent tree bytes: 16384
  btree space waste bytes: 124305
  file data blocks allocated: 262144
   referenced 262144
  btrfs-progs v4.2.3

So fix this by adding the directory index entries as the very last
step of symlink creation.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/btrfs/inode.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8877,10 +8877,6 @@ static int btrfs_symlink(struct inode *d
 	if (err)
 		goto out_unlock_inode;
 
-	err = btrfs_add_nondir(trans, dir, dentry, inode, 0, index);
-	if (err)
-		goto out_unlock_inode;
-
 	path = btrfs_alloc_path();
 	if (!path) {
 		err = -ENOMEM;
@@ -8918,6 +8914,13 @@ static int btrfs_symlink(struct inode *d
 	inode_set_bytes(inode, name_len);
 	btrfs_i_size_write(inode, name_len);
 	err = btrfs_update_inode(trans, root, inode);
+	/*
+	 * Last step, add directory indexes for our symlink inode. This is the
+	 * last step to avoid extra cleanup of these indexes if an error happens
+	 * elsewhere above.
+	 */
+	if (!err)
+		err = btrfs_add_nondir(trans, dir, dentry, inode, 0, index);
 	if (err) {
 		drop_inode = 1;
 		goto out_unlock_inode;

