Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4CDC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 09:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05A9220865
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 09:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fmBaIyev"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05A9220865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbeKXUpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 15:45:31 -0500
Received: from m12-13.163.com ([220.181.12.13]:60059 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbeKXUpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 15:45:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=7J89eZ5fW8/oS2WhaN
        DIG5+D61MYEvp2nIuYqqeYPZo=; b=fmBaIyevuH37KFRuqYQlE+vZXg0cDhTzch
        E6T+fbPBnm8z5k02XPNduecKKA8HX7k6+IHZiDbBSDGnDB1YGGkQCMzr3lzC1BK1
        X7t/umUNcP+CTI3IEl6U91MTU8tWsnUGv8S2wKHMnpDmCEIDn/uCWEW4Zqh+0/B8
        MAcUAO/UU=
Received: from bp.localdomain (unknown [106.120.213.96])
        by smtp9 (Coremail) with SMTP id DcCowAA3zhaAIPlb6G5XBg--.53608S3;
        Sat, 24 Nov 2018 17:57:25 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        ernesto.mnd.fernandez@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pan Bian <bianpan2016@163.com>
Subject: [PATCH 1/1] hfsplus: do not free node before using
Date:   Sat, 24 Nov 2018 17:57:21 +0800
Message-Id: <1543053441-66942-1-git-send-email-bianpan2016@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: DcCowAA3zhaAIPlb6G5XBg--.53608S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrtr1DCw1xCFy5WF43tF48Xrb_yoWfGFc_Xa
        1I9as7t3yrJFZ7JrZxArZ8t3sFgF4rG3s7Ww4xtF1Yk3yjyan8Jr1kZrnYkryfurWYqr15
        JrWktry5Ga4UXjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0sYFJUUUUU==
X-Originating-IP: [106.120.213.96]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/1tbiQAIJclSIYSB5fQAAsg
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function hfs_bmap_free frees node via hfs_bnode_put(node).
However, it then reads node->this when dumping error message on an error
path, which may result in a use-after-free bug. This patch frees node
only when it is never used.

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 fs/hfsplus/btree.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
index 236efe5..66774f4 100644
--- a/fs/hfsplus/btree.c
+++ b/fs/hfsplus/btree.c
@@ -466,14 +466,15 @@ void hfs_bmap_free(struct hfs_bnode *node)
 
 		nidx -= len * 8;
 		i = node->next;
-		hfs_bnode_put(node);
 		if (!i) {
 			/* panic */;
 			pr_crit("unable to free bnode %u. "
 					"bmap not found!\n",
 				node->this);
+			hfs_bnode_put(node);
 			return;
 		}
+		hfs_bnode_put(node);
 		node = hfs_bnode_find(tree, i);
 		if (IS_ERR(node))
 			return;
-- 
2.7.4


