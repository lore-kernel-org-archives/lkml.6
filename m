Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F171C46465
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 12:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 477E52086B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 12:07:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 477E52086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388245AbeKFVcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 16:32:11 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:14179 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387612AbeKFVcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 16:32:08 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6CB1179EDFDD3;
        Tue,  6 Nov 2018 20:07:11 +0800 (CST)
Received: from localhost.localdomain (10.175.124.28) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 6 Nov 2018
 20:07:04 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Eric Biggers <ebiggers@google.com>
CC:     <linux-fscrypt@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [RFC PATCH v2 2/2] fscrypt: enable RCU-walk path for .d_revalidate
Date:   Tue, 6 Nov 2018 20:20:52 +0800
Message-ID: <20181106122052.18507-2-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181106122052.18507-1-gaoxiang25@huawei.com>
References: <20181106122052.18507-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch attempts to enable RCU-walk for fscrypt.
It looks harmless at glance and could have better
performance than do ref-walk only.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---

p.s.
  In my opinion, it is better to retry for the case of
  READ_ONCE(dentry->d_parent) != dir rather than just
  return 0; and then do real lookup for ref-walk path...
  It behaves much like a seqlock and I tend to avoid
  taking d_lock as well..
  Please kindly correct me if I am wrong... Thanks in advance.

Thanks,
Gao Xiang

 fs/crypto/crypto.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
index b38c574f70ac..2cc26fe9c43d 100644
--- a/fs/crypto/crypto.c
+++ b/fs/crypto/crypto.c
@@ -319,20 +319,29 @@ static int fscrypt_d_revalidate(struct dentry *dentry, unsigned int flags)
 {
 	struct dentry *dir;
 	int dir_has_key, cached_with_key;
+	struct inode *dir_inode;
 
-	if (flags & LOOKUP_RCU)
-		return -ECHILD;
+repeat:
+	rcu_read_lock();
+	dir = READ_ONCE(dentry->d_parent);
 
-	dir = dget_parent(dentry);
-	if (!IS_ENCRYPTED(d_inode(dir))) {
-		dput(dir);
+	dir_inode = d_inode_rcu(dir);
+	if (!dir_inode || !IS_ENCRYPTED(dir_inode)) {
+		rcu_read_unlock();
 		return 0;
 	}
+	dir_has_key = (dir_inode->i_crypt_info != NULL);
+
+	/* original dir becomes invalid after sampling all? */
+	if (unlikely(__lockref_is_dead(&dir->d_lockref) ||
+		     READ_ONCE(dentry->d_parent) != dir)) {
+		rcu_read_unlock();
+		goto repeat;
+	}
+	rcu_read_unlock();
 
 	cached_with_key = READ_ONCE(dentry->d_flags) &
 		DCACHE_ENCRYPTED_WITH_KEY;
-	dir_has_key = (d_inode(dir)->i_crypt_info != NULL);
-	dput(dir);
 
 	/*
 	 * If the dentry was cached without the key, and it is a
-- 
2.14.4

