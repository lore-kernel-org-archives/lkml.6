Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB66C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D658218FE
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545999466;
	bh=YoxWaALmjNemq3GUiF8AkVhRkvYYypLDGkjzsCLyGNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=azGGo3zZA1dxyzRq6an/e2R018RAxvfF5z44Nd4aFpqX+NTJDPu7xprVTK46XegEt
	 Liy8SJGOzQlYLPP+sMqCXCd5DKl53nI5+5r7F/mJewWs5ltf6E5e1f5ua0RPeVRlBu
	 l6039ug5ckirDL/SFvQF0s/l7yNN7cR8d1RhNOd8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733018AbeL1MRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 07:17:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:36752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732992AbeL1MRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 07:17:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E49162184B;
        Fri, 28 Dec 2018 12:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545999459;
        bh=YoxWaALmjNemq3GUiF8AkVhRkvYYypLDGkjzsCLyGNQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BvOSVpA09P68ynh9viJLsDbQ/0HP/gIVPEnPrpKBntDBjG6nRlueM/ABah9+hVcnP
         IlSg8T0kQ+aRebBpe91fZwkkBbezHA1lSVYG8rxFYHrkvVSuiqrA1PLsM4FXpVgE/v
         gXUU2Wuc7SQg+R0K1RaB3Mow2HIGbA/MAilz/ED8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Russell Senior <russell@personaltelco.net>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Richard Weinberger <richard@nod.at>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 19/22] ubifs: Handle re-linking of inodes correctly while recovery
Date:   Fri, 28 Dec 2018 12:52:56 +0100
Message-Id: <20181228113127.486628766@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181228113126.144310132@linuxfoundation.org>
References: <20181228113126.144310132@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
index fb0f44cd1e28..de7799a0a9d1 100644
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



