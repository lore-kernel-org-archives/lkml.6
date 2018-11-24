Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55283C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 02:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12EA020868
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 02:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XrQcL3eT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12EA020868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729437AbeKXM6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 07:58:00 -0500
Received: from m12-18.163.com ([220.181.12.18]:40781 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729268AbeKXM57 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 07:57:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=ZbW9rYi3Cz6z27YeA9
        E1w9eoVVKUuxmORxUFqr6PC5A=; b=XrQcL3eTSM7uttLp7hSKMgSxWYvPE+kazm
        G6dRMiVdKL5KT/nNk6LecY3YPb99f11bSfNvHRfEwD/k2xhEbiVVG3S3ornKq8TS
        JPS/GytUdMCOdNKyWMPlMK0M9O1RSxf+RtGXuygvlYwrjlob4Wqor/bLYMQGx2Fm
        iubnIjbsw=
Received: from bp.localdomain (unknown [106.120.213.96])
        by smtp14 (Coremail) with SMTP id EsCowACn0zU4s_hb184VBg--.38107S3;
        Sat, 24 Nov 2018 10:11:16 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        ernesto.mnd.fernandez@gmail.com, Joe Perches <joe@perches.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pan Bian <bianpan2016@163.com>
Subject: [PATCH V2] hfs: do not free node before using
Date:   Sat, 24 Nov 2018 10:10:58 +0800
Message-Id: <1543025458-31592-1-git-send-email-bianpan2016@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: EsCowACn0zU4s_hb184VBg--.38107S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrtr1DCw1xCFy5WF43uFykXwb_yoWfZFb_JF
        4xW3Wxt34rGFZ7Jrs3CrZYqw42gF4rGwnagw4xtFWak3yYyan5Jr1kZr9YyryfuFWYgrn8
        J3yktryUGay7GjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnjFAJUUUUU==
X-Originating-IP: [106.120.213.96]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/xtbBZwQJcletsGsCLAAAsX
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function hfs_bmap_free frees node via hfs_bnode_put(node). However,
it then reads node->this when dumping error message on an error path,
which may result in a use-after-free bug. This patch frees node only
when it is never used.

Fixes: a1185ffa2fc("HFS rewrite")

Signed-off-by: Pan Bian <bianpan2016@163.com>

---
V2: correct the commit information in Fixes

---
 fs/hfs/btree.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
index 98b96ff..19017d2 100644
--- a/fs/hfs/btree.c
+++ b/fs/hfs/btree.c
@@ -338,13 +338,14 @@ void hfs_bmap_free(struct hfs_bnode *node)
 
 		nidx -= len * 8;
 		i = node->next;
-		hfs_bnode_put(node);
 		if (!i) {
 			/* panic */;
 			pr_crit("unable to free bnode %u. bmap not found!\n",
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


