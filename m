Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A389ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 19:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0824220657
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 19:13:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0824220657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730475AbeKAEMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 00:12:35 -0400
Received: from relay.sw.ru ([185.231.240.75]:47230 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725731AbeKAEMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 00:12:35 -0400
Received: from [172.16.24.21]
        by relay.sw.ru with esmtp (Exim 4.90_1)
        (envelope-from <vvs@virtuozzo.com>)
        id 1gHvvT-0006Ku-HQ; Wed, 31 Oct 2018 22:13:11 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH 7/7] ext4: lost brelse in ext4_expand_extra_isize_ea()
To:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org
References: <cover.1541011937.git.vvs@virtuozzo.com>
Message-ID: <c5dc2118-ac42-c899-f218-4a78aa39c37f@virtuozzo.com>
Date:   Wed, 31 Oct 2018 22:13:09 +0300
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

Fixes de05ca852679 ("ext4: move call to ext4_error() into ...") # 4.17

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 fs/ext4/xattr.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 5c9bc0d85cc0..0b9688683526 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -2698,7 +2698,6 @@ int ext4_expand_extra_isize_ea(struct inode *inode, int new_extra_isize,
 			       struct ext4_inode *raw_inode, handle_t *handle)
 {
 	struct ext4_xattr_ibody_header *header;
-	struct buffer_head *bh;
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	static unsigned int mnt_count;
 	size_t min_offs;
@@ -2739,13 +2738,17 @@ int ext4_expand_extra_isize_ea(struct inode *inode, int new_extra_isize,
 	 * EA block can hold new_extra_isize bytes.
 	 */
 	if (EXT4_I(inode)->i_file_acl) {
+		struct buffer_head *bh;
+
 		bh = sb_bread(inode->i_sb, EXT4_I(inode)->i_file_acl);
 		error = -EIO;
 		if (!bh)
 			goto cleanup;
 		error = ext4_xattr_check_block(inode, bh);
-		if (error)
+		if (error) {
+			brelse(bh);
 			goto cleanup;
+		}
 		base = BHDR(bh);
 		end = bh->b_data + bh->b_size;
 		min_offs = end - base;
-- 
2.17.1

