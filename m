Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58AC4C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27F0520661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:16:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27F0520661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbeLIWHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:07:46 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37236 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727295AbeLIWHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:07:42 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW738-0002ij-8s; Sun, 09 Dec 2018 21:55:42 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72f-0003TO-Hn; Sun, 09 Dec 2018 21:55:13 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Theodore Ts'o" <tytso@mit.edu>,
        "Maxim Malkov" <malkov@ispras.ru>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.737294888@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 188/328] ext4: prevent online resize with backup
 superblock
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit 011fa99404bea3f5d897c4983f6bd51170e3b18f upstream.

Prevent BUG or corrupted file systems after the following:

mkfs.ext4 /dev/vdc 100M
mount -t ext4 -o sb=40961 /dev/vdc /vdc
resize2fs /dev/vdc

We previously prevented online resizing using the old resize ioctl.
Move the code to ext4_resize_begin(), so the check applies for all of
the resize ioctl's.

Reported-by: Maxim Malkov <malkov@ispras.ru>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/ext4/resize.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -24,6 +24,18 @@ int ext4_resize_begin(struct super_block
 		return -EPERM;
 
 	/*
+	 * If we are not using the primary superblock/GDT copy don't resize,
+         * because the user tools have no way of handling this.  Probably a
+         * bad time to do it anyways.
+         */
+	if (EXT4_SB(sb)->s_sbh->b_blocknr !=
+	    le32_to_cpu(EXT4_SB(sb)->s_es->s_first_data_block)) {
+		ext4_warning(sb, "won't resize using backup superblock at %llu",
+			(unsigned long long)EXT4_SB(sb)->s_sbh->b_blocknr);
+		return -EPERM;
+	}
+
+	/*
 	 * We are not allowed to do online-resizing on a filesystem mounted
 	 * with error, because it can destroy the filesystem easily.
 	 */
@@ -758,18 +770,6 @@ static int add_new_gdb(handle_t *handle,
 		       "EXT4-fs: ext4_add_new_gdb: adding group block %lu\n",
 		       gdb_num);
 
-	/*
-	 * If we are not using the primary superblock/GDT copy don't resize,
-         * because the user tools have no way of handling this.  Probably a
-         * bad time to do it anyways.
-         */
-	if (EXT4_SB(sb)->s_sbh->b_blocknr !=
-	    le32_to_cpu(EXT4_SB(sb)->s_es->s_first_data_block)) {
-		ext4_warning(sb, "won't resize using backup superblock at %llu",
-			(unsigned long long)EXT4_SB(sb)->s_sbh->b_blocknr);
-		return -EPERM;
-	}
-
 	gdb_bh = sb_bread(sb, gdblock);
 	if (!gdb_bh)
 		return -EIO;

