Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF36C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 353A62145D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YShjECQW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 353A62145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733078AbeKTDEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:04:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:37980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732128AbeKTDEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:04:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13259206BA;
        Mon, 19 Nov 2018 16:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645640;
        bh=8lhJj9g/igikTj5pWXPs+rt1odZ1uwvBfgrM2UvT8us=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YShjECQWzw8JeyEAjwKQvg4gd+PVvB9O5CMuY8f3Gs+hD7qpvz8zO+oU0kFrUc0Ro
         DsKv3ScUrvY3icWBIP2dHE4MlcbsArmcp8dBEDR8B5D7v6/voDaA4mOHcCMnPpKMet
         BzQw7+QiC4errhYny1xF8xKpUPQ9dcjdbpxYm6EU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 032/171] udf: Prevent write-unsupported filesystem to be remounted read-write
Date:   Mon, 19 Nov 2018 17:27:08 +0100
Message-Id: <20181119162625.038921820@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162618.909354448@linuxfoundation.org>
References: <20181119162618.909354448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1317,6 +1314,7 @@ static int udf_load_partdesc(struct supe
 			ret = -EACCES;
 			goto out_bh;
 		}
+		UDF_SET_FLAG(sb, UDF_FLAG_RW_INCOMPAT);
 		ret = udf_load_vat(sb, i, type1_idx);
 		if (ret < 0)
 			goto out_bh;
@@ -2215,10 +2213,12 @@ static int udf_fill_super(struct super_b
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
@@ -2236,10 +2236,12 @@ static int udf_fill_super(struct super_b
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


