Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E450ECDE46
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 540B1204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QA0ueJto"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 540B1204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730501AbeKDXHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 18:07:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:45682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730437AbeKDXHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 18:07:39 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02B982085A;
        Sun,  4 Nov 2018 13:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541339555;
        bh=0+5Dm57xvtJEuBh1J+1JT5/oJdYTGSPNmjrR1Q6HiIA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QA0ueJtotMOK59/TxA3ibRmd+/B906DoIyJfbSgoN0YFvMXgzLS2EWdvXdLDizomJ
         bpeLAD21u/V8kq8ow0xC+8O2G2+RyiIRlXxWcTfi16mZRfehcXdueHZ9+Be3dN4rUw
         7T4lxCttHq+ND6fa+H46OLDPGwVlSI57K151N4S4=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 52/57] udf: Prevent write-unsupported filesystem to be remounted read-write
Date:   Sun,  4 Nov 2018 08:51:39 -0500
Message-Id: <20181104135144.88324-52-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181104135144.88324-1-sashal@kernel.org>
References: <20181104135144.88324-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 fs/udf/super.c  | 30 ++++++++++++++++--------------
 fs/udf/udf_sb.h |  2 ++
 2 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/fs/udf/super.c b/fs/udf/super.c
index 6f515651a2c2..b997e3116e37 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -613,14 +613,11 @@ static int udf_remount_fs(struct super_block *sb, int *flags, char *options)
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
@@ -1257,6 +1254,7 @@ static int udf_load_partdesc(struct super_block *sb, sector_t block)
 			ret = -EACCES;
 			goto out_bh;
 		}
+		UDF_SET_FLAG(sb, UDF_FLAG_RW_INCOMPAT);
 		ret = udf_load_vat(sb, i, type1_idx);
 		if (ret < 0)
 			goto out_bh;
@@ -2155,10 +2153,12 @@ static int udf_fill_super(struct super_block *sb, void *options, int silent)
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
@@ -2176,10 +2176,12 @@ static int udf_fill_super(struct super_block *sb, void *options, int silent)
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
diff --git a/fs/udf/udf_sb.h b/fs/udf/udf_sb.h
index 9424d7cab790..d12e507e9eb2 100644
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
-- 
2.17.1

