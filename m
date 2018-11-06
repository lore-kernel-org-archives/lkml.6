Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687EBC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 12:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39BCC2083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 12:08:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39BCC2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387921AbeKFVbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 16:31:32 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:14598 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387454AbeKFVbc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 16:31:32 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 02F102112A9DE;
        Tue,  6 Nov 2018 20:06:36 +0800 (CST)
Received: from localhost.localdomain (10.175.124.28) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 6 Nov 2018
 20:06:28 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Eric Biggers <ebiggers@google.com>
CC:     <linux-fscrypt@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [RFC PATCH v2 1/2] fscrypt: remove d_lock on reading DCACHE_ENCRYPTED_WITH_KEY
Date:   Tue, 6 Nov 2018 20:20:51 +0800
Message-ID: <20181106122052.18507-1-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.14.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems there is no need to take d_lock when accessing
dentry->d_flags & DCACHE_ENCRYPTED_WITH_KEY in
fscrypt_d_revalidate. It only needs to be serialized for updating.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---

Change log v2:
 - Fix negative dentry (NULL d_inode) issue as Eric pointed out;
 - Fix to use '__lockref_is_dead()' as Eric pointed out before;

[original message]
Hi,
 At glance, I have no idea why fscrypt_d_revalidate disables
RCU-lookup. Therefore I made patches to raise a question and
do some test (eg. fsstress w/ and w/o drop_caches) and it
seems to work.

Thanks,
Gao Xiang

 fs/crypto/crypto.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
index 0f46cf550907..b38c574f70ac 100644
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
2.14.4

