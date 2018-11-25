Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B145FC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 00:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F67D20874
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 00:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="M5Rr+4os"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F67D20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbeKYLsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 06:48:00 -0500
Received: from m12-16.163.com ([220.181.12.16]:54106 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726323AbeKYLsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 06:48:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=m5M4DMmmfC8+Hxib1I
        vpkBcysAcYi1Haj5CF53szmUY=; b=M5Rr+4osRIjWtlEQUR6z3UnVr+uw33S4oH
        GKRmKWFTMTeRjkYbEABpLI0EQUxfSekRGbzGT0ogLkdOjNum2wmL1TFA7fXo/Grz
        XTAp78fowzZiDzJX8HaZ9q0c28TahwBvn976mTKSJhQRnDbs8+QgFo9hco+wbqlX
        Y0mD1hHPE=
Received: from bp.localdomain (unknown [106.120.213.96])
        by smtp12 (Coremail) with SMTP id EMCowADHV1ef8_lbtG7IBg--.31384S3;
        Sun, 25 Nov 2018 08:58:10 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     Jan Kara <jack@suse.com>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pan Bian <bianpan2016@163.com>
Subject: [PATCH] ext2: fix potential use after free
Date:   Sun, 25 Nov 2018 08:58:02 +0800
Message-Id: <1543107482-97334-1-git-send-email-bianpan2016@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: EMCowADHV1ef8_lbtG7IBg--.31384S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrtFWkZFyDtrW8Cw1UuryxuFg_yoW3Xwb_Ka
        4UJw4Ikrs5GrZYq3WxAFWYy3Z5Kas5Ar1rur4rGr13ZayUtFZ7ZFyDXrWfZr15Xw47Gan8
        WF4kXry3ArWIgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0ubyJUUUUU==
X-Originating-IP: [106.120.213.96]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/1tbiVBoKclUMGJWYxQAAs-
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function ext2_xattr_set calls brelse(bh) to drop the reference count
of bh. After that, bh may be freed. However, following brelse(bh),
it reads bh->b_data via macro HDR(bh). This may result in a
use-after-free bug. This patch moves brelse(bh) after reading field.

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 fs/ext2/xattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
index 62d9a659a..dd8f10d 100644
--- a/fs/ext2/xattr.c
+++ b/fs/ext2/xattr.c
@@ -612,9 +612,9 @@ bad_block:		ext2_error(sb, "ext2_xattr_set",
 	}
 
 cleanup:
-	brelse(bh);
 	if (!(bh && header == HDR(bh)))
 		kfree(header);
+	brelse(bh);
 	up_write(&EXT2_I(inode)->xattr_sem);
 
 	return error;
-- 
2.7.4


