Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C693C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E905214E0
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOFom1Bw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E905214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404325AbeKLIlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:41:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:54620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404153AbeKLIXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:23:07 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C7C4223DD;
        Sun, 11 Nov 2018 22:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975590;
        bh=rALukCeLIVZw1uw0Znpe+Yh1D9hnFLzK0iw83v0xUPo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NOFom1Bw6Cdl6wPso6nG4hIoiPLea9UxsyUjMVsal79NNyWCEBvAtZ6HjYyZZe/9A
         DLjwIyRM3YZp4X151Zj/h+TmkteQwNLppp/4cwK2jLN6FH4mqxke8eCPuVMZVCW0G2
         eLD5Sy2d8vQjgiqzruptHG5F8LyM3zuqSc1+T9b8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Murphy <lists@colorremedies.com>,
        Qu Wenruo <wqu@suse.com>, Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.14 201/222] btrfs: Ensure btrfs_trim_fs can trim the whole filesystem
Date:   Sun, 11 Nov 2018 14:24:58 -0800
Message-Id: <20181111221704.710887970@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221647.665769131@linuxfoundation.org>
References: <20181111221647.665769131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -11055,21 +11055,13 @@ int btrfs_trim_fs(struct btrfs_fs_info *
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
@@ -352,7 +352,6 @@ static noinline int btrfs_ioctl_fitrim(s
 	struct fstrim_range range;
 	u64 minlen = ULLONG_MAX;
 	u64 num_devices = 0;
-	u64 total_bytes = btrfs_super_total_bytes(fs_info->super_copy);
 	int ret;
 
 	if (!capable(CAP_SYS_ADMIN))
@@ -376,11 +375,15 @@ static noinline int btrfs_ioctl_fitrim(s
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


