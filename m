Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0E6ECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 02:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE899214D5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 02:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qzgr+FWf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE899214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbeIRHsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 03:48:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:48714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbeIRHsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 03:48:20 -0400
Received: from localhost (unknown [104.132.1.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A94DB20C0E;
        Tue, 18 Sep 2018 02:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537237087;
        bh=6epabHWYDPNZOzoDX/5xV5xOd6qX3qxaYFs4wurMhMg=;
        h=From:To:Cc:Subject:Date:From;
        b=qzgr+FWf/1OFDuhNoKNX9vXh7wonZ/N+CP2SK6e0Mbf5EVd+QnkXUuS45sSbtsXzp
         zDjBrkQwepB2UKTuWMnA8zodTCpAQDVhSl5Kuq3qd1ImyX0cj5w8NDAN/7xD+BLzcq
         KoLlxZwGvs736Jwv1aMQ9y5IkUuk2syKWBuf3f+U=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] f2fs: report ENOENT correct in f2fs_rename
Date:   Mon, 17 Sep 2018 19:18:04 -0700
Message-Id: <20180918021805.85032-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes wrong error report in f2fs_rename.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/namei.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 98d3ab7c3ce6..d653be777529 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -833,7 +833,7 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	struct f2fs_dir_entry *old_entry;
 	struct f2fs_dir_entry *new_entry;
 	bool is_old_inline = f2fs_has_inline_dentry(old_dir);
-	int err = -ENOENT;
+	int err;
 
 	if (unlikely(f2fs_cp_error(sbi)))
 		return -EIO;
@@ -854,6 +854,7 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	if (err)
 		goto out;
 
+	err = -ENOENT;
 	if (new_inode) {
 		err = dquot_initialize(new_inode);
 		if (err)
-- 
2.17.0.441.gb46fe60e1d-goog

