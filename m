Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2C6C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBCB621901
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548357939;
	bh=zJpahbNB8P9ywSTP9A2wxOfsWvMJ2dowjwM4bu9WftY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qSkds4w1bgIqh5PtCPrU3UsHRG4I06duBEDQUPk96FphLD9t9G7xzDxIq3kC0xOmV
	 awKLwAvrvi1tnqh/sdACM+IqgED51Qw3Ehv+ypeVRvdCYcBPnUhgUNe9mG0q8xTvsH
	 pbG/Nc+9+XMCsAzH5OWNhKHkWssx+ctwCN+VB3FE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730452AbfAXTZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:25:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:51264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730405AbfAXTZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:25:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA470217D7;
        Thu, 24 Jan 2019 19:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548357934;
        bh=zJpahbNB8P9ywSTP9A2wxOfsWvMJ2dowjwM4bu9WftY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DV/xN7WK6N+Z3ETlTad5G5jP6jg7XwbUc/ks6kPqpRY6gTJBwkA9+JijN9CcKqaxV
         IZVEOcff64dtn/WOq9rxoPsWA38FRU8a6wNfWx3POpGuG785yrI9/X/WWVMMkP1p4r
         eLy8pYvjkbex4/fkAbNV4EJ7n97WNSjIVhrtQbgg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 005/104] f2fs: move sanity checking of cp into get_valid_checkpoint
Date:   Thu, 24 Jan 2019 20:18:54 +0100
Message-Id: <20190124190155.481180967@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190154.968308875@linuxfoundation.org>
References: <20190124190154.968308875@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shawn Lin <shawn.lin@rock-chips.com>

commit 984ec63c5a82a07ad4490ecc69bebacd23f6fa64 upstream.

>From the function name of get_valid_checkpoint, it seems to return
the valid cp or NULL for caller to check. If no valid one is found,
f2fs_fill_super will print the err log. But if get_valid_checkpoint
get one valid(the return value indicate that it's valid, however actually
it is invalid after sanity checking), then print another similar err
log. That seems strange. Let's keep sanity checking inside the procedure
of geting valid cp. Another improvement we gained from this move is
that even the large volume is supported, we check the cp in advanced
to skip the following procedure if failing the sanity checking.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/checkpoint.c |    4 ++++
 fs/f2fs/f2fs.h       |    1 +
 fs/f2fs/super.c      |   10 +---------
 3 files changed, 6 insertions(+), 9 deletions(-)

--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -696,6 +696,10 @@ int get_valid_checkpoint(struct f2fs_sb_
 	cp_block = (struct f2fs_checkpoint *)page_address(cur_page);
 	memcpy(sbi->ckpt, cp_block, blk_size);
 
+	/* Sanity checking of checkpoint */
+	if (sanity_check_ckpt(sbi))
+		goto fail_no_cp;
+
 	if (cp_blks <= 1)
 		goto done;
 
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1718,6 +1718,7 @@ int f2fs_commit_super(struct f2fs_sb_inf
 int f2fs_sync_fs(struct super_block *, int);
 extern __printf(3, 4)
 void f2fs_msg(struct super_block *, const char *, const char *, ...);
+int sanity_check_ckpt(struct f2fs_sb_info *sbi);
 
 /*
  * hash.c
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1073,7 +1073,7 @@ static int sanity_check_raw_super(struct
 	return 0;
 }
 
-static int sanity_check_ckpt(struct f2fs_sb_info *sbi)
+int sanity_check_ckpt(struct f2fs_sb_info *sbi)
 {
 	unsigned int total, fsmeta;
 	struct f2fs_super_block *raw_super = F2FS_RAW_SUPER(sbi);
@@ -1358,13 +1358,6 @@ try_onemore:
 		goto free_meta_inode;
 	}
 
-	/* sanity checking of checkpoint */
-	err = -EINVAL;
-	if (sanity_check_ckpt(sbi)) {
-		f2fs_msg(sb, KERN_ERR, "Invalid F2FS checkpoint");
-		goto free_cp;
-	}
-
 	sbi->total_valid_node_count =
 				le32_to_cpu(sbi->ckpt->valid_node_count);
 	sbi->total_valid_inode_count =
@@ -1517,7 +1510,6 @@ free_nm:
 	destroy_node_manager(sbi);
 free_sm:
 	destroy_segment_manager(sbi);
-free_cp:
 	kfree(sbi->ckpt);
 free_meta_inode:
 	make_bad_inode(sbi->meta_inode);


