Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65582C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 21:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2811720664
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 21:58:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2811720664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbeJaGxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 02:53:11 -0400
Received: from relay.sw.ru ([185.231.240.75]:45962 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725743AbeJaGxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 02:53:11 -0400
Received: from [172.16.24.21]
        by relay.sw.ru with esmtp (Exim 4.90_1)
        (envelope-from <vvs@virtuozzo.com>)
        id 1gHc1N-0003gX-6t; Wed, 31 Oct 2018 00:57:57 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH v2 03/11] ext4 resize: brelse() cleanup in
 add_new_gdb_meta_bg()
To:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org,
        Yongqiang Yang <xiaoqiangnk@gmail.com>,
        Yongqiang Yang <yangyongqiang01@baidu.com>
References: <cover.1540935522.git.vvs@virtuozzo.com>
Message-ID: <34d94824-834c-fb72-2f93-01e9036e9b38@virtuozzo.com>
Date:   Wed, 31 Oct 2018 00:57:55 +0300
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

gdb_bh must be released in case of errors before update of s_group_desc
but it must not be released after update of group descriptors
because in this case bh can be used later.

Fixes 01f795f9e0d6 ("ext4: add online resizing support for meta_bg ...") # 3.7

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 fs/ext4/resize.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index 0a4dc6217e78..7131f35b62d9 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -922,6 +922,7 @@ static int add_new_gdb_meta_bg(struct super_block *sb,
 				     sizeof(struct buffer_head *),
 				     GFP_NOFS);
 	if (!n_group_desc) {
+		brelse(gdb_bh);
 		err = -ENOMEM;
 		ext4_warning(sb, "not enough memory for %lu groups",
 			     gdb_num + 1);
@@ -937,8 +938,6 @@ static int add_new_gdb_meta_bg(struct super_block *sb,
 	kvfree(o_group_desc);
 	BUFFER_TRACE(gdb_bh, "get_write_access");
 	err = ext4_journal_get_write_access(handle, gdb_bh);
-	if (unlikely(err))
-		brelse(gdb_bh);
 	return err;
 }
 
-- 
2.17.1

