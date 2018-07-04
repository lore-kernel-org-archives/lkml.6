Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4C2C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80EB421719
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:42:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80EB421719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753617AbeGDJmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 05:42:35 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:45062 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753048AbeGDJke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 05:40:34 -0400
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id 7AB6218186370;
        Wed,  4 Jul 2018 11:40:32 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        stable@vger.kernel.org
Subject: [PATCH] ubifs: log: Don't leak kernel memory to the MTD
Date:   Wed,  4 Jul 2018 11:40:25 +0200
Message-Id: <20180704094025.26789-1-richard@nod.at>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ubifs_log_start_commit() allocates a buffer with kmalloc(),
this buffer is used to build UBIFS CS and REF nodes, all structure
attributes get set, except for the padding field in the ubifs_ref_node.
That way we leak 28 bytes of kernel memory to the MTD.
Fix it by using kzalloc().

Cc: stable@vger.kernel.org
Fixes: 1e51764a3c2a ("UBIFS: add new flash file system")
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 fs/ubifs/log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ubifs/log.c b/fs/ubifs/log.c
index 7cffa120a750..60d49c6dd470 100644
--- a/fs/ubifs/log.c
+++ b/fs/ubifs/log.c
@@ -369,7 +369,7 @@ int ubifs_log_start_commit(struct ubifs_info *c, int *ltail_lnum)
 
 	max_len = UBIFS_CS_NODE_SZ + c->jhead_cnt * UBIFS_REF_NODE_SZ;
 	max_len = ALIGN(max_len, c->min_io_size);
-	buf = cs = kmalloc(max_len, GFP_NOFS);
+	buf = cs = kzalloc(max_len, GFP_NOFS);
 	if (!buf)
 		return -ENOMEM;
 
-- 
2.18.0

