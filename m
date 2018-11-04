Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC02C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 17:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB5D72082D
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 17:29:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB5D72082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731367AbeKECp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 21:45:26 -0500
Received: from relay.sw.ru ([185.231.240.75]:46944 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731157AbeKECp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 21:45:26 -0500
Received: from [172.16.24.21]
        by relay.sw.ru with esmtp (Exim 4.90_1)
        (envelope-from <vvs@virtuozzo.com>)
        id 1gJMDT-0005VZ-Rj; Sun, 04 Nov 2018 20:29:39 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH] ext4: missing !bh check in ext4_xattr_inode_write()
To:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     linux-kernel@vger.kernel.org
Message-ID: <710ddac8-eb88-e631-3b27-74410039d15f@virtuozzo.com>
Date:   Sun, 4 Nov 2018 20:29:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ext4_getblk() called with map_flags=0 can return NULL,
it can lead to oops on bh dereferemce

Fixes e50e5129f384 ("ext4: xattr-in-inode support")
Cc: stable@kernel.org # 4.13

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 fs/ext4/xattr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 0b9688683526..6dc6c70828f0 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1384,6 +1384,8 @@ static int ext4_xattr_inode_write(handle_t *handle, struct inode *ea_inode,
 		bh = ext4_getblk(handle, ea_inode, block, 0);
 		if (IS_ERR(bh))
 			return PTR_ERR(bh);
+		if (!bh)
+			return -ENOMEM;
 		ret = ext4_journal_get_write_access(handle, bh);
 		if (ret)
 			goto out;
-- 
2.17.1


