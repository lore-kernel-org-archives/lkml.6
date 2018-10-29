Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78554C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 15:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47EEC20664
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 15:47:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47EEC20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbeJ3Agt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 20:36:49 -0400
Received: from relay.sw.ru ([185.231.240.75]:46092 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727647AbeJ3Ags (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 20:36:48 -0400
Received: from [172.16.24.21]
        by relay.sw.ru with esmtp (Exim 4.90_1)
        (envelope-from <vvs@virtuozzo.com>)
        id 1gH9Pk-0006be-05; Mon, 29 Oct 2018 18:25:12 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH 2/7] ext4 resize: missing brelse() after errors in
 set_flexbg_block_bitmap()
To:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org,
        Yongqiang Yang <xiaoqiangnk@gmail.com>,
        Yongqiang Yang <xiaoqiangnk@gmail.com>
Message-ID: <335a6774-8328-b6c6-ea41-919607c9c6d1@virtuozzo.com>
Date:   Mon, 29 Oct 2018 18:25:11 +0300
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

Fixes 33afdcc5402d ("ext4: add a function which sets up group blocks ...")
#? cc: stable@vger.kernel.org # 3.3+

Signed-off-by: Vasily Averin <vvs@openvz.org>
---
 fs/ext4/resize.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index c3fa30878ca8..0a4dc6217e78 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -459,16 +459,18 @@ static int set_flexbg_block_bitmap(struct super_block *sb, handle_t *handle,
 
 		BUFFER_TRACE(bh, "get_write_access");
 		err = ext4_journal_get_write_access(handle, bh);
-		if (err)
+		if (err) {
+			brelse(bh);
 			return err;
+		}
 		ext4_debug("mark block bitmap %#04llx (+%llu/%u)\n",
 			   first_cluster, first_cluster - start, count2);
 		ext4_set_bits(bh->b_data, first_cluster - start, count2);
 
 		err = ext4_handle_dirty_metadata(handle, NULL, bh);
+		brelse(bh);
 		if (unlikely(err))
 			return err;
-		brelse(bh);
 	}
 
 	return 0;
-- 
2.17.1

