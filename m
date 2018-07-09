Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89B1C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 06:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1FE5208AF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 06:08:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1FE5208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lge.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754613AbeGIGIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 02:08:21 -0400
Received: from lgeamrelo12.lge.com ([156.147.23.52]:34771 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750846AbeGIGIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 02:08:20 -0400
Received: from unknown (HELO lgeamrelo01.lge.com) (156.147.1.125)
        by 156.147.23.52 with ESMTP; 9 Jul 2018 15:08:16 +0900
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: junil0814.lee@lge.com
Received: from unknown (HELO localhost.localdomain) (10.168.178.207)
        by 156.147.1.125 with ESMTP; 9 Jul 2018 15:08:16 +0900
X-Original-SENDERIP: 10.168.178.207
X-Original-MAILFROM: junil0814.lee@lge.com
From:   Junil Lee <junil0814.lee@lge.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        junil0814.lee@lge.com
Subject: [PATCH] ext4: remove abnormal set for I_DATA_SEM subclass
Date:   Mon,  9 Jul 2018 15:08:14 +0900
Message-Id: <1531116494-156102-1-git-send-email-junil0814.lee@lge.com>
X-Mailer: git-send-email 2.6.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The -EBUSY return value of dquot_enable() function means that just
want to update flags. If some users make a duplicate request to update
flags, lockdep could catch the false positive casued by needing to
allocate a quota block from inside ext4_map_blocks(), while holding
i_data_sem for a data inode. This results in this comlaint:

       CPU0                    CPU1
       ----                    ----
  lock(&s->s_dquot.dqio_mutex);
                               lock(&ei->i_data_sem);
                               lock(&s->s_dquot.dqio_mutex);
  lock(&ei->i_data_sem);

Signed-off-by: Junil Lee <junil0814.lee@lge.com>
---
 fs/ext4/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 13d2706..f16c92d 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5637,7 +5637,7 @@ static int ext4_quota_enable(struct super_block *sb, int type, int format_id,
 	lockdep_set_quota_inode(qf_inode, I_DATA_SEM_QUOTA);
 	err = dquot_enable(qf_inode, type, format_id, flags);
 	iput(qf_inode);
-	if (err)
+	if (err != -EBUSY)
 		lockdep_set_quota_inode(qf_inode, I_DATA_SEM_NORMAL);
 
 	return err;
-- 
2.6.2

