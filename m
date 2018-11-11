Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C878EC0044C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E60C20817
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wjzk1uEw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E60C20817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389986AbeKLJFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:05:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:49358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389848AbeKLIVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:21:42 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6011224E0;
        Sun, 11 Nov 2018 22:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975504;
        bh=GFxQaXkPknXLXowH7xr7qDCAh9P/w813ftUsdWVUglU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wjzk1uEwwmCmb302emms2xXg19mpVFnC22KIzHgwH3rOob9xK+LvgdXqhblfQevpF
         yjT3lOOl0/DmlSwWwBCbEJBc3uZkhNxoFll/P5i9maEP1j/rYMrnRihxwCBSCc8KIg
         TkoHFhJ/iPsGLROqG948pF0XyXlLiViMvM6gWJLU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Murphy <lists@colorremedies.com>,
        Qu Wenruo <wqu@suse.com>, Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.18 323/350] btrfs: Ensure btrfs_trim_fs can trim the whole filesystem
Date:   Sun, 11 Nov 2018 14:23:07 -0800
Message-Id: <20181111221721.583962138@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qu Wenruo <wqu@suse.com>

commit 6ba9fc8e628becf0e3ec94083450d089b0dec5f5 upstream.

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
CC: <stable@vger.kernel.org> # v4.4+
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/extent-tree.c |   10 +---------
 fs/btrfs/ioctl.c       |   11 +++++++----
 2 files changed, 8 insertions(+), 13 deletions(-)

--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -10984,21 +10984,13 @@ int btrfs_trim_fs(struct btrfs_fs_info *
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
 	for (; cache; cache = next_block_group(fs_info, cache)) {
 		if (cache->key.objectid >= (range->start + range->len)) {
 			btrfs_put_block_group(cache);
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -496,7 +496,6 @@ static noinline int btrfs_ioctl_fitrim(s
 	struct fstrim_range range;
 	u64 minlen = ULLONG_MAX;
 	u64 num_devices = 0;
-	u64 total_bytes = btrfs_super_total_bytes(fs_info->super_copy);
 	int ret;
 
 	if (!capable(CAP_SYS_ADMIN))
@@ -520,11 +519,15 @@ static noinline int btrfs_ioctl_fitrim(s
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
 	ret = btrfs_trim_fs(fs_info, &range);
 	if (ret < 0)


