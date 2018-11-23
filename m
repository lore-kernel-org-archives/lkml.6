Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520D8C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 125DE20685
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Rs2mgK8h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 125DE20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408762AbeKWTtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 14:49:17 -0500
Received: from m12-14.163.com ([220.181.12.14]:60837 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732135AbeKWTtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 14:49:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=DCwuoK5VcJCo4dkCoM
        h3n7cLwH609uBf3xTxpnmAMOs=; b=Rs2mgK8hQf3+MXwjmJ4HElyRqbrbW31mp8
        TovCDrQEJHtKbYTWvQKkHjYB2PPCjflmICN3zsGE4TWiC2Sd8MsTqAByi1ncAgPO
        tS7L2NlQnkJJ1o26NWewJjmgs5S+PdH6usVyDoi0a8EaBHV8yY+fa710h354Egep
        XX4fa5Rlg=
Received: from bp.localdomain (unknown [106.120.213.96])
        by smtp10 (Coremail) with SMTP id DsCowABH_OGwwvdbbrrlBQ--.19497S3;
        Fri, 23 Nov 2018 17:04:51 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     Joe Perches <joe@perches.com>,
        =?UTF-8?q?Ernesto=20A=2E=20Fern=C3=A1ndez?= 
        <ernesto.mnd.fernandez@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pan Bian <bianpan2016@163.com>
Subject: [PATCH] hfs: do not free node before using
Date:   Fri, 23 Nov 2018 17:04:49 +0800
Message-Id: <1542963889-128825-1-git-send-email-bianpan2016@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: DsCowABH_OGwwvdbbrrlBQ--.19497S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrtr1DCw1xCFy5WF43CFWfXwb_yoWfCrg_XF
        4xW3Z7t3yrGFZ7JFZ3ArZYqrW2gF4rGws3Ww4xtFWak3yYvan8Jrs7Zr9YyryxuF4agr15
        J3yktry8Gay7JjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0dWrJUUUUU==
X-Originating-IP: [106.120.213.96]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/1tbiDhMIclXlpkg5VQAAsV
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function hfs_bmap_free frees node via hfs_bnode_put(node). However,
it then reads node->this when dumping error message on an error path,
which may result in a use-after-free bug. This patch frees node only
when it is never used.

Fixes: d614267329f("hfs/hfsplus: convert printks to pr_<level>")

Signed-off-by: Pan Bian <bianpan2016@163.com>
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


