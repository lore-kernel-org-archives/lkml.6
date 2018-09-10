Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A274C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D17FD204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:01:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D17FD204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbeIJRz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 13:55:29 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12092 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727269AbeIJRz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 13:55:29 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DCC9DA7FDF2DA;
        Mon, 10 Sep 2018 21:01:25 +0800 (CST)
Received: from szvp000100637.huawei.com (10.162.55.131) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.399.0; Mon, 10 Sep
 2018 21:01:20 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>
CC:     Eric Biggers <ebiggers@google.com>,
        <linux-fscrypt@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Chao Yu <yuchao0@huawei.com>, Miao Xie <miaoxie@huawei.com>,
        <weidu.du@huawei.com>, Gao Xiang <gaoxiang25@huawei.com>
Subject: [RFC PATCH 1/2] fscrypt: remove d_lock on reading DCACHE_ENCRYPTED_WITH_KEY
Date:   Mon, 10 Sep 2018 21:01:07 +0800
Message-ID: <1536584468-15695-1-git-send-email-gaoxiang25@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.162.55.131]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems there is no need to take d_lock when
accessing dentry->d_flags & DCACHE_ENCRYPTED_WITH_KEY
in fscrypt_d_revalidate. It only needs to be
serialized for updating.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
Hi,

At glance, I have no idea why fscrypt_d_revalidate disables
RCU-lookup. Therefore I made patches to raise a question and
do some basic test, and it seems to work.

Thanks,

 fs/crypto/crypto.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
index 0f46cf5..b38c574 100644
--- a/fs/crypto/crypto.c
+++ b/fs/crypto/crypto.c
@@ -329,9 +329,8 @@ static int fscrypt_d_revalidate(struct dentry *dentry, unsigned int flags)
 		return 0;
 	}
 
-	spin_lock(&dentry->d_lock);
-	cached_with_key = dentry->d_flags & DCACHE_ENCRYPTED_WITH_KEY;
-	spin_unlock(&dentry->d_lock);
+	cached_with_key = READ_ONCE(dentry->d_flags) &
+		DCACHE_ENCRYPTED_WITH_KEY;
 	dir_has_key = (d_inode(dir)->i_crypt_info != NULL);
 	dput(dir);
 
-- 
1.9.1

