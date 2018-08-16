Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C75C04AB9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20D5820C0E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:49:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20D5820C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729530AbeHPTsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 15:48:53 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:35635 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727247AbeHPTsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 15:48:51 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CC5AB54CE29B;
        Fri, 17 Aug 2018 00:49:09 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.399.0; Fri, 17 Aug 2018 00:49:10 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <dsterba@suse.com>
CC:     <jbacik@fb.com>, <clm@fb.com>, <linux-btrfs@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCHv4 3/3] btrfs: change btrfs_pin_log_trans to be void function
Date:   Fri, 17 Aug 2018 00:37:15 +0800
Message-ID: <1534437435-51605-4-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1534437435-51605-1-git-send-email-zhongjiang@huawei.com>
References: <1534437435-51605-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

btrfs_pin_log_trans defines the variable "ret" for return value,
but it is not modified after initialization. Further, I find that
any of the callers do not handle the return value, so it is safe
to drop the unneeded "ret" and make it to be void function.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 fs/btrfs/tree-log.c | 5 +----
 fs/btrfs/tree-log.h | 2 +-
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 1650dc4..4ed7379 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -205,14 +205,11 @@ static int join_running_log_trans(struct btrfs_root *root)
  * until you call btrfs_end_log_trans() or it makes any future
  * log transactions wait until you call btrfs_end_log_trans()
  */
-int btrfs_pin_log_trans(struct btrfs_root *root)
+void btrfs_pin_log_trans(struct btrfs_root *root)
 {
-	int ret = -ENOENT;
-
 	mutex_lock(&root->log_mutex);
 	atomic_inc(&root->log_writers);
 	mutex_unlock(&root->log_mutex);
-	return ret;
 }
 
 /*
diff --git a/fs/btrfs/tree-log.h b/fs/btrfs/tree-log.h
index 122e68b..8977678 100644
--- a/fs/btrfs/tree-log.h
+++ b/fs/btrfs/tree-log.h
@@ -65,7 +65,7 @@ int btrfs_del_inode_ref_in_log(struct btrfs_trans_handle *trans,
 			       const char *name, int name_len,
 			       struct btrfs_inode *inode, u64 dirid);
 void btrfs_end_log_trans(struct btrfs_root *root);
-int btrfs_pin_log_trans(struct btrfs_root *root);
+void btrfs_pin_log_trans(struct btrfs_root *root);
 void btrfs_record_unlink_dir(struct btrfs_trans_handle *trans,
 			     struct btrfs_inode *dir, struct btrfs_inode *inode,
 			     int for_rename);
-- 
1.7.12.4

