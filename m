Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A84C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 21:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D409320827
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 21:58:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D409320827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbeJaGxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 02:53:45 -0400
Received: from relay.sw.ru ([185.231.240.75]:45994 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725743AbeJaGxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 02:53:45 -0400
Received: from [172.16.24.21]
        by relay.sw.ru with esmtp (Exim 4.90_1)
        (envelope-from <vvs@virtuozzo.com>)
        id 1gHc1v-0003h6-Md; Wed, 31 Oct 2018 00:58:31 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH v2 08/11] ext4: lost brelse in ext4_orphan_add()
To:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org, Dmitry Monakhov <dmonakhov@gmail.com>
References: <cover.1540935522.git.vvs@virtuozzo.com>
Message-ID: <c747413b-f5e1-d3e0-650b-e3749a98d59d@virtuozzo.com>
Date:   Wed, 31 Oct 2018 00:58:31 +0300
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

iloc.bh os taken in ext4_reserve_inode_write().
If (dirty == true) it is released in ext4_mark_iloc_dirty(),
however it is not released in (dirty == false) case.

Fixes d745a8c20c1f ("ext4: reduce contention on s_orphan_lock")
however iloc.bh count balance was broken earlier by
Fixes 6e3617e579e0 ("ext4: Handle non empty on-disk orphan link") #2.6.34

cc: Dmitry Monakhov <dmonakhov@gmail.com>
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 fs/ext4/namei.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 67a38532032a..d388cce72db2 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2811,7 +2811,9 @@ int ext4_orphan_add(handle_t *handle, struct inode *inode)
 			list_del_init(&EXT4_I(inode)->i_orphan);
 			mutex_unlock(&sbi->s_orphan_lock);
 		}
-	}
+	} else
+		brelse(iloc.bh);
+
 	jbd_debug(4, "superblock will point to %lu\n", inode->i_ino);
 	jbd_debug(4, "orphan inode %lu will point to %d\n",
 			inode->i_ino, NEXT_ORPHAN(inode));
-- 
2.17.1

