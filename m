Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCA1C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 21:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C5EF20664
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 21:58:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C5EF20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbeJaGxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 02:53:53 -0400
Received: from relay.sw.ru ([185.231.240.75]:46002 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725743AbeJaGxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 02:53:53 -0400
Received: from [172.16.24.21]
        by relay.sw.ru with esmtp (Exim 4.90_1)
        (envelope-from <vvs@virtuozzo.com>)
        id 1gHc23-0003hD-HS; Wed, 31 Oct 2018 00:58:39 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH v2 09/11] ext4: iloc.bh cleanup in add_new_gdb()
To:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org
References: <cover.1540935522.git.vvs@virtuozzo.com>
Message-ID: <eb58c8ca-8456-7b5f-9c12-99f03e3057af@virtuozzo.com>
Date:   Wed, 31 Oct 2018 00:58:38 +0300
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

iloc.bh was taken in ext4_reserve_inode_write() and released
in ext4_mark_iloc_dirty(). It should not be released 2nd time
in rollback after failed ext4_handle_dirty_metadata(gdb_bh)

Fixes b40971426a83 ("ext4: add error checking to calls to ...") # 2.6.38

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 fs/ext4/resize.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index 85158e9de7c2..aedfd6a6fcd1 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -871,7 +871,7 @@ static int add_new_gdb(handle_t *handle, struct inode *inode,
 	err = ext4_handle_dirty_metadata(handle, NULL, gdb_bh);
 	if (unlikely(err)) {
 		ext4_std_error(sb, err);
-		goto exit_inode;
+		goto exit_kfree;
 	}
 	brelse(dind);
 
@@ -891,8 +891,9 @@ static int add_new_gdb(handle_t *handle, struct inode *inode,
 	return err;
 
 exit_inode:
-	kvfree(n_group_desc);
 	brelse(iloc.bh);
+exit_kfree:
+	kvfree(n_group_desc);
 exit_dind:
 	brelse(dind);
 exit_bh:
-- 
2.17.1

