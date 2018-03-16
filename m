Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752900AbeCPNYN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 09:24:13 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60904 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751236AbeCPNYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 09:24:09 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 72D4B60C5F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=riteshh@codeaurora.org
From: Ritesh Harjani <riteshh@codeaurora.org>
To: jaegeuk@kernel.org, yuchao0@huawei.com,
        linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: stummala@codeaurora.org, Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH] f2fs: Set GF_NOFS in read_cache_page_gfp while doing f2fs_quota_read
Date: Fri, 16 Mar 2018 18:53:53 +0530
Message-Id: <1521206633-21378-2-git-send-email-riteshh@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1521206633-21378-1-git-send-email-riteshh@codeaurora.org>
References: <1521206633-21378-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quota code itself is serializing the operations by taking mutex_lock.
It seems a below deadlock can happen if GF_NOFS is not used in
f2fs_quota_read

__switch_to+0x88
__schedule+0x5b0
schedule+0x78
schedule_preempt_disabled+0x20
__mutex_lock_slowpath+0xdc   		//mutex owner is itself
mutex_lock+0x2c
dquot_commit+0x30			//mutex_lock(&dqopt->dqio_mutex);
dqput+0xe0
__dquot_drop+0x80
dquot_drop+0x48
f2fs_evict_inode+0x218
evict+0xa8
dispose_list+0x3c
prune_icache_sb+0x58
super_cache_scan+0xf4
do_shrink_slab+0x208
shrink_slab.part.40+0xac
shrink_zone+0x1b0
do_try_to_free_pages+0x25c
try_to_free_pages+0x164
__alloc_pages_nodemask+0x534
do_read_cache_page+0x6c
read_cache_page+0x14
f2fs_quota_read+0xa4
read_blk+0x54
find_tree_dqentry+0xe4
find_tree_dqentry+0xb8
find_tree_dqentry+0xb8
find_tree_dqentry+0xb8
qtree_read_dquot+0x68
v2_read_dquot+0x24
dquot_acquire+0x5c			// mutex_lock(&dqopt->dqio_mutex);
dqget+0x238
__dquot_initialize+0xd4
dquot_initialize+0x10
dquot_file_open+0x34
f2fs_file_open+0x6c
do_dentry_open+0x1e4
vfs_open+0x6c
path_openat+0xa20
do_filp_open+0x4c
do_sys_open+0x178

Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
---
 fs/f2fs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 708155d..3a9a924 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1382,7 +1382,7 @@ static ssize_t f2fs_quota_read(struct super_block *sb, int type, char *data,
 	while (toread > 0) {
 		tocopy = min_t(unsigned long, sb->s_blocksize - offset, toread);
 repeat:
-		page = read_mapping_page(mapping, blkidx, NULL);
+		page = read_cache_page_gfp(mapping, blkidx, GFP_NOFS);
 		if (IS_ERR(page)) {
 			if (PTR_ERR(page) == -ENOMEM) {
 				congestion_wait(BLK_RW_ASYNC, HZ/50);
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.
