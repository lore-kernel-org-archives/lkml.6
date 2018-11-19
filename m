Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A374BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B0702146D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOYVTfB4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B0702146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407090AbeKTDae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:30:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:45620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406321AbeKTDad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:30:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 974CF214E0;
        Mon, 19 Nov 2018 17:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542647175;
        bh=pORKD3FL6N0zg+DCjZbRwcW+k6znkkB8Y7mGyzbmirg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kOYVTfB4v8l31xKylFPEyvK61kkO2BSMJujpt9lEVgwwxM6C64GO3rJzvZUMCS8Sm
         Ct8LZ4l3khccGRtTsWQbwoSXT+Xfnd/YHlEzZ1NghWzkfnTYpXd2erDsBjqs82JU+Q
         BlqzkSkLmCMY1padKwQqU3PUycT5gQK5TRfFYfAg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vasily Averin <vvs@virtuozzo.com>,
        Theodore Tso <tytso@mit.edu>, stable@kernel.org
Subject: [PATCH 3.18 80/90] ext4: fix possible leak of sbi->s_group_desc_leak in error path
Date:   Mon, 19 Nov 2018 17:30:02 +0100
Message-Id: <20181119162632.881531477@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162620.585061184@linuxfoundation.org>
References: <20181119162620.585061184@linuxfoundation.org>
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

commit 9e463084cdb22e0b56b2dfbc50461020409a5fd3 upstream.

Fixes: bfe0a5f47ada ("ext4: add more mount time checks of the superblock")
Reported-by: Vasily Averin <vvs@virtuozzo.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org # 4.18
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/super.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3976,6 +3976,14 @@ static int ext4_fill_super(struct super_
 	sbi->s_groups_count = blocks_count;
 	sbi->s_blockfile_groups = min_t(ext4_group_t, sbi->s_groups_count,
 			(EXT4_MAX_BLOCK_FILE_PHYS / EXT4_BLOCKS_PER_GROUP(sb)));
+	if (((u64)sbi->s_groups_count * sbi->s_inodes_per_group) !=
+	    le32_to_cpu(es->s_inodes_count)) {
+		ext4_msg(sb, KERN_ERR, "inodes count not valid: %u vs %llu",
+			 le32_to_cpu(es->s_inodes_count),
+			 ((u64)sbi->s_groups_count * sbi->s_inodes_per_group));
+		ret = -EINVAL;
+		goto failed_mount;
+	}
 	db_count = (sbi->s_groups_count + EXT4_DESC_PER_BLOCK(sb) - 1) /
 		   EXT4_DESC_PER_BLOCK(sb);
 	if (EXT4_HAS_INCOMPAT_FEATURE(sb, EXT4_FEATURE_INCOMPAT_META_BG)) {
@@ -3995,14 +4003,6 @@ static int ext4_fill_super(struct super_
 		ret = -ENOMEM;
 		goto failed_mount;
 	}
-	if (((u64)sbi->s_groups_count * sbi->s_inodes_per_group) !=
-	    le32_to_cpu(es->s_inodes_count)) {
-		ext4_msg(sb, KERN_ERR, "inodes count not valid: %u vs %llu",
-			 le32_to_cpu(es->s_inodes_count),
-			 ((u64)sbi->s_groups_count * sbi->s_inodes_per_group));
-		ret = -EINVAL;
-		goto failed_mount;
-	}
 
 	if (ext4_proc_root)
 		sbi->s_proc = proc_mkdir(sb->s_id, ext4_proc_root);


