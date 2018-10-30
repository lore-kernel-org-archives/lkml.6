Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A147C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 21:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F30B20664
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 21:58:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F30B20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbeJaGyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 02:54:00 -0400
Received: from relay.sw.ru ([185.231.240.75]:46010 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725743AbeJaGyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 02:54:00 -0400
Received: from [172.16.24.21]
        by relay.sw.ru with esmtp (Exim 4.90_1)
        (envelope-from <vvs@virtuozzo.com>)
        id 1gHc2A-0003hJ-KO; Wed, 31 Oct 2018 00:58:46 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH v2 10/11] ext4: remove useless brelse call in
 ext4_xattr_inode_update_ref()
To:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org, Tahsin Erdogan <tahsin@google.com>
References: <cover.1540935522.git.vvs@virtuozzo.com>
Message-ID: <fb87bcc2-5e4a-34ba-a063-3f43e9de976c@virtuozzo.com>
Date:   Wed, 31 Oct 2018 00:58:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <cover.1540935522.git.vvs@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

brelse(iloc.bh) is useless here, it is always called with iloc.bh = NULL

Fixes dec214d00e0d ("ext4: xattr inode deduplication") # 4.13
cc: Tahsin Erdogan <tahsin@google.com>

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 fs/ext4/xattr.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index f36fc5d5b257..dc1aeab06dba 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1031,10 +1031,8 @@ static int ext4_xattr_inode_update_ref(handle_t *handle, struct inode *ea_inode,
 	inode_lock(ea_inode);
 
 	ret = ext4_reserve_inode_write(handle, ea_inode, &iloc);
-	if (ret) {
-		iloc.bh = NULL;
+	if (ret)
 		goto out;
-	}
 
 	ref_count = ext4_xattr_inode_get_ref(ea_inode);
 	ref_count += ref_change;
@@ -1080,12 +1078,10 @@ static int ext4_xattr_inode_update_ref(handle_t *handle, struct inode *ea_inode,
 	}
 
 	ret = ext4_mark_iloc_dirty(handle, ea_inode, &iloc);
-	iloc.bh = NULL;
 	if (ret)
 		ext4_warning_inode(ea_inode,
 				   "ext4_mark_iloc_dirty() failed ret=%d", ret);
 out:
-	brelse(iloc.bh);
 	inode_unlock(ea_inode);
 	return ret;
 }
-- 
2.17.1

