Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08394C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 01:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8CC421104
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 01:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MwfWY1Em"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8CC421104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbeKYMjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 07:39:45 -0500
Received: from m12-16.163.com ([220.181.12.16]:36554 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbeKYMjp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 07:39:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=RX0NJVp6kJM8Ft+0zM
        t/FQ39NY+3juAFTpU724pd67g=; b=MwfWY1EmL5RXre0lTgnqHzPZf2QknSO/hw
        WggY8AvFWFnOdq3vorfW+AwimhY8iIO/1xOt9due6CjB2IkrDep0OYeJqxECQgjf
        DERBbECAJBBQ7qGyH3GeCVGxzsc0ZdFT5nkAibPTe+gfQ56iz5qpF+KlA551s6uJ
        UNZt3xnfc=
Received: from bp.localdomain (unknown [106.120.213.96])
        by smtp12 (Coremail) with SMTP id EMCowAA3A1Gc__lbW3bNBg--.31965S3;
        Sun, 25 Nov 2018 09:49:23 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Pan Bian <bianpan2016@163.com>
Subject: [PATCH] freevxfs: set bp to NULL after dropping its reference in loop
Date:   Sun, 25 Nov 2018 09:49:17 +0800
Message-Id: <1543110557-126460-1-git-send-email-bianpan2016@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: EMCowAA3A1Gc__lbW3bNBg--.31965S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrKr1UGr4ftw4kurWkKr4kWFg_yoWfGFXEka
        1xJrW8C3yFvr17ta18JFWYqr9IqayrZrn7A342q39Iyry3ta98t3sFvr9xGr1UWrW7WrZ0
        k3sFqr1FqryxGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8AcTPUUUUU==
X-Originating-IP: [106.120.213.96]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/xtbBUQMKclaD0TL+IAAAsC
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function vxfs_bmap_indir calls brelse(bh) in the loop and tries to
start the next iteration. However, if it happens to break the loop,
brelse(bp) will be called again. Resulting in a potential double free
bug. This patch assigns NULL to bh after dropping its reference in the
loop body.

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 fs/freevxfs/vxfs_bmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/freevxfs/vxfs_bmap.c b/fs/freevxfs/vxfs_bmap.c
index 1fd41cf..136e5d1 100644
--- a/fs/freevxfs/vxfs_bmap.c
+++ b/fs/freevxfs/vxfs_bmap.c
@@ -150,6 +150,7 @@ vxfs_bmap_indir(struct inode *ip, long indir, int size, long block)
 
 		if (block < off) {
 			brelse(bp);
+			bp = NULL;
 			continue;
 		}
 
@@ -186,6 +187,7 @@ vxfs_bmap_indir(struct inode *ip, long indir, int size, long block)
 			BUG();
 		}
 		brelse(bp);
+		bp = NULL;
 	}
 
 fail:
-- 
2.7.4


