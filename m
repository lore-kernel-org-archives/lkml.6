Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B842C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0C9A21470
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWBfpC4J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0C9A21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730412AbeJKXJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:09:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:39634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729758AbeJKXJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:09:01 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0030821476;
        Thu, 11 Oct 2018 15:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272477;
        bh=KhQxX/2pYkrfvCy3PXLE8g95czjXz1YbhdmWHlWDwds=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jWBfpC4JdSh10XWVWtGydpAgQBBXOigBtnUcQKNlHM2uUMzJRiI71ybiuvZMgURcx
         VaUHQhl9CN3+Gi/1ZbL3/ec0jmBKTQTbroDGEACU+hlxVPewPU8wuxuyLWvCRwvUyp
         KwdO3zl61tG0ACAsXXzRLg3yfI3Mj6w6NA1QtKhM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Whitney <enwlinux@gmail.com>,
        Theodore Tso <tytso@mit.edu>,
        Ben Hutchings <ben@decadent.org.uk>,
        Greg Hackmann <ghackmann@google.com>
Subject: [PATCH 3.18 109/120] ext4: fix check to prevent initializing reserved inodes
Date:   Thu, 11 Oct 2018 17:34:50 +0200
Message-Id: <20181011152554.309780225@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152549.500488630@linuxfoundation.org>
References: <20181011152549.500488630@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/ialloc.c |    5 ++++-
 fs/ext4/super.c  |    8 +-------
 2 files changed, 5 insertions(+), 8 deletions(-)

--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -1253,7 +1253,10 @@ int ext4_init_inode_table(struct super_b
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
@@ -3140,14 +3140,8 @@ static ext4_group_t ext4_has_uninit_itab
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


