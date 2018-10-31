Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3ACFECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 19:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C359620657
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 19:12:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C359620657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730072AbeKAEMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 00:12:09 -0400
Received: from relay.sw.ru ([185.231.240.75]:47198 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725731AbeKAEMI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 00:12:08 -0400
Received: from [172.16.24.21]
        by relay.sw.ru with esmtp (Exim 4.90_1)
        (envelope-from <vvs@virtuozzo.com>)
        id 1gHvv2-0006KT-SP; Wed, 31 Oct 2018 22:12:45 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH 4/7] ext4: lost brelse in ext4_xattr_get_block()
To:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org
References: <cover.1541011937.git.vvs@virtuozzo.com>
Message-ID: <42b953ae-72de-4196-09b3-dbac68af9c85@virtuozzo.com>
Date:   Wed, 31 Oct 2018 22:12:43 +0300
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

Fixes dec214d00e0d ("ext4: xattr inode deduplication") # 4.13

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 fs/ext4/xattr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index dc1aeab06dba..07c3a115f7ae 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -2272,8 +2272,10 @@ static struct buffer_head *ext4_xattr_get_block(struct inode *inode)
 	if (!bh)
 		return ERR_PTR(-EIO);
 	error = ext4_xattr_check_block(inode, bh);
-	if (error)
+	if (error) {
+		brelse(bh);
 		return ERR_PTR(error);
+	}
 	return bh;
 }
 
-- 
2.17.1

