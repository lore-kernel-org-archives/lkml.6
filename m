Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8F6ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 19:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3983720657
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 19:12:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3983720657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730217AbeKAEMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 00:12:17 -0400
Received: from relay.sw.ru ([185.231.240.75]:47210 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725731AbeKAEMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 00:12:17 -0400
Received: from [172.16.24.21]
        by relay.sw.ru with esmtp (Exim 4.90_1)
        (envelope-from <vvs@virtuozzo.com>)
        id 1gHvvA-0006Kc-Md; Wed, 31 Oct 2018 22:12:52 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH 5/7] ext4: bs.bh cleanup before re-using in
 ext4_xattr_block_find()
To:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org, Tiger Yang <tiger.yang@oracle.com>
References: <cover.1541011937.git.vvs@virtuozzo.com>
Message-ID: <1a83ea26-a159-490a-1e07-e7c8f187672a@virtuozzo.com>
Date:   Wed, 31 Oct 2018 22:12:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <cover.1541011937.git.vvs@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bs.bh was taken in previous ext4_xattr_block_find() call,
it should be released before re-using

Fixes 7e01c8e5420b ("ext3/4: fix uninitialized bs in ...") # 2.6.26
cc: Tiger Yang <tiger.yang@oracle.com>

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 fs/ext4/xattr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 07c3a115f7ae..07b9a335c8eb 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -2395,6 +2395,8 @@ ext4_xattr_set_handle(handle_t *handle, struct inode *inode, int name_index,
 			error = ext4_xattr_block_set(handle, inode, &i, &bs);
 		} else if (error == -ENOSPC) {
 			if (EXT4_I(inode)->i_file_acl && !bs.s.base) {
+				brelse(bs.bh);
+				bs.bh = NULL;
 				error = ext4_xattr_block_find(inode, &i, &bs);
 				if (error)
 					goto cleanup;
-- 
2.17.1

