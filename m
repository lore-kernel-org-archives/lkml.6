Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BE0C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 19:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED58520657
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 19:13:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED58520657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730407AbeKAEM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 00:12:28 -0400
Received: from relay.sw.ru ([185.231.240.75]:47220 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725731AbeKAEM1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 00:12:27 -0400
Received: from [172.16.24.21]
        by relay.sw.ru with esmtp (Exim 4.90_1)
        (envelope-from <vvs@virtuozzo.com>)
        id 1gHvvJ-0006Km-2V; Wed, 31 Oct 2018 22:13:01 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH 6/7] ext4: lost brelse in ext4_xattr_move_to_block()
To:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Kalpak Shah <kalpak@clusterfs.com>
References: <cover.1541011937.git.vvs@virtuozzo.com>
Message-ID: <76da5ae3-274d-efa4-58bb-6cd280763a37@virtuozzo.com>
Date:   Wed, 31 Oct 2018 22:13:00 +0300
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

Fixes 3f2571c1f91f ("ext4: factor out xattr moving")
cc: Jan Kara <jack@suse.cz>
however issue was present in original ext4_expand_extra_isize_ea()
Fixes 6dd4ee7cab7e ("ext4: Expand extra_inodes space per ...") # 2.6.23
cc: Kalpak Shah <kalpak@clusterfs.com>

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 fs/ext4/xattr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 07b9a335c8eb..5c9bc0d85cc0 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -2617,6 +2617,8 @@ static int ext4_xattr_move_to_block(handle_t *handle, struct inode *inode,
 	kfree(buffer);
 	if (is)
 		brelse(is->iloc.bh);
+	if (bs)
+		brelse(bs->bh);
 	kfree(is);
 	kfree(bs);
 
-- 
2.17.1

