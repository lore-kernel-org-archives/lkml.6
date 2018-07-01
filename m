Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E49C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 21:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CED91255DD
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 21:21:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CED91255DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752584AbeGAVVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 17:21:09 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:54132 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752407AbeGAVVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 17:21:05 -0400
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id 269D81818141E;
        Sun,  1 Jul 2018 23:21:03 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Kees Cook <keescook@chromium.org>,
        Silvio Cesare <silvio.cesare@gmail.com>, stable@vger.kernel.org
Subject: [PATCH 1/2] Revert "UBIFS: Fix potential integer overflow in allocation"
Date:   Sun,  1 Jul 2018 23:20:50 +0200
Message-Id: <20180701212051.29486-1-richard@nod.at>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 353748a359f1821ee934afc579cf04572406b420.
It bypassed the linux-mtd review process and fixes the issue not as it
should.

Cc: Kees Cook <keescook@chromium.org>
Cc: Silvio Cesare <silvio.cesare@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 fs/ubifs/journal.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
index 07b4956e0425..da8afdfccaa6 100644
--- a/fs/ubifs/journal.c
+++ b/fs/ubifs/journal.c
@@ -1282,11 +1282,10 @@ static int truncate_data_node(const struct ubifs_info *c, const struct inode *in
 			      int *new_len)
 {
 	void *buf;
-	int err, compr_type;
-	u32 dlen, out_len, old_dlen;
+	int err, dlen, compr_type, out_len, old_dlen;
 
 	out_len = le32_to_cpu(dn->size);
-	buf = kmalloc_array(out_len, WORST_COMPR_FACTOR, GFP_NOFS);
+	buf = kmalloc(out_len * WORST_COMPR_FACTOR, GFP_NOFS);
 	if (!buf)
 		return -ENOMEM;
 
-- 
2.18.0

