Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D87C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79DF8206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:09:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79DF8206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbeIJSDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 14:03:19 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11678 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727269AbeIJSDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 14:03:19 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CB4FFC24D8D33;
        Mon, 10 Sep 2018 21:09:14 +0800 (CST)
Received: from szvp000100637.huawei.com (10.162.55.131) by smtp.huawei.com
 (10.3.19.209) with Microsoft SMTP Server (TLS) id 14.3.399.0; Mon, 10 Sep
 2018 21:09:10 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>
CC:     Eric Biggers <ebiggers@google.com>,
        <linux-fscrypt@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Chao Yu <yuchao0@huawei.com>, Miao Xie <miaoxie@huawei.com>,
        <weidu.du@huawei.com>, Gao Xiang <gaoxiang25@huawei.com>
Subject: [RFC PATCH v2 2/2] fscrypt: enable RCU-walk path for .d_revalidate
Date:   Mon, 10 Sep 2018 21:08:57 +0800
Message-ID: <1536584937-16960-1-git-send-email-gaoxiang25@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1536584468-15695-2-git-send-email-gaoxiang25@huawei.com>
References: <1536584468-15695-2-git-send-email-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.162.55.131]
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
change log v2:
	- READ_ONCE(dir->d_parent) -> READ_ONCE(dentry->d_parent)

 fs/crypto/crypto.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
index b38c574..9bd21c0 100644
--- a/fs/crypto/crypto.c
+++ b/fs/crypto/crypto.c
@@ -319,20 +319,24 @@ static int fscrypt_d_revalidate(struct dentry *dentry, unsigned int flags)
 {
 	struct dentry *dir;
 	int dir_has_key, cached_with_key;
-
-	if (flags & LOOKUP_RCU)
-		return -ECHILD;
-
-	dir = dget_parent(dentry);
-	if (!IS_ENCRYPTED(d_inode(dir))) {
-		dput(dir);
+	struct inode *dir_inode;
+
+	rcu_read_lock();
+repeat:
+	dir = READ_ONCE(dentry->d_parent);
+	dir_inode = d_inode_rcu(dir);
+	if (!IS_ENCRYPTED(dir_inode)) {
+		rcu_read_unlock();
 		return 0;
 	}
+	dir_has_key = (dir_inode->i_crypt_info != NULL);
+	if (unlikely(READ_ONCE(dir->d_lockref.count) < 0 ||
+		READ_ONCE(dentry->d_parent) != dir))
+		goto repeat;
+	rcu_read_unlock();
 
 	cached_with_key = READ_ONCE(dentry->d_flags) &
 		DCACHE_ENCRYPTED_WITH_KEY;
-	dir_has_key = (d_inode(dir)->i_crypt_info != NULL);
-	dput(dir);
 
 	/*
 	 * If the dentry was cached without the key, and it is a
-- 
1.9.1

