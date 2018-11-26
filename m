Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315F5C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E83B62146F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HgY9L64l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E83B62146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbeKZVvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:51:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:32786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbeKZVve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:51:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77A1C21104;
        Mon, 26 Nov 2018 10:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543229869;
        bh=6N5BvU/wuikfm25zoVElIebjsk1AIYb3DmRBB7f2bXU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HgY9L64lDVw1x0sw0A5UarixjOBWS7YYJEIFIbKJgpaN0g3tT/GiMyFZwMO2y6JK3
         eWzByVDCUvhm+qZFLPrm6b+wwvzgOyH55NVYVrnDO3oo3Xv0piP+0tbqdKTBWqcfig
         YiaMvPxLnfCxht1STy4FvuNrm37qylQgPwgfU4Yg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Murphy <lists@colorremedies.com>,
        Qu Wenruo <wqu@suse.com>, Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 31/46] btrfs: Ensure btrfs_trim_fs can trim the whole filesystem
Date:   Mon, 26 Nov 2018 11:51:20 +0100
Message-Id: <20181126105049.067070110@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105045.447291262@linuxfoundation.org>
References: <20181126105045.447291262@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

Commit 6ba9fc8e628becf0e3ec94083450d089b0dec5f5 upstream.

[BUG]
fstrim on some btrfs only trims the unallocated space, not trimming any
space in existing block groups.

[CAUSE]
Before fstrim_range passed to btrfs_trim_fs(), it gets truncated to
range [0, super->total_bytes).  So later btrfs_trim_fs() will only be
able to trim block groups in range [0, super->total_bytes).

While for btrfs, any bytenr aligned to sectorsize is valid, since btrfs
uses its logical address space, there is nothing limiting the location
where we put block groups.

For filesystem with frequent balance, it's quite easy to relocate all
block groups and bytenr of block groups will start beyond
super->total_bytes.

In that case, btrfs will not trim existing block groups.

[FIX]
Just remove the truncation in btrfs_ioctl_fitrim(), so btrfs_trim_fs()
can get the unmodified range, which is normally set to [0, U64_MAX].

Reported-by: Chris Murphy <lists@colorremedies.com>
Fixes: f4c697e6406d ("btrfs: return EINVAL if start > total_bytes in fitrim ioctl")
CC: <stable@vger.kernel.org> # v4.9
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
[ change parameter from @fs_info to @fs_info->root for older kernel ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/extent-tree.c | 10 +---------
 fs/btrfs/ioctl.c       | 11 +++++++----
 2 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 42c4b246f749..a775307f3b6b 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -11159,21 +11159,13 @@ int btrfs_trim_fs(struct btrfs_root *root, struct fstrim_range *range)
 	u64 start;
 	u64 end;
 	u64 trimmed = 0;
-	u64 total_bytes = btrfs_super_total_bytes(fs_info->super_copy);
 	u64 bg_failed = 0;
 	u64 dev_failed = 0;
 	int bg_ret = 0;
 	int dev_ret = 0;
 	int ret = 0;
 
-	/*
-	 * try to trim all FS space, our block group may start from non-zero.
-	 */
-	if (range->len == total_bytes)
-		cache = btrfs_lookup_first_block_group(fs_info, range->start);
-	else
-		cache = btrfs_lookup_block_group(fs_info, range->start);
-
+	cache = btrfs_lookup_first_block_group(fs_info, range->start);
 	for (; cache; cache = next_block_group(fs_info->tree_root, cache)) {
 		if (cache->key.objectid >= (range->start + range->len)) {
 			btrfs_put_block_group(cache);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 96ad2778405b..242584a0d3b5 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -380,7 +380,6 @@ static noinline int btrfs_ioctl_fitrim(struct file *file, void __user *arg)
 	struct fstrim_range range;
 	u64 minlen = ULLONG_MAX;
 	u64 num_devices = 0;
-	u64 total_bytes = btrfs_super_total_bytes(fs_info->super_copy);
 	int ret;
 
 	if (!capable(CAP_SYS_ADMIN))
@@ -404,11 +403,15 @@ static noinline int btrfs_ioctl_fitrim(struct file *file, void __user *arg)
 		return -EOPNOTSUPP;
 	if (copy_from_user(&range, arg, sizeof(range)))
 		return -EFAULT;
-	if (range.start > total_bytes ||
-	    range.len < fs_info->sb->s_blocksize)
+
+	/*
+	 * NOTE: Don't truncate the range using super->total_bytes.  Bytenr of
+	 * block group is in the logical address space, which can be any
+	 * sectorsize aligned bytenr in  the range [0, U64_MAX].
+	 */
+	if (range.len < fs_info->sb->s_blocksize)
 		return -EINVAL;
 
-	range.len = min(range.len, total_bytes - range.start);
 	range.minlen = max(range.minlen, minlen);
 	ret = btrfs_trim_fs(fs_info->tree_root, &range);
 	if (ret < 0)
-- 
2.17.1



