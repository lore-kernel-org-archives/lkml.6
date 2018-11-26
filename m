Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89CEC43610
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 03:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DE5D20865
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 03:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="T0SqVDwu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DE5D20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbeKZOO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 09:14:26 -0500
Received: from m12-17.163.com ([220.181.12.17]:35171 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbeKZOOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 09:14:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=7A4ihKGl+zCslg/+6W
        5OvV8mY9+t1E/X9U+NulVAZjY=; b=T0SqVDwur0Y7nR0XQaSQVs1LMTtWLqpolT
        yCnIgiHJvIYVNfN3/CFwAg2lode+P4G2jRNe0a0SD/zAiL8RTfuBW20b5oDBtu4x
        s0e+buhRxgau9qdPGy2ee0OoEReHTsuABTLIr+RaEZqMlRQA8AzmVJppf0/PE9cG
        ltDQWkovY=
Received: from bp.localdomain (unknown [106.120.213.96])
        by smtp13 (Coremail) with SMTP id EcCowABXI2WiZvtbfg2eBg--.13072S3;
        Mon, 26 Nov 2018 11:21:08 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     "Theodore Ts\'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pan Bian <bianpan2016@163.com>
Subject: [PATCH] ext4: fix possible use after free in ext4_quota_enable
Date:   Mon, 26 Nov 2018 11:21:06 +0800
Message-Id: <1543202466-68277-1-git-send-email-bianpan2016@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: EcCowABXI2WiZvtbfg2eBg--.13072S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xr4rKryfWryrAw4rAr4kCrg_yoWfZFg_Xa
        1xKF4Iv3sxXrn3KayvkFW3tr1v9F48uF45GF9Yqw4fu34Y9Fs8JFyDArnrAwn3W3y3t3s8
        Arn2yF15XFW8ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0vzuJUUUUU==
X-Originating-IP: [106.120.213.96]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/xtbBZAgLclQHCq5JKQAAsC
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function frees qf_inode via iput but then pass qf_inode to
lockdep_set_quota_inode on the failure path. This may result in a
use-after-free bug. The patch frees df_inode only when it is never used.

Signed-off-by: Pan Bian <bianpan2016@163.com>
Fixes: daf647d2dd5("ext4: add lockdep annotations for i_data_sem")
---
 fs/ext4/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 53ff6c2..35689eb 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5690,9 +5690,9 @@ static int ext4_quota_enable(struct super_block *sb, int type, int format_id,
 	qf_inode->i_flags |= S_NOQUOTA;
 	lockdep_set_quota_inode(qf_inode, I_DATA_SEM_QUOTA);
 	err = dquot_enable(qf_inode, type, format_id, flags);
-	iput(qf_inode);
 	if (err)
 		lockdep_set_quota_inode(qf_inode, I_DATA_SEM_NORMAL);
+	iput(qf_inode);
 
 	return err;
 }
-- 
2.7.4


