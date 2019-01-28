Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316F4C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 044A12171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548691623;
	bh=L72q0sXFpHqz3P0a9KMLYZwWjigbUy86A70gzUvyUb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CxtrDP/aHLhG25SOfcQgTCKZ+a8YhIctUXfuvnIMFKxiS9o4EGOX04xSW8lmo/fB1
	 5fZKN6MmUL7EryqWxGI2S9ZFEHXQ9lTE3NN+iSk6Tg/ulXwhpaAZSr8WForMe/I2fR
	 reaYIIQ+/+VnXDz2lHglkHrGqIU5ftV5zyMYmHic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732133AbfA1QHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:07:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:56874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732111AbfA1QG7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:06:59 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3D4F21738;
        Mon, 28 Jan 2019 16:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691618;
        bh=L72q0sXFpHqz3P0a9KMLYZwWjigbUy86A70gzUvyUb0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xkJEMj7o+6y3UNX7Et2hdfKFfQX4NtXFDVXGdWwzQ7mc0nkU0jEkMMF00ycnR90bG
         ZORLfPgMcP4bLJ3FhSwJNwhY1e7LLx1fJlYK/gteg4b0UJBkOISGpnMXuvdLzAaP74
         Cjhs/8nGxdv8ScCy5AmN+bBs/tge5hAxkAp1Wxtw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>, Sasha Levin <sashal@kernel.org>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 161/258] btrfs: reada: reorder dev-replace locks before radix tree preload
Date:   Mon, 28 Jan 2019 10:57:47 -0500
Message-Id: <20190128155924.51521-161-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Sterba <dsterba@suse.com>

[ Upstream commit ceb21a8db48559fd0809e03c4df9eb37743d9170 ]

The device-replace read lock is going to use rw semaphore in followup
commits. The semaphore might sleep which is not possible in the radix
tree preload section. The lock nesting is now:

* device replace
  * radix tree preload
    * readahead spinlock

Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/reada.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/reada.c b/fs/btrfs/reada.c
index dec14b739b10..6f81f3e88b6d 100644
--- a/fs/btrfs/reada.c
+++ b/fs/btrfs/reada.c
@@ -376,26 +376,28 @@ static struct reada_extent *reada_find_extent(struct btrfs_fs_info *fs_info,
 		goto error;
 	}
 
+	/* Insert extent in reada tree + all per-device trees, all or nothing */
+	btrfs_dev_replace_read_lock(&fs_info->dev_replace);
 	ret = radix_tree_preload(GFP_KERNEL);
-	if (ret)
+	if (ret) {
+		btrfs_dev_replace_read_unlock(&fs_info->dev_replace);
 		goto error;
+	}
 
-	/* insert extent in reada_tree + all per-device trees, all or nothing */
-	btrfs_dev_replace_read_lock(&fs_info->dev_replace);
 	spin_lock(&fs_info->reada_lock);
 	ret = radix_tree_insert(&fs_info->reada_tree, index, re);
 	if (ret == -EEXIST) {
 		re_exist = radix_tree_lookup(&fs_info->reada_tree, index);
 		re_exist->refcnt++;
 		spin_unlock(&fs_info->reada_lock);
-		btrfs_dev_replace_read_unlock(&fs_info->dev_replace);
 		radix_tree_preload_end();
+		btrfs_dev_replace_read_unlock(&fs_info->dev_replace);
 		goto error;
 	}
 	if (ret) {
 		spin_unlock(&fs_info->reada_lock);
-		btrfs_dev_replace_read_unlock(&fs_info->dev_replace);
 		radix_tree_preload_end();
+		btrfs_dev_replace_read_unlock(&fs_info->dev_replace);
 		goto error;
 	}
 	radix_tree_preload_end();
-- 
2.19.1

