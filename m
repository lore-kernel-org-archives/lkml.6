Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0FEC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 21:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 678C220664
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 21:58:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 678C220664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbeJaGxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 02:53:17 -0400
Received: from relay.sw.ru ([185.231.240.75]:45968 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725743AbeJaGxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 02:53:17 -0400
Received: from [172.16.24.21]
        by relay.sw.ru with esmtp (Exim 4.90_1)
        (envelope-from <vvs@virtuozzo.com>)
        id 1gHc1T-0003gf-FY; Wed, 31 Oct 2018 00:58:03 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH v2 04/11] ext4 resize: lost brelse() in update_backups()
To:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org
References: <cover.1540935522.git.vvs@virtuozzo.com>
Message-ID: <7120b1a5-fcda-8e31-fc8c-7944b4291b14@virtuozzo.com>
Date:   Wed, 31 Oct 2018 00:58:03 +0300
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

bh was not released after error in ext4_journal_get_write_access()

Fixes ac27a0ec112a ("ext4: initial copy of files from ext3") # 2.6.19

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 fs/ext4/resize.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index 7131f35b62d9..3df326ee6d50 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -1121,8 +1121,10 @@ static void update_backups(struct super_block *sb, sector_t blk_off, char *data,
 			   backup_block, backup_block -
 			   ext4_group_first_block_no(sb, group));
 		BUFFER_TRACE(bh, "get_write_access");
-		if ((err = ext4_journal_get_write_access(handle, bh)))
+		if ((err = ext4_journal_get_write_access(handle, bh))) {
+			brelse(bh);
 			break;
+		}
 		lock_buffer(bh);
 		memcpy(bh->b_data, data, size);
 		if (rest)
-- 
2.17.1

