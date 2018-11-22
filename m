Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD71C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0EC120866
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Sb6kzPIS";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FU6QiVxI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0EC120866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405450AbeKVVik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 16:38:40 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:51352 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405240AbeKVVie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 16:38:34 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BE3ED60B11; Thu, 22 Nov 2018 10:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542884380;
        bh=bfb0kG3+6N2FbsNZt/nLpvoGzPhzmwxc3ymqV8DoBH8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sb6kzPIS8PQTfnjS1PEp2BKMiNLiUATb5GLu0mEvJIFF5MCsUB+MLUpIpb/KDbBFA
         WkDE870z8n2RyVf/IVXvjd0qlJzsBvcgsskV7FTaUK4dHRhNGKMcsXtDfC6J46MBKy
         glnqUIET/xiFMr/eooY+y1MKWf2oLI6vq/n/1hv8=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 52AB860791;
        Thu, 22 Nov 2018 10:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542884379;
        bh=bfb0kG3+6N2FbsNZt/nLpvoGzPhzmwxc3ymqV8DoBH8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FU6QiVxI/gnZGIgiN7nT+fS32BYDEx9kJoajVnwGOT/ZiQtdw/6BLifysT/EYPFOR
         rQs6nW/W+rGr0cayFoC4YBOVJFqfPf5ejyBga4D1FIPPavjTzjs83Fo57vVolAMl3R
         V2ltRJW8wIAX9hk6n/0a7GASEKRpsBa7gXAs9SmQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 52AB860791
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org,
        Sahitya Tummala <stummala@codeaurora.org>
Subject: [PATCH 2/2] f2fs: fix memory leak of quota files extent tree and it's nodes
Date:   Thu, 22 Nov 2018 16:29:20 +0530
Message-Id: <1542884360-19470-2-git-send-email-stummala@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1542884360-19470-1-git-send-email-stummala@codeaurora.org>
References: <1542884360-19470-1-git-send-email-stummala@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When there is a failure in f2fs_fill_super() after the quota is
enabled, then f2fs_quota_off_umount() is called in the error handling.
Then sbi is freed up and f2fs_fill_super() retries again.
But f2fs_quota_off_umount() doesn't guarantee that quota file's extent
tree/nodes are removed/freed. It will just add to sbi->zombie_list,
if those files are referenced. In the next retry, quota is enabled
again with the new extent tree and nodes, causing memory leak for the
previously allocated memory.

Fix this by cleaning up the sbi->zombie_list before freeing sbi and
before the next retry.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 fs/f2fs/extent_cache.c | 21 +++++++++++++++++++++
 fs/f2fs/f2fs.h         |  1 +
 fs/f2fs/super.c        |  5 +++++
 3 files changed, 27 insertions(+)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 763ba83..c2bcd88 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -629,6 +629,27 @@ static void f2fs_update_extent_tree_range(struct inode *inode,
 		f2fs_mark_inode_dirty_sync(inode, true);
 }
 
+void f2fs_cleanup_zombie_list(struct f2fs_sb_info *sbi)
+{
+	struct extent_tree *et, *next;
+
+	mutex_lock(&sbi->extent_tree_lock);
+	list_for_each_entry_safe(et, next, &sbi->zombie_list, list) {
+		if (atomic_read(&et->node_cnt)) {
+			write_lock(&et->lock);
+			__free_extent_tree(sbi, et);
+			write_unlock(&et->lock);
+		}
+		f2fs_bug_on(sbi, atomic_read(&et->node_cnt));
+		list_del_init(&et->list);
+		radix_tree_delete(&sbi->extent_tree_root, et->ino);
+		kmem_cache_free(extent_tree_slab, et);
+		atomic_dec(&sbi->total_ext_tree);
+		atomic_dec(&sbi->total_zombie_tree);
+	}
+	mutex_unlock(&sbi->extent_tree_lock);
+}
+
 unsigned int f2fs_shrink_extent_tree(struct f2fs_sb_info *sbi, int nr_shrink)
 {
 	struct extent_tree *et, *next;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index db8a919..6807815 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3419,6 +3419,7 @@ void f2fs_update_extent_cache_range(struct dnode_of_data *dn,
 void f2fs_init_extent_cache_info(struct f2fs_sb_info *sbi);
 int __init f2fs_create_extent_cache(void);
 void f2fs_destroy_extent_cache(void);
+void f2fs_cleanup_zombie_list(struct f2fs_sb_info *sbi);
 
 /*
  * sysfs.c
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index f41ac43..521fe3f 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3023,6 +3023,11 @@ void f2fs_cleanup_extent_cache(struct f2fs_sb_info *sbi)
 
 	list_for_each_entry_safe(inode, next, &sb->s_inodes, i_sb_list)
 		f2fs_destroy_extent_tree(inode, true);
+
+	f2fs_cleanup_zombie_list(sbi);
+
+	f2fs_bug_on(sbi, !list_empty(&sbi->zombie_list));
+	f2fs_bug_on(sbi, !list_empty(&sbi->extent_list));
 }
 
 static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

