Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAEA2C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 21:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B87C920664
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 21:58:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B87C920664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbeJaGyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 02:54:08 -0400
Received: from relay.sw.ru ([185.231.240.75]:46020 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725743AbeJaGyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 02:54:07 -0400
Received: from [172.16.24.21]
        by relay.sw.ru with esmtp (Exim 4.90_1)
        (envelope-from <vvs@virtuozzo.com>)
        id 1gHc2H-0003hQ-Vl; Wed, 31 Oct 2018 00:58:54 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH v2 11/11] ext4: access to uninitialized bh fields in
 ext4_xattr_set_handle()
To:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org
References: <cover.1540935522.git.vvs@virtuozzo.com>
Message-ID: <b8523c3a-0eb2-3aeb-fdf9-2e9d6d320d5c@virtuozzo.com>
Date:   Wed, 31 Oct 2018 00:58:53 +0300
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

On-stack initialization does not guarantee zeroying of unintialized
fields. So is.iloc.bh and bs.bh can be contain garbage of old stack
conent.

Errors in the beginning of ext4_xattr_set_handle() function
lead to jump to "cleanup:" label where brelse(is.iloc.bh)
and brelse(bs.bh) can access uninitialized bh fields of
on-stack located "is" and "bs" structures.

Issue was inherited from ext3 and was present in first ext4 commit.

Fixes ac27a0ec112a ("ext4: initial copy of files from ext3") # 2.6.19

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 fs/ext4/xattr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index dc1aeab06dba..aae12425597e 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -2303,9 +2303,11 @@ ext4_xattr_set_handle(handle_t *handle, struct inode *inode, int name_index,
 	};
 	struct ext4_xattr_ibody_find is = {
 		.s = { .not_found = -ENODATA, },
+		.iloc = { .bh = NULL, },
 	};
 	struct ext4_xattr_block_find bs = {
 		.s = { .not_found = -ENODATA, },
+		.bh = NULL,
 	};
 	int no_expand;
 	int error;
-- 
2.17.1

