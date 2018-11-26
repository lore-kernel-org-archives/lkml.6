Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77978C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30C5821473
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vd5yy1/s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30C5821473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbeKZVvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:51:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:60962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbeKZVvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:51:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E278C21104;
        Mon, 26 Nov 2018 10:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543229867;
        bh=MvP56rTp4Iejo1L9aQIo//9lTAtLfEoIJCed4C6oVXM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vd5yy1/sCxykxFW50lsLu8DpSULyBPVVIhF21yvEQRp+Nhsfbjl4sXOcxeGYTEfcE
         ++x3s6UcFmLE9Hg7cvT0jEHIqxxRFMsEcQOc/8D7nb3qK+KBOvwjMhtJjkXAbsVIuH
         v7y2nYzEJfr1pPz10ucwpKOSgMqSn6nheCeVKn0A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Murphy <lists@colorremedies.com>,
        Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 30/46] btrfs: Enhance btrfs_trim_fs function to handle error better
Date:   Mon, 26 Nov 2018 11:51:19 +0100
Message-Id: <20181126105048.979947188@linuxfoundation.org>
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

Commit 93bba24d4b5ad1e5cd8b43f64e66ff9d6355dd20 upstream.

Function btrfs_trim_fs() doesn't handle errors in a consistent way. If
error happens when trimming existing block groups, it will skip the
remaining blocks and continue to trim unallocated space for each device.

The return value will only reflect the final error from device trimming.

This patch will fix such behavior by:

1) Recording the last error from block group or device trimming
   The return value will also reflect the last error during trimming.
   Make developer more aware of the problem.

2) Continuing trimming if possible
   If we failed to trim one block group or device, we could still try
   the next block group or device.

3) Report number of failures during block group and device trimming
   It would be less noisy, but still gives user a brief summary of
   what's going wrong.

Such behavior can avoid confusion for cases like failure to trim the
first block group and then only unallocated space is trimmed.

Reported-by: Chris Murphy <lists@colorremedies.com>
CC: stable@vger.kernel.org # 4.9
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
[ add bg_ret and dev_ret to the messages ]
Signed-off-by: David Sterba <dsterba@suse.com>
[ change parameter from @fs_info to @fs_info->root for older kernel ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/extent-tree.c | 53 +++++++++++++++++++++++++++++++-----------
 1 file changed, 40 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 163b61a92b59..42c4b246f749 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -11140,6 +11140,15 @@ static int btrfs_trim_free_extents(struct btrfs_device *device,
 	return ret;
 }
 
+/*
+ * Trim the whole filesystem by:
+ * 1) trimming the free space in each block group
+ * 2) trimming the unallocated space on each device
+ *
+ * This will also continue trimming even if a block group or device encounters
+ * an error.  The return value will be the last error, or 0 if nothing bad
+ * happens.
+ */
 int btrfs_trim_fs(struct btrfs_root *root, struct fstrim_range *range)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
@@ -11151,6 +11160,10 @@ int btrfs_trim_fs(struct btrfs_root *root, struct fstrim_range *range)
 	u64 end;
 	u64 trimmed = 0;
 	u64 total_bytes = btrfs_super_total_bytes(fs_info->super_copy);
+	u64 bg_failed = 0;
+	u64 dev_failed = 0;
+	int bg_ret = 0;
+	int dev_ret = 0;
 	int ret = 0;
 
 	/*
@@ -11161,7 +11174,7 @@ int btrfs_trim_fs(struct btrfs_root *root, struct fstrim_range *range)
 	else
 		cache = btrfs_lookup_block_group(fs_info, range->start);
 
-	while (cache) {
+	for (; cache; cache = next_block_group(fs_info->tree_root, cache)) {
 		if (cache->key.objectid >= (range->start + range->len)) {
 			btrfs_put_block_group(cache);
 			break;
@@ -11175,13 +11188,15 @@ int btrfs_trim_fs(struct btrfs_root *root, struct fstrim_range *range)
 			if (!block_group_cache_done(cache)) {
 				ret = cache_block_group(cache, 0);
 				if (ret) {
-					btrfs_put_block_group(cache);
-					break;
+					bg_failed++;
+					bg_ret = ret;
+					continue;
 				}
 				ret = wait_block_group_cache_done(cache);
 				if (ret) {
-					btrfs_put_block_group(cache);
-					break;
+					bg_failed++;
+					bg_ret = ret;
+					continue;
 				}
 			}
 			ret = btrfs_trim_block_group(cache,
@@ -11192,28 +11207,40 @@ int btrfs_trim_fs(struct btrfs_root *root, struct fstrim_range *range)
 
 			trimmed += group_trimmed;
 			if (ret) {
-				btrfs_put_block_group(cache);
-				break;
+				bg_failed++;
+				bg_ret = ret;
+				continue;
 			}
 		}
-
-		cache = next_block_group(fs_info->tree_root, cache);
 	}
 
-	mutex_lock(&root->fs_info->fs_devices->device_list_mutex);
-	devices = &root->fs_info->fs_devices->devices;
+	if (bg_failed)
+		btrfs_warn(fs_info,
+			"failed to trim %llu block group(s), last error %d",
+			bg_failed, bg_ret);
+	mutex_lock(&fs_info->fs_devices->device_list_mutex);
+	devices = &fs_info->fs_devices->devices;
 	list_for_each_entry(device, devices, dev_list) {
 		ret = btrfs_trim_free_extents(device, range->minlen,
 					      &group_trimmed);
-		if (ret)
+		if (ret) {
+			dev_failed++;
+			dev_ret = ret;
 			break;
+		}
 
 		trimmed += group_trimmed;
 	}
 	mutex_unlock(&root->fs_info->fs_devices->device_list_mutex);
 
+	if (dev_failed)
+		btrfs_warn(fs_info,
+			"failed to trim %llu device(s), last error %d",
+			dev_failed, dev_ret);
 	range->len = trimmed;
-	return ret;
+	if (bg_ret)
+		return bg_ret;
+	return dev_ret;
 }
 
 /*
-- 
2.17.1



