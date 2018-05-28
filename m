Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165972AbeE1Oq0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 10:46:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:49400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937164AbeE1K3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:29:53 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liu Bo <bo.li.liu@oracle.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 050/329] Btrfs: set plug for fsync
Date: Mon, 28 May 2018 11:59:39 +0200
Message-Id: <20180528100246.671024036@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Liu Bo <bo.li.liu@oracle.com>

[ Upstream commit 343e4fc1c60971b0734de26dbbd475d433950982 ]

Setting plug can merge adjacent IOs before dispatching IOs to the disk
driver.

Without plug, it'd not be a problem for single disk usecases, but for
multiple disks using raid profile, a large IO can be split to several
IOs of stripe length, and plug can be helpful to bring them together
for each disk so that we can save several disk access.

Moreover, fsync issues synchronous writes, so plug can really take
effect.

Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/file.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1912,10 +1912,19 @@ int btrfs_release_file(struct inode *ino
 static int start_ordered_ops(struct inode *inode, loff_t start, loff_t end)
 {
 	int ret;
+	struct blk_plug plug;
 
+	/*
+	 * This is only called in fsync, which would do synchronous writes, so
+	 * a plug can merge adjacent IOs as much as possible.  Esp. in case of
+	 * multiple disks using raid profile, a large IO can be split to
+	 * several segments of stripe length (currently 64K).
+	 */
+	blk_start_plug(&plug);
 	atomic_inc(&BTRFS_I(inode)->sync_writers);
 	ret = btrfs_fdatawrite_range(inode, start, end);
 	atomic_dec(&BTRFS_I(inode)->sync_writers);
+	blk_finish_plug(&plug);
 
 	return ret;
 }
