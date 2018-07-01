Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695FBC6778D
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 21:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A3EF25978
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 21:21:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A3EF25978
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752623AbeGAVVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 17:21:11 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:54142 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752457AbeGAVVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 17:21:05 -0400
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id BB25F1802086B;
        Sun,  1 Jul 2018 23:21:03 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Kees Cook <keescook@chromium.org>,
        Silvio Cesare <silvio.cesare@gmail.com>, stable@vger.kernel.org
Subject: [PATCH 2/2] ubifs: Check data node size before truncate
Date:   Sun,  1 Jul 2018 23:20:51 +0200
Message-Id: <20180701212051.29486-2-richard@nod.at>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701212051.29486-1-richard@nod.at>
References: <20180701212051.29486-1-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check whether the size is within bounds before using it.
If the size is not correct, abort and dump the bad data node.

Cc: Kees Cook <keescook@chromium.org>
Cc: Silvio Cesare <silvio.cesare@gmail.com>
Cc: stable@vger.kernel.org
Fixes: 1e51764a3c2ac ("UBIFS: add new flash file system")
Reported-by: Silvio Cesare <silvio.cesare@gmail.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 fs/ubifs/journal.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
index da8afdfccaa6..eea12d25a58b 100644
--- a/fs/ubifs/journal.c
+++ b/fs/ubifs/journal.c
@@ -1387,7 +1387,16 @@ int ubifs_jnl_truncate(struct ubifs_info *c, const struct inode *inode,
 		else if (err)
 			goto out_free;
 		else {
-			if (le32_to_cpu(dn->size) <= dlen)
+			int dn_len = le32_to_cpu(dn->size);
+
+			if (dn_len <= 0 || dn_len > UBIFS_BLOCK_SIZE) {
+				ubifs_err(c, "bad data node (block %u, inode %lu)",
+					  blk, inode->i_ino);
+				ubifs_dump_node(c, dn);
+				goto out_free;
+			}
+
+			if (dn_len <= dlen)
 				dlen = 0; /* Nothing to do */
 			else {
 				err = truncate_data_node(c, inode, blk, dn, &dlen);
-- 
2.18.0

