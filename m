Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7237C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77B4120675
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545999618;
	bh=i5rdA6ktjYoODdHrVjqcaCDUcPgrm8C5NvQE5Mri91c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E2MLGs3chTI+/0CK5ntV9jTJDs1Ougo6j/T1YcKxO20VOLnQTP8KWP7iU+5jhy/KB
	 LZNUnR0ZoHAM3QiWIyPYbpy8SkxFfhYq2eGIksihIGQ2paZPIptoxeBonrOYY+1IZT
	 c9TyNIqZaRe52Uzhood1ApBbzVBjbkLdyRdm7cdw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbeL1MUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 07:20:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:35766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732740AbeL1MQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 07:16:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E1BF2146F;
        Fri, 28 Dec 2018 12:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545999399;
        bh=i5rdA6ktjYoODdHrVjqcaCDUcPgrm8C5NvQE5Mri91c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FEe9IZ4eJQ2JskhnPDEfmNGxVwRowQ2nwjNNjhFlC5eKB436NTA6IuAhqHgueU6SA
         dihNS8bwB7ZOtj1UHmf4jBCxG50pRpBBtz7ZFm7n9l0aeckTyDJ5mmHV35uq0/K5De
         kkoI624kR6WRXUXn9zT3f4DYcFRH/bgMnVtCdLrc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Russell Senior <russell@personaltelco.net>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Richard Weinberger <richard@nod.at>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 33/36] ubifs: Handle re-linking of inodes correctly while recovery
Date:   Fri, 28 Dec 2018 12:52:49 +0100
Message-Id: <20181228113128.614177090@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181228113126.526729877@linuxfoundation.org>
References: <20181228113126.526729877@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

commit e58725d51fa8da9133f3f1c54170aa2e43056b91 upstream.

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
Cc: stable@vger.kernel.org # 4.9-4.18
Cc: Russell Senior <russell@personaltelco.net>
Cc: Rafał Miłecki <zajec5@gmail.com>
Reported-by: Russell Senior <russell@personaltelco.net>
Reported-by: Rafał Miłecki <zajec5@gmail.com>
Tested-by: Rafał Miłecki <rafal@milecki.pl>
Signed-off-by: Richard Weinberger <richard@nod.at>
[rmilecki: update ubifs_assert() calls to compile with 4.18 and older]
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
(cherry picked from commit e58725d51fa8da9133f3f1c54170aa2e43056b91)
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ubifs/replay.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/fs/ubifs/replay.c b/fs/ubifs/replay.c
index ae5c02f22f3e..d998fbf7de30 100644
--- a/fs/ubifs/replay.c
+++ b/fs/ubifs/replay.c
@@ -209,6 +209,38 @@ static int trun_remove_range(struct ubifs_info *c, struct replay_entry *r)
 	return ubifs_tnc_remove_range(c, &min_key, &max_key);
 }
 
+/**
+ * inode_still_linked - check whether inode in question will be re-linked.
+ * @c: UBIFS file-system description object
+ * @rino: replay entry to test
+ *
+ * O_TMPFILE files can be re-linked, this means link count goes from 0 to 1.
+ * This case needs special care, otherwise all references to the inode will
+ * be removed upon the first replay entry of an inode with link count 0
+ * is found.
+ */
+static bool inode_still_linked(struct ubifs_info *c, struct replay_entry *rino)
+{
+	struct replay_entry *r;
+
+	ubifs_assert(rino->deletion);
+	ubifs_assert(key_type(c, &rino->key) == UBIFS_INO_KEY);
+
+	/*
+	 * Find the most recent entry for the inode behind @rino and check
+	 * whether it is a deletion.
+	 */
+	list_for_each_entry_reverse(r, &c->replay_list, list) {
+		ubifs_assert(r->sqnum >= rino->sqnum);
+		if (key_inum(c, &r->key) == key_inum(c, &rino->key))
+			return r->deletion == 0;
+
+	}
+
+	ubifs_assert(0);
+	return false;
+}
+
 /**
  * apply_replay_entry - apply a replay entry to the TNC.
  * @c: UBIFS file-system description object
@@ -239,6 +271,11 @@ static int apply_replay_entry(struct ubifs_info *c, struct replay_entry *r)
 			{
 				ino_t inum = key_inum(c, &r->key);
 
+				if (inode_still_linked(c, r)) {
+					err = 0;
+					break;
+				}
+
 				err = ubifs_tnc_remove_ino(c, inum);
 				break;
 			}
-- 
2.19.1



