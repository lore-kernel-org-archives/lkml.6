Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD3CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 346092089F
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXqvI0gU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 346092089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730539AbeKTCzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:55:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:53826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730526AbeKTCzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:55:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 020832089F;
        Mon, 19 Nov 2018 16:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645106;
        bh=ScfGi2GKjPnEymGpvcEzLKXu56UmwDK7mrJhzzgsEzI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GXqvI0gU7I0pvbLSgCPB8QofDimjgDYjOFdnshRX/MK7UUQMwkhTzvPx/CC6NHPRr
         xTjxys2FitC1IMXZoMCYSP5gMZrjTC8isOPEhpTF6SScOfYjnGKwuaVeu1YlUaDF2F
         ZxBpqAM8mDW+200g4Zv0GTeA9N5U4CKctkNURWOw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 039/205] udf: Prevent write-unsupported filesystem to be remounted read-write
Date:   Mon, 19 Nov 2018 17:25:46 +0100
Message-Id: <20181119162624.373332996@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Kara <jack@suse.cz>

[ Upstream commit a9ad01bc759df79b0012f43ee52164391e31cd96 ]

There are certain filesystem features which we support for reading but
not for writing. We properly refuse to mount such filesystems read-write
however for some features (such as read-only partitions), we don't check
for these features when remounting the filesystem from read-only to
read-write. Thus such filesystems could be remounted read-write leading
to strange behavior (most likely crashes).

Fix the problem by marking in superblock whether the filesystem has some
features that are supported in read-only mode and check this flag during
remount.

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/udf/super.c  |   30 ++++++++++++++++--------------
 fs/udf/udf_sb.h |    2 ++
 2 files changed, 18 insertions(+), 14 deletions(-)

--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -613,14 +613,11 @@ static int udf_remount_fs(struct super_b
 	struct udf_options uopt;
 	struct udf_sb_info *sbi = UDF_SB(sb);
 	int error = 0;
-	struct logicalVolIntegrityDescImpUse *lvidiu = udf_sb_lvidiu(sb);
+
+	if (!(*flags & SB_RDONLY) && UDF_QUERY_FLAG(sb, UDF_FLAG_RW_INCOMPAT))
+		return -EACCES;
 
 	sync_filesystem(sb);
-	if (lvidiu) {
-		int write_rev = le16_to_cpu(lvidiu->minUDFWriteRev);
-		if (write_rev > UDF_MAX_WRITE_VERSION && !(*flags & SB_RDONLY))
-			return -EACCES;
-	}
 
 	uopt.flags = sbi->s_flags;
 	uopt.uid   = sbi->s_uid;
@@ -1257,6 +1254,7 @@ static int udf_load_partdesc(struct supe
 			ret = -EACCES;
 			goto out_bh;
 		}
+		UDF_SET_FLAG(sb, UDF_FLAG_RW_INCOMPAT);
 		ret = udf_load_vat(sb, i, type1_idx);
 		if (ret < 0)
 			goto out_bh;
@@ -2155,10 +2153,12 @@ static int udf_fill_super(struct super_b
 				UDF_MAX_READ_VERSION);
 			ret = -EINVAL;
 			goto error_out;
-		} else if (minUDFWriteRev > UDF_MAX_WRITE_VERSION &&
-			   !sb_rdonly(sb)) {
-			ret = -EACCES;
-			goto error_out;
+		} else if (minUDFWriteRev > UDF_MAX_WRITE_VERSION) {
+			if (!sb_rdonly(sb)) {
+				ret = -EACCES;
+				goto error_out;
+			}
+			UDF_SET_FLAG(sb, UDF_FLAG_RW_INCOMPAT);
 		}
 
 		sbi->s_udfrev = minUDFWriteRev;
@@ -2176,10 +2176,12 @@ static int udf_fill_super(struct super_b
 	}
 
 	if (sbi->s_partmaps[sbi->s_partition].s_partition_flags &
-			UDF_PART_FLAG_READ_ONLY &&
-	    !sb_rdonly(sb)) {
-		ret = -EACCES;
-		goto error_out;
+			UDF_PART_FLAG_READ_ONLY) {
+		if (!sb_rdonly(sb)) {
+			ret = -EACCES;
+			goto error_out;
+		}
+		UDF_SET_FLAG(sb, UDF_FLAG_RW_INCOMPAT);
 	}
 
 	if (udf_find_fileset(sb, &fileset, &rootdir)) {
--- a/fs/udf/udf_sb.h
+++ b/fs/udf/udf_sb.h
@@ -30,6 +30,8 @@
 #define UDF_FLAG_LASTBLOCK_SET	16
 #define UDF_FLAG_BLOCKSIZE_SET	17
 #define UDF_FLAG_INCONSISTENT	18
+#define UDF_FLAG_RW_INCOMPAT	19	/* Set when we find RW incompatible
+					 * feature */
 
 #define UDF_PART_FLAG_UNALLOC_BITMAP	0x0001
 #define UDF_PART_FLAG_UNALLOC_TABLE	0x0002


