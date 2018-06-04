Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751348AbeFDSDM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 14:03:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:55058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751213AbeFDSDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 14:03:09 -0400
From: Jeff Layton <jlayton@kernel.org>
To: viro@ZenIV.linux.org.uk, dhowells@redhat.com
Cc: willy@infradead.org, andres@anarazel.de, cmaiolino@redhat.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/5] buffer: record blockdev write errors in super_block that backs them
Date: Mon,  4 Jun 2018 14:03:01 -0400
Message-Id: <20180604180304.9662-3-jlayton@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180604180304.9662-1-jlayton@kernel.org>
References: <20180604180304.9662-1-jlayton@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Layton <jlayton@redhat.com>

When syncing out a block device (a'la __sync_blockdev), any error
encountered will only be recorded in the bd_inode's mapping. When the
blockdev contains a filesystem however, we'd like to also record the
error in the super_block that's stored there.

Make mark_buffer_write_io_error also record the error in the
corresponding super_block when a writeback error occurs and the block
device contains a mounted superblock.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/buffer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/buffer.c b/fs/buffer.c
index 249b83fafe48..dae2a857d5bc 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1117,6 +1117,8 @@ void mark_buffer_write_io_error(struct buffer_head *bh)
 		mapping_set_error(bh->b_page->mapping, -EIO);
 	if (bh->b_assoc_map)
 		mapping_set_error(bh->b_assoc_map, -EIO);
+	if (bh->b_bdev->bd_super)
+		errseq_set(&bh->b_bdev->bd_super->s_wb_err, -EIO);
 }
 EXPORT_SYMBOL(mark_buffer_write_io_error);
 
-- 
2.17.0
