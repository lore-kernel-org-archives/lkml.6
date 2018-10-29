Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E245C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 15:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F73220664
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 15:48:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F73220664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbeJ3AhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 20:37:13 -0400
Received: from relay.sw.ru ([185.231.240.75]:46114 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727744AbeJ3AhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 20:37:13 -0400
Received: from [172.16.24.21]
        by relay.sw.ru with esmtp (Exim 4.90_1)
        (envelope-from <vvs@virtuozzo.com>)
        id 1gH9Q8-0006cA-Ik; Mon, 29 Oct 2018 18:25:36 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH 6/7] ext4 resize: lost rollback in ext4_resize_fs()
To:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org
Message-ID: <0a8fb3b8-9f2b-9d66-0785-afee16b6e16c@virtuozzo.com>
Date:   Mon, 29 Oct 2018 18:25:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes 117fff10d7f1 ("ext4: grow the s_flex_groups array as needed ...")
#? cc: stable <stable@vger.kernel.org>     # 3.7+

Signed-off-by: Vasily Averin <vvs@openvz.org>
---
 fs/ext4/resize.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index 26bcb53e5869..16b7cfe485d7 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -2023,7 +2023,7 @@ int ext4_resize_fs(struct super_block *sb, ext4_fsblk_t n_blocks_count)
 
 	err = ext4_alloc_flex_bg_array(sb, n_group + 1);
 	if (err)
-		return err;
+		goto out;
 
 	err = ext4_mb_alloc_groupinfo(sb, n_group + 1);
 	if (err)
-- 
2.17.1

