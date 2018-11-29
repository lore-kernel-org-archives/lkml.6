Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8293BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47D5621019
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1clyfOg+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47D5621019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731243AbeK3BZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:25:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:48830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729806AbeK3BZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:25:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3551D208E7;
        Thu, 29 Nov 2018 14:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501193;
        bh=VZRWVEgLHfY4MaREpi+s/vj5lVnUek8myFpCjngm9tU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1clyfOg+A/uvcIlnTyRn//o5joa8vJWUjtNo4THiQby0l3LxizLFV+JN9pI3OFjAG
         URmdYT8FrM77Fu7BQM8BWRtVq2Vy08mu4db5o+ntmdBT1VR7xECcHt3rRwNWzCy2s5
         DXbKy5gKD0L85SAzvCNX+OsMp6V5pPyY2Ujz2ptI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Murphy <lists@colorremedies.com>,
        Qu Wenruo <wqu@suse.com>, Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.4 82/86] btrfs: Ensure btrfs_trim_fs can trim the whole filesystem
Date:   Thu, 29 Nov 2018 15:12:47 +0100
Message-Id: <20181129140116.297281513@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140109.832117862@linuxfoundation.org>
References: <20181129140109.832117862@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -10708,17 +10708,9 @@ int btrfs_trim_fs(struct btrfs_root *roo
 	u64 start;
 	u64 end;
 	u64 trimmed = 0;
-	u64 total_bytes = btrfs_super_total_bytes(fs_info->super_copy);
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
 	while (cache) {
 		if (cache->key.objectid >= (range->start + range->len)) {
 			btrfs_put_block_group(cache);
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -378,7 +378,6 @@ static noinline int btrfs_ioctl_fitrim(s
 	struct fstrim_range range;
 	u64 minlen = ULLONG_MAX;
 	u64 num_devices = 0;
-	u64 total_bytes = btrfs_super_total_bytes(fs_info->super_copy);
 	int ret;
 
 	if (!capable(CAP_SYS_ADMIN))
@@ -402,11 +401,15 @@ static noinline int btrfs_ioctl_fitrim(s
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


