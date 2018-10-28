Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695E7C2BC61
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 21:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 185022082D
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 21:44:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 185022082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbeJ2GaL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 02:30:11 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:43440 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728009AbeJ2GaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 02:30:11 -0400
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id 2364318011ADE;
        Sun, 28 Oct 2018 22:44:15 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, russell@personaltelco.net,
        zajec5@gmail.com, Richard Weinberger <richard@nod.at>,
        stable@vger.kernel.org
Subject: [PATCH] ubifs: Handle re-linking of inodes correctly while recovery
Date:   Sun, 28 Oct 2018 22:44:07 +0100
Message-Id: <20181028214407.20965-1-richard@nod.at>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UBIFS's recovery code strictly assumes that a deleted inode will never
come back, therefore it removes all data which belongs to that inode
as soon it faces an inode with link count 0 in the replay list.
Before O_TMPFILE this assumption was perfectly fine. With O_TMPFILE
it can lead to data loss upon a power-cut.

Consider a journal with entries like:
0: inode X (nlink = 0) /* O_TMPFILE was created */
1: data for inode X /* Someone writes to the temp file */
2: inode X (nlink = 0) /* inode was changed, xattr, chmod, … */
3: inode X (nlink = 1) /* inode was re-linked via linkat() */

Upon replay of entry #2 UBIFS will drop all data that belongs to inode X,
this will lead to an empty file after mounting.

As solution for this problem, scan the replay list for a re-link entry
before dropping data.

Fixes: 474b93704f32 ("ubifs: Implement O_TMPFILE")
Cc: stable@vger.kernel.org
Reported-by: Russell Senior <russell@personaltelco.net>
Reported-by: Rafał Miłecki <zajec5@gmail.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
---
Russel, Rafał,

please give this patch another testing.
I'll also run it on different test systems before merging.

Thanks,
//richard
---
 fs/ubifs/replay.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/fs/ubifs/replay.c b/fs/ubifs/replay.c
index 4844538eb926..65a780685b82 100644
--- a/fs/ubifs/replay.c
+++ b/fs/ubifs/replay.c
@@ -209,6 +209,34 @@ static int trun_remove_range(struct ubifs_info *c, struct replay_entry *r)
 	return ubifs_tnc_remove_range(c, &min_key, &max_key);
 }
 
+/**
+ * inode_relinked - check whether inode in question will be re-linked.
+ * @c: UBIFS file-system description object
+ * @rino: replay entry to test
+ *
+ * O_TMPFILE files can be re-linked, this means link count goes from 0 to 1.
+ * This case needs special care, otherwise all references to the inode will
+ * be removed upon the first replay entry of an inode with link count 0
+ * is found.
+ */
+static bool inode_relinked(struct ubifs_info *c, struct replay_entry *rino)
+{
+	struct replay_entry *r = rino;
+
+	ubifs_assert(c, rino->deletion);
+	ubifs_assert(c, key_type(c, &rino->key) == UBIFS_INO_KEY);
+
+	list_for_each_entry_from(r, &c->replay_list, list) {
+		if (key_inum(c, &r->key) == key_inum(c, &rino->key) &&
+		    r->deletion == 0) {
+			ubifs_assert(c, r->sqnum > rino->sqnum);
+			return true;
+		}
+	}
+
+	return false;
+}
+
 /**
  * apply_replay_entry - apply a replay entry to the TNC.
  * @c: UBIFS file-system description object
@@ -236,6 +264,11 @@ static int apply_replay_entry(struct ubifs_info *c, struct replay_entry *r)
 			{
 				ino_t inum = key_inum(c, &r->key);
 
+				if (inode_relinked(c, r)) {
+					err = 0;
+					break;
+				}
+
 				err = ubifs_tnc_remove_ino(c, inum);
 				break;
 			}
-- 
2.19.1

