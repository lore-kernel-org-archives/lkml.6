Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02486ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9DCB21479
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="P9hoHSkf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9DCB21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731003AbeJYWxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:53:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:35828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729116AbeJYWxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:53:20 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AAC82085B;
        Thu, 25 Oct 2018 14:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477223;
        bh=rzIYP/HxjVSvM6JjY20sjazP/W8+Kraft4kpjxdt3+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P9hoHSkf3OgGLVf2tmq43d61TLHhObALk946mZA1B5DulN4nnJL+U2l2jcCzVgCQz
         Pfr+T9hVUHFweWN/sepL2sTw7VAncMexqYFnE8QXYUN1XvdsOQKdL50+nXqXZ/BHs1
         5zPPIOtJN4Qxw6/Uc6U5594ek7gcQwN1ivknznWE=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Filipe Manana <fdmanana@suse.com>, Chris Mason <clm@fb.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 58/98] Btrfs: avoid syncing log in the fast fsync path when not necessary
Date:   Thu, 25 Oct 2018 10:18:13 -0400
Message-Id: <20181025141853.214051-58-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit b659ef027792219b590d67a2baf1643a93727d29 ]

Commit 3a8b36f37806 ("Btrfs: fix data loss in the fast fsync path") added
a performance regression for that causes an unnecessary sync of the log
trees (fs/subvol and root log trees) when 2 consecutive fsyncs are done
against a file, without no writes or any metadata updates to the inode in
between them and if a transaction is committed before the second fsync is
called.

Huang Ying reported this to lkml (https://lkml.org/lkml/2015/3/18/99)
after a test sysbench test that measured a -62% decrease of file io
requests per second for that tests' workload.

The test is:

  echo performance > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
  echo performance > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
  echo performance > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
  echo performance > /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor
  mkfs -t btrfs /dev/sda2
  mount -t btrfs /dev/sda2 /fs/sda2
  cd /fs/sda2
  for ((i = 0; i < 1024; i++)); do fallocate -l 67108864 testfile.$i; done
  sysbench --test=fileio --max-requests=0 --num-threads=4 --max-time=600 \
    --file-test-mode=rndwr --file-total-size=68719476736 --file-io-mode=sync \
    --file-num=1024 run

A test on kvm guest, running a debug kernel gave me the following results:

Without 3a8b36f378060d:             16.01 reqs/sec
With 3a8b36f378060d:                 3.39 reqs/sec
With 3a8b36f378060d and this patch: 16.04 reqs/sec

Reported-by: Huang Ying <ying.huang@intel.com>
Tested-by: Huang, Ying <ying.huang@intel.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Chris Mason <clm@fb.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/file.c         |  9 ++++++---
 fs/btrfs/ordered-data.c | 14 ++++++++++++++
 fs/btrfs/ordered-data.h |  3 +++
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 2ad4cb3da8f6..ba37ec6263ca 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1879,6 +1879,7 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	struct btrfs_log_ctx ctx;
 	int ret = 0;
 	bool full_sync = 0;
+	const u64 len = end - start + 1;
 
 	trace_btrfs_sync_file(file, datasync);
 
@@ -1907,7 +1908,7 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 		 * all extents are persisted and the respective file extent
 		 * items are in the fs/subvol btree.
 		 */
-		ret = btrfs_wait_ordered_range(inode, start, end - start + 1);
+		ret = btrfs_wait_ordered_range(inode, start, len);
 	} else {
 		/*
 		 * Start any new ordered operations before starting to log the
@@ -1979,8 +1980,10 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	 */
 	smp_mb();
 	if (btrfs_inode_in_log(inode, root->fs_info->generation) ||
-	    (full_sync && BTRFS_I(inode)->last_trans <=
-	     root->fs_info->last_trans_committed)) {
+	    (BTRFS_I(inode)->last_trans <=
+	     root->fs_info->last_trans_committed &&
+	     (full_sync ||
+	      !btrfs_have_ordered_extents_in_range(inode, start, len)))) {
 		/*
 		 * We'v had everything committed since the last time we were
 		 * modified so clear this flag in case it was set for whatever
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index b23d024c0234..4c20199cef62 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -848,6 +848,20 @@ struct btrfs_ordered_extent *btrfs_lookup_ordered_range(struct inode *inode,
 	return entry;
 }
 
+bool btrfs_have_ordered_extents_in_range(struct inode *inode,
+					 u64 file_offset,
+					 u64 len)
+{
+	struct btrfs_ordered_extent *oe;
+
+	oe = btrfs_lookup_ordered_range(inode, file_offset, len);
+	if (oe) {
+		btrfs_put_ordered_extent(oe);
+		return true;
+	}
+	return false;
+}
+
 /*
  * lookup and return any extent before 'file_offset'.  NULL is returned
  * if none is found
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 0124bffc775f..a1bce0a5cccc 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -191,6 +191,9 @@ btrfs_lookup_first_ordered_extent(struct inode * inode, u64 file_offset);
 struct btrfs_ordered_extent *btrfs_lookup_ordered_range(struct inode *inode,
 							u64 file_offset,
 							u64 len);
+bool btrfs_have_ordered_extents_in_range(struct inode *inode,
+					 u64 file_offset,
+					 u64 len);
 int btrfs_ordered_update_i_size(struct inode *inode, u64 offset,
 				struct btrfs_ordered_extent *ordered);
 int btrfs_find_ordered_sum(struct inode *inode, u64 offset, u64 disk_bytenr,
-- 
2.17.1

