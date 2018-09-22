Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865FFC433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49E1321523
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:20:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49E1321523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392123AbeIVGKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 02:10:51 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:44300 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392075AbeIVGKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 02:10:50 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Ve0-0008BM-7P; Sat, 22 Sep 2018 01:19:32 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vdn-0000rh-Tv; Sat, 22 Sep 2018 01:19:19 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Theodore Ts'o" <tytso@mit.edu>,
        "Eric Whitney" <enwlinux@gmail.com>
Date:   Sat, 22 Sep 2018 01:15:42 +0100
Message-ID: <lsq.1537575342.717898263@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 25/63] ext4: fix check to prevent initializing
 reserved inodes
In-Reply-To: <lsq.1537575341.194909669@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.58-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit 5012284700775a4e6e3fbe7eac4c543c4874b559 upstream.

Commit 8844618d8aa7: "ext4: only look at the bg_flags field if it is
valid" will complain if block group zero does not have the
EXT4_BG_INODE_ZEROED flag set.  Unfortunately, this is not correct,
since a freshly created file system has this flag cleared.  It gets
almost immediately after the file system is mounted read-write --- but
the following somewhat unlikely sequence will end up triggering a
false positive report of a corrupted file system:

   mkfs.ext4 /dev/vdc
   mount -o ro /dev/vdc /vdc
   mount -o remount,rw /dev/vdc

Instead, when initializing the inode table for block group zero, test
to make sure that itable_unused count is not too large, since that is
the case that will result in some or all of the reserved inodes
getting cleared.

This fixes the failures reported by Eric Whiteney when running
generic/230 and generic/231 in the the nojournal test case.

Fixes: 8844618d8aa7 ("ext4: only look at the bg_flags field if it is valid")
Reported-by: Eric Whitney <enwlinux@gmail.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/ext4/ialloc.c | 5 ++++-
 fs/ext4/super.c  | 8 +-------
 2 files changed, 5 insertions(+), 8 deletions(-)

--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -1289,7 +1289,10 @@ int ext4_init_inode_table(struct super_b
 			    ext4_itable_unused_count(sb, gdp)),
 			    sbi->s_inodes_per_block);
 
-	if ((used_blks < 0) || (used_blks > sbi->s_itb_per_group)) {
+	if ((used_blks < 0) || (used_blks > sbi->s_itb_per_group) ||
+	    ((group == 0) && ((EXT4_INODES_PER_GROUP(sb) -
+			       ext4_itable_unused_count(sb, gdp)) <
+			      EXT4_FIRST_INO(sb)))) {
 		ext4_error(sb, "Something is wrong with group %u: "
 			   "used itable blocks: %d; "
 			   "itable unused count: %u",
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3088,14 +3088,8 @@ static ext4_group_t ext4_has_uninit_itab
 		if (!gdp)
 			continue;
 
-		if (gdp->bg_flags & cpu_to_le16(EXT4_BG_INODE_ZEROED))
-			continue;
-		if (group != 0)
+		if (!(gdp->bg_flags & cpu_to_le16(EXT4_BG_INODE_ZEROED)))
 			break;
-		ext4_error(sb, "Inode table for bg 0 marked as "
-			   "needing zeroing");
-		if (sb->s_flags & MS_RDONLY)
-			return ngroups;
 	}
 
 	return group;

