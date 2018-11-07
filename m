Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E78EC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7D9020862
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:30:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7D9020862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731423AbeKHDBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 22:01:42 -0500
Received: from relay.sw.ru ([185.231.240.75]:37756 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727859AbeKHDBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 22:01:42 -0500
Received: from [172.16.24.21]
        by relay.sw.ru with esmtp (Exim 4.90_1)
        (envelope-from <vvs@virtuozzo.com>)
        id 1gKRek-0003kL-Ij; Wed, 07 Nov 2018 20:30:18 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH v2] ext4: lost brelse in __ext4_read_dirblock()
To:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     linux-kernel@vger.kernel.org
References: <6e5c9e17-5916-7296-35a0-cc0600a79f27@virtuozzo.com>
Message-ID: <e269cf8c-b5ca-3eed-bd60-a8629378db8b@virtuozzo.com>
Date:   Wed, 7 Nov 2018 20:30:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <6e5c9e17-5916-7296-35a0-cc0600a79f27@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes dc6982ff4db1 ("ext4: refactor code to read directory blocks ...")
Cc: stable@kernel.org # 3.9

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 fs/ext4/namei.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index d388cce72db2..6a6b90363ef1 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -126,6 +126,7 @@ static struct buffer_head *__ext4_read_dirblock(struct inode *inode,
 	if (!is_dx_block && type == INDEX) {
 		ext4_error_inode(inode, func, line, block,
 		       "directory leaf block found instead of index block");
+		brelse(bh);
 		return ERR_PTR(-EFSCORRUPTED);
 	}
 	if (!ext4_has_metadata_csum(inode->i_sb) ||
-- 
2.17.1

