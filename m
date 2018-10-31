Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23EBDECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 19:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E18FA20657
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 19:12:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E18FA20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbeKAELw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 00:11:52 -0400
Received: from relay.sw.ru ([185.231.240.75]:47186 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725731AbeKAELw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 00:11:52 -0400
Received: from [172.16.24.21]
        by relay.sw.ru with esmtp (Exim 4.90_1)
        (envelope-from <vvs@virtuozzo.com>)
        id 1gHvum-0006KG-12; Wed, 31 Oct 2018 22:12:28 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH 2/7] ext4: possible sbi->s_group_desc leak in ext4_fill_super
To:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org
References: <cover.1541011937.git.vvs@virtuozzo.com>
Message-ID: <4b554ca1-f46e-742e-4aaa-04b379baf5f9@virtuozzo.com>
Date:   Wed, 31 Oct 2018 22:12:27 +0300
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

Fixes bfe0a5f47ada ("ext4: add more mount time checks of the superblock") # 4.18

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 fs/ext4/super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index a221f1cdf704..ed4d36506ec2 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4100,7 +4100,8 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 			 le32_to_cpu(es->s_inodes_count),
 			 ((u64)sbi->s_groups_count * sbi->s_inodes_per_group));
 		ret = -EINVAL;
-		goto failed_mount;
+		db_count = 0;
+		goto failed_mount2;
 	}
 
 	bgl_lock_init(sbi->s_blockgroup_lock);
-- 
2.17.1

