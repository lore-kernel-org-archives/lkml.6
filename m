Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932985AbeCJHET (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 02:04:19 -0500
Received: from mga12.intel.com ([192.55.52.136]:32510 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932918AbeCJHEL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 02:04:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,449,1515484800";
   d="scan'208";a="40758304"
Subject: [PATCH v5 03/11] ext4, dax: introduce ext4_dax_aops
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>, david@fromorbit.com, hch@lst.de,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, jack@suse.cz,
        ross.zwisler@linux.intel.com, hch@lst.de, linux-kernel@vger.kernel.org
Date: Fri, 09 Mar 2018 22:55:05 -0800
Message-ID: <152066490498.40260.13597428016512482129.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <152066488891.40260.14605734226832760468.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <152066488891.40260.14605734226832760468.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for the dax implementation to start associating dax pages
to inodes via page->mapping, we need to provide a 'struct
address_space_operations' instance for dax. Otherwise, direct-I/O
triggers incorrect page cache assumptions and warnings.

Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>
Cc: linux-ext4@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 fs/ext4/inode.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index c94780075b04..ef21f0ad38ff 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3946,6 +3946,13 @@ static const struct address_space_operations ext4_da_aops = {
 	.error_remove_page	= generic_error_remove_page,
 };
 
+static const struct address_space_operations ext4_dax_aops = {
+	.writepages		= ext4_writepages,
+	.direct_IO		= ext4_direct_IO,
+	.set_page_dirty		= dax_set_page_dirty,
+	.invalidatepage		= dax_invalidatepage,
+};
+
 void ext4_set_aops(struct inode *inode)
 {
 	switch (ext4_inode_journal_mode(inode)) {
@@ -3958,7 +3965,9 @@ void ext4_set_aops(struct inode *inode)
 	default:
 		BUG();
 	}
-	if (test_opt(inode->i_sb, DELALLOC))
+	if (IS_DAX(inode))
+		inode->i_mapping->a_ops = &ext4_dax_aops;
+	else if (test_opt(inode->i_sb, DELALLOC))
 		inode->i_mapping->a_ops = &ext4_da_aops;
 	else
 		inode->i_mapping->a_ops = &ext4_aops;
