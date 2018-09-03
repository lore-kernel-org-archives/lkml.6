Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5B8C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 729C720658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:31:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 729C720658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730739AbeICVxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:53:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47274 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728303AbeICVxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:53:04 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C0E0AD18;
        Mon,  3 Sep 2018 17:31:54 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.18 017/123] Btrfs: fix mount failure after fsync due to hard link recreation
Date:   Mon,  3 Sep 2018 18:56:01 +0200
Message-Id: <20180903165720.219244018@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165719.499675257@linuxfoundation.org>
References: <20180903165719.499675257@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Filipe Manana <fdmanana@suse.com>

commit 0d836392cadd5535f4184d46d901a82eb276ed62 upstream.

If we end up with logging an inode reference item which has the same name
but different index from the one we have persisted, we end up failing when
replaying the log with an errno value of -EEXIST. The error comes from
btrfs_add_link(), which is called from add_inode_ref(), when we are
replaying an inode reference item.

Example scenario where this happens:

  $ mkfs.btrfs -f /dev/sdb
  $ mount /dev/sdb /mnt

  $ touch /mnt/foo
  $ ln /mnt/foo /mnt/bar

  $ sync

  # Rename the first hard link (foo) to a new name and rename the second
  # hard link (bar) to the old name of the first hard link (foo).
  $ mv /mnt/foo /mnt/qwerty
  $ mv /mnt/bar /mnt/foo

  # Create a new file, in the same parent directory, with the old name of
  # the second hard link (bar) and fsync this new file.
  # We do this instead of calling fsync on foo/qwerty because if we did
  # that the fsync resulted in a full transaction commit, not triggering
  # the problem.
  $ touch /mnt/bar
  $ xfs_io -c "fsync" /mnt/bar

  <power fail>

  $ mount /dev/sdb /mnt
  mount: mount /dev/sdb on /mnt failed: File exists

So fix this by checking if a conflicting inode reference exists (same
name, same parent but different index), removing it (and the associated
dir index entries from the parent inode) if it exists, before attempting
to add the new reference.

A test case for fstests follows soon.

CC: stable@vger.kernel.org # 4.4+
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/tree-log.c |   66 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -1291,6 +1291,46 @@ again:
 	return ret;
 }
 
+static int btrfs_inode_ref_exists(struct inode *inode, struct inode *dir,
+				  const u8 ref_type, const char *name,
+				  const int namelen)
+{
+	struct btrfs_key key;
+	struct btrfs_path *path;
+	const u64 parent_id = btrfs_ino(BTRFS_I(dir));
+	int ret;
+
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+
+	key.objectid = btrfs_ino(BTRFS_I(inode));
+	key.type = ref_type;
+	if (key.type == BTRFS_INODE_REF_KEY)
+		key.offset = parent_id;
+	else
+		key.offset = btrfs_extref_hash(parent_id, name, namelen);
+
+	ret = btrfs_search_slot(NULL, BTRFS_I(inode)->root, &key, path, 0, 0);
+	if (ret < 0)
+		goto out;
+	if (ret > 0) {
+		ret = 0;
+		goto out;
+	}
+	if (key.type == BTRFS_INODE_EXTREF_KEY)
+		ret = btrfs_find_name_in_ext_backref(path->nodes[0],
+						     path->slots[0], parent_id,
+						     name, namelen, NULL);
+	else
+		ret = btrfs_find_name_in_backref(path->nodes[0], path->slots[0],
+						 name, namelen, NULL);
+
+out:
+	btrfs_free_path(path);
+	return ret;
+}
+
 /*
  * replay one inode back reference item found in the log tree.
  * eb, slot and key refer to the buffer and key found in the log tree.
@@ -1400,6 +1440,32 @@ static noinline int add_inode_ref(struct
 				}
 			}
 
+			/*
+			 * If a reference item already exists for this inode
+			 * with the same parent and name, but different index,
+			 * drop it and the corresponding directory index entries
+			 * from the parent before adding the new reference item
+			 * and dir index entries, otherwise we would fail with
+			 * -EEXIST returned from btrfs_add_link() below.
+			 */
+			ret = btrfs_inode_ref_exists(inode, dir, key->type,
+						     name, namelen);
+			if (ret > 0) {
+				ret = btrfs_unlink_inode(trans, root,
+							 BTRFS_I(dir),
+							 BTRFS_I(inode),
+							 name, namelen);
+				/*
+				 * If we dropped the link count to 0, bump it so
+				 * that later the iput() on the inode will not
+				 * free it. We will fixup the link count later.
+				 */
+				if (!ret && inode->i_nlink == 0)
+					inc_nlink(inode);
+			}
+			if (ret < 0)
+				goto out;
+
 			/* insert our name */
 			ret = btrfs_add_link(trans, BTRFS_I(dir),
 					BTRFS_I(inode),


