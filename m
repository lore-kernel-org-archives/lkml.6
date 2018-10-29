Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91756C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 396292064C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:26:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 396292064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=personaltelco.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729565AbeJ2SON convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 14:14:13 -0400
Received: from mail.klickitat.com ([54.70.207.208]:46684 "EHLO
        mail.klickitat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729466AbeJ2SON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 14:14:13 -0400
X-Greylist: delayed 485 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Oct 2018 14:14:12 EDT
Received: by mail.klickitat.com (Postfix, from userid 182)
        id AB690A613E3; Mon, 29 Oct 2018 02:07:14 -0700 (PDT)
Received: from husum.klickitat.com (husum.ptp [192.168.80.4])
        by mail.klickitat.com (Postfix) with ESMTP id 1D33DA613A7;
        Mon, 29 Oct 2018 02:07:12 -0700 (PDT)
From:   Russell Senior <russell@personaltelco.net>
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        zajec5@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH] ubifs: Handle re-linking of inodes correctly while recovery
References: <20181028214407.20965-1-richard@nod.at>
Date:   Mon, 29 Oct 2018 02:18:17 -0700
In-Reply-To: <20181028214407.20965-1-richard@nod.at> (Richard Weinberger's
        message of "Sun, 28 Oct 2018 22:44:07 +0100")
Message-ID: <87ftwpqffq.fsf@husum.klickitat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
Tested-by: Russell Senior <russell@personaltelco.net>
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



-- 
Russell Senior, President
russell@personaltelco.net
