Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281D4C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E44D22241E
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qegODw9+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E44D22241E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404199AbeKLIXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:23:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:54672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404173AbeKLIXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:23:07 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E053E223D8;
        Sun, 11 Nov 2018 22:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975590;
        bh=XCgKS9PQP3X9G2Zl/lVFMGAB4jZDGZsrsV35lZ52LPo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qegODw9+zu4xV9/KbWLeZu3fAtr1jH3/Mt11yg0AlNYTALoIJ5q2QcZ7cmCw3Hvmx
         Y6VjFKtBCJIlMULtuZrfMU40dyn5mp1fyuAxJsUbGysInuD7OxLWsQ2dDM43J+OwFj
         PZN+aL/aprOsuRSgQOQTkArmh0BfrGpGhP8glu/4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Murphy <lists@colorremedies.com>,
        Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.com>
Subject: [PATCH 4.14 200/222] btrfs: Enhance btrfs_trim_fs function to handle error better
Date:   Sun, 11 Nov 2018 14:24:57 -0800
Message-Id: <20181111221704.644686691@linuxfoundation.org>
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

commit 93bba24d4b5ad1e5cd8b43f64e66ff9d6355dd20 upstream.

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
CC: stable@vger.kernel.org # 4.4+
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
[ add bg_ret and dev_ret to the messages ]
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/extent-tree.c |   49 ++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 38 insertions(+), 11 deletions(-)

--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -11037,6 +11037,15 @@ static int btrfs_trim_free_extents(struc
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
 int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
 {
 	struct btrfs_block_group_cache *cache = NULL;
@@ -11047,6 +11056,10 @@ int btrfs_trim_fs(struct btrfs_fs_info *
 	u64 end;
 	u64 trimmed = 0;
 	u64 total_bytes = btrfs_super_total_bytes(fs_info->super_copy);
+	u64 bg_failed = 0;
+	u64 dev_failed = 0;
+	int bg_ret = 0;
+	int dev_ret = 0;
 	int ret = 0;
 
 	/*
@@ -11057,7 +11070,7 @@ int btrfs_trim_fs(struct btrfs_fs_info *
 	else
 		cache = btrfs_lookup_block_group(fs_info, range->start);
 
-	while (cache) {
+	for (; cache; cache = next_block_group(fs_info, cache)) {
 		if (cache->key.objectid >= (range->start + range->len)) {
 			btrfs_put_block_group(cache);
 			break;
@@ -11071,13 +11084,15 @@ int btrfs_trim_fs(struct btrfs_fs_info *
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
@@ -11088,28 +11103,40 @@ int btrfs_trim_fs(struct btrfs_fs_info *
 
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
-		cache = next_block_group(fs_info, cache);
 	}
 
+	if (bg_failed)
+		btrfs_warn(fs_info,
+			"failed to trim %llu block group(s), last error %d",
+			bg_failed, bg_ret);
 	mutex_lock(&fs_info->fs_devices->device_list_mutex);
 	devices = &fs_info->fs_devices->alloc_list;
 	list_for_each_entry(device, devices, dev_alloc_list) {
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
 	mutex_unlock(&fs_info->fs_devices->device_list_mutex);
 
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


