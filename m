Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224BFC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 15:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E17812084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 15:47:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E17812084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbeJ3Agk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 20:36:40 -0400
Received: from relay.sw.ru ([185.231.240.75]:46086 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727456AbeJ3Agk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 20:36:40 -0400
X-Greylist: delayed 1349 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Oct 2018 20:36:38 EDT
Received: from [172.16.24.21]
        by relay.sw.ru with esmtp (Exim 4.90_1)
        (envelope-from <vvs@virtuozzo.com>)
        id 1gH9Pp-0006bq-6m; Mon, 29 Oct 2018 18:25:17 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH 3/7] ext4 resize: missing brelse() in case success in
 add_new_gdb()
To:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org
Message-ID: <d8c84f46-7ffe-7fd3-0e70-775c3c59320e@virtuozzo.com>
Date:   Mon, 29 Oct 2018 18:25:16 +0300
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

Fixes ac27a0ec112a ("ext4: initial copy of files from ext3")
#? cc: stable <stable@vger.kernel.org>     # 2.6.19 or evel earlier in ext3

Signed-off-by: Vasily Averin <vvs@openvz.org>
---
 fs/ext4/resize.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index 0a4dc6217e78..ff17480e8613 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -874,6 +874,7 @@ static int add_new_gdb(handle_t *handle, struct inode *inode,
 		goto exit_inode;
 	}
 	brelse(dind);
+	brelse(iloc.bh);
 
 	o_group_desc = EXT4_SB(sb)->s_group_desc;
 	memcpy(n_group_desc, o_group_desc,
-- 
2.17.1

